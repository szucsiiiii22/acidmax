VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Send Mail"
   ClientHeight    =   4530
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4380
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
   ScaleHeight     =   302
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   292
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmrDelayToSendSuccess 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1560
      Top             =   4560
   End
   Begin VB.Timer tmrSendMail 
      Enabled         =   0   'False
      Interval        =   1500
      Left            =   120
      Top             =   4560
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Interval        =   20000
      Left            =   1080
      Top             =   4560
   End
   Begin VB.Timer tmrSetFocusOnce 
      Enabled         =   0   'False
      Interval        =   150
      Left            =   600
      Top             =   4560
   End
   Begin AcidmaxSendMail.isButton cmdClose 
      Height          =   315
      Left            =   1800
      TabIndex        =   0
      Top             =   4080
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   556
      Icon            =   "frmMain.frx":0CCA
      Style           =   1
      Caption         =   "&Close"
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
   Begin AcidmaxSendMail.isButton cmdSendEmail 
      Height          =   315
      Left            =   3120
      TabIndex        =   9
      Top             =   4080
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   556
      Icon            =   "frmMain.frx":0CE6
      Style           =   1
      Caption         =   "Send E-Mail"
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
   Begin AcidmaxSendMail.isButton cmdAbout 
      Height          =   315
      Left            =   120
      TabIndex        =   10
      Top             =   4080
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   556
      Icon            =   "frmMain.frx":0D02
      Style           =   1
      Caption         =   "About"
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
   Begin VB.Frame fraMail 
      BorderStyle     =   0  'None
      Caption         =   "Frame3"
      Height          =   3615
      Index           =   1
      Left            =   0
      TabIndex        =   6
      Top             =   360
      Visible         =   0   'False
      Width           =   4815
      Begin VB.TextBox txtHost 
         BackColor       =   &H8000000F&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1200
         TabIndex        =   24
         Top             =   120
         Width           =   1455
      End
      Begin VB.CheckBox chkSelectHostAutomatically 
         Caption         =   "Automatic"
         Height          =   255
         Left            =   2880
         TabIndex        =   23
         Top             =   120
         Value           =   1  'Checked
         Width           =   1095
      End
      Begin VB.ComboBox cboTimeout 
         Height          =   315
         ItemData        =   "frmMain.frx":0D1E
         Left            =   1200
         List            =   "frmMain.frx":0D20
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   480
         Width           =   1455
      End
      Begin VB.CheckBox chkEnableTimeout 
         Caption         =   "Timeout:"
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   480
         Value           =   1  'Checked
         Width           =   2535
      End
      Begin AcidmaxSendMail.isButton cmdAddEmailAccount 
         Height          =   315
         Left            =   120
         TabIndex        =   27
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":0D22
         Style           =   1
         Caption         =   "Add"
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
      Begin AcidmaxSendMail.ctlListView lvwEmailAccounts 
         Height          =   1575
         Left            =   120
         TabIndex        =   28
         Top             =   960
         Width           =   4095
         _ExtentX        =   7223
         _ExtentY        =   2778
      End
      Begin AcidmaxSendMail.isButton cmdDeleteAccount 
         Height          =   315
         Left            =   1080
         TabIndex        =   29
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":0D3E
         Style           =   1
         Caption         =   "Delete"
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
      Begin AcidmaxSendMail.isButton cmdModifyAccount 
         Height          =   315
         Left            =   2040
         TabIndex        =   30
         Top             =   3240
         Visible         =   0   'False
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":0D5A
         Style           =   1
         Caption         =   "Modify"
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
      Begin VB.Label lblActiveAccountName 
         Height          =   255
         Left            =   1560
         TabIndex        =   38
         Top             =   2640
         Width           =   1455
      End
      Begin VB.Label lblReplyToAccountName 
         Height          =   255
         Left            =   1560
         TabIndex        =   37
         Top             =   2880
         Width           =   1455
      End
      Begin VB.Label lblActiveAccount 
         Caption         =   "Active Account:"
         Height          =   255
         Left            =   120
         TabIndex        =   36
         Top             =   2640
         Width           =   1215
      End
      Begin VB.Label lblReplyToAccount 
         Caption         =   "Reply to Account:"
         Height          =   255
         Left            =   120
         TabIndex        =   35
         Top             =   2880
         Width           =   1455
      End
      Begin VB.Label lblSelectActiveAccount 
         Alignment       =   1  'Right Justify
         Caption         =   "Select"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3720
         MouseIcon       =   "frmMain.frx":0D76
         MousePointer    =   99  'Custom
         TabIndex        =   34
         Top             =   2640
         Width           =   495
      End
      Begin VB.Label lblSelectReplyToAccount 
         Alignment       =   1  'Right Justify
         Caption         =   "Select"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3720
         MouseIcon       =   "frmMain.frx":0EC8
         MousePointer    =   99  'Custom
         TabIndex        =   33
         Top             =   2880
         Width           =   495
      End
      Begin VB.Label lblClearActiveAccount 
         Alignment       =   1  'Right Justify
         Caption         =   "Clear"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3120
         MouseIcon       =   "frmMain.frx":101A
         MousePointer    =   99  'Custom
         TabIndex        =   32
         Top             =   2640
         Width           =   495
      End
      Begin VB.Label lblClearReply 
         Alignment       =   1  'Right Justify
         Caption         =   "Clear"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3120
         MouseIcon       =   "frmMain.frx":116C
         MousePointer    =   99  'Custom
         TabIndex        =   31
         Top             =   2880
         Width           =   495
      End
      Begin VB.Label lblHost 
         Caption         =   "Host:"
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   120
         Width           =   495
      End
      Begin VB.Label lblSeconds 
         Caption         =   "Seconds"
         Height          =   255
         Left            =   2880
         TabIndex        =   25
         Top             =   520
         Width           =   1095
      End
      Begin VB.Line Line7 
         BorderColor     =   &H00808080&
         X1              =   4365
         X2              =   4365
         Y1              =   0
         Y2              =   3600
      End
      Begin VB.Line Line6 
         BorderColor     =   &H00FFFFFF&
         BorderStyle     =   6  'Inside Solid
         X1              =   2160
         X2              =   4320
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line5 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   1080
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line4 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   0
         Y2              =   3840
      End
   End
   Begin VB.Frame fraMail 
      BorderStyle     =   0  'None
      Caption         =   "Frame3"
      Height          =   3615
      Index           =   2
      Left            =   0
      TabIndex        =   7
      Top             =   360
      Visible         =   0   'False
      Width           =   4815
      Begin AcidmaxSendMail.ctlListView lvwFiles 
         Height          =   2895
         Left            =   120
         TabIndex        =   39
         Top             =   120
         Width           =   4095
         _ExtentX        =   7223
         _ExtentY        =   5106
      End
      Begin AcidmaxSendMail.isButton cmdAddFile 
         Height          =   315
         Left            =   120
         TabIndex        =   40
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":12BE
         Style           =   1
         Caption         =   "Add"
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
      Begin AcidmaxSendMail.isButton cmdDel 
         Height          =   315
         Left            =   1080
         TabIndex        =   41
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":12DA
         Style           =   1
         Caption         =   "Remove"
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
      Begin AcidmaxSendMail.isButton cmdClearAttachments 
         Height          =   315
         Left            =   2040
         TabIndex        =   42
         Top             =   3240
         Visible         =   0   'False
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":12F6
         Style           =   1
         Caption         =   "Clear"
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
      Begin AcidmaxSendMail.isButton cmdSelectAll 
         Height          =   315
         Left            =   3000
         TabIndex        =   43
         Top             =   3240
         Visible         =   0   'False
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":1312
         Style           =   1
         Caption         =   "Check All"
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
      Begin VB.Line Line11 
         BorderColor     =   &H00FFFFFF&
         X1              =   3240
         X2              =   4320
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line10 
         BorderColor     =   &H00808080&
         X1              =   4360
         X2              =   4360
         Y1              =   0
         Y2              =   3720
      End
      Begin VB.Line Line9 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   2160
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line8 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   -120
         Y2              =   3600
      End
   End
   Begin VB.Frame fraMail 
      BorderStyle     =   0  'None
      Height          =   3615
      Index           =   0
      Left            =   0
      TabIndex        =   5
      Top             =   360
      Width           =   4860
      Begin VB.TextBox txtSubject 
         Height          =   285
         Left            =   120
         TabIndex        =   12
         Top             =   120
         Width           =   4095
      End
      Begin VB.TextBox txtMessage 
         Height          =   2985
         Left            =   120
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   11
         Top             =   480
         Width           =   4095
      End
      Begin VB.Line Line2 
         BorderColor     =   &H00FFFFFF&
         X1              =   1080
         X2              =   4320
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   0
         Y2              =   3650
      End
      Begin VB.Line Line3 
         BorderColor     =   &H00C0C0C0&
         X1              =   4365
         X2              =   4365
         Y1              =   0
         Y2              =   3640
      End
   End
   Begin VB.Frame fraMail 
      BorderStyle     =   0  'None
      Caption         =   "Frame3"
      Height          =   3615
      Index           =   3
      Left            =   0
      TabIndex        =   8
      Top             =   360
      Visible         =   0   'False
      Width           =   4815
      Begin AcidmaxSendMail.ctlListView lvwRecipients 
         Height          =   2535
         Left            =   120
         TabIndex        =   13
         Top             =   120
         Width           =   4095
         _ExtentX        =   7223
         _ExtentY        =   4471
      End
      Begin AcidmaxSendMail.isButton cmdAddRecipient 
         Height          =   315
         Left            =   120
         TabIndex        =   14
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":132E
         Style           =   1
         Caption         =   "Add"
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
      Begin AcidmaxSendMail.isButton cmdRemoveRecipient 
         Height          =   315
         Left            =   1080
         TabIndex        =   15
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":134A
         Style           =   1
         Caption         =   "Remove"
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
      Begin AcidmaxSendMail.isButton cmdClear 
         Height          =   315
         Left            =   2040
         TabIndex        =   16
         Top             =   3240
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         Icon            =   "frmMain.frx":1366
         Style           =   1
         Caption         =   "Clear"
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
      Begin VB.Label lblEmailToName 
         Height          =   255
         Left            =   1080
         TabIndex        =   20
         Top             =   2880
         Width           =   3135
      End
      Begin VB.Label lblRecipient 
         Caption         =   "Recipient:"
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   2880
         Width           =   855
      End
      Begin VB.Label lblClearRecipient 
         Caption         =   "Clear"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3120
         MouseIcon       =   "frmMain.frx":1382
         MousePointer    =   99  'Custom
         TabIndex        =   18
         Top             =   3240
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label lblSelect 
         Caption         =   "Select"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   3720
         MouseIcon       =   "frmMain.frx":14D4
         MousePointer    =   99  'Custom
         TabIndex        =   17
         Top             =   3240
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Line Line13 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   3240
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line14 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   0
         Y2              =   3720
      End
      Begin VB.Line Line12 
         BorderColor     =   &H00808080&
         X1              =   4365
         X2              =   4365
         Y1              =   0
         Y2              =   3720
      End
   End
   Begin AcidmaxSendMail.XPButton cmdMail 
      Height          =   375
      Index           =   0
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   661
      BTYPE           =   7
      TX              =   "Message"
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      COLTYPE         =   1
      FOCUSR          =   -1  'True
      BCOL            =   16777215
      BCOLO           =   16777215
      FCOL            =   0
      FCOLO           =   16711680
      MCOL            =   12632256
      MPTR            =   0
      MICON           =   "frmMain.frx":1626
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin AcidmaxSendMail.XPButton cmdMail 
      Height          =   375
      Index           =   1
      Left            =   1095
      TabIndex        =   2
      Top             =   0
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   661
      BTYPE           =   7
      TX              =   "Options"
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      COLTYPE         =   1
      FOCUSR          =   -1  'True
      BCOL            =   16777215
      BCOLO           =   16777215
      FCOL            =   0
      FCOLO           =   16711680
      MCOL            =   12632256
      MPTR            =   0
      MICON           =   "frmMain.frx":1642
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin AcidmaxSendMail.XPButton cmdMail 
      Height          =   375
      Index           =   2
      Left            =   2190
      TabIndex        =   3
      Top             =   0
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   661
      BTYPE           =   7
      TX              =   "Attachments"
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      COLTYPE         =   1
      FOCUSR          =   -1  'True
      BCOL            =   16777215
      BCOLO           =   16777215
      FCOL            =   0
      FCOLO           =   16711680
      MCOL            =   12632256
      MPTR            =   0
      MICON           =   "frmMain.frx":165E
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin AcidmaxSendMail.XPButton cmdMail 
      Height          =   375
      Index           =   3
      Left            =   3285
      TabIndex        =   4
      Top             =   0
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   661
      BTYPE           =   7
      TX              =   "Recipients"
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      COLTYPE         =   1
      FOCUSR          =   -1  'True
      BCOL            =   16777215
      BCOLO           =   16777215
      FCOL            =   0
      FCOLO           =   16711680
      MCOL            =   12632256
      MPTR            =   0
      MICON           =   "frmMain.frx":167A
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin VB.Line Line16 
      BorderColor     =   &H00FFFFFF&
      X1              =   0
      X2              =   293
      Y1              =   265
      Y2              =   265
   End
   Begin VB.Line Line15 
      BorderColor     =   &H00404040&
      X1              =   288
      X2              =   0
      Y1              =   264
      Y2              =   264
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private lConfigFile As String
Private lAttachmentFiles As String
Dim WithEvents lSocket As clsSocket
Attribute lSocket.VB_VarHelpID = -1
Private lFileListIndex As Integer
Private lRecipientIndex As Integer
Private Enum gSmtpStates
    MAIL_CONNECT
    MAIL_HELO
    MAIL_FROM
    MAIL_RCPTTO
    MAIL_DATA
    MAIL_DOT
    MAIL_QUIT
End Enum
Private lState As gSmtpStates
Private lFileListCount As Integer
Private lEmailAccountCount As Integer
Private lEmailAccountIndex As Integer
Private lRecipientCount As Integer
Private lAddMultipleOpen As Boolean
Private lRecipientArray(100) As String
Private lRecipientArray2(100) As String
Private lRecipientArrCount As Integer
Private lCurrentlySending As Boolean
Private lCurrentRecipientName As String
Private lCurrentRecipientEMail As String
Private lDisplayCurrentProgress As Boolean

Public Sub SendMail(lName As String, lEMail As String)
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
If Len(lName) <> 0 And Len(lEMail) <> 0 Then
    DisableProgram False
    lblEmailToName.Tag = lEMail
    lblEmailToName.Caption = lName
    msg = lblEmailToName.Tag
Rep:
    If Len(txtHost.Text) = 0 Then
        If InStr(msg, "@") Then
            msg = Right(msg, Len(msg) - 1)
            If Left(msg, 1) = "@" Then
                msg = Right(msg, Len(msg) - 1)
            Else
                GoTo Rep
            End If
            msg2 = MX_Query(msg)
            If Len(msg2) <> 0 Then
                'chkSelectHostAutomatically.Value = 1
                'txtHost.Text = msg2
                msg = msg2
            End If
        End If
        If Len(msg) <> 0 Then
            If chkEnableTimeout.Enabled = True Then
                tmrTimeout.Enabled = True
                tmrTimeout.interval = Int(Trim(cboTimeout.Text)) * 1000
            End If
            lState = MAIL_CONNECT
            lSocket.Connect msg, 25
        End If
    Else
        If chkEnableTimeout.Enabled = True Then
            tmrTimeout.Enabled = True
            tmrTimeout.interval = Int(Trim(cboTimeout.Text)) * 1000
        End If
        lState = MAIL_CONNECT
        lSocket.Connect txtHost.Text, 25
    End If
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub AddToRecipientsArray(lName As String, lEMail As String)
'Public Sub AddToRecipientsArray(lData As String)
On Local Error GoTo ErrHandler
If Len(lName) <> 0 And Len(lEMail) <> 0 Then
    lRecipientArrCount = lRecipientArrCount + 1
    lRecipientArray(lRecipientArrCount) = lName
    lRecipientArray2(lRecipientArrCount) = lEMail
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub ClearRecipientsArray()
On Local Error GoTo ErrHandler
Dim i As Integer
lRecipientArrCount = 0
For i = 0 To 100
    lRecipientArray(i) = ""
    lRecipientArray2(i) = ""
Next i
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetAddMultipleOpen(lValue As Boolean)
On Local Error GoTo ErrHandler
lAddMultipleOpen = lValue
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function ReturnAddMultipleFilesOpen() As Boolean
On Local Error GoTo ErrHandler
ReturnAddMultipleFilesOpen = lAddMultipleOpen
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub DisableProgram(lValue As Boolean)
On Local Error GoTo ErrHandler
If lValue = True Then
    txtMessage.Enabled = True
    txtSubject.Enabled = True
    lvwEmailAccounts.Enabled = True
    lvwFiles.Enabled = True
    lvwRecipients.Enabled = True
    cmdSelectAll.Enabled = True
    cmdClear.Enabled = True
    cmdAbout.Enabled = True
    cmdAddFile.Enabled = True
    cmdAddFile.Enabled = True
    cmdAddRecipient.Enabled = True
    cmdClose.Enabled = True
    cmdDel.Enabled = True
    cmdMail(0).Enabled = True
    cmdMail(1).Enabled = True
    cmdMail(2).Enabled = True
    cmdMail(3).Enabled = True
    cmdModifyAccount.Enabled = True
    'cmdPrepareAttachments.Enabled = True
    cmdRemoveRecipient.Enabled = True
    cmdSendEmail.Enabled = True
