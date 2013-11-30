VERSION 5.00
Begin VB.Form frmStep 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Step"
   ClientHeight    =   1140
   ClientLeft      =   150
   ClientTop       =   5955
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
   ScaleHeight     =   1140
   ScaleWidth      =   3450
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   WhatsThisHelp   =   -1  'True
   Begin VB.PictureBox picBottom 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   600
      Left            =   0
      ScaleHeight     =   600
      ScaleWidth      =   6015
      TabIndex        =   2
      Top             =   720
      Width           =   6015
      Begin VB.CommandButton cmdExit 
         Cancel          =   -1  'True
         Caption         =   "E&xit"
         Height          =   255
         Left            =   1320
         TabIndex        =   5
         Top             =   120
         Width           =   975
      End
      Begin VB.CommandButton cmdStepTo 
         Caption         =   "&Step Now"
         Default         =   -1  'True
         Height          =   255
         Left            =   2400
         TabIndex        =   4
         Top             =   120
         Width           =   975
      End
      Begin VB.CheckBox Check1 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Mute"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   120
         MaskColor       =   &H00404040&
         TabIndex        =   3
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
   Begin VB.TextBox txtStep 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   120
      TabIndex        =   1
      Text            =   "20"
      Top             =   360
      Width           =   3255
   End
   Begin VB.Label Label1 
      Caption         =   "Enter forward step rate:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "frmStep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdExit_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdExit_Click()", Err.Description
End Sub

Private Sub cmdStepTo_Click()
On Local Error Resume Next
Dim i As Long
i = txtStep.Text
If i <> 0 Then
    frmMain.ctlDVD.Step i
End If
If Err.Number <> 0 Then SetError "cmdStepTo_Click()", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
SetForm True, Me
AlwaysOnTop Me, True
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
AlwaysOnTop Me, False
SetForm False, Me
If Err.Number <> 0 Then SetError "Form_Unload", Err.Description
End Sub
