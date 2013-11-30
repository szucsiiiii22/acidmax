VERSION 5.00
Begin VB.Form frmSplash 
   BorderStyle     =   0  'None
   Caption         =   "nexDVD - Splash"
   ClientHeight    =   4860
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4650
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   Picture         =   "frmSplash.frx":0000
   ScaleHeight     =   4860
   ScaleWidth      =   4650
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Timer tmrNexDVD 
      Interval        =   4000
      Left            =   120
      Top             =   120
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Click()
On Local Error Resume Next
tmrNexDVD.Enabled = False
Unload Me
If Err.Number <> 0 Then SetError "Form_Click", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
AlwaysOnTop Me, True
Dim t As Single
Dim rtn As Long
'  rtn = GetWindowLong(hwnd, GWL_EXSTYLE)
'  rtn = rtn Or WS_EX_LAYERED
'  SetWindowLong hwnd, GWL_EXSTYLE, rtn
'  SetLayeredWindowAttributes hwnd, 0, 192, LWA_ALPHA
'SetLayeredWindowAttributes hwnd, &H0, 0, LWA_COLORKEY

t = Timer

If Me.Picture <> 0 Then
  Call SetAutoRgn(Me)
End If

If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
AutoPlay
AlwaysOnTop Me, False
If Err.Number <> 0 Then SetError "Form_Unload", Err.Description
End Sub

Private Sub tmrNexDVD_Timer()
On Local Error Resume Next
tmrNexDVD.Enabled = False
Unload Me
If Err.Number <> 0 Then SetError "tmrNexDVD_Timer", Err.Description
End Sub
