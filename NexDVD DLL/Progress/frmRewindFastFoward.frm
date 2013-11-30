VERSION 5.00
Begin VB.Form frmRewindFastFoward 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Rewind / Fast Forward"
   ClientHeight    =   1755
   ClientLeft      =   60
   ClientTop       =   330
   ClientWidth     =   3450
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1755
   ScaleWidth      =   3450
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.CommandButton cmdApply 
      Caption         =   "< Rewind"
      Height          =   255
      Left            =   2400
      TabIndex        =   5
      Top             =   840
      Width           =   975
   End
   Begin VB.CommandButton cmdPlay 
      Caption         =   "Play"
      Enabled         =   0   'False
      Height          =   255
      Left            =   1320
      TabIndex        =   6
      Top             =   840
      Width           =   975
   End
   Begin VB.ComboBox cboSpeed 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      ItemData        =   "frmRewindFastFoward.frx":0000
      Left            =   840
      List            =   "frmRewindFastFoward.frx":001C
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   480
      Width           =   2535
   End
   Begin VB.ComboBox cboType 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      ItemData        =   "frmRewindFastFoward.frx":0038
      Left            =   120
      List            =   "frmRewindFastFoward.frx":0042
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   120
      Width           =   3255
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   0
      ScaleHeight     =   615
      ScaleWidth      =   3495
      TabIndex        =   0
      Top             =   1320
      Width           =   3495
      Begin VB.CommandButton cmdOK 
         Cancel          =   -1  'True
         Caption         =   "Close"
         Default         =   -1  'True
         Height          =   255
         Left            =   2520
         TabIndex        =   1
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   3
         X1              =   0
         X2              =   8880
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.Label Label1 
      Caption         =   "Speed:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   480
      Width           =   1695
   End
End
Attribute VB_Name = "frmRewindFastFoward"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cboType_Click()
On Local Error Resume Next
Select Case cboType.ListIndex
Case 0
    Caption = "nexDVD - Rewind"
    cmdApply.Caption = "< Rewind"
Case 1
    Caption = "nexDVD - Fast Forward"
    cmdApply.Caption = "Forward >"
End Select
If Err.Number <> 0 Then SetError "cboType_Click()", Err.Description
End Sub

Private Sub cmdApply_Click()
On Local Error Resume Next
Dim i As Integer, f As Integer
i = cboSpeed.Text
f = cboType.ListIndex
Select Case f
Case 0
    OnScreenDisplay "Rewind x" & i
    lPlayer.pRewindSpeed = i
    frmMain.ctlDVD.PlayBackwards lPlayer.pRewindSpeed
Case 1
    OnScreenDisplay "Fast Forward x" & i
    lPlayer.pFastforwardSpeed = i
    frmMain.ctlDVD.PlayForwards lPlayer.pFastforwardSpeed
End Select
cmdApply.Enabled = False
cmdPlay.Enabled = True
cboSpeed.Enabled = False
cboType.Enabled = False
If Err.Number <> 0 Then SetError "cmdApply_Click", Err.Description
End Sub

Private Sub cmdOK_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdOK_Click()", Err.Description
End Sub

Private Sub cmdPlay_Click()
On Local Error Resume Next
PlayerState ePlay
cmdPlay.Enabled = False
cmdApply.Enabled = True
cboType.Enabled = True
cboSpeed.Enabled = True
If Err.Number <> 0 Then SetError "cmdPlay_Click()", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim i As Integer, m As Integer
AlwaysOnTop Me, True
cboType.ListIndex = 0
cboSpeed.ListIndex = ReadINI(lINIFiles.iSettings, "Settings", "SeekSpeed", 2) - 1
SetForm True, Me
If Err.Number <> 0 Then SetError "form_Load()", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
'MsgBox cboSpeed.Text
WriteINI lINIFiles.iSettings, "Settings", "SeekSpeed", cboSpeed.Text
AlwaysOnTop Me, False
SetForm False, Me
If Err.Number <> 0 Then SetError "Form_Unload()", Err.Description
End Sub
