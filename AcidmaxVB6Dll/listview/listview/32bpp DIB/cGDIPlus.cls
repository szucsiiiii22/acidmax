VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cGDIPlus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

' No APIs are declared public. This is to prevent possibly, differently
' declared APIs, or different versions of the same API, from conflciting
' with any APIs you declared in your project. Same rule for UDTs.
' Note: I did take some liberties in several API declarations throughout


' following are used for saving dib to PNG (testing phase only)
Private Declare Function GdipImageRotateFlip Lib "gdiplus" (ByVal Image As Long, ByVal rfType As Long) As Long
Private Declare Function GdipCreateBitmapFromScan0 Lib "gdiplus" (ByVal Width As Long, ByVal Height As Long, ByVal stride As Long, ByVal PixelFormat As Long, scan0 As Any, BITMAP As Long) As Long
Private Declare Function GdipCreateBitmapFromGdiDib Lib "gdiplus" (gdiBitmapInfo As BITMAPINFO, gdiBitmapData As Any, BITMAP As Long) As Long
Private Declare Function lstrlenW Lib "kernel32" (ByVal psString As Any) As Long
Private Declare Function GdipGetImageEncodersSize Lib "gdiplus" (numEncoders As Long, Size As Long) As Long
Private Declare Function GdipGetImageEncoders Lib "gdiplus" (ByVal numEncoders As Long, ByVal Size As Long, Encoders As Any) As Long
Private Declare Function GdipSaveImageToFile Lib "gdiplus" (ByVal hImage As Long, ByVal sFilename As String, clsidEncoder As Any, encoderParams As Any) As Long
Private Declare Function GdipSaveImageToStream Lib "gdiplus" (ByVal Image As Long, ByVal Stream As IUnknown, clsidEncoder As Any, encoderParams As Any) As Long
Private Enum EncoderParameterValueType
    [EncoderParameterValueTypeByte] = 1
    [EncoderParameterValueTypeASCII] = 2
    [EncoderParameterValueTypeShort] = 3
    [EncoderParameterValueTypeLong] = 4
    [EncoderParameterValueTypeRational] = 5
    [EncoderParameterValueTypeLongRange] = 6
    [EncoderParameterValueTypeUndefined] = 7
    [EncoderParameterValueTypeRationalRange] = 8
End Enum
Private Type EncoderParameter
    GUID(0 To 3)   As Long
    NumberOfValues As Long
    Type           As EncoderParameterValueType
    Value          As Long
End Type
'-- Encoder Parameters structure
Private Type EncoderParameters
    Count     As Long
    Parameter As EncoderParameter
End Type
Private Type ImageCodecInfo
    ClassID(0 To 3)   As Long
    FormatID(0 To 3)  As Long
    CodecName         As Long
    DllName           As Long
    FormatDescription As Long
    FilenameExtension As Long
    MimeType          As Long
    Flags             As Long
    Version           As Long
    SigCount          As Long
    SigSize           As Long
    SigPattern        As Long
    SigMask           As Long
End Type

Private Declare Function GdipSetInterpolationMode Lib "gdiplus" (ByVal hGraphics As Long, ByVal Interpolation As Long) As Long
Private Declare Function GdipTranslateWorldTransform Lib "gdiplus" (ByVal graphics As Long, ByVal dX As Single, ByVal dY As Single, ByVal Order As Long) As Long
Private Declare Function GdipRotateWorldTransform Lib "gdiplus" (ByVal graphics As Long, ByVal Angle As Single, ByVal Order As Long) As Long
Private Declare Function GdipCreateImageAttributes Lib "gdiplus" (ByRef imgAttr As Long) As Long
Private Declare Function GdipSetImageAttributesColorMatrix Lib "gdiplus" (ByVal imgAttr As Long, ByVal clrAdjust As Long, ByVal clrAdjustEnabled As Long, ByRef clrMatrix As Any, ByRef grayMatrix As Any, ByVal clrMatrixFlags As Long) As Long
Private Declare Function GdipDisposeImageAttributes Lib "gdiplus" (ByVal imgAttr As Long) As Long
Private Const ColorAdjustTypeBitmap As Long = 1

Private Const PixelFormat32bppARGB As Long = &H26200A
Private Const PixelFormat32bppPARGB As Long = &HE200B
Private Const InterpolationModeNearestNeighbor As Long = 5
Private Const InterpolationModeHighQualityBicubic As Long = 7

