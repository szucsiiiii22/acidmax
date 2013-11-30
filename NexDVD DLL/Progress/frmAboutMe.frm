VERSION 5.00
Begin VB.Form frmAboutMe 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "nexDVD"
   ClientHeight    =   3075
   ClientLeft      =   45
   ClientTop       =   2490
   ClientWidth     =   2370
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
   ScaleHeight     =   3075
   ScaleWidth      =   2370
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.PictureBox Picture2 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   855
      Left            =   0
      ScaleHeight     =   855
      ScaleWidth      =   2415
      TabIndex        =   3
      Top             =   2640
      Width           =   2415
      Begin VB.CommandButton cmdClose 
         Cancel          =   -1  'True
         Caption         =   "Close"
         Default         =   -1  'True
         Height          =   255
         Left            =   1320
         TabIndex        =   6
         Top             =   120
         Width           =   975
      End
      Begin VB.Line Line2 
         BorderWidth     =   6
         X1              =   0
         X2              =   2400
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   855
      Left            =   0
      ScaleHeight     =   855
      ScaleWidth      =   2415
      TabIndex        =   0
      Top             =   0
      Width           =   2415
      Begin VB.Line Line1 
         BorderWidth     =   4
         X1              =   0
         X2              =   2400
         Y1              =   840
         Y2              =   840
      End
      Begin VB.Label lblVersion 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Current Version"
         Height          =   255
         Left            =   600
         TabIndex        =   2
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label lblProduct 
         BackStyle       =   0  'Transparent
         Caption         =   "nexDVD"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   720
         TabIndex        =   1
         Top             =   120
         Width           =   1455
      End
      Begin VB.Image imgIcon 
         Height          =   480
         Left            =   120
         Picture         =   "frmAboutMe.frx":0000
         Top             =   120
         Width           =   480
      End
   End
   Begin VB.Label Label1 
      Caption         =   "Visit Team Nexgen"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   120
      MouseIcon       =   "frmAboutMe.frx":0CCA
      MousePointer    =   99  'Custom
      TabIndex        =   5
      Top             =   2280
      Width           =   2175
   End
   Begin VB.Label lblCredits 
      Caption         =   "This program was written by Leon Aiossa. Some graphics designed by Colin Foss. "
      Height          =   1575
      Left            =   120
      TabIndex        =   4
      Top             =   960
      Width           =   2175
   End
End
Attribute VB_Name = "frmAboutMe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdClose_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdClose_Click", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
AlwaysOnTop Me, True
lblVersion.Caption = "Version: " & App.Major & "." & App.Minor
SetForm True, Me
If Err.Number <> 0 Then SetError "Form_Load()", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
SetForm False, Me
AlwaysOnTop Me, False
If Err.Number <> 0 Then SetError "Form_Unload", Err.Description
End Sub

Private Sub imgIcon_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub

Private Sub Label1_Click()
On Local Error Resume Next
Surf "http://www.tnexgen.com"
If Err.Number <> 0 Then SetError "label1", Err.Description
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub

Private Sub lblCredits_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub

Private Sub lblProduct_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub

Private Sub lblVersion_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub

Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub

Private Sub Picture2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "MouseDown", Err.Description
End Sub
