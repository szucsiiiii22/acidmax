VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDUPreUpdate15"
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
B = CBool(GetSetting("DU", "Settings", "Loaded", False))
SetMircPath Replace(lData, "mirc.exe", "") & "du\"
mIRCStatusSend "//ECHO 12[0dup12]"
lVersion = ReadINI(Left(ReturnAcidmaxPath, Len(ReturnAcidmaxPath()) - 3) & "data\setting.ini", "version", "ver", "")
msg = ReturnAcidmaxPath & "du\"
msg = Replace(msg, "\du\du\", "\du\")
If DoesDirectoryExist(msg) = False Then CreateMultiDirectory msg
DoEvents
Set lFTP = New clsFTP
If lFTP.LoginToFTP = True Then
    mIRCStatusSend "//ECHO 12 • checking for updates to 0direct update"
    'v = FindFileIndex("version.ini")
    'If v <> 0 Then
    mIRCStatusSend "//ECHO 12 • downloading 0version.ini"
    
    If lFTP.DownloadFile("\version.ini") = True Then
        DoEvents
        lNewVersion = ReadINI(App.Path & "\version.ini", "Settings", "Version", "")
    Else
        mIRCStatusSend "//ECHO 12 • download failed!!"
        mIRCStatusSend "//ECHO 12 •"
    End If
    If DoesFileExist(App.Path & "\version.ini") = False Then
        mIRCStatusSend "//ECHO 12 • unable to download 0version.ini"
        mIRCStatusSend "//ECHO 12 • try again later"
        mIRCStatusSend "//ECHO 12[0end dup12]"
        mIRCStatusSend "/.COMCLOSE lDUPreUpdate"
        lFTP.CloseConnection
        Exit Function
    End If
    lFTP.ListFTPDirectory
    DoEvents
    'End If
    If ReturnNewFiles = True Then
        mIRCStatusSend "//ECHO 12 • out of date 0direct update"
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
                mIRCStatusSend "//ECHO 12 • patching 0direct update"
    '            mIRCStatusSend "//ECHO Please wait while Direct Update gets patched ..."
                For i = 0 To ReturnFileCount
                    If ReturnFileNew(i) = True Then
                        If DoesFileExist(ReturnFileAcidmaxPath(i) & ReturnFileName(i)) = True Then
                            'mIRCStatusSend "//ECHO 12• deleteing 0" & ReturnFileName(i)
                            Kill ReturnFileAcidmaxPath(i) & ReturnFileName(i)
                            DoEvents
                        End If
                        mIRCStatusSend "//ECHO 12 • deleteing 0" & ReturnFileName(i)
                        If lFTP.DownloadFile(ReturnFileName(i)) = True Then
                            mIRCStatusSend "//ECHO 12 • downloaded 0" & ReturnFileName(i)
                            'mIRCStatusSend "//ECHO Downloaded " & ReturnFileName(i)
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
    Else
        mIRCStatusSend "//ECHO 12 • up to date 0direct update"
    End If
    DoEvents
    If Len(Trim(lVersion)) <> 0 And Len(Trim(lNewVersion)) <> 0 Then
        If Trim(lVersion) <> Trim(lNewVersion) Then
            mIRCStatusSend "//ECHO 12 • out of date 0acidmax"
            mIRCStatusSend "//ECHO 12 • your version 0" & lVersion
            mIRCStatusSend "//ECHO 12 • new version 0" & lNewVersion
            'mIRCStatusSend "//ECHO 4*** Your version of Acidmax appears to be out of date, to load Direct Update type /du"
            'mIRCStatusSend "//ECHO 4*** Your Version: " & lVersion & ""
            'mIRCStatusSend "//ECHO 4*** New Version: " & lNewVersion & ""
        Else
            mIRCStatusSend "//ECHO 12 • up to date 0acidmax"
        End If
    Else
        mIRCStatusSend "//ECHO 12 • error 0version information not obtained"
    End If
End If
lFTP.CloseConnection
mIRCStatusSend "//ECHO 12[0end dup12]"
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