' Following are used only if PNG file is being processed by GDI+
Private Type GdiplusStartupInput
    GdiplusVersion           As Long
    DebugEventCallback       As Long
    SuppressBackgroundThread As Long
    SuppressExternalCodecs   As Long
End Type
Private Declare Function GdiplusStartup Lib "gdiplus" (token As Long, inputbuf As GdiplusStartupInput, Optional ByVal outputbuf As Long = 0) As Long
Private Declare Sub GdiplusShutdown Lib "gdiplus" (ByVal token As Long)
Private Declare Function GdipLoadImageFromFile Lib "gdiplus" (ByVal FileName As String, hImage As Long) As Long
Private Declare Function GdipLoadImageFromStream Lib "gdiplus" (ByVal Stream As IUnknown, Image As Long) As Long
Private Declare Function GdipGetImageBounds Lib "gdiplus.dll" (ByVal nImage As Long, srcRect As RECTF, srcUnit As Long) As Long
Private Declare Function GdipDisposeImage Lib "gdiplus" (ByVal Image As Long) As Long
Private Declare Function GdipCreateFromHDC Lib "gdiplus" (ByVal hDC As Long, hGraphics As Long) As Long
Private Declare Function GdipDeleteGraphics Lib "gdiplus" (ByVal hGraphics As Long) As Long
Private Declare Function GdipDrawImageRectRectI Lib "gdiplus" (ByVal hGraphics As Long, ByVal hImage As Long, ByVal dstX As Long, ByVal dstY As Long, ByVal dstWidth As Long, ByVal dstHeight As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal srcWidth As Long, ByVal srcHeight As Long, ByVal srcUnit As Long, Optional ByVal imageAttributes As Long = 0, Optional ByVal Callback As Long = 0, Optional ByVal CallbackData As Long = 0) As Long
Private Declare Function GdipGetImagePixelFormat Lib "gdiplus" (ByVal Image As Long, PixelFormat As Long) As Long
Private Const UnitPixel As Long = 2&
Private Type RECTF
    nLeft As Single
    nTop As Single
    nWidth As Single
    nHeight As Single
End Type

