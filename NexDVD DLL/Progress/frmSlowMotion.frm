VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmSlowMotion 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Slow Motion"
   ClientHeight    =   1785
   ClientLeft      =   3645
   ClientTop       =   330
   ClientWidth     =   3630
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
   ScaleHeight     =   1785
   ScaleWidth      =   3630
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.CommandButton cmdCapture 
      Caption         =   "Capture"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton cmdSlow 
      Caption         =   "Slow"
      Height          =   255
      Left            =   2640
      TabIndex        =   4
      Top             =   960
      Width           =   855
   End
   Begin VB.CommandButton cmdPlay 
      Caption         =   "Play"
      Enabled         =   0   'False
      Height          =   255
      Left            =   1800
      TabIndex        =   5
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton cmdPause 
      Caption         =   "Pause"
      Height          =   255
      Left            =   960
      TabIndex        =   6
      Top             =   960
      Width           =   735
   End
   Begin VB.Timer tmrSlowMotion 
      Left            =   2880
      Top             =   0
   End
   Begin VB.PictureBox picBottom 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   600
      Left            =   0
      ScaleHeight     =   600
      ScaleWidth      =   6015
      TabIndex        =   2
      Top             =   1320
      Width           =   6015
      Begin VB.CommandButton cmdExit 
         Cancel          =   -1  'True
         Caption         =   "E&xit"
         Default         =   -1  'True
         Height          =   255
         Left            =   2520
         TabIndex        =   3
         Top             =   120
         Width           =   975
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   4
         DrawMode        =   1  'Blackness
         X1              =   0
         X2              =   6000
         Y1              =   0
         Y2              =   0
      End
   End
   Begin MSComctlLib.Slider sldSpeed 
      Height          =   495
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   873
      _Version        =   393216
      Min             =   50
      Max             =   500
      SelStart        =   100
      TickStyle       =   3
      Value           =   100
   End
   Begin VB.Label Label1 
      Caption         =   "Speed:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "frmSlowMotion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCapture_Click()
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
If lSettings.sCaptureMode = True Then
    frmMain.ctlDVD.Capture
Else
    mbox = MsgBox("nexDVD is not in capture mode. Would you like to switch to capture mode now? (This will require nexDVD to end and load again)", vbInformation + vbYesNo, "Capture mode")
    If mbox = vbYes Then
        lSettings.sCaptureMode = True
        WriteINI lINIFiles.iSettings, "Settings", "CaptureMode", lSettings.sCaptureMode
        LoadCaptureMode
        Exit Sub
    End If
End If
If Err.Number <> 0 Then SetError "cmdCapture_Click", Err.Description
End Sub

Private Sub cmdExit_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdExit_Click()", Err.Description
End Sub

Private Sub cmdPause_Click()
On Local Error Resume Next
tmrSlowMotion.Enabled = False
frmMain.ctlDVD.Pause
cmdPause.Enabled = False
cmdPlay.Enabled = True
cmdSlow.Enabled = True
If Err.Number <> 0 Then SetError "cmdPause_Click()", Err.Description
End Sub

Private Sub cmdPlay_Click()
On Local Error Resume Next
cmdPlay.Enabled = False
cmdSlow.Enabled = True
cmdPause.Enabled = True
tmrSlowMotion.Enabled = False
frmMain.ctlDVD.Play
If Err.Number <> 0 Then SetError "cmdPlay_Click()", Err.Description
End Sub

Private Sub cmdSlow_Click()
On Local Error Resume Next
tmrSlowMotion.interval = sldSpeed.Value
cmdPause.Enabled = True
cmdPlay.Enabled = True
cmdSlow.Enabled = False
tmrSlowMotion.Enabled = True
If Err.Number <> 0 Then SetError "cmdSlow_Click()", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
SetForm True, Me
AlwaysOnTop Me, True
If Err.Number <> 0 Then SetError "Form_Load()", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
AlwaysOnTop Me, False
SetForm False, Me
tmrSlowMotion.Enabled = False
If Err.Number <> 0 Then SetError "Form_Unload()", Err.Description
End Sub

Private Sub sldSpeed_Scroll()
On Local Error Resume Next
tmrSlowMotion.interval = sldSpeed.Value
If Err.Number <> 0 Then SetError "sldSpeed_Scroll()", Err.Description
End Sub

Private Sub tmrSlowMotion_Timer()
On Local Error Resume Next
If cmdSlow.Enabled = True Then cmdSlow.Enabled = False
If cmdPlay.Enabled = False Then cmdPlay.Enabled = True
If cmdPause.Enabled = False Then cmdPause.Enabled = True

frmMain.ctlDVD.Step 1
End Sub
