VERSION 5.00
Object = "{EE128208-4F73-11D3-83BB-C47C02EE3D01}#1.0#0"; "ControlResizer.ocx"
Begin VB.Form frmTextStrings 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Text Strings"
   ClientHeight    =   2760
   ClientLeft      =   60
   ClientTop       =   330
   ClientWidth     =   3990
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
   ScaleHeight     =   2760
   ScaleWidth      =   3990
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   0
      ScaleHeight     =   495
      ScaleWidth      =   3975
      TabIndex        =   1
      Top             =   2280
      Width           =   3975
      Begin VB.CommandButton cmdClose 
         Caption         =   "Close"
         Default         =   -1  'True
         Height          =   255
         Left            =   3000
         TabIndex        =   2
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00FFFFFF&
         BorderWidth     =   4
         X1              =   0
         X2              =   3960
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.ListBox lstTextStrings 
      Height          =   2010
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3735
   End
   Begin ControlResizer.AutoResizer AutoResizer1 
      Height          =   135
      Left            =   3000
      Top             =   2880
      Visible         =   0   'False
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   238
   End
End
Attribute VB_Name = "frmTextStrings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
On Error Resume Next
Dim i As Integer, k As Integer, msg As String
For i = 0 To 100
    For k = 0 To 100
        msg = frmMain.ctlDVD.GetDVDTextString(i, k)
        If Len(msg) <> 0 Then lstTextStrings.AddItem Str(i) & ":" & Str(k) & msg
    Next k
Next i
End Sub
