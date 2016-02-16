Attribute VB_Name = "Common"
 Option Explicit
Public Type gSystemStatsBios
    Description As String
    BuildNumber As String
    LanguageEdition As String
    Manufacturer As String
    Version As String
    SoftwareElementID As String
End Type
Public Type gSystemStatsCpu
    SocketDesignation As String
    Manufacturer As String
    Name As String
    Description As String
    MaxClockSpeed As String
End Type

Public Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long
Public Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String) As Long
Public Type HSL
    Hue                 As Integer
    Saturation          As Integer
    Luminance           As Integer
End Type
Public Type RGB
    Red                 As Integer
    Green               As Integer
    Blue                As Integer
End Type
Private Const HueMAX    As Long = 239
Private Const SatMAX    As Long = 240
Private Const LumMAX    As Long = 240
Private Const C_2_DIV_3 As Double = (2 / 3)
Private Const C_1_DIV_3 As Double = (1 / 3)
Private Const GWL_STYLE = -16
Private Const WS_CHILD = &H40000000
Private Const WM_SETTEXT = &HC
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
Private Const HWND_NOTOPMOST = -2
Private Const HWND_TOPMOST = -1
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_SHOWWINDOW = &H40
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nindex As Long, ByVal dwnewlong As Long) As Long
'Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function EnumChildWindows Lib "user32" (ByVal hWndParent As Long, ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long
Private Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hWnd As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hWnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function PtInRect Lib "user32" (lpRect As RECT, ByVal lLeft As Long, ByVal lTop As Long) As Long
Private lLong As Long
Private lParentText As String
Public lParenthWnd As String
Private lChildText As String
Private lChildHnwd As String
Private Const WM_CHAR = &H102
'Public Type RECT
    'Left As Long
    'Top As Long
    'Right As Long
    'Bottom As Long
'End Type
Private ControlPanel As New frmControlPanel
'Type RECT
   'x1 As Long
   'y1 As Long
   'x2 As Long
   'y2 As Long
'End Type
Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, rectangle As RECT) As Boolean
Public Enum BYTEVALUES
  KiloByte = 1024
  MegaByte = 1048576
  GigaByte = 107374182
End Enum


Public Declare Function GetDiskFreeSpaceEx Lib "kernel32" Alias "GetDiskFreeSpaceExA" (ByVal lpRootPathName As String, lpFreeBytesAvailableToCaller As Currency, lpTotalNumberOfBytes As Currency, lpTotalNumberOfFreeBytes As Currency) As Long
Public Declare Sub GlobalMemoryStatus Lib "kernel32" (lpBuffer As MEMORYSTATUS)
Public Declare Function GetDriveType Lib "kernel32" Alias "GetDriveTypeA" (ByVal nDrive As String) As Long
Public Declare Function GetLogicalDriveStrings Lib "kernel32" Alias "GetLogicalDriveStringsA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Public Declare Sub GetSystemInfo Lib "kernel32" (lpSystemInfo As SYSTEM_INFO)
Public Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As OSVERSIONINFO) As Long
Public Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Public Declare Function GetVolumeInformation Lib "kernel32" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Long, lpVolumeSerialNumber As Long, lpMaximumComponentLength As Long, lpFileSystemFlags As Long, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Long) As Long
'Private Declare Function LockWorkStation Lib "user32.dll" () As Long
Public Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Public Declare Function ShellAbout Lib "shell32.dll" Alias "ShellAboutA" (ByVal hWnd As Long, ByVal szApp As String, ByVal szOtherStuff As String, ByVal hIcon As Long) As Long

Public Const MAX_COMPUTERNAME_LENGTH As Long = 31

Public Type SYSTEM_INFO
    dwOemID As Long
    dwPageSize As Long
    lpMinimumApplicationAddress As Long
    lpMaximumApplicationAddress As Long
    dwActiveProcessorMask As Long
    dwNumberOrfProcessors As Long
    dwProcessorType As Long
    dwAllocationGranularity As Long
    dwReserved As Long
