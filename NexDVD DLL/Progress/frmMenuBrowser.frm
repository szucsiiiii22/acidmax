VERSION 5.00
Begin VB.Form frmMenuBrowser 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Menu Browser"
   ClientHeight    =   1125
   ClientLeft      =   4575
   ClientTop       =   2685
   ClientWidth     =   4905
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
   ScaleHeight     =   1125
   ScaleWidth      =   4905
   ShowInTaskbar   =   0   'False
   Begin VB.ComboBox cboMenu 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      ItemData        =   "frmMenuBrowser.frx":0000
      Left            =   120
      List            =   "frmMenuBrowser.frx":0016
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   120
      Width           =   4695
   End
   Begin VB.PictureBox picBottom 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   735
      Left            =   0
      ScaleHeight     =   735
      ScaleWidth      =   4935
      TabIndex        =   0
      Top             =   600
      Width           =   4935
      Begin VB.CommandButton cmdOK 
         Caption         =   "&Ok"
         Default         =   -1  'True
         Height          =   315
         Left            =   3000
         TabIndex        =   3
         Top             =   120
         Width           =   855
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "&Cancel"
         Height          =   315
         Left            =   3960
         TabIndex        =   2
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line1 
         BorderWidth     =   5
         X1              =   0
         X2              =   4920
         Y1              =   0
         Y2              =   0
      End
   End
End
Attribute VB_Name = "frmMenuBrowser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdCancel_Click", Err.Description
End Sub

Private Sub cmdOK_Click()
On Local Error Resume Next
Dim i As Integer
Select Case cboMenu.ListIndex
Case 0
    GoMenu 3
Case 1
    GoMenu 7
Case 2
    GoMenu 2
Case 3
    GoMenu 5
Case 4
    GoMenu 6
Case 5
    GoMenu 4
End Select
If Err.Number <> 0 Then SetError "cmdOK_Click", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
SetForm True, Me
AlwaysOnTop Me, True
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
SetForm False, Me
AlwaysOnTop Me, False
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub
