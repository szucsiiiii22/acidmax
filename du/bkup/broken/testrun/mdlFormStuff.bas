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
On Local Error GoTo ErrHandler
Dim lFlag As Integer
If SetOnTop Then
    lFlag = HWND_TOPMOST
Else
    lFlag = HWND_NOTOPMOST
End If
SetWindowPos myfrm.hwnd, lFlag, myfrm.Left / Screen.TwipsPerPixelX, myfrm.Top / Screen.TwipsPerPixelY, myfrm.Width / Screen.TwipsPerPixelX, myfrm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
Exit Sub
ErrHandler:
    ProcessError "Public Sub AlwaysOnTop(myfrm As Form, SetOnTop As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub HideMainForm()
On Local Error GoTo ErrHandler
lMainForm.Visible = False
Exit Sub
ErrHandler:
    ProcessError "Public Sub HideMainForm()", Err.Description
    Err.Clear
End Sub

Public Sub SetFormCenter(lForm As Form)
On Local Error GoTo ErrHandler
lForm.Left = (Screen.Width - lForm.ScaleWidth) / 2
lForm.Top = (Screen.Height - lForm.ScaleHeight) / 2 + 100
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetFormCenter(lForm As Form)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormDoEventsTimerEnabled(lValue As Boolean)
On Local Error GoTo ErrHandler
lMainForm.tmrDoEvents.Enabled = lValue
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormDoEventsTimerEnabled(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormAutoCheck(lValue As Boolean)
On Local Error GoTo ErrHandler
Select Case lValue
Case True
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormAutoCheck(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Function ReturnMainFormAutoUpdate() As Boolean
On Local Error GoTo ErrHandler
Select Case lMainForm.imgUpdateAutomatically.Picture
Case lMainForm.imgCheckBox_Checked.Picture
    ReturnMainFormAutoUpdate = True
Case lMainForm.imgCheckBox_UnChecked.Picture
    ReturnMainFormAutoUpdate = False
End Select
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormAutoUpdate() As Boolean", Err.Description
    Err.Clear
End Function

Public Function ReturnMainFormAutoCheck() As Boolean
On Local Error GoTo ErrHandler
Select Case lMainForm.imgCheckUpdatesAutomatically.Picture
Case lMainForm.imgCheckBox_Checked.Picture
    ReturnMainFormAutoCheck = True
Case lMainForm.imgCheckBox_UnChecked.Picture
    ReturnMainFormAutoCheck = False
End Select
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormAutoCheck() As Boolean", Err.Description
    Err.Clear
End Function

Public Sub SetMainFormAutoUpdate(lValue As Boolean)
On Local Error GoTo ErrHandler
Select Case lValue
Case True
    lMainForm.imgUpdateAutomatically.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgUpdateAutomatically.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormAutoUpdate(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub FTP_CloseConnection()
On Local Error GoTo ErrHandler
lMainForm.ctlFTP1.CloseConnection
Exit Sub
ErrHandler:
    ProcessError "Public Sub FTP_CloseConnection()", Err.Description
    Err.Clear
End Sub

Public Sub FTP_EnterFTPDirectory(lDirectory As String)
On Local Error GoTo ErrHandler
lMainForm.ctlFTP1.EnterFTPDirectory lDirectory
Exit Sub
ErrHandler:
    ProcessError "Public Sub FTP_EnterFTPDirectory(lDirectory As String)", Err.Description
    Err.Clear
End Sub

Public Sub FTP_SetConnected(lConnected As Boolean)
On Local Error GoTo ErrHandler
lMainForm.ctlFTP1.SetConnected lConnected
Exit Sub
ErrHandler:
    ProcessError "Public Sub FTP_SetConnected(lConnected As Boolean)", Err.Description
    Err.Clear
End Sub

Public Function FTP_DownloadFile(lFilename As String) As Boolean
On Local Error GoTo ErrHandler
FTP_DownloadFile = lMainForm.ctlFTP1.DownloadFile(lFilename)
Exit Function
ErrHandler:
    ProcessError "Public Function FTP_DownloadFile(lFilename As String) As Boolean", Err.Description
    Err.Clear
End Function

Public Function FTP_ReturnConnected() As Boolean
On Local Error GoTo ErrHandler
FTP_ReturnConnected = lMainForm.ctlFTP1.ReturnConnected
Exit Function
ErrHandler:
    ProcessError "Public Function FTP_ReturnConnected() As Boolean", Err.Description
    Err.Clear
End Function

Public Function FTP_LoginToFTP()
On Local Error GoTo ErrHandler
lMainForm.ctlFTP1.LoginToFTP
Exit Function
ErrHandler:
    ProcessError "Public Function FTP_LoginToFTP()", Err.Description
    Err.Clear
End Function

Public Sub RefreshFTPDirectoryListBox()
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To ReturnDirectoryCount
    If Len(ReturnDirectory(i)) <> 0 And DoesListBoxItemExist(ReturnDirectory(i), lMainForm.lstDirectories) = False Then lMainForm.lstDirectories.AddItem ReturnDirectory(i)
Next i
Exit Sub
ErrHandler:
    ProcessError "Public Sub RefreshFTPDirectoryListBox()", Err.Description
    Err.Clear
End Sub

Public Sub ClearMainFormFileList()
On Local Error GoTo ErrHandler
lMainForm.lvwFiles.Clear
Exit Sub
ErrHandler:
    ProcessError "Public Sub ClearMainFormFileList()", Err.Description
    Err.Clear
End Sub

Public Sub LoginToAdmin(lUsername As String, lPassword As String)
On Local Error GoTo ErrHandler
Dim i As Integer
If FTP_ReturnConnected = False Then FTP_LoginToFTP
DoEvents
lMainForm.fraAdmin.Visible = False
lMainForm.txtCurrentVersion.Text = ReturnNewVersion
lMainForm.lstDirectories.Clear
lMainForm.lstDirectories.AddItem "/"
For i = 0 To ReturnDirectoryCount
    If Len(ReturnDirectory(i)) <> 0 And DoesListBoxItemExist(ReturnDirectory(i), lMainForm.lstDirectories) = False Then lMainForm.lstDirectories.AddItem ReturnDirectory(i)
Next i
Exit Sub
ErrHandler:
    ProcessError "Public Sub LoginToAdmin(lUsername As String, lPassword As String)", Err.Description
    Err.Clear
End Sub

Public Sub SetUpdateBusy(lValue As Boolean)
On Local Error GoTo ErrHandler
Dim i As Integer
If ReturnShowDialog = True Then
    With lMainForm
        Select Case lValue
        Case True
            .cmdLogin.Enabled = False
            .cmdUpdate.Enabled = False
            .lstFTPFiles.Enabled = False
            .lstDirectories.Enabled = False
            .cmdMakeFolder.Enabled = False
            .cmdRMDir.Enabled = False
            .cmdAdd.Enabled = False
            .cmdDelete.Enabled = False
            .lblA.MousePointer = vbHourglass
            .lblAvailableVersion.MousePointer = vbHourglass
            .lblFTPFileSize.MousePointer = vbHourglass
            .lblStatus.MousePointer = vbHourglass
            .lblUsername.MousePointer = vbHourglass
            .lblYourVer.MousePointer = vbHourglass
            .lblYourVersion.MousePointer = vbHourglass
            For i = 0 To .fraFrames.Count - 1
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
            .cmdLogin.Enabled = True
            .cmdUpdate.Enabled = True
            .lstFTPFiles.Enabled = True
            .lstDirectories.Enabled = True
            .cmdMakeFolder.Enabled = True
            .cmdRMDir.Enabled = True
            .cmdAdd.Enabled = True
            .cmdDelete.Enabled = True
            .lblA.MousePointer = vbDefault
            .lblAvailableVersion.MousePointer = vbDefault
            .lblFTPFileSize.MousePointer = vbDefault
            .lblStatus.MousePointer = vbDefault
            .lblUsername.MousePointer = vbDefault
            .lblYourVer.MousePointer = vbDefault
            .lblYourVersion.MousePointer = vbDefault
            For i = 0 To .fraFrames.Count - 1
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
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetUpdateBusy(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormSavePassword(lValue As Boolean)
On Local Error GoTo ErrHandler
Select Case lValue
Case True
    lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormSavePassword(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Function ReturnSaveAdminInfo() As Boolean
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    If lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_Checked.Picture Then
        ReturnSaveAdminInfo = True
    ElseIf lMainForm.imgSavePassword.Picture = lMainForm.imgCheckBox_UnChecked.Picture Then
        ReturnSaveAdminInfo = False
    End If
End If
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnSaveAdminInfo() As Boolean", Err.Description
    Err.Clear
End Function

Public Function ReturnMainFormFilesListView() As ctlListView
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    If lMainForm Is Nothing Then
        If Not lMainForm.lvwFiles Is Nothing Then
            ReturnMainFormFilesListView = lMainForm.lvwFiles
        End If
    End If
End If
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormFilesListView() As ctlListView", Err.Description
    Err.Clear
End Function

Public Sub RemoveMainFormFilesListView(lData As String)
On Local Error GoTo ErrHandler
Dim i As Integer
If ReturnShowDialog = True Then
    i = FindListViewIndex(lData, lMainForm.lvwFiles)
    If i <> 0 Then lMainForm.lvwFiles.ItemRemove i
End If
Exit Sub
ErrHandler:
    ProcessError "Public Sub RemoveMainFormFilesListView(lData As String)", Err.Description
    Err.Clear
End Sub

Public Function DoesListViewItemExist(lText As String, lListView As ctlListView) As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
If ReturnShowDialog = True Then
    If Not lListView Is Nothing Then
        For i = 0 To lListView.Count - 1
            If LCase(Trim(lText)) = LCase(Trim(lListView.ItemText(i))) Then
                DoesListViewItemExist = True
                Exit For
            End If
        Next i
    End If
End If
Exit Function
ErrHandler:
    ProcessError "Public Function DoesListViewItemExist(lText As String, lListView As ctlListView) As Boolean", Err.Description
    Err.Clear
End Function

Public Function DoesListBoxItemExist(lText As String, lListBox As ListBox) As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListBox.ListCount
        If LCase(Trim(lText)) = LCase(Trim(lListBox.List(i))) Then
            DoesListBoxItemExist = True
            Exit For
        End If
    Next i
End If
Exit Function
ErrHandler:
    ProcessError "Public Function DoesListBoxItemExist(lText As String, lListBox As ListBox) As Boolean", Err.Description
    Err.Clear
End Function

Public Function ReturnMainFormDirectoryListBoxText() As String
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnMainFormDirectoryListBoxText = lMainForm.lstDirectories.Text
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormDirectoryListBoxText() As String", Err.Description
    Err.Clear
End Function

Public Function FindListViewIndex(lText As String, lListView As ctlListView) As Integer
On Local Error GoTo ErrHandler
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListView.Count
        If LCase(Trim(lText)) = LCase(Trim(lListView.ItemText(i))) Then
            FindListViewIndex = i
            Exit Function
        End If
    Next i
End If
Exit Function
ErrHandler:
    ProcessError "Public Function FindListViewIndex(lText As String, lListView As ctlListView) As Integer", Err.Description
    Err.Clear
End Function

Public Function FindListBoxIndex(lText As String, lListBox As ListBox) As Integer
On Local Error GoTo ErrHandler
Dim i As Integer
If ReturnShowDialog = True Then
    For i = 0 To lListBox.ListCount
        If LCase(Trim(lText)) = LCase(Trim(lListBox.List(i))) Then
            FindListBoxIndex = i
            Exit Function
        End If
    Next i
End If
Exit Function
ErrHandler:
    ProcessError "Public Function FindListBoxIndex(lText As String, lListBox As ListBox) As Integer", Err.Description
    Err.Clear
End Function

Public Function ReturnAdminUsername() As String
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnAdminUsername = lMainForm.txtUsername.Text
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnAdminUsername() As String", Err.Description
    Err.Clear
End Function

Public Function ReturnAdminPassword() As String
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnAdminPassword = lMainForm.txtPassword.Text
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnAdminPassword() As String", Err.Description
    Err.Clear
End Function

Public Sub SetMainFormLoginTimerDelayEnabled(lValue As Boolean)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.tmrLoginToFTPDelay.Enabled = lValue
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormLoginTimerDelayEnabled(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Function GetMainFormButtonType() As Integer
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then GetMainFormButtonType = lButtonType
Exit Function
ErrHandler:
    ProcessError "Public Function GetMainFormButtonType() As Integer", Err.Description
    Err.Clear
End Function

Public Sub SetMainFormButtonType(lType As Integer)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lButtonType = lType
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormButtonType(lType As Integer)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormReloadScripts(lValue As Boolean)
On Local Error GoTo ErrHandler
Select Case lValue
Case True
    lMainForm.imgReloadDownloadedScripts.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgReloadDownloadedScripts.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormReloadScripts(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Function ReturnMainFormReloadScripts() As Boolean
On Local Error GoTo ErrHandler
Select Case lMainForm.imgReloadDownloadedScripts.Picture
Case lMainForm.imgCheckBox_Checked.Picture
    ReturnMainFormReloadScripts = True
Case lMainForm.imgCheckBox_UnChecked.Picture
    ReturnMainFormReloadScripts = False
End Select
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormReloadScripts() As Boolean", Err.Description
    Err.Clear
End Function

Public Sub SetMainFormCheckUpdatesAutomatically(lValue As Boolean)
On Local Error GoTo ErrHandler
Select Case lValue
Case True
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_Checked.Picture
Case False
    lMainForm.imgCheckUpdatesAutomatically.Picture = lMainForm.imgCheckBox_UnChecked.Picture
End Select
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormCheckUpdatesAutomatically(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormNewVersion(lVersion As String)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.lblAvailableVersion.Caption = lVersion
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormNewVersion(lVersion As String)", Err.Description
    Err.Clear
End Sub

Public Function DeterminAcidmaxOld() As Boolean
On Local Error GoTo ErrHandler
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
Exit Function
ErrHandler:
    ProcessError "Public Function DeterminAcidmaxOld() As Boolean", Err.Description
    Err.Clear
End Function

Public Sub SetMainFormProgressVisible(lEnable As Boolean)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.prgProgress.Visible = lEnable
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormProgressVisible(lEnable As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormCheckForUpdatesEnabled(lValue As Boolean)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    lMainForm.cmdCheckForUpdates.Enabled = lValue
End If
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormCheckForUpdatesEnabled(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormAcidmaxVersion(lVersion As String)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.lblYourVersion.Caption = lVersion
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormAcidmaxVersion(lVersion As String)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormUpdateAcidmax3ButtonEnabled(lEnabled As Boolean)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    lMainForm.cmdUpdateAcidmax3.Enabled = lEnabled
End If
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormUpdateAcidmax3ButtonEnabled(lEnabled As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainLockWindowUpdate(lEnable As Boolean)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    Select Case lEnable
    Case True
        LockWindowUpdate lMainForm.hwnd
    Case False
        LockWindowUpdate 0
    End Select
End If
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainLockWindowUpdate(lEnable As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainProgress(lFrameIndex As Long, lFrameCount As Long)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then
    lMainForm.prgProgress.Value = lFrameIndex * 100 / lFrameCount
End If
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainProgress(lFrameIndex As Long, lFrameCount As Long)", Err.Description
    Err.Clear
End Sub

Public Sub ShowMainFormAdmin(lShow As Boolean)
On Local Error GoTo ErrHandler
lMainForm.cmdTopButtons(1).Visible = lShow
Exit Sub
ErrHandler:
    ProcessError "Public Sub ShowMainFormAdmin(lShow As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub RefreshMainForm()
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.Refresh
Exit Sub
ErrHandler:
    ProcessError "Public Sub RefreshMainForm()", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormStatusLabel(lData As String)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then SetChildWindowText "Direct Update - " & lData
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormStatusLabel(lData As String)", Err.Description
    Err.Clear
End Sub

Public Function ReturnMainFormCaption() As String
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnMainFormCaption = lMainForm.Caption
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormCaption() As String", Err.Description
    Err.Clear
End Function

Public Sub CloseMainForm()
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then Unload lMainForm
Exit Sub
ErrHandler:
    ProcessError "Public Sub CloseMainForm()", Err.Description
    Err.Clear
End Sub

Public Function ReturnMainForm() As Form
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then Set ReturnMainForm = lMainForm
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainForm() As Form", Err.Description
    Err.Clear
End Function

Public Function IsCheckDirectoryTimerEnabled() As Boolean
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then IsCheckDirectoryTimerEnabled = lMainForm.tmrCheckDirectory.Enabled
Exit Function
ErrHandler:
    ProcessError "Public Function IsCheckDirectoryTimerEnabled() As Boolean", Err.Description
    Err.Clear
End Function

Public Sub EnableCheckDirectory(lEnabled As Boolean)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.tmrCheckDirectory.Enabled = lEnabled
Exit Sub
ErrHandler:
    ProcessError "Public Sub EnableCheckDirectory(lEnabled As Boolean)", Err.Description
    Err.Clear
End Sub

Public Function ReturnNewVersion() As String
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnNewVersion = lMainForm.lblAvailableVersion.Caption
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnNewVersion() As String", Err.Description
    Err.Clear
End Function

Public Sub EnableChooseFilesButton(lValue As Boolean)
On Local Error GoTo ErrHandler
lMainForm.cmdCustomize.Enabled = lValue
Exit Sub
ErrHandler:
    ProcessError "Public Sub EnableChooseFilesButton(lValue As Boolean)", Err.Description
    Err.Clear
End Sub

Public Sub AddToFileList(lData As String, lSize As String)
On Local Error GoTo ErrHandler
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
Exit Sub
ErrHandler:
    ProcessError "Public Sub AddToFileList(lData As String, lSize As String)", Err.Description
    Err.Clear
End Sub

Public Sub AddToStatus(lData As String)
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then lMainForm.lstStatus.AddItem lData
Exit Sub
ErrHandler:
    ProcessError "Public Sub AddToStatus(lData As String)", Err.Description
    Err.Clear
End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnMainFormWidth = lMainForm.Width
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormWidth() As Long", Err.Description
    Err.Clear
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnMainFormHeight = lMainForm.Height
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormHeight() As Long", Err.Description
    Err.Clear
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnMainFormLeft = lMainForm.Left
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormLeft() As Long", Err.Description
    Err.Clear
End Function

Public Function ReturnMainFormTop() As Long
On Local Error GoTo ErrHandler
If ReturnShowDialog = True Then ReturnMainFormTop = lMainForm.Top
Exit Function
ErrHandler:
    ProcessError "Public Function ReturnMainFormTop() As Long", Err.Description
    Err.Clear
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
    ProcessError "Public Sub LoadMainForm(lHwnd As Long)", Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormTimeoutEnabled(lValue As Boolean)
On Local Error GoTo ErrHandler
lMainForm.tmrTimeOut.Enabled = lValue
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetMainFormTimeoutEnabled(lValue As Boolean)", Err.Description
    Err.Clear
End Sub
