VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   ClientHeight    =   4710
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   6525
   ClipControls    =   0   'False
   ControlBox      =   0   'False
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
   ScaleHeight     =   4710
   ScaleWidth      =   6525
   Visible         =   0   'False
   Begin MSComctlLib.Toolbar tblTop 
      Align           =   1  'Align Top
      Height          =   810
      Left            =   0
      TabIndex        =   18
      Top             =   0
      Width           =   6525
      _ExtentX        =   11509
      _ExtentY        =   1429
      ButtonWidth     =   1455
      ButtonHeight    =   1429
      ToolTips        =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "imlTop"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
            Style           =   2
            Value           =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
            Style           =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
            Style           =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
            Style           =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
            Style           =   2
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
            Style           =   2
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   3975
      Left            =   7440
      ScaleHeight     =   3975
      ScaleWidth      =   1215
      TabIndex        =   13
      Top             =   840
      Visible         =   0   'False
      Width           =   1215
      Begin VB.Timer tmrDelayRefreshToolBar 
         Enabled         =   0   'False
         Interval        =   500
         Left            =   120
         Top             =   2880
      End
      Begin MSComctlLib.ImageList imlTop 
         Left            =   120
         Top             =   1320
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   48
         ImageHeight     =   48
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":1708A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":18BDE
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":1A732
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":1C286
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":1DDDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":1F92E
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.PictureBox ctlMP3Decode 
         Height          =   375
         Left            =   720
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   21
         Top             =   600
         Width           =   375
      End
      Begin VB.Timer tmrProgress 
         Enabled         =   0   'False
         Interval        =   700
         Left            =   120
         Top             =   2400
      End
      Begin VB.Timer tmrDragBlackLine 
         Enabled         =   0   'False
         Interval        =   1
         Left            =   120
         Top             =   1920
      End
      Begin MSComctlLib.ImageList imlToolbar 
         Left            =   120
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   11
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":21482
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":27D1E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":2E5BA
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":34E56
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":3B6F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":41F8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4882A
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":48D2F
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":49273
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":49744
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4A398
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.ImageList IMG 
         Left            =   120
         Top             =   720
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   162
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4AFEC
               Key             =   "IMG1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4BCC6
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4C9A6
               Key             =   "IMG2"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4D7F8
               Key             =   "IMG4"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4E0D2
               Key             =   "IMG8"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4E9AC
               Key             =   "IMG10"
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4F286
               Key             =   "IMG11"
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":4FB60
               Key             =   "IMG12"
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5043A
               Key             =   "IMG13"
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":50754
               Key             =   "IMG15"
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5102E
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5190A
               Key             =   "IMG16"
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":521E4
               Key             =   "IMG18"
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":52ABE
               Key             =   "IMG19"
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":53398
               Key             =   "IMG21"
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":53C72
               Key             =   "IMG22"
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5454C
               Key             =   "IMG23"
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":54E26
               Key             =   "IMG24"
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":55700
               Key             =   "IMG25"
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":55FDA
               Key             =   "IMG26"
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":568B4
               Key             =   "IMG30"
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5716A
               Key             =   "IMG31"
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":57A44
               Key             =   "IMG34"
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5A1F6
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5AED6
               Key             =   ""
            EndProperty
            BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5BBB6
               Key             =   ""
            EndProperty
            BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5C896
               Key             =   ""
            EndProperty
            BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5D576
               Key             =   ""
            EndProperty
            BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5E256
               Key             =   ""
            EndProperty
            BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5EF36
               Key             =   ""
            EndProperty
            BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":5FC16
               Key             =   ""
            EndProperty
            BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":608F6
               Key             =   ""
            EndProperty
            BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":615D6
               Key             =   ""
            EndProperty
            BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":622B6
               Key             =   ""
            EndProperty
            BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":62F96
               Key             =   ""
            EndProperty
            BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":63C76
               Key             =   ""
            EndProperty
            BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":64956
               Key             =   ""
            EndProperty
            BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":65636
               Key             =   ""
            EndProperty
            BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":66316
               Key             =   ""
            EndProperty
            BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":66FF6
               Key             =   ""
            EndProperty
            BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":67CD6
               Key             =   ""
            EndProperty
            BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":689B6
               Key             =   ""
            EndProperty
            BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":69696
               Key             =   ""
            EndProperty
            BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6A376
               Key             =   ""
            EndProperty
            BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6B056
               Key             =   ""
            EndProperty
            BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6BD36
               Key             =   ""
            EndProperty
            BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6CA16
               Key             =   ""
            EndProperty
            BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6D6F6
               Key             =   ""
            EndProperty
            BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6E3D6
               Key             =   ""
            EndProperty
            BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6F0B6
               Key             =   ""
            EndProperty
            BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":6FD96
               Key             =   ""
            EndProperty
            BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":70A76
               Key             =   ""
            EndProperty
            BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":71756
               Key             =   ""
            EndProperty
            BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":72436
               Key             =   ""
            EndProperty
            BeginProperty ListImage55 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":72D12
               Key             =   ""
            EndProperty
            BeginProperty ListImage56 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":739F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage57 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":746D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage58 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":753B2
               Key             =   ""
            EndProperty
            BeginProperty ListImage59 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":76092
               Key             =   ""
            EndProperty
            BeginProperty ListImage60 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":76D72
               Key             =   ""
            EndProperty
            BeginProperty ListImage61 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":77A52
               Key             =   "exlamation"
            EndProperty
            BeginProperty ListImage62 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7872E
               Key             =   "critical"
            EndProperty
            BeginProperty ListImage63 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7940A
               Key             =   "information"
            EndProperty
            BeginProperty ListImage64 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7A0E6
               Key             =   "question"
            EndProperty
            BeginProperty ListImage65 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7ADC2
               Key             =   ""
            EndProperty
            BeginProperty ListImage66 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7B69C
               Key             =   ""
            EndProperty
            BeginProperty ListImage67 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7BF76
               Key             =   ""
            EndProperty
            BeginProperty ListImage68 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7C850
               Key             =   ""
            EndProperty
            BeginProperty ListImage69 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7D12A
               Key             =   ""
            EndProperty
            BeginProperty ListImage70 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7DA04
               Key             =   ""
            EndProperty
            BeginProperty ListImage71 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7E2DE
               Key             =   ""
            EndProperty
            BeginProperty ListImage72 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7EBB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage73 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7F492
               Key             =   ""
            EndProperty
            BeginProperty ListImage74 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7FA2E
               Key             =   ""
            EndProperty
            BeginProperty ListImage75 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":7FFCA
               Key             =   ""
            EndProperty
            BeginProperty ListImage76 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":80564
               Key             =   ""
            EndProperty
            BeginProperty ListImage77 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":80B00
               Key             =   ""
            EndProperty
            BeginProperty ListImage78 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8109C
               Key             =   ""
            EndProperty
            BeginProperty ListImage79 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":81638
               Key             =   ""
            EndProperty
            BeginProperty ListImage80 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":81BD4
               Key             =   ""
            EndProperty
            BeginProperty ListImage81 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":82170
               Key             =   ""
            EndProperty
            BeginProperty ListImage82 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8270C
               Key             =   ""
            EndProperty
            BeginProperty ListImage83 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":82CA8
               Key             =   ""
            EndProperty
            BeginProperty ListImage84 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":83244
               Key             =   ""
            EndProperty
            BeginProperty ListImage85 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":837E0
               Key             =   ""
            EndProperty
            BeginProperty ListImage86 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":83D7C
               Key             =   ""
            EndProperty
            BeginProperty ListImage87 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":84318
               Key             =   ""
            EndProperty
            BeginProperty ListImage88 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":848B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage89 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":84E50
               Key             =   ""
            EndProperty
            BeginProperty ListImage90 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":853EC
               Key             =   ""
            EndProperty
            BeginProperty ListImage91 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":85988
               Key             =   ""
            EndProperty
            BeginProperty ListImage92 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":85F24
               Key             =   ""
            EndProperty
            BeginProperty ListImage93 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":864C0
               Key             =   ""
            EndProperty
            BeginProperty ListImage94 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":86A5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage95 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":86FF8
               Key             =   ""
            EndProperty
            BeginProperty ListImage96 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":87594
               Key             =   ""
            EndProperty
            BeginProperty ListImage97 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":87B30
               Key             =   ""
            EndProperty
            BeginProperty ListImage98 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":880CC
               Key             =   ""
            EndProperty
            BeginProperty ListImage99 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":88668
               Key             =   ""
            EndProperty
            BeginProperty ListImage100 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":88C04
               Key             =   ""
            EndProperty
            BeginProperty ListImage101 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":891A0
               Key             =   ""
            EndProperty
            BeginProperty ListImage102 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8973C
               Key             =   ""
            EndProperty
            BeginProperty ListImage103 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":89CD8
               Key             =   ""
            EndProperty
            BeginProperty ListImage104 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8A274
               Key             =   ""
            EndProperty
            BeginProperty ListImage105 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8A810
               Key             =   ""
            EndProperty
            BeginProperty ListImage106 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8ADAC
               Key             =   ""
            EndProperty
            BeginProperty ListImage107 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8B348
               Key             =   ""
            EndProperty
            BeginProperty ListImage108 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8B8E4
               Key             =   ""
            EndProperty
            BeginProperty ListImage109 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8BE80
               Key             =   ""
            EndProperty
            BeginProperty ListImage110 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8C41C
               Key             =   ""
            EndProperty
            BeginProperty ListImage111 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8C9B8
               Key             =   ""
            EndProperty
            BeginProperty ListImage112 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8CF54
               Key             =   ""
            EndProperty
            BeginProperty ListImage113 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8D4F0
               Key             =   ""
            EndProperty
            BeginProperty ListImage114 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8DA8C
               Key             =   ""
            EndProperty
            BeginProperty ListImage115 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8E028
               Key             =   ""
            EndProperty
            BeginProperty ListImage116 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8E5C4
               Key             =   ""
            EndProperty
            BeginProperty ListImage117 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8EB60
               Key             =   ""
            EndProperty
            BeginProperty ListImage118 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8F0FC
               Key             =   ""
            EndProperty
            BeginProperty ListImage119 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8F698
               Key             =   ""
            EndProperty
            BeginProperty ListImage120 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":8FC34
               Key             =   ""
            EndProperty
            BeginProperty ListImage121 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":901D0
               Key             =   ""
            EndProperty
            BeginProperty ListImage122 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage123 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":90D08
               Key             =   "iconform"
            EndProperty
            BeginProperty ListImage124 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":912A4
               Key             =   ""
            EndProperty
            BeginProperty ListImage125 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":91840
               Key             =   ""
            EndProperty
            BeginProperty ListImage126 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":91DDC
               Key             =   ""
            EndProperty
            BeginProperty ListImage127 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":926C0
               Key             =   ""
            EndProperty
            BeginProperty ListImage128 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":92C5A
               Key             =   ""
            EndProperty
            BeginProperty ListImage129 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":931F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage130 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9378E
               Key             =   ""
            EndProperty
            BeginProperty ListImage131 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":93D28
               Key             =   ""
            EndProperty
            BeginProperty ListImage132 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":942C2
               Key             =   ""
            EndProperty
            BeginProperty ListImage133 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9485C
               Key             =   ""
            EndProperty
            BeginProperty ListImage134 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":94DF6
               Key             =   ""
            EndProperty
            BeginProperty ListImage135 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":95390
               Key             =   ""
            EndProperty
            BeginProperty ListImage136 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9592A
               Key             =   ""
            EndProperty
            BeginProperty ListImage137 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":95EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage138 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9645E
               Key             =   ""
            EndProperty
            BeginProperty ListImage139 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":969F8
               Key             =   ""
            EndProperty
            BeginProperty ListImage140 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":96F92
               Key             =   ""
            EndProperty
            BeginProperty ListImage141 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9752C
               Key             =   ""
            EndProperty
            BeginProperty ListImage142 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":97AC6
               Key             =   ""
            EndProperty
            BeginProperty ListImage143 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":98060
               Key             =   ""
            EndProperty
            BeginProperty ListImage144 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":985FA
               Key             =   ""
            EndProperty
            BeginProperty ListImage145 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":98B94
               Key             =   ""
            EndProperty
            BeginProperty ListImage146 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":99478
               Key             =   ""
            EndProperty
            BeginProperty ListImage147 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":99D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage148 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9A640
               Key             =   ""
            EndProperty
            BeginProperty ListImage149 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9AF24
               Key             =   ""
            EndProperty
            BeginProperty ListImage150 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9B808
               Key             =   ""
            EndProperty
            BeginProperty ListImage151 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9BDA4
               Key             =   ""
            EndProperty
            BeginProperty ListImage152 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9CB78
               Key             =   ""
            EndProperty
            BeginProperty ListImage153 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9DABC
               Key             =   ""
            EndProperty
            BeginProperty ListImage154 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9E890
               Key             =   ""
            EndProperty
            BeginProperty ListImage155 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":9F664
               Key             =   ""
            EndProperty
            BeginProperty ListImage156 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":A0438
               Key             =   ""
            EndProperty
            BeginProperty ListImage157 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":A13BC
               Key             =   ""
            EndProperty
            BeginProperty ListImage158 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":A1C98
               Key             =   ""
            EndProperty
            BeginProperty ListImage159 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":A2A6C
               Key             =   ""
            EndProperty
            BeginProperty ListImage160 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":A3A80
               Key             =   ""
            EndProperty
            BeginProperty ListImage161 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":A4700
               Key             =   "bgxp2"
            EndProperty
            BeginProperty ListImage162 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMain.frx":B2990
               Key             =   "bgxp1"
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   840
      Width           =   6615
      Begin VB.PictureBox picResizeHorrizontal 
         BorderStyle     =   0  'None
         Height          =   80
         Left            =   60
         MousePointer    =   7  'Size N S
         ScaleHeight     =   75
         ScaleWidth      =   6120
         TabIndex        =   12
         Top             =   1920
         Width           =   6120
      End
      Begin VB.PictureBox picDrag 
         BackColor       =   &H00000000&
         BorderStyle     =   0  'None
         ForeColor       =   &H00000000&
         Height          =   1575
         Left            =   6360
         ScaleHeight     =   1575
         ScaleWidth      =   75
         TabIndex        =   10
         Top             =   360
         Visible         =   0   'False
         Width           =   80
      End
      Begin VB.PictureBox picWhite 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   1575
         Left            =   2400
         Picture         =   "frmMain.frx":C5628
         ScaleHeight     =   1575
         ScaleWidth      =   855
         TabIndex        =   11
         Top             =   360
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.PictureBox picResizeVerticle 
         BorderStyle     =   0  'None
         Height          =   1575
         Left            =   3240
         MousePointer    =   9  'Size W E
         ScaleHeight     =   105
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   5
         TabIndex        =   9
         Top             =   360
         Width           =   80
      End
      Begin VB.ComboBox cboPath 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   0
         TabIndex        =   1
         Text            =   "cboPath"
         Top             =   0
         Width           =   6495
      End
      Begin MSComctlLib.TreeView tvwFiles 
         Height          =   1575
         Left            =   3360
         TabIndex        =   3
         Top             =   360
         Width           =   2895
         _ExtentX        =   5106
         _ExtentY        =   2778
         _Version        =   393217
         HideSelection   =   0   'False
         Indentation     =   53
         Sorted          =   -1  'True
         Style           =   1
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         ImageList       =   "imlToolbar"
         Appearance      =   1
         OLEDragMode     =   1
      End
      Begin MSComctlLib.TreeView tvwFunctions 
         Height          =   1575
         Left            =   0
         TabIndex        =   4
         Top             =   360
         Width           =   3255
         _ExtentX        =   5741
         _ExtentY        =   2778
         _Version        =   393217
         HideSelection   =   0   'False
         Indentation     =   53
         LabelEdit       =   1
         Style           =   5
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         ImageList       =   "imlToolbar"
         Appearance      =   1
      End
      Begin MSComctlLib.ListView lvwPending 
         Height          =   1815
         Left            =   0
         TabIndex        =   2
         Top             =   2040
         Width           =   6495
         _ExtentX        =   11456
         _ExtentY        =   3201
         View            =   3
         MultiSelect     =   -1  'True
         LabelWrap       =   -1  'True
         HideSelection   =   -1  'True
         OLEDropMode     =   1
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         Icons           =   "imlToolbar"
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         Appearance      =   1
         OLEDropMode     =   1
         NumItems        =   9
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Text            =   "File"
            Object.Width           =   5292
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Text            =   "Path"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Text            =   "Function"
            Object.Width           =   4410
         EndProperty
         BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   3
            Text            =   "Format"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(5) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   4
            Text            =   "Duration"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(6) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   5
            Text            =   "Artist"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(7) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   6
            Text            =   "Album"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(8) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   7
            Text            =   "Title"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(9) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   8
            Text            =   "Size"
            Object.Width           =   2540
         EndProperty
      End
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   6
      Left            =   0
      TabIndex        =   27
      Top             =   840
      Visible         =   0   'False
      Width           =   6615
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   3
      Left            =   0
      TabIndex        =   15
      Top             =   840
      Visible         =   0   'False
      Width           =   6855
      Begin Audiogen2.ctlXPButton cmdPause 
         Height          =   350
         Left            =   3600
         TabIndex        =   40
         Top             =   0
         Width           =   1095
         _extentx        =   1931
         _extenty        =   609
         btype           =   3
         tx              =   "Pause"
         enab            =   -1
         font            =   "frmMain.frx":C56CA
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C56F2
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   -1
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdOpenProcess 
         Height          =   345
         Left            =   0
         TabIndex        =   37
         Top             =   0
         Width           =   1095
         _extentx        =   1931
         _extenty        =   609
         btype           =   3
         tx              =   "Open"
         enab            =   -1
         font            =   "frmMain.frx":C5854
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C587C
         picn            =   "frmMain.frx":C59DE
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   -1
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin MSComctlLib.ListView lvwProcesses 
         Height          =   3495
         Left            =   0
         TabIndex        =   16
         Top             =   380
         Width           =   6495
         _ExtentX        =   11456
         _ExtentY        =   6165
         View            =   3
         Arrange         =   1
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         Appearance      =   1
         NumItems        =   8
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Text            =   "Status"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Text            =   "Percent"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Text            =   "Input File"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   3
            Text            =   "Output File"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(5) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   4
            Text            =   "Convert From"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(6) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   5
            Text            =   "Convert To"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(7) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   6
            Text            =   "Input Path"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(8) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   7
            Text            =   "Output Path"
            Object.Width           =   2540
         EndProperty
      End
      Begin Audiogen2.ctlXPButton cmdStopProcess 
         Height          =   345
         Left            =   2400
         TabIndex        =   38
         Top             =   0
         Width           =   1095
         _extentx        =   1931
         _extenty        =   609
         btype           =   3
         tx              =   "Stop"
         enab            =   -1
         font            =   "frmMain.frx":C5F7A
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C5FA2
         picn            =   "frmMain.frx":C6104
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   -1
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdStart 
         Cancel          =   -1  'True
         Height          =   345
         Left            =   1200
         TabIndex        =   39
         Top             =   0
         Width           =   1095
         _extentx        =   1931
         _extenty        =   609
         btype           =   3
         tx              =   "Start"
         enab            =   -1
         font            =   "frmMain.frx":C66A0
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C66C8
         picn            =   "frmMain.frx":C682A
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   -1
         fx              =   0
         check           =   0
         value           =   0
      End
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   4
      Left            =   0
      TabIndex        =   6
      Top             =   840
      Visible         =   0   'False
      Width           =   6615
      Begin Audiogen2.ctlXPButton cmdSearch 
         Height          =   315
         Left            =   5520
         TabIndex        =   30
         Top             =   0
         Width           =   975
         _extentx        =   1931
         _extenty        =   556
         btype           =   2
         tx              =   ""
         enab            =   -1
         font            =   "frmMain.frx":C6DC6
         coltype         =   1
         focusr          =   -1
         bcol            =   14215660
         bcolo           =   14215660
         fcol            =   0
         fcolo           =   0
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C6DF2
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin VB.ComboBox cboSearchType 
         Height          =   315
         Left            =   3000
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   0
         Width           =   2295
      End
      Begin VB.TextBox txtSearch 
         Height          =   315
         Left            =   0
         TabIndex        =   8
         Top             =   0
         Width           =   2895
      End
      Begin MSComctlLib.ListView lvwSearch 
         Height          =   3495
         Left            =   0
         TabIndex        =   7
         Top             =   360
         Width           =   6495
         _ExtentX        =   11456
         _ExtentY        =   6165
         View            =   3
         Arrange         =   1
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         Appearance      =   1
         NumItems        =   6
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Text            =   "Title"
            Object.Width           =   8819
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Text            =   "Artist"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Text            =   "Album"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   3
            Text            =   "Path"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(5) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   4
            Text            =   "File"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(6) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   5
            Text            =   "Type"
            Object.Width           =   2540
         EndProperty
      End
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   1
      Left            =   0
      TabIndex        =   5
      Top             =   840
      Visible         =   0   'False
      Width           =   6615
      Begin MSComctlLib.TreeView tvwPlaylist 
         Height          =   3855
         Left            =   0
         TabIndex        =   14
         Top             =   0
         Width           =   6495
         _ExtentX        =   11456
         _ExtentY        =   6800
         _Version        =   393217
         HideSelection   =   0   'False
         Style           =   7
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         ImageList       =   "imlToolbar"
         Appearance      =   1
         OLEDragMode     =   1
         OLEDropMode     =   1
      End
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   5
      Left            =   0
      TabIndex        =   17
      Top             =   840
      Visible         =   0   'False
      Width           =   6615
      Begin Audiogen2.ctlMovie ctlMovie1 
         Height          =   2775
         Left            =   0
         TabIndex        =   47
         Top             =   840
         Width           =   5895
         _ExtentX        =   10398
         _ExtentY        =   4895
      End
      Begin Audiogen2.ctlXPButton cmdFullScreen 
         Height          =   300
         Left            =   5400
         TabIndex        =   45
         Top             =   0
         Width           =   975
         _extentx        =   1720
         _extenty        =   529
         btype           =   3
         tx              =   "Fullscreen"
         enab            =   0
         font            =   "frmMain.frx":C6E10
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C6E38
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdOpen 
         Height          =   300
         Left            =   3240
         TabIndex        =   44
         Top             =   0
         Width           =   975
         _extentx        =   1720
         _extenty        =   529
         btype           =   3
         tx              =   "Open"
         enab            =   -1
         font            =   "frmMain.frx":C6F9A
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C6FC2
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdStop 
         Height          =   300
         Left            =   2160
         TabIndex        =   43
         Top             =   0
         Width           =   975
         _extentx        =   1720
         _extenty        =   529
         btype           =   3
         tx              =   "Stop"
         enab            =   0
         font            =   "frmMain.frx":C7124
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C714C
         picn            =   "frmMain.frx":C72AE
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdPausePlayback 
         Height          =   300
         Left            =   1080
         TabIndex        =   42
         Top             =   0
         Width           =   975
         _extentx        =   1720
         _extenty        =   529
         btype           =   3
         tx              =   "Pause"
         enab            =   0
         font            =   "frmMain.frx":C784A
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C7872
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdPlay 
         Height          =   300
         Left            =   0
         TabIndex        =   41
         Top             =   0
         Width           =   975
         _extentx        =   1720
         _extenty        =   529
         btype           =   3
         tx              =   "Play"
         enab            =   0
         font            =   "frmMain.frx":C79D4
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C79FC
         picn            =   "frmMain.frx":C7B5E
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin MSComctlLib.Slider sldProgress 
         Height          =   255
         Left            =   960
         TabIndex        =   22
         ToolTipText     =   "Position"
         Top             =   360
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   450
         _Version        =   393216
         Max             =   100
         TickStyle       =   3
         TickFrequency   =   0
      End
      Begin MSComctlLib.Slider sldVolume 
         Height          =   255
         Left            =   3840
         TabIndex        =   23
         ToolTipText     =   "Volume"
         Top             =   360
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   450
         _Version        =   393216
         Max             =   100
         TickStyle       =   3
         TickFrequency   =   0
      End
      Begin Audiogen2.ctlXPButton cmdMute 
         Height          =   300
         Left            =   4320
         TabIndex        =   46
         Top             =   0
         Width           =   975
         _extentx        =   1720
         _extenty        =   529
         btype           =   3
         tx              =   "Mute"
         enab            =   -1
         font            =   "frmMain.frx":C80FA
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   99
         micon           =   "frmMain.frx":C8122
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin VB.Label lblVolume 
         Caption         =   "Volume:"
         Height          =   255
         Left            =   3120
         TabIndex        =   25
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label lblProgress 
         Caption         =   "Progress:"
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label lblFilename 
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   620
         Width           =   5775
      End
   End
   Begin VB.Frame fraFunction 
      BorderStyle     =   0  'None
      Height          =   3975
      Index           =   2
      Left            =   0
      TabIndex        =   26
      Top             =   840
      Visible         =   0   'False
      Width           =   6615
      Begin Audiogen2.ctlXPButton cmdCopy 
         Height          =   375
         Left            =   0
         TabIndex        =   36
         Top             =   390
         Width           =   975
         _extentx        =   1931
         _extenty        =   661
         btype           =   3
         tx              =   "Copy"
         enab            =   0
         font            =   "frmMain.frx":C8284
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C82AC
         picn            =   "frmMain.frx":C82CA
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdCopyAll 
         Height          =   375
         Left            =   1080
         TabIndex        =   35
         Top             =   390
         Width           =   1095
         _extentx        =   1931
         _extenty        =   661
         btype           =   3
         tx              =   "Copy All"
         enab            =   0
         font            =   "frmMain.frx":C8866
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C888E
         picn            =   "frmMain.frx":C88AC
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdConvert 
         Height          =   375
         Left            =   2280
         TabIndex        =   34
         Top             =   390
         Width           =   1095
         _extentx        =   1931
         _extenty        =   661
         btype           =   3
         tx              =   "Convert"
         enab            =   0
         font            =   "frmMain.frx":C8E48
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C8E70
         picn            =   "frmMain.frx":C8E8E
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdPlayCD 
         Height          =   375
         Left            =   3720
         TabIndex        =   33
         Top             =   390
         Width           =   1095
         _extentx        =   2143
         _extenty        =   661
         btype           =   3
         tx              =   "Play"
         enab            =   0
         font            =   "frmMain.frx":C942A
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C9452
         picn            =   "frmMain.frx":C9470
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdPauseCD 
         Height          =   375
         Left            =   4920
         TabIndex        =   32
         Top             =   390
         Width           =   735
         _extentx        =   1720
         _extenty        =   661
         btype           =   3
         tx              =   "Pause"
         enab            =   0
         font            =   "frmMain.frx":C9A0C
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C9A34
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin Audiogen2.ctlXPButton cmdStopCD 
         Height          =   375
         Left            =   5760
         TabIndex        =   31
         Top             =   390
         Width           =   735
         _extentx        =   1931
         _extenty        =   661
         btype           =   3
         tx              =   "Stop"
         enab            =   0
         font            =   "frmMain.frx":C9A52
         coltype         =   1
         focusr          =   -1
         bcol            =   16777215
         bcolo           =   16777215
         fcol            =   0
         fcolo           =   16711680
         mcol            =   12632256
         mptr            =   0
         micon           =   "frmMain.frx":C9A7A
         umcol           =   -1
         soft            =   0
         picpos          =   0
         ngrey           =   0
         fx              =   0
         check           =   0
         value           =   0
      End
      Begin VB.ComboBox cboDrives 
         Height          =   315
         Left            =   0
         Style           =   2  'Dropdown List
         TabIndex        =   29
         Top             =   0
         Width           =   6495
      End
      Begin MSComctlLib.ListView lvwCD 
         Height          =   2775
         Left            =   0
         TabIndex        =   28
         Top             =   840
         Width           =   5055
         _ExtentX        =   8916
         _ExtentY        =   4895
         View            =   3
         LabelEdit       =   1
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         Appearance      =   1
         NumItems        =   6
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Text            =   "Track"
            Object.Width           =   1411
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Text            =   "Artist"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Text            =   "Album"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   3
            Text            =   "Title"
            Object.Width           =   2999
         EndProperty
         BeginProperty ColumnHeader(5) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   4
            Text            =   "Length"
            Object.Width           =   1411
         EndProperty
         BeginProperty ColumnHeader(6) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   5
            Text            =   "Status"
            Object.Width           =   2540
         EndProperty
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Visible         =   0   'False
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuRadio 
      Caption         =   "&Radio"
      Visible         =   0   'False
      Begin VB.Menu mnuAddStation 
         Caption         =   "Add Station"
      End
      Begin VB.Menu mnuRemoveStation 
         Caption         =   "Remove Station"
      End
      Begin VB.Menu mnuSep34789263789 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPlayStation 
         Caption         =   "Play"
      End
      Begin VB.Menu mnuStopStation 
         Caption         =   "Stop"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help"
      Visible         =   0   'False
      Begin VB.Menu mnuTeamNexgen 
         Caption         =   "Team Nexgen"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuAboutAudiogen2 
         Caption         =   "About Audiogen 2"
      End
   End
   Begin VB.Menu mnuFunctionsPopup 
      Caption         =   "<tvwFunctions>"
      Visible         =   0   'False
      Begin VB.Menu mnuToggleExpanded 
         Caption         =   "Expand"
      End
      Begin VB.Menu mnuSearch 
         Caption         =   "Search"
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "Open"
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuProporties2 
         Caption         =   "Proporties"
      End
   End
   Begin VB.Menu mnutvwFile 
      Caption         =   "<tvwFile Menu>"
      Visible         =   0   'False
      Begin VB.Menu mnuPlayFile 
         Caption         =   "Play"
      End
      Begin VB.Menu mnuAddToBatch 
         Caption         =   "Add to Batch"
      End
      Begin VB.Menu mnuHide 
         Caption         =   "Hide"
      End
      Begin VB.Menu mnuSep3789263 
         Caption         =   "-"
      End
      Begin VB.Menu mnuProporties 
         Caption         =   "Proporties"
      End
   End
   Begin VB.Menu mnutvwPlaylistMenu 
      Caption         =   "<tvwPlaylist Menu>"
      Visible         =   0   'False
      Begin VB.Menu mnuPlayThisFile 
         Caption         =   "Play"
      End
      Begin VB.Menu mnuDecode 
         Caption         =   "Decode"
      End
      Begin VB.Menu mnuSepw3897289356 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddFile2 
         Caption         =   "Add File"
      End
      Begin VB.Menu mnuAddToBurnQue 
         Caption         =   "Add to Burn Que"
      End
      Begin VB.Menu mnuRemoveFile 
         Caption         =   "Remove"
      End
      Begin VB.Menu mnuSep397290369264 
         Caption         =   "-"
      End
      Begin VB.Menu mnuChaneTitle 
         Caption         =   "Change Title"
      End
      Begin VB.Menu mnuChangeArtist 
         Caption         =   "Change Artist"
      End
      Begin VB.Menu mnuChangeAlbum 
         Caption         =   "Change Album"
      End
      Begin VB.Menu mnuSep38728302 
         Caption         =   "-"
      End
      Begin VB.Menu mnuReloadPlaylist 
         Caption         =   "Reload Playlist"
      End
   End
   Begin VB.Menu mnutvwPlaylistMenu2 
      Caption         =   "<Album/Artist Maint>"
      Visible         =   0   'False
      Begin VB.Menu mnuExpand 
         Caption         =   "Expand"
      End
      Begin VB.Menu mnuContract 
         Caption         =   "Contract"
      End
      Begin VB.Menu mnuSep837296392 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddFileToArtist 
         Caption         =   "Add File"
      End
      Begin VB.Menu mnuRemoveArtist 
         Caption         =   "Remove"
      End
   End
   Begin VB.Menu mnuPending 
      Caption         =   "<Processes>"
      Visible         =   0   'False
      Begin VB.Menu mnuAddProcess 
         Caption         =   "Add"
         Begin VB.Menu mnuThisEntry 
            Caption         =   "This Entry to Processes"
         End
         Begin VB.Menu mnuSep8923 
            Caption         =   "-"
         End
         Begin VB.Menu mnuProcessAllEntrys 
            Caption         =   "All Entry(s) to Processes"
         End
         Begin VB.Menu mnuSelectedEntrys 
            Caption         =   "Selected Entry(s) to Processes"
         End
      End
      Begin VB.Menu mnuSep397889237 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRemove 
         Caption         =   "Remove"
      End
      Begin VB.Menu mnuClear 
         Caption         =   "Clear"
      End
      Begin VB.Menu mnuSep38972906 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSaveTheseProcesses 
         Caption         =   "Save these Processes"
      End
      Begin VB.Menu mnuSaveAs 
         Caption         =   "Save As ..."
      End
   End
   Begin VB.Menu mnulvwProcesses 
      Caption         =   "<lvwProcesses>"
      Visible         =   0   'False
      Begin VB.Menu mnuControl 
         Caption         =   "Control"
         Begin VB.Menu mnuStartConversion 
            Caption         =   "Start"
         End
         Begin VB.Menu mnuStop 
            Caption         =   "Stop"
         End
         Begin VB.Menu mnuOpen1 
            Caption         =   "Open"
         End
         Begin VB.Menu mnuSep839623876 
            Caption         =   "-"
         End
         Begin VB.Menu mnuPause 
            Caption         =   "Pause"
         End
      End
      Begin VB.Menu mnuChange 
         Caption         =   "Change Output"
         Begin VB.Menu mnuChangeOutputFile 
            Caption         =   "File"
         End
         Begin VB.Menu mnuChangeOutputPath 
            Caption         =   "Path"
         End
         Begin VB.Menu mnuChangeOutputFormat 
            Caption         =   "Format"
         End
      End
      Begin VB.Menu mnuRemoveEntry 
         Caption         =   "Remove"
      End
      Begin VB.Menu mnuClearProcesses 
         Caption         =   "Clear"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private lResizeVert As Boolean
