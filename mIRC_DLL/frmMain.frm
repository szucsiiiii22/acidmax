VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Acidmax Translator"
   ClientHeight    =   2670
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4950
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   178
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   330
   ShowInTaskbar   =   0   'False
   Begin VB.Label Label2 
      Caption         =   $"frmMain.frx":0CCA
      Height          =   1815
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   4695
   End
   Begin VB.Label Label1 
      Caption         =   "mIRC_DLL v1.0"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4215
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
On Local Error GoTo ErrHandler
MsgBox "HEY"
SetWindowToChild Trim(CLng(Me.hWnd))
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
