VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCPanel"
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
    'MsgBox Err.Description
    Err.Clear
End Sub

Public Sub Startcpanel(lData As String)
On Local Error GoTo ErrHandler
If Len(lData) <> 0 Then
    SetParentHwnd CLng(Trim(lData))
Else
    'mIRCStatusSend "//window -KBR D @controlpanel acidmax.ico"
    'SetParentHwnd CLng(Trim(lData))
    'MsgBox "No @window could be found, unable to start!"
    Exit Sub
End If
InitMainForm
Exit Sub
ErrHandler:
    'MsgBox "Startcpanel:" & Err.Description
    Err.Clear
End Sub

Public Sub GoPanel(lData As String)
On Local Error GoTo ErrHandler
lData = Replace(lData, Chr(34), "")
LoadPanel lData
Exit Sub
ErrHandler:
    'MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Class_Terminate()
On Local Error GoTo ErrHandler
Dim msg As String
msg = App.Path & "\cpanel.ini"
DoEvents
DestroyMainForm
CoFreeUnusedLibraries
Exit Sub
ErrHandler:
    'MsgBox Err.Description
    Err.Clear
End Sub
