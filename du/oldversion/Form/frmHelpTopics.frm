VERSION 5.00
Begin VB.Form frmHelpTopics 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Help Topics"
   ClientHeight    =   3150
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5340
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmHelpTopics.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3150
   ScaleWidth      =   5340
   StartUpPosition =   1  'CenterOwner
   Begin DU.isButton cmdClose 
      Height          =   345
      Left            =   4200
      TabIndex        =   3
      Top             =   2640
      Width           =   975
      _ExtentX        =   1508
      _ExtentY        =   609
      Icon            =   "frmHelpTopics.frx":2E7A
      Style           =   8
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
   Begin VB.Label lblHelpText 
      BackStyle       =   0  'Transparent
      Caption         =   "Body of help"
      Height          =   1815
      Left            =   1440
      TabIndex        =   2
      Top             =   720
      Width           =   3735
   End
   Begin VB.Label lblHelpTitleSmall 
      BackStyle       =   0  'Transparent
      Caption         =   "Description of topic"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   1440
      TabIndex        =   1
      Top             =   480
      Width           =   3735
   End
   Begin VB.Label lblTitle 
      BackStyle       =   0  'Transparent
      Caption         =   "Help Title"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1440
      TabIndex        =   0
      Top             =   120
      Width           =   3735
   End
   Begin VB.Image imgHelpTopics 
      Height          =   1200
      Left            =   120
      Picture         =   "frmHelpTopics.frx":2E96
      Top             =   120
      Width           =   1245
   End
End
Attribute VB_Name = "frmHelpTopics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdClose_Click()
On Local Error Resume Next
Unload Me
End Sub

