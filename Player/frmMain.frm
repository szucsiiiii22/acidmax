VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Acidmax Player"
   ClientHeight    =   5640
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6465
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
   ScaleHeight     =   376
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   431
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmrProgress 
      Interval        =   1000
      Left            =   0
      Top             =   4200
   End
   Begin VB.Frame fraFunctions 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   3855
      Index           =   1
      Left            =   0
      TabIndex        =   13
      Top             =   270
      Visible         =   0   'False
      Width           =   6135
      Begin AcidmaxPlayer.isButton cmdLoadPlaylist 
         Height          =   300
         Left            =   0
         TabIndex        =   40
         Top             =   3480
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   529
         Icon            =   "frmMain.frx":0CCA
         Style           =   1
         Caption         =   "Load Playlist"
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
      Begin AcidmaxPlayer.isButton cmdSavePlaylist 
         Height          =   300
         Left            =   1120
         TabIndex        =   41
         Top             =   3480
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   529
         Icon            =   "frmMain.frx":0CE6
         Style           =   1
         Caption         =   "Save Playlist"
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
      Begin AcidmaxPlayer.ctlListView lvwPlaylist 
         Height          =   1815
         Left            =   0
         TabIndex        =   39
         Top             =   10
         Width           =   4935
         _ExtentX        =   8705
         _ExtentY        =   3201
      End
      Begin VB.Label Label10 
         BackStyle       =   0  'Transparent
         Caption         =   "ALPHA: DOES NOT FUNCTION"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         TabIndex        =   38
         Top             =   120
         Visible         =   0   'False
         Width           =   3615
      End
      Begin VB.Line Line7 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   0
         Y2              =   3600
      End
      Begin VB.Line Line4 
         BorderColor     =   &H00FFFFFF&
         X1              =   1920
         X2              =   6120
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line3 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   960
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.Frame fraFunctions 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   3615
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   270
      Width           =   6135
      Begin VB.PictureBox picTop 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   855
         Left            =   0
         ScaleHeight     =   855
         ScaleWidth      =   6015
         TabIndex        =   1
         Top             =   0
         Width           =   6015
         Begin AcidmaxPlayer.ucSlider sldVolume 
            Height          =   240
            Left            =   960
            Top             =   555
            Width           =   1200
            _ExtentX        =   2117
            _ExtentY        =   423
            SliderIcon      =   "frmMain.frx":0D02
            Orientation     =   0
            RailPicture     =   "frmMain.frx":0E14
            Max             =   100
         End
         Begin AcidmaxPlayer.XPButton cmdPlay 
            Height          =   375
            Left            =   1440
            TabIndex        =   2
            Top             =   120
            Width           =   495
            _ExtentX        =   873
            _ExtentY        =   661
            BTYPE           =   5
            TX              =   ""
            ENAB            =   0   'False
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
            MCOL            =   16777215
            MPTR            =   0
            MICON           =   "frmMain.frx":0E30
            PICN            =   "frmMain.frx":0E4C
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
         End
         Begin AcidmaxPlayer.XPButton cmdBackward 
            Height          =   375
            Left            =   120
            TabIndex        =   3
            Top             =   120
            Width           =   615
            _ExtentX        =   1085
            _ExtentY        =   661
            BTYPE           =   5
            TX              =   ""
            ENAB            =   0   'False
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
            MCOL            =   16777215
            MPTR            =   0
            MICON           =   "frmMain.frx":0F8B
            PICN            =   "frmMain.frx":0FA7
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
         End
         Begin AcidmaxPlayer.XPButton cmdPause 
            Height          =   375
            Left            =   2040
            TabIndex        =   4
            Top             =   120
            Width           =   495
            _ExtentX        =   873
            _ExtentY        =   661
            BTYPE           =   5
            TX              =   ""
            ENAB            =   0   'False
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
            MCOL            =   16777215
            MPTR            =   0
            MICON           =   "frmMain.frx":1227
            PICN            =   "frmMain.frx":1243
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
         End
         Begin AcidmaxPlayer.XPButton cmdForward 
            Height          =   375
            Left            =   3240
            TabIndex        =   5
            Top             =   120
            Width           =   615
            _ExtentX        =   1085
            _ExtentY        =   661
            BTYPE           =   5
            TX              =   ""
            ENAB            =   0   'False
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
            MCOL            =   16777215
            MPTR            =   0
            MICON           =   "frmMain.frx":12CF
            PICN            =   "frmMain.frx":12EB
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
         End
         Begin AcidmaxPlayer.XPButton cmdStop 
            Height          =   375
            Left            =   2640
            TabIndex        =   6
            Top             =   120
            Width           =   495
            _ExtentX        =   873
            _ExtentY        =   661
            BTYPE           =   5
            TX              =   ""
            ENAB            =   0   'False
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
            MCOL            =   16777215
            MPTR            =   0
            MICON           =   "frmMain.frx":156F
            PICN            =   "frmMain.frx":158B
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
         End
         Begin AcidmaxPlayer.XPButton cmdEject 
            Height          =   375
            Left            =   840
            TabIndex        =   7
            Top             =   120
            Width           =   495
            _ExtentX        =   873
            _ExtentY        =   661
            BTYPE           =   5
            TX              =   ""
            ENAB            =   -1  'True
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
            MCOL            =   16777215
            MPTR            =   0
            MICON           =   "frmMain.frx":1608
            PICN            =   "frmMain.frx":1624
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
         End
         Begin AcidmaxPlayer.ucSlider sldProgress 
            Height          =   240
            Left            =   3120
            Top             =   540
            Width           =   1200
            _ExtentX        =   2117
            _ExtentY        =   423
            SliderIcon      =   "frmMain.frx":1699
            Orientation     =   0
            RailPicture     =   "frmMain.frx":17AB
            Max             =   100
         End
         Begin VB.Line Line6 
            BorderColor     =   &H00FFFFFF&
            X1              =   0
            X2              =   0
            Y1              =   840
            Y2              =   0
         End
         Begin VB.Line Line2 
            BorderColor     =   &H00FFFFFF&
            X1              =   960
            X2              =   7320
            Y1              =   0
            Y2              =   0
         End
         Begin VB.Line Line1 
            BorderColor     =   &H00808080&
            X1              =   0
            X2              =   6000
            Y1              =   840
            Y2              =   840
         End
         Begin VB.Label Label1 
            BackStyle       =   0  'Transparent
            Caption         =   "Volume:"
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Top             =   550
            Width           =   615
         End
         Begin VB.Label Label2 
            BackStyle       =   0  'Transparent
            Caption         =   "Progress:"
            Height          =   255
            Left            =   2280
            TabIndex        =   8
            Top             =   555
            Width           =   855
         End
      End
      Begin AcidmaxPlayer.ctlAcidmaxPlayer ctlMovie 
         Height          =   2655
         Left            =   10
         TabIndex        =   10
         Top             =   840
         Visible         =   0   'False
         Width           =   6000
         _ExtentX        =   10583
         _ExtentY        =   4683
      End
      Begin VB.Line Line5 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   840
         Y2              =   3600
      End
      Begin VB.Image imgLogo 
         Height          =   1815
         Left            =   1800
         Picture         =   "frmMain.frx":17C7
         Top             =   2160
         Width           =   2100
      End
   End
   Begin VB.Frame fraFunctions 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   3855
      Index           =   2
      Left            =   0
      TabIndex        =   15
      Top             =   270
      Width           =   6255
      Begin VB.Frame fraFServe 
         BorderStyle     =   0  'None
         Caption         =   "Server"
         Height          =   2535
         Index           =   1
         Left            =   0
         TabIndex        =   35
         Top             =   120
         Width           =   4575
         Begin AcidmaxPlayer.isButton cmdConnectToFServe 
            Height          =   300
            Left            =   120
            TabIndex        =   36
            Top             =   480
            Visible         =   0   'False
            Width           =   1695
            _ExtentX        =   2990
            _ExtentY        =   529
            Icon            =   "frmMain.frx":215F
            Style           =   1
            Caption         =   "Connect To FServe"
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
         Begin VB.Label Label9 
            BackStyle       =   0  'Transparent
            Caption         =   "ALPHA! DOES NOT WORK"
            ForeColor       =   &H00FF0000&
            Height          =   255
            Left            =   120
            TabIndex        =   37
            Top             =   0
            Width           =   2535
         End
      End
      Begin VB.ListBox lstUsers 
         Height          =   2400
         ItemData        =   "frmMain.frx":217B
         Left            =   120
         List            =   "frmMain.frx":217D
         TabIndex        =   20
         Top             =   360
         Width           =   1575
      End
      Begin AcidmaxPlayer.isButton cmdDisconnect 
         Height          =   300
         Left            =   120
         TabIndex        =   18
         Top             =   2880
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   529
         Icon            =   "frmMain.frx":217F
         Style           =   1
         Caption         =   "Disconnect User"
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
      Begin AcidmaxPlayer.isButton cmdMessage 
         Height          =   300
         Left            =   120
         TabIndex        =   19
         Top             =   3240
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   529
         Icon            =   "frmMain.frx":219B
         Style           =   1
         Caption         =   "Message User"
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
      Begin VB.Frame fraFServe 
         BackColor       =   &H00404040&
         Caption         =   "FServe Settings"
         Height          =   2655
         Index           =   0
         Left            =   480
         TabIndex        =   21
         Top             =   600
         Width           =   5535
         Begin VB.CheckBox chkAdvertise 
            Caption         =   "Advertise"
            Height          =   255
            Left            =   0
            TabIndex        =   28
            Top             =   0
            Width           =   1455
         End
         Begin VB.TextBox txtAd 
            Height          =   285
            Left            =   960
            TabIndex        =   27
            Top             =   600
            Width           =   3255
         End
         Begin VB.TextBox txtChannel 
            Height          =   285
            Left            =   960
            TabIndex        =   26
            Top             =   960
            Width           =   3255
         End
         Begin VB.TextBox txtPath 
            Height          =   285
            Left            =   960
            TabIndex        =   25
            Top             =   1680
            Width           =   2295
         End
         Begin VB.TextBox txtTrigger 
            Height          =   285
            Left            =   960
            TabIndex        =   23
            Top             =   1320
            Width           =   3255
         End
         Begin VB.CheckBox chkFServeEnabled 
            Caption         =   "Enabled"
            Height          =   255
            Left            =   0
            TabIndex        =   22
            Top             =   240
            Width           =   1335
         End
         Begin AcidmaxPlayer.isButton cmdSelect 
            Height          =   300
            Left            =   3360
            TabIndex        =   24
            Top             =   1680
            Width           =   855
            _ExtentX        =   1508
            _ExtentY        =   529
            Icon            =   "frmMain.frx":21B7
            Style           =   1
            Caption         =   "Select"
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
         Begin AcidmaxPlayer.ucSlider sldInterval 
            Height          =   240
            Left            =   960
            Top             =   2040
            Width           =   3240
            _ExtentX        =   5715
            _ExtentY        =   423
            SliderIcon      =   "frmMain.frx":21D3
            Orientation     =   0
            RailPicture     =   "frmMain.frx":22E5
            Max             =   100
         End
         Begin VB.Label lblInterval 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Disabled"
            Height          =   255
            Left            =   960
            TabIndex        =   34
            Top             =   2280
            Width           =   3255
         End
         Begin VB.Label Label4 
            BackStyle       =   0  'Transparent
            Caption         =   "Ad:"
            Height          =   255
            Left            =   0
            TabIndex        =   33
            Top             =   600
            Width           =   855
         End
         Begin VB.Label Label5 
            BackStyle       =   0  'Transparent
            Caption         =   "Interval:"
            Height          =   255
            Left            =   0
            TabIndex        =   32
            Top             =   2040
            Width           =   855
         End
         Begin VB.Label Label6 
            BackStyle       =   0  'Transparent
            Caption         =   "Channel:"
            Height          =   255
            Left            =   0
            TabIndex        =   31
            Top             =   960
            Width           =   855
         End
         Begin VB.Label Label7 
            BackStyle       =   0  'Transparent
            Caption         =   "Path:"
            Height          =   255
            Left            =   0
            TabIndex        =   30
            Top             =   1680
            Width           =   855
         End
         Begin VB.Label Label8 
            BackStyle       =   0  'Transparent
            Caption         =   "Trigger:"
            Height          =   255
            Left            =   0
            TabIndex        =   29
            Top             =   1320
            Width           =   855
         End
      End
      Begin VB.Label Label3 
         Caption         =   "Users:"
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   120
         Width           =   1575
      End
      Begin VB.Line Line9 
         BorderColor     =   &H00FFFFFF&
         X1              =   2880
         X2              =   6000
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line8 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   1920
         Y1              =   0
         Y2              =   0
      End
   End
   Begin AcidmaxPlayer.isButton cmdTopButtons 
      Height          =   300
      Index           =   2
      Left            =   1950
      TabIndex        =   16
      Top             =   30
      Visible         =   0   'False
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   529
      Icon            =   "frmMain.frx":2301
      Style           =   1
      Caption         =   "FServe"
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
   Begin AcidmaxPlayer.isButton cmdTopButtons 
      Height          =   300
      Index           =   1
      Left            =   975
      TabIndex        =   12
      Top             =   30
      Visible         =   0   'False
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   529
      Icon            =   "frmMain.frx":231D
      Style           =   1
      Caption         =   "Playlist"
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
   Begin AcidmaxPlayer.isButton cmdTopButtons 
      Height          =   300
      Index           =   0
      Left            =   0
      TabIndex        =   11
      Top             =   30
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   529
      Style           =   1
      Caption         =   "Player"
      iNonThemeStyle  =   0
      BackColor       =   -2147483633
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
   Begin VB.Label lblTop 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Nothing"
      Height          =   255
      Left            =   5280
      TabIndex        =   14
      Top             =   60
      Width           =   735
   End
   Begin VB.Image imgExit2 
      Height          =   210
      Left            =   720
      Picture         =   "frmMain.frx":2339
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgExit1 
      Height          =   195
      Left            =   480
      Picture         =   "frmMain.frx":261B
      Top             =   4200
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image imgTop 
      Height          =   285
      Left            =   5160
      Picture         =   "frmMain.frx":28CD
      Top             =   0
      Width           =   975
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private lServerListViewCount As Integer
Private lUserCount As Integer
Private lChangeProgress As Boolean
Private lPlaylistSelected As Integer
Private lInsideWindow As Boolean

