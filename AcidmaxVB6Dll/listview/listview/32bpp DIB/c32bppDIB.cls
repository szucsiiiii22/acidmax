VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "c32bppDIB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

' Credits/Acknowledgements - Thanx goes to:
'   Paul Caton for his class on calling non VB-Friendly DLLs that use _cdecl calling convention
'   Alfred Koppold for his PNG, VB-only, decompression routines
'   www.zlib.net for their free zLIB.dll, the standard DLL for compressing/decompressing PNGs
'   coders like you that provide constructive criticism to make this class better & more all-inclusive

' = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
'                                       QUICK OVERVIEW
' = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
' About 32bpp pre-multiplied RGB (pARGB) bitmaps, if you are not aware.
'   - These are used specifically for the AlphaBlend API & are GDI+ compatible
'   Advantages:
'       - Images can be per-pixel alpha blended
'       - Opacity can be simultaneously adjusted during rendering
'       - AlphaBlend does both BitBlt & StretchBlt for pARGB images.
'       - Speed: AlphaBlend & GDI+ are pretty quick APIs vs manual blending
'   Disadvantages:
'       - The original RGB values are permanently destroyed during pre-multiplying
'           -- there is no way to convert pARGB back to non-premultiplied RGB values
'           -- the formula would be: reconstructedRed=(preMultipliedRed * 255) \ Alpha.
'               but because of integer division when pre-multiplying the result is only close
'               and if this should be premultiplied again & converted again, the results can get worse
'       - Displaying a pre-multiplied bitmap without AlphaBlend will not result in
'           the image being displayed as expected.
'       - Not ideal for saving due to its size: SizeOf= W x H x 4
'           -- better to save source image instead or compress the DIB bytes using favorite compression utility
'           -- with GDI+, image can be converted to PNG for storage
'       - AlphaBlend (msimg32.dll) is not included with Win95, NT4 and lower
' Note that GDI+ is standard on WinXP+, and can be used on Win98,ME,2K, & on NT4 if SP6 is installed

' About Win95, Win98, NT3.5, NT4 & WinME support
' ----------------------------------------------
' The routines will not honor AlphaBlend if it exists on those systems. Win98's version,
' for example, has several bugs that can crash the application when AlphaBlending to DIBs.
' NT4, NT3.5 & Win95 do not come with AlphaBlend and I do not have WinME to test with.
' Therefore, to support these systems, the Render routine will alphablend manually
' regardless if the AlhpaBlend API (msimg32.dll) exists on the system or not.

' Table of methods used for rendering dependent upon class settings and O/S
' Win2K or Better?  GDI+ Available?  HighQualityInterpolation?  Method of Rendering
'       Yes              Yes                No / Yes            AlphaBlend / GDI+
'       No               Yes                No / Yes            GDI+ / GDI+
'       Yes              No                 No / Yes            AlphaBlend / Manually
'       No               No                 No / Yes            Manually / Manually
' Note that AlphaBlend does not support mirroring nor rotation nor high quality interpolation,
' so if these are applied when rendering, then class will use GDI+ if available,
' otherwise, manually rendered. By default, the class will initialize with
' HighQualityInterpolation=True if GDI+ is available.


' Class Purpose:
' This class holds the 32bpp image. It also marshals any new image thru
' the battery of parsers to determine best method for converting the image
' to a 32bpp alpha-compatible image. It handles rendering, rotating, scaling,
' mirroring of DIBs using manual processes, AlphaBlend, and/or GDI+.
' What about DirectX?  Hmmmm...

' The parser order is very important for fastest/best results...
' cPNGparser :: will convert PNG, all bit depths; aborts quickly if not PNG
' cGIFparser :: will convert non-transparent/transparent GIFs; aborts quickly
' cICOpraser :: will convert XP-Alpha, paletted, true color, & Vista PNG icons
'               -- can also convert most non-animated cursors
' cBMPparser :: will convert bitmaps, wmf/emf & jpgs

' The parsers are efficient. Most image formats have a magic number that give
'   a hint to what type of image the file/stream is. However, checks need to
'   be employed because non-image files could feasibly have those same magic
'   numbers. If the image is determined not to be one the parser is designed
'   to handle, the parser rejects it and the next parser takes over.  The
'   icon parser is slightly different because PNG files can be included into
'   a Vista ico file. When this occurs, the icon parser will pass off the
'   PNG format to the PNG parser automatically.
' And last but not least, the parsers have no advanced knowledge of the image
' format; as far as they are concerned, anything passed is just a byte array

' = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
'                                       CHANGE HISTORY
' = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
' Accompanying FAQ.rtf is updated with every change
' 20 Feb 07:
'   - PNGparser conversion routines overhauled for speed, minor error found & fixed
'       -- PNGparser.InitializePalette did not correctly identify transparency index for Grayscale with simple transparency
'   - PNGwriter.FormatCaption & FormatText recognized non-spec text but did not prevent it from being written to PNG
'   - Modified PNGwriter to use zLIB compress2 function when available
'   - Error on my part, last post had debugging code using zLibVB.dll vs zLib.dll
'       -- no serious harm but versions prior to this update probably will not be able to use zlib.net's zLib.DLL
' 18 Feb 07:
'   - Bugs recognized & fixed
'       -- cPNGwriter.OptimizeTrueColor could error when converting to 24bpp images
'       -- cPNGwriter.OptimizeTrueColor was not writing the single transparency color for 24bpp converted images
'       -- cPNGwriter.Write_tRNS was not always writing the tranpsarency color either
'       -- PngPropertySet was not honoring the user-selected filterMethod property
' 16 Feb 07:
'   - More PNG support....(First non-GDI+ PNG writer in VB open source? Maybe.)
'       -- Added cPNGwriter class. Can create PNGs using zLIB.dll versions. See class for more
'       -- Added cCDECL class. Allows calling zLIB.dll when zLIB is not VB-friendly
'           -- added modParsers.iparseValidateZLIB to determine if zLIB is available & if VB-friendly
'           -- required adding some custom zLIB calls to end of cPngWriter & cPngParser classes
'       -- added PngPropertySet to allow PNG creation options not possible w/GDI+. Must have zLIB available
'       -- added PngPropertyGet to retrieve settings. Over a dozen options
'       -- added isZlibEnabled property to inform you if zLIB can be used or not
'       -- Modified SaveToStream_PNG & SaveToFile_PNG to use zLIB if GDI+ is not available,
'               but zLIB is or vice versa. zLIB is prefered when pngPropertySet is called
'       -- Zlib is 100% free and is available directly from source: www.zlib.net
' 11 Feb 07:
'   - Logic error. When a DIB is first initialized, the Alpha property is False.
'       This should have been Alpha=True. Note that if you are creating blank DIBs and rendering other
'       DIBs to the blank one, you should change the blank DIB's alpha and image format properties as
'       appropriate, dependent upon what you are rendering to that DIB. The Alpha property is used in
'       other routines and must be accurate, but the ImageType property is not used
'   - Added imgError to the ImageType property enumeration. This can assist when self-rendering
'       DIBs. If ImageType=imgError then Handle=0& and no DIB has been loaded into the class.
' 10 Feb 07:
'   - Added LoadPicture_FromOrignalFormat routine which will recreate the DIB from the bytes
'       cached during a call to LoadPicture_File or LoadPicture_Stream
'   - Added TrimImage routine which will remove excess transparency from an image
'       If a 256x256 image has 20x20 transparency border around it, the image will be reduced to 216x216
'   - When calling Resize, class would not save original image bytes if they existed; now it does
'   - Minor tweaks in rotation routines. Routines no longer overwrite class' Interpolation setting
'   - Logic error fixed: GDI+ when rendering mirrored & rotated used incorred DC X,Y coordinates
' 4 Feb 07:
'   - Added SaveToFile_PNG & SaveToStream_PNG as main class options, but only supported if isGDIplusEnabled = True
'   - Complete revamp of mirroring routines.
'       -- Added MirrorDIB routine that mirrors an image as needed & mirrored bytes are later rotated, scaled, rendered
'       -- Previous version attempted to calculate mirroring offsets when scaling, rotating, rendering -- failed
'       -- Following routines modified: pvResize, CopyImageTo, Resize, RotateAtTopLeft
'   - Logic error fixed: pvResize would clip wrong end of image when image is rendered past vertical bounds of DC.
'   - Modified startup to always set HighQualityInterpolation if GDI+ is available.
' 1 Feb 07: By request...
'   - Added mirroring support to following routines. Passing a negative destination width and/or height causes mirroring
'       - pvResize, Win9xBlend, CopyImageTo, Resize, RotateAtCenterPoint, RotateAtTopLeft & cGDIPlus.RenderGDIplus
'       - The msimg32.dll AlphaBlend API cannot perform mirroring. Therefore...
'       - Whenever mirroring is in effect and GDI+ can't be used, mirroring will be done manually
'       - GDI+, if available, will only perfrorm the mirroring if also rotating or if HighQualityInterpolation=True
'   - Found another minor bug. Broke GDI+ ability to Global blend while rotating. Fixed.
' 31 Jan 07:
'   - Fixed logic error when rotating negative angles via GDI+ (cGDIPlus.RenderGDIplus routine)
'   - Fixed logic error when manually resizing using BiLinear method (pvResize routine)
'       - routines were combining current pixel with one above, not below as required
'   - Fixed rotation routines (non-GDI+); now rotation while non-proportional scaling compatible
'   - Renamed cPNGParser.SaveTo routine to cGDIPlus.SaveToPNG. See Change 4Jan07 below for more
' 30 Jan 07:
'   - Added rotation options. See RotateAtCenterPoint & RotateAtTopLeft
'       - The two routines are identical except for how the destination X,Y coords are determined
'   - Added isGDIplusEnabled property to inform you whether or not GDI+ can be used on the system
'   - Added HighQualityInterpolation property to produce better renderings
'       - When set to True & GDI+ is available, any rendering is done by GDI+
'       - When set to True and GDI+ is not available, manual interpolation is done when scaling/rotating
'       - Property can be set to False manually to prevent GDI+ usage
'   - Added MakeGrayScale routine. Irreversible pixel modifications
'       - 3 different grayscale formulas are provided
'   - Relocated all GDI+ function calls and related code into a new class: cGDIPlus
'   - Relocated cPNGparser.ValidateDLL to modParsers as iparseValidateDLL
' 25 Jan 07:
'   - Modified Win9xBlend routine. Did not exactly replicate AlphaBlend when stretching; fixed I believe
'       -- Added extra checks in Win9xBlend & pvResize when alphablending on Win9x systems.
'       -- Prevents user from supplying invalid values that could cause routines to read past allocated memory
'       -- Properly handles negative destination DC offsets
'   - Changed iswin95Alpha property to isAlphaBlendFriendly to indicate whether or not AlphaBlend will be used
' 24 Jan 07:
'   - Now compatible with all O/S. Added Win95/NT4 support to the following routines:
'       CopyImageTo, Resize, Render
'       -- Added Win9xBlend & heavily modified then added Carles P.V.'s pvResize routine
'   - Bug found. cPNGparser.vbDecompress, under NT4, was causing crashes when trying to
'       resize a passed byte array. Fixed. Array is sized before it is passed to that routine
'   - Bug found. The iparseCreateShapedRegion routine was creating shaped regions bottom up
'       and this crashed on NT4. Fixed so regions are created top down always
'   - Bug found. In Win98 & possibly other O/S. When VB creates a 24bpp stdPicture as used
'       in cBMPparser, the stdPicture.Render method can write into the alpha channel of the
'       destination 32bpp DIB; 24bpp has no alpha channel. Routine tweaked to handle that.
' 17 Jan 07:
'   - Added CreateCheckerBoard method. This method will create a checkerboard pattern
'       as the DIB image. It will also set the ImageType property to imgCheckerBoard
'       so you know whether or not the image is class checkerboard or not.
'       This can be useful when the DIB should be displayed, but has no image to display.
'       The flag can be used to determine saving the image. If imgCheckerboard then noSave
'   - Added Resize method to permanently resize the image within the DIB
'   - Added optional resizing parameters to CopyImageTo routine
'   - Tweaked cBMPparser & cGIFparser to always modify alpha bytes regardless of transparency
'       -- Previously, when image had no transparency, the alpha bytes were not touched, rather
'          the class tracked this information via its Alpha property. But if you wanted to pass
'          the DIB to some other routine in your project and process/render it, the unmodified
'          alpha bytes could prove to fool those processes/routines
'   - Tweaked Render method to fully expose all of AlphaBlend's parameters
'   - LoadPicture_StdPicture could not process WMFs, fixed
'   - LoadDIBinDC fixed - could fail if multiple calls made passing a True parameter
'   - Error in LoadPictureEx prevented saving image bytes when PNG file was loaded, fixed
' 5 Jan 07:
'   - Added SaveFormat parameter to LoadPicture_File & LoadPicture_Stream
'       -- option has class cache the original bytes of the image if loaded
'       -- the 32bpp DIB will always be larger than the source bytes and for
'           usercontrols, saving the original bytes takes less space than
'           saving the DIB bytes.
'   - Added GetOrginalFormat to retrieve bytes when SaveFormat was passed as True
'   - Added SetOriginalFormat used when copying one DIB class to another
' 4 Jan 07:
'   - Added LoadPicture_ByHandle, LoadPicture_StdPicture, ScaleImage & CopyImageTo
'   - Added cGDIPlus.SaveToPNG (testing). Requires GDI+ or zLIB but will save 32bpp to PNG file or stream
'       -- not accessible, right now, from c32bppDIB. Must create cGDIPlus class to use it.
'   - Modified cICOparser's GetBestMatch algorithm
'   - Added imgPNGicon as an image type to distinguish PNG in Vista Icon vs standard .PNG file
'   - Bug found: removing overlays in cGIFparser.ConvertGIFto32bpp; forgot ByVal VarPtrArray(...)
'       which could cause crash when compiled. Fixed & double checked everywhere else too
' 1 Jan 07:
'   - Added SaveToFile & SaveToStream methods
'   - cBMPparser could possibly try to query unauthorized memory; fixed
'   - Methodology changed a bit when parsers return results. If image is definitely one
'       that the parser is responsible for & the image is invalid, the parser will return
'       True to prevent other parsers from handling the image. The c32bppDIB.Handle is used
'       to determine true success or failure.
'       -- cGIFparser when recognizing improperly formatted GIF would allow image to continue to
'           other parsers which then may cause those parsers to lock up.
' 26 Dec 06: First version
' = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


' No APIs are declared public. This is to prevent possibly, differently
' declared APIs, or different versions of the same API, from conflciting
' with any APIs you declared in your project. Same rule for UDTs.
' Note: I did take liberties, changing parameter types, in several APIs throughout

' Used to determine operating system
Private Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As Any) As Long
Private Const VER_PLATFORM_WIN32_WINDOWS As Long = &H1
Private Type OSVERSIONINFOEX
   dwOSVersionInfoSize As Long
   dwMajorVersion As Long
   dwMinorVersion As Long
   dwBuildNumber As Long
   dwPlatformId As Long
   szCSDVersion As String * 128 ' up to here is OSVERSIONINFO vs EX
   wServicePackMajor As Integer ' 8 bytes larger than OSVERSIONINFO
   wServicePackMinor As Integer
   wSuiteMask As Integer
   wProductType As Byte
   wReserved As Byte
End Type

