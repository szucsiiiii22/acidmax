Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lMainForm As New frmMain
Private lButtonType As Integer
Private Declare Function LockWindowUpdate Lib "user32" (ByVal hwndLock As Long) As Long
Private lFileListCount As Integer
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Const HWND_NOTOPMOST = -2
Private Const HWND_TOPMOST = -1
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_SHOWWINDOW = &H40

Public Sub AlwaysOnTop(myfrm As Form, SetOnTop As Boolean)
On Local Error Resume Next
Dim lFlag As Integer
If SetOnTop Then
    lFlag = HWND_TOPMOST
Else
    lFlag = HWND_NOTOPMOST
End If
SetWindowPos myfrm.hwnd, lFlag, myfrm.Left / Screen.TwipsPerPixelX, myfrm.Top / Screen.TwipsPerPixelY, myfrm.Width / Screen.TwipsPerPixelX, myfrm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
End Sub

Public Sub HideMainForm()
lMainForm.Visible = False
End Sub

Public Sub SetFormCenter(lForm As Form)
On Local Error GoTo ErrHandler
lForm.Left = (Screen.Width - lForm.ScaleWidth) / 2
lForm.Top = (Screen.Height - lForm.ScaleHeight) / 2 + 100
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormDoEventsTimerEnabled(lValue As Boolean)
On Local Error Resume Next
lMainForm.tmrDoEvents.Enabled = lValue
End Sub

Public Sub SetMainFormAutoCheck(lValue As Boolean)
On Local Error Resume Next
Select Case lValue
Case True
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
End Sub

Public Function ReturnMainFormAutoUpdate() As Boolean
On Local Error Resume Next
Select Case lMainForm.imgUpdateAutomatically.Picture
Case lMainForm.imgCheckBox_Checked.Picture
    ReturnMainFormAutoUpdate = True
Case lMainForm.imgCheckBox_UnChecked.Picture
    ReturnMainFormAutoUpdate = False
End Select
End Function

Public Function ReturnMainFormAutoCheck() As Boolean
On Local Error Resume Next
Select Case lMainForm.imgCheckUpdatesAutomatically.Picture
Case lMainForm.imgCheckBox_Checked.Picture
    ReturnMainFormAutoCheck = True
Case lMainForm.imgCheckBox_UnChecked.Picture
    ReturnMainFormAutoCheck = False
End Select
End Function

Public Sub SetMainFormAutoUpdate(lValue As Boolean)
On Local Error Resume Next
Select Case lValue
Case True
    lMainForm.imgUpdateAutomatically.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgUpdateAutomatically.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
End Sub

Public Sub FTP_CloseConnection()
On Local Error Resume Next
lMainForm.ctlFTP1.CloseConnection
End Sub

Public Sub FTP_EnterFTPDirectory(lDirectory As String)
On Local Error Resume Next
lMainForm.ctlFTP1.EnterFTPDirectory lDirectory
End Sub

Public Sub FTP_SetConnected(lConnected As Boolean)
On Local Error Resume Next
lMainForm.ctlFTP1.SetConnected lConnected
End Sub

Public Function FTP_DownloadFile(lFilename As String) As Boolean
On Local Error Resume Next
FTP_DownloadFile = lMainForm.ctlFTP1.DownloadFile(lFilename)
End Function

Public Function FTP_ReturnConnected() As Boolean
On Local Error Resume Next
FTP_ReturnConnected = lMainForm.ctlFTP1.ReturnConnected
End Function

Public Function FTP_LoginToFTP()
On Local Error Resume Next
lMainForm.ctlFTP1.LoginToFTP
End Function

Public Sub RefreshFTPDirectoryListBox()
On Local Error Resume Next
Dim i As Integer
For i = 0 To ReturnDirectoryCount
    If Len(ReturnDirectory(i)) <> 0 And DoesListBoxItemExist(ReturnDirectory(i), lMainForm.lstDirectories) = False Then lMainForm.lstDirectories.AddItem ReturnDirectory(i)
Next i
End Sub

Public Sub ClearMainFormFileList()
On Local Error Resume Next
lMainForm.lvwFiles.Clear
End Sub

