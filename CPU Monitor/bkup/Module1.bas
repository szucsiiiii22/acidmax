Attribute VB_Name = "Module1"
Option Explicit
Type SYSTEM_INFO
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
Type OSVERSIONINFO
        dwOSVersionInfoSize As Long
        dwMajorVersion As Long
        dwMinorVersion As Long
        dwBuildNumber As Long
        dwPlatformId As Long
        szCSDVersion As String * 128
End Type
Type MEMORYSTATUS
        dwLength As Long
        dwMemoryLoad As Long
        dwTotalPhys As Long
        dwAvailPhys As Long
        dwTotalPageFile As Long
        dwAvailPageFile As Long
        dwTotalVirtual As Long
        dwAvailVirtual As Long
End Type

Public Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As OSVERSIONINFO) As Long
Public Declare Sub GlobalMemoryStatus Lib "kernel32" (lpBuffer As MEMORYSTATUS)
Public Declare Sub GetSystemInfo Lib "kernel32" (lpSystemInfo As SYSTEM_INFO)

Public Const PROCESSOR_INTEL_386 = 386
Public Const PROCESSOR_INTEL_486 = 486
Public Const PROCESSOR_INTEL_PENTIUM = 586
Public Const PROCESSOR_MIPS_R4000 = 4000
Public Const PROCESSOR_ALPHA_21064 = 21064

Public Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function SetWindowRgn Lib "user32" (ByVal hWnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
Public Declare Function CreateRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Public Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long
Public Declare Sub ReleaseCapture Lib "user32" ()
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Public Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Public Declare Function BitBlt Lib "gdi32" (ByVal hDCDest As Long, ByVal XDest As Long, ByVal YDest As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hDCSrc As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function CreatePen Lib "gdi32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long
Public Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Public Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Public Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal lpString As String, ByVal nCount As Long) As Long
Public Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Public Declare Function RoundRect Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long) As Long
Public Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Public Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI) As Long
Public Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Public Type POINTAPI
    X As Long
    Y As Long
End Type
Public Const SWP_NOMOVE = &H2, SWP_NOSIZE = &H1
Public Const HWND_TOPMOST = -1, HWND_NOTOPMOST = -2
Public Const RGN_DIFF = 4
Public Const SC_CLICKMOVE = &HF012&
Public Const WM_SYSCOMMAND = &H112

Dim CurRgn, TempRgn As Long

Public Function SetColorTransparent(bg As Form, transColor)
Dim X As Integer
Dim Y As Integer
Dim Success As Long
CurRgn = CreateRectRgn(0, 0, bg.ScaleWidth, bg.ScaleHeight)

While Y <= bg.ScaleHeight
    While X <= bg.ScaleWidth
        If GetPixel(bg.hdc, X, Y) = transColor Then
            TempRgn = CreateRectRgn(X, Y, X + 1, Y + 1)
            Success = CombineRgn(CurRgn, CurRgn, TempRgn, RGN_DIFF)
            DeleteObject (TempRgn)
        End If
        X = X + 1
    Wend
        Y = Y + 1
        X = 0
Wend
Success = SetWindowRgn(bg.hWnd, CurRgn, True)
DeleteObject (CurRgn)

End Function
