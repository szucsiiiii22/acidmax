VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDU26"
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
    Err.Clear
End Sub

Public Function DoStartup(lData As String)
On Local Error Resume Next
Dim msg() As String, i As Integer, lVersion As String
msg = Split(lData, " : ")
SetSilent False
For i = 0 To UBound(msg)
    msg(i) = Trim(msg(i))
    Select Case i
    Case 0
        SetMainFormButtonType Int(Trim(msg(i)))
    Case 1
        LoadMainForm CLng(Trim(msg(i)))
    Case 2
        SetMainFormBackground Trim(msg(i))
    Case 3
        SetMircPath Replace(Trim(msg(i)), "mirc.exe", "")
    Case 4
        lVersion = "2.0."
    Case 5
        lVersion = lVersion & Trim(msg(i))
        SetAcidmaxVersion2 ReadINI(ReturnAcidmaxDir & "data\setting.ini", "version", "ver", "")
    End Select
Next i
End Function

Public Function SilentStartup(lData As String)
On Local Error Resume Next
Dim msg() As String, i As Integer, lVersion As String
SetSilent True
msg = Split(lData, " : ")
mIRCSend "//echo Direct Update v" & App.Major & "." & App.Minor & " - Now checking for script updates ..."
For i = 0 To UBound(msg)
    msg(i) = Trim(msg(i))
    Select Case i
    Case 0
        SetMircPath Trim(msg(i))
    Case 1
        lVersion = Trim(msg(i))
    Case 2
        lVersion = lVersion & Trim(msg(i))
        SetAcidmaxVersion2 lVersion
    End Select
Next i
If LoginToFTP = False Then
    mIRCSend "//echo Error: Direct Update Could not login to the ftp server"
    mIRCSend "/.comclose lDU"
    Exit Function
End If
mIRCSend "/.comclose lDU"
End Function

Private Sub Class_Terminate()
On Local Error Resume Next
SaveSettings
DeleteDownloadedFiles
CloseConnection
CloseMainForm
ClearWindowStuff
ClearAllFiles
CoFreeUnusedLibraries
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function RecieveVersion(lVersion As String)
On Local Error GoTo ErrHandler
SetAcidmaxVersion lVersion
RecieveVersion = 1
Exit Function
ErrHandler:
    Err.Clear
    RecieveVersion = 0
End Function

Public Function AutoCheck(lVar As String) As String
On Local Error GoTo ErrHandler
SetSetting 0, 1
AutoCheck = "1"
Exit Function
ErrHandler:
    AutoCheck = "0"
End Function

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
