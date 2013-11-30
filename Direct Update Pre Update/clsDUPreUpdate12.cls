VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDUPreUpdate12"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long
Private lFTP As clsFTP
Private lmIRCPath As String

Public Function DoStartup(lData As String)
On Local Error Resume Next
Dim i As Integer, v As Integer, mbox As VbMsgBoxResult, lVersion As String, lNewVersion As String, mbox2 As VbMsgBoxResult, msg As String, msg2 As String, B As Boolean, c As Boolean
B = GetSetting("DU", "Settings", "Loaded", False)
Set lFTP = New clsFTP
SetMircPath Replace(lData, "mirc.exe", "") & "du\"
lVersion = ReadINI(Left(ReturnAcidmaxPath, Len(ReturnAcidmaxPath()) - 3) & "data\setting.ini", "version", "ver", "")
msg = ReturnAcidmaxPath & "du\"
msg = Replace(msg, "\du\du\", "\du\")
If DoesDirectoryExist(msg) = False Then CreateMultiDirectory msg
lFTP.LoginToFTP
DoEvents
mIRCStatusSend "//ECHO Checking for Updates to Acidmax ..."
v = FindFileIndex("version.ini")
If v <> 0 Then
    If lFTP.DownloadFile("version.ini") = True Then
        DoEvents
        lNewVersion = ReadINI(App.Path & "\version.ini", "Settings", "Version", "")
    End If
End If
If ReturnNewFiles = True Then
    mbox = MsgBox("Direct Update apears to be out of date. Would you like to update Direct Update files now?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        If B = True Then
            mbox = MsgBox("Direct Update apears to be open, would you like to close it now?", vbYesNo + vbQuestion)
            SaveSetting "DU", "Settings", "Loaded", False
            If mbox = vbYes Then
                mIRCStatusSend "//frmDU.Unload"
                DoEvents
                Pause 1.5
                c = True
            Else
                c = False
            End If
        Else
            c = True
        End If
        If c = True Then
            mIRCStatusSend "//ECHO Please wait while Direct Update gets patched ..."
            For i = 0 To ReturnFileCount
                If ReturnFileNew(i) = True Then
                    If DoesFileExist(ReturnFileAcidmaxPath(i) & ReturnFileName(i)) = True Then
                        Kill ReturnFileAcidmaxPath(i) & ReturnFileName(i)
                        DoEvents
                    End If
                    mIRCStatusSend "//ECHO Downloading " & ReturnFileName(i)
                    If lFTP.DownloadFile(ReturnFileName(i)) = True Then
                        mIRCStatusSend "//ECHO Downloaded " & ReturnFileName(i)
                        DoEvents
                        FileCopy ReturnFileLocalPath(i) & ReturnFileName(i), ReturnFileAcidmaxPath(i) & ReturnFileName(i)
                        DoEvents
                        Select Case LCase(ReturnFileName(i))
                        Case "du.mrc"
                            msg2 = ReturnFileAcidmaxPath(i) & ReturnFileName(i)
                        End Select
                        Kill ReturnFileLocalPath(i) & ReturnFileName(i)
                    End If
                End If
            Next i
            If Len(msg2) <> 0 Then mIRCStatusSend "//load -rs " & msg2
        End If
    End If
End If
DoEvents
If lVersion <> lNewVersion Then
    mIRCStatusSend "//ECHO 4*** Your version of Acidmax appears to be out of date, to load Direct Update type /du"
    mIRCStatusSend "//ECHO 4*** Your Version: " & lVersion & ""
    mIRCStatusSend "//ECHO 4*** New Version: " & lNewVersion & ""
End If
lFTP.CloseConnection
DoEvents
Pause 0.2
mIRCStatusSend "/.COMCLOSE lDUPreUpdate"
End Function

Private Sub Class_Terminate()
On Local Error Resume Next
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
