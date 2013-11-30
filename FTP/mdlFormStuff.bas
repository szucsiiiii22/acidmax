Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lMainForm As New frmMain
Private lButtonType As Integer
Private Declare Function LockWindowUpdate Lib "user32" (ByVal hwndLock As Long) As Long

Public Sub AddToFileListBox(lFile As String)
On Local Error Resume Next
lMainForm.lstFTPFiles.AddItem lFile
End Sub

Public Sub AddtoFolderListBox(lFolder As String)
On Local Error Resume Next
lMainForm.lstDirectories.AddItem lFolder
End Sub

Public Sub RefreshFTPDirectoryListBox()
On Local Error Resume Next
Dim i As Integer
For i = 0 To ReturnDirectoryCount
    If Len(ReturnDirectory(i)) <> 0 And DoesListBoxItemExist(ReturnDirectory(i), lMainForm.lstDirectories) = False Then lMainForm.lstDirectories.AddItem ReturnDirectory(i)
Next i
End Sub

Public Sub SetFTPBusy(lValue As Boolean)
On Local Error Resume Next
Dim i As Integer
If ReturnShowDialog = True Then
    With lMainForm
        Select Case lValue
        Case True
            .cmdLogin.Enabled = False
            .lstFTPFiles.Enabled = False
            .lstDirectories.Enabled = False
            .cmdMakeFolder.Enabled = False
            .cmdRMDir.Enabled = False
            .cmdAdd.Enabled = False
            .cmdDelete.Enabled = False
            .lblFTPFileSize.MousePointer = vbHourglass
            .lblProgress.MousePointer = vbHourglass
            'For i = 0 To .fraFrames.Count
            '    .fraFrames(i).MousePointer = vbHourglass
            'Next i
            .lstDirectories.MousePointer = vbHourglass
            .lstFTPFiles.MousePointer = vbHourglass
            .MousePointer = vbHourglass
        Case False
            .cmdLogin.Enabled = True
            .lstFTPFiles.Enabled = True
            .lstDirectories.Enabled = True
            .cmdMakeFolder.Enabled = True
            .cmdRMDir.Enabled = True
            .cmdAdd.Enabled = True
            .cmdDelete.Enabled = True
            .lblFTPFileSize.MousePointer = vbDefault
            .lblProgress.MousePointer = vbDefault
            'For i = 0 To .fraFrames.Count
            '    .fraFrames(i).MousePointer = vbDefault
            'Next i
            .lstDirectories.MousePointer = vbDefault
            .lstFTPFiles.MousePointer = vbDefault
            .MousePointer = vbDefault
        End Select
    End With
End If
End Sub

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

Public Sub SetMainFormTimerFocusOnceEnabled(lValue As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.tmrSetFocusOnce.Enabled = lValue
End Sub

Public Sub SetMainFormProgressVisible(lEnable As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then
    Select Case lEnable
    Case True
        lMainForm.shpPercent.Visible = True
        lMainForm.shpBackground.Visible = True
        lMainForm.lblInsideProgress.Visible = True
        lMainForm.lblProgress.Visible = True
    Case False
        lMainForm.shpPercent.Visible = False
        lMainForm.shpBackground.Visible = False
        lMainForm.lblInsideProgress.Visible = False
        lMainForm.lblProgress.Visible = False
    End Select
End If
End Sub

'Public Sub SetMainFormAcidmaxVersion(lVersion As String)
'On Local Error Resume Next
'If ReturnShowDialog = True Then lMainForm.lblYourVersion.Caption = lVersion
'End Sub

Public Sub SetMainLockWindowUpdate(lEnable As Boolean)
On Local Error Resume Next
If ReturnShowDialog = True Then
    Select Case lEnable
    Case True
        LockWindowUpdate lMainForm.hWnd
    Case False
        LockWindowUpdate 0
    End Select
End If
End Sub

Public Sub SetMainProgress(lFrameIndex As Long, lFrameCount As Long)
On Local Error Resume Next
If ReturnShowDialog = True Then
    lMainForm.shpPercent.Width = lFrameIndex * 1800 / lFrameCount
    lMainForm.lblInsideProgress.Caption = Str(Int(lFrameIndex * 100 / lFrameCount)) & "%"
End If
End Sub

Public Sub SetMainFormBackground(lBackground As String)
On Local Error Resume Next
Dim i As Integer, w As Boolean
If ReturnShowDialog = True Then
    Select Case Int(lBackground)
    Case 0
        lBackground = RGB(255, 255, 255)
        w = True
    Case 1
        lBackground = RGB(0, 0, 0)
    Case 2
        lBackground = RGB(0, 0, 127)
    Case 3
        lBackground = RGB(0, 147, 0)
    Case 4
        lBackground = RGB(255, 0, 0)
    Case 5
        lBackground = RGB(127, 0, 0)
    Case 6
        lBackground = RGB(0, 0, 0)
        'lBackground = RGB(156, 0, 156)
    Case 7
        lBackground = RGB(252, 127, 0)
        w = True
    Case 8
        lBackground = RGB(255, 255, 0)
        w = True
    Case 9
        lBackground = RGB(0, 252, 0)
    Case 10
        lBackground = RGB(0, 147, 147)
    Case 11
        lBackground = RGB(0, 255, 255)
        w = True
    Case 12
        lBackground = RGB(0, 0, 252)
    Case 13
        lBackground = RGB(255, 0, 255)
        w = True
    Case 14
        lBackground = RGB(127, 127, 127)
    Case 15
        lBackground = RGB(210, 210, 210)
        w = True
    End Select
    With lMainForm
        .BackColor = lBackground
        'For i = 0 To .fraFrames.Count
        '    .fraFrames(i).BackColor = lBackground
        'Next i
        If w = True Then
'            .lblA.ForeColor = vbBlack
'            .lblAvailableVersion.ForeColor = vbBlack
            .lblInsideProgress.ForeColor = vbBlack
            .lblProgress.ForeColor = vbBlack
'            .lblYourVer.ForeColor = vbBlack
'            .lblYourVersion.ForeColor = vbBlack
        Else
            .lblInsideProgress.ForeColor = vbWhite
            .lblProgress.ForeColor = vbWhite
        End If
        .Refresh
    End With
End If
End Sub

Public Sub RefreshMainForm()
On Local Error Resume Next
If ReturnShowDialog = True Then lMainForm.Refresh
End Sub

Public Sub SetMainFormStatusLabel(lData As String)
On Local Error Resume Next
If ReturnShowDialog = True Then SetChildWindowText "Acidmax FTP - " & lData
End Sub

Public Function ReturnMainFormCaption() As String
On Local Error Resume Next
If ReturnShowDialog = True Then ReturnMainFormCaption = lMainForm.Caption
End Function

Public Sub CloseMainForm()
On Local Error Resume Next
If ReturnShowDialog = True Then Unload lMainForm
'Set lMainForm = Nothing
End Sub

Public Function ReturnMainForm() As Form
On Local Error Resume Next
If ReturnShowDialog = True Then Set ReturnMainForm = lMainForm
End Function

Public Sub AddToStatus(lData As String)
On Local Error Resume Next
'If ReturnShowDialog = True Then lMainForm.lstStatus.AddItem lData
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
    LoginToFTP
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub
