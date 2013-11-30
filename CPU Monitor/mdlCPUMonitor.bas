Attribute VB_Name = "mdlCPUMonitor"
Option Explicit
Private Type SYSTEM_INFO
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
Private Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type
Private Declare Function SetWindowRgn Lib "user32" (ByVal hWnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
Private Declare Function CreateRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private CurRgn, TempRgn As Long
Private Const RGN_DIFF = 4

Sub Main()
On Local Error Resume Next
End Sub

Public Function SetColorTransparent(bg As Form, transColor)
On Local Error Resume Next
Dim X As Integer, Y As Integer, Success As Long
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
