Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lMainForm As New frmMain
Private lButtonType As Integer
Private Declare Function LockWindowUpdate Lib "user32" (ByVal hwndLock As Long) As Long
Private lStartUrl As String

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lMainForm.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lMainForm.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lMainForm.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lMainForm.Top
End Function

Public Sub SetMainFormBackground(lBackground As String)
On Local Error Resume Next
Dim i As Integer, w As Boolean
If ReturnSettingsUseThemeColor = True Then
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
        .Refresh
    End With
End If
End Sub

Public Function DoesListBoxItemExist(lText As String, lListBox As ListBox) As Boolean
On Local Error Resume Next
Dim i As Integer
For i = 0 To lListBox.ListCount
    If LCase(Trim(lText)) = LCase(Trim(lListBox.List(i))) Then
        DoesListBoxItemExist = True
        Exit For
    End If
Next i
End Function

Public Function FindListBoxIndex(lText As String, lListBox As ListBox) As Integer
On Local Error Resume Next
Dim i As Integer
For i = 0 To lListBox.ListCount
    If LCase(Trim(lText)) = LCase(Trim(lListBox.List(i))) Then
        FindListBoxIndex = i
        Exit Function
    End If
Next i
End Function

Public Function GetMainFormButtonType() As Integer
On Local Error Resume Next
GetMainFormButtonType = lButtonType
End Function

Public Sub SetMainFormButtonType(lType As Integer)
On Local Error Resume Next
lButtonType = lType
End Sub

Public Function ReturnMainFormCaption() As String
On Local Error Resume Next
ReturnMainFormCaption = lMainForm.Caption
End Function

Public Sub CloseMainForm()
On Local Error Resume Next
Unload lMainForm
End Sub

Public Function ReturnMainForm() As Form
On Local Error Resume Next
Set ReturnMainForm = lMainForm
End Function

Public Sub LoadMainForm(lHwnd As Long)
On Local Error Resume Next
Set lMainForm = New frmMain
SetParentHwnd CLng(Trim(lHwnd))
ShowNonModalForm lMainForm
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function ReturnStartURL() As String
On Local Error GoTo ErrHandler
ReturnStartURL = lStartUrl
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Sub GoURL1(lUrl As String)
On Local Error GoTo ErrHandler
lMainForm.cboURL.AddItem lUrl
lMainForm.ctlBrowser.Navigate lUrl
Exit Sub
ErrHandler:
    Err.Clear
End Sub
