VERSION 5.00
Begin VB.Form frmSendMail 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Acidmax - Send Mail"
   ClientHeight    =   4470
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4440
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmSendMail.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4470
   ScaleWidth      =   4440
   Begin VB.TextBox txtData 
      Height          =   2630
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   9
      Top             =   1360
      Width           =   4215
   End
   Begin VB.ComboBox cboTo 
      Height          =   315
      Left            =   840
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   450
      Width           =   2535
   End
   Begin AcidmaxPlayer.isButton cmdAdd 
      Height          =   345
      Left            =   1320
      TabIndex        =   2
      Top             =   2880
      Width           =   855
      _extentx        =   1508
      _extenty        =   609
      icon            =   "frmSendMail.frx":0CCA
      style           =   1
      caption         =   "&Add"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0CE6
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin VB.ComboBox cboFrom 
      Height          =   315
      Left            =   840
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   120
      Width           =   2535
   End
   Begin AcidmaxPlayer.isButton isButton1 
      Height          =   345
      Left            =   2280
      TabIndex        =   3
      Top             =   2880
      Width           =   855
      _extentx        =   1508
      _extenty        =   609
      icon            =   "frmSendMail.frx":0D0E
      style           =   1
      caption         =   "&Delete"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0D2A
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin AcidmaxPlayer.isButton isButton2 
      Height          =   345
      Left            =   3240
      TabIndex        =   4
      Top             =   2880
      Width           =   855
      _extentx        =   1508
      _extenty        =   609
      icon            =   "frmSendMail.frx":0D52
      style           =   1
      caption         =   "&Edit"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0D6E
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin AcidmaxPlayer.isButton cmdSelectTo 
      Height          =   315
      Left            =   3480
      TabIndex        =   7
      Top             =   450
      Width           =   855
      _extentx        =   1508
      _extenty        =   556
      icon            =   "frmSendMail.frx":0D96
      style           =   1
      caption         =   "S&elect"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0DB2
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin AcidmaxPlayer.isButton cmdSelectFrom 
      Height          =   315
      Left            =   3480
      TabIndex        =   8
      Top             =   120
      Width           =   855
      _extentx        =   1508
      _extenty        =   556
      icon            =   "frmSendMail.frx":0DDA
      style           =   1
      caption         =   "&Select"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0DF6
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin AcidmaxPlayer.isButton cmdConfig 
      Height          =   315
      Left            =   3480
      TabIndex        =   10
      Top             =   960
      Width           =   855
      _extentx        =   1508
      _extenty        =   556
      icon            =   "frmSendMail.frx":0E1E
      style           =   1
      caption         =   "C&onfig"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0E3A
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin AcidmaxPlayer.isButton cmdSend 
      Default         =   -1  'True
      Height          =   315
      Left            =   2520
      TabIndex        =   11
      Top             =   4080
      Width           =   855
      _extentx        =   1508
      _extenty        =   556
      icon            =   "frmSendMail.frx":0E62
      style           =   1
      caption         =   "&Send"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0E7E
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin AcidmaxPlayer.isButton cmdCancel 
      Height          =   315
      Left            =   3480
      TabIndex        =   12
      Top             =   4080
      Width           =   855
      _extentx        =   1508
      _extenty        =   556
      icon            =   "frmSendMail.frx":0EA6
      style           =   1
      caption         =   "&Cancel"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmSendMail.frx":0EC2
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      X1              =   0
      X2              =   4440
      Y1              =   850
      Y2              =   850
   End
   Begin VB.Label Label2 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "To:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   480
      Width           =   615
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "From:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "frmSendMail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
