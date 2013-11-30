VERSION 5.00
Begin VB.Form frmLanguage 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Select Language"
   ClientHeight    =   1065
   ClientLeft      =   5325
   ClientTop       =   1260
   ClientWidth     =   4170
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
   ScaleWidth      =   4170
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.ComboBox cboLanguages 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      ItemData        =   "frmLanguage.frx":0000
      Left            =   120
      List            =   "frmLanguage.frx":0002
      MousePointer    =   1  'Arrow
      TabIndex        =   3
      Top             =   120
      Width           =   3975
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      ForeColor       =   &H00E0E0E0&
      Height          =   495
      Left            =   0
      ScaleHeight     =   495
      ScaleWidth      =   4335
      TabIndex        =   0
      Top             =   600
      Width           =   4335
      Begin VB.CommandButton cmdOK 
         Caption         =   "Set"
         Default         =   -1  'True
         Height          =   255
         Left            =   2280
         MousePointer    =   1  'Arrow
         TabIndex        =   2
         Top             =   120
         Width           =   855
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "&Cancel"
         Height          =   255
         Left            =   3240
         MousePointer    =   1  'Arrow
         TabIndex        =   1
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   4
         X1              =   0
         X2              =   8880
         Y1              =   0
         Y2              =   0
      End
   End
End
Attribute VB_Name = "frmLanguage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
On Local Error Resume Next
Unload Me
End Sub

Private Sub cmdOK_Click()
On Local Error Resume Next
Dim i As Integer, f As Integer, m As Integer, msg As String
msg = cboLanguages.Text
f = cboLanguages.ListIndex
frmMain.ctlDVD.CurrentSubpictureStream = f
frmMain.ctlDVD.SubpictureOn = True
OnScreenDisplay "Lanugage set to: " & msg
Unload Me
If Err.Number <> 0 Then SetError "cmdOK_Click()", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim i As Integer, m As Integer, f As Integer, msg As String
f = frmMain.ctlDVD.SubpictureStreamsAvailable
i = frmMain.ctlDVD.CurrentSubpictureStream
For m = 0 To f + 1
    msg = frmMain.ctlDVD.GetSubpictureLanguage(m)
    If Len(msg) <> 0 Then cboLanguages.AddItem msg
    msg = ""
Next m
cboLanguages.ListIndex = i
SetForm True, Me
AlwaysOnTop Me, True
If Err.Number <> 0 Then SetError "Form_Load()", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
AlwaysOnTop Me, False
SetForm False, Me
If Err.Number <> 0 Then SetError "Form_Unload()", Err.Description
End Sub