Else
    txtMessage.Enabled = False
    txtSubject.Enabled = False
    lvwEmailAccounts.Enabled = False
    lvwFiles.Enabled = False
    lvwRecipients.Enabled = False
    cmdSelectAll.Enabled = False
    cmdClear.Enabled = False
    cmdAbout.Enabled = False
    cmdAddFile.Enabled = False
    cmdAddFile.Enabled = False
    cmdAddRecipient.Enabled = False
    cmdClose.Enabled = False
    cmdDel.Enabled = False
    cmdMail(0).Enabled = False
    cmdMail(1).Enabled = False
    cmdMail(2).Enabled = False
    cmdMail(3).Enabled = False
    cmdModifyAccount.Enabled = False
    'cmdPrepareAttachments.Enabled = False
    cmdRemoveRecipient.Enabled = False
    cmdSendEmail.Enabled = False
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub RefreshConfigFile()
On Local Error GoTo ErrHandler
Dim c As Integer, i As Integer, msg As String, msg2 As String, msg3 As String
For i = 0 To lvwEmailAccounts.Count
    If Len(lvwEmailAccounts.ItemText(i)) <> 0 Then
        msg = lvwEmailAccounts.ItemText(i)
        msg2 = lvwEmailAccounts.SubItemText(i, 1)
        msg3 = lvwEmailAccounts.SubItemText(i, 2)
        If Len(msg) <> 0 And Len(msg2) <> 0 Then
            WriteINI lConfigFile, "Account" & Trim(Str(i + 1)), "Name", msg
            WriteINI lConfigFile, "Account" & Trim(Str(i + 1)), "EMail", msg2
            WriteINI lConfigFile, "Account" & Trim(Str(i + 1)), "Primary", msg3
            c = c + 1
        End If
    End If
Next i
WriteINI lConfigFile, "Settings", "AccountCount", Trim(Str(c))
c = 0
For i = 0 To lvwRecipients.Count
    If Len(lvwRecipients.ItemText(i)) <> 0 Then
        msg = lvwRecipients.ItemText(i)
        msg2 = lvwRecipients.SubItemText(i, 1)
        If Len(msg) <> 0 And Len(msg2) <> 0 Then
            WriteINI lConfigFile, "Contact" & Trim(Str(i + 1)), "Name", msg
            WriteINI lConfigFile, "Contact" & Trim(Str(i + 1)), "EMail", msg2
            c = c + 1
        End If
    End If
Next i
WriteINI lConfigFile, "Settings", "ContactCount", Trim(Str(c))
WriteINI lConfigFile, "Settings", "ActiveAccountName", lblActiveAccountName.Caption
WriteINI lConfigFile, "Settings", "ActiveAccountEmail", lblActiveAccountName.Tag
WriteINI lConfigFile, "Settings", "ReplyToAccountName", lblReplyToAccountName.Caption
WriteINI lConfigFile, "Settings", "ReplyToAccountEMail", lblReplyToAccountName.Tag
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub PrepareAttachments()
On Local Error GoTo ErrHandler
Dim i As Integer, msg As String, msg2 As String
lAttachmentFiles = ""
ShowNonModalForm frmSending
frmSending.Caption = App.Title & " - Converting Attachments"
frmSending.lblStatus.Caption = "Please wait ..."
frmSending.Refresh
DoEvents
For i = 0 To lvwFiles.Count - 1
    If Len(lvwFiles.ItemText(i)) <> 0 Then
        If lvwFiles.ItemChecked(i) = True Then
            msg2 = lvwFiles.SubItemText(i, 1)
            If DoesFileExist(msg2) = True Then
                frmSending.lblStatus.Caption = "UUEncoding '" & msg2 & "', please wait"
                frmSending.Refresh
                DoEvents
                msg = UUEncodeFile(msg2) & vbCrLf & msg
                'If Len(msg) = 0 Then
                '    msg = UUEncodeFile(msg2) & vbCrLf
                'Else
                '    msg = msg & UUEncodeFile(msg2) & vbCrLf
                'End If
            End If
        End If
    End If
Next i
Unload frmSending
lAttachmentFiles = msg
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub AddToRecipients(lName As String, lEMail As String)
On Local Error GoTo ErrHandler
Dim i As Integer
If Len(lName) <> 0 & Len(lEMail) <> 0 Then
    With lvwRecipients
        lRecipientCount = lRecipientCount + 1
        .ItemAdd lRecipientCount, lName, 0, 0
        For i = 0 To .Count
            If LCase(Trim(.ItemText(i))) = Trim(LCase(lName)) Then
                .SubItemSet i, 1, lEMail, 0
                Exit For
            End If
        Next i
    End With
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub AddToFiles(lFile As String, lPath As String, lSize As String)
On Local Error Resume Next
Dim i As Integer
If Len(lFile) <> 0 & Len(lPath) <> 0 And Len(lSize) <> 0 Then
    With lvwFiles
        lEmailAccountCount = lEmailAccountCount + 1
        .ItemAdd lEmailAccountCount, lFile, 0, 0
        For i = 0 To .Count
            If LCase(Trim(.ItemText(i))) = Trim(LCase(lFile)) Then
                .SubItemSet i, 1, lPath, 0
                .SubItemSet i, 2, lSize, 0
                .ItemChecked(i) = True
                Exit For
            End If
        Next i
    End With
End If
End Sub

Public Sub AddToEmailAccounts(lName As String, lEmailAddress As String, lPrimary As String)
On Local Error Resume Next
Dim i As Integer
If Len(lName) <> 0 & Len(lEmailAddress) <> 0 And Len(lPrimary) <> 0 Then
    With lvwEmailAccounts
        lFileListCount = lFileListCount + 1
        .ItemAdd lFileListCount, lName, 0, 0
        For i = 0 To .Count
            If LCase(Trim(.ItemText(i))) = Trim(LCase(lName)) Then
                .SubItemSet i, 1, lEmailAddress, 0
                .SubItemSet i, 2, lPrimary, 0
                Exit For
            End If
        Next i
    End With
End If
End Sub

Private Function MXQuery()
On Error GoTo ErrHandler
MX_Query ("")
If MX.Count Then
    MXQuery = MX.Best
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub cboTimeout_Change()
'SetWindowFocus ReturnParentHwnd
End Sub