Public Sub AddToFServerServerListView(lUser As String)
On Local Error GoTo ErrHandler
lServerListViewCount = lServerListViewCount + 1
'lvwServer.ItemAdd lServerListViewCount, lUser, 0, 0
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetFServeServerListViewSubItems(lUser As String, lIp As String, lActivity As String, lFile As String)
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lServerListViewCount
'    If Trim(LCase('lvwServer.ItemText(i))) = Trim(LCase(lUser)) Then
        'lvwServer.SubItemSet i, 1, lIp, 0
        'lvwServer.SubItemSet i, 2, lActivity, 0
        'lvwServer.SubItemSet i, 3, lFile, 0
'    End If
Next i
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetCenter(lImage As Image)
On Local Error GoTo ErrHandler
lImage.Left = (Me.Width - lImage.Width) / 2
lImage.Top = (Me.Height - lImage.Height) / 2 + 100
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub PromptPlay()
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
'ctlMovie.SetMovieWindowByhWnd ReturnParentHwnd
msg = OpenDialog(Me, "Supported Files (*.m4a;*.avi;*.mpg;*.mpeg;*.mpe;*.mp3;*.mp2;*.mp1;*.wav;*.aif;*.aiff;*.aifc;*.au;*.mv1;*.mov;*.mpa;*.qt;*.snd;*.mpm;*.mpv;*.enc;*.mid;*.rmi;*.vob;*.wma;*.wmv)|*.m4a;*.avi;*.mpg;*.mpeg;*.mpe;*.mp3;*.mp2;*.mp1;*.wav;*.aif;*.aiff;*.aifc;*.au;*.mv1;*.mov;*.mpa;*.qt;*.snd;*.mpm;*.mpv;*.enc;*.mid;*.rmi;*.vob;*.wma;*.wmv|", App.Title, CurDir)
If Len(msg) <> 0 Then
    msg2 = GetFileTitle(msg)
    msg2 = Left(msg, Len(msg) - Len(msg2))
    AddToPlaylist GetFileTitle(msg), msg2, "Opened Media", FileLen(msg)
    ctlMovie.OpenMovie msg
    DoEvents
    ctlMovie.PlayMovie
    Form_Resize
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdConnectToFServe_Click()
On Local Error GoTo ErrHandler
InitConnectToFServeForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdEject_Click()
On Local Error GoTo ErrHandler
PromptPlay
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdFullScreen_Click()
On Local Error GoTo ErrHandler
ctlMovie.FullScreen
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdLoadPlaylist_Click()
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
msg = OpenDialog(Me, "M3U Files (*.m3u)|*.m3u|PLS Files (*.pls)|*.pls|All Files (*.*)|*.*|", App.Title, CurDir)
MsgBox "!" & msg & "!"
msg2 = ReadFile(msg)
MsgBox msg2
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdPause_Click()
On Local Error GoTo ErrHandler
ctlMovie.PauseMovie
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdPlay_Click()
On Local Error GoTo ErrHandler
ctlMovie.PlayMovie
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdStop_Click()
On Local Error GoTo ErrHandler
ctlMovie.StopMovie
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdTopButtons_Click(Index As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To cmdTopButtons.Count - 1
    cmdTopButtons(i).Visible = True
    'cmdTopButtons(i).Top = 360
    cmdTopButtons(i).Top = 30
Next i
imgTop.Left = cmdTopButtons(Index).Left
imgTop.Visible = True
'imgTop.Top = 340
'lblTop.Top = 420
imgTop.Top = 0
lblTop.Top = 70
lblTop.Left = imgTop.Left + 120
lblTop.Caption = cmdTopButtons(Index).Caption
cmdTopButtons(Index).Visible = False
cmdTopButtons(Index).Top = 0
lblTop.Visible = True
For i = 0 To fraFunctions.Count - 1
    fraFunctions(i).Visible = False
Next i
fraFunctions(Index).Visible = True
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub ctlMovie_AGClick()
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub ctlMovie_AGDoubleClick()
On Local Error GoTo ErrHandler
PromptPlay
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub ctlMovie_AGMovieOpened(lFilename As String)
On Local Error GoTo ErrHandler
Dim l As Integer
l = ctlMovie.ReturnTotalSeconds()
sldProgress.Max = l
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub ctlMovie_AGMoviePlay()
On Local Error GoTo ErrHandler
ctlMovie.Visible = True
cmdPause.Enabled = True
cmdPlay.Enabled = True
cmdStop.Enabled = True
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub ctlMovie_AGMovieStopped()
On Local Error GoTo ErrHandler
ctlMovie.Visible = False
cmdPause.Enabled = False
cmdPlay.Enabled = False
cmdStop.Enabled = False
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub InitSockets()
On Local Error GoTo ErrHandler
'sckListen.CloseSck
'sckListen.LocalPort = 9190
'sckListen.Listen
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub InitListViews()
On Local Error GoTo ErrHandler
lvwPlaylist.Initialize
lvwPlaylist.BorderStyle = bsNone
lvwPlaylist.ViewMode = vmDetails
lvwPlaylist.ColumnAdd 0, "File", 150, [caLeft]
lvwPlaylist.ColumnAdd 1, "Path", 100, [caLeft]
lvwPlaylist.ColumnAdd 2, "Type", 100, [caLeft]
lvwPlaylist.ColumnAdd 3, "Size", 300, caLeft
lvwPlaylist.Font.Name = "Tahoma"
lvwPlaylist.FullRowSelect = True
lvwPlaylist.HeaderFlat = True
lvwPlaylist.HeaderHide = False
'lvwServer.Initialize
'lvwServer.BorderStyle = bsThin
'lvwServer.ViewMode = vmDetails
'lvwServer.ColumnAdd 0, "User", 150, [caLeft]
'lvwServer.ColumnAdd 1, "Ip", 100, [caLeft]
'lvwServer.ColumnAdd 2, "Activity", 100, [caLeft]
'lvwServer.ColumnAdd 3, "File", 300, caLeft
'lvwServer.Font.Name = "Tahoma"
'lvwServer.FullRowSelect = True
'lvwServer.HeaderFlat = True
'lvwServer.HeaderHide = False
'LoadFServes
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub InitPosition()
On Local Error GoTo ErrHandler
Me.Width = GetSetting(App.Title, "Settings", "Width", Me.Width)
Me.Height = GetSetting(App.Title, "Settings", "Height", Me.Height)
Me.Left = GetSetting(App.Title, "Settings", "Left", Me.Left)
Me.Top = GetSetting(App.Title, "Settings", "Top", Me.Top)
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub InitVolume()
On Local Error GoTo ErrHandler
sldVolume.Value = 50
ctlMovie.SetVolume 50 * 10
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub ctlMovie_GotFocus()
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_GotFocus()
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_Load()
On Local Error GoTo ErrHandler
'lblAppTitle.Caption = "Acidmax Player"
'SetParent Me.hWnd, ReturnParentHwnd
SetWindowToChild Me.hWnd
cmdTopButtons_Click (0)
InitSockets
InitListViews
'InitPosition
LoadPlaylist
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_Resize()
On Local Error GoTo ErrHandler
Dim i As Integer
'imgTopRight.Left = Me.ScaleWidth - imgTopRight.Width + 50
'imgTopBar.Width = (Me.ScaleWidth - imgTopRight.Width) - imgTopLeft.Width + 200
'imgExit.Left = Me.ScaleWidth - imgExit.Width - 40
Line1.x2 = Me.ScaleWidth
Line2.x2 = Me.ScaleWidth
Line4.x2 = Me.ScaleWidth
Line7.y2 = Me.ScaleHeight
Line5.y2 = Me.ScaleHeight
Line9.x2 = Me.ScaleWidth
SetCenter imgLogo
ctlMovie.Width = Me.ScaleWidth - 10
ctlMovie.Height = Me.ScaleHeight - (picTop.Height)
picTop.Width = Me.ScaleWidth
For i = 0 To fraFunctions.Count - 1
    fraFunctions(i).Width = Me.ScaleWidth
    fraFunctions(i).Height = Me.ScaleHeight - fraFunctions(i).Top
Next i
For i = 0 To fraFServe.Count - 1
    fraFServe(i).Width = fraFunctions(2).Width
    fraFServe(i).Height = fraFunctions(2).Height
Next i
lvwPlaylist.Visible = False
lvwPlaylist.Width = fraFunctions(2).Width
lvwPlaylist.Height = fraFunctions(2).Height - (20 + cmdLoadPlaylist.Height)
lvwPlaylist.Refresh
lvwPlaylist.Visible = True
cmdLoadPlaylist.Top = lvwPlaylist.Height + 40
cmdSavePlaylist.Top = lvwPlaylist.Height + 40
txtAd.Width = Me.ScaleWidth - 2800
txtChannel.Width = Me.ScaleWidth - 2800
txtPath.Width = (Me.ScaleWidth - 2800) - (cmdSelect.Width)
sldInterval.Width = Me.ScaleWidth - 2800
cmdSelect.Left = txtPath.Width + 50
If ctlMovie.GetStatus = 1 Then ctlMovie.SetSize 0, 0, CLng(Me.ScaleWidth) / CLng(Screen.TwipsPerPixelX), CLng(Me.ScaleHeight) / CLng(Screen.TwipsPerPixelY) - (CLng(picTop.Height) / CLng(Screen.TwipsPerPixelY))
Exit Sub
ErrHandler:
    'MsgBox "RESIZE ERR: " & Err.Description
    Err.Clear
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer, msg As String, c As Integer
ctlMovie.StopMovie
ctlMovie.CloseMovie
SetWindowFocus ReturnParentHwnd
SaveSetting App.Title, "Settings", "Width", Me.Width
SaveSetting App.Title, "Settings", "Height", Me.Height
SaveSetting App.Title, "Settings", "Left", Me.Left
SaveSetting App.Title, "Settings", "Top", Me.Top
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub OpenMovie(lFile As String)
On Local Error GoTo ErrHandler
With ctlMovie
    .StopMovie
    .OpenMovie lFile
    DoEvents
    .PlayMovie
    Form_Resize
End With
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub fraFunctions_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

'Private Sub imgExit_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
'On Local Error GoTo ErrHandler
'If Button = 1 Then
'    imgExit.Picture = imgExit2.Picture
'End If
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
'End Sub

'Private Sub imgExit_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
'On Local Error GoTo ErrHandler
'If Button = 1 Then
'    imgExit.Picture = imgExit1.Picture
'End If
'mIRCStatusSend "//.COMCLOSE lAP"
'Unload Me
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
'End Sub

Private Sub imgLogo_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub imgTop_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub imgTopBar_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
Me.SetFocus
DoEvents
FormDrag Me
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub imgTopLeft_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Label2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblAppTitle_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
imgTopBar_MouseDown Button, Shift, x, y
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblAppTitle_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
'imgTopBar_MouseUp Button, Shift, X, Y
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lblTop_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwPlaylist_DblClick()
On Local Error GoTo ErrHandler
Dim msg As String
msg = lvwPlaylist.SubItemText(lPlaylistSelected, 1) & lvwPlaylist.ItemText(lPlaylistSelected)

OpenMovie msg
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwPlaylist_GotFocus()
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwPlaylist_ItemClick(Item As Integer)
On Local Error GoTo ErrHandler
lPlaylistSelected = Item
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub picTop_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub sldInterval_Change()
On Local Error GoTo ErrHandler
Select Case sldInterval.Value
Case 0
    lblInterval.Caption = "Disabled"
Case Else
    lblInterval.Caption = Str(Trim(sldInterval.Value)) & " Minutes"
End Select
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub sldProgress_Change()
On Local Error GoTo ErrHandler
If lChangeProgress = True Then ctlMovie.ChangeMoviePosition sldProgress.Value

Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub sldProgress_MouseDown(Shift As Integer)
On Local Error GoTo ErrHandler
lChangeProgress = True
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub sldProgress_MouseUp(Shift As Integer)
On Local Error GoTo ErrHandler
lChangeProgress = False
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub sldVolume_Change()
On Local Error GoTo ErrHandler
ctlMovie.SetVolume CLng(sldVolume.Value) * 10
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrProgress_Timer()
On Local Error GoTo ErrHandler
If lChangeProgress = False Then sldProgress.Value = ctlMovie.ReturnCurrentPosition
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

'Private Sub 'sckClient_Connect()
'sckClient.SendData "100:guideX"
'End Sub

'Private Sub 'sckListen_CloseSck()
'sckListen.CloseSck
'End Sub

'Private Sub 'sckListen_ConnectionRequest(ByVal requestID As Long)
'lUserCount = lUserCount + 1
'Load sckUsers(lUserCount)
'With sckUsers(lUserCount)
'    sckUsers(lUserCount).Accept requestID
    'sckListen.CloseSck
    'sckListen.LocalPort = 9190
    'sckListen.Listen
'End With
'End Sub

'Private Sub sckUsers_Connect(Index As Integer)
'MsgBox Index & " Server Connected"
'End Sub
Private Sub XPButton1_Click()

End Sub
