Attribute VB_Name = "modAPI"
Option Explicit

Public Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Public Declare Function GetClientRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Public Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function ClientToScreen Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Public Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Public Declare Function OleTranslateColor Lib "olepro32" (ByVal ole_color As Long, ByVal HPALETTE As Long, pccolorref As Long) As Long
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Public Declare Function CreateFontIndirect Lib "gdi32" Alias "CreateFontIndirectA" (lpLogFont As LOGFONT) As Long
Public Declare Function MulDiv Lib "kernel32" (ByVal nNumber As Long, ByVal nNumerator As Long, ByVal nDenominator As Long) As Long
Public Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Public Declare Function CreatePen Lib "gdi32" (ByVal fnPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long
Public Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal y As Long) As Long
Public Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal y As Long, ByVal lpPoint As Any) As Long
Public Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Public Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Public Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
Public Declare Function FillRect Lib "user32" (ByVal hdc As Long, ByRef lpRect As RECT, ByVal HBRUSH As Long) As Long
Public Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function DrawText Lib "user32" Alias "DrawTextA" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, ByRef lpRect As RECT, ByVal wFormat As Long) As Long
Public Declare Function DrawEdge Lib "user32" (ByVal hdc As Long, qrc As RECT, ByVal edge As Long, ByVal grfFlags As Long) As Long
Public Declare Function FrameRect Lib "user32" (ByVal hdc As Long, lprc As RECT, ByVal hBr As Long) As Long
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (lpDest As Any, lpSource As Any, ByVal cBytes As Long)
Public Declare Sub ZeroMemory Lib "kernel32" Alias "RtlZeroMemory" (lpDest As Any, ByVal cBytes As Long)
Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function BeginPaint Lib "user32" (ByVal hwnd As Long, lpPaint As PAINTSTRUCT) As Long
Public Declare Function EndPaint Lib "user32" (ByVal hwnd As Long, lpPaint As PAINTSTRUCT) As Long
Public Declare Function GetCurrentObject Lib "gdi32" (ByVal hdc As Long, ByVal uObjectType As Long) As Long
Public Declare Function DrawFocusRect Lib "user32" (ByVal hdc As Long, lpRect As RECT) As Long
Public Declare Function GetObject Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long

Public Type POINTAPI
    X                               As Long
    y                               As Long
End Type

Public Type RECT
    X1                              As Long
    Y1                              As Long
    X2                              As Long
    Y2                              As Long
End Type

Public Type BITMAP
    bmType                          As Long
    bmWidth                         As Long
    bmHeight                        As Long
    bmWidthBytes                    As Long
    bmPlanes                        As Integer
    bmBitsPixel                     As Integer
    bmBits                          As Long
End Type

Public Type LOGFONT
    lfHeight                        As Long
    lfWidth                         As Long
    lfEscapement                    As Long
    lfOrientation                   As Long
    lfWeight                        As Long
    lfItalic                        As Byte
    lfUnderline                     As Byte
    lfStrikeOut                     As Byte
    lfCharSet                       As Byte
    lfOutPrecision                  As Byte
    lfClipPrecision                 As Byte
    lfQuality                       As Byte
    lfPitchAndFamily                As Byte
    lfFaceName(32)                  As Byte
End Type

Public Type PAINTSTRUCT
    hdc                             As Long
    fErase                          As Long
    rcPaint                         As RECT
    fRestore                        As Long
    fIncUpdate                      As Long
    rgbReserved(32)                 As Byte
End Type

Public Enum HBRUSH
    [_]
End Enum

Public Enum HPEN
    [_]
End Enum

Public Enum HFONT
    [_]
End Enum

Public Const INVALID_HANDLE         As Long = -1

Public Const LOGPIXELSX             As Long = 88&
Public Const LOGPIXELSY             As Long = 90&
Public Const FW_NORMAL              As Long = 400&
Public Const FW_BOLD                As Long = 700&
Public Const FF_DONTCARE            As Long = 0&
Public Const DEFAULT_QUALITY        As Long = 0&
Public Const DEFAULT_PITCH          As Long = 0&
Public Const DEFAULT_CHARSET        As Long = 1&
Public Const NONANTIALIASED_QUALITY As Long = 3&

Public Const CLR_INVALID            As Long = -1&
Public Const CLR_NONE               As Long = &HFFFFFFFF

Public Const DT_BOTTOM              As Long = &H8&
Public Const DT_CENTER              As Long = &H1&
Public Const DT_LEFT                As Long = &H0&
Public Const DT_RIGHT               As Long = &H2&
Public Const DT_TOP                 As Long = &H0&
Public Const DT_VCENTER             As Long = &H4&
Public Const DT_WORDBREAK           As Long = &H10&
Public Const DT_PATH_ELLIPSIS       As Long = &H4000&
Public Const DT_END_ELLIPSIS        As Long = &H8000&
Public Const DT_MODIFYSTRING        As Long = &H10000
Public Const DT_SINGLELINE          As Long = &H20&

Public Const DT_CALCRECT            As Long = &H400&
Public Const DT_EDITCONTROL         As Long = &H2000&
Public Const DT_NOCLIP              As Long = &H100&

Public Const PS_SOLID               As Long = 0&

Public Const BDR_RAISEDOUTER        As Long = &H1&
Public Const BDR_SUNKENOUTER        As Long = &H2&
Public Const BDR_RAISEDINNER        As Long = &H4&
Public Const BDR_SUNKENINNER        As Long = &H8&

Public Const EDGE_BUMP              As Long = (BDR_RAISEDOUTER Or BDR_SUNKENINNER)
Public Const EDGE_ETCHED            As Long = (BDR_SUNKENOUTER Or BDR_RAISEDINNER)
Public Const EDGE_RAISED            As Long = (BDR_RAISEDOUTER Or BDR_RAISEDINNER)
Public Const EDGE_SUNKEN            As Long = (BDR_SUNKENOUTER Or BDR_SUNKENINNER)

Public Const BF_LEFT                As Long = &H1&
Public Const BF_TOP                 As Long = &H2&
Public Const BF_RIGHT               As Long = &H4&
Public Const BF_BOTTOM              As Long = &H8&
Public Const BF_RECT                As Long = (BF_LEFT Or BF_TOP Or BF_RIGHT Or BF_BOTTOM)

Public Const GWL_STYLE              As Long = (-16)
Public Const GWL_EXSTYLE            As Long = (-20)
Public Const WS_EX_TOPMOST          As Long = &H8&
Public Const WS_EX_WINDOWEDGE       As Long = &H100&
Public Const WS_EX_CLIENTEDGE       As Long = &H200&
Public Const WS_EX_STATICEDGE       As Long = &H20000
Public Const WS_TABSTOP             As Long = &H10000
Public Const WS_THICKFRAME          As Long = &H40000
Public Const WS_BORDER              As Long = &H800000
Public Const WS_DISABLED            As Long = &H8000000
Public Const WS_VISIBLE             As Long = &H10000000
Public Const WS_CHILD               As Long = &H40000000

Public Const SWP_NOMOVE             As Long = &H2&
Public Const SWP_NOSIZE             As Long = &H1&
Public Const SWP_NOOWNERZORDER      As Long = &H200&
Public Const SWP_NOZORDER           As Long = &H4&
Public Const SWP_FRAMECHANGED       As Long = &H20&

Public Const OBJ_FONT               As Long = 6
Public Const OBJ_PEN                As Long = 1
