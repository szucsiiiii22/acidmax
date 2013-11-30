VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{EE128208-4F73-11D3-83BB-C47C02EE3D01}#1.0#0"; "ControlResizer.ocx"
Object = "{7314ED99-8643-4E82-A4F8-5E9F4DEC14BE}#1.0#0"; "VolumeControl.ocx"
Begin VB.Form frmVolume 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Volume"
   ClientHeight    =   1845
   ClientLeft      =   2400
   ClientTop       =   2505
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
   ScaleHeight     =   1845
   ScaleWidth      =   3450
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.OptionButton optVolType 
      Caption         =   "Wave Volume"
      Height          =   375
      Index           =   5
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   480
      Width           =   3195
   End
   Begin VB.OptionButton optVolType 
      Caption         =   "Master Volume"
      Height          =   375
      Index           =   0
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   120
      Width           =   3195
   End
   Begin MSComctlLib.Slider sldVolume 
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   960
      Width           =   3240
      _ExtentX        =   5715
      _ExtentY        =   661
      _Version        =   393216
      Max             =   100
      TickStyle       =   3
   End
   Begin VB.PictureBox picBottom 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   600
      Left            =   0
      ScaleHeight     =   600
      ScaleWidth      =   3735
      TabIndex        =   7
      Top             =   1440
      Width           =   3735
      Begin VB.CheckBox Check1 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Mute"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   120
         MaskColor       =   &H00404040&
         TabIndex        =   10
         Top             =   120
         Width           =   855
      End
      Begin VB.CommandButton cmdClose 
         Cancel          =   -1  'True
         Caption         =   "Close"
         Default         =   -1  'True
         Height          =   255
         Left            =   2520
         TabIndex        =   9
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   3
         X1              =   0
         X2              =   6000
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.OptionButton optVolType 
      Caption         =   "Auxiliary"
      Height          =   375
      Index           =   6
      Left            =   840
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   3840
      Width           =   3000
   End
   Begin VB.OptionButton optVolType 
      Caption         =   "CD Audio"
      Height          =   255
      Index           =   4
      Left            =   840
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   2400
      Visible         =   0   'False
      Width           =   3360
   End
   Begin VB.OptionButton optVolType 
      Caption         =   "Synthesizer"
      Height          =   375
      Index           =   3
      Left            =   840
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   3480
      Width           =   3000
   End
   Begin VB.OptionButton optVolType 
      Caption         =   "Microphone"
      Height          =   375
      Index           =   2
      Left            =   840
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   3000
      Width           =   3000
   End
   Begin VB.OptionButton optVolType 
      Caption         =   "Line In"
      Height          =   375
      Index           =   1
      Left            =   840
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   2760
      Width           =   3000
   End
   Begin ControlResizer.AutoResizer AutoResizer1 
      Height          =   135
      Left            =   120
      Top             =   2280
      Visible         =   0   'False
      Width           =   135
      _ExtentX        =   238
      _ExtentY        =   238
   End
   Begin VolControl.VolumeControl VolumeControl1 
      Left            =   120
      Top             =   2520
      _ExtentX        =   847
      _ExtentY        =   847
      Volume          =   31
   End
End
Attribute VB_Name = "frmVolume"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Check1_Click()
On Local Error Resume Next
If Check1.Value = vbChecked Then
    VolumeControl1.Mute = True
Else
    VolumeControl1.Mute = False
End If
If Err.Number <> 0 Then SetError "check1_Click", Err.Description
End Sub

Private Sub cmdClose_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdClose_Click", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Icon = frmMain.Icon
AlwaysOnTop Me, True
optVolType(VolumeControl1.DeviceToControl).Value = True
sldVolume.Value = VolumeControl1.Volume
SetForm True, Me
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub imgTopper_DblClick()
On Local Error Resume Next
If Me.WindowState = vbMaximized Then
    Me.WindowState = vbNormal
Else
    Me.WindowState = vbMaximized
End If
If Err.Number <> 0 Then SetError "imgTopper_DblClick", Err.Description
End Sub

Private Sub imgTopper_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "imgTopper_MouseDown", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
SetForm False, Me
End Sub

Private Sub optVolType_Click(Index As Integer)
On Local Error Resume Next
VolumeControl1.DeviceToControl = Index
sldVolume.SetFocus
If Err.Number <> 0 Then SetError "optVolType_Click", Err.Description
End Sub

Private Sub sldVolume_Scroll()
On Local Error Resume Next
VolumeControl1.Volume = sldVolume.Value
If Err.Number <> 0 Then SetError "sldVolume_Scroll", Err.Description
End Sub

Private Sub VolumeControl1_MuteChanged(NewMute As Boolean)
On Local Error Resume Next
If NewMute Then
    Check1.Value = vbChecked
Else
    Check1.Value = vbUnchecked
End If
If Err.Number <> 0 Then SetError "VolumeControl1_MuteChanged", Err.Description
End Sub

Private Sub VolumeControl1_VolumeChanged(NewVolume As Long)
On Local Error Resume Next
sldVolume.Value = NewVolume
If Err.Number <> 0 Then SetError "VolumeControl1_VolumeChanged", Err.Description
End Sub