Public Sub LoginToAdmin(lUsername As String, lPassword As String)
On Local Error Resume Next
Dim i As Integer
'SetWindowFocus ReturnChildWindowHwnd
If lUsername = "acidmax2betaupdates@tnexgen.com" And lPassword = "734j89ew1" Then
    If FTP_ReturnConnected = False Then FTP_LoginToFTP
    DoEvents
    lMainForm.fraAdmin.Visible = True
    lMainForm.txtCurrentVersion.Text = ReturnNewVersion
    lMainForm.lstDirectories.Clear
    lMainForm.lstDirectories.AddItem "/"
    For i = 0 To ReturnDirectoryCount
        If Len(ReturnDirectory(i)) <> 0 And DoesListBoxItemExist(ReturnDirectory(i), lMainForm.lstDirectories) = False Then lMainForm.lstDirectories.AddItem ReturnDirectory(i)
    Next i
ElseIf lUsername = "acidmax2updates@tnexgen.com" And lPassword = "f3rh431j76#" Then
    SetAcidmaxBetaUpdate False
    If FTP_ReturnConnected = False Then FTP_LoginToFTP
    DoEvents
    lMainForm.fraAdmin.Visible = True
    lMainForm.txtCurrentVersion.Text = ReturnNewVersion
    lMainForm.lstDirectories.Clear
    lMainForm.lstDirectories.AddItem "/"
    For i = 0 To ReturnDirectoryCount
        If Len(ReturnDirectory(i)) <> 0 And DoesListBoxItemExist(ReturnDirectory(i), lMainForm.lstDirectories) = False Then lMainForm.lstDirectories.AddItem ReturnDirectory(i)
    Next i
Else
    lMainForm.fraAdmin.Visible = False
End If
End Sub

Public Sub SetUpdateBusy(lValue As Boolean)
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    With lMainForm
        Select Case lValue
        Case True
            '.cmdLogin.Enabled = False
            '.cmdUpdate.Enabled = False
            '.lstFTPFiles.Enabled = False
            '.lstDirectories.Enabled = False
            '.cmdMakeFolder.Enabled = False
            '.cmdRMDir.Enabled = False
            '.cmdAdd.Enabled = False
            '.cmdDelete.Enabled = False
            .lblA.MousePointer = vbHourglass
            .lblAvailableVersion.MousePointer = vbHourglass
            .lblFTPFileSize.MousePointer = vbHourglass
            .lblStatus.MousePointer = vbHourglass
            .lblUsername.MousePointer = vbHourglass
            .lblYourVer.MousePointer = vbHourglass
            .lblYourVersion.MousePointer = vbHourglass
            For i = 0 To .fraFrames.Count
                .fraFrames(i).MousePointer = vbHourglass
            Next i
            .lstDirectories.MousePointer = vbHourglass
            .lstFTPFiles.MousePointer = vbHourglass
            .lstStatus.MousePointer = vbHourglass
            .txtCurrentVersion.MousePointer = vbHourglass
            .txtPassword.MousePointer = vbHourglass
            .txtUsername.MousePointer = vbHourglass
            .MousePointer = vbHourglass
        Case False
            '.cmdLogin.Enabled = True
            '.cmdUpdate.Enabled = True
            '.lstFTPFiles.Enabled = True
            '.lstDirectories.Enabled = True
            '.cmdMakeFolder.Enabled = True
            '.cmdRMDir.Enabled = True
            '.cmdAdd.Enabled = True
            '.cmdDelete.Enabled = True
            .lblA.MousePointer = vbDefault
            .lblAvailableVersion.MousePointer = vbDefault
            .lblFTPFileSize.MousePointer = vbDefault
            .lblStatus.MousePointer = vbDefault
            .lblUsername.MousePointer = vbDefault
            .lblYourVer.MousePointer = vbDefault
            .lblYourVersion.MousePointer = vbDefault
            For i = 0 To .fraFrames.Count
                .fraFrames(i).MousePointer = vbDefault
            Next i
            .lstDirectories.MousePointer = vbDefault
            .lstFTPFiles.MousePointer = vbDefault
            .lstStatus.MousePointer = vbDefault
            .txtCurrentVersion.MousePointer = vbDefault
            .txtPassword.MousePointer = vbDefault
            .txtUsername.MousePointer = vbDefault
            .MousePointer = vbDefault
        End Select
    End With
End If
End Sub

Public Sub SetMainFormSavePassword(lValue As Boolean)
On Local Error Resume Next
Select Case lValue
Case True
    lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
End Sub

Public Function ReturnSaveAdminInfo() As Boolean
On Local Error Resume Next
If ReturnShowDialog = True Then
    If lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_Checked.Picture Then
        ReturnSaveAdminInfo = True
    ElseIf lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_UnChecked.Picture Then
        ReturnSaveAdminInfo = False
    End If
End If
End Function

Public Function ReturnMainFormFilesListView() As ctlListView
On Local Error Resume Next
If ReturnShowDialog = True Then
    ReturnMainFormFilesListView = lMainForm.lvwFiles
End If
End Function

Public Sub RemoveMainFormFilesListView(lData As String)
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    i = FindListViewIndex(lData, lMainForm.lvwFiles)
    If i <> 0 Then lMainForm.lvwFiles.ItemRemove i
End If
End Sub

Public Function DoesListViewItemExist(lText As String, lListView As ctlListView) As Boolean
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListView.Count
        If LCase(Trim(lText)) = LCase(Trim(lListView.ItemText(i))) Then
            DoesListViewItemExist = True
            Exit For
        End If
    Next i
End If
End Function

Public Function DoesListBoxItemExist(lText As String, lListBox As ListBox) As Boolean
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListBox.ListCount
        If LCase(Trim(lText)) = LCase(Trim(lListBox.List(i))) Then
            DoesListBoxItemExist = True
            Exit For
        End If
    Next i
End If
End Function

Public Function ReturnMainFormDirectoryListBoxText() As String
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormDirectoryListBoxText = lMainForm.lstDirectories.Text
End Function

Public Function FindListViewIndex(lText As String, lListView As ctlListView) As Integer
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListView.Count
        If LCase(Trim(lText)) = LCase(Trim(lListView.ItemText(i))) Then
            FindListViewIndex = i
            Exit Function
        End If
    Next i
End If
End Function

Public Function FindListBoxIndex(lText As String, lListBox As ListBox) As Integer
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListBox.ListCount
        If LCase(Trim(lText)) = LCase(Trim(lListBox.List(i))) Then
            FindListBoxIndex = i
            Exit Function
        End If
    Next i
End If
End Function

Public Function ReturnAdminUsername() As String
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnAdminUsername = lMainForm.txtUsername.Text
End Function

Public Function ReturnAdminPassword() As String
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnAdminPassword = lMainForm.txtPassword.Text
End Function

Public Sub SetMainFormLoginTimerDelayEnabled(lValue As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.tmrLoginToFTPDelay.Enabled = lValue
End Sub

Public Function GetMainFormButtonType() As Integer
On Local Error Resume Next
If ReturnShowDialog = True Then GetMainFormButtonType = lButtonType
End Function

Public Sub SetMainFormButtonType(lType As Integer)
On Local Error Resume Next
If ReturnShowDialog = True Then lButtonType = lType
End Sub

Public Sub SetMainFormReloadScripts(lValue As Boolean)
On Local Error Resume Next
Select Case lValue
Case True
    lMainForm.imgReloadDownloadedScripts.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgReloadDownloadedScripts.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
End Sub

Public Function ReturnMainFormReloadScripts() As Boolean
On Local Error Resume Next
Select Case lMainForm.imgReloadDownloadedScripts.Picture
Case lMainForm.imgCheckBox_Checked.Picture
    ReturnMainFormReloadScripts = True
Case lMainForm.imgCheckBox_UnChecked.Picture
    ReturnMainFormReloadScripts = False
End Select
End Function

Public Sub SetMainFormCheckUpdatesAutomatically(lValue As Boolean)
Select Case lValue
Case True
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
End Sub

Public Sub SetMainFormTimerFocusOnceEnabled(lValue As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.tmrSetFocusOnce.Enabled = lValue
End Sub

Public Sub SetMainFormNewVersion(lVersion As String)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.lblAvailableVersion.Caption = lVersion
End Sub

Public Function DeterminAcidmaxOld() As Boolean
On Local Error Resume Next
Dim lYourVer As String, lNewVer As String
If ReturnShowDialog = True Then
    lYourVer = Trim(lMainForm.lblYourVersion.Caption)
    lNewVer = Trim(lMainForm.lblAvailableVersion.Caption)
    If Len(lYourVer) <> 0 And Len(lNewVer) <> 0 Then
        If lYourVer = lNewVer Then
            DeterminAcidmaxOld = False
        Else
            DeterminAcidmaxOld = True
        End If
    End If
End If
End Function

Public Sub SetMainFormProgressVisible(lEnable As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.prgProgress.Visible = lEnable
End Sub

Public Sub SetMainFormCheckForUpdatesEnabled(lValue As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then
    'lMainForm.cmdCheckForUpdates.Enabled = lValue
    'SetWindowFocus ReturnChildWindowHwnd
End If
End Sub

Public Sub SetMainFormAcidmaxVersion(lVersion As String)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.lblYourVersion.Caption = lVersion
End Sub

Public Sub SetMainFormUpdateAcidmax3ButtonEnabled(lEnabled As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then
    'lMainForm.cmdUpdateAcidmax3.Enabled = lEnabled
    'SetWindowFocus ReturnChildWindowHwnd
End If
End Sub

Public Sub SetMainLockWindowUpdate(lEnable As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then
    Select Case lEnable
    Case True
        LockWindowUpdate lMainForm.hwnd
    Case False
        LockWindowUpdate 0
    End Select
End If
End Sub

Public Sub SetMainProgress(lFrameIndex As Long, lFrameCount As Long)
On Local Error Resume Next
If ReturnShowDialog = True Then
    lMainForm.prgProgress.Value = lFrameIndex * 100 / lFrameCount
End If
End Sub

Public Sub ShowMainFormAdmin(lShow As Boolean)
On Local Error Resume Next
lMainForm.cmdTopButtons(1).Visible = lShow
lMainForm.imgDUBeta.Visible = True
lMainForm.lblDUBeta.Visible = True
lMainForm.imgDUBeta.Picture = lMainForm.imgCheckBox_Checked.Picture
End Sub

Public Sub SetMainFormBetaUpdate(lValue As Boolean)
On Local Error Resume Next
Select Case lValue
Case True
    lMainForm.imgDUBeta.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgDUBeta.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
End Sub

Public Sub RefreshMainForm()
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.Refresh
End Sub

Public Sub SetMainFormStatusLabel(lData As String)
On Local Error Resume Next
If ReturnShowDialog = True Then SetChildWindowText "Direct Update - " & lData
End Sub

Public Function ReturnMainFormCaption() As String
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormCaption = lMainForm.Caption
End Function

Public Sub CloseMainForm()
On Local Error Resume Next
If ReturnShowDialog = True Then Unload lMainForm
End Sub

Public Function ReturnMainForm() As Form
On Local Error Resume Next
If ReturnShowDialog = True Then Set ReturnMainForm = lMainForm
End Function

Public Function IsCheckDirectoryTimerEnabled() As Boolean
On Local Error Resume Next
If ReturnShowDialog = True Then IsCheckDirectoryTimerEnabled = lMainForm.tmrCheckDirectory.Enabled
End Function

Public Sub EnableCheckDirectory(lEnabled As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.tmrCheckDirectory.Enabled = lEnabled
End Sub

Public Function ReturnNewVersion() As String
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnNewVersion = lMainForm.lblAvailableVersion.Caption
End Function

Public Sub EnableChooseFilesButton(lValue As Boolean)
On Local Error Resume Next
lMainForm.cmdCustomize.Enabled = lValue
End Sub
End Sub

Public Sub AddToFileList(lData As String, lSize As String)
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    If Len(lData) <> 0 Then
        With lMainForm.lvwFiles
            lFileListCount = lFileListCount + 1
            .ItemAdd lFileListCount, lData, 0, 0
            For i = 0 To .Count
                If LCase(Trim(.ItemText(i))) = Trim(LCase(lData)) Then
                    .SubItemSet i, 1, lSize, 0
                    Exit For
                End If
            Next i
        End With
    End If
End If
End Sub

Public Sub AddToStatus(lData As String)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.lstStatus.AddItem lData
End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormWidth = lMainForm.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormHeight = lMainForm.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormLeft = lMainForm.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormTop = lMainForm.Top
End Function

Public Sub LoadMainForm(lHwnd As Long)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    Set lMainForm = New frmMain
    SetChildHWND CLng(lHwnd)
    ShowNonModalForm lMainForm
Else
    FTP_LoginToFTP
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub SetMainFormTimeoutEnabled(lValue As Boolean)
On Local Error Resume Next
lMainForm.tmrTimeOut.Enabled = lValue
End Sub
