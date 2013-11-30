VERSION 5.00
Begin VB.Form frmChapters 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Chapters"
   ClientHeight    =   2490
   ClientLeft      =   6495
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
   ScaleHeight     =   2490
   ScaleWidth      =   3000
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.ListBox lstChapters 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   1815
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2775
   End
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
      ScaleWidth      =   3495
      TabIndex        =   0
      Top             =   2040
      Width           =   3495
      Begin VB.CommandButton cmdPlay 
         Caption         =   "Play"
         Default         =   -1  'True
         Height          =   255
         Left            =   1320
         TabIndex        =   3
         Top             =   120
         Width           =   735
      End
      Begin VB.CommandButton cmdOK 
         Cancel          =   -1  'True
         Caption         =   "Cancel"
         Height          =   255
         Left            =   2160
         TabIndex        =   1
         Top             =   120
         Width           =   735
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
Attribute VB_Name = "frmChapters"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdOK_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdOK_Click()", Err.Description
End Sub

Private Sub cmdPlay_Click()
On Local Error Resume Next
Dim i As Integer
i = Int(Right(lstChapters.Text, Len(lstChapters.Text) - 7))
frmMain.ctlDVD.PlayChapter i
Unload Me
If Err.Number <> 0 Then SetError "cmdOK_Click()", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim i As Integer, f As Integer
AlwaysOnTop Me, True
f = frmMain.ctlDVD.GetNumberOfChapters(frmMain.ctlDVD.CurrentTitle)
If Err.Number <> 0 Then SetError "FormLoad()", Err.Description
If f <> 0 Then
    For i = 1 To f
        lstChapters.AddItem "Chapter " & i
    Next i
End If
SetForm True, Me
If Err.Number <> 0 Then SetError "Form_Load()", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
SetForm False, Me
AlwaysOnTop Me, False
If Err.Number <> 0 Then SetError "Form_Unload()", Err.Description
End Sub

Private Sub lstChapters_DblClick()
On Local Error Resume Next
Dim i As Integer
i = Int(Right(lstChapters.Text, Len(lstChapters.Text) - 7))
frmMain.ctlDVD.PlayChapter i
If Err.Number <> 0 Then SetError "lstCHapters_DblClick()", Err.Description
End Sub
