VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDU298"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long

Private Sub Class_Initialize()
On Local Error GoTo ErrHandler
LoadSettings
Exit Sub
ErrHandler:
    ProcessError "Private Sub Class_Initialize()", Err.Description
End Sub

Public Function DoStartup(lData As String)
On Local Error GoTo ErrHandler
Dim msg() As String, i As Integer, lVersion As String
msg = Split(lData, " : ")
For i = 0 To UBound(msg)
    msg(i) = Trim(msg(i))
    Select Case i
    Case 0
        SetMainFormButtonType Int(Trim(msg(i)))
    Case 1
        LoadMainForm CLng(Trim(msg(i)))
    Case 2
        SetMircPath Replace(Trim(msg(i)), "mirc.exe", "")
    Case 3
        lVersion = "2.1."
    Case 4
        lVersion = lVersion & Trim(msg(i))
        SetAcidmaxVersion2 ReadINI(ReturnAcidmaxDir & "data\setting.ini", "version", "ver", "")
    End Select
    DoEvents
Next i
Exit Function
ErrHandler:
    ProcessError "Public Function DoStartup(lData As String)", Err.Description
End Function

Public Function ShowAdmin(lData As String)
On Local Error GoTo ErrHandler
Exit Function
ErrHandler:
    ProcessError "Public Function ShowAdmin(lData As String)", Err.Description
End Function

Public Function Run() As String
On Local Error GoTo ErrHandler
Exit Function
ErrHandler:
    ProcessError "Public Function Run() As String", Err.Description
End Function

Private Sub Class_Terminate()
On Local Error GoTo ErrHandler
'WriteINI ReturnDUINI, "Settings", "Loaded", "False"
'SaveSettings
'DeleteDownloadedFiles
'FTP_CloseConnection
'CloseMainForm
'ClearWindowStuff
'ClearAllFiles
CoFreeUnusedLibraries
'DoEvents
Exit Sub
ErrHandler:
    ProcessError "Private Sub Class_Terminate()", Err.Description
End Sub