End Type

Private Type DISKSPACE
  dsRoot As String
  dsFreeBytesAvailToCaller As Currency
  dsTotalBytes As Currency
  dsTotalFreeBytes As Currency
  dsDriveType As String
  dsVolume As String
  dsSerial As Long
  dsFileSystem As String
End Type

Public Type MEMORYSTATUS
  dwLength As Long
  dwMemoryLoad As Long
  dwTotalPhys As Long
  dwAvailPhys As Long
  dwTotalPageFile As Long
  dwAvailPageFile As Long
  dwTotalVirtual As Long
  dwAvailVirtual As Long
End Type

Public Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type

Function ConvertBytes(Bytes As Long, Optional NumDigitsAfterDecmal As Long = 0) As String
  ConvertBytes = FormatNumber(Bytes, NumDigitsAfterDecmal) & "bytes"
End Function
Function ConvertKiloBytes(Bytes As Long, Optional NumDigitsAfterDecmal As Long = 0) As String
  ConvertKiloBytes = FormatNumber(Bytes / BYTEVALUES.KiloByte, NumDigitsAfterDecmal) & "kb"
End Function
Function ConvertMegaBytes(Bytes As Long, Optional NumDigitsAfterDecmal As Long = 0) As String
  ConvertMegaBytes = FormatNumber(Bytes / BYTEVALUES.MegaByte, NumDigitsAfterDecmal) & "mb"
End Function
Function ConvertGigaBytes(Bytes As Long, Optional NumDigitsAfterDecmal As Long = 0) As String
  ConvertGigaBytes = FormatNumber(Bytes / BYTEVALUES.GigaByte, NumDigitsAfterDecmal) & "gb"
End Function


Public Sub AlwaysOnTop(lForm As Form, lOnTop As Boolean)
On Local Error GoTo ErrHandler
Dim i As Integer
If lOnTop Then
    i = HWND_TOPMOST
Else
    i = HWND_NOTOPMOST
End If
SetWindowPos lForm.hWnd, i, lForm.Left / Screen.TwipsPerPixelX, lForm.Top / Screen.TwipsPerPixelY, lForm.Width / Screen.TwipsPerPixelX, lForm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function GetCheckboxValue(lCheckbox As CheckBox) As Boolean
On Local Error GoTo ErrHandler
If lCheckbox.Value = 1 Then
    GetCheckboxValue = True
Else
    GetCheckboxValue = False
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Sub mIRCStatusSend(lData As String)
On Local Error GoTo ErrHandler
Dim l As Long, o As Long, n As Long, g As Long
l = FindWindow("mIRC", vbNullString)
o = FindWindowEx(l, 0&, "MdiClient", vbNullString)
n = FindWindowEx(o, 0&, "mIRC_Status", vbNullString)
g = FindWindowEx(n, 0&, "RichEdit20A", vbNullString)
Call SendMessageByString(g, WM_SETTEXT, 0&, lData)
If g = 0 Then Exit Sub
Do
    DoEvents
    l = FindWindow("mIRC", vbNullString)
    o = FindWindowEx(l, 0&, "MdiClient", vbNullString)
    n = FindWindowEx(o, 0&, "mIRC_Status", vbNullString)
    g = FindWindowEx(n, 0&, "RichEdit20A", vbNullString)
    Call SendMessageLong(g, WM_CHAR, 13, 0&)
Loop Until g <> 0
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub Pause(lInt)
On Local Error GoTo ErrHandler
Dim msg
msg = Timer
Do While Timer - msg < Val(lInt)
    DoEvents
Loop
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetChildWindowText(lText As String)
On Local Error GoTo ErrHandler
SetWindowText CLng(Trim(lChildHnwd)), lText
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub PutIn(lForm As Form)
On Local Error GoTo ErrHandler
Dim r As RECT
With r
    .Left = .Left - 4
    .Top = .Top - 4
    .Right = .Right + 4
    .Bottom = .Bottom + 4
