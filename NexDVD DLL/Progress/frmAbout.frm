VERSION 5.00
Object = "{EE128208-4F73-11D3-83BB-C47C02EE3D01}#1.0#0"; "ControlResizer.ocx"
Begin VB.Form frmAbout 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - About"
   ClientHeight    =   2700
   ClientLeft      =   6465
   ClientTop       =   330
   ClientWidth     =   3000
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
   ScaleHeight     =   2700
   ScaleWidth      =   3000
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   0
      ScaleHeight     =   615
      ScaleWidth      =   3015
      TabIndex        =   2
      Top             =   2280
      Width           =   3015
      Begin VB.CommandButton cmdOK 
         Caption         =   "Close"
         Default         =   -1  'True
         Height          =   255
         Left            =   1800
         TabIndex        =   3
         Top             =   120
         Width           =   1095
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   3
         X1              =   0
         X2              =   8880
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Label lblVersion 
         BackStyle       =   0  'Transparent
         Caption         =   "Version: Current Version"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   120
         Width           =   1935
      End
   End
   Begin ControlResizer.AutoResizer AutoResizer1 
      Height          =   255
      Left            =   4080
      Top             =   480
      Visible         =   0   'False
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
   End
   Begin VB.Image Image2 
      Height          =   1725
      Left            =   0
      Picture         =   "frmAbout.frx":0000
      Stretch         =   -1  'True
      Top             =   0
      Width           =   3030
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Graphics: Leon J Aiossa, Colin Foss"
      ForeColor       =   &H00000000&
      Height          =   615
      Left            =   120
      TabIndex        =   1
      Top             =   2040
      Width           =   2775
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Programming: Leon J Aiossa"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   1800
      Width           =   2895
   End
   Begin VB.Image Image1 
      Height          =   1500
      Left            =   4440
      Picture         =   "frmAbout.frx":B720
      Top             =   3240
      Visible         =   0   'False
      Width           =   9075
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
On Local Error Resume Next
Unload Me
End Sub

Private Sub Form_Load()
On Local Error Resume Next
SetForm True, Me
lblVersion.Caption = "Version: " & App.Major & "." & App.Minor
AlwaysOnTop Me, True
End Sub

Private Sub Form_Unload(Cancel As Integer)
AlwaysOnTop Me, False
SetForm False, Me
End Sub

Private Sub Image2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
FormDrag Me
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
FormDrag Me
End Sub

Private Sub Label2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
FormDrag Me
End Sub

Private Sub lblVersion_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
FormDrag Me
End Sub

Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
FormDrag Me
End Sub