Private Type RECT
    left As Long
    top As Long
    Right As Long
    Bottom As Long
End Type
Private lLabelEdit As String
Private WithEvents wskFreeDB As clsSocketMaster
Attribute wskFreeDB.VB_VarHelpID = -1

Private Sub cboDrives_Click()
'On Local Error Resume Next
Dim lDiscID As String
FillListViewWithTrackCount lvwCD, cboDrives.Text: DoEvents
SetListViewTagWithToc lvwCD, cboDrives.Text
If Len(lvwCD.Tag) <> 0 Then
    lDiscID = ReturnDiscID(lvwCD.Tag)
    If Len(lvwCD.Tag) <> 0 Then ConnectToFreeDB wskFreeDB
End If
End Sub

Private Sub cboPath_Click()
'On Local Error Resume Next
Dim i As Integer, msg As String, msg2 As String
SetWindowFocus ReturnChildWindowHwnd
For i = 1 To frmMain.tvwFunctions.Nodes.Count
    msg = tvwFunctions.Nodes(i).FullPath
    msg = Replace(msg, "Hard Drives\", "") & "\"
    msg = Replace(msg, "Folders\", "")
    msg = Replace(msg, "My Documents\", GetMyDocumentsDir)
    msg = Replace(msg, "My Music\", GetMyDocumentsDir & "\My Documents\My Music\")
    msg = Replace(msg, "Playlist\", "")
    msg = Replace(msg, "\\", "\")
    msg2 = cboPath.Text & "\"
    msg2 = Replace(msg2, "\\", "\")
    msg2 = Replace(msg2, "Installed Hard Drives", "Hard Drives")
    msg2 = Replace(msg2, "Media Folders", "Folders")
    If LCase(msg) = LCase(msg2) Then
        If InStr(msg, "Internet Radio") Then
        Else
            If i <> 0 And i <> 1 Then frmMain.tvwFunctions.Nodes(i).Parent.Expanded = True
            frmMain.tvwFunctions.Nodes(i).Selected = True
            FunctionsTreeView
            DoEvents
            If frmMain.tvwFunctions.Nodes(i).Expanded = False Then frmMain.tvwFunctions.Nodes(i).Expanded = True
            Exit For
        End If
    End If
Next i
End Sub

Private Sub cboPath_GotFocus()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cboPath_KeyPress(KeyAscii As Integer)
'On Local Error Resume Next
If KeyAscii = 13 Then
    KeyAscii = 0
    If left(LCase(cboPath.Text), 7) = "http://" Then
'        ctlRadio1.StopStream
'        ctlRadio1.PlayStream cboPath.Text
    End If
End If
End Sub

Private Sub cmdConvert_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdCopy_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
Dim msg As String, msg2 As String, B As Boolean
msg = lvwCD.SelectedItem.SubItems(1) & " - " & lvwCD.SelectedItem.SubItems(3)
msg = left(msg, Len(msg) - 2) & ".wav"
msg2 = App.Path & "\data\wave\" & lvwCD.SelectedItem.SubItems(1) & " - " & lvwCD.SelectedItem.SubItems(2)
msg2 = left(msg2, Len(msg2) - 2) & "\"
lvwCD.SelectedItem.SubItems(6) = "Copy 0%"
B = CopyTrack(Int(lvwCD.SelectedItem.Text), Trim(cboDrives.Text), msg2, msg)
End Sub

Private Sub cmdCopyAll_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdFullScreen_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
'If frmMain.cmdFullScreen.Caption = "Partial Screen" Then
'    ToggleFullScreen False
'ElseIf frmMain.cmdFullScreen.Caption = "Full Screen" Then
'    ToggleFullScreen True
'End If
End Sub

Private Sub cmdMute_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If cmdMute.Caption = "Mute" Then
    cmdMute.Caption = "Unmute"
    ctlMovie1.Mute False
Else
    cmdMute.Caption = "Mute"
    ctlMovie1.Mute True
End If
End Sub

Private Sub cmdOpen_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
Dim msg As String
msg = Trim(OpenDialog(frmMain, "Supported Types |" & ReturnSupportedTypes & "|", "Open Media", CurDir))
If Len(msg) <> 0 And DoesFileExist(msg) = True Then OpenMediaFile msg, False
End Sub

Private Sub cmdOpenProcess_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
Dim msg As String
msg = lvwProcesses.SelectedItem.SubItems(2)
msg = tvwPlaylist.Nodes(FindTreeViewIndexByFileTitle(msg, tvwPlaylist)).Key
If Len(msg) <> 0 Then
    OpenMediaFile msg, False
End If
If Err.Number <> 0 Then Err.Clear
End Sub

Private Sub cmdPause_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If lvwProcesses.SelectedItem.Text = "Playing" Then
    ctlMovie1.PauseMovie
ElseIf lvwProcesses.SelectedItem.Text = "Decoding" Then
    MsgBox "Unable to pause Decode", vbExclamation
ElseIf lvwProcesses.SelectedItem.Text = "Encoding" Then
    MsgBox "Unable to pause Encode", vbExclamation
ElseIf lvwProcesses.SelectedItem.Text = "Idle" Then
    MsgBox "Process is idle", vbExclamation
End If
End Sub

Private Sub cmdPauseCD_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
'ctlCDPlayer1.PauseCD
End Sub

Private Sub cmdPausePlayback_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If cmdPausePlayback.Caption = "Pause" Then
    frmMain.sldProgress.Enabled = False
    cmdPausePlayback.Caption = "Resume"
    ctlMovie1.PauseMovie
ElseIf cmdPausePlayback.Caption = "Resume" Then
    frmMain.sldProgress.Enabled = True
    cmdPausePlayback.Caption = "Pause"
    ctlMovie1.ResumeMovie
End If
End Sub

Private Sub cmdPlay_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If Len(lblFilename.Tag) <> 0 Then
    ctlMovie1.PlayMovie
Else
    cmdOpen_Click
    DoEvents
    ctlMovie1.PlayMovie
End If
End Sub

Private Sub cmdPlayCD_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
'ctlCDPlayer1.PlayCD
'ctlCDPlayer1.ForwardTrack
End Sub

Private Sub cmdSearch_Click()
'On Local Error Resume Next
Dim i As Integer, msg As String, msg2 As String, mItem As ListItem, msg3 As String, lMP3 As MP3File, lArtist As String, lAlbum As String, lTitle As String
SetWindowFocus ReturnChildWindowHwnd
If cboSearchType.ListIndex = 0 Then
    lvwSearch.ListItems.Clear
    For i = 1 To tvwPlaylist.Nodes.Count
        If Len(tvwPlaylist.Nodes(i).Text) <> 0 Then
            If InStr(LCase(tvwPlaylist.Nodes(i).Key), txtSearch.Text) Then
                msg = tvwPlaylist.Nodes(i).Text
                msg3 = GetFileTitle(tvwPlaylist.Nodes(i).Key)
                msg2 = left(tvwPlaylist.Nodes(i).Key, Len(tvwPlaylist.Nodes(i).Key) - Len(msg3))
                If Len(msg2) <> 0 Then
                    Set mItem = lvwSearch.ListItems.Add(, , msg)
                    lMP3.HasIDv2 = ReadID3v2(tvwPlaylist.Nodes(i).Key, lMP3.IDv2)
                    If lMP3.HasIDv2 = True Then
                        lMP3.IDv2.Artist = CleanInterpreteItems(lMP3.IDv2.Artist)
                        lMP3.IDv2.Album = CleanInterpreteItems(lMP3.IDv2.Album)
                        lMP3.IDv2.Title = CleanInterpreteItems(lMP3.IDv2.Title)
                        lArtist = lMP3.IDv2.Artist
                        lAlbum = lMP3.IDv2.Album
                        lTitle = lMP3.IDv2.Title
                    Else
                        lMP3.HasIDv1 = ReadID3v1(tvwPlaylist.Nodes(i).Key, lMP3.IDv1)
                        If lMP3.HasIDv1 = True Then
                            lMP3.IDv1.Artist = CleanInterpreteItems(lMP3.IDv1.Artist)
                            lMP3.IDv1.Album = CleanInterpreteItems(lMP3.IDv1.Album)
                            lMP3.IDv1.Title = CleanInterpreteItems(lMP3.IDv1.Title)
                            lArtist = lMP3.IDv1.Artist
                            lAlbum = lMP3.IDv1.Album
                            lTitle = lMP3.IDv1.Title
                        End If
                    End If
                    mItem.SubItems(1) = lArtist
                    mItem.SubItems(2) = lAlbum
                    mItem.SubItems(3) = msg2
                    mItem.SubItems(4) = msg3
                    Select Case LCase(Right(msg3, 4))
                    Case ".mp3"
                        mItem.SubItems(5) = "Audio Clip"
                    Case ".wav"
                        mItem.SubItems(5) = "Audio Clip"
                    Case "mpeg"
                        mItem.SubItems(5) = "Video Clip"
                    Case ".avi"
                        mItem.SubItems(5) = "Video Clip"
                    End Select
                End If
            End If
        End If
    Next i
ElseIf cboSearchType.ListIndex = 1 Then
    lvwSearch.ListItems.Clear
    For i = 0 To ReturnDriveCount
        SearchHardDrive ReturnHardDriveLetter(i), lvwSearch
    Next i
End If
End Sub

Private Sub cmdStart_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
StartProcess lvwProcesses.SelectedItem
End Sub

Private Sub cmdStop_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
StopPlayback lblFilename.Tag
End Sub

Private Sub cmdStopCD_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
'ctlCDPlayer1.StopCD
End Sub

Private Sub cmdStopProcess_Click()
'On Local Error Resume Next
Dim msg As String, i As Integer
SetWindowFocus ReturnChildWindowHwnd
If lvwProcesses.SelectedItem.Text = "Play" Then
    msg = frmMain.lvwProcesses.SelectedItem.SubItems(2)
    i = FindTreeViewIndexByFileTitle(msg, tvwPlaylist)
    If i <> 0 Then StopPlayback tvwPlaylist.Nodes(i).Key
ElseIf lvwProcesses.SelectedItem.Text = "Decoding" Then
    ctlMP3Decode.Stop
    ctlMP3Decode.Tag = ""
ElseIf lvwProcesses.SelectedItem.Text = "Encoding" Then
    ctlMP3Encode.Stop
    ctlMP3Encode.Tag = ""
End If
End Sub

Private Sub Command1_Click()
On Local Error Resume Next
Dim i As Integer
i = Int(InputBox("Enter Correction", "a", "0"))
If Me.ScaleHeight <> 0 Then lvwPending.Height = ((Me.ScaleHeight - lvwPending.top) + i)
End Sub

Private Sub ctlMovie1_DBLClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub ctlMovie1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub ctlMovie1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub ctlMP3Decode_PercentDone(ByVal nPercent As Long)
'On Local Error Resume Next
Dim i As Integer
i = FindListViewIndexByFileTitle(GetFileTitle(ctlMP3Decode.Tag), lvwProcesses)
If i <> 0 Then
    If lvwProcesses.ListItems(i).SubItems(1) <> Int(nPercent) & "%" Then
        If Int(nPercent) = 100 Then
            ctlMP3Decode.Tag = ""
            lvwProcesses.ListItems(i).Text = "Finished"
            lvwProcesses.ListItems(i).SubItems(1) = Int(nPercent) & "%"
        Else
            If lvwProcesses.ListItems(i).Text <> "Decoding" Then lvwProcesses.ListItems(i).Text = "Decoding"
            lvwProcesses.ListItems(i).SubItems(1) = Int(nPercent) & "%"
        End If
    End If
End If
End Sub

Private Sub ctlMP3Encode_PercentDone(ByVal nPercent As Long)
'On Local Error Resume Next
Dim i As Integer
i = FindListViewIndexByFileTitle(GetFileTitle(ctlMP3Encode.Tag), lvwProcesses)
If nPercent <> 0 Then
    If i <> 0 Then
        If lvwProcesses.ListItems(i).SubItems(1) <> Int(nPercent) & "%" Then
            If Int(nPercent) = 100 Then
                ctlMP3Encode.Tag = ""
                lvwProcesses.ListItems(i).Text = "Finished"
                lvwProcesses.ListItems(i).SubItems(1) = Int(nPercent) & "%"
            Else
                If lvwProcesses.ListItems(i).Text <> "Encoding" Then lvwProcesses.ListItems(i).Text = "Encoding"
                lvwProcesses.ListItems(i).SubItems(1) = Int(nPercent) & "%"
            End If
        End If
    End If
Else
    If i <> 0 Then
        If lvwProcesses.ListItems(i).Text <> "Finished" And lvwProcesses.ListItems(i).Text <> "Starting" Then lvwProcesses.ListItems(i).Text = "Starting"
    End If
End If
End Sub

Private Sub Form_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_Load()
'On Local Error Resume Next
SetWindowToChild Me.hwnd
Set wskFreeDB = New clsSocketMaster
wskFreeDB.Protocol = sckTCPProtocol
SetDirectories
sldVolume.Value = Int(ReadINI(ReturnIniFilename(iWindowPositions), "sldVolume", "Value", 50))
cboSearchType.AddItem "Search Playlist"
cboSearchType.AddItem "Search Hard Drives"
cboSearchType.ListIndex = 0
tvwPlaylist.Nodes.Clear
tvwPlaylist.Nodes.Add , , "MP3", "Mpeg Audio (*.mp1;*.mp2;*.mp3)", 8
tvwPlaylist.Nodes.Add , , "Wave", "Wave Audio (*.wav)", 8
tvwPlaylist.Nodes.Add , , "Mpeg", "Mpeg Video (*.mpg;*.mpeg)", 8
tvwPlaylist.Nodes.Add , , "Avi", "Avi and DivX Video (*.avi)", 8
tvwPlaylist.Nodes.Add , , "WMA", "Windows Media (*.wma;*.wmv;*.asf;*.wmx)", 8
LoadSettings
LoadDrives
FillComboWithCDDrives cboDrives
FillTreeViewWithDrives tvwFunctions
FillTreeViewWithFolders tvwFunctions
WindowPosition Me, False
InitResizers
If DoesFileExist(ReturnIniFilename(iPlaylistTreeView)) = True Then
    LoadTVFromFile tvwPlaylist, ReturnIniFilename(iPlaylistTreeView)
    tvwPlaylist.Nodes(1).Selected = True
Else
    LoadPlaylist ReturnIniFilename(iPlaylist)
    tvwPlaylist.Nodes(1).Selected = True
End If
cboPath.Text = ""
LoadInternetRadio
Me.left = -2200
Me.top = -30
tmrDelayRefreshToolBar.Enabled = True
If Err.Number <> 0 Then
    MsgBox Err.Description
    Err.Clear
End If
End Sub

Private Sub InitResizers()
'On Local Error Resume Next
picDrag.Height = 80
picDrag.Width = picResizeHorrizontal.Width
picDrag.top = picResizeHorrizontal.top
picDrag.left = picResizeHorrizontal.left
picDrag.Visible = True
picResizeHorrizontal.Visible = False
picDrag.Visible = False
picWhite.Visible = False
picResizeHorrizontal.Visible = True
picResizeHorrizontal.left = 40
lvwPending.top = picResizeHorrizontal.top
lvwPending.Height = Me.Height - lvwPending.top - 1650
tvwFiles.Height = Me.Height - lvwPending.Height - 2000
tvwFunctions.Height = Me.Height - lvwPending.Height - 2000
picResizeVerticle.Height = tvwFiles.Height
picResizeVerticle.Visible = False
picDrag.Height = tvwFunctions.Height - 40
picDrag.Width = picResizeVerticle.Width
picDrag.top = picResizeVerticle.top + 80
picDrag.Visible = True
picWhite.Visible = True
picWhite.Width = picResizeVerticle.Width + 80
picWhite.Height = picResizeVerticle.Height + 180
picWhite.left = picResizeVerticle.left - 50
picWhite.top = picResizeVerticle.top + 50
tvwFunctions.Width = picResizeVerticle.left
tvwFiles.left = picResizeVerticle.left + picResizeVerticle.Width
tvwFiles.Width = Me.ScaleWidth - (tvwFunctions.Width + 100)
picResizeVerticle.top = cboPath.top + cboPath.Height
picResizeVerticle.Visible = True
picDrag.Visible = False
picWhite.Visible = False
picResizeVerticle.Visible = True
End Sub

Public Sub ActiveateResize()
'On Local Error Resume Next
Form_Resize
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_Resize()
On Local Error GoTo ErrHandler
Dim i As Integer
'Exit Sub
If Me.ScaleWidth <> 0 Then tvwFunctions.Width = (Me.ScaleWidth / 2)
If Me.ScaleWidth <> 0 Then tvwFiles.Width = (Me.ScaleWidth / 2) - 80
tvwFiles.left = tvwFunctions.Width + picResizeVerticle.Width - 30
tvwPlaylist.Width = Me.Width - 100
tvwPlaylist.Height = Me.Height - 1660
lvwProcesses.Width = Me.Width - 120
lvwProcesses.Height = Me.Height - 2020
lvwCD.Width = Me.Width - 80
lvwCD.Height = (Me.Height - frmMain.cboDrives.Height) - 2010
cboDrives.Width = Me.ScaleWidth
If Me.ScaleWidth <> 0 Then lvwPending.Width = Me.ScaleWidth - 10
If Me.ScaleHeight <> 0 Then lvwPending.Height = ((Me.ScaleHeight - lvwPending.top) + 100)
'If Me.ScaleHeight <> 0 Then lvwPending.Height = (tblTop.Height + cboPath.Height +
If Me.ScaleHeight <> 0 Then lvwPending.top = (Me.ScaleHeight / 2) - 30
If Me.ScaleHeight <> 0 And Me.ScaleHeight > (lvwPending.Height + tblTop.Height) - 600 Then
    tvwFunctions.Height = Me.ScaleHeight - (lvwPending.Height + tblTop.Height) - 600
    tvwFiles.Height = Me.ScaleHeight - (lvwPending.Height + tblTop.Height) - 600
End If
picResizeHorrizontal.top = lvwPending.top + 30
picResizeHorrizontal.Width = Me.ScaleWidth
picResizeVerticle.left = tvwFunctions.Width
If tvwFunctions.Height > 200 Then picResizeVerticle.Height = tvwFunctions.Height - 200
cboPath.Width = picResizeVerticle.Width
cboPath.Width = Me.ScaleWidth
For i = 0 To fraFunction.UBound
    fraFunction(i).Width = Me.ScaleWidth
    fraFunction(i).Height = Me.ScaleHeight
Next i
lblFilename.Width = Me.ScaleWidth - 250
txtSearch.Width = Me.ScaleWidth / 2 - 600
cboSearchType.Width = Me.ScaleWidth / 2 - 600
cboSearchType.left = txtSearch.Width + 100
lvwSearch.Width = Me.ScaleWidth
lvwSearch.Height = Me.ScaleHeight - 1200
cmdSearch.left = Me.ScaleWidth - cmdSearch.Width - 40
picResizeVerticle.top = cboPath.top + cboPath.Height
If Err.Number <> 0 Then Err.Clear
InitResizers
If LCase(Trim(cmdFullScreen.Caption)) = "full screen" Then
    ctlMovie1.Width = Me.ScaleWidth
    ctlMovie1.Height = Me.ScaleHeight - 1440
    ctlMovie1.SetSize 0, 0, Me.ScaleWidth / Screen.TwipsPerPixelX, Me.ScaleHeight / Screen.TwipsPerPixelY - 114
Else
    ctlMovie1.Width = Me.ScaleWidth
    ctlMovie1.Height = Me.ScaleHeight
    ctlMovie1.SetSize 0, 0, Me.ScaleWidth / Screen.TwipsPerPixelX, Me.ScaleHeight / Screen.TwipsPerPixelY
End If
SetWindowPosition ReturnChildWindowHwnd, 0, 0, (Me.Width) / Screen.TwipsPerPixelX + 3, (Me.Height) / Screen.TwipsPerPixelY + 30: DoEvents
SetWindowFocus ReturnChildWindowHwnd
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error GoTo ErrHandler
cboDrives.Clear
cboSearchType.Clear
tvwFunctions.Nodes.Clear
tvwFiles.Nodes.Clear
tvwPlaylist.Nodes.Clear
txtSearch.Text = ""
lvwCD.ListItems.Clear
lvwProcesses.ListItems.Clear
lvwSearch.ListItems.Clear
ctlMovie1.StopMovie
ctlMovie1.CloseMovie
WindowPosition Me, True
SavePlaylist ReturnIniFilename(iPlaylist)
SaveTVToFile frmMain.tvwPlaylist, ReturnIniFilename(iPlaylistTreeView)
Exit Sub
ErrHandler:
    MsgBox "Unload: " & Err.Description
    Err.Clear
End Sub

Private Sub fraFunction_Click(Index As Integer)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub fraFunction_DblClick(Index As Integer)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub fraFunction_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub fraFunction_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblFilename_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblFilename_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblFilename_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblFilename_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblProgress_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblProgress_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblProgress_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblProgress_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblVolume_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblVolume_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblVolume_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblVolume_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwCD_Click()
'On Local Error Resume Next
'SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwCD_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwCD_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwCD_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwPending_ColumnClick(ByVal ColumnHeader As MSComctlLib.ColumnHeader)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwPending_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
Dim i As Integer
If ProcessEntry(lvwPending.SelectedItem.Key, lvwPending.SelectedItem.SubItems(2), False) = True Then
    ProcessEntry lvwPending.SelectedItem.Key, lvwPending.SelectedItem.SubItems(2), True
    lvwPending.ListItems.Remove lvwPending.SelectedItem.Index
End If
If Err.Number <> 0 Then Err.Clear
End Sub

Private Sub lvwPending_KeyDown(KeyCode As Integer, Shift As Integer)
'On Local Error Resume Next
Select Case KeyCode
Case 46
    lvwPending.ListItems.Remove lvwPending.SelectedItem.Index
    If Err.Number <> 0 Then Err.Clear
End Select
End Sub

Private Sub lvwPending_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnChildWindowHwnd
If Button = 2 Then
    If Len(lvwPending.SelectedItem.Text) <> 0 Then
        If Err.Number <> 0 Then
            Err.Clear
            Exit Sub
        End If
        PopupMenu mnuPending
    End If
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwPending_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwProcesses_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwProcesses_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwProcesses_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If Button = 2 Then
    PopupMenu mnulvwProcesses
End If
End Sub

Private Sub lvwProcesses_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwSearch_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
OpenMediaFile lvwSearch.SelectedItem.SubItems(3) & lvwSearch.SelectedItem.SubItems(4), True
End Sub

Private Sub lvwSearch_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lvwSearch_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub mnuAddFile2_Click()
'On Local Error Resume Next
Dim msg As String, lTag As ID3Tag
msg = OpenDialog(Me, "Supported Files|" & ReturnSupportedTypes & "|", "Select File", CurDir)
If Len(msg) <> 0 Then
    lTag = RenderMp3Tag(msg)
    AddToTreeView tvwPlaylist, tvwPlaylist.SelectedItem.Key, tvwChild, msg, lTag.Title, 9
Else
    AddToTreeView tvwPlaylist, tvwPlaylist.SelectedItem.Key, tvwChild, msg, GetFileTitle(msg), 9
End If
End Sub

Private Sub mnuAddFileToArtist_Click()
'On Local Error Resume Next
Dim msg As String, lTag As ID3Tag
msg = OpenDialog(Me, "Supported Files|" & ReturnSupportedTypes & "|", "Select File", CurDir)
If Len(msg) <> 0 Then
    lTag = RenderMp3Tag(msg)
    AddToTreeView tvwPlaylist, tvwPlaylist.SelectedItem.Key, tvwChild, msg, lTag.Title, 9
Else
    AddToTreeView tvwPlaylist, tvwPlaylist.SelectedItem.Key, tvwChild, msg, GetFileTitle(msg), 9
End If
End Sub

Private Sub mnuAddStation_Click()
'On Local Error Resume Next
PromptAddInternetRadio
End Sub

Private Sub mnuAddToBatch_Click()
'On Local Error Resume Next
If DoesFileExist(tvwFiles.SelectedItem.Key) = True And Len(tvwFiles.SelectedItem.Key) <> 0 Then
    AddToPending tvwFiles.SelectedItem.Key
End If
If Err.Number = 91 Then Err.Clear
End Sub

Private Sub mnuAddToBurnQue_Click()
'On Local Error Resume Next
If DoesFileExist(tvwPlaylist.SelectedItem.Key) = True And Len(tvwPlaylist.SelectedItem.Key) <> 0 Then
    AddToPending tvwPlaylist.SelectedItem.Key
End If
If Err.Number = 91 Then Err.Clear
End Sub

Private Sub mnuChaneTitle_Click()
'On Local Error Resume Next
Dim msg As String, lMP3 As MP3File, lTag As ID3Tag
If DoesFileExist(tvwPlaylist.SelectedItem.Key) = True And Right(LCase(tvwPlaylist.SelectedItem.Key), 4) = ".mp3" Then
    lTag = RenderMp3Tag(tvwPlaylist.SelectedItem.Key): DoEvents
    msg = InputBox("Enter new Title:", App.Title, lTag.Title)
    If Len(msg) <> 0 Then
        lTag.Title = msg
        lMP3.HasIDv2 = ReadID3v2(tvwPlaylist.SelectedItem.Key, lMP3.IDv2)
        If lMP3.HasIDv2 = True Then
            WriteID3v2 tvwPlaylist.SelectedItem.Key, lTag
        Else
            lMP3.HasIDv1 = ReadID3v1(tvwPlaylist.SelectedItem.Key, lMP3.IDv1)
            If lMP3.HasIDv1 = True Then
                WriteID3v1 tvwPlaylist.SelectedItem.Key, lTag
            Else
                WriteID3v2 tvwPlaylist.SelectedItem.Key, lTag
            End If
        End If
    End If
End If
End Sub

Private Sub mnuChangeAlbum_Click()
'On Local Error Resume Next
Dim msg As String, lType As Integer, lMP3 As MP3File, lTag As ID3Tag, i As Integer
If Right(LCase(tvwPlaylist.SelectedItem.Key), 4) = ".mp3" Then
    lTag = RenderMp3Tag(tvwPlaylist.SelectedItem.Key)
    msg = InputBox("Enter new Album:", App.Title, lTag.Album)
    If Len(msg) <> 0 Then
        If DoesFileExist(tvwPlaylist.SelectedItem.Key) = True Then
            lTag.Album = msg
            lMP3.HasIDv2 = ReadID3v2(tvwPlaylist.SelectedItem.Key, lMP3.IDv2)
            If lMP3.HasIDv2 = True Then
                lType = 2
            Else
                lMP3.HasIDv1 = ReadID3v1(tvwPlaylist.SelectedItem.Key, lMP3.IDv1)
                If lMP3.HasIDv1 = True Then
                    lType = 1
                Else
                    lType = 0
                End If
            End If
        End If
    End If
End If
End Sub

Private Sub mnuChangeArtist_Click()
'On Local Error Resume Next
Dim msg As String, msg2 As String, lMP3 As MP3File, lTag As ID3Tag, i As Integer, lFile As String, lFileTitle As String
lFile = tvwPlaylist.SelectedItem.Key
lFileTitle = tvwPlaylist.SelectedItem.Text
If Err.Number = 91 Then
    Err.Clear
    Exit Sub
End If
If DoesFileExist(lFile) = True And Right(LCase(lFile), 4) = ".mp3" Then
    lTag = RenderMp3Tag(lFile): DoEvents
    msg2 = Parse(GetFileTitle(tvwPlaylist.SelectedItem.Key), "(", ")")
    If Len(msg2) = 0 Then
        msg2 = lTag.Artist
    Else
        If Len(lTag.Title) = 0 Then
            lTag.Title = lFileTitle
        End If
    End If
    msg = InputBox("Enter new Artist:", App.Title, msg2)
    If Len(msg) <> 0 Then
        lTag.Artist = msg
        lMP3.HasIDv2 = ReadID3v2(lFile, lMP3.IDv2)
        If lMP3.HasIDv2 = True Then
            WriteID3v2 lFile, lTag
        Else
            lMP3.HasIDv1 = ReadID3v1(lFile, lMP3.IDv1)
            If lMP3.HasIDv1 = True Then
                WriteID3v1 lFile, lTag
            Else
                WriteID3v2 lFile, lTag
            End If
        End If
        DoEvents
        i = FindTreeViewIndex(tvwPlaylist.SelectedItem.Text, tvwPlaylist)
        tvwPlaylist.Nodes.Remove i
        If DoesTreeViewItemExist(msg, tvwPlaylist) = True Then
            If Len(lTag.Title) <> 0 Then
                lFileTitle = lTag.Title
            Else
                If Len(lFileTitle) = 0 Then lFileTitle = GetFileTitle(lFile)
            End If
            AddToTreeView tvwPlaylist, msg, tvwChild, lFile, lFileTitle, 9
        Else
            If Len(lTag.Title) <> 0 Then
                lFileTitle = lTag.Title
            Else
                If Len(lFileTitle) = 0 Then lFileTitle = GetFileTitle(lFile)
            End If
            AddToTreeView tvwPlaylist, "MP3", tvwChild, msg, msg, 8
            AddToTreeView tvwPlaylist, msg, tvwChild, lFile, lFileTitle, 9
        End If
    End If
End If
End Sub

Private Sub mnuClear_Click()
'On Local Error Resume Next
lvwPending.ListItems.Clear
End Sub

Private Sub mnuClearProcesses_Click()
'On Local Error Resume Next
lvwProcesses.ListItems.Clear
End Sub

Private Sub mnuContract_Click()
'On Local Error Resume Next
tvwPlaylist.SelectedItem.Expanded = False
End Sub

Private Sub mnuCreateTag_Click()
'On Local Error Resume Next
Dim lTag As ID3Tag, lMP3 As MP3File
lTag = RenderMp3Tag(tvwPlaylist.SelectedItem.Key)
lMP3.HasIDv2 = ReadID3v2(tvwPlaylist.SelectedItem.Key, lMP3.IDv2)
If lMP3.HasIDv2 = True Then
End If
End Sub

Private Sub mnuExit_Click()
'On Local Error Resume Next
Unload Me
End Sub

Private Sub mnuExpand_Click()
'On Local Error Resume Next
tvwPlaylist.SelectedItem.Expanded = True
End Sub

Private Sub mnuHide_Click()
'On Local Error Resume Next
If Len(tvwFiles.SelectedItem.Key) <> 0 And DoesFileExist(tvwFiles.SelectedItem.Key) = True Then
    tvwFiles.Nodes.Remove tvwFiles.SelectedItem.Index
End If
If Err.Number = 91 Then Err.Clear
End Sub

Private Sub mnuPlayFile_Click()
'On Local Error Resume Next
OpenMediaFile tvwFiles.SelectedItem.Key, True
End Sub

Private Sub mnuPlayThisFile_Click()
'On Local Error Resume Next
OpenMediaFile tvwPlaylist.SelectedItem.Key, True
End Sub

Private Sub mnuProcessAllEntrys_Click()
'On Local Error Resume Next
Dim i As Integer, C As Integer
If lvwPending.ListItems.Count <> 0 And lvwPending.ListItems.Count <> 1 Then
    C = lvwPending.ListItems.Count + 1
    For i = 1 To C
        If i < C Then
            If ProcessEntry(lvwPending.ListItems(i).Key, lvwPending.ListItems(i).SubItems(2), False) = True Then
                ProcessEntry lvwPending.ListItems(i).Key, lvwPending.ListItems(i).SubItems(2), True
                lvwPending.ListItems.Remove lvwPending.ListItems(i).Index
            End If
        End If
    Next i
ElseIf lvwPending.ListItems.Count = 1 Then
    If ProcessEntry(lvwPending.ListItems(1).Key, lvwPending.ListItems(1).SubItems(2), False) Then
        ProcessEntry lvwPending.ListItems(1).Key, lvwPending.ListItems(1).SubItems(2), True
        frmMain.lvwPending.ListItems.Remove 1
    End If
End If
End Sub

Private Sub mnuReloadPlaylist_Click()
'On Local Error Resume Next
LoadPlaylist ReturnIniFilename(iPlaylist), True
End Sub

Private Sub mnuRemove_Click()
'On Local Error Resume Next
Dim mbox As VbMsgBoxResult
If Len(lvwPending.SelectedItem.Text) <> 0 Then
    mbox = MsgBox("Are you sure you wish to remove '" & lvwPending.SelectedItem.Text & "'?", vbYesNo + vbQuestion)
    If mbox = vbYes Then lvwPending.ListItems.Remove lvwPending.SelectedItem.Index
End If
If Err.Number = 91 Then Err.Clear
End Sub

Private Sub mnuRemoveArtist_Click()
'On Local Error Resume Next
tvwPlaylist.Nodes.Remove tvwPlaylist.SelectedItem.Index
End Sub

Private Sub mnuRemoveEntry_Click()
'On Local Error Resume Next
lvwProcesses.ListItems.Remove lvwProcesses.SelectedItem.Index
End Sub

Private Sub mnuRemoveFile_Click()
'On Local Error Resume Next
tvwPlaylist.Nodes.Remove tvwPlaylist.SelectedItem.Index
End Sub

Private Sub mnuRemoveStation_Click()
'On Local Error Resume Next
DeleteTreeViewInternetRadio tvwFunctions, tvwFunctions.SelectedItem.Text
End Sub

Private Sub mnuSelectedEntrys_Click()
'On Local Error Resume Next
Dim i As Integer
For i = 1 To lvwPending.ListItems.Count
    If i < lvwPending.ListItems.Count Then
        If lvwPending.ListItems(i).Selected = True Then
            If ProcessEntry(lvwPending.ListItems(i).Key, lvwPending.ListItems(i).SubItems(2), False) = True Then
                frmMain.lvwPending.ListItems.Remove i
            End If
        End If
    End If
Next i
End Sub

Private Sub mnuStopStation_Click()
'On Local Error Resume Next
'StopInternetRadio frmMain.ctlRadio1
End Sub

Private Sub mnuThisEntry_Click()
'On Local Error Resume Next
If ProcessEntry(lvwPending.SelectedItem.Key, lvwPending.SelectedItem.SubItems(2), False) = True Then
    ProcessEntry lvwPending.SelectedItem.Key, lvwPending.SelectedItem.SubItems(2), True
    lvwPending.ListItems.Remove lvwPending.SelectedItem.Index
End If
If Err.Number <> 0 Then Err.Clear
End Sub

Private Sub picDrag_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub picDrag_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub picDrag_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub picDrag_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub picResizeHorrizontal_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If Button = 1 Then
    picDrag.Height = 80
    picDrag.Width = picResizeHorrizontal.Width
    picDrag.top = picResizeHorrizontal.top
    picDrag.left = picResizeHorrizontal.left
    picDrag.Visible = True
    lResizeVert = False
    picResizeHorrizontal.Visible = False
    tmrDragBlackLine.Enabled = True
    FormDrag picResizeHorrizontal.hwnd
    tmrDragBlackLine.Enabled = False
    picDrag.Visible = False
    picWhite.Visible = False
    picResizeHorrizontal.Visible = True
    picResizeHorrizontal.left = 40
    lvwPending.top = picResizeHorrizontal.top
    lvwPending.Height = Me.Height - lvwPending.top - 1650
    tvwFiles.Height = Me.Height - lvwPending.Height - 2000
    tvwFunctions.Height = Me.Height - lvwPending.Height - 2000
    picResizeVerticle.Height = tvwFiles.Height
    'frmMain.Refresh
Else
    picDrag.Visible = False
End If
End Sub

Private Sub picResizeVerticle_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
If Button = 1 Then
    lResizeVert = True
    picResizeVerticle.Visible = False
    picDrag.Height = tvwFunctions.Height - 40
    picDrag.Width = picResizeVerticle.Width
    picDrag.top = picResizeVerticle.top + 80
    picDrag.Visible = True
    picWhite.Visible = True
    picWhite.Width = picResizeVerticle.Width + 80
    picWhite.Height = picResizeVerticle.Height + 10
    picWhite.left = picResizeVerticle.left - 50
    picWhite.top = picResizeVerticle.top + 50
    tmrDragBlackLine.Enabled = True
    FormDrag picResizeVerticle.hwnd
    tvwFunctions.Width = picResizeVerticle.left
    tvwFiles.left = picResizeVerticle.left + picResizeVerticle.Width
    tvwFiles.Width = Me.ScaleWidth - (tvwFunctions.Width + 100)
    picResizeVerticle.top = cboPath.top + cboPath.Height
    picResizeVerticle.Visible = True
    tmrDragBlackLine.Enabled = False
    picDrag.Visible = False
    picWhite.Visible = False
    picResizeVerticle.Visible = True
Else
    picDrag.Visible = False
End If
End Sub

Private Sub sldProgress_Click()
'On Local Error Resume Next
ctlMovie1.ChangeMoviePosition sldProgress.Value
End Sub

Private Sub sldProgress_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub sldProgress_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub sldProgress_Scroll()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub sldVolume_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
ctlMovie1.SetVolume sldVolume.Value * 10
End Sub

Private Sub sldVolume_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub sldVolume_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub sldVolume_Scroll()
'On Local Error Resume Next
ctlMovie1.SetVolume sldVolume.Value * 10
End Sub

Private Sub tblTop_ButtonClick(ByVal Button As MSComctlLib.Button)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
ResetFrames
fraFunction(Button.Index - 1).Visible = True
DoEvents
Select Case Button.Index
Case 1
    SetChildWindowText "Audiogen 2 (Files and Folders)"
Case 2
    SetChildWindowText "Audiogen 2 (Playlist)"
Case 3
    SetChildWindowText "Audiogen 2 (CD Ripper (NON FUNCTIONAL))"
    If cboDrives.ListCount = 1 And Len(cboDrives.Text) = 0 Then
        cboDrives.ListIndex = 0
    End If
Case 4
    SetChildWindowText "Audiogen 2 (CD Burner (NON FUNCTIONAL))"
Case 5
    SetChildWindowText "Audiogen 2 (Search for Media)"
Case 6
    SetChildWindowText "Audiogen 2 (Playback)"
End Select
End Sub

Private Sub tblTop_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tblTop_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tblTop_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tblTop_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tmrDelayRefreshToolBar_Timer()
'On Local Error Resume Next
frmMain.tblTop.Refresh
tmrDelayRefreshToolBar.Enabled = False
End Sub

Private Sub tmrDragBlackLine_Timer()
'On Local Error Resume Next
If picDrag.Visible = True Then
    If lResizeVert = True Then
        picDrag.left = picResizeVerticle.left
    Else
        picDrag.top = picResizeHorrizontal.top
    End If
End If
End Sub

Private Sub tmrProgress_Timer()
'On Local Error Resume Next
Dim i As Integer
If Len(lblFilename.Tag) <> 0 Then
    frmMain.sldProgress.Value = ctlMovie1.ReturnCurrentPosition
    i = FindListViewIndexByFileTitle(lblFilename.Caption, lvwProcesses)
    If frmMain.sldProgress.Value <> 0 Then
        If i <> 0 Then
            If lvwProcesses.ListItems(i).SubItems(1) <> Int(frmMain.sldProgress.Value) & "%" Then
                If Int(frmMain.sldProgress.Value) = frmMain.sldProgress.Max Then
                    lvwProcesses.ListItems(i).Text = "Finished"
                    lvwProcesses.ListItems(i).SubItems(1) = "100%"
                    StopPlayback lblFilename.Tag
                    tmrProgress.Enabled = False
                Else
                    If lvwProcesses.ListItems(i).Text <> "Play" Then lvwProcesses.ListItems(i).Text = "Play"
                    If lvwProcesses.ListItems(i).SubItems(1) <> Int(frmMain.sldProgress.Value * 100 / frmMain.sldProgress.Max) & "%" Then lvwProcesses.ListItems(i).SubItems(1) = Int(frmMain.sldProgress.Value * 100 / frmMain.sldProgress.Max) & "%"
                End If
            End If
        End If
    End If
Else
    tmrProgress.Enabled = False
End If
End Sub

Private Sub tvwFiles_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
OpenMediaFile tvwFiles.SelectedItem.Key, True
If Err.Number = 91 Then Err.Clear
End Sub

Private Sub tvwFiles_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnChildWindowHwnd
If Button = 2 Then
    PopupMenu mnutvwFile
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tvwFiles_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tvwFunctions_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
'If Left(tvwFunctions.SelectedItem.FullPath, 15) = "Internet Radio\" Then PlayInternetRadio ctlRadio1, ReturnInternetRadioAddress(tvwFunctions.SelectedItem.Text)
End Sub

Private Sub tvwFunctions_KeyPress(KeyAscii As Integer)
'On Local Error Resume Next
If KeyAscii = 27 Then Unload Me
End Sub

Private Sub tvwFunctions_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnChildWindowHwnd
If Button = 2 Then
    Select Case LCase(tvwFunctions.SelectedItem.Parent.Text)
    Case "internet radio"
        PopupMenu mnuRadio
    End Select
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tvwFunctions_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If Button = 1 Then FunctionsTreeView
End Sub

Private Sub tvwPlaylist_AfterLabelEdit(Cancel As Integer, NewString As String)
'On Local Error Resume Next
TreeViewLabelEdit tvwPlaylist, lLabelEdit, NewString
End Sub

Private Sub tvwPlaylist_BeforeLabelEdit(Cancel As Integer)
'On Local Error Resume Next
lLabelEdit = tvwPlaylist.SelectedItem.Text
End Sub

Private Sub tvwPlaylist_Click()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tvwPlaylist_DblClick()
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
OpenMediaFile tvwPlaylist.SelectedItem.Key, True
End Sub

Private Sub tvwPlaylist_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If Button = 2 Then
    If LCase(Right(frmMain.tvwPlaylist.SelectedItem.Key, 4)) = ".mp3" Then
        If DoesFileExist(frmMain.tvwPlaylist.SelectedItem.Key) = True Then
            PopupMenu mnutvwPlaylistMenu
        End If
    Else
        PopupMenu mnutvwPlaylistMenu2
    End If
End If
End Sub

Private Sub tvwPlaylist_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub wskFreeDB_CloseSck()
'On Local Error Resume Next
wskFreeDB.CloseSck
End Sub

Private Sub wskFreeDB_Connect()
'On Local Error Resume Next
wskFreeDB.SendData "cddb hello guidex@team-nexgen.com " & wskFreeDB.LocalHostName & " Audiogen 2." & App.Minor & vbCrLf: DoEvents
End Sub

Private Sub wskFreeDB_DataArrival(ByVal bytesTotal As Long)
'On Local Error Resume Next
Dim msg As String
wskFreeDB.GetData msg, vbString
ProcessFreeDBString msg, wskFreeDB
End Sub
