VERSION 5.00
Begin VB.Form frmSending 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Acidmax - Sending Mail"
   ClientHeight    =   1050
   ClientLeft      =   2895
   ClientTop       =   3210
   ClientWidth     =   4680
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmSending.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1050
   ScaleWidth      =   4680
   Begin AcidmaxSendMail.XP_ProgressBar prgSendProgress 
      Height          =   255
      Left            =   1200
      TabIndex        =   0
      Top             =   120
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   450
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BrushStyle      =   0
      Color           =   6956042
   End
   Begin VB.Label lblStatus 
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   4455
   End
   Begin VB.Label Label1 
      Caption         =   "Sending Mail:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   2175
   End
End
Attribute VB_Name = "frmSending"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
AlwaysOnTop Me, True
End Sub
