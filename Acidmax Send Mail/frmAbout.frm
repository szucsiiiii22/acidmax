VERSION 5.00
Begin VB.Form frmAbout 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About"
   ClientHeight    =   1725
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2505
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmAbout.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1725
   ScaleWidth      =   2505
   StartUpPosition =   3  'Windows Default
   Begin AcidmaxSendMail.isButton cmdClose 
      Height          =   315
      Left            =   1440
      TabIndex        =   3
      Top             =   1320
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   556
      Icon            =   "frmAbout.frx":0CCA
      Style           =   1
      Caption         =   "Close"
      iNonThemeStyle  =   0
      Tooltiptitle    =   ""
      ToolTipIcon     =   0
      ToolTipType     =   1
      ttForeColor     =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaskColor       =   0
      RoundedBordersByTheme=   0   'False
   End
   Begin VB.Label lblVersion 
      Caption         =   "Version: 1.0"
      Height          =   255
      Left            =   720
      TabIndex        =   2
      Top             =   600
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "Developer: guideX"
      Height          =   255
      Left            =   720
      TabIndex        =   1
      Top             =   960
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "Nexgen Acidmax - Send Mail"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   720
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
   Begin VB.Image imgIcon 
      Height          =   480
      Left            =   120
      Picture         =   "frmAbout.frx":0CE6
      Top             =   120
      Width           =   480
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdClose_Click()
On Local Error Resume Next
Unload Me
End Sub

Private Sub Form_Load()
On Local Error Resume Next
lblVersion.Caption = "Version: " & App.Major & "." & App.Revision
End Sub