' used for workaround of VB not exposing IStream interface
Private Declare Function CreateStreamOnHGlobal Lib "ole32" (ByVal hGlobal As Long, ByVal fDeleteOnRelease As Long, ppstm As Any) As Long
Private Declare Function GlobalAlloc Lib "kernel32" (ByVal uFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function GlobalLock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalUnlock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalSize Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GetHGlobalFromStream Lib "ole32" (ByVal ppstm As Long, hGlobal As Long) As Long

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Sub FillMemory Lib "kernel32.dll" Alias "RtlFillMemory" (ByRef Destination As Any, ByVal Length As Long, ByVal Fill As Byte)
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
    bmiColors As Long
End Type

Public Function isGDIplusOk() As Boolean

    ' Function starts GDI+ and returns true if no errors occurred
    Dim gdiToken As Long
    ' does the system have GDI+ on it?
    If iparseValidateDLL("gdiplus.dll", "GdiplusStartup") Then
        isGDIplusOk = InitializeGDIplus(gdiToken, False)
        InitializeGDIplus gdiToken, True
    End If

End Function

Public Function SaveToPNG(FileName As String, outStream() As Byte, cHost As c32bppDIB) As Boolean

    Dim gdiToken As Long
    
    If cHost.Handle = 0 Then Exit Function
    ' does the system have GDI+ on it?
    If iparseValidateDLL("gdiplus.dll", "GdiplusStartup") = False Then Exit Function
    If InitializeGDIplus(gdiToken, False) = False Then Exit Function

    Dim hImg         As Long
    Dim uEncCLSID(0 To 3) As Long
    Dim tBMPI As BITMAPINFO
    Dim IIStream As IUnknown
    
    
    If cHost.Alpha = True Then
        Call GdipCreateBitmapFromScan0(cHost.Width, cHost.Height, cHost.scanWidth, PixelFormat32bppPARGB, ByVal cHost.BitsPointer, hImg)
        ' dib is bottom up, scan0 does top down, so flip it
        GdipImageRotateFlip hImg, 6 ' flip vertically
    Else
        ' upload our DIB as a 24bit image; no Alpha channel used
        With tBMPI.bmiHeader
            .biBitCount = 24
            .biHeight = cHost.Height
            .biWidth = cHost.Width
            .biPlanes = 1
            .biSize = 40
        End With
        GdipCreateBitmapFromGdiDib tBMPI, ByVal cHost.BitsPointer, hImg
    End If
    
    If Not hImg = 0 Then
        On Error Resume Next
        Call pvGetEncoderClsID("image/png", uEncCLSID)
        If FileName = vbNullString Then
            ' create a null stream (IUnknown object)
            Erase outStream
            Set IIStream = CreateStream(outStream)
            ' have GDI+ save the 32bpp image to the IUnknown using the PNG format
            If GdipSaveImageToStream(hImg, IIStream, uEncCLSID(0), ByVal 0&) = 0& Then
                ' now we need to get that array to pass back to client
                ArrayFromStream IIStream, outStream()
                SaveToPNG = True
            End If
        Else
            If iparseFileExists(FileName) Then
                SetAttr FileName, vbNormal
                If Err Then Err.Clear       ' don't care if attr wasn't set
                Kill FileName
            End If
            If Err Then
                Err.Clear               ' do care if we couldn't delete the file
            Else
                SaveToPNG = (GdipSaveImageToFile(hImg, StrConv(FileName, vbUnicode), uEncCLSID(0), ByVal 0&) = 0&)
            End If
        End If
        GdipDisposeImage hImg
    End If
    Call InitializeGDIplus(gdiToken, True)
    
End Function

Private Function pvPtrToStrW(ByVal lpsz As Long) As String
  ' supporting routine for SaveToPNG
  Dim sOut As String
  Dim lLen As Long

    lLen = lstrlenW(lpsz)

    If (lLen > 0) Then
        sOut = StrConv(String$(lLen, vbNullChar), vbUnicode)
        Call CopyMemory(ByVal sOut, ByVal lpsz, lLen * 2)
        pvPtrToStrW = StrConv(sOut, vbFromUnicode)
    End If
End Function

Private Function pvGetEncoderClsID(strMimeType As String, ClassID() As Long) As Long
  ' supporting routine for SaveToPNG
  Dim Num      As Long
  Dim Size     As Long
  Dim lIdx     As Long
  Dim ICI()    As ImageCodecInfo
  Dim Buffer() As Byte
    
    pvGetEncoderClsID = -1 ' Failure flag
    
    '-- Get the encoder array size
    Call GdipGetImageEncodersSize(Num, Size)
    If (Size = 0) Then Exit Function ' Failed!
    
    '-- Allocate room for the arrays dynamically
    ReDim ICI(1 To Num) As ImageCodecInfo
    ReDim Buffer(1 To Size) As Byte
    
    '-- Get the array and string data
    Call GdipGetImageEncoders(Num, Size, Buffer(1))
    '-- Copy the class headers
    Call CopyMemory(ICI(1), Buffer(1), (Len(ICI(1)) * Num))
    
    '-- Loop through all the codecs
    For lIdx = 1 To Num
        '-- Must convert the pointer into a usable string
        If (StrComp(pvPtrToStrW(ICI(lIdx).MimeType), strMimeType, vbTextCompare) = 0) Then
            CopyMemory ClassID(0), ICI(lIdx).ClassID(0), 16& ' Save the Class ID
            pvGetEncoderClsID = lIdx      ' Return the index number for success
            Exit For
        End If
    Next lIdx
    '-- Free the memory
    Erase ICI
    Erase Buffer
End Function

Friend Function RenderGDIplus(cHost As c32bppDIB, ByVal hDC As Long, _
                            ByVal Angle As Long, ByVal Alpha As Long, _
                            ByVal destX As Long, ByVal destY As Long, _
                            ByVal destWidth As Long, ByVal destHeight As Long, _
                            ByVal srcX As Long, ByVal srcY As Long, _
                            ByVal srcWidth As Long, ByVal srcHeight As Long, _
                            ByVal highQuality As Boolean) As Boolean

    
    If Alpha = 0& Then
        RenderGDIplus = True    ' full transparent, nothing to render
        Exit Function
    End If
    
    Dim gdiToken As Long
    If InitializeGDIplus(gdiToken, False) = False Then Exit Function

    Dim hImg         As Long
    Dim hGraphics As Long, hImgAttr As Long
    Dim clrMatrix(0 To 4, 0 To 4) As Single
    Dim mirrorROP As Long, mirrorOffsetX As Long, mirrorOffsetY As Long
    
    ' have GDI+ create a DIB from our host pointer
    Call GdipCreateBitmapFromScan0(cHost.Width, cHost.Height, cHost.scanWidth, PixelFormat32bppPARGB, ByVal cHost.BitsPointer, hImg)
    
    If Not hImg = 0& Then
        
        If GdipCreateFromHDC(hDC, hGraphics) = 0& Then   ' wrap GDI+ around our target DC
            
            If Not hGraphics = 0& Then
                
                ' Interpolation quality? There is a 3rd quality which falls between the following two. It is InterpolationModeHighQualityBilinear
                If highQuality = True Then
                    Call GdipSetInterpolationMode(hGraphics, InterpolationModeHighQualityBicubic)
                Else
                    Call GdipSetInterpolationMode(hGraphics, InterpolationModeNearestNeighbor)
                End If
                
                mirrorOffsetX = 1&                           ' angle rotation offset (X)
                If destHeight < 0& Then
                    destHeight = -destHeight                ' no flipping needed; bottom up dibs are flipped vertically naturally
                    mirrorOffsetY = -1&                      ' reverse angle rotation offset
                Else
                    mirrorROP = 6&                           ' flip vertically
                    mirrorOffsetY = 1&                       ' angle rotation offsets(Y)
                End If
                If destWidth < 0& Then
                    mirrorROP = mirrorROP Xor 4&             ' flip horizontally (mirror horizontally)
                    destWidth = -destWidth
                    mirrorOffsetX = -mirrorOffsetX          ' reverse angle rotation offset
                End If
                
                GdipImageRotateFlip hImg, mirrorROP         ' flip image as needed
                
                If Angle = 0& And Alpha = 100& Then ' no blending and no rotation being used

                    RenderGDIplus = (GdipDrawImageRectRectI(hGraphics, hImg, destX, destY, destWidth, destHeight, srcX, srcY, srcWidth, srcHeight, UnitPixel, hImgAttr, 0&, 0&) = 0&)
                
                Else ' we are blending and/or rotating
                    
                    If GdipCreateImageAttributes(hImgAttr) = 0 Then ' create image attributes for blending/rotating
                        ' Blending?
                        clrMatrix(0, 0) = 1
                        clrMatrix(1, 1) = 1
                        clrMatrix(2, 2) = 1
                        clrMatrix(3, 3) = CSng(Alpha / 100&) ' value between 0 & 1
                        clrMatrix(4, 4) = 1 ' required; cannot be anything else
                        
                        If GdipSetImageAttributesColorMatrix(hImgAttr, ColorAdjustTypeBitmap, -1&, clrMatrix(0, 0), clrMatrix(0, 0), 0&) = 0& Then
                            If Angle = 0& Then   ' blending, not rotating
                                RenderGDIplus = (GdipDrawImageRectRectI(hGraphics, hImg, destX, destY, destWidth, destHeight, srcX, srcY, srcWidth, srcHeight, UnitPixel, hImgAttr, 0&, 0&) = 0&)
                                
                            Else ' rotating & maybe blending... different coordinates system
                            
                                If GdipRotateWorldTransform(hGraphics, CSng(Angle + 180), 0&) = 0& Then
                                    GdipTranslateWorldTransform hGraphics, destX + (destWidth \ 2) * mirrorOffsetX, destY + (destHeight \ 2) * mirrorOffsetY, 1
                                End If
                                RenderGDIplus = (GdipDrawImageRectRectI(hGraphics, hImg, destWidth \ 2, destHeight \ 2, -destWidth, -destHeight, srcX, srcY, srcWidth, srcHeight, UnitPixel, hImgAttr, 0&, 0&) = 0&)
                            End If
                        End If
                        
                        GdipDisposeImageAttributes hImgAttr ' clean up
                        
                    End If
                End If
                    
                GdipDeleteGraphics hGraphics ' clean up
                
            End If
        End If
        
        GdipDisposeImage hImg   ' clean up
        
    End If
    
    Call InitializeGDIplus(gdiToken, True) ' terminate GDI+

End Function

Friend Function GDIplusLoadPNG(FileName As String, pngStream() As Byte, cHost As c32bppDIB) As Boolean
'Exit Function
    ' Purpose: Use GDI+ to load a PNG either by fileName or by array/stream
    ' FileName :: if vbNullString, then the pngStream() array contains the
    '   PNG file else FileName is full path & name of the PNG file
    
    Dim gdiToken As Long
    ' does the system have GDI+ on it?
    If iparseValidateDLL("gdiplus.dll", "GdiplusStartup") = False Then Exit Function
    If InitializeGDIplus(gdiToken, False) = False Then Exit Function
     
    Dim hImage As Long, hGraphics As Long
    Dim tDC As Long, lRtn As Long
    Dim rDimensions As RECTF, pStream As IUnknown
    
    On Error GoTo ExitRoutine
    
    If FileName = vbNullString Then ' we need an array vs file name
        ' hack of my own. Create an IUnknown Stream that has the same properties
        ' and minimum methods needed as the IStream interface which VB does not
        ' expose. Once the stream is created, we have GDI+ load from it
        Set pStream = CreateStream(pngStream())
        If Not pStream Is Nothing Then Call GdipLoadImageFromStream(pStream, hImage)

    Else    ' we use the passed file name; have GDI+ load the file
        Call GdipLoadImageFromFile(StrConv(FileName, vbUnicode), hImage)
    End If
    
    If Not hImage = 0& Then
        ' get size of PNG
        lRtn = GdipGetImageBounds(hImage, rDimensions, UnitPixel)
        If lRtn = 0& Then

            ' build 32bpp
            cHost.InitializeDIB CLng(rDimensions.nWidth), CLng(rDimensions.nHeight)

            ' wrap a GDI+ DC around our DIB's DC
            tDC = cHost.LoadDIBinDC(True)
            lRtn = GdipCreateFromHDC(tDC, hGraphics)
            If lRtn = 0& Then
                ' now draw the PNG into our 32bpp. GDI+ is nice enough to pre-multiply
                ' the RGB values for us during the rendering
                With rDimensions
                    GdipDrawImageRectRectI hGraphics, hImage, 0&, 0&, .nWidth, .nHeight, .nLeft, .nTop, .nWidth, .nHeight, UnitPixel, 0&, 0&, 0&
                End With
                GdipDeleteGraphics hGraphics    ' remove the GDI+ DC wrapper
                hGraphics = 0&
            End If
            cHost.LoadDIBinDC False ' unselect our DIB
        End If

        If lRtn = 0& Then                    ' return results
            GDIplusLoadPNG = True
            Call GdipGetImagePixelFormat(hImage, lRtn)
            GdipDisposeImage hImage             ' destroy the GDI+ image
            cHost.Alpha = (lRtn = PixelFormat32bppARGB Or lRtn = PixelFormat32bppPARGB)
            cHost.ImageType = imgPNG
        Else
            GdipDisposeImage hImage             ' destroy the GDI+ image
            cHost.DestroyDIB
        End If
        hImage = 0&
    End If
        
ExitRoutine:
    If Not gdiToken = 0& Then
        If Not hGraphics = 0& Then GdipDeleteGraphics hGraphics
        If Not hImage = 0& Then GdipDisposeImage hImage
        Call InitializeGDIplus(gdiToken, True)   ' stop GDI+
    End If
End Function


Friend Function MakeGrayScale(cHost As c32bppDIB, ByVal GrayScaleType As Long) As Boolean


    Dim gdiToken As Long
    If InitializeGDIplus(gdiToken, False) = False Then Exit Function

    Dim hImg         As Long
    Dim hGraphics As Long, hImgAttr As Long, tDC As Long
    Dim clrMatrix(0 To 4, 0 To 4) As Single
    
    ' have GDI+ create a DIB from our host pointer
    Call GdipCreateBitmapFromScan0(cHost.Width, cHost.Height, cHost.scanWidth, PixelFormat32bppPARGB, ByVal cHost.BitsPointer, hImg)
    
    If Not hImg = 0& Then
        GdipImageRotateFlip hImg, 6& ' flip vertically. Our DIBs are bottom up but that GDI+ function creates top down dibs
        
        tDC = cHost.LoadDIBinDC(True)   ' ensure we have a DC
        If GdipCreateFromHDC(tDC, hGraphics) = 0& Then ' wrap GDI+ around our target DC
            If Not hGraphics = 0& Then
                
                ' create image attributes and identify how RGB will be multiplied to create GrayScale
                If GdipCreateImageAttributes(hImgAttr) = 0& Then
                    
                    Select Case GrayScaleType
                    Case 1                      ' Formula.NtscPal
                        clrMatrix(0, 0) = 0.299!
                        clrMatrix(0, 1) = 0.587!
                        clrMatrix(0, 2) = 0.114!
                    Case 2                      ' Formula.SimpleAverage
                        clrMatrix(0, 0) = 0.333!
                        clrMatrix(0, 1) = 0.334!
                        clrMatrix(0, 2) = 0.333!
                    Case Else                   ' Formula.CCIRRec709
                        clrMatrix(0, 0) = 0.213! ' r
                        clrMatrix(0, 1) = 0.715! ' g
                        clrMatrix(0, 2) = 0.072! ' b
                    
                    End Select
                    clrMatrix(1, 0) = clrMatrix(0, 0)
                    clrMatrix(2, 0) = clrMatrix(0, 0)
                    clrMatrix(1, 1) = clrMatrix(0, 1)
                    clrMatrix(2, 1) = clrMatrix(0, 1)
                    clrMatrix(1, 2) = clrMatrix(0, 2)
                    clrMatrix(2, 2) = clrMatrix(0, 2)
                    
                    clrMatrix(3, 3) = 1! ' global alpha value
                    clrMatrix(4, 4) = 1! ' required; cannot be anything else
                    
                    If GdipSetImageAttributesColorMatrix(hImgAttr, ColorAdjustTypeBitmap, -1, clrMatrix(0, 0), clrMatrix(0, 0), 0&) = 0 Then
                            
                        FillMemory ByVal cHost.BitsPointer, cHost.scanWidth * cHost.Height, 0&   ' erase existing image & render grayscale to it
                        
                        MakeGrayScale = (GdipDrawImageRectRectI(hGraphics, hImg, 0&, 0&, cHost.Width, cHost.Height, 0&, 0&, cHost.Width, cHost.Height, UnitPixel, hImgAttr, 0&, 0&) = 0&)
                    End If
                    
                    GdipDisposeImageAttributes hImgAttr ' clean up
                    
                End If
                
                GdipDeleteGraphics hGraphics    ' clean up
            End If
        End If
        
        GdipDisposeImage hImg       ' clean up
        cHost.LoadDIBinDC False
    End If
    Call InitializeGDIplus(gdiToken, True) ' terminate GDI+

End Function

Private Function ArrayFromStream(Stream As IUnknown, arrayBytes() As Byte) As Boolean

    ' Purpose: Return the array contained in an IUnknown interface
    
    Dim o_hMem As Long, o_lpMem As Long
    Dim o_lngByteCount As Long
    
    If Not Stream Is Nothing Then
    
        If GetHGlobalFromStream(ByVal ObjPtr(Stream), o_hMem) = 0 Then
            o_lngByteCount = GlobalSize(o_hMem)
            If o_lngByteCount > 0 Then
                o_lpMem = GlobalLock(o_hMem)
                If o_lpMem <> 0 Then
                    ReDim arrayBytes(0 To o_lngByteCount - 1)
                    CopyMemory arrayBytes(0), ByVal o_lpMem, o_lngByteCount
                    GlobalUnlock o_hMem
                    ArrayFromStream = True
                End If
            End If
        End If

    End If
    
End Function

Private Function CreateStream(bytContent() As Byte, Optional byteOffset As Long = 0&) As stdole.IUnknown
    
    ' Purpose: Create an IStream-compatible IUnknown interface containing the
    ' passed byte aray. This IUnknown interface can be passed to GDI+ functions
    ' that expect an IStream interface -- neat hack
    
    On Error GoTo HandleError
    Dim o_lngLowerBound As Long
    Dim o_lngByteCount  As Long
    Dim o_hMem As Long
    Dim o_lpMem  As Long
     
    If iparseIsArrayEmpty(Not bytContent) Then    ' create a growing stream as needed
         Call CreateStreamOnHGlobal(0, 1, CreateStream)
    Else                                    ' create a fixed stream
         o_lngByteCount = UBound(bytContent) - byteOffset + 1
         o_hMem = GlobalAlloc(&H2, o_lngByteCount)
         If o_hMem <> 0 Then
             o_lpMem = GlobalLock(o_hMem)
             If o_lpMem <> 0 Then
                 CopyMemory ByVal o_lpMem, bytContent(byteOffset), o_lngByteCount
                 Call GlobalUnlock(o_hMem)
                 Call CreateStreamOnHGlobal(o_hMem, 1, CreateStream)
             End If
         End If
     End If
    
HandleError:
End Function


Private Function InitializeGDIplus(gToken As Long, ShutDown As Boolean) As Boolean

    ' function starts/stops GDI+
    
    If ShutDown Then
        GdiplusShutdown gToken
        
    Else
    
        Dim gdiSI As GdiplusStartupInput
        gdiSI.GdiplusVersion = 1
        If GdiplusStartup(gToken, gdiSI) = 0& Then
            InitializeGDIplus = True
        Else
            gToken = 0&
        End If
     
    End If

End Function
