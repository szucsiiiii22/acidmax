VERSION 5.00
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "control panel"
   ClientHeight    =   5655
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7815
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Raleway"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "frmMain.frx":000C
   ScaleHeight     =   377
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   521
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Timer tmrResize 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3120
      Top             =   4680
   End
   Begin VB.FileListBox File1 
      Appearance      =   0  'Flat
      Height          =   420
      Left            =   4320
      Pattern         =   "*.ini"
      TabIndex        =   5
      Top             =   4680
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox picBottom 
      BackColor       =   &H00404040&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      ScaleHeight     =   255
      ScaleWidth      =   7680
      TabIndex        =   1
      Top             =   5280
      Width           =   7680
      Begin VB.Label lblInformation 
         BackStyle       =   0  'Transparent
         Caption         =   "cpanel"
         BeginProperty Font 
            Name            =   "Raleway"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   0
         TabIndex        =   2
         Top             =   30
         Width           =   5175
      End
   End
   Begin VB.Timer tmrShowMain 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   3720
      Top             =   4680
   End
   Begin VB.PictureBox picOtherPanels 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5295
      Left            =   0
      Picture         =   "frmMain.frx":015E
      ScaleHeight     =   5295
      ScaleWidth      =   3000
      TabIndex        =   3
      Top             =   0
      Width           =   3000
      Begin cpanel.ctlListView ctlLeftNav 
         Height          =   2055
         Left            =   240
         TabIndex        =   4
         Top             =   645
         Width           =   2520
         _ExtentX        =   4445
         _ExtentY        =   3625
      End
      Begin VB.Label lblHelpTopic 
         BackStyle       =   0  'Transparent
         Caption         =   "How to modify Control Panel"
         BeginProperty Font 
            Name            =   "Raleway"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   735
         Index           =   0
         Left            =   840
         MouseIcon       =   "frmMain.frx":35CB4
         MousePointer    =   99  'Custom
         TabIndex        =   6
         Top             =   3720
         Width           =   1275
      End
   End
   Begin cpanel.ctlListView ctlCPanel 
      Height          =   4455
      Left            =   3000
      TabIndex        =   0
      Top             =   0
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   7858
   End
   Begin VB.TextBox TextViewer 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FFFFFF&
      Height          =   4455
      Left            =   3000
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Top             =   0
      Visible         =   0   'False
      Width           =   4335
   End
   Begin VB.Image imgTemp 
      Height          =   495
      Left            =   4800
      Top             =   4680
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Image imgCPanelList 
      Height          =   360
      Index           =   0
      Left            =   600
      Top             =   840
      Visible         =   0   'False
      Width           =   360
   End
   Begin VB.Image imgExitNormal 
      Height          =   210
      Left            =   120
      Picture         =   "frmMain.frx":35E06
      Top             =   1320
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgExitDown 
      Height          =   210
      Left            =   360
      Picture         =   "frmMain.frx":360E8
      Top             =   1320
      Visible         =   0   'False
      Width           =   240
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private lCurrentItem As Integer
Private lCurrentItemIndex As Integer
Private lCurrentLeftNavItem As Integer
Private Const WM_SETTEXT = &HC
Private Const WM_CHAR = &H102
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Integer
Private Declare Sub ReleaseCapture Lib "user32" ()
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Type gListViewItem
    lTitle As String
    lToolTip As String
    lCommand As String
    lImage As String
    lImageIndex As Integer
End Type
Private lListViewItems(100) As gListViewItem
Private Enum eWindowThemes
    wWindowClassic = 1
    wWindowXP = 2
End Enum
Private Type gCPanelOptions
    cSort As Boolean
    cWindowTheme As eWindowThemes
    cShowLeftNav As Boolean
End Type
Private lCPanelOptions As gCPanelOptions
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private lVarRect As RECT, lVarLong As Long
Private lTitleBarHeight As Long

Sub GetWindowSize(ByVal hWnd As Long, Width As Long, Height As Long)
Dim rc As RECT
GetWindowRect hWnd, rc
Width = rc.Right - rc.Left
Height = rc.Bottom - rc.Top
End Sub

Public Function DoesFileExist(lFileName As String) As Boolean
Dim msg As String
msg = Dir(lFileName)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
End Function

Public Function ReadFile(lFile As String) As String
On Local Error Resume Next
Dim n As Integer, msg As String
n = FreeFile
If DoesFileExist(lFile) = True Then
    Open lFile For Input As #n
        msg = StrConv(InputB(LOF(n), n), vbUnicode)
        If Len(msg) <> 0 Then
            ReadFile = Left(msg, Len(msg) - 2)
        End If
    Close #n
End If
End Function

Public Sub ShowTextFile(lFile As String)
Dim msg As String
If Len(lFile) <> 0 Then
    msg = ReadFile(lFile)
    If Len(msg) <> 0 Then
        TextViewer.Visible = True
        ctlCPanel.Visible = False
        TextViewer.Text = msg
    End If
End If
End Sub

Public Sub RefreshHelpTopics()
Dim i As Integer
For i = 0 To (lblHelpTopic.Count - 1)
    lblHelpTopic(i).ForeColor = vbWhite
