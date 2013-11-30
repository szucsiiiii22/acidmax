VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmPlaybackPosition 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Playback Position"
   ClientHeight    =   1065
   ClientLeft      =   60
   ClientTop       =   5820
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
   ScaleHeight     =   1065
   ScaleWidth      =   3450
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   0
      ScaleHeight     =   615
      ScaleWidth      =   5535
      TabIndex        =   0
      Top             =   600
      Width           =   5535
      Begin VB.CommandButton cmdClose 
         Cancel          =   -1  'True
         Caption         =   "&Close"
         Default         =   -1  'True
         Height          =   300
         Left            =   2520
         TabIndex        =   1
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   4
         X1              =   0
         X2              =   5400
         Y1              =   0
         Y2              =   0
      End
   End
   Begin MSComctlLib.Slider sldVolume 
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   120
      Width           =   3480
      _ExtentX        =   6138
      _ExtentY        =   661
      _Version        =   393216
      Max             =   100
      TickStyle       =   3
   End
End
Attribute VB_Name = "frmPlaybackPosition"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
AlwaysOnTop Me, True
lPlayer.pPlaybackPositionShown = True
SetForm True, Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
AlwaysOnTop Me, False
lPlayer.pPlaybackPositionShown = False
SetForm False, Me
End Sub

Private Sub sldVolume_Click()
Dim i As Long, f As Long
'i = frmMain.ctlDVD.TotalTitleTime
'MsgBox frmMain.ctlDVD.CurrentTime
End Sub