End With
PtInRect r, lForm.Left, lForm.Top
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetWindowToChild(lWindowHwnd As Long, Optional lCaption As String)
On Local Error GoTo ErrHandler
SetWindowLong lWindowHwnd, GWL_STYLE, WS_CHILD
SetParent CLng(Trim(lWindowHwnd)), lParenthWnd
'If Len(lCaption) = 0 Then
    'SetWindowText CLng(Trim(lParenthWnd)), App.Title & " - v" & App.Major & "." & App.Revision
'Else
    'SetWindowText CLng(Trim(lParenthWnd)), lCaption
'End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetParentHwnd(lhWnd As Long)
On Local Error GoTo ErrHandler
lParenthWnd = Str(lhWnd)
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetChildHWND(lhWnd As Long)
On Local Error Resume Next
lChildHnwd = Str(lhWnd)
End Sub

Public Sub ClearWindowStuff()
On Local Error GoTo ErrHandler
lLong = 0
lParenthWnd = ""
lParentText = ""
lChildHnwd = ""
lChildText = ""
ErrHandler:
    Err.Clear
End Sub

Public Function SetWindowFocus(lhWnd As Long)
On Local Error GoTo ErrHandler
SetFocus lhWnd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ShowNonModalForm(lForm As Form) As Boolean
On Local Error GoTo ErrHandler
ShowWindow lForm.hWnd, 1
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function GetParentVersion() As String
On Local Error GoTo ErrHandler
Dim c As Long, l As Long, msg As String
l = GetWindowTextLength(lParenthWnd)
msg = Space$(l + 1)
l = GetWindowText(lParenthWnd, msg, l + 1)
msg = Left$(msg, Len(msg) - 1)
GetParentVersion = Right(msg, Len(msg) - 25)
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnChildWindowHwnd() As Long
On Local Error GoTo ErrHandler
ReturnChildWindowHwnd = lChildHnwd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnParentWindowHwnd() As Long
On Local Error GoTo ErrHandler
ReturnParentWindowHwnd = lParenthWnd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function SetParentWindowFunction(lSetAsParent As Boolean, lParentCaption As String, lChildCaption As String, lForm As Form) As Boolean
On Local Error Resume Next
Dim l As Long, o As Long
If Len(lParentCaption) <> 0 Then
    If lSetAsParent = True Then
        lParentText = lParentCaption
        l = EnumWindows(AddressOf CheckWindows, lForm)
        lChildText = lChildCaption
        o = EnumChildWindows(lParenthWnd, AddressOf CheckChildWindow, l)
        SetParent lForm.hWnd, lChildHnwd
        SetWindowPosition CLng(lChildHnwd), 0, 0, ReturnMainFormWidth / Screen.TwipsPerPixelX, ReturnMainFormHeight / Screen.TwipsPerPixelY + 27
    ElseIf lSetAsParent = False Then
        SetParent lChildHnwd, 0
    End If
End If
End Function

Public Function SetWindowPosition(lhWnd As Long, lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long) As Boolean
On Local Error GoTo ErrHandler
SetWindowPos lhWnd, 0, lLeft, lTop, lWidth, lHeight, 0
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function IsParentChildOpen() As Boolean
On Local Error GoTo ErrHandler
lChildHnwd = 0
lLong = EnumChildWindows(lParenthWnd, AddressOf CheckChildWindow, 0)
If lChildHnwd = 0 Then
    IsParentChildOpen = False
Else
    IsParentChildOpen = True
End If
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnParentHwnd() As Long
On Local Error GoTo ErrHandler
ReturnParentHwnd = lParenthWnd
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function CheckWindows(ByVal lhWnd As Long, ByVal lForm As Form) As Long
On Local Error Resume Next
Dim msg As String * 512, lRet As Long, lLen As Long, lClass As String * 50
lLen = GetWindowTextLength(lhWnd)
lRet = GetWindowText(lhWnd, msg, lLen + 1)
GetClassName lhWnd, lClass, 50
If lLen <> 0 Then
    msg = Trim(msg)
    If InStr(1, LCase(msg), lParentText, vbTextCompare) Then lParenthWnd = lhWnd
