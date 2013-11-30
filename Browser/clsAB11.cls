VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAB11"
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
If Len(lData) <> 0 Then LoadMainForm CLng(Trim(lData))
If Err.Number <> 0 Then Err.Clear
End Function

Public Function GoURL(lUrl As String)
On Local Error Resume Next
If Len(lUrl) <> 0 Then GoURL1 lUrl
GoURL = lUrl
End Function

Private Sub Class_Terminate()
On Local Error Resume Next
CloseMainForm
CoFreeUnusedLibraries
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function Run() As String
On Local Error GoTo ErrHandler
Run = "Not initialized"
Exit Function
ErrHandler:
    Run = "0"
    Err.Clear
End Function
