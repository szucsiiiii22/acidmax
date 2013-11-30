VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAB10"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long

Private Sub Class_Initialize()
On Local Error GoTo ErrHandler
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Function StartBrowser(lData As String)
On Local Error Resume Next
Dim i As Integer, msg() As String, msg2 As String
lData = Split(lData, ";")
For i = 0 To UBound(msg)
    msg2 = msg(i)
    If Len(msg2) <> 0 Then
        Select Case i
        Case 0
            
        End Select
    End If
Next i
'LoadMainForm CLng(Trim(lData))
End Function

Public Function GoURL(lData As String)
On Local Error Resume Next
If Len(lData) <> 0 Then
    GoURL1 lData
End If
End Function

Public Function GoHomePage(lData As String)
On Local Error Resume Next
LoadMainForm CLng(Trim(lData))
DoEvents
GoURL1 "http://www.tnexgen.com"
End Function

Private Sub Class_Terminate()
On Local Error Resume Next
WriteINI App.Path & "\ab.ini", "Settings", "Width", ReturnMainFormWidth
WriteINI App.Path & "\ab.ini", "Settings", "Height", ReturnMainFormHeight
CloseMainForm
CoFreeUnusedLibraries
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function SetParentWindowHwnd(lHwnd As String) As String
On Local Error GoTo ErrHandler
SetParentHwnd CLng(lHwnd)
Exit Function
ErrHandler:
    SetParentWindowHwnd = "0"
    Err.Clear
End Function

Public Function Run() As String
On Local Error GoTo ErrHandler
Run = "Not initialized"
Exit Function
ErrHandler:
    Run = "0"
    Err.Clear
End Function