End If
CheckWindows = 1
End Function

Private Function CheckChildWindow(ByVal lhWnd As Long) As Long
On Local Error Resume Next
Dim lRet As Long, msg As String * 50
lRet = GetClassName(lhWnd, msg, 50)
If Trim(LCase(lChildText)) = Trim(LCase(GetText(lhWnd))) Then lChildHnwd = lhWnd
CheckChildWindow = 1
If Err.Number <> 0 Then Err.Clear
End Function

Private Function GetText(lhWnd As Long) As String
On Local Error Resume Next
Dim lLen As Long, lText As String
lLen = SendMessage(lhWnd, WM_GETTEXTLENGTH, 0, 0)
If lLen = 0 Then
    GetText = "Nothing"
    Exit Function
End If
lLen = lLen + 1
lText = Space(lLen)
lLen = SendMessage(lhWnd, WM_GETTEXT, lLen, ByVal lText)
GetText = Left(lText, lLen)
If Err.Number <> 0 Then
    Err.Clear
End If
End Function



Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = ControlPanel.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = ControlPanel.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = ControlPanel.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = ControlPanel.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set ControlPanel = New frmControlPanel
ShowNonModalForm ControlPanel
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload ControlPanel
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub



Public Function HSLtoRGB(ByVal Hue As Integer, _
                         ByVal Saturation As Integer, _
                         ByVal Luminance As Integer) As Long

    Dim RetVal      As RGB
    Dim pHue        As Double
    Dim pSat        As Double
    Dim pLum        As Double
    Dim pRed        As Double
    Dim pGreen      As Double
    Dim pBlue       As Double
    Dim temp1       As Double
    Dim temp2       As Double
    Dim temp3(2)    As Double
    Dim n           As Long
   
    pHue = Hue / HueMAX
    pSat = Saturation / SatMAX
    pLum = Luminance / LumMAX

    If pSat = 0 Then
        pRed = pLum
        pGreen = pLum
        pBlue = pLum
    Else
        If pLum < 0.5 Then
            temp2 = pLum * (1 + pSat)
        Else
            temp2 = pLum + pSat - pLum * pSat
        End If
        temp1 = 2 * pLum - temp2
   
        temp3(0) = pHue + C_1_DIV_3
        temp3(1) = pHue
        temp3(2) = pHue - C_1_DIV_3
      
        For n = 0 To 2
            If temp3(n) < 0# Then
                temp3(n) = temp3(n) + 1#
            ElseIf temp3(n) > 1# Then
                temp3(n) = temp3(n) - 1#
            End If
            
            If 6# * temp3(n) < 1# Then
                temp3(n) = temp1 + (temp2 - temp1) * 6# * temp3(n)
            Else
                If 2# * temp3(n) < 1# Then
                    temp3(n) = temp2
                Else
                    If 3# * temp3(n) < 2# Then
                        temp3(n) = temp1 + (temp2 - temp1) * (C_2_DIV_3 - temp3(n)) * 6#
                    Else
                        temp3(n) = temp1
                    End If
                End If
            End If
        Next n
        pRed = temp3(0)
        pGreen = temp3(1)
        pBlue = temp3(2)
    End If
    With RetVal
        .Red = Int(pRed * 255#)
        .Green = Int(pGreen * 255#)
        .Blue = Int(pBlue * 255#)
        If .Red < 0 Then .Red = 0
        If .Green < 0 Then .Green = 0
        If .Blue < 0 Then .Blue = 0
        HSLtoRGB = RGB(.Red, .Green, .Blue)
    End With
End Function

Public Sub RunAudica()
Shell App.Path & "\system\bin\Audica.exe mirc", vbNormalFocus
End Sub