Next i
End Sub

Public Sub ClearItems()
Dim i As Integer
For i = 0 To 100
    lListViewItems(i).lCommand = ""
    lListViewItems(i).lImage = ""
    lListViewItems(i).lImageIndex = 0
    lListViewItems(i).lTitle = ""
    lListViewItems(i).lToolTip = ""
Next i
ctlCPanel.Clear
End Sub

Public Function GetFileTitle(lFileName As String) As String
On Local Error Resume Next
Dim msg() As String
If Len(lFileName) <> 0 Then
    msg = Split(lFileName, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

Public Sub LoadItems(Optional lINI As String)
On Local Error Resume Next
Dim msg As String, msg2 As String, msg3 As String, c As Integer, i As Integer, lDone As Boolean
ClearItems
If Len(lINI) = 0 Then
    msg = App.Path & "\cpanel.ini"
Else
    msg = lINI
End If
msg3 = GetFileTitle(msg)
ctlCPanel.Visible = False
ctlCPanel.Initialize
ctlCPanel.BackColor = 0
ctlCPanel.BorderStyle = bsNone
ctlCPanel.ViewMode = vmIcon
ctlCPanel.ForeColor = vbWhite
ctlCPanel.Font.Name = "Tahoma"
ctlCPanel.HeaderFlat = True
ctlCPanel.LabelEdit = False
ctlCPanel.LabelTips = True
ctlCPanel.BorderStyle = bsNone
ctlCPanel.OneClickActivate = True
ctlCPanel.InitializeImageListLarge 32, 32
Do Until lDone = True
    c = c + 1
    msg2 = "cp" & Trim(Str(c))
    With lListViewItems(c)
        .lTitle = ReadINI(msg, msg2, "title", "")
        .lToolTip = ReadINI(msg, msg2, "tip", "")
        .lCommand = ReadINI(msg, msg2, "command", "")
        .lImage = ReadINI(msg, msg2, "icon", "")
        .lImageIndex = (c - 1)
        If Len(.lTitle) <> 0 Then
            If Len(.lImage) <> 0 Then
                Load imgCPanelList(c)
                If DoesFileExist(App.Path & "\" & .lImage) Then
                    imgCPanelList(c).Picture = LoadPicture(App.Path & "\" & .lImage)
                    ctlCPanel.ImageListLarge_AddBitmap imgCPanelList(c).Picture, vbBlack
                    DoEvents
                End If
                
            End If
            ctlCPanel.ItemAdd i, .lTitle, 0, .lImageIndex
        Else
            lDone = True
        End If
    End With
Loop
If lCPanelOptions.cSort = True Then ctlCPanel.Sort 0, soAscending, stString
ctlCPanel.Visible = True
If Err.Number <> 0 Then Err.Clear
End Sub

Public Sub AddToListView(lIndex As Integer, lText As String, lImage As Integer)
On Local Error Resume Next
If Len(lText) <> 0 Then ctlCPanel.ItemAdd lIndex, lText, 0, lImage
End Sub

Public Sub FormDrag(lForm As Form)
On Local Error GoTo ErrHandler
ReleaseCapture
Call SendMessage(lForm.hWnd, &HA1, 2, 0&)
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub ctlCPanel_DblClick()
On Local Error Resume Next
mIRCStatusSend "//" & lListViewItems(lCurrentItemIndex).lCommand
End Sub

Private Sub ctlCPanel_ItemClick(Item As Integer)
On Local Error Resume Next
Dim msg As String, i As Integer
lCurrentItem = Item
msg = Trim(LCase(ctlCPanel.ItemText(lCurrentItem)))
For i = 0 To 100
    If LCase(Trim(lListViewItems(i).lTitle)) = msg Then
        lblInformation.Caption = lListViewItems(i).lToolTip
        lCurrentItemIndex = i
        Exit For
    End If
Next i
End Sub

Private Sub InitLeftNav()
On Local Error Resume Next
Dim i As Integer, msg As String, msg2 As String
msg = App.Path & "\cpanel.ini"
ctlLeftNav.Initialize
ctlLeftNav.BackColor = &H202020
ctlLeftNav.ForeColor = vbWhite
ctlLeftNav.BorderStyle = bsNone
ctlLeftNav.LabelEdit = False
ctlLeftNav.OneClickActivate = True
ctlLeftNav.ViewMode = vmList
msg2 = ReadINI(msg, "settings", "sm", "")
If Len(msg2) <> 0 Then
    ctlLeftNav.InitializeImageListSmall 16, 16
    imgTemp.Picture = LoadPicture(App.Path & "/" & msg2)
    ctlLeftNav.ImageListSmall_AddBitmap imgTemp.Picture, -1
End If
For i = 0 To File1.ListCount
    If Len(File1.List(i)) <> 0 Then ctlLeftNav.ItemAdd i, File1.List(i), 0, 0
Next i
End Sub

Private Sub ctlLeftNav_DblClick()
TextViewer.Visible = False
ctlCPanel.Visible = True
LoadItems App.Path & "\" & ctlLeftNav.ItemText(lCurrentLeftNavItem)
End Sub

Private Sub ctlLeftNav_ItemClick(Item As Integer)
lCurrentLeftNavItem = Item
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim msg As String
lTitleBarHeight = ReturnWindowTitleBarHeight(ReturnParentWindow)
File1.Path = App.Path
msg = App.Path & "\cp.ini"
SetWindowToChild Me.hWnd
LoadCPanelOptions
LoadItems (msg)
InitLeftNav
tmrShowMain.Enabled = True
If Err.Number <> 0 Then Err.Clear
End Sub

Private Sub LoadCPanelOptions()
On Local Error GoTo ErrHandler
Dim msg As String
msg = App.Path & "\cpanel.ini"
lCPanelOptions.cSort = ReadINI(msg, "settings", "sort", False)
lCPanelOptions.cShowLeftNav = ReadINI(msg, "settings", "showleftnav", True)
lCPanelOptions.cWindowTheme = ReadINI(msg, "settings", "windowtheme", 0)
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
RefreshHelpTopics
End Sub

Private Sub Form_Resize()
On Local Error GoTo ErrHandler
picOtherPanels.Height = Me.ScaleHeight - (picOtherPanels.Top + picBottom.Height) - 2
ctlCPanel.Left = picOtherPanels.Width
ctlCPanel.Width = Me.ScaleWidth - picOtherPanels.Width
ctlCPanel.Height = Me.ScaleHeight - ((picBottom.Height + lTitleBarHeight) - 8)
picBottom.Width = Me.ScaleWidth
picBottom.Top = ctlCPanel.Height
If picBottom.Left <> 0 Then picBottom.Left = 0
TextViewer.Left = picOtherPanels.Width
TextViewer.Width = Me.ScaleWidth - picOtherPanels.Width
TextViewer.Height = Me.ScaleHeight - 37
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error GoTo ErrHandler
Dim msg As String
msg = App.Path & "\cpanel.ini"
WriteINI msg, "settings", "width", ReturnMainFormWidth()
WriteINI msg, "settings", "height", ReturnMainFormHeight()
WriteINI msg, "settings", "top", ReturnMainFormTop()
WriteINI msg, "settings", "left", ReturnMainFormLeft()
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub lblHelpTopic_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Integer
For i = 0 To (lblHelpTopic.Count - 1)
    lblHelpTopic(i).ForeColor = &H404040
Next i
End Sub

Private Sub lblHelpTopic_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Integer
If Button = 0 Then
    For i = 0 To (lblHelpTopic.Count - 1)
        lblHelpTopic(i).ForeColor = &HC0C0C0
    Next i
End If
End Sub

Private Sub lblHelpTopic_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Integer
For i = 0 To (lblHelpTopic.Count - 1)
    lblHelpTopic(i).ForeColor = &H404040
Next i
Select Case Index
Case 0
    ShowTextFile App.Path & "\howto.txt"
End Select
End Sub

Private Sub lblTop_DblClick()
On Local Error GoTo ErrHandler
If Me.WindowState = vbMaximized Then
    Me.WindowState = vbNormal
Else
    Me.WindowState = vbMaximized
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub lblTop_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
FormDrag Me
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub picMove_DblClick()
On Local Error GoTo ErrHandler
If Me.WindowState = vbMaximized Then
    Me.WindowState = vbNormal
Else
    Me.WindowState = vbMaximized
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub picMove_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
FormDrag Me
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub picOtherPanels_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
RefreshHelpTopics
End Sub

Private Sub picTop_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Sub mIRCStatusSend(lData As String)
On Local Error Resume Next
Dim lmIRC As Long, lMdiClient As Long, lmIRCStatus As Long, lEditBox As Long
lmIRC = FindWindow("mIRC", vbNullString)
lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20W", vbNullString)
Call SendMessageByString(lEditBox, WM_SETTEXT, 0&, lData)
If lEditBox = 0 Then Exit Sub
Do
    DoEvents
    lmIRC = FindWindow("mIRC", vbNullString)
    lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
    lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
    lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20W", vbNullString)
    Call SendMessageLong(lEditBox, WM_CHAR, 13, 0&)
Loop Until lEditBox <> 0
End Sub

Private Sub tmrResize_Timer()
On Local Error Resume Next
lVarLong = GetWindowRect(ReturnParentWindow, lVarRect)
If Me.Left <> 0 Then Me.Left = 0
If Me.Top <> 0 Then Me.Top = 0
lVarLong = 0
lVarLong = ((lVarRect.Right - lVarRect.Left) * Screen.TwipsPerPixelX) - 120
If Me.Width <> lVarLong Then Me.Width = lVarLong
lVarLong = 0
lVarLong = ((lVarRect.Bottom - lVarRect.Top) * Screen.TwipsPerPixelY) - 100
If Me.Height <> lVarLong Then Me.Height = lVarLong
End Sub

Private Sub tmrShowMain_Timer()
On Local Error Resume Next
Dim msg As String
msg = App.Path & "\cpanel.ini"
tmrShowMain.Enabled = False
DoEvents
tmrResize.Enabled = True
Me.Visible = True
End Sub