Private Sub cboTimeout_Click()
'SetWindowFocus ReturnParentHwnd
End Sub

Private Sub chkEnableTimeout_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
If chkEnableTimeout.Value = 0 Then
    cboTimeout.Enabled = False
Else
    cboTimeout.Enabled = True
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub chkSelectHostAutomatically_Click()
On Local Error GoTo ErrHandler
If chkSelectHostAutomatically.Value = 1 Then
    txtHost.Enabled = False
    txtHost.BackColor = &H8000000F
Else
    txtHost.Enabled = True
    txtHost.BackColor = vbWhite
End If
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdAbout_Click()
On Local Error GoTo ErrHandler
frmAbout.Show 1
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdAddEmailAccount_Click()
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
msg = InputBox("Enter account display name:")
If Len(msg) <> 0 Then
    msg2 = InputBox("Enter email address:")
    AddToEmailAccounts msg, msg2, "True"
    If Len(lblActiveAccountName.Caption) = 0 And Len(lblActiveAccountName.Tag) = 0 Then
        lblActiveAccountName.Caption = msg
        lblActiveAccountName.Tag = msg2
    End If
    If Len(lblReplyToAccountName.Caption) = 0 And Len(lblReplyToAccountName.Tag) = 0 Then
        lblReplyToAccountName.Caption = msg
        lblReplyToAccountName.Tag = msg2
    End If
    RefreshConfigFile
