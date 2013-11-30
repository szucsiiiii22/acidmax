VERSION 5.00
Begin VB.Form frmTray 
   Caption         =   "nexDVD"
   ClientHeight    =   765
   ClientLeft      =   -2940
   ClientTop       =   -2550
   ClientWidth     =   3045
   Icon            =   "frmTray.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   51
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   203
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Image imgIcon 
      Height          =   480
      Left            =   120
      Picture         =   "frmTray.frx":0CCA
      Top             =   120
      Width           =   480
   End
End
Attribute VB_Name = "frmTray"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
On Local Error Resume Next
If lSettings.sShowIconInSystray = True Then
    try.cbSize = Len(try)
    try.hwnd = Me.hwnd
    try.uId = vbNull
    try.uFlags = NIF_ICON Or NIF_TIP Or NIF_MESSAGE
    try.uCallBackMessage = WM_MOUSEMOVE
    try.hIcon = Me.Icon
    try.szTip = App.Title & " " & App.Major & "." & App.Minor & " by Team Nexgen - http://www.tnexgen.com"
    Call Shell_NotifyIcon(NIM_ADD, try)
    Call Shell_NotifyIcon(NIM_MODIFY, try)
End If
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
Select Case x
Case 516
    PopupMenu frmMain.mnuControls
Case 513
    PlayerVisible True
End Select
If Err.Number <> 0 Then SetError "Form_MouseMove", Err.Description
End Sub