' APIs used to manage the 32bpp DIB
Private Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
Private Declare Function CreateCompatibleDC Lib "gdi32.dll" (ByVal hDC As Long) As Long
Private Declare Function GetDC Lib "user32.dll" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseDC Lib "user32.dll" (ByVal hwnd As Long, ByVal hDC As Long) As Long
Private Declare Function DeleteDC Lib "gdi32.dll" (ByVal hDC As Long) As Long
Private Declare Function SelectObject Lib "gdi32.dll" (ByVal hDC As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32.dll" (ByVal hObject As Long) As Long
Private Declare Function CreateDIBSection Lib "gdi32.dll" (ByVal hDC As Long, ByRef pBitmapInfo As Any, ByVal un As Long, ByRef Pointer As Long, ByVal Handle As Long, ByVal dw As Long) As Long
Private Declare Function AlphaBlend Lib "msimg32.dll" (ByVal hdcDest As Long, ByVal nXOriginDest As Long, ByVal nYOriginDest As Long, ByVal nWidthDest As Long, ByVal nHeightDest As Long, ByVal hdcSrc As Long, ByVal nXOriginSrc As Long, ByVal nYOriginSrc As Long, ByVal nWidthSrc As Long, ByVal nHeightSrc As Long, ByVal lBlendFunction As Long) As Long
Private Declare Function SetStretchBltMode Lib "gdi32.dll" (ByVal hDC As Long, ByVal nStretchMode As Long) As Long
Private Declare Function GetObjectType Lib "gdi32.dll" (ByVal hgdiobj As Long) As Long
Private Declare Function GetCurrentObject Lib "gdi32.dll" (ByVal hDC As Long, ByVal uObjectType As Long) As Long
Private Declare Function GetGDIObject Lib "gdi32.dll" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, ByRef lpObject As Any) As Long
Private Declare Function GetIconInfo Lib "user32.dll" (ByVal hIcon As Long, ByRef piconinfo As ICONINFO) As Long
Private Const STRETCH_HALFTONE As Long = 4
Private Const OBJ_BITMAP As Long = 7
Private Const OBJ_METAFILE As Long = 9
Private Const OBJ_ENHMETAFILE As Long = 13
Private Type BITMAP
    bmType As Long
    bmWidth As Long
    bmHeight As Long
    bmWidthBytes As Long
    bmPlanes As Integer
    bmBitsPixel As Integer
    bmBits As Long
End Type

' APIs used to create files
Private Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, lpSecurityAttributes As Any, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long
Private Declare Function WriteFile Lib "kernel32" (ByVal hFile As Long, lpBuffer As Any, ByVal nNumberOfBytesToWrite As Long, lpNumberOfBytesWritten As Long, lpOverlapped As Any) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Const INVALID_HANDLE_VALUE = -1
Private Const CREATE_ALWAYS = 2
Private Const GENERIC_READ = &H80000000
Private Const GENERIC_WRITE = &H40000000
Private Const FILE_ATTRIBUTE_NORMAL = &H80