End If
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdAddFile_Click()
On Local Error GoTo ErrHandler
'Dim msg As String
'msg = OpenDialog(Me, "All Files (*.*)|*.*|", App.Title, CurDir)
''SetWindowFocus ReturnParentHwnd
ShowNonModalForm frmAddMultipleFiles
'AddToFiles GetFileTitle(msg), Left(msg, Len(msg) - Len(GetFileTitle(msg))), Format(FileLen(msg), "###,###,###") & " byte(s)"
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdAddRecipient_Click()
On Local Error GoTo ErrHandler
AddToRecipients InputBox("Enter contact name:"), InputBox("Enter E-Mail address:")
RefreshConfigFile
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdClear_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
lvwRecipients.Clear
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdClearAttachments_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
lvwFiles.Clear
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdClose_Click()
On Local Error GoTo ErrHandler
''SetWindowFocus ReturnParentHwnd
mIRCStatusSend "//frmASM.Close"
'mIRCStatusSend "//window -c @ASM"
'DoEvents
'mIRCStatusSend "//.comclose lASM"
Exit Sub
ErrHandler:
'    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdDel_Click()
On Local Error GoTo ErrHandler
lvwFiles.ItemRemove lFileListIndex
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdDeleteAccount_Click()
On Local Error GoTo ErrHandler
lvwEmailAccounts.ItemRemove lEmailAccountIndex
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdMail_Click(index As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To 3
    fraMail(i).Visible = False
Next i
fraMail(index).Visible = True
Select Case index
Case 0
    txtMessage.SetFocus
    'SetWindowFocus ReturnParentHwnd
Case 1
    chkSelectHostAutomatically.SetFocus
    'SetWindowFocus ReturnParentHwnd
Case 2
    cmdAddFile.SetFocus
    'SetWindowFocus ReturnParentHwnd
Case 3
    cmdAddRecipient.SetFocus
    'SetWindowFocus ReturnParentHwnd
End Select
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdModifyAccount_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdRemoveRecipient_Click()
On Local Error GoTo ErrHandler
lvwRecipients.ItemRemove lRecipientIndex
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdSelectRecipient_Click()

End Sub

Private Sub cmdSelectAll_Click()
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lvwFiles.Count
    lvwFiles.ItemChecked(i) = True
Next i
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function CheckFeilds() As Boolean
On Local Error GoTo ErrHandler
Dim mbox As VbMsgBoxResult, i As Integer, c As Integer
If Len(txtMessage.Text) = 0 Then
    mbox = MsgBox("You have not entered any text for your message body. You must do this to send an e-mail. Would you like to edit your message now?", vbCritical + vbYesNo)
    If mbox = vbYes Then
        fraMail(0).Visible = True
        fraMail(1).Visible = False
        fraMail(2).Visible = False
        fraMail(3).Visible = False
        txtMessage.SetFocus
        Exit Function
    Else
        Exit Function
    End If
End If
If Len(lblActiveAccountName.Caption) = 0 Or Len(lblActiveAccountName.Tag) = 0 Then
    mbox = MsgBox("You have not setup any accounts to send from. Would you like to enter your e-mail address now?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        lblActiveAccountName.Caption = InputBox("Enter a name for this e-mail account")
        If Len(lblActiveAccountName.Caption) <> 0 Then
            lblActiveAccountName.Tag = InputBox("Enter this e-mail accounts address (like name@host.com)")
            If Len(lblActiveAccountName.Tag) = 0 Then
                MsgBox "Unable to continue", vbCritical
                Exit Function
            Else
                mbox = MsgBox("Would you like to use this e-mail address as your return address as well?", vbQuestion + vbYesNo)
                If mbox = vbYes Then
                    lblReplyToAccountName.Caption = lblActiveAccountName.Caption
                    lblReplyToAccountName.Tag = lblActiveAccountName.Tag
                End If
            End If
        Else
            MsgBox "Unable to continue", vbCritical
            Exit Function
        End If
    Else
        Exit Function
    End If
End If
If Len(lblReplyToAccountName.Caption) = 0 Or Len(lblReplyToAccountName.Tag) = 0 Then
    mbox = MsgBox("You have not set your 'Reply To' settings. Would you like to enter one now?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        lblReplyToAccountName.Caption = InputBox("Enter a name for this reply to account")
        If Len(lblReplyToAccountName.Caption) <> 0 Then
            lblReplyToAccountName.Tag = InputBox("Enter this reply to accounts address (like name@foo.com)")
            If Len(lblReplyToAccountName.Tag) = 0 Then
                MsgBox "Unable to continue", vbCritical
                Exit Function
            End If
        Else
            MsgBox "Unable to continue", vbCritical
            Exit Function
        End If
    Else
        Exit Function
    End If
End If
If lvwFiles.Count <> 0 Then
    For i = 0 To lvwFiles.Count
        If Len(lvwFiles.ItemText(i)) <> 0 And lvwFiles.ItemChecked(i) = True Then
            c = c + 1
        End If
    Next i
    If c = 0 Then MsgBox "You have not selected any recipients, can not continue!", vbYesNo + vbQuestion
End If
'If Len(lblEmailToName.Caption) = 0 Or Len(lblEmailToName.Tag) = 0 Then
'    mbox = MsgBox("You have not selected the recipients e-mail address. Would you like to select one now?", vbYesNo + vbQuestion)
'    If mbox = vbYes Then
'        lblEmailToName.Caption = InputBox("Enter name of the recipient")
'        If Len(lblEmailToName.Caption) <> 0 Then
'            lblEmailToName.Tag = InputBox("Enter e-mail address of recipient")
'            If Len(lblEmailToName.Tag) = 0 Then
'                MsgBox "Unable to continue", vbCritical
'                Exit Function
'            End If
'        Else
'            MsgBox "Unable to continue", vbCritical
'            Exit Function
'        End If
'    Else
'        Exit Function
'    End If
'End If
If Len(txtSubject.Text) = 0 Then
    mbox = MsgBox("You must enter a subject to this message to continue, would you like to enter one now?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        txtSubject.Text = InputBox("Enter a subject for this message:")
        If Len(txtSubject.Text) = 0 Then
            MsgBox "Unable to continue", vbCritical
            Exit Function
        End If
    Else
        Exit Function
    End If
End If
CheckFeilds = True
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub cmdSendEmail_Click()
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String, mbox As VbMsgBoxResult, i As Integer, c As Integer
'SetWindowFocus ReturnParentHwnd
If chkSelectHostAutomatically.Value = 0 And Len(txtHost.Text) = 0 Then
    chkSelectHostAutomatically.Value = 1
    txtHost.BackColor = &H8000000F
End If
If CheckFeilds = True Then
    ClearRecipientsArray
    For i = 0 To lvwRecipients.Count
        If Len(lvwRecipients.ItemText(i)) <> 0 Then
            If lvwRecipients.ItemChecked(i) = True Then
                c = c + 1
                AddToRecipientsArray lvwRecipients.ItemText(i), lvwRecipients.SubItemText(i, 1)
            End If
        End If
    Next i
    If c <> 0 Then
        PrepareAttachments
        tmrSendMail.Enabled = True
    Else
        MsgBox "No recipients have been selected", vbExclamation
    End If
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Command1_Click()
PrepareAttachments
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim i As Integer, c As Integer, msg As String, msg2 As String, msg3 As String
For i = 10 To 60
    cboTimeout.AddItem Trim(Str(i))
Next i
cboTimeout.ListIndex = 0
lConfigFile = App.Path & "\asm.ini"
SetWindowToChild Trim(CLng(Me.hWnd))
'tmrSetFocusOnce.Enabled = True
Set lSocket = New clsSocket
txtHost = MXQuery
txtHost.Text = Replace(txtHost, "mx", "smtp")
lvwRecipients.Initialize
lvwRecipients.BorderStyle = bsThin
lvwRecipients.ViewMode = vmDetails
lvwRecipients.ColumnAdd 0, "Name", 95, [caLeft]
lvwRecipients.ColumnAdd 1, "E-Mail", 150, [caLeft]
lvwRecipients.Font.name = "Tahoma"
lvwRecipients.FullRowSelect = True
lvwRecipients.HeaderFlat = False
lvwRecipients.HeaderHide = False
lvwRecipients.Font = "Tahoma"
lvwRecipients.CheckBoxes = True
lvwFiles.Initialize
lvwFiles.BorderStyle = bsThin
lvwFiles.ViewMode = vmDetails
lvwFiles.ColumnAdd 0, "File", 95, [caLeft]
lvwFiles.ColumnAdd 1, "Path", 100, [caLeft]
lvwFiles.ColumnAdd 2, "Size", 50, [caLeft]
lvwFiles.Font.name = "Tahoma"
lvwFiles.FullRowSelect = True
lvwFiles.HeaderFlat = False
lvwFiles.HeaderHide = False
lvwFiles.Font = "Tahoma"
lvwFiles.CheckBoxes = True
lvwEmailAccounts.Initialize
lvwEmailAccounts.BorderStyle = bsThin
lvwEmailAccounts.ViewMode = vmDetails
lvwEmailAccounts.ColumnAdd 0, "Name", 95, [caLeft]
lvwEmailAccounts.ColumnAdd 1, "E-Mail Address", 105, [caLeft]
lvwEmailAccounts.ColumnAdd 2, "Primary", 50, [caLeft]
lvwEmailAccounts.Font.name = "Tahoma"
lvwEmailAccounts.FullRowSelect = True
lvwEmailAccounts.HeaderFlat = False
lvwEmailAccounts.HeaderHide = False
lvwEmailAccounts.Font = "Tahoma"
txtHost.Text = ReadINI(lConfigFile, "Settings", "Host", "")
lblActiveAccountName.Caption = ReadINI(lConfigFile, "Settings", "ActiveAccountName", "")
lblActiveAccountName.Tag = ReadINI(lConfigFile, "Settings", "ActiveAccountEmail", "")
lblReplyToAccountName.Caption = ReadINI(lConfigFile, "Settings", "ReplyToAccountName", "")
lblReplyToAccountName.Tag = ReadINI(lConfigFile, "Settings", "ReplyToAccountEMail", "")
c = ReadINI(lConfigFile, "Settings", "AccountCount", 0)
If c <> 0 Then
    For i = 1 To c
        msg = ReadINI(lConfigFile, "Account" & Trim(Str(i)), "Name", "")
        msg2 = ReadINI(lConfigFile, "Account" & Trim(Str(i)), "EMail", "")
        msg3 = ReadINI(lConfigFile, "Account" & Trim(Str(i)), "Primary", "")
        If Len(msg) <> 0 And Len(msg2) <> 0 Then AddToEmailAccounts msg, msg2, msg3
    Next i
End If
c = ReadINI(lConfigFile, "Settings", "ContactCount", 0)
If c <> 0 Then
    For i = 1 To c
        msg = ReadINI(lConfigFile, "Contact" & Trim(Str(i)), "Name", "")
        msg2 = ReadINI(lConfigFile, "Contact" & Trim(Str(i)), "EMail", "")
        If Len(msg) <> 0 And Len(msg2) <> 0 Then AddToRecipients msg, msg2
    Next i
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMe()
On Local Error GoTo ErrHandler
Set lSocket = Nothing
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_Unload(Cancel As Integer)
'On Local Error GoTo ErrHandler
'lvwEmailAccounts.Clear
'lvwFiles.Clear
'lvwRecipients.Clear
'txtHost.Text = ""
'txtMessage.Text = ""
'txtSubject.Text = ""
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
End Sub

Private Sub fraAttachments_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraContacts_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraEMailAccounts_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Frame2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub isButton1_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraMail_MouseDown(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraMailServer_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub isButton3_Click()
'SetWindowFocus ReturnParentHwnd
End Sub

Private Sub fraMessage_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraServerTimeout_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraSubject_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Label1_Click()

End Sub

Private Sub lblActiveAccount_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblActiveAccountName_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblClearActiveAccount_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
lblClearActiveAccount.ForeColor = vbGreen
End Sub

Private Sub lblClearActiveAccount_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
lblClearActiveAccount.ForeColor = vbBlue
'SetWindowFocus ReturnParentHwnd
lblActiveAccountName.Caption = ""
lblActiveAccountName.Tag = ""
RefreshConfigFile
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblClearRecipient_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
lblClearRecipient.ForeColor = vbGreen
End Sub

Private Sub lblClearRecipient_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
lblClearRecipient.ForeColor = vbBlue
lblEmailToName.Caption = ""
lblEmailToName.Tag = ""
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblClearReply_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
lblClearReply.ForeColor = vbGreen
End Sub

Private Sub lblClearReply_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
lblClearReply.ForeColor = vbBlue
'SetWindowFocus ReturnParentHwnd
lblReplyToAccountName.Caption = ""
lblReplyToAccountName.Tag = ""
RefreshConfigFile
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblEmailToName_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblHost_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblRecipient_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblReplyToAccount_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblReplyToAccountName_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblSeconds_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblSelect_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
lblSelect.ForeColor = vbGreen
End Sub

Private Sub lblSelect_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
lblSelect.ForeColor = vbBlue
'SetWindowFocus ReturnParentHwnd
lblEmailToName.Caption = lvwRecipients.ItemText(lRecipientIndex)
lblEmailToName.Tag = lvwRecipients.SubItemText(lRecipientIndex, 1)
msg = lblEmailToName.Tag
Rep:
If InStr(msg, "@") Then
    msg = Right(msg, Len(msg) - 1)
    If Left(msg, 1) = "@" Then
        msg = Right(msg, Len(msg) - 1)
    Else
        GoTo Rep
    End If
    If Len(msg) <> 0 Then
        msg2 = MX_Query(msg)
        If Len(msg2) <> 0 Then
            chkSelectHostAutomatically.Value = 0
            txtHost.Text = msg2
        End If
    End If
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblSelectActiveAccount_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
lblSelectActiveAccount.ForeColor = vbGreen
End Sub

Private Sub lblSelectActiveAccount_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
lblSelectActiveAccount.ForeColor = vbBlue
lblActiveAccountName.Caption = lvwEmailAccounts.ItemText(lEmailAccountIndex)
lblActiveAccountName.Tag = lvwEmailAccounts.SubItemText(lEmailAccountIndex, 1)
RefreshConfigFile
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblSelectReplyToAccount_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
lblSelectReplyToAccount.ForeColor = vbGreen
End Sub

Private Sub lblSelectReplyToAccount_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
lblSelectReplyToAccount.ForeColor = vbBlue
'SetWindowFocus ReturnParentHwnd
lblReplyToAccountName.Caption = lvwEmailAccounts.ItemText(lEmailAccountIndex)
lblReplyToAccountName.Tag = lvwEmailAccounts.SubItemText(lEmailAccountIndex, 1)
RefreshConfigFile
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblSMTPHost_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblSubject_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lSocket_SendProgress(ByVal bytesSent As Long, ByVal bytesRemaining As Long)
If lDisplayCurrentProgress = True Then
    If frmSending.prgSendProgress.Max <> bytesSent + bytesRemaining Then frmSending.prgSendProgress.Max = bytesRemaining + bytesSent
    frmSending.prgSendProgress.Value = bytesSent
End If
End Sub

Private Sub lvwEmailAccounts_ItemClick(Item As Integer)
On Local Error GoTo ErrHandler
lEmailAccountIndex = Item
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwEmailAccounts_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwEmailAccounts_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwFiles_ItemClick(Item As Integer)
On Local Error GoTo ErrHandler
lFileListIndex = Item
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwFiles_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwFiles_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwRecipients_ItemClick(Item As Integer)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
lRecipientIndex = Item
'lblSelect_MouseUp 0, 0, 0, 0
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwRecipients_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwRecipients_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmr_Timer()

End Sub

Private Sub tmrDelayToSendSuccess_Timer()
On Local Error GoTo ErrHandler
frmSending.lblStatus.Caption = "Send Successfull"
lState = MAIL_QUIT
lSocket.SendData "QUIT" & vbCrLf
DisableProgram True
tmrDelayToSendSuccess.Enabled = False
lCurrentlySending = False
Unload frmSending
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrSendMail_Timer()
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String, msg3 As String, msg4 As String, i As Integer, c As Integer, tmp As String
If lCurrentlySending = False Then
    For i = 0 To lRecipientArrCount
        If lCurrentlySending = False Then
            If Len(lRecipientArray(i)) <> 0 And Len(lRecipientArray2(i)) <> 0 Then
                lCurrentlySending = True
                'msg = lRecipientArray(i)
                'tmp = msg
                'lRecipientArray(i) = ""
                'If InStr(tmp, ":") Then
'ChopSuey:
                    'msg4 = Left(tmp, 1)
                    'tmp = Right(tmp, Len(tmp) - 1)
                    'If Left(tmp, 1) = ":" Then
                    '    tmp = ""
                    '    msg3 = msg4
                    '    msg2 = Right(msg, Len(msg) - Len(msg2)) - 1
                    'Else
                    '    GoTo ChopSuey
                    'End If
                'End If
                'msg3 = Right(msg, Len(msg) - Len(msg2))
                'MsgBox msg
                'MsgBox msg2
                'MsgBox msg3
                SendMail lRecipientArray(i), lRecipientArray2(i)
                lRecipientArray(i) = ""
                lRecipientArray2(i) = ""
                c = c + 1
                tmrSendMail.Enabled = False
                Exit Sub
            End If
        End If
    Next i
    If c = 0 Then
        tmrSendMail.Enabled = False
        lCurrentlySending = False
        DisableProgram True
    End If
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrSetFocusOnce_Timer()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
tmrSetFocusOnce.Enabled = False
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrTimeout_Timer()
On Local Error GoTo ErrHandler
MsgBox "Sending of message has timed out", vbExclamation
Unload frmSending
tmrTimeout.Enabled = False
lSocket.CloseSck
DisableProgram True
lCurrentlySending = False
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lSocket_DataArrival(ByVal bytesTotal As Long)
On Local Error GoTo ErrHandler
Dim strServerResponse As String, strResponseCode As String, strDataToSend As String, strMessage As String
lSocket.GetData strServerResponse
strResponseCode = Left(strServerResponse, 3)
If strResponseCode = "250" Or strResponseCode = "220" Or strResponseCode = "354" Then
    Select Case lState
    Case MAIL_CONNECT
        lState = MAIL_HELO
        lSocket.SendData "EHLO " & Left$(Trim(lblActiveAccountName.Tag), InStr(1, Trim(lblActiveAccountName.Tag), "@") - 1) & vbCrLf
        'frmSending.prgSendProgress.Value = 5
        frmSending.lblStatus.Caption = "Connected to mail server, sending account name"
    Case MAIL_HELO
        lState = MAIL_FROM
        lSocket.SendData "MAIL FROM:<" & Trim$(lblActiveAccountName.Tag) & ">" & vbCrLf
        'frmSending.prgSendProgress.Value = 10
        frmSending.lblStatus.Caption = "Sending senders E-Mail address"
    Case MAIL_FROM
        lState = MAIL_RCPTTO
        lSocket.SendData "RCPT TO:<" & Trim$(lblEmailToName.Tag) & ">" & vbCrLf
        'frmSending.prgSendProgress.Value = 15
        frmSending.lblStatus.Caption = "Sending recievers E-Mail address"
    Case MAIL_RCPTTO
        lState = MAIL_DATA
        lSocket.SendData "DATA" & vbCrLf
        'frmSending.prgSendProgress.Value = 20
        frmSending.lblStatus.Caption = "Preparing to send message..."
    Case MAIL_DATA
        'frmSending.prgSendProgress.Value = 25
        frmSending.lblStatus.Caption = "Sending message"
        lState = MAIL_DOT
        lSocket.SendData "From:" & lblActiveAccountName.Caption & " <" & lblActiveAccountName.Tag & ">" & vbCrLf
        ''frmSending.prgSendProgress.Value = 60
        lSocket.SendData "To:" & lblEmailToName.Caption & " <" & lblEmailToName.Tag & ">" & vbCrLf
        'frmSending.prgSendProgress.Value = 70
        If Len(lblReplyToAccountName.Tag) <> 0 Then
            lSocket.SendData "Subject:" & txtSubject & vbCrLf
            lSocket.SendData "Reply-To:" & lblReplyToAccountName.Caption & " <" & lblReplyToAccountName.Tag & ">" & vbCrLf & vbCrLf
        Else
            lSocket.SendData "Subject:" & txtSubject & vbCrLf & vbCrLf
        End If
        'frmSending.prgSendProgress.Value = 80
        tmrTimeout.Enabled = False
        strMessage = txtMessage & vbCrLf & vbCrLf & lAttachmentFiles
        'lAttachmentFiles = ""
        frmSending.lblStatus.Caption = "Sending message to '" & lblEmailToName.Caption & " (" & lblEmailToName.Tag & ")"
        lDisplayCurrentProgress = True
        lSocket.SendData strMessage & vbCrLf
        lDisplayCurrentProgress = False
        'frmSending.prgSendProgress.Value = 90
        strMessage = ""
        lSocket.SendData "." & vbCrLf
        tmrDelayToSendSuccess.Enabled = True
    Case MAIL_DOT
        tmrDelayToSendSuccess.Enabled = False
        'frmSending.prgSendProgress.Value = 95
        frmSending.lblStatus.Caption = "Send Successfull"
        lState = MAIL_QUIT
        lSocket.SendData "QUIT" & vbCrLf
        Unload frmSending
        'MsgBox "Message Sent to '" & lblEmailToName.Caption & "'", vbInformation
        DisableProgram True
        lCurrentlySending = False
        tmrSendMail.Enabled = True
    Case MAIL_QUIT
        lSocket.CloseSck
    End Select
Else
    lSocket.CloseSck
    DisableProgram True
    If Not lState = MAIL_QUIT Then MsgBox "Error - " & strResponseCode
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lSocket_Error(ByVal Number As Integer, Description As String, ByVal sCode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
On Local Error GoTo ErrHandler
lSocket.CloseSck
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

'Private Sub txtSubject_KeyPress(KeyAscii As Integer)
'On Local Error GoTo ErrHandler
'If KeyAscii = 13 And Len(txtSubject.Text) <> 0 Then
'    txtMessage.SetFocus
'    KeyAscii = 0
'End If
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
'End Sub
