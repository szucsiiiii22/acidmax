VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTetris"
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

Public Sub StartTetris(lData As String)
On Local Error GoTo ErrHandler
If Len(lData) <> 0 Then
    SetParentHwnd CLng(Trim(lData))
Else
    Exit Sub
End If
InitMainForm
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Class_Terminate()
On Local Error GoTo ErrHandler
DoEvents
DestroyMainForm
CoFreeUnusedLibraries
Exit Sub
ErrHandler:
    Err.Clear
End Sub