' used to create the checkerboard pattern on demand
Private Declare Function FillRect Lib "user32.dll" (ByVal hDC As Long, ByRef lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32.dll" (ByVal crColor As Long) As Long
Private Declare Function OffsetRect Lib "user32.dll" (ByRef lpRect As RECT, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function BitBlt Lib "gdi32.dll" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type


' used when saving an image or part of the image
Private Declare Function VarPtrArray Lib "msvbvm60.dll" Alias "VarPtr" (Ptr() As Any) As Long
Private Type SafeArrayBound
    cElements As Long
    lLbound As Long
End Type
Private Type SafeArray
    cDims As Integer
    fFeatures As Integer
    cbElements As Long
    cLocks As Long
    pvData As Long
    rgSABound(0 To 1) As SafeArrayBound ' reusable UDT for 1 & 2 dim arrays
End Type

Private Type ICONINFO
    fIcon As Long
    xHotspot As Long
    yHotspot As Long
    hbmMask As Long
    hbmColor As Long
End Type
Private Type BITMAPINFOHEADER
    biSize As Long
    biWidth As Long
    biHeight As Long
    biPlanes As Integer
    biBitCount As Integer
    biCompression As Long
    biSizeImage As Long
    biXPelsPerMeter As Long
    biYPelsPerMeter As Long
    biClrUsed As Long
    biClrImportant As Long
End Type
Private Type BITMAPINFO
    bmiHeader As BITMAPINFOHEADER
    bmiPalette As Long
End Type

Private Const AC_SRC_OVER = &H0
Private Const AC_SRC_ALPHA = &H1

Public Enum eImageFormat    ' source image format
    imgError = -1  ' no DIB has been initialized
    imgNone = 0    ' no image loaded
    imgBitmap = 1  ' standard bitmap or jpg
    imgIcon = 3    ' standard icon
    imgWMF = 2     ' windows meta file
    imgEMF = 4     ' enhanced WMF
    imgCursor = 5  ' standard cursor
    imgBmpARGB = 6  ' 32bpp bitmap where RGB is not pre-multiplied
    imgBmpPARGB = 7 ' 32bpp bitmap where RGB is pre-multiplied
    imgIconARGB = 8 ' XP-type icon; 32bpp ARGB
    imgGIF = 9      ' gif; if class.Alpha=True, then transparent GIF
    imgPNG = 10     ' PNG image
    imgPNGicon = 11 ' PNG in icon file (Vista)
    imgCursorARGB = 12 ' alpha blended cursors? do they exist yet?
    imgCheckerBoard = 64 ' image is displaying own checkerboard pattern; no true image
End Enum

Public Enum ePngProperties ' following are recognized "Captions" within a PNG file
    txtTitle = 1           ' See cPNGwriter.SetPngProperty for more information
    txtAuthor = 2
    txtDescription = 4
    txtCopyright = 8
    txtCreationTime = 16
    txtSoftware = 32
    txtDisclaimer = 64
    txtWarning = 128
    txtSource = 256
    txtComment = 512
    ' special properties
    txtLargeBlockText = 1024 ' this is free-form text can be of any length & contain most any characters
    dateTimeModified = 2048  ' date/time of the last image modification (not the time of initial image creation)
    colorDefaultBkg = 4096   ' default background color to use if PNG viewer does not do transparency
    filterType = 8192        ' one of the eFilterMethods values
    ClearAllProperties = -1  ' resets all PNG properties
End Enum

Public Enum eTrimOptions    ' see TrimImage method
    trimAll = 0
    trimLeft = 1
    trimTop = 2
    trimRight = 4
    trimBottom = 8
End Enum

Public Enum eScaleOptions
    scaleToSize = 0         ' [Default] will always scale
    scaleDownAsNeeded = 1   ' will only scale down if image won't fit
    ScaleStretch = 2        ' wll always stretch/distort
End Enum

Public Enum eGrayScaleFormulas
    gsclCCIR709 = 0
    gsclNTSCPAL = 1
    gsclSimpleAvg = 2
End Enum

Public Enum eFilterMethods
    filterDefault = 0     ' paletted PNGs will use filterNone while others will use filterPaeth
    filterNone = 1        ' no byte preparation used; else preps bytes using one of the following
    filterAdjLeft = 2     ' see cPNGwriter.EncodeFilter_Sub
    filterAdjTop = 3      ' see cPNGwriter.EncodeFilter_Up
    filterAdjAvg = 4      ' see cPNGwriter.EncodeFilter_Avg
    filterPaeth = 5       ' see cPNGwriter.EncodeFilter_Paeth
    filterAdaptive = 6    ' this is a best guess of the above 4 (can be different for each DIB scanline)
End Enum

'Private m_PNGprops As cPNGwriter    ' used for more advanced PNG creation options
Private m_StretchQuality As Boolean ' if true will use BiLinear or better interpolation
Private m_Handle As Long        ' handle to 32bpp DIB
Private m_Pointer As Long       ' pointer to DIB bits
Private m_Height As Long        ' height of DIB
Private m_Width As Long         ' width of DIB
Private m_hDC As Long           ' DC if self-managing one
Private m_prevObj As Long       ' object deselected from DC when needed
Private m_osCAP As Long         ' 1=Can use AlphaBlend (Win2K+), 2=Can use GDI+ (Win98+), 4=Can use zLib. See Class_Initialize
Private m_Format As eImageFormat ' type of source image
Private m_ManageDC As Boolean   ' does class manage its own DC
Private m_AlphaImage As Boolean ' does the DIB contain alpha/transparency
Private m_ImageByteCache() As Byte  ' should you want the DIB class to cache original bytes
' ^^ N/A if image is loaded by handle, stdPicture, or resource

Public Function LoadPicture_File(ByVal FileName As String, _
                                Optional ByVal iconCx As Long, _
                                Optional ByVal iconCy As Long, _
                                Optional ByVal SaveFormat As Boolean) As Boolean

    ' PURPOSE: Convert passed image file into a 32bpp image
    
    ' Parameters.
    ' FileName :: full path of file. Validation occurs before we continue
    ' iconCx :: desired width of icon if file is an icon file. Default is 32x32
    ' iconCy :: desired height of icon if file is an icon file. Default is 32x32
    ' SaveFormat :: if true, then the image will be cached as a byte array only
    '   if the image was successfully loaded. Call GetOrginalFormat to retrieve them.
    
    ' Why would you want to save the bytes? If this is being used in a usercontrol,
    ' saving the bytes will almost always be less size than saving the 32bit DIB.
    ' Additionally, these classes have the ability to get different sizes from
    ' the original source (i.e., WMF, icon, cursors) if available, but if the
    ' 32bit DIB is saved, it is a constant size. The potential of different sizes
    ' could allow better resizing of the image vs stretching the DIB.

    On Error Resume Next
    If Not iparseFileExists(FileName) Then Exit Function
    If FileLen(FileName) < 57 Then Exit Function
    ' no image file/stream can be less than 57 bytes and still be an image
    If Err Then
        Err.Clear
        Exit Function
    End If
    Dim aDIB() As Byte  ' dummy array
    LoadPicture_File = LoadPictureEx(FileName, aDIB(), iconCx, iconCy, 0, 0, SaveFormat)
    
End Function

Public Function LoadPicture_Stream(inStream() As Byte, _
                                    Optional ByVal iconCx As Long, _
                                    Optional ByVal iconCy As Long, _
                                    Optional ByVal streamStart As Long = 0, _
                                    Optional ByVal streamLength As Long = 0, _
                                    Optional ByVal SaveFormat As Boolean) As Boolean
    
    ' PURPOSE: Convert passed array into a 32bpp image
    
    ' Parameters.
    ' inStream:: byte stream containing the image. Validation occurs below
    ' iconCx :: desired width of icon if file is an icon file. Default is 32x32
    ' iconCy :: desired height of icon if file is an icon file. Default is 32x32
    ' streamStart :: array position of 1st byte of the image file. Validated.
    ' streamLength :: total length of the image file. Validated.
    ' SaveFormat :: if true, then the image will be cached as a byte array only
    '   if the image was successfully loaded. Call GetOrginalFormat to retrieve them.
    
    ' Why would you want to save the bytes? If this is being used in a usercontrol,
    ' saving the bytes will almost always be less size than saving the 32bit DIB.
    ' Additionally, these classes have the ability to get different sizes from
    ' the original source (i.e., WMF, icon, cursors) if available, but if the
    ' 32bit DIB is saved, it is a constant size. The potential of different sizes
    ' could allow better resizing of the image vs stretching the DIB.
    
    If iparseIsArrayEmpty(Not inStream) Then Exit Function
    If streamStart < LBound(inStream) Then streamStart = LBound(inStream)
    If streamLength = 0 Then streamLength = UBound(inStream) - streamStart + 1
    If streamLength < 57 Then Exit Function
    ' no image file/stream can be less than 57 bytes and still be an image
    LoadPicture_Stream = LoadPictureEx(vbNullString, inStream, iconCx, iconCy, streamStart, streamLength, SaveFormat)

End Function

Public Function LoadPicture_Resource(ByVal ResIndex As Variant, ByVal resSection As Variant, _
                            Optional VbGlobal As IUnknown, _
                            Optional ByVal iconCx As Long, _
                            Optional ByVal iconCy As Long, _
                            Optional ByVal streamStart As Long = 0, _
                            Optional ByVal streamLength As Long = 0) As Boolean

    ' PURPOSE: Convert passed resource into a 32bpp image
    
    ' Parameters.
    ' ResIndex :: the resource file index (i.e., 101)
    ' ResSection :: one of the VB LoadResConstants or String value of
    '       your resource section, i.e., vbResBitmap, vbResIcon, "Custom", etc
    ' VbGlobal :: pass as VB.GLOBAL of the project containing the resource file
    '       - Allows class to be mobile; can exist in DLL or OCX
    '       - if not provided, class will use resource from existing workspace
    '       - For example, if this class was in a compiled OCX, then the only way
    '           to use the host's resource file is passing the host's VB.Global reference
    ' iconCx :: desired width of icon if file is an icon file. Default is 32x32
    ' iconCy :: desired height of icon if file is an icon file. Default is 32x32
    ' streamStart :: array position of 1st byte of the image file. Validated.
    ' streamLength :: total length of the image file. Validated.
    '   -- See LoadPicture_Stream for the validation
    
    ' Tips:
    ' 1) Store 32bpp bitmaps in the "Custom" resource always. Storing in the
    '       Bitmap resource can change color depth of the image created by VB
    '       depending on your screen settings
    ' 2) Icons, normal bitmaps, & cursors are generally stored in their own sections
    '       However, with icons containing multiple formats, VB will extract the
    '       closest format to 32x32. May want to consider storing these in "Custom"
    ' 3) All other types of images are normally stored in the "Custom" section

    On Error GoTo ExitRoutine
    
    Dim oWorkSpace As VB.Global, tPic As StdPicture
    
    If VbGlobal Is Nothing Then
        Set oWorkSpace = VB.Global
    ElseIf TypeOf VbGlobal Is VB.Global Then
        Set oWorkSpace = VbGlobal
    Else
        Set oWorkSpace = VB.Global
    End If
    
    If VarType(resSection) = vbString Then
        Dim inStream() As Byte
        ' could be anything, PNG,icon,gif,32bpp bitmap,wmf, etc
        inStream = oWorkSpace.LoadResData(ResIndex, resSection)
        LoadPicture_Resource = LoadPicture_Stream(inStream, iconCx, iconCy, streamStart, streamLength)
    Else
        ' can only be single icon, bitmap or cursor
        Set tPic = oWorkSpace.LoadResPicture(ResIndex, resSection)
        LoadPicture_StdPicture tPic
    End If
    LoadPicture_Resource = Not (m_Handle = 0)
    
ExitRoutine:
    If Err Then Err.Clear
End Function

Public Function LoadPicture_StdPicture(Picture As StdPicture) As Boolean

    ' PURPOSE: Convert passed stdPicture into a 32bpp image
    
    Me.DestroyDIB
    If Not Picture Is Nothing Then
        ' simply pass off to other parsers
        If Picture.Type = vbPicTypeIcon Then
            ' pass to icon/cursor parser
            Dim cICO As New cICOParser
            Call cICO.ConvertstdPicTo32bpp(Picture, Me)
            Set cICO = Nothing
        ElseIf Not Picture.Type = vbPicTypeNone Then
            ' pass to bmp,jpg,wmf parser
            ' Note: transparent GIFs should not be passed as stdPictures
            '   Pass transparent GIFs by Stream or FileName
            Dim cBMP As New cBMPParser
            Call cBMP.ConvertstdPicTo32bpp(Picture, Me, 0)
            Set cBMP = Nothing
        End If
        LoadPicture_StdPicture = Not (m_Handle = 0)
    End If
    

End Function

Public Function LoadPicture_ByHandle(Handle As Long) As Boolean

    ' PURPOSE: Convert passed image handle into a 32bpp image

    Dim icoInfo As ICONINFO, tPic As StdPicture
    If Not Handle = 0 Then
        Select Case GetObjectType(Handle)
        Case OBJ_BITMAP, OBJ_METAFILE, OBJ_ENHMETAFILE
            ' we should be able to convert this to a stdPicture...
            Set tPic = iparseHandleToStdPicture(Handle, vbPicTypeBitmap)
        Case Else
            ' Test for icons & cursors
            If Not GetIconInfo(Handle, icoInfo) = 0 Then
                ' got it; clean up the bitmap(s) created by GetIconInfo API
                If Not icoInfo.hbmColor = 0 Then DeleteObject icoInfo.hbmColor
                If Not icoInfo.hbmMask = 0 Then DeleteObject icoInfo.hbmMask
                ' convert to stdPicture...
                Set tPic = iparseHandleToStdPicture(Handle, vbPicTypeIcon)
            End If
        End Select
        If Not tPic Is Nothing Then
            ' send to this routine to process
            LoadPicture_ByHandle = LoadPicture_StdPicture(tPic)
        End If
    End If
    
End Function

Public Function LoadPicture_FromOrignalFormat(Optional ByVal iconCx As Long, _
                                         Optional ByVal iconCy As Long) As Boolean

    ' PURPOSE: Reload the current image from the cached bytes (if any)
    ' If the original bytes were not cached when the image was loaded, then no action
    ' will be taken.  See LoadPicture_File & LoadPicture_Stream
    
    Dim tBytes() As Byte
    tBytes() = m_ImageByteCache() ' copy bytes; original are destroyed when DIB is recreated
    LoadPicture_FromOrignalFormat = Me.LoadPicture_Stream(tBytes, iconCx, iconCy, , , True)
    
End Function

Public Sub ScaleImage(ByVal destWidth As Long, ByVal destHeight As Long, newWidth As Long, newHeight As Long, Optional ByVal ScaleMode As eScaleOptions = scaleDownAsNeeded)
                            
    ' Purpose: Returns the width and height needed to draw the image to the requested dimensions.
    ' The actual image is not modified.
    
    ' Function should be called before .Render or .Resize should you want to scale the image.
    ' Additionally, scaling can assist in positioning image too, i.e., centering.
    
    ' destWidth [in]:: the width of the target canvas (drawing area)
    ' destHeight [in]:: the height the target canvas
    ' NewWidth [out]:: returns the width to use for the supplied ScaleMode
    ' NewHeight [out]:: returns the height to use for the supplied ScaleMode
    ' ScaleMode [in]::
    '   scaleToSize [Default] - will always proportionally stretch the image to the target canvas size
    '   scaleDownAsNeeded - will only shrink the image if needed; otherwise the original image size is passed
    '   scaleStretch - the return value is always the canvas width and height; image distortion can occur
                            
    If m_Handle = 0& Then Exit Sub
    
    Dim RatioX As Single, RatioY As Single
    ' calculate scale and offsets
    Select Case ScaleMode
    
    Case scaleDownAsNeeded, scaleToSize: ' scaled
        RatioX = destWidth / m_Width
        RatioY = destHeight / m_Height
        If ScaleMode = scaleDownAsNeeded Then
            If RatioX > 1! And RatioY > 1! Then
                RatioX = 1!: RatioY = RatioX
            End If
        End If
        If RatioX > RatioY Then RatioX = RatioY
        newWidth = Int(RatioX * m_Width)
        newHeight = Int(RatioX * m_Height)
    
        ' To center your image in the target canvas: Use the passed & returned parameters like so:
        ' canvasX = (destWidth - NewWidth) \ 2 + any Left offset you may be using
        ' canvasY = (destHeight - NewHeight) \ 2 + any Top offset you may be using
        ' returned results would then be passed to Render like so:
        '       class.Render canvasX, canvasY, NewWidth, NewHeight, .... additional optional parameters
        
    Case ScaleStretch
        newWidth = destWidth
        newHeight = destHeight
    
    Case Else
        newWidth = m_Width
        newHeight = m_Height
        
    End Select


End Sub

Public Sub CopyImageTo(cDIBclass As c32bppDIB, Optional ByVal newWidth As Long, _
            Optional ByVal newHeight As Long, Optional ByVal CopyOriginalFormat As Boolean = False)
    
    ' Function replicates the the current image to another DIB class and optionally resizes it
    
    ' NewWidth is optional. if zero, will use the source DIB width. If negative will mirror & resize if needed
    ' NewHeight is optional. if zero, will use the source DIB height. If negative will mirror & resize if needed
    ' If CopyOriginalFormat = True then, and only, if class loaded its image
    '   with the optional SaveFormat=True, then the original image bytes
    '   were cached and will be copied to the target cDIBclass also
    '   See LoadPicture_File & LoadPicture_Stream for more info
    
    Dim dDC As Long, bUnselect As Boolean, aResized() As Byte
    
    If Not m_Handle = 0& Then                ' do we have an image to copy?
    
        If newWidth = 0& Then newWidth = m_Width
        If newHeight = 0& Then newHeight = m_Height
        
        If cDIBclass Is Nothing Then
            Set cDIBclass = New c32bppDIB  ' was a valid ref passed?
            cDIBclass.isGDIplusEnabled = Me.isGDIplusEnabled
            cDIBclass.HighQualityInterpolation = Me.HighQualityInterpolation
            cDIBclass.InitializeDIB Abs(newWidth), Abs(newHeight) ' Create new one
        Else
            If Not (Abs(newWidth) = cDIBclass.Width And Abs(newHeight) = cDIBclass.Height) Then
                cDIBclass.InitializeDIB Abs(newWidth), Abs(newHeight) ' Create new one
            End If
        End If
        cDIBclass.Alpha = m_AlphaImage       ' carry over the alpha flag
        cDIBclass.ImageType = m_Format       ' and image type flag
            
        If newWidth = m_Width And newHeight = m_Height Then
            ' can copy using CopyMemory vs AlphaBlend
            CopyMemory ByVal cDIBclass.BitsPointer, ByVal m_Pointer, newWidth * 4& * newHeight
        Else
            
            bUnselect = (m_prevObj = 0&)
            If (m_osCAP And 2) = 2 And (m_StretchQuality = True Or ((m_osCAP And 1) = 0)) Then ' use GDI+ to resize
                Dim cGDIp As New cGDIPlus
                dDC = cDIBclass.LoadDIBinDC(True)
                If bUnselect Then Me.LoadDIBinDC True
                cGDIp.RenderGDIplus Me, dDC, 0&, 100&, 0&, 0&, newWidth, newHeight, 0&, 0&, m_Width, m_Height, True
                cDIBclass.LoadDIBinDC False
                Set cGDIp = Nothing
                If bUnselect Then Me.LoadDIBinDC False
        
            ElseIf newWidth < 0& Or newHeight < 0& Then   ' handle mirroring, AlphaBlend cannot do mirroring
                MirrorDIB 0&, 0&, 0&, 0&, newWidth, newHeight, aResized(), cDIBclass ' routine mirrors directly to DIB bytes
        
            ElseIf (m_osCAP And 1) = 1 And m_StretchQuality = False Then ' O/S has no alphablending shortfalls that are known
                dDC = cDIBclass.LoadDIBinDC(True)   ' load target into a DC
                If bUnselect Then Me.LoadDIBinDC True
                Me.Render dDC, 0&, 0&, newWidth, newHeight, 0&, 0&, m_Width, m_Height
                cDIBclass.LoadDIBinDC False         ' remove DIB from DC
                If bUnselect Then Me.LoadDIBinDC False
            Else
                ' stretching is involved, resize
                Call pvResize(0&, aResized(), aResized(), cDIBclass) ' routine resizes directly to DIB bytes
            End If
        
        End If
        ' if the original image bytes are to be copied, do them too
        If CopyOriginalFormat = True Then Call cDIBclass.SetOriginalFormat(m_ImageByteCache)
    
    End If
    
End Sub

Public Function GetOrginalFormat(outStream() As Byte) As Boolean

    ' If SaveFormat is true when LoadPicture_Stream or LoadPicture_File was
    ' called, the original bytes were cached when the image was successfully
    ' loaded. Call this to return those original bytes

    ' If there are no original bytes, the function returns False
    
    outStream() = m_ImageByteCache()
    GetOrginalFormat = Not iparseIsArrayEmpty(Not m_ImageByteCache)

End Function

Friend Property Let Alpha(isAlpha As Boolean)
    m_AlphaImage = isAlpha  ' determines the flags used for AlphaBlend API
    ' this flag is set by the various image parsers; setting it yourself
    ' can produce less than desirable effects.
    ' Used in cGDIPlus.SaveToPNG, Me.Render & Me.TrimImage, cPNGwriter.OptimizeTrueColor & cPNGwriter.PalettizeImage
End Property
Public Property Get Alpha() As Boolean
    Alpha = m_AlphaImage
End Property

Public Property Let HighQualityInterpolation(Value As Boolean)
    ' When possible GDI+ will be used for stretching, rotation.
    ' If GDI+ is used,then high quality equates to BiCubic interpolation
    ' If not used, then BiLinear (manual processing) will be used.
    ' If High Quality is false, then Nearest Neighbor (very fast) interpolation used
    m_StretchQuality = Value
End Property
Public Property Get HighQualityInterpolation() As Boolean
    HighQualityInterpolation = m_StretchQuality
End Property

Public Property Get ImageType() As eImageFormat
    ImageType = m_Format    ' returns image format of the source image
End Property
Friend Property Let ImageType(iType As eImageFormat)
    m_Format = iType    ' set by the various image parsers. This is not used
    ' anywhere in these classes, you can do with it what you want -- for now.
End Property

Public Property Get Width() As Long
    Width = m_Width     ' width of image in pixels
End Property
Public Property Get Height() As Long
    Height = m_Height   ' height of image in pixels
End Property
Public Property Get BitsPointer() As Long
    BitsPointer = m_Pointer ' pointer to the bits of the image
End Property
Public Property Get scanWidth() As Long
    scanWidth = m_Width * 4&    ' number of bytes per scan line
End Property
Public Property Get Handle() As Long
    Handle = m_Handle   ' the picture handle of the image
End Property

Public Function LoadDIBinDC(ByVal bLoad As Boolean) As Long

    ' Purpose: Select/Unselect the DIB into a DC.
    ' Returns the DC handle when image is loaded
    ' Called by image parser if it needs to paint the image into the DIB
       
    If bLoad = True Then
        Dim tDC As Long
        If Not m_Handle = 0& Then    ' do we have an image?
            If m_hDC = 0& Then        ' do we have a DC?
                tDC = GetDC(0&)     ' if not create one
                m_hDC = CreateCompatibleDC(tDC)
                ReleaseDC 0&, tDC
            End If
            If m_prevObj = 0& Then
                m_prevObj = SelectObject(m_hDC, m_Handle)
            End If
            LoadDIBinDC = m_hDC
        End If
    Else
        If Not m_prevObj = 0& Then
            SelectObject m_hDC, m_prevObj
            If m_ManageDC = False Then
                DeleteObject m_hDC
                m_hDC = 0&
            End If
            m_prevObj = 0&
        End If
    End If
End Function

Public Property Let ManageOwnDC(bManage As Boolean)
    ' Determines whether or not this class will manage its own DC
    ' If false, then a DC is created each time the image needs to be Rendered
    Dim tDC As Long
    If bManage = False Then     ' removing management of DC
        If Not m_hDC = 0& Then   ' DC does exist, destroy it
            ' first remove the dib, if one exists
            If Not m_Handle = 0& Then SelectObject m_hDC, m_prevObj
            m_prevObj = 0&
        End If
        DeleteDC m_hDC
        m_hDC = 0&
    Else                        ' allowing creation of dc
        If m_hDC = 0& Then        ' create DC only if we have a dib to put in it
            If Not m_Handle = 0& Then
                tDC = GetDC(0&)
                m_hDC = CreateCompatibleDC(tDC)
                ReleaseDC 0&, tDC
            End If
        End If
    End If
    m_ManageDC = bManage
End Property
Public Property Get ManageOwnDC() As Boolean
    ManageOwnDC = m_ManageDC
End Property

Public Property Get isAlphaBlendFriendly() As Boolean
    ' Read Only - Available for FYI only. Not used in this class
    isAlphaBlendFriendly = ((m_osCAP And 1) = 1)
    ' WinNT4 & below and Win95 are not shipped with msimg32.dll (AlphaBlend API)
    ' Win98 has bugs & would believe that WinME is buggy too but don't know for sure
    ' Therefore, the Rendering in this class will not use AlphaBlend on these
    ' operating systems even if the DLL exists, but will use GDI+ if available
End Property
Public Property Get isGDIplusEnabled() As Boolean
    ' When GDI+ can be used, it will be used by default for following
    ' rotations, if system not AlphaBlend friendly, all other renderings
    ' if HighQualityInterpolation=True
    ' See the Let Property for more.
    isGDIplusEnabled = ((m_osCAP And 2) = 2)
End Property
Public Property Let isGDIplusEnabled(Enabled As Boolean)
    ' You can force the class not to use GDI plus by setting this property to False
    ' When setting it to true, the setting will only take if GDI+ can be started on the system
    
    ' TIP: If this property returns true and isAlphaBlendFriendly returns True,
    ' recommend setting HighQualityInterpolation to True. That setting will force
    ' routines to use GDI+ for all rendering vs AlphaBlend.
    ' If isAlphaBlendFriendly=False and isGDIplusEnabled=True then GDI+ is always used,
    ' otherwise manual rendering will be used if HighQualityInterpolation=True, rotating, or mirroring
    
    m_osCAP = (m_osCAP And Not 2)
    If Enabled Then
        Dim cGDIp As New cGDIPlus
        If cGDIp.isGDIplusOk() = True Then m_osCAP = m_osCAP Or 2
    End If
End Property

Public Property Get isZlibEnabled() As Boolean
    ' The SaveToFile_PNGex & SaveToStream_PNGex require zLIB.
    ' You can test this property to see if zLIB exists in the user's DLL path
    isZlibEnabled = iparseValidateZLIB(vbNullString, 0, False, False, True)
    
End Property

Public Function InitializeDIB(ByVal Width As Long, ByVal Height As Long) As Boolean

    ' Creates a blank (all black, all transparent) DIB of requested height & width
    
    Dim tBMPI As BITMAPINFO, tDC As Long
    
    DestroyDIB ' clear any pre-existing dib
    
    If Width < 0& Then Exit Function
    If Height = 0& Then
        Exit Function
    ElseIf Height < 0& Then
        Height = Abs(Height) ' no top-down dibs
    End If
    
    On Error Resume Next
    With tBMPI.bmiHeader
        .biBitCount = 32
        .biHeight = Height
        .biWidth = Width
        .biPlanes = 1
        .biSize = 40&
        .biSizeImage = .biHeight * .biWidth * 4&
    End With
    If Err Then
        Err.Clear
        ' only possible error would be that Width*Height*4& is absolutely huge
        Exit Function
    End If
    
    tDC = GetDC(0&) ' get screen DC
    m_Handle = CreateDIBSection(tDC, tBMPI, 0&, m_Pointer, 0&, 0&)
    If m_ManageDC = True Then
        ' create a DC if class is managing its own & one isn't created yet
        If m_hDC = 0& Then m_hDC = CreateCompatibleDC(tDC)
    End If
    ' release the screen DC if we captured it
    ReleaseDC 0&, tDC
    
    If Not m_Handle = 0& Then    ' let's hope system resources allowed DIB creation
        m_Width = Width
        m_Height = Height
        m_AlphaImage = True
        m_Format = imgNone
        InitializeDIB = True
    End If

End Function

Public Sub DestroyDIB()
    
    ' PURPOSE: Destroy any existing image
    If Not m_hDC = 0 Then   ' do we have a DC?
        ' do we have an image; if so get it out of the DC
        If Not m_prevObj = 0 Then SelectObject m_hDC, m_prevObj
        ' destroy our DC, no point in keeping it w/o image
        DeleteObject m_hDC
        m_hDC = 0
    End If
    ' if we do have an image, destroy it now
    If Not m_Handle = 0 Then
        DeleteObject m_Handle
        Erase m_ImageByteCache
    End If
    ' reset other image attributes
    m_Width = 0
    m_Height = 0
    m_Handle = 0
    m_Pointer = 0
    m_prevObj = 0
    m_AlphaImage = False
    m_Format = imgError
End Sub

Public Function Render(ByVal destinationDC As Long, _
                Optional ByVal destX As Long, Optional ByVal destY As Long, _
                Optional ByVal destWidth As Long, Optional ByVal destHeight As Long, _
                Optional ByVal srcX As Long, Optional ByVal srcY As Long, _
                Optional ByVal srcWidth As Long, Optional ByVal srcHeight As Long, _
                Optional ByVal Opacity As Long = 100, _
                Optional ByVal Blend As Boolean = True, _
                Optional ByVal SetHalfTone As Boolean = True) As Boolean

    ' PURPOSE: Render an existing 32bpp DIB to a target DC
    ' Note: Scaling, if needed, must be done before routine is called
    
    ' Parameters.
    ' destinationDC :: target DC to draw to
    ' destX, destY :: the top/left coordinates to draw to, default is 0,0
    ' destWidth, destHeight :: the width and height to draw to, default is the image's width & height
    ' srcX, srcY :: the left & top offset within the DIB
    ' srcWidth, srcHeight :: the amount of DIB to be rendered
    ' Opacity :: how opaque to draw the image, default is 100% opaque
    ' Blend :: if True, then AlphaBlend will use AC_SRC_ALPHA (per pixel alpha blending)
    '       -- this option is ignored if the class' Alpha property is False
    ' SetHalfTone :: if True, then the destination DC's stretch mode will be modified to
    '       produce better quality results. This option is not available on Win9x systems.
    '       Tip: When AlphaBlending to another DIB set to False
    '            When AlphaBlending to CompatibleBitmap (DDB) or visible DC set to True

    Dim lBlendFunc As Long, tDC As Long, hOldImage As Long
    Dim lStretchMode As Long
    Dim aResizedBytes() As Byte, aMirrorBytes() As Byte
    Dim targetBmp As Long
    Dim bMirrored As Boolean
    
    ' validate a few things
    If m_Handle = 0& Then
        Exit Function
    ElseIf destinationDC = 0& Then
        Exit Function
    ElseIf srcWidth < 0 Then   ' AlphaBlend is not compatible with negative width/height
        Exit Function          ' negative values used in APIs like StretchBlt for mirroring
    ElseIf srcHeight < 0 Then
        Exit Function
    End If
    
    If Opacity = 0 Then
        Render = True
        Exit Function   ' pointless if image is 100% transparent
    Else
        Opacity = Abs(Opacity) Mod 100
        If Opacity = 0 Then Opacity = 100
    End If
    
    ' validate optional parameters for source image
        If srcWidth = 0& Then srcWidth = m_Width
        If srcHeight = 0& Then srcHeight = m_Height
        If srcX < 0 Then srcX = 0&  ' source X,Y cannot be negative
        If srcY < 0 Then srcY = 0&  ' but the dest X,Y can be
    ' validate optional parameters for destination image
        If destWidth = 0 Then destWidth = m_Width
        If destHeight = 0 Then destHeight = m_Height
    ' one more check, AlphaBlend requires that the source rectangle fit within the image
        If srcX + srcWidth > m_Width Then Exit Function
        If srcY + srcHeight > m_Height Then Exit Function
    
    bMirrored = (destWidth < 0 Or destHeight < 0)
    
    If (m_osCAP And 2) = 2 And (m_StretchQuality = True Or ((m_osCAP And 1) = 0)) Then
        ' we can use GDI+ to render when higher quality interpolation is desired
        ' also use GDI+ by default if O/S has GDI+ and system is not AlphaBlend friendly (WinME and lower)
        Dim cGDIp As New cGDIPlus
        cGDIp.RenderGDIplus Me, destinationDC, 0&, Opacity, destX, destY, destWidth, destHeight, srcX, srcY, srcWidth, srcHeight, m_StretchQuality

    Else
        
        
        If m_hDC = 0& Then  ' do we have a DC to select our image into?
            tDC = GetDC(0&) ' if not create one, if ManageOwnDC=True, we will have one
            m_hDC = CreateCompatibleDC(tDC)
            ReleaseDC 0&, tDC
            hOldImage = SelectObject(m_hDC, m_Handle)
        Else
            ' we have a DC, but is the image selected into it?
            If m_prevObj = 0 Then hOldImage = SelectObject(m_hDC, m_Handle)
        End If
        
        If m_osCAP = 0& Or (destWidth < 0& Or destHeight < 0&) Or m_StretchQuality = True Then
            ' win95/NT4, or other nonAlphaBlend Friendly systems w/o GDI+
            ' or mirroring is in effect. AlphaBlend does not support mirroring, therefore, need to manually do it
            ' AlphaBlend does not support BiLinear/BiCubic interpolation; only supports Nearest Neighbor
            
            targetBmp = GetCurrentObject(destinationDC, OBJ_BITMAP) ' used to reduce amount of pixels rendered if possible
            If Not (srcWidth = destWidth And srcHeight = destHeight) Then
                ' stretching is involved, resize. First mirror if needed
                MirrorDIB srcX, srcY, srcWidth, srcHeight, destWidth, destHeight, aMirrorBytes()
                If pvResize(targetBmp, aResizedBytes(), aMirrorBytes(), Nothing, srcX, srcY, srcWidth, srcHeight, destX, destY, destWidth, destHeight) = False Then Exit Function
            End If
            ' use custom blending routine
            Render = Win9xBlend(targetBmp, destinationDC, aResizedBytes(), srcX, srcY, destX, destY, destWidth, destHeight, (255& * Opacity) \ 100&)
        
        Else
        
            ' Stretch_Halftone not compatible with win9x
            If SetHalfTone Then
                If (m_osCAP And 1) = 1 Then lStretchMode = SetStretchBltMode(destinationDC, STRETCH_HALFTONE)
            End If
            
            ' calculate the opacity required & add it to the BlendFunction variable
            lBlendFunc = AC_SRC_OVER Or (((255& * Opacity) \ 100&) * &H10000)
            ' if the image has transparency, then we add the AC_SRC_ALPHA flag too
            If m_AlphaImage = True And Blend = True Then lBlendFunc = lBlendFunc Or (AC_SRC_ALPHA * &H1000000)
            Render = Not (AlphaBlend(destinationDC, destX, destY, destWidth, destHeight, m_hDC, srcX, srcY, srcWidth, srcHeight, lBlendFunc) = 0)
            
            If SetHalfTone Then
                If (m_osCAP And 1) = 1 Then SetStretchBltMode destinationDC, lStretchMode
            End If
            
        End If
        
        ' remove the image from the DC if necessary
        If Not hOldImage = 0 Then SelectObject m_hDC, hOldImage
        If Not tDC = 0& Then    ' if we created a DC, let's destroy it now
            DeleteDC m_hDC
            m_hDC = 0&
        End If
        
    End If
    
End Function

Public Function SaveToFile(ByVal FileName As String, Optional ByVal PromptOverwrite As Boolean = True) As Boolean

    ' Should you want to save a 32bpp image to a file
    ' Did you know? A 32bpp "XP-icon" saved in bitmap format is actually smaller
    '               than saving it in an icon format....
    '   BMP Format: 14byte header + 40byte BitmapInfo + 32bpp image bytes
    '   ICO Format: 22byte header + 40byte BitmapInfo + 32bpp image bytes + 1bpp mask bytes
    
    ' FileName :: full path & name of file to be created
    ' PromptOverwrite :: if True, the user will be offered an option to abort
    '    if the target file already exists
    
    If FileName = vbNullString Then Exit Function
    If m_Handle = 0& Then Exit Function
    
    On Error GoTo ExitRoutine
    If iparseFileExists(FileName) Then
        If PromptOverwrite = True Then
            If MsgBox("Overwrite current file?", vbYesNo + vbDefaultButton2 + vbQuestion, "Overwrite Confirmation") = vbNo Then
                Exit Function
            End If
        End If
    End If
    
    Dim fileNum As Long, rwLen As Long
    Dim tBMPI As BITMAPINFO
    
    ' CREATE_ALWAYS will delete previous file if necessary
    fileNum = CreateFile(FileName, GENERIC_READ Or GENERIC_WRITE, _
              ByVal 0&, ByVal 0&, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0&)
    If (fileNum = INVALID_HANDLE_VALUE) Then Exit Function
    
    With tBMPI.bmiHeader
        .biHeight = m_Height
        .biPlanes = 1
        .biSize = 40
        .biWidth = m_Width
        .biBitCount = 32
        .biSizeImage = .biWidth * .biHeight * 4&
    End With
    
    ' simply write the file
    WriteFile fileNum, &H4D42&, 2&, rwLen, ByVal 0& ' write BMP magic number
    If rwLen = 2& Then                              ' write the overall size of bitmap
        WriteFile fileNum, CLng(54& + tBMPI.bmiHeader.biSizeImage), 4&, rwLen, ByVal 0&
        If rwLen = 4& Then                          ' write reserved bytes
            WriteFile fileNum, 0&, 4&, rwLen, ByVal 0&
            If rwLen = 4& Then                      ' write image offset from beginning of file
                WriteFile fileNum, 54&, 4&, rwLen, ByVal 0&
                If rwLen = 4& Then                  ' write the bitmap info structure
                    WriteFile fileNum, tBMPI.bmiHeader.biSize, 40&, rwLen, ByVal 0&
                    If rwLen = 40& Then             ' write the bitmap pixels
                        WriteFile fileNum, ByVal m_Pointer, tBMPI.bmiHeader.biSizeImage, rwLen, ByVal 0&
                        SaveToFile = (rwLen = tBMPI.bmiHeader.biSizeImage)
                    End If
                End If
            End If
        End If
    End If
    
ExitRoutine:
If Not fileNum = 0& Then CloseHandle fileNum
If Err Then Err.Clear

End Function

'Public Function SaveToFile_PNG(ByVal FileName As String, Optional ByVal PromptOverwrite As Boolean = True) As Boolean
'
'    ' Requires GDI+ and/or zLib installed on the system, otherwise function fails
'    ' TEST isGDIplusEnabled or isZlibEnabled
'    ' To use the optional PNG properties, isZlibEnabled must be True
'    '   See PngPropertySet and PngPropertyGet
'
'    ' Function saves the 32bpp image to file, converting it to a PNG format first
'    ' FileName :: full path & name of file to be created
'    ' PromptOverwrite :: if True, the user will be offered an option to abort
'    '    if the target file already exists
'    ' Per PNG recommendations, the PNG is converted to non-premultiplied pixels
'
'    If FileName = vbNullString Then Exit Function
'    If m_Handle = 0& Then Exit Function
'
'    If iparseFileExists(FileName) Then
'        If PromptOverwrite = True Then
'            If MsgBox("Overwrite current file?", vbYesNo + vbDefaultButton2 + vbQuestion, "Overwrite Confirmation") = vbNo Then
'                Exit Function
'            End If
'        End If
'    End If
'
'    Dim aDummy() As Byte
'    Dim cGDIp As cGDIPlus, cZlib As cPNGwriter
'    Dim bSuccess As Boolean
'
'    If m_PNGprops Is Nothing Then
'        Set cGDIp = New cGDIPlus
'        If cGDIp.SaveToPNG(FileName, aDummy(), Me) = False Then
'            Set cZlib = New cPNGwriter
'            bSuccess = cZlib.SavePNGex(Me, FileName, aDummy())
'        Else
'            bSuccess = True
'        End If
'    Else
'        If m_PNGprops.SavePNGex(Me, FileName, aDummy()) = False Then
'            Set cGDIp = New cGDIPlus
'            bSuccess = cGDIp.SaveToPNG(FileName, aDummy(), Me)
'        Else
'            bSuccess = True
'        End If
'    End If
'    SaveToFile_PNG = bSuccess
'
'End Function

Public Function SaveToStream(outStream() As Byte) As Boolean

    ' Should you want to serialize the 32bpp DIB
    
    On Error GoTo ExitRoutine   ' should out of memory occur?
    
    If m_Handle = 0& Then Exit Function
    
    Dim tBMPI As BITMAPINFO
    
    With tBMPI.bmiHeader
        .biBitCount = 32
        .biHeight = m_Height
        .biPlanes = 1
        .biSize = 40
        .biSizeImage = m_Width * m_Height * 4&
        .biWidth = m_Width
    End With
    
    ReDim outStream(0 To 54 + tBMPI.bmiHeader.biSizeImage - 1)
    
    CopyMemory outStream(0), &H4D42, 2& ' bmp magic number
    CopyMemory outStream(2), CLng(54 + tBMPI.bmiHeader.biSizeImage), 4& ' overall size of image
    ' ^^ 54 = 14 byte bmp header + 40 for the tBMPI structure
    CopyMemory outStream(10), 54&, 4& ' image offset from beginning of file
    CopyMemory outStream(14), tBMPI, 40&
    CopyMemory outStream(54), ByVal m_Pointer, tBMPI.bmiHeader.biSizeImage
    
    SaveToStream = True
    
ExitRoutine:
    If Err Then
        Err.Clear
        Erase outStream()
    End If
End Function

'Public Function SaveToStream_PNG(outStream() As Byte) As Boolean
'
'    ' Requires GDI+ and/or zLib installed on the system, otherwise function fails
'    ' TEST isGDIplusEnabled or isZlibEnabled
'    ' To use the optional PNG properties, isZlibEnabled must be True
'    '   See PngPropertySet and PngPropertyGet
'
'    ' Function saves the current 32bpp DIB to an array containing the DIB in PNG format
'    ' Per PNG recommendations, the PNG is converted to non-premultiplied pixels
'
'    If m_Handle = 0& Then Exit Function
'
'    Dim cGDIp As cGDIPlus, cZlib As cPNGwriter
'    Dim bSuccess As Boolean
'
'    If m_PNGprops Is Nothing Then
'        Set cGDIp = New cGDIPlus
'        If cGDIp.SaveToPNG(vbNullString, outStream(), Me) = False Then
'            Set cZlib = New cPNGwriter
'            bSuccess = cZlib.SavePNGex(Me, vbNullString, outStream())
'        Else
'            bSuccess = True
'        End If
'    Else
'        If m_PNGprops.SavePNGex(Me, vbNullString, outStream()) = False Then
'            Set cGDIp = New cGDIPlus
'            bSuccess = cGDIp.SaveToPNG(vbNullString, outStream(), Me)
'        Else
'            bSuccess = True
'        End If
'    End If
'    SaveToStream_PNG = bSuccess
'
'End Function

'Public Function PngPropertySet(ByVal PropertyID As ePngProperties, Optional PropertyValue As Variant, Optional ByVal LargeBlockCaption As String) As Boolean
'
'    ' Sets up to 13 properties: the properties are described below
'    ' Once set, properties are forever applied until PngPropetySet(ClearAllProperties)
'    '   is called or this class is terminated
'
'    ' [PropertyID]
'    ' txtTitle - Short (one line) title or caption for image
'    ' txtAuthor - Name of image's creator
'    ' txtDescription - Description of image
'    ' txtCopyright - Copyright notice
'    ' txtCreationTime - Creation Time of original image creation
'    ' txtSoftware - Software used to create the image
'    ' txtDisclaimer - Legal disclaimer
'    ' txtWarning - Warning or nature of content
'    ' txtSource - Device used to create the image
'    ' txtComment - Comment
'    ' :: the above are registered/recognized keywords usable in PNGs
'
'    ' txtLargeBlockText - miscellaneous, can contain most any text and size.
'    '   When used, you must supply a Caption/Keyword for the text in LargeBlockCaption parameter
'
'    ' colorDefaultBkg - background color used if PNG viewer opts to compose against only solid colors
'
'    ' dateTimeModified - date/time when the PNG was last modified.
'
'    ' filterType - changes the precompression filter method applied to PNG data
'    '   See cPNGwriter filter functions for details on how filters modify data
'
'    ' ClearAllProperties - removes all properties, the other parameters are not used
'    '   When a property is set zLIB will be used over GDI+. When properties are cleared
'    '   then GDI+ will be used over zLIB
'
'    '[PropertyValue]
'    ' If not provided, the property associated with PropertyID is removed
'    '   for colorDefaultBkg, this parameter is a valid RGB color
'    '   for dateTimeModified, this parameter is a valid date/time. IsDate(PropertyValue) must be True
'    '   for filterType, this paramater is one of the eFilterMethods enumeration values. Default is filterDefault
'    '   for all others, this is text
'
'    '[LargeBlockCaption]
'    '   Only used when PropertyID is txtLargeBlockText. This is the caption/keyword to
'    '   be used with the supplied text. Cannot be one of the registered keywords
'
'    If PropertyID = ClearAllProperties Then
'        Set m_PNGprops = Nothing
'        PngPropertySet = True
'
'    ElseIf IsMissing(PropertyValue) = True Then
'        If Not m_PNGprops Is Nothing Then
'            PngPropertySet = m_PNGprops.RemoveProperty(PropertyID, LargeBlockCaption)
'        End If
'
'    Else
'        If m_PNGprops Is Nothing Then Set m_PNGprops = New cPNGwriter
'        PngPropertySet = m_PNGprops.AddProperty(PropertyID, PropertyValue, LargeBlockCaption)
'    End If
'
'End Function

'Public Function PngPropertyGet(ByVal PropertyID As ePngProperties, Optional ByVal LargeBlockCaption As String) As Variant
'
'    ' Returns a property previously set
'    ' See PngPropertySet for parameter details
'    ' Note that LargeBlockCaption is required if PropertyID = txtLargeBlockText
'
'    Dim vReturn As Variant
'
'    If m_PNGprops Is Nothing Then
'        If PropertyID = colorDefaultBkg Then
'            vReturn = -1&
'        ElseIf PropertyID = dateTimeModified Then
'            vReturn = CDate(0)
'        Else
'            vReturn = vbNullString
'        End If
'    Else
'        vReturn = m_PNGprops.GetProperty(PropertyID, LargeBlockCaption)
'    End If
'
'    PngPropertyGet = vReturn
'End Function


Public Function Resize(ByVal newWidth As Long, ByVal newHeight As Long) As Boolean

    ' Function simply resizes the current DIB to passed dimensions of Width & Height
    ' If newWidth is negative, the image will be horizontally mirrored
    ' If newHeight is negative, the image will be vertically mirrored
    
    If m_Handle = 0& Then Exit Function
    
    If newWidth = 0& Then newWidth = m_Width
    If newHeight = 0& Then newHeight = m_Height
    
    If newWidth = m_Width And newHeight = m_Height Then
        Resize = True                   ' no change
        Exit Function
    End If

    Dim tHost As New c32bppDIB
    Dim tDC As Long, sDC As Long
    Dim aDummy() As Byte, bUnselect As Boolean
    
    With tHost
        .InitializeDIB Abs(newWidth), Abs(newHeight)   ' create new DIB
        .isGDIplusEnabled = Me.isGDIplusEnabled
        .HighQualityInterpolation = Me.HighQualityInterpolation
        .ImageType = m_Format          ' transfer format & alpha format
        .Alpha = m_AlphaImage
        .SetOriginalFormat m_ImageByteCache
    End With
    
    bUnselect = (m_prevObj = 0&)
    If m_StretchQuality = True And ((m_osCAP And 2) = 2) Then ' use GDI+ for resizing
        Dim cGDIp As New cGDIPlus
        tDC = tHost.LoadDIBinDC(True)
        If bUnselect Then Me.LoadDIBinDC True
        cGDIp.RenderGDIplus Me, tDC, 0&, 100&, 0&, 0&, newWidth, newHeight, 0&, 0&, m_Width, m_Height, True
        tHost.LoadDIBinDC False
        Set cGDIp = Nothing
        If bUnselect Then Me.LoadDIBinDC False
        
    ElseIf newWidth < 0& Or newHeight < 0& Then ' handle mirroring, AlphaBlend cannot do mirroring
        MirrorDIB 0&, 0&, 0&, 0&, newWidth, newHeight, aDummy(), tHost ' routine mirrors directly to DIB bytes
    
    ElseIf (m_osCAP And 1) = 1& And m_StretchQuality = False Then
        tDC = tHost.LoadDIBinDC(True)               ' select into DC
        If bUnselect Then Me.LoadDIBinDC True
        Me.Render tDC, 0&, 0&, newWidth, newHeight  ' stretch AlphaBlend
        tHost.LoadDIBinDC False                     ' remove from DC
        If bUnselect Then Me.LoadDIBinDC False
    Else
        pvResize 0&, aDummy(), aDummy(), tHost   ' use custom resizing routine for nonAlphaBlend-friendly systems
    End If
    
    tHost.CopyImageTo Me, , , True    ' copy it back to us
    
    Set tHost = Nothing                 ' done
    Resize = True

End Function

Public Function TrimImage(ByVal UpdateDIB As Boolean, ByVal Method As eTrimOptions, _
                          Optional ByRef X As Long, Optional ByRef Y As Long, _
                          Optional ByRef Width As Long, Optional ByRef Height As Long) As Boolean
    
    ' Function can remove excess transparency from an image and/or return the
    ' X,Y,width & height needed to render out the excess transaprency
    
    ' Parameters
    ' UpdateDIB. If true, the image will be permanently resized/cropped/trimmed
    ' X,Y.
    '   If UpdateDIB=True, then these will be zero,zero
    '   If UpdateDIB=False, then X,Y will be the top,left coordinate of 1st non-transparent pixel
    ' Width,Height. the adjusted width/height after trimming the image
    '   If either Width/Height are zero, then the image is 100% transparent
    
    ' Note: Trimming alpha images may not produce desired results. Many alpha images may
    ' have buffered transparent borders to visually center the image within the overall
    ' dimensions of the image. For example, if the image is heavily shaded on the right side,
    ' the image may have an equal amount of transparent columns on the left side to compensate.
    
    If m_Handle = 0& Then Exit Function
    If m_AlphaImage = False Then
        X = 0&: Y = 0&: Width = m_Width: Height = m_Height
        TrimImage = True
        Exit Function
    End If
    If Method = trimAll Then Method = trimBottom Or trimLeft Or trimRight Or trimTop
    If Method < trimAll Then Exit Function
    
    Dim tSA As SafeArray, sBytes() As Byte
    Dim dSA As SafeArray, dBytes() As Byte
    Dim srcX As Long, srcY As Long, sWidth As Long
    Dim tHost As c32bppDIB
    
    sWidth = m_Width * 4&
    With tSA
        .cbElements = 1
        .cDims = 2
        .pvData = m_Pointer
        .rgSABound(0).cElements = m_Height
        .rgSABound(1).cElements = sWidth
    End With
    CopyMemory ByVal VarPtrArray(sBytes), VarPtr(tSA), 4&
    
    ' define trimmed top edge
    If (Method And trimTop) = trimTop Then
        For Y = m_Height - 1& To 0& Step -1&
            For srcX = 3& To sWidth - 1& Step 4&
                If Not sBytes(srcX, Y) = 0& Then Exit For
            Next
            If srcX < sWidth Then Exit For ' row is NOT fully transparent
        Next
        If Y = -1& Then ' the entire image is transparent
            Y = 0&: X = 0&: Width = 0&: Height = 0&
            CopyMemory ByVal VarPtrArray(sBytes), 0&, 4&
            Exit Function
        End If
    Else
        Y = m_Height - 1&
    End If
    
    Y = m_Height - Y - 1&    ' calculate top trimmed row
    
    If (Method And trimBottom) = trimBottom Then
        ' define trimmed bottom edge
        For Height = 0& To m_Height - Y - 1&
            For srcX = 3& To sWidth - 1& Step 4&
                If Not sBytes(srcX, Height) = 0& Then Exit For
            Next
            If srcX < sWidth Then Exit For ' row is NOT fully transparent
        Next
        If (Method And trimTop) = 0& Then ' check for full transparency image
            If Height = m_Height Then ' the entire image is transparent
                Y = 0&: X = 0&: Width = 0&: Height = 0&
                CopyMemory ByVal VarPtrArray(sBytes), 0&, 4&
                Exit Function
            End If
        End If
    Else
        Height = 0&
    End If
    
    TrimImage = True
    
    If Height = m_Height - Y Then
        Height = m_Height - Y ' there are no transparent rows from bottom edge
    Else
        Height = m_Height - (Height + Y) ' calculate height of trimmed image
    End If
    
    ' define trimmed left edge
    If (Method And trimLeft) = trimLeft Then
        For X = 3& To sWidth - 1& Step 4&
            For srcY = Y To Y + Height - 1&
                If Not sBytes(X, srcY) = 0& Then Exit For
            Next
            If srcY < Y + Height Then Exit For ' column is NOT fully transparent
        Next
    Else
        X = 3&
    End If
    
    ' define trimmed left edge
    If (Method And trimRight) = trimRight Then
        For Width = sWidth - 1& To X + 1& Step -4&
            For srcY = Y To Y + Height - 1&
                If Not sBytes(Width, srcY) = 0& Then Exit For
            Next
            If srcY < Y + Height Then Exit For ' column is NOT fully transparent
        Next
    Else
        Width = sWidth - 1&
    End If
    
    If Width < X Then Width = X     ' only one column of non-transparent pixels
    X = X \ 4                       ' calculate left offset of trimmed image
    Width = Width \ 4 - X + 1&      ' calculate width of trimmed image
    
    If UpdateDIB = True And Not (Width = m_Width And Height = m_Height) Then
    
        ' create a temporary DIB to copy
        Set tHost = New c32bppDIB
        tHost.InitializeDIB Width, Height
        tHost.Alpha = m_AlphaImage
        tHost.ImageType = m_Format
        tHost.SetOriginalFormat m_ImageByteCache
        
        With dSA
            .cbElements = 1
            .cDims = 2
            .pvData = tHost.BitsPointer
            .rgSABound(0).cElements = Height
            .rgSABound(1).cElements = Width * 4&
        End With
        CopyMemory ByVal VarPtrArray(dBytes), VarPtr(dSA), 4&
        
        srcY = 0&           ' current destination row
        srcX = X * 4&       ' current source column
        sWidth = Width * 4& ' scanwidth of trimmed image
        
        For Y = m_Height - (Y + Height) To m_Height - Y - 1&
            CopyMemory dBytes(0&, srcY), sBytes(srcX, Y), sWidth
            srcY = srcY + 1&    ' increment destination row
        Next
        CopyMemory ByVal VarPtrArray(dBytes), 0&, 4&
        CopyMemory ByVal VarPtrArray(sBytes), 0&, 4&
        
        ' transfer the updated DIB to our DIB
        tHost.CopyImageTo Me, , , True
        X = 0&: Y = 0&
        
    Else
    
        CopyMemory ByVal VarPtrArray(sBytes), 0&, 4&
    End If
    
End Function

Public Function CreateCheckerBoard(Optional ByVal CheckerSize As Long = 12, _
            Optional ByVal FirstColor As Long = vbWhite, Optional ByVal SecondColor As Long = 12632256) As Boolean

    ' Function simply creates a checkerboard pattern.  This can be desirable when the DIB currently has no
    ' image but something should be displayed. When this is set, you can test whether or not this class
    ' created the Checkerboard by testing class.ImageType = imgCheckerBoard
    
    ' The checker size is used for both the width and height of each square. Default value is 12.
    ' FirstColor is the colored checker at the top left corner of the pattern. Default is white
    ' SecondColor is the alternating checker color. Default is light gray RGB: 192,192,192
    
    If m_Handle = 0& Then Exit Function

    Dim hBrush As Long, hBr1 As Long, hBr2 As Long
    Dim cRect As RECT, tSA As SafeArray
    Dim X As Long, Y As Long, tDC As Long
    Dim bUnselect As Boolean, bEven As Boolean
    Dim dibBytes() As Byte
    
    bUnselect = (m_prevObj = 0&)
    tDC = LoadDIBinDC(True)
    
    hBr1 = CreateSolidBrush(FirstColor)
    hBr2 = CreateSolidBrush(SecondColor)
    
    cRect.Right = CheckerSize
    cRect.Bottom = CheckerSize
    For Y = 0& To m_Height - 1& Step CheckerSize
        If bEven Then hBrush = hBr2 Else hBrush = hBr1
        For X = 0& To m_Width - 1& Step CheckerSize
            FillRect tDC, cRect, hBrush
            If hBrush = hBr1 Then hBrush = hBr2 Else hBrush = hBr1
            OffsetRect cRect, CheckerSize, 0&
        Next
        bEven = Not bEven
        OffsetRect cRect, -cRect.Left, CheckerSize
    Next
    DeleteObject hBr1
    DeleteObject hBr2
    
    If bUnselect Then LoadDIBinDC False
    
    ' here we will force every alpha byte to be fully opaque
    With tSA
        .cbElements = 1
        .cDims = 2
        .pvData = m_Pointer
        .rgSABound(0).cElements = m_Height
        .rgSABound(1).cElements = m_Width * 4&
    End With
    CopyMemory ByVal VarPtrArray(dibBytes), VarPtr(tSA), 4&
    For Y = 0& To m_Height - 1&
        For X = 3& To m_Width * 4& - 1& Step 4&
            dibBytes(X, Y) = 255
        Next
    Next
    CopyMemory ByVal VarPtrArray(dibBytes), 0&, 4&

    m_AlphaImage = False            ' we are not using transparency
    m_Format = imgCheckerBoard      ' special flag for user
    
    CreateCheckerBoard = True
End Function

Public Function RotateAtCenterPoint(ByVal hDC As Long, ByVal Angle As Long, _
                            ByVal CenterPointX As Long, ByVal CenterPointY As Long, _
                            Optional ByVal destWidth As Long, Optional ByVal destHeight As Long, _
                            Optional ByVal srcX As Long, Optional ByVal srcY As Long, _
                            Optional ByVal srcWidth As Long, Optional ByVal srcHeight As Long, _
                            Optional ByVal Opacity As Long = 100&) As Boolean
                            
    ' Function will rotate an image by passed Angle and render to the passed hDC.
    ' This function simultaneously rotates, scales and then blends.
    ' See also RotateAtTopLeft for a different way of entering coordinates for rotation
    
    ' Note: The HighQualityInterpolation property is used to determine quality of rotation/scaling
    
    ' hDC :: target Destination DC to render rotated image
    ' Angle :: between -360 and 360. Rotation is clockwise
    ' CenterPointX :: the center left point where rendered image will rotate around
    ' CenterPointY :: the center top point where rendered image will rotate around
    ' destWidth :: the width of the rotated image. Default is full image width, negative value mirrors horizontally
    ' destHeight :: the height of the rotated image. Default is fulll image height, negative value mirrors vertically
    ' srcX :: the left edge of the source image to begin rotating. Default is 0
    ' srcY :: the top edge of the source image to begin rotating. Default is 0
    ' srcWidth :: the amount of source image to rotate. Default is full image width
    ' srcHeight :: the amount of source image to rotate. Default is full image height
    ' Opacity :: a value between 0 and 100 percent
                            
    
    ' validate parameters
    If destWidth = 0& Then destWidth = m_Width
    If destHeight = 0& Then destHeight = m_Height
    
    ' We will calculate the top/left coordinate based off the passed Center coordinates & eventual width/height
    ' Note: width/height may be negative if mirroring image. Don't change to Abs() otherwise
    '   if GDI+ is rendering, the X,Y coords will be incorrect. GDI+ routine needs the offset
    '   using negative values
    CenterPointX = CenterPointX - destWidth \ 2
    CenterPointY = CenterPointY - destHeight \ 2
    
    ' Simply pass this routine off to the RotateAtTopLeft function vs duplicating the code
    
    RotateAtCenterPoint = RotateAtTopLeft(hDC, Angle, CenterPointX, CenterPointY, destWidth, destHeight, srcX, srcY, srcWidth, srcHeight, Opacity)

End Function


Public Function RotateAtTopLeft(ByVal hDC As Long, ByVal Angle As Long, _
                            Optional ByVal TopX As Long = 0&, Optional ByVal TopY As Long = 0&, _
                            Optional ByVal destWidth As Long, Optional ByVal destHeight As Long, _
                            Optional ByVal srcX As Long = 0&, Optional ByVal srcY As Long = 0&, _
                            Optional ByVal srcWidth As Long, Optional ByVal srcHeight As Long, _
                            Optional ByVal Opacity As Long = 100&) As Boolean

    ' Function will rotate an image by passed Angle and render to the passed hDC.
    ' This function simultaneously rotates, scales and then blends.
    ' See also RotateAtCenterPoint for a different way of entering coordinates for rotation
    
    ' Note: The HighQualityInterpolation property is used to determine quality of rotation/scaling
    
    ' hDC :: target Destination DC to render rotated image
    ' Angle :: between -360 and 360. Rotation is clockwise
    ' TopX :: the left edge of rectangle to rotate within
    ' TopY :: the top edge of rectangle to rotate within
    ' destWidth :: the width of the rotated image. Default is full image width, negative value mirrors horizontally
    ' destHeight :: the height of the rotated image. Default is fulll image height, negative value mirrors vertically
    ' srcX :: the left edge of the source image to begin rotating. Default is 0
    ' srcY :: the top edge of the source image to begin rotating. Default is 0
    ' srcWidth :: the amount of source image to rotate. Default is full image width
    ' srcHeight :: the amount of source image to rotate. Default is full image height
    ' Opacity :: a value between 0 and 100 percent

    If m_Handle = 0& Then Exit Function
    If hDC = 0& Then Exit Function
    
    If Angle Mod 360 = 0 Then ' for zero rotation, call normal Render function -- faster overall
        RotateAtTopLeft = Me.Render(hDC, TopX, TopY, destWidth, destHeight, srcX, srcY, srcWidth, srcHeight, Opacity)
        Exit Function
    End If
    
    ' validate parameters
    If srcX < 0& Or srcY < 0& Then Exit Function
    If srcWidth < 1& Then srcWidth = m_Width
    If srcHeight < 1& Then srcHeight = m_Height
    If srcX + srcWidth > m_Width Then Exit Function
    If srcY + srcHeight > m_Height Then Exit Function
    
    If destWidth = 0& Then destWidth = m_Width
    If destHeight = 0& Then destHeight = m_Height
    
    If Opacity = 0& Then
        RotateAtTopLeft = True
        Exit Function   ' pointless if image is 100% transparent
    End If
    
    ' first see if we can do this via GDI+
    If (m_osCAP And 2) = 2 Then
        Dim cGDIp As New cGDIPlus
        Opacity = Abs(Opacity) Mod 100
        If Opacity = 0& Then Opacity = 100&
        If cGDIp.RenderGDIplus(Me, hDC, Angle, Opacity, TopX, TopY, destWidth, destHeight, srcX, srcY, srcWidth, srcHeight, m_StretchQuality) = True Then
            RotateAtTopLeft = True
            Exit Function
        End If
        Set cGDIp = Nothing
    End If
        
    Dim cosTx As Double, sinTx As Double
    Dim cosTy As Double, sinTy As Double
    Dim scalerX As Double, scalerY As Double
    
    Dim maxX As Long, maxY As Long, maxSize As Long
    Dim ctrX As Long, ctrY As Long
    Dim xOffset As Double, yOffset As Double
    Dim targetX As Double, targetY As Double
    
    Dim dSA As SafeArray, sSA As SafeArray
    Dim dBytes() As Byte, sBytes() As Byte
    
    Dim rHost As New c32bppDIB
    Dim lRow As Long, lCol As Long
    
    ' following variables are used for the BiLinear interpolation only
    Dim tgtY As Long, tgtX As Long
    Dim srcPixel As Long, dstPixel As Long, srcRow As Long
    Dim edgeOffsetX As Long, edgeOffsetY As Long
    Dim fY As Double, fX As Double, iX As Long, iY As Long
    Dim R As Double, G As Double, B As Double, A As Double
    
    ' handle mirroring as needed
    If destWidth < 0 Then TopX = TopX + destWidth
    If destHeight < 0 Then TopY = TopY + destHeight
    MirrorDIB srcX, srcY, srcWidth, srcHeight, destWidth, destHeight, sBytes()
    
    ' determine the scale to use based off the passed
    ' source and destination widths,heights
    scalerX = destWidth / srcWidth      ' scale x coordinates
    scalerY = destHeight / srcHeight    ' scale y coordinates
    
    ' convert angle to radians & calculate scaled COS/SIN of the angle
    ' Multiplying by Negative so we rotate clockwise
    sinTx = -((Angle Mod 360) * (4& * Atn(1))) / 180  ' convert Degree to Radian
    cosTy = Cos(sinTx) / scalerY      ' get cosine of angle (Y coordinates)
    sinTy = Sin(sinTx) / scalerY      ' get sine of angle (Y coordinates)
    
    cosTx = Cos(sinTx) / scalerX      ' get cosine of angle (X coordinates)
    sinTx = Sin(sinTx) / scalerX      ' get sine of angle  (X coordinates)
    ' determine maximum size image we will need to cover any angle
    maxSize = Sqr(destWidth * destWidth + destHeight * destHeight)
    
    ' create a temporary DIB to hold the rotated image
    rHost.InitializeDIB maxSize, maxSize
    rHost.isGDIplusEnabled = Me.isGDIplusEnabled
    rHost.HighQualityInterpolation = Me.HighQualityInterpolation
    
    On Error GoTo eh
    ' overlay the temp DIB and our host DIB
    With dSA
        .cbElements = 1
        .cDims = 2
        .pvData = rHost.BitsPointer
        .rgSABound(0).cElements = maxSize
        .rgSABound(1).cElements = maxSize * 4&
    End With
    CopyMemory ByVal VarPtrArray(dBytes), VarPtr(dSA), 4&
    
    If iparseIsArrayEmpty(Not sBytes) Then
        With sSA
            .cbElements = 1
            .cDims = 2
            .pvData = m_Pointer
            .rgSABound(0).cElements = m_Height
            .rgSABound(1).cElements = m_Width * 4&
        End With
        CopyMemory ByVal VarPtrArray(sBytes), VarPtr(sSA), 4&
    End If
    
    ' bottom up dib, vertical offset is from bottom, not top
    srcY = UBound(sBytes, 2) - srcHeight - srcY + 1&
    ' set up offsets for calculating rotated/scaled points
    maxX = srcWidth + srcX      ' the right edge of the source image
    maxY = srcHeight + srcY     ' the bottom edge of the source image
    ' determine where the center of the source selected bounds falls within the maxSize bounds
    ctrX = srcWidth \ 2 + srcX  ' the center of the source image
    ctrY = srcHeight \ 2 + srcY
    ' calculate offsets to "center" destination image in its maxSize window
    xOffset = ((maxSize - srcWidth) \ 2)
    yOffset = ((maxSize - srcHeight) \ 2)
    
    ' here's where we apply all of the above offsets
    ' This is a bit complicated because we are allows any angle rotation,
    ' and also allowing portions of the image or entire image to be rotated
    ' and also allows scaling up or down
    If m_StretchQuality = False Then
    
        For lRow = -yOffset To maxSize - yOffset - 1&
            
            ' Calculate the point in the source image needed for the rotated point in destination image
            ' This only needs to be done once per image scan line & contains 14 math executions
            targetX = (-xOffset - ctrX) * cosTx + (lRow - ctrY) * sinTx + ctrX
            targetY = (lRow - ctrY) * cosTy - (-xOffset - ctrX) * sinTy + ctrY
        
            For lCol = -xOffset To maxSize - xOffset - 1&
            
                ' validate rotated point is within bounds of the image/portion
                If targetY >= srcY Then                    ' is Y within area of source?
                    If targetY < maxY Then
                        If targetX >= srcX Then            ' is X within area of source?
                            If targetX < maxX Then
                                ' validation complete, copy pixel to destination
                                CopyMemory dBytes((xOffset + lCol) * 4&, yOffset + lRow), sBytes(Int(targetX) * 4&, Int(targetY)), 4&
                            End If
                        End If
                    End If
                End If
        
                ' Excellent optimization I found (wish I remember where so I can give credit)
                ' But the logic is simple: once the initial X,Y coordinates for the
                ' current source row is found, the next point is always a constant value from
                ' the last point. In this case, increments of cosT & sinT.
                ' Therefore we don't need to recalculate targetX,targetY for every point
                ' since we did it once for current row. Thus we have 2 simple additions per pixel
                ' vs 4 multiplications & 10 additions per pixel
                targetX = targetX + cosTx
                targetY = targetY - sinTy
            Next
        Next
        
    Else
        ' BiLinear interpolation with rotation. This can produce better quality
        ' results but takes significantly longer. Recommend using this option
        ' when you need a static rotated image, but when rotating via a scrollbar
        ' or some other method where scrolling is expected to be repeated often,
        ' then use the non-BiLinear method. COMPILED IS MUCH FASTER !!!!
        
        ' Up to 4 source pixels (16 bytes) are blended for each destination pixel (4 bytes)
        srcWidth = maxX - 1& ' reuse variable & subtract now vs subtraction for every pixel in the image
        For lRow = -yOffset To maxSize - yOffset - 1&
            
            ' Calculate the rotated point in relation to host image
            ' These calcs only needs to be done once per image scan line
            targetX = (-xOffset - ctrX) * cosTx + (lRow - ctrY) * sinTx + ctrX
            targetY = (lRow - ctrY) * cosTy - (-xOffset - ctrX) * sinTy + ctrY
        
            For lCol = -xOffset To maxSize - xOffset - 1&
                If targetY >= srcY Then                    ' is Y within area of source?
                    If targetY < maxY Then
                        If targetX >= srcX Then            ' is X within area of source?
                            If targetX < maxX Then
                            
                                tgtY = Int(targetY)     ' whole number of the double
                                If tgtY = 0& Then       ' for top down images check for last row vs 0
                                    ' last row of source image, will use only this row
                                    edgeOffsetY = 0&
                                    fY = 0#
                                Else
                                    ' will use this row & next row for blending
                                    edgeOffsetY = 1&
                                    fY = 1# - (targetY - tgtY) ' for top down images, use: fY = targetY-tgtY
                                    ' ^ Y coordinate fraction; pct of next vertical pixel that is used
                                End If
                                               
                                R = 0#: G = 0#: B = 0#: A = 0#
                                
                                tgtX = Int(targetX)  ' coordinate rounded down to whole number
                                If tgtX = srcWidth Then
                                    ' at far edge of source image, will use only this pixel for blending
                                    edgeOffsetX = 0&
                                    fY = 0#: fX = 0#
                                Else
                                    ' will use this pixel and next pixel for blending
                                    edgeOffsetX = 1&
                                    fX = targetX - tgtX
                                    ' ^ X coordinate fraction, pct of next horizontal pixel that is used
                                End If
                                
                                For iY = 0& To edgeOffsetY
                                    scalerY = Abs(iY - fY)   ' percentage of current row's pixel to blend
                                    
                                    If Not scalerY = 1& Then  ' else zero
                                        srcRow = tgtY - iY    ' for top down images Add iY vs subtracting
                                        For iX = 0& To edgeOffsetX
                                            scalerX = Abs(fX - iX)   ' percentage of current column's pixel to blend
                                            
                                            If Not scalerX = 1& Then  ' else zero
                                                scalerX = (1# - scalerX) * (1# - scalerY) ' combine percentages
                                                srcPixel = (tgtX + iX) * 4&
                                                B = B + sBytes(srcPixel, srcRow) * scalerX
                                                G = G + sBytes(srcPixel + 1&, srcRow) * scalerX
                                                R = R + sBytes(srcPixel + 2&, srcRow) * scalerX
                                                A = A + sBytes(srcPixel + 3&, srcRow) * scalerX
                                            End If
                                            
                                        Next
                                    End If
                    
                                Next
                                dstPixel = (xOffset + lCol) * 4&
                                iY = lRow + yOffset
                                dBytes(dstPixel, iY) = Int(B)
                                dBytes(dstPixel + 1&, iY) = Int(G)
                                dBytes(dstPixel + 2&, iY) = Int(R)
                                dBytes(dstPixel + 3&, iY) = Int(A)
                            End If
                        End If
                    End If
                End If
            targetX = targetX + cosTx
            targetY = targetY - sinTy
            Next
        Next
    End If
    
    CopyMemory ByVal VarPtrArray(dBytes), 0&, 4&
    If sSA.pvData = 0& Then ' image was also mirrored
        Erase sBytes()
    Else                    ' remove overlay of non-mirrored image
        CopyMemory ByVal VarPtrArray(sBytes), 0&, 4&
    End If
    
    xOffset = (TopX + destWidth \ 2) - (maxSize \ 2) '- (bUseBiLinear = False)
    yOffset = (TopY + destHeight \ 2) - (maxSize \ 2) '+ (bUseBiLinear = False)
    RotateAtTopLeft = rHost.Render(hDC, xOffset, yOffset, , , , , , , Opacity)
    
eh:
    If Err Then
        If Err.Number = 16 Then ' expression too complex
            Err.Clear
            Resume
        Else
            Stop
            Err.Clear ' troubleshooting only, should be removed before compiling to final app
            Resume
        End If
    End If
End Function

Public Function MakeGrayScale(ByVal Formula As eGrayScaleFormulas) As Boolean

    ' Purpose: Convert premultiplied bytes to gray scale using one of several formulas
    
    ' Note: to add in your favorite formula, add it first to the eGRayScaleForumals enumeration
    ' in the declarations section, then add the R,G,B percentages in the Select:Case section below
    ' Additionally, don't forget to add the formula in cGDIPlus.MakeGrayScale

    If m_Handle = 0& Then Exit Function
    
    If (m_osCAP And 2) = 2 Then ' we'll use GDI+
        Dim cGDIp As New cGDIPlus
        MakeGrayScale = cGDIp.MakeGrayScale(Me, Formula)
    Else
    
        Dim tSA As SafeArray, gBytes() As Byte
        Dim R As Single, G As Single, B As Single
        Dim X As Long, Y As Long
        
        With tSA
            .cbElements = 1
            .cDims = 2
            .pvData = m_Pointer
            .rgSABound(0).cElements = m_Height
            .rgSABound(1).cElements = m_Width * 4&
        End With
        CopyMemory ByVal VarPtrArray(gBytes), VarPtr(tSA), 4&
        
        Select Case Formula ' note: when adding your own formulas, ensure they add up to 1.0
        Case gsclSimpleAvg
            R = 0.333: G = 0.334: B = R
        Case gsclNTSCPAL
            R = 0.299: G = 0.587: B = 0.114
        Case Else   ' Formula.CCIR 709
            R = 0.213: G = 0.715: B = 0.072
        End Select
        
        For Y = 0& To m_Height - 1&
            For X = 0& To m_Width * 4& - 1& Step 4&
                gBytes(X, Y) = ((0& + (gBytes(X, Y) * B) + (gBytes(X + 1, Y) * G) + (gBytes(X + 2, Y) * R)) * 255&) \ 255
                gBytes(X + 1, Y) = gBytes(X, Y)
                gBytes(X + 2, Y) = gBytes(X, Y)
            Next
        Next
        
        CopyMemory ByVal VarPtrArray(gBytes), 0&, 4&
        
        MakeGrayScale = True
        
    End If
    
End Function

Friend Sub SetOriginalFormat(inStream() As Byte)

    ' Purpose: Pass the original image file/bytes to this DIB from another DIB
    ' This is only called by the CopyImageTo function. Note it is Friend vs Public
    
    m_ImageByteCache() = inStream()

End Sub

Private Function LoadPictureEx(FileName As String, aStream() As Byte, _
                            cx As Long, cy As Long, _
                            streamOffset As Long, streamLength As Long, _
                            Optional SaveFormat As Boolean = False) As Boolean
    
    ' PURPOSE: Marshal passed file/array to image classes for conversion to 32bpp image
    ' For parameter information, see LoadPicture_File & LoadPicture_Stream
    
    Me.DestroyDIB
    
    If Not FileName = vbNullString Then ' file name was passed
        
        Dim fileNum As Integer
        On Error Resume Next
        
        fileNum = FreeFile()    ' attempt to open file with read access only
        Open FileName For Binary Access Read As #fileNum
        ' if successful, we will use it later
        If Err Then
            Close #fileNum
            Err.Clear
            Exit Function
        End If
    End If
    
    ' various image parsers, in order of precedence
    ' All 4 recognize transparency
    Dim cPNG As cPNGParser  ' very fast to abort if not a PNG file
    Dim cGIF As cGIFParser  ' very fast to abort if not a GIF file
    Dim cICO As cICOParser  ' must parse key parts of a file. handles icons & Vista PNG Icons
    Dim cBMP As cBMPParser  ' catchall. Handles bitmaps, wmf, emf & jpgs
    
    Dim bReturn As Boolean  ' function return value
    
    ' validate passed desired icon sizes
    If cx < 0& Then cx = 0&
    If cy < 0& Then cy = 0&
    
    Set cPNG = New cPNGParser   ' see if image is a PNG; aborts quickly if not
    If FileName = vbNullString Then
        bReturn = cPNG.LoadStream(aStream(), Me, streamOffset, streamLength)
    Else     ' note: processing from file is slightly faster than via array
        bReturn = cPNG.LoadFile(FileName, Me)
        If bReturn = True Then Close #fileNum         ' close the file
    End If
    If Err Then MsgBox Err.Description
    Set cPNG = Nothing
    If Not bReturn Then
        If Not FileName = vbNullString Then
            streamOffset = 0&
            streamLength = LOF(fileNum) ' cache length of file
            ReDim aStream(streamOffset To streamLength - 1&)
            Get #fileNum, , aStream()   ' populate our stream with the file contents
            Close #fileNum
        End If
        Set cGIF = New cGIFParser ' what about a GIF; aborts quickly if not
        bReturn = cGIF.LoadStream(aStream(), Me, streamOffset, streamLength)
        Set cGIF = Nothing
        If Not bReturn Then
            Set cICO = New cICOParser   ' will process Vista PNG icon if needed
            bReturn = cICO.LoadStream(aStream(), cx, cy, Me, streamOffset, streamLength)
            Set cICO = Nothing
            If Not bReturn Then ' check for bmp, emf, wmf & jpg << last chance
                Set cBMP = New cBMPParser
                bReturn = cBMP.LoadStream(aStream(), Me, streamOffset, streamLength)
                Set cBMP = Nothing
            End If
        End If
    End If
    If Not m_Handle = 0 Then
        If SaveFormat = True Then ' we will cache the original bytes
            If iparseIsArrayEmpty(Not aStream) = True And Not FileName = vbNullString Then
                ' we loaded the image from the file and not a stream (PNG), need to get stream
                fileNum = FreeFile()
                Open FileName For Binary Access Read As #fileNum
                ReDim m_ImageByteCache(0 To LOF(fileNum) - 1)
                Get #fileNum, 1, m_ImageByteCache
                Close #fileNum
            Else
                m_ImageByteCache() = aStream()
            End If
        End If
        LoadPictureEx = True
    End If
    
End Function


Private Function pvResize(ByVal destBMP As Long, _
                        rSizedBytes() As Byte, rMirror() As Byte, _
                        Optional tHost As c32bppDIB, _
                        Optional ByVal srcX As Long, Optional ByVal scrY As Long, _
                        Optional ByVal srcWidth As Long, Optional ByVal srcHeight As Long, _
                        Optional ByVal destX As Long, Optional ByVal destY As Long, _
                        Optional destWidth As Long, Optional destHeight As Long) As Boolean
                            
    ' Function resizes an alpha image, maintaining premultiplied pixels & alpha values
    ' Code originally by Carles P.V. but significantly modified for this project.
    
    ' Parameters:
    ' destBMP :: handle to the bitmap within the target DC
    ' rSizedbytes() : array to hold resized alpha section; not used if tHost is not Nothing
    ' tHost : when resizing to another DIB class, the destination DIB class
    ' srcX,Y : the coordinates of the source image to start resizing from
    ' srcWidth,srcHeight : the width/height of the source image to resize from
    ' destX,Y : the coordinates of the destination image to resize to
    ' destWidth,destHeight : the width/height of the destination image to resize to

    If srcWidth = 0& Then srcWidth = m_Width
    If srcHeight = 0& Then srcHeight = m_Height

    Dim aNewBits() As Byte, dSA As SafeArray   ' new size, overlay of DIB pointer
    Dim aOldBits() As Byte, tSA As SafeArray   ' old size, overlay of DIB pointer
    
    Dim xLUdbl() As Double                     ' look up table (LUT)
    Dim xRatio As Double, yRatio As Double     ' scaled ratios
    Dim srcPixel As Long, dstPixel As Long     ' source/destination pixel locations
    Dim lCol As Long, lRow As Long             ' loop variables
    
    Dim newWidth As Long, newHeight As Long
    Dim tBMP As BITMAP
    
    ' following used with BiLinear scaling
    Dim fX As Double, fY As Double
    Dim tgtX As Long, tgtY As Long
    Dim edgeOffsetX As Long, edgeOffsetY As Long
    Dim iX As Long, iY As Long
    Dim R As Double, G As Double, B As Double, A As Double
    Dim scalerX As Double, scalerY As Double
    
    ' fill in opitonal parameters
    If Not tHost Is Nothing Then
        newWidth = tHost.Width
        newHeight = tHost.Height
        ' Scaling ratio (ratio of actual image to scaled image)
        xRatio = srcWidth / newWidth
        yRatio = srcHeight / newHeight
    Else
        newWidth = Abs(destWidth)
        newHeight = Abs(destHeight)
        GetGDIObject destBMP, Len(tBMP), tBMP   ' additional checks when drawing to DC
        If tBMP.bmWidth = 0& Then
            ' The .bmWidth can be null in two cases:
            ' 1. We are resizing directly to another DIB class
            ' 2. The target DC is a VB DC with AutoRedraw=False
            tBMP.bmWidth = Abs(destX) + newWidth   ' Reszing from Class to Class
            tBMP.bmHeight = Abs(destY) + newHeight ' set these to actual Class sizes
        End If
        ' Scaling ratio (ratio of actual image to scaled image)
        xRatio = srcWidth / newWidth
        yRatio = srcHeight / newHeight
    
        ' safety checks, recalculation of bounding destination size
        ' if not done, we could very easily access unallocated memory.
        If destX < 0 Then   ' negative DC offset
            newWidth = newWidth + destX    ' reduce width to process
            destX = -destX                    ' used to offset LUT; adjust so not processing bytes not used
        ElseIf newWidth + destX > tBMP.bmWidth Then
            newWidth = tBMP.bmWidth - destX ' reduce width to process
            destX = 0&                        ' will not offset LUT
        Else
            destX = 0&                        ' fits within destination bitmap; no offsetting needed
        End If
        ' final check, even with the offsets, the source can still be larger than the target, check it
        If newWidth > tBMP.bmWidth Then newWidth = tBMP.bmWidth
        
        ' now to check the vertical
        If destY < 0& Then  ' negative DC offset
            newHeight = newHeight + destY
            destY = 0&
        ElseIf destY + newHeight > tBMP.bmHeight Then
            lRow = newHeight
            newHeight = tBMP.bmHeight - destY
            destY = lRow - newHeight
        Else
            destY = 0&
        End If
        ' final check, even with the offsets, the source can still be larger than the target, check it
        If newHeight > tBMP.bmHeight Then
            lRow = newHeight            ' but with bottom up dibs, we adjust from the bottom
            newHeight = tBMP.bmHeight
            destY = lRow - newHeight
        End If
        
    End If
    If newHeight < 1& Or newWidth < 1& Then Exit Function
    
    With dSA    ' overlay destination array onto the passed Byte() array
        .cbElements = 1
        .cDims = 2
        .rgSABound(0).cElements = newHeight
        .rgSABound(1).cElements = newWidth * 4&
        If tHost Is Nothing Then
            ReDim rSizedBytes(0& To .rgSABound(1).cElements - 1&, 0& To newHeight - 1&)
            .pvData = VarPtr(rSizedBytes(0&, 0&))
        Else
            .pvData = tHost.BitsPointer ' called by CopyImageTo & Resize routines
        End If
    End With
    
    With tSA    ' overlay source array onto our DIB
        .cbElements = 1
        .cDims = 2
        If iparseIsArrayEmpty(Not rMirror) Then
            .pvData = m_Pointer                     ' source is our DIB
            .rgSABound(0).cElements = m_Height
            .rgSABound(1).cElements = m_Width * 4&
        Else
            .pvData = VarPtr(rMirror(0&, 0&))           ' source is the mirrored DIB; clipped as needed
            .rgSABound(0).cElements = UBound(rMirror, 2) + 1&
            .rgSABound(1).cElements = UBound(rMirror, 1) + 1&
        End If
    End With
    
    CopyMemory ByVal VarPtrArray(aNewBits), VarPtr(dSA), 4&
    CopyMemory ByVal VarPtrArray(aOldBits), VarPtr(tSA), 4&
    
    On Error GoTo eh
    
    scrY = UBound(aOldBits, 2) - srcHeight - scrY + 1&     ' adjust Y position in source for bottom up DIBs
    If (m_StretchQuality = False) Then
        
        ' Scaling LUT, cache actual X position of DIB in relation to scaled X
        ' Cache one scan line of X coords so we don't have to calculate for every pixel
        ReDim xLUdbl(0 To newWidth - 1&)
        For lCol = 0 To newWidth - 1&
            ' offset destX used for negative coordinates, X is location in source to start blending at
            xLUdbl(lCol) = Int(((lCol + destX) * xRatio) + srcX) * 4&
        Next
        
        ' nearest neighbor algorithm
        For lRow = newHeight - 1& To 0& Step -1&
            '^ current scanline for the scaled image
            ' offset destY is used for negative coordinates
            srcPixel = Int((lRow + destY) * yRatio) + scrY  ' recalcualted once per scanline
            ' current scanline for the scaled image
            dstPixel = 0&
            For lCol = 0& To newWidth - 1&
                ' copy into resized array the nearest raw/actual pixel
                CopyMemory aNewBits(dstPixel, lRow), aOldBits(Int(xLUdbl(lCol)), srcPixel), 4&
                dstPixel = dstPixel + 4&
            Next lCol
        Next lRow
        
    Else
        
        ' BiLinear interoplation, up to 4 source pixels (16 bytes) are blended for each destination pixel (4 bytes)
 
        ReDim xLUd(0 To newWidth - 1&)   ' work with doubles, we need the decimal portions
        ' Cache one scan line of X coords so we don't have to calculate for every pixel
        For lCol = 0& To newWidth - 1&
            ' offset destX used for negative coordinates, X is location in source to start blending at
            xLUd(lCol) = (((lCol + destX) * xRatio) + srcX)
        Next
        srcWidth = srcWidth - 1& ' subtract now vs subtracting in loop below
        destY = destY + 1
        For lRow = newHeight - 1& To 0& Step -1&
            
            fY = (lRow + destY) * yRatio + scrY ' get the scaled source row
            tgtY = Int(fY)              ' get whole number of double
            If tgtY = 0& Then         ' for top down images, test for last row vs 0
                ' last row of source image, will use only this row
                edgeOffsetY = 0&
                fY = 0#
            Else
                ' will use this row & next row for blending
                edgeOffsetY = 1&
                fY = Abs(1# - (fY - tgtY)) ' for top down images, use fY = fY-tgtY
                ' ^ Y coordinate fraction; pct of next vertical pixel that is used
            End If
            
            For lCol = 0& To newWidth - 1&
                
                R = 0#: G = 0#: B = 0#: A = 0#
                
                tgtX = Int(xLUd(lCol))  ' coordinate rounded down to whole number
                If tgtX = srcWidth Then
                    ' at far edge of source image, will use only this pixel for blending
                    edgeOffsetX = 0&
                    fX = 0#
                Else
                    ' will use this pixel and next pixel for blending
                    edgeOffsetX = 1&
                    fX = xLUd(lCol) - tgtX
                    ' ^ X coordinate fraction, pct of next horizontal pixel that is used
                End If
                
                For iY = 0& To edgeOffsetY
    
                    scalerY = Abs(iY - fY)   ' percentage of current row's pixel to blend
                    If Not scalerY = 1# Then  ' else result will be zero
                    
                        For iX = 0& To edgeOffsetX
                            scalerX = Abs(fX - iX)   ' percentage of current column's pixel to blend
                            
                            If Not scalerX = 1# Then  ' else result will be zero
                                scalerX = (1# - scalerX) * (1# - scalerY) ' combine percentages
    
                                ' Build the blended RGB values, for top down images Add iY vs subtracting
                                srcPixel = (tgtX + iX) * 4&
                                B = B + aOldBits(srcPixel, tgtY - iY) * scalerX
                                G = G + aOldBits(srcPixel + 1&, tgtY - iY) * scalerX
                                R = R + aOldBits(srcPixel + 2&, tgtY - iY) * scalerX
                                A = A + aOldBits(srcPixel + 3&, tgtY - iY) * scalerX
    
                            End If
                        Next
                    End If
                Next
                iX = lCol * 4&
                ' update destination with adjusted pixel
                aNewBits(iX, lRow) = Int(B)
                aNewBits(iX + 1&, lRow) = Int(G)
                aNewBits(iX + 2&, lRow) = Int(R)
                aNewBits(iX + 3&, lRow) = Int(A)
            Next
        Next
    End If
    
    CopyMemory ByVal VarPtrArray(aOldBits), 0&, 4&
    CopyMemory ByVal VarPtrArray(aNewBits), 0&, 4&
    
    ' the passed destWidth,destHeight params are used when rendering; we are just sizing now
    destWidth = newWidth ' the parameter is ByRef, update it now
    destHeight = newHeight ' the parameter is ByRef, update it now
    Erase rMirror()
    pvResize = True
eh:
    If Err Then
        If Err.Number = 16 Then ' expression too complex. Why I get this, I don't understand
            Err.Clear
            Resume
        Else
            Err.Clear   ' troubleshooting only, should be removed before compiling to final app
            Stop
            Resume
        End If
    End If
End Function

Private Function Win9xBlend(ByVal destBMP As Long, ByVal destinationDC As Long, aResizedBytes() As Byte, _
                            ByVal srcX As Long, ByVal srcY As Long, _
                            ByVal destX As Long, ByVal destY As Long, _
                            ByVal destWidth As Long, ByVal destHeight As Long, _
                            ByVal GlobalAlpha As Long, Optional tHost As c32bppDIB)

    ' Parameters identify the destination more than anything else. The source was already pre-processed if needed
    
    ' destBMP :: handle to the bitmap within the target DC
    ' destinationDC :: DC to blend to
    ' aResizedBytes() :: array of bytes sized to target destination blend area.
    '   if array is null, then the destination size is same size as our DIB's image
    ' srcX,Y :: the position on source to begin blending; only used if aResizedBytes() is null
    ' destX,Y :: the position on destination where blending starts
    ' destWidth,Height :: the amount of columns/rows to blend
    ' globalAlpha :: the AlphaBlend global alpha value: between 0 and 255
    ' tHost (Optional) :: blending will occur DIB to DIB vs DIB to DC

    ' Function blends an alpha bitmap to a target DC
    
    Dim dstBytes() As Byte, dstSA As SafeArray
    Dim srcBytes() As Byte, srcSA As SafeArray
    Dim srcCol As Long, srcRow As Long
    Dim srcAlpha As Long, dstAlpha As Long
    Dim Y As Long, X As Long
    Dim sX As Long, sY As Long
    Dim dstOffsetX As Long, dstOffsetY As Long
    Dim mirrorOffsetX As Long, mirrorOffsetY As Long
    
    Dim BMPI As BITMAPINFO, tBMP As BITMAP
    Dim hDib As Long, hDIBptr As Long
    Dim dDC As Long, hOldObj As Long
    
    ' The following is just a wee bit confusing.
    ' Our source can be 2 different objects:
    '   1) Our host DIB if the rendering results with no stretching
    '   2) The passed aResizedBytes() array if stretching was involved
    ' Likewise, the destination can be 2 different objects
    '   1) A passed DC handle
    '   2) Another DIB class if tHost is passed
    ' So to use a common base for all possibilities, we use SafeArrays
    
    With srcSA
        .cbElements = 1
        .cDims = 2
        If destWidth < 0 Then           ' handle horizontal mirroring
            destWidth = -destWidth
            mirrorOffsetX = 1           ' flag to be used later
        End If
        If destHeight < 0 Then          ' handle vertical mirroring
            destHeight = -destHeight
            mirrorOffsetY = 1           ' flag to be used later
        End If
        If iparseIsArrayEmpty(Not aResizedBytes) Then
            .rgSABound(0).cElements = m_Height      ' source is our host DIB
            .rgSABound(1).cElements = m_Width * 4   ' srcX and srcY will be used for offsets
            .pvData = m_Pointer
            ' need to tweak for negative offsets
            If destX < 0 Then
                srcX = srcX - destX ' less area that needs to be rendered
                destWidth = destWidth + destX ' adjust amount of destination we copy
                destX = 0                     ' set destination offset to zero
            End If
            If destY < 0 Then
                srcY = srcY - destY ' less area that needs to be rendered
                destHeight = destHeight + destY ' adjust amount of destination we copy
                destY = 0                       ' set destination offset to zero
            End If
            srcY = m_Height - srcY  ' set DIB offset for 1st row to be blended
            
            ' now to validate destination width in relation to target's image
            GetGDIObject destBMP, Len(tBMP), tBMP
            ' The .bmWidth can be null when the target DC is a VB DC with AutoRedraw=False
            If Not tBMP.bmWidth = 0 Then
                ' if target width exceeds bitmap dimensions, we can reduce even more
                If destX + destWidth > tBMP.bmWidth Then destWidth = tBMP.bmWidth - destX
                If destY + destHeight > tBMP.bmHeight Then destHeight = tBMP.bmHeight - destY
            End If
            
        Else                                        ' source is the resized array
            .rgSABound(0).cElements = destHeight    ' source offsets are always zero,last row
            .rgSABound(1).cElements = destWidth * 4 ' size/contents of array validated during pvResize
            .pvData = VarPtr(aResizedBytes(0, 0))
            If destX < 0 Then destX = 0 ' when negative target coords are used, we set to
            If destY < 0 Then destY = 0 ' zero to match the resized array (zero-based)
            srcX = 0: srcY = destHeight
       End If
    End With
    If destWidth < 1 Or destHeight < 1 Then Exit Function   ' nothing to Blt, passed bad params
    
    If tHost Is Nothing Then
        ' we need the contents of the target DC first
        With BMPI.bmiHeader
            .biBitCount = 32
            .biHeight = destHeight
            .biWidth = destWidth
            .biPlanes = 1
            .biSize = 40
            .biSizeImage = .biHeight * .biWidth * 4&
        End With
        ' create a dib section passing the return pointer
        hDib = CreateDIBSection(destinationDC, BMPI, 0, hDIBptr, 0, 0)
        If hDib = 0 Then Exit Function
        
        ' now create a DC and select the DIB into it so we can copy the DC contents
        dDC = CreateCompatibleDC(destinationDC)
        hOldObj = SelectObject(dDC, hDib)
        BitBlt dDC, 0, 0, destWidth, destHeight, destinationDC, destX, destY, vbSrcCopy
        SelectObject dDC, hOldObj
    
        With dstSA              ' overlay the destination bytes onto the DIB we just created
            .cbElements = 1
            .cDims = 2
            .rgSABound(0).cElements = destHeight
            .rgSABound(1).cElements = destWidth * 4
            .pvData = hDIBptr
        End With
    
    Else
        ' DIB class to DIB class blending; not yet implemented, still testing idea
        With dstSA              ' overlay on the target DIB section
            .cbElements = 1
            .cDims = 2
            .rgSABound(0).cElements = tHost.Height
            .rgSABound(1).cElements = tHost.scanWidth * 4
            .pvData = tHost.BitsPointer
        End With
        dstOffsetX = destX * 4  ' set offsets on target DIB
        dstOffsetY = destY
    
    End If
    
    CopyMemory ByVal VarPtrArray(srcBytes), VarPtr(srcSA), 4&
    CopyMemory ByVal VarPtrArray(dstBytes), VarPtr(dstSA), 4&
                    
    On Error Resume Next ' expected errors? using a corrupted pre-multiplied image possibly, but will just draw wrong
    
    If mirrorOffsetY = 1 Then
        srcY = -1           ' handle horizontal mirroring
        mirrorOffsetY = 1
    Else
        mirrorOffsetY = -1
    End If
    If mirrorOffsetX = 1 Then mirrorOffsetX = (srcX + destWidth - 1) * 4
    srcX = srcX * 4 ' any offset needs to be multiplied by bpp
    
    For srcRow = destHeight - 1 To 0 Step -1
    
        ' offset our DIB row as we go
        srcY = srcY + mirrorOffsetY  ' handle vertical mirroring
        
        If GlobalAlpha = &HFF& Then
            
            ' with full opaqueness, use separate loop, less calculations
            For srcCol = 0 To destWidth * 4 - 1 Step 4
             
                 sX = Abs(srcX + srcCol - mirrorOffsetX) ' adjusted column of source image
                 srcAlpha = srcBytes(sX + 3, srcY) ' get its alpha value
                 
                 If (srcAlpha = &HFF&) Then
                     ' copy pixel to destination, adjusting for destination row/column as needed
                     CopyMemory dstBytes(srcCol + dstOffsetX, srcRow + dstOffsetY), srcBytes(sX, srcY), &H3
                     
                 ElseIf Not srcAlpha = &H0 Then
                     
                     '-- Blend
                     X = dstOffsetX + srcCol    ' adjusted column of destination image
                     Y = dstOffsetY + srcRow    ' adjusted row of destination image
                     
                                dstAlpha = &HFF - srcAlpha ' calculate dest alpha value
                                dstBytes(X, Y) = (dstAlpha * dstBytes(X, Y)) \ &HFF + srcBytes(sX, srcY)
                     X = X + 1: dstBytes(X, Y) = (dstAlpha * dstBytes(X, Y)) \ &HFF + srcBytes(sX + 1, srcY)
                     X = X + 1: dstBytes(X, Y) = (dstAlpha * dstBytes(X, Y)) \ &HFF + srcBytes(sX + 2, srcY)
                 End If
             Next
        
        Else
            ' global alpha and per-pixel blending
            For srcCol = 0 To destWidth * 4 - 1 Step 4
                
                 sX = Abs(srcX + srcCol - mirrorOffsetX) ' adjusted column of source image
                 srcAlpha = srcBytes(sX + 3, srcY) ' get its alpha value
                 
                 If Not srcAlpha = 0& Then
                     '-- Blend
                     X = dstOffsetX + srcCol    ' adjusted column of destination image
                     Y = dstOffsetY + srcRow    ' adjusted row of destination image
                     
                     ' following formula is for already pre-multiplied bytes
                                dstAlpha = &HFF& - ((srcAlpha * GlobalAlpha) \ &HFF&)
                                dstBytes(X, Y) = (dstAlpha * (dstBytes(X, Y)) + (srcBytes(sX, srcY) * GlobalAlpha)) \ &HFF
                     X = X + 1: dstBytes(X, Y) = (dstAlpha * (dstBytes(X, Y)) + (srcBytes(sX + 1, srcY) * GlobalAlpha)) \ &HFF
                     X = X + 1: dstBytes(X, Y) = (dstAlpha * (dstBytes(X, Y)) + (srcBytes(sX + 2, srcY) * GlobalAlpha)) \ &HFF
                 End If
             Next
        
        End If
    Next
    ' remove overlays
    CopyMemory ByVal VarPtrArray(srcBytes), 0&, 4&
    CopyMemory ByVal VarPtrArray(dstBytes), 0&, 4&
    
    If Not hDib = 0& Then
        ' clean up if we were blending to a DC & send our work to that DC
        hOldObj = SelectObject(dDC, hDib)
        BitBlt destinationDC, destX, destY, destWidth, destHeight, dDC, 0&, 0&, vbSrcCopy
        DeleteObject SelectObject(dDC, hOldObj)
        DeleteDC dDC
    End If
    
    Win9xBlend = True


End Function

Private Sub MirrorDIB(ByRef srcX As Long, ByRef srcY As Long, _
                    ByVal srcWidth As Long, ByVal srcHeight As Long, _
                    ByRef newWidth As Long, ByRef newHeight As Long, _
                    ByRef mirrorBytes() As Byte, Optional ByRef tHost As c32bppDIB)

    ' through trial and error, the rule, for mirroring images, appears to be valid for
    ' Windows drawing routines are:  Flip first, then stretch and/or rotate, then clip as needed
    
    ' For manual rendering, this has the potential of really complex offsets whether or not
    ' the pixels are read left to right, right to left, top to bottom or vice versa. Not
    ' to mention rotation and/or scaling and offsets whether or not image is to be clipped
    ' because it is being rendered at negative X,Y coordinates or the image is clipped
    ' because its scaled size is too big for the destination bitmap area. So, we will
    ' not precalculate all the possible combinations of offsets in the manual rendering
    ' routines, rather we will flip first, then allow rendering routines to process as normal.
    
    ' srcX,Y :: position in source image where mirroring begins
    ' srcWidth,Height :: amount of source image that will be mirrored
    ' newWidth,Height :: size of destination mirrored image
    ' mirrorBytes() :: byte array to hold mirrored image
    ' tHost :: called by CopyImageTo & Resize when mirroring
    
    ' is image being mirrored?
    If newWidth > 0& And newHeight > 0& Then Exit Sub
    
    Dim tSA As SafeArray, srcBytes() As Byte
    Dim dSA As SafeArray, dstBytes() As Byte
    Dim X As Long, Y As Long, yOffset As Long, xOffset As Long
    
    With tSA    ' overlay array on our source DIB
        .cbElements = 1
        .cDims = 2
        .pvData = m_Pointer
        .rgSABound(0).cElements = m_Height
        .rgSABound(1).cElements = m_Width * 4&
    End With
    
    With dSA    ' overlay array on our destination object
        .cbElements = 1
        .cDims = 2
        If tHost Is Nothing Then    ' destination is mirrorBytes
            ReDim mirrorBytes(0& To srcWidth * 4& - 1&, 0& To srcHeight - 1&)
            .pvData = VarPtr(mirrorBytes(0&, 0&))
        Else                        ' destination is passed DIB class
            .pvData = tHost.BitsPointer ' called by CopyImageTo & Resize routines
        End If
        .rgSABound(0).cElements = srcHeight
        .rgSABound(1).cElements = srcWidth * 4&
    End With
    
    CopyMemory ByVal VarPtrArray(srcBytes), VarPtr(tSA), 4&
    CopyMemory ByVal VarPtrArray(dstBytes), VarPtr(dSA), 4&
    
    If newHeight < 0& Then
        If newWidth > 0& Then   ' flipping vertically only, faster/easier
            xOffset = srcWidth * 4& ' number of bytes to flip at once
            Y = srcY    ' when flipping, our Y is adjusted from the bottom
            X = srcX * 4&   ' starting X position in source
            For yOffset = srcHeight - 1& To 0& Step -1&
                CopyMemory dstBytes(0&, yOffset), srcBytes(X, Y), xOffset
                Y = Y + 1&   ' move source Y to next row
            Next
        Else   ' flipping both vertically/horizontally
            Y = srcY ' when flipping vertically, adjust from the bottom
            For yOffset = srcHeight - 1& To 0& Step -1&
                X = (m_Width - srcX) * 4& - 4&  ' X adjusted from right when flipping
                For xOffset = 0 To srcWidth * 4 - 4& Step 4&
                    CopyMemory dstBytes(xOffset, yOffset), srcBytes(X, Y), 4&
                    X = X - 4&  ' move source X to next pixel
                Next
                Y = Y + 1&   ' move source Y to next row
            Next
        End If
    
    Else  ' flipping horizontally only, same comments as above
        Y = m_Height - srcY - 1& ' not fipping vertically, so read from bottom up
        For yOffset = srcHeight - 1& To 0& Step -1&
            X = (m_Width - srcX) * 4& - 4&
            For xOffset = 0 To srcWidth * 4 - 4& Step 4&
                CopyMemory dstBytes(xOffset, yOffset), srcBytes(X, Y), 4&
                X = X - 4&
            Next
            Y = Y - 1&
        Next
    End If
    CopyMemory ByVal VarPtrArray(srcBytes), 0&, 4&
    CopyMemory ByVal VarPtrArray(dstBytes), 0&, 4&
    
    ' any rendering routines will now use the mirrored byte array
    ' so we ensure the bounds parameters match the mirrored array bounds
    srcX = 0&
    srcY = 0&
    newWidth = Abs(newWidth)
    newHeight = Abs(newHeight)
    
End Sub

Private Sub Class_Initialize()

    ' NOTE: m_os9x no longer used in this class as of Change 30 Jan 07
    '       replaced with m_osCAP & meaning is different
    
    ' Determine operating system for compatibility of 32bpp images
    ' http://vbnet.mvps.org/code/helpers/iswinversion.htm
    ' http://msdn2.microsoft.com/en-gb/library/ms724834.aspx
    
   Dim osType As OSVERSIONINFOEX
   ' Retrieve version data for OS.
   osType.dwOSVersionInfoSize = Len(osType)
   If GetVersionEx(osType) = 0 Then
      ' The OSVERSIONINFOEX structure is only supported
      ' in NT4/SP6+ and NT5.x, so we're likely running
      ' on an earlier version of Windows. Revert structure
      ' size to OSVERSIONINFO and try again.
      osType.dwOSVersionInfoSize = Len(osType) - 8
      Call GetVersionEx(osType)
   End If
   
    ' when m_os9X=0 then we have no AlphaBlend conflicts that we know of
    If osType.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS Then
    ' windows 9x
        Select Case osType.dwMinorVersion
        Case 0  ' win 95
            'm_os9x = 1  ' AlphaBlend not supported, nor exists on 95
        Case 10 ' win 98 (when build > 1998 then SE)
            'm_os9x = 2 ' can crash when AlphaBlending DIB to DIB within memory DCs
        Case Else ' 90 winME
            'm_os9x = 3 ' untested; don't have ME to see if AlphaBlend is buggy there too
        End Select
    Else
        ' need to test for NT4 too.
        If osType.dwMajorVersion < 5 Then ' NT4 or lower
            'm_os9x = 1 ' treat as if Win95, NT4 was not shipped with msimg32.dll
        Else
            m_osCAP = 1
        End If
    End If
    
    Me.isGDIplusEnabled = True  ' attempt to start GDI+, test system capability
    If Me.isGDIplusEnabled Then Me.HighQualityInterpolation = True
    
End Sub

Private Sub Class_Terminate()
    DestroyDIB ' simply clean up
End Sub
