VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   ClientHeight    =   6840
   ClientLeft      =   15
   ClientTop       =   15
   ClientWidth     =   11055
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMain.frx":0CCA
   ScaleHeight     =   456
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   737
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmrDoEvents 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   5040
      Top             =   0
   End
   Begin VB.Timer tmrCheckDirectory 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   3600
      Top             =   0
   End
   Begin VB.Timer tmrLoginToFTPDelay 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   4080
      Top             =   0
   End
   Begin VB.Timer tmrTimeOut 
      Enabled         =   0   'False
      Interval        =   20000
      Left            =   4560
      Top             =   0
   End
   Begin DU.ctlFTP ctlFTP1 
      Left            =   120
      Top             =   120
      _extentx        =   450
      _extenty        =   450
   End
   Begin VB.Frame fraFrames 
      BorderStyle     =   0  'None
      Caption         =   "User Mods"
      ForeColor       =   &H00FFFFFF&
      Height          =   3000
      Index           =   2
      Left            =   4440
      TabIndex        =   0
      Top             =   7800
      Visible         =   0   'False
      Width           =   6135
      Begin VB.Line Line19 
         BorderColor     =   &H00808080&
         X1              =   6000
         X2              =   6000
         Y1              =   0
         Y2              =   2880
      End
      Begin VB.Line Line18 
         BorderColor     =   &H00808080&
         X1              =   0
         X2              =   6000
         Y1              =   2880
         Y2              =   2880
      End
      Begin VB.Line Line17 
         BorderColor     =   &H00FFFFFF&
         X1              =   5
         X2              =   5
         Y1              =   2880
         Y2              =   0
      End
      Begin VB.Line Line16 
         BorderColor     =   &H00FFFFFF&
         X1              =   3600
         X2              =   6000
         Y1              =   5
         Y2              =   5
      End
      Begin VB.Line Line15 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   2400
         Y1              =   5
         Y2              =   5
      End
   End
   Begin VB.Frame fraFrames 
      BorderStyle     =   0  'None
      Caption         =   "User Mods"
      ForeColor       =   &H00FFFFFF&
      Height          =   3120
      Index           =   1
      Left            =   5160
      TabIndex        =   6
      Top             =   7800
      Visible         =   0   'False
      Width           =   6375
      Begin VB.Line Line1 
         BorderColor     =   &H00FFFFFF&
         X1              =   2400
         X2              =   6000
         Y1              =   5
         Y2              =   5
      End
      Begin VB.Line Line2 
         BorderColor     =   &H00FFFFFF&
         X1              =   1170
         X2              =   0
         Y1              =   5
         Y2              =   5
      End
      Begin VB.Line Line12 
         BorderColor     =   &H00FFFFFF&
         X1              =   5
         X2              =   5
         Y1              =   0
         Y2              =   2880
      End
      Begin VB.Line Line13 
         BorderColor     =   &H00808080&
         X1              =   0
         X2              =   6000
         Y1              =   2880
         Y2              =   2880
      End
      Begin VB.Line Line14 
         BorderColor     =   &H00808080&
         X1              =   6000
         X2              =   6000
         Y1              =   2880
         Y2              =   0
      End
   End
   Begin VB.CheckBox chkSettings 
      Caption         =   "Reload Window"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   5
      Left            =   360
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   8160
      Visible         =   0   'False
      Width           =   1545
   End
   Begin VB.CheckBox chkSettings 
      Caption         =   "Show Dialog"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   2
      Left            =   360
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   8640
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.CheckBox chkSettings 
      Caption         =   "Use Theme Color"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   6
      Left            =   360
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   8400
      Visible         =   0   'False
      Width           =   1545
   End
   Begin VB.FileListBox File1 
      Height          =   1065
      Left            =   2280
      TabIndex        =   1
      Top             =   8280
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.PictureBox picFrames 
      BorderStyle     =   0  'None
      Height          =   6135
      Left            =   3105
      ScaleHeight     =   6135
      ScaleWidth      =   8055
      TabIndex        =   12
      Top             =   1125
      Width           =   8055
      Begin VB.Frame fraFrames 
         BorderStyle     =   0  'None
         Height          =   5400
         Index           =   0
         Left            =   0
         TabIndex        =   13
         Top             =   290
         Visible         =   0   'False
         Width           =   7830
         Begin VB.ListBox lstFiles 
            Height          =   3960
            Left            =   120
            TabIndex        =   51
            Top             =   120
            Width           =   2295
         End
         Begin DU.isButton cmdCheckForUpdates 
            Height          =   345
            Left            =   120
            TabIndex        =   34
            Top             =   4200
            Width           =   2295
            _ExtentX        =   4048
            _ExtentY        =   609
            Icon            =   "frmMain.frx":56A6
            Style           =   8
            Caption         =   "Check for Updates"
            iNonThemeStyle  =   0
            Enabled         =   0   'False
            Tooltiptitle    =   ""
            ToolTipIcon     =   0
            ToolTipType     =   1
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
         Begin VB.ListBox lstStatus 
            BackColor       =   &H00FFFFFF&
            ForeColor       =   &H00000000&
            Height          =   5175
            IntegralHeight  =   0   'False
            Left            =   5040
            TabIndex        =   15
            Top             =   120
            Width           =   2655
         End
         Begin DU.XP_ProgressBar prgProgress 
            Height          =   375
            Left            =   2520
            TabIndex        =   14
            Top             =   4920
            Visible         =   0   'False
            Width           =   2415
            _ExtentX        =   4260
            _ExtentY        =   661
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
            Color           =   4210752
            Scrolling       =   9
         End
         Begin DU.isButton cmdUpdateAcidmax3 
            Height          =   345
            Left            =   120
            TabIndex        =   35
            Top             =   4920
            Width           =   2295
            _ExtentX        =   4048
            _ExtentY        =   609
            Icon            =   "frmMain.frx":56C2
            Style           =   8
            Caption         =   "Update Acidmax"
            iNonThemeStyle  =   0
            Enabled         =   0   'False
            Tooltiptitle    =   ""
            ToolTipIcon     =   0
            ToolTipType     =   1
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
         Begin DU.isButton cmdCustomize 
            Height          =   345
            Left            =   120
            TabIndex        =   50
            Top             =   4560
            Width           =   2295
            _ExtentX        =   4048
            _ExtentY        =   609
            Icon            =   "frmMain.frx":56DE
            Style           =   8
            Caption         =   "Choose Files"
            iNonThemeStyle  =   0
            Enabled         =   0   'False
            Tooltiptitle    =   ""
            ToolTipIcon     =   0
            ToolTipType     =   1
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
         Begin VB.Label lblReloadDownloadedScripts 
            BackStyle       =   0  'Transparent
            Caption         =   "Reload Downloaded Scripts"
            Height          =   255
            Left            =   2805
            MouseIcon       =   "frmMain.frx":56FA
            MousePointer    =   99  'Custom
            TabIndex        =   44
            Top             =   585
            Width           =   2175
         End
         Begin VB.Image imgReloadDownloadedScripts 
            Height          =   195
            Left            =   2520
            Picture         =   "frmMain.frx":584C
            Top             =   600
            Width           =   195
         End
         Begin VB.Label lblUpdateAutomatically 
            BackStyle       =   0  'Transparent
            Caption         =   "Update Automatically"
            Height          =   255
            Left            =   2805
            MouseIcon       =   "frmMain.frx":5A96
            MousePointer    =   99  'Custom
            TabIndex        =   43
            Top             =   345
            Width           =   1695
         End
         Begin VB.Image imgUpdateAutomatically 
            Height          =   195
            Left            =   2520
            Picture         =   "frmMain.frx":5BE8
            Top             =   360
            Width           =   195
         End
         Begin VB.Label lblCheckUpdatesAutomatically 
            BackStyle       =   0  'Transparent
            Caption         =   "Check for Updates on Start"
            Height          =   255
            Left            =   2805
            MouseIcon       =   "frmMain.frx":5E32
            MousePointer    =   99  'Custom
            TabIndex        =   42
            Top             =   105
            Width           =   2175
         End
         Begin VB.Image imgCheckUpdatesAutomatically 
            Height          =   195
            Left            =   2520
            Picture         =   "frmMain.frx":5F84
            Top             =   120
            Width           =   195
         End
         Begin VB.Image imgCheckBox_Checked 
            Height          =   195
            Left            =   2760
            Picture         =   "frmMain.frx":61CE
            Top             =   4680
            Visible         =   0   'False
            Width           =   195
         End
         Begin VB.Image imgCheckBox_UnChecked 
            Height          =   195
            Left            =   2520
            Picture         =   "frmMain.frx":6418
            Top             =   4680
            Visible         =   0   'False
            Width           =   195
         End
         Begin VB.Label lblYourVer 
            BackColor       =   &H00000000&
            BackStyle       =   0  'Transparent
            Caption         =   "This Version:"
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   2520
            TabIndex        =   19
            Top             =   1080
            Width           =   1095
         End
         Begin VB.Label lblA 
            BackColor       =   &H00000000&
            BackStyle       =   0  'Transparent
            Caption         =   "New Version:"
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   2520
            TabIndex        =   18
            Top             =   1320
            Width           =   1095
         End
         Begin VB.Label lblYourVersion 
            BackStyle       =   0  'Transparent
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   3480
            TabIndex        =   17
            Top             =   1080
            Width           =   1935
         End
         Begin VB.Label lblAvailableVersion 
            BackStyle       =   0  'Transparent
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   3480
            TabIndex        =   16
            Top             =   1320
            Width           =   1935
         End
         Begin VB.Line Line3 
            BorderColor     =   &H00FFFFFF&
            X1              =   1200
            X2              =   7900
            Y1              =   5
            Y2              =   5
         End
         Begin VB.Line Line6 
            BorderColor     =   &H00FFFFFF&
            X1              =   0
            X2              =   0
            Y1              =   0
            Y2              =   5400
         End
         Begin VB.Line Line7 
            BorderColor     =   &H00808080&
            X1              =   7800
            X2              =   7800
            Y1              =   0
            Y2              =   5400
         End
         Begin VB.Line Line8 
            BorderColor     =   &H00808080&
            X1              =   7800
            X2              =   -480
            Y1              =   5380
            Y2              =   5380
         End
      End
      Begin VB.Frame fraFrames 
         BorderStyle     =   0  'None
         Caption         =   "User Mods"
         ForeColor       =   &H8000000F&
         Height          =   5400
         Index           =   3
         Left            =   0
         TabIndex        =   22
         Top             =   290
         Visible         =   0   'False
         Width           =   7815
         Begin VB.TextBox txtPassword 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
            Height          =   285
            IMEMode         =   3  'DISABLE
            Left            =   1200
            PasswordChar    =   "*"
            TabIndex        =   24
            Top             =   480
            Width           =   6375
         End
         Begin VB.TextBox txtUsername 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
            Height          =   285
            Left            =   1200
            TabIndex        =   23
            Top             =   120
            Width           =   6375
         End
         Begin DU.isButton cmdLogin 
            Height          =   300
            Left            =   6600
            TabIndex        =   36
            Top             =   840
            Width           =   975
            _ExtentX        =   1720
            _ExtentY        =   529
            Icon            =   "frmMain.frx":6662
            Style           =   8
            Caption         =   "Login"
            iNonThemeStyle  =   0
            Tooltiptitle    =   ""
            ToolTipIcon     =   0
            ToolTipType     =   1
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
         Begin DU.isButton cmdChange 
            Height          =   300
            Left            =   5520
            TabIndex        =   48
            Top             =   840
            Width           =   975
            _ExtentX        =   1720
            _ExtentY        =   529
            Icon            =   "frmMain.frx":667E
            Style           =   8
            Caption         =   "Change"
            iNonThemeStyle  =   0
            Tooltiptitle    =   ""
            ToolTipIcon     =   0
            ToolTipType     =   1
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
         Begin VB.Frame fraAdmin 
            BorderStyle     =   0  'None
            ForeColor       =   &H00000000&
            Height          =   4095
            Left            =   120
            TabIndex        =   25
            Top             =   1200
            Visible         =   0   'False
            Width           =   7575
            Begin VB.TextBox txtCurrentVersion 
               Height          =   285
               Left            =   1080
               TabIndex        =   28
               Top             =   0
               Width           =   5295
            End
            Begin VB.ListBox lstDirectories 
               Height          =   3300
               IntegralHeight  =   0   'False
               Left            =   1080
               TabIndex        =   27
               Top             =   360
               Width           =   2055
            End
            Begin VB.ListBox lstFTPFiles 
               Height          =   3300
               IntegralHeight  =   0   'False
               Left            =   3240
               TabIndex        =   26
               Top             =   360
               Width           =   4215
            End
            Begin DU.isButton cmdUpdate 
               Height          =   300
               Left            =   6480
               TabIndex        =   37
               Top             =   0
               Width           =   975
               _ExtentX        =   1720
               _ExtentY        =   529
               Icon            =   "frmMain.frx":669A
               Style           =   8
               Caption         =   "Update"
               iNonThemeStyle  =   0
               Tooltiptitle    =   ""
               ToolTipIcon     =   0
               ToolTipType     =   1
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
            Begin DU.isButton cmdMakeFolder 
               Height          =   300
               Left            =   1080
               TabIndex        =   38
               Top             =   3720
               Width           =   975
               _ExtentX        =   1720
               _ExtentY        =   529
               Icon            =   "frmMain.frx":66B6
               Style           =   8
               Caption         =   "MK Dir"
               iNonThemeStyle  =   0
               Tooltiptitle    =   ""
               ToolTipIcon     =   0
               ToolTipType     =   1
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
            Begin DU.isButton cmdAdd 
               Height          =   300
               Left            =   3240
               TabIndex        =   39
               Top             =   3720
               Width           =   855
               _ExtentX        =   1508
               _ExtentY        =   529
               Icon            =   "frmMain.frx":66D2
               Style           =   8
               Caption         =   "Upload"
               iNonThemeStyle  =   0
               Tooltiptitle    =   ""
               ToolTipIcon     =   0
               ToolTipType     =   1
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
            Begin DU.isButton cmdDelete 
               Height          =   300
               Left            =   4200
               TabIndex        =   40
               Top             =   3720
               Width           =   855
               _ExtentX        =   1508
               _ExtentY        =   529
               Icon            =   "frmMain.frx":66EE
               Style           =   8
               Caption         =   "Delete"
               iNonThemeStyle  =   0
               Tooltiptitle    =   ""
               ToolTipIcon     =   0
               ToolTipType     =   1
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
            Begin DU.isButton cmdRMDir 
               Height          =   300
               Left            =   2160
               TabIndex        =   41
               Top             =   3720
               Width           =   975
               _ExtentX        =   1720
               _ExtentY        =   529
               Icon            =   "frmMain.frx":670A
               Style           =   8
               Caption         =   "RM Dir"
               iNonThemeStyle  =   0
               Tooltiptitle    =   ""
               ToolTipIcon     =   0
               ToolTipType     =   1
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
            Begin DU.isButton cmdPasswordProtectDir 
               Height          =   300
               Left            =   5160
               TabIndex        =   49
               Top             =   3720
               Width           =   2295
               _ExtentX        =   4048
               _ExtentY        =   529
               Icon            =   "frmMain.frx":6726
               Style           =   8
               Caption         =   "Password Protect Directory"
               iNonThemeStyle  =   0
               Tooltiptitle    =   ""
               ToolTipIcon     =   0
               ToolTipType     =   1
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
            Begin VB.Line Line21 
               BorderColor     =   &H00FFFFFF&
               X1              =   0
               X2              =   840
               Y1              =   1575
               Y2              =   1575
            End
            Begin VB.Label lblWriteAcidmaxMrc 
               Caption         =   "Write version information to acidmax1.mrc"
               ForeColor       =   &H00FF0000&
               Height          =   780
               Left            =   0
               MouseIcon       =   "frmMain.frx":6742
               MousePointer    =   99  'Custom
               TabIndex        =   46
               Top             =   1680
               Width           =   975
            End
            Begin VB.Line Line20 
               X1              =   0
               X2              =   840
               Y1              =   1560
               Y2              =   1560
            End
            Begin VB.Label lblWriteVersionINI 
               Caption         =   "Write file list to 'version.ini'"
               ForeColor       =   &H00FF0000&
               Height          =   585
               Left            =   0
               MouseIcon       =   "frmMain.frx":6894
               MousePointer    =   99  'Custom
               TabIndex        =   45
               Top             =   840
               Width           =   975
            End
            Begin VB.Label Label10 
               BackStyle       =   0  'Transparent
               Caption         =   "&Version:"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   0
               TabIndex        =   31
               Top             =   0
               Width           =   735
            End
            Begin VB.Label lblFTPFileSize 
               Alignment       =   1  'Right Justify
               Height          =   255
               Left            =   4560
               TabIndex        =   30
               Top             =   1440
               Width           =   1215
            End
            Begin VB.Label Label11 
               BackStyle       =   0  'Transparent
               Caption         =   "&Files:"
               ForeColor       =   &H00000000&
               Height          =   255
               Left            =   0
               TabIndex        =   29
               Top             =   360
               Width           =   735
            End
         End
         Begin VB.Image imgSavePassword 
            Height          =   195
            Left            =   1200
            Picture         =   "frmMain.frx":69E6
            Top             =   840
            Width           =   195
         End
         Begin VB.Label lblSavePassword 
            BackStyle       =   0  'Transparent
            Caption         =   "&Save Password"
            Height          =   255
            Left            =   1485
            MouseIcon       =   "frmMain.frx":6C30
            MousePointer    =   99  'Custom
            TabIndex        =   47
            Top             =   840
            Width           =   1215
         End
         Begin VB.Label Label9 
            BackStyle       =   0  'Transparent
            Caption         =   "&Password:"
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   120
            TabIndex        =   33
            Top             =   480
            Width           =   855
         End
         Begin VB.Label lblUsername 
            BackStyle       =   0  'Transparent
            Caption         =   "&Username:"
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   120
            TabIndex        =   32
            Top             =   120
            Width           =   855
         End
         Begin VB.Line Line4 
            BorderColor     =   &H00FFFFFF&
            X1              =   0
            X2              =   1210
            Y1              =   5
            Y2              =   5
         End
         Begin VB.Line Line5 
            BorderColor     =   &H00FFFFFF&
            X1              =   2400
            X2              =   7905
            Y1              =   0
            Y2              =   0
         End
         Begin VB.Line Line9 
            BorderColor     =   &H00FFFFFF&
            X1              =   0
            X2              =   0
            Y1              =   0
            Y2              =   5400
         End
         Begin VB.Line Line10 
            BorderColor     =   &H00808080&
            X1              =   0
            X2              =   7800
            Y1              =   5385
            Y2              =   5385
         End
         Begin VB.Line Line11 
            BorderColor     =   &H00808080&
            X1              =   7800
            X2              =   7800
            Y1              =   5400
            Y2              =   0
         End
      End
      Begin DU.isButton cmdTopButtons 
         Height          =   300
         Index           =   1
         Left            =   1240
         TabIndex        =   21
         Top             =   0
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   529
         Icon            =   "frmMain.frx":6D82
         Style           =   1
         Caption         =   "&Admin"
         iNonThemeStyle  =   0
         BackColor       =   14737632
         Tooltiptitle    =   ""
         ToolTipIcon     =   0
         ToolTipType     =   1
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
      Begin DU.isButton cmdTopButtons 
         Height          =   300
         Index           =   0
         Left            =   10
         TabIndex        =   20
         Top             =   0
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   529
         Style           =   1
         Caption         =   "Update"
         iNonThemeStyle  =   0
         BackColor       =   14737632
         Tooltiptitle    =   ""
         ToolTipIcon     =   0
         ToolTipType     =   1
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
      Begin VB.Line Line22 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   0
         Y2              =   280
      End
      Begin VB.Image Image2 
         Height          =   225
         Left            =   6960
         Picture         =   "frmMain.frx":6D9E
         Top             =   0
         Width           =   585
      End
   End
   Begin VB.Label lblOtherPlaces 
      BackStyle       =   0  'Transparent
      Caption         =   "Check for Updates to Direct Update"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Index           =   0
      Left            =   840
      MouseIcon       =   "frmMain.frx":6F1B
      MousePointer    =   99  'Custom
      TabIndex        =   11
      Top             =   5040
      Width           =   1815
   End
   Begin VB.Label lblOtherPlaces 
      BackStyle       =   0  'Transparent
      Caption         =   "Team Nexgen Webpage"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Index           =   1
      Left            =   840
      MouseIcon       =   "frmMain.frx":706D
      MousePointer    =   99  'Custom
      TabIndex        =   10
      Top             =   5760
      Width           =   1815
   End
   Begin VB.Label lblHelpTopic 
      BackStyle       =   0  'Transparent
      Caption         =   "Changes to Direct Update"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Index           =   2
      Left            =   840
      MouseIcon       =   "frmMain.frx":71BF
      MousePointer    =   99  'Custom
      TabIndex        =   9
      Top             =   3240
      Width           =   1815
   End
   Begin VB.Label lblHelpTopic 
      BackStyle       =   0  'Transparent
      Caption         =   "Live Help and support options"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Index           =   1
      Left            =   840
      MouseIcon       =   "frmMain.frx":7311
      MousePointer    =   99  'Custom
      TabIndex        =   8
      Top             =   2610
      Width           =   1815
   End
   Begin VB.Label lblHelpTopic 
      BackStyle       =   0  'Transparent
      Caption         =   "Automatic update notification"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Index           =   0
      Left            =   840
      MouseIcon       =   "frmMain.frx":7463
      MousePointer    =   99  'Custom
      TabIndex        =   7
      Top             =   1950
      Width           =   1815
   End
   Begin VB.Label lblStatus 
      BackStyle       =   0  'Transparent
      Caption         =   "Acidmax 3 Direct Update"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3360
      TabIndex        =   5
      Top             =   6360
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Menu mnuFileMenu 
      Caption         =   "File Menu"
      Visible         =   0   'False
      Begin VB.Menu mnuRemove 
         Caption         =   "Remove"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private lClickedFile As String
Private lDownloadOutputFile As String
Private lFileSize As Long
Private lGettingFileSize As Boolean

Public Sub SetClickedFile(lFilename As String)
On Local Error GoTo ErrHandler
lClickedFile = lFilename
Exit Sub
ErrHandler:
    ProcessError "Public Sub SetClickedFile(lFilename As String)", Err.Description
    Err.Clear
End Sub

Private Sub cmdAdd_Click()
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String, msg3 As String
If Len(lstDirectories.Text) <> 0 Then
    msg = OpenDialog(ReturnMainForm, "mIRC Scripts (*.mrc)|*.mrc|All Files (*.*)|*.*|", App.Title, CurDir)
    SetMainFormStatusLabel "Please wait, uploading ..."
    msg2 = GetFileTitle(msg)
    msg3 = ReturnMainFormDirectoryListBoxText
    If Len(msg3) <> 1 Then msg3 = msg3 & "/"
    ctlFTP1.UploadFile Left(msg, Len(msg) - Len(msg2)), msg2, msg3
    SetMainFormStatusLabel "Upload Complete"
    AddFile msg2, FileDateTime(msg), FileLen(msg), msg3
    lstFTPFiles.AddItem msg2
Else
    Beep
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub ProcessError(lSub As String, lError As String)", Err.Description
    Err.Clear
End Sub

Private Sub cmdChange_Click()
On Local Error GoTo ErrHandler
cmdChange.Enabled = False
txtPassword.Enabled = True
txtUsername.Enabled = True
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdChange_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdCheckForUpdates_Click()
On Local Error GoTo ErrHandler
ctlFTP1.LoginToFTP
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdCheckForUpdates_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdCustomize_Click()
On Local Error GoTo ErrHandler
If cmdCustomize.Enabled = True Then
    DisplayChooseFiles
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdCustomize_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdDelete_Click()
On Local Error GoTo ErrHandler
Dim b As Boolean
If Len(lstDirectories.Text) = 1 Then
    b = ctlFTP1.DeleteFile(lstFTPFiles.Text, lstDirectories.Text)
Else
    b = ctlFTP1.DeleteFile(lstFTPFiles.Text, lstDirectories.Text & "/")
End If
ClearFileIndex FindFileIndex(lstFTPFiles.Text)
lstFTPFiles.RemoveItem lstFTPFiles.ListIndex
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdDelete_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdLogin_Click()
On Local Error GoTo ErrHandler
lstDirectories.Clear
LoginToAdmin txtUsername.Text, txtPassword.Text: DoEvents
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdLogin_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdMakeFolder_Click()
On Local Error GoTo ErrHandler
Dim msg As String
msg = InputBox("Enter Directory:", App.Title, "/sys/files/")
If Len(msg) <> 0 Then
    If Right(msg, 1) <> "/" Then msg = msg & "/"
    If ctlFTP1.CreateDirectory(msg) = True Then
        AddDirectory msg, ""
        lstDirectories.AddItem Left(msg, Len(msg) - 1)
    End If
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdMakeFolder_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdPasswordProtectDir_Click()
On Local Error GoTo ErrHandler
Dim c As Integer, i As Integer, msg As String, msg2 As String, b As Boolean
c = CInt(ReadINI(ReturnVersionINI, "Settings", "Dirs", 0))
msg = InputBox("Enter new (unencrypted) password for '" & lstDirectories.Text & "'. DU will then encrypt the password for you.")
msg = EncodeString(msg, ReturnProbaPassword, True)
If Len(msg) = 0 Then Exit Sub
For i = 1 To c
    If ReadINI(ReturnVersionINI, Trim(CStr(i)), "Path", "") = lstDirectories.Text Then
        WriteINI ReturnVersionINI, Trim(CStr(i)), "Password", msg
        Exit For
    End If
Next i
MsgBox "Remember to click 'Update' after making changes to 'version.ini'"
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdMakeFolder_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdRMDir_Click()
On Local Error GoTo ErrHandler
Dim msg As String
msg = lstDirectories.Text
If Len(msg) = 1 Then
    Exit Sub
Else
    If ctlFTP1.RemoveDirectory(msg & "/") = True Then
        lstDirectories.RemoveItem lstDirectories.ListIndex
        ClearDirectory ReturnDirectoryIndex(msg)
    End If
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdRMDir_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdTopButtons_Click(Index As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer
Select Case Index
Case 0
    fraFrames(0).Visible = True
    fraFrames(3).Visible = False
Case 1
    fraFrames(0).Visible = False
    fraFrames(3).Visible = True
End Select
cmdTopButtons(Index).Value = True
fraFrames(Index).Visible = True
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdTopButtons_Click(Index As Integer)", Err.Description
    Err.Clear
End Sub

Private Sub cmdUpdate_Click()
On Local Error GoTo ErrHandler
Select Case ctlFTP1.ReturnConnected
Case True
    WriteINI ReturnVersionINI, "Settings", "Version", Trim(txtCurrentVersion.Text)
    DoEvents
    If DoesFileExist(ReturnVersionINI) = True Then
        SetMainFormStatusLabel "Setting new version ..."
        ctlFTP1.UploadFile App.Path & "\", "version.ini", "/"
        SetMainFormStatusLabel "New version set"
        lblAvailableVersion.Caption = txtCurrentVersion.Text
    End If
Case False
    If ctlFTP1.LoginToFTP = True Then
        WriteINI ReturnVersionINI, "Settings", "Version", Trim(txtCurrentVersion.Text)
        DoEvents
        If DoesFileExist(App.Path & "\version.ini") = True Then
            SetMainFormStatusLabel "Setting new version ..."
            ctlFTP1.UploadFile App.Path & "\", "version.ini", "/"
            SetMainFormStatusLabel "New version set"
            lblAvailableVersion.Caption = txtCurrentVersion.Text
        End If
    End If
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdUpdate_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdUpdateAcidmax3_Click()
On Local Error GoTo ErrHandler
cmdCustomize.Enabled = False
UpdateFiles
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdUpdateAcidmax3_Click()", Err.Description
    Err.Clear
End Sub

Public Sub DisplayChooseFiles()
On Local Error GoTo ErrHandler
Dim f As frmChooseFiles
Set f = New frmChooseFiles
f.Show 1
Exit Sub
ErrHandler:
    ProcessError "Public Sub DisplayChooseFiles()", Err.Description
    Err.Clear
End Sub

Public Sub DisplayHelpTopic(lTitle As String, lDescription As String, lBody As String)
On Local Error GoTo ErrHandler
Dim H As New frmHelpTopics
If Len(lTitle) <> 0 And Len(lDescription) <> 0 And Len(lBody) <> 0 Then
    Set H = New frmHelpTopics
    H.lblTitle.Caption = lTitle
    H.lblHelpTitleSmall = lDescription
    H.lblHelpText = lBody
    H.Show 1
End If
Exit Sub
ErrHandler:
    ProcessError "Public Sub DisplayHelpTopic(lTitle As String, lDescription As String, lBody As String)", Err.Description
    Err.Clear
End Sub

Private Sub DeleteFile(lFile As String)
On Local Error GoTo ErrHandler
If DoesFileExist(lFile) Then
    Kill lFile
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub DeleteFile(lFile As String)", Err.Description
    Err.Clear
End Sub

Private Sub Form_Load()
On Local Error GoTo ErrHandler
Dim i As Integer
lvwFiles.Initialize
lvwFiles.BorderStyle = bsThin
lvwFiles.ViewMode = vmDetails
lvwFiles.ColumnAdd 0, "File", 95, [caLeft]
lvwFiles.ColumnAdd 1, "Size", 55, [caLeft]
lvwFiles.Font.Name = "Tahoma"
lvwFiles.FullRowSelect = True
lvwFiles.HeaderFlat = False
lvwFiles.HeaderHide = False
lvwFiles.Font = "Tahoma"
SetProbaPassword "2djeu839d72gbj3hoeb7c09dkehd031"
txtUsername.Text = ReadINI(ReturnDUINI, "Settings", "AdminUsername", "")
txtPassword.Text = ReadINI(ReturnDUINI, "Settings", "AdminPassword", "")
SetMainFormProgressVisible False
SetWindowToChild Me.hwnd
WriteINI ReturnDUINI, "Settings", "Loaded", "True"
File1.Path = App.Path & "\"
File1.Pattern = ""
File1.Refresh
For i = 0 To File1.ListCount
    If Len(File1.List(i)) <> 0 Then
        If Left(Trim(LCase(File1.List(i))), 2) <> "du" Then
            If Trim(LCase(File1.List(i))) <> "oleguids3.tlb" Then
                DeleteFile App.Path & "\" & File1.List(i)
            End If
        Else
            If Right(Trim(LCase(File1.List(i))), 4) = ".dll" Then
                If Trim(LCase(File1.List(i))) <> "du" & Trim(Str(App.Major & App.Minor)) & ".dll" Then
                    If Trim(LCase(File1.List(i))) <> "oleguids3.tlb" Then
                        DeleteFile App.Path & "\" & File1.List(i)
                    End If
                End If
            End If
        End If
    End If
Next i
fraFrames(0).Visible = True
DoEvents
ApplySettings
SetMainFormCheckForUpdatesEnabled True
SetMainFormUpdateAcidmax3ButtonEnabled False
SetMainFormProgressVisible False
If ReturnAutoCheck = True Then SetMainFormLoginTimerDelayEnabled True
Exit Sub
ErrHandler:
    ProcessError "Private Sub Form_Load()", Err.Description
    Err.Clear
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Dim i As Integer
If lblWriteAcidmaxMrc.Font.Underline = True Then lblWriteAcidmaxMrc.Font.Underline = False
If lblWriteVersionINI.Font.Underline = True Then lblWriteVersionINI.Font.Underline = False
For i = 0 To lblOtherPlaces.Count - 1
    lblOtherPlaces(i).ForeColor = vbWhite
Next i
For i = 0 To lblHelpTopic.Count - 1
    lblHelpTopic(i).ForeColor = vbWhite
Next i
Exit Sub
ErrHandler:
    ProcessError "Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error GoTo ErrHandler
'MsgBox (ReturnDUINI)
WriteINI ReturnDUINI, "Settings", "Loaded", "False"
'ctlFTP1.CloseConnection
'tmrCheckDirectory.Enabled = False
'tmrLoginToFTPDelay.Enabled = False
'tmrSetFocusOnce.Enabled = False
'lblA.Caption = ""
'lblAvailableVersion.Caption = ""
'lblYourVersion.Caption = ""
'tmrCheckDirectory.Enabled = False
Exit Sub
ErrHandler:
    ProcessError "Private Sub Form_Unload(Cancel As Integer)", Err.Description
    Err.Clear
End Sub

Private Sub fraAdmin_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Form_MouseMove 0, 0, 0, 0
Exit Sub
ErrHandler:
    ProcessError "Private Sub fraAdmin_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub fraFrames_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If lblWriteVersionINI.Font.Underline = True Then lblWriteVersionINI.Font.Underline = False
If lblWriteAcidmaxMrc.Font.Underline = True Then lblWriteAcidmaxMrc.Font.Underline = False
lblWriteAcidmaxMrc.Font.Underline = False
lblCheckUpdatesAutomatically.ForeColor = vbBlack
lblUpdateAutomatically.ForeColor = vbBlack
lblReloadDownloadedScripts.ForeColor = vbBlack
lblCheckUpdatesAutomatically.Font.Underline = False
lblUpdateAutomatically.Font.Underline = False
lblReloadDownloadedScripts.Font.Underline = False
Exit Sub
ErrHandler:
    ProcessError "Private Sub fraFrames_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub imgCheckUpdatesAutomatically_Click()
On Local Error GoTo ErrHandler
Select Case ReturnAutoCheck
Case True
    SetAutoCheck False
Case False
    SetAutoCheck True
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub imgCheckUpdatesAutomatically_Click()", Err.Description
    Err.Clear
End Sub

Private Sub imgReloadDownloadedScripts_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Select Case ReturnReloadScripts
Case True
    SetReloadScripts False
Case False
    SetReloadScripts True
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub imgReloadDownloadedScripts_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub imgSavePassword_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblSavePassword.ForeColor = vbBlue
If imgSavePassword.Picture = imgCheckBox_Checked.Picture Then
    imgSavePassword.Picture = imgCheckBox_UnChecked.Picture
ElseIf imgSavePassword.Picture = imgCheckBox_Checked Then
    imgSavePassword.Picture = imgCheckBox_Checked.Picture
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub imgSavePassword_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub imgUpdateAutomatically_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Select Case ReturnAutoUpdate
Case True
    SetAutoUpdate False
Case False
    SetAutoUpdate True
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub imgUpdateAutomatically_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblCheckUpdatesAutomatically_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Select Case ReturnAutoCheck
Case True
    SetAutoCheck False
Case False
    SetAutoCheck True
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblCheckUpdatesAutomatically_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblCheckUpdatesAutomatically_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblCheckUpdatesAutomatically.ForeColor = vbBlue
lblUpdateAutomatically.ForeColor = vbBlack
lblReloadDownloadedScripts.ForeColor = vbBlack
lblCheckUpdatesAutomatically.Font.Underline = True
lblUpdateAutomatically.Font.Underline = False
lblReloadDownloadedScripts.Font.Underline = False
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblCheckUpdatesAutomatically_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblHelpTopic_Click(Index As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer
Select Case Index
Case 0
    Select Case ReturnAutoCheck()
    Case True
        DisplayHelpTopic "Automatic Update Notification", "Automatic Update Prompting is turned ON", "Your Automatic Updates are turned on. If you wish to disable them, uncheck the autocheck checkbox"
    Case False
        DisplayHelpTopic "Automatic Update Notification", "Automatic Update Prompting is turned OFF", "Your Automatic Updates are turned off. If you wish to enable them, check the autocheck checkbox"
    End Select
Case 1
    'If ReturnAcidmaxBetaUpdate = True Then
        'Select Case ReturnAcidmaxBetaUpdate
        'Case True
            'DisplayHelpTopic "Beta and PreRelease Updates", "Acidmax 2 Beta Update2 is turned ON", "Direct Update can download beta and prerelease versions of Nexgen Acidmax. Beware, using this option can damage your copy of Nexgen Acidmax. If you are not sure what to do, it is recommended that you do not use this option. To turn it off, close Direct Update, and type in your status or a channel 'DU'"
        'Case False
            'DisplayHelpTopic "Beta and PreRelease Updates", "Acidmax 2 Beta Update2 is turned OFF", "Direct Update can download beta and prerelease versions of Nexgen Acidmax. Beware, using this option can damage your copy of Nexgen Acidmax. If you are unsure on what to do, it is recommended that you do not use this option. To turn it on, close Direct Update, and type in your status or a channel window 'DUBETA'"
        'End Select
    'Else
    DisplayHelpTopic "Live Help and Support Options", "Support Options", "To get live support, you can reach the development Team of Nexgen Acidmax in #nexgen on undernet. Alternatly, you can post a message on the forum www.team-nexgen.org/forum/"
    'End If
Case 2
    DisplayHelpTopic "Changes to Direct Update", "Changes to Direct Update", "Direct Update has been redesigned to better serve Acidmax's need for updates. For questions regaurding Direct Update, e-mail guidex@tnexgen.com"
End Select
For i = 0 To lblHelpTopic.Count - 1
    lblHelpTopic(i).ForeColor = vbWhite
Next i
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblHelpTopic_Click(Index As Integer)", Err.Description
    Err.Clear
End Sub

Private Sub lblHelpTopic_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblHelpTopic(Index).ForeColor = vbBlue
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblHelpTopic_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblOtherPlaces_Click(Index As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer
Select Case Index
Case 0
    mIRCStatusSend "//frmDuPreUpdate.Load": DoEvents
    Pause 0.2
    mIRCStatusSend "//frmDU.Unload": DoEvents
    Exit Sub
Case 1
    mIRCStatusSend "//www www.team-nexgen.org"
    lblOtherPlaces(1).ForeColor = vbWhite
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblOtherPlaces_Click(Index As Integer)", Err.Description
    Err.Clear
End Sub

Private Sub lblOtherPlaces_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblOtherPlaces(Index).ForeColor = vbBlue
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblOtherPlaces_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblReloadDownloadedScripts_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Select Case ReturnReloadScripts
Case True
    SetReloadScripts False
Case False
    SetReloadScripts True
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblReloadDownloadedScripts_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblReloadDownloadedScripts_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblCheckUpdatesAutomatically.ForeColor = vbBlack
lblUpdateAutomatically.ForeColor = vbBlack
lblReloadDownloadedScripts.ForeColor = vbBlue
lblCheckUpdatesAutomatically.Font.Underline = False
lblUpdateAutomatically.Font.Underline = False
lblReloadDownloadedScripts.Font.Underline = True
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblReloadDownloadedScripts_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblSavePassword_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblSavePassword.ForeColor = vbWhite
If imgSavePassword.Picture = imgCheckBox_Checked.Picture Then
    imgSavePassword.Picture = imgCheckBox_UnChecked.Picture
Else
    imgSavePassword.Picture = imgCheckBox_Checked.Picture
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblSavePassword_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblSavePassword_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If lblSavePassword.Font.Underline = False Then lblSavePassword.Font.Underline = True
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblSavePassword_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblSavePassword_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblSavePassword.ForeColor = vbBlue
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblSavePassword_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblUpdateAutomatically_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Select Case ReturnAutoUpdate
Case True
    SetAutoUpdate False
Case False
    SetAutoUpdate True
End Select
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblUpdateAutomatically_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblUpdateAutomatically_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblCheckUpdatesAutomatically.ForeColor = vbBlack
lblUpdateAutomatically.ForeColor = vbBlue
lblReloadDownloadedScripts.ForeColor = vbBlack
lblCheckUpdatesAutomatically.Font.Underline = False
lblUpdateAutomatically.Font.Underline = True
lblReloadDownloadedScripts.Font.Underline = False
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblUpdateAutomatically_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblWriteAcidmaxMrc_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If lblWriteAcidmaxMrc.ForeColor <> vbWhite Then lblWriteAcidmaxMrc.ForeColor = vbWhite
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblWriteAcidmaxMrc_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblWriteAcidmaxMrc_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If lblWriteVersionINI.Font.Underline = True Then lblWriteVersionINI.Font.Underline = False
If lblWriteAcidmaxMrc.Font.Underline = False Then lblWriteAcidmaxMrc.Font.Underline = True
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblWriteAcidmaxMrc_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblWriteAcidmaxMrc_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If lblWriteAcidmaxMrc.ForeColor <> vbBlue Then lblWriteAcidmaxMrc.ForeColor = vbBlue
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblWriteAcidmaxMrc_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblWriteVersionINI_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
Dim i As Integer
lblWriteVersionINI.ForeColor = vbWhite
For i = 0 To ReturnFileCount
    If Len(ReturnFileName(i)) <> 0 Then
        WriteINI ReturnVersionINI, Trim(CStr("File" & i)), "Url", Trim(ReturnFileName(i))
        WriteINI ReturnVersionINI, Trim(CStr("File" & i)), "Size", Trim(ReturnFileSize(i))
    End If
Next i
WriteINI ReturnVersionINI, "Settings", "Files", Trim(CStr(ReturnFileCount))
MsgBox "Files and sizes written to 'version.ini'"
Exit Sub
ErrHandler:
    ProcessError "Private Sub lblWriteVersionINI_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lblWriteVersionINI_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If lblWriteVersionINI.Font.Underline = False Then lblWriteVersionINI.Font.Underline = True
If lblWriteAcidmaxMrc.Font.Underline = True Then lblWriteAcidmaxMrc.Font.Underline = False
Exit Sub
ErrHandler:
    ProcessError "Private Sub lstDirectories_Click()", Err.Description
    Err.Clear
End Sub

Private Sub lblWriteVersionINI_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblWriteVersionINI.ForeColor = vbBlue
Exit Sub
ErrHandler:
    ProcessError "Private Sub lstDirectories_Click()", Err.Description
    Err.Clear
End Sub

Private Sub lstDirectories_Click()
On Local Error GoTo ErrHandler
Dim i As Integer, l As Integer, msg As String, b As Boolean
lblFTPFileSize.Caption = ""
lstFTPFiles.Clear
For i = 0 To ReturnFileCount
    If Len(ReturnFileName(i)) <> 0 Then
        If LCase(ReturnFileName(i)) <> "version.ini" Then
            msg = Replace(ReturnFilesRemotePath(i), "*.*", "")
            Select Case Len(lstDirectories.Text)
            Case 1
                If msg = "/" And lstDirectories.Text = "/" Then
                    lstFTPFiles.AddItem ReturnFileName(i)
                    
                End If
            Case Else
                If LCase(msg) = LCase(lstDirectories.Text) & "/" Then
                    lstFTPFiles.AddItem ReturnFileName(i)
                    b = True
                End If
            End Select
        End If
    End If
Next i
If b = False Then
    ctlFTP1.EnterFTPDirectory lstDirectories.Text
End If
Exit Sub
ErrHandler:
    ProcessError "Private Sub lstDirectories_Click()", Err.Description
    Err.Clear
End Sub

Private Sub lstDirectories_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
lblWriteAcidmaxMrc.Font.Underline = False
lblWriteVersionINI.Font.Underline = False
Exit Sub
ErrHandler:
    ProcessError "Private Sub lstDirectories_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lstFTPFiles_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error GoTo ErrHandler
If FindFileIndex(lstFTPFiles.Text) <> 0 Then lblFTPFileSize.Caption = "Size: " & ReturnFileSize(FindFileIndex(lstFTPFiles.Text))
Exit Sub
ErrHandler:
    ProcessError "Private Sub lstFTPFiles_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)", Err.Description
    Err.Clear
End Sub

Private Sub lvwFiles_Click()

End Sub

Private Sub tmrCheckDirectory_Timer()
On Local Error GoTo ErrHandler
BrowseNextDirectory
Exit Sub
ErrHandler:
    ProcessError "Private Sub tmrCheckDirectory_Timer()", Err.Description
    Err.Clear
End Sub

Private Sub tmrDoEvents_Timer()
On Local Error GoTo ErrHandler
DoEvents
Exit Sub
ErrHandler:
    ProcessError "Private Sub tmrDoEvents_Timer()", Err.Description
    Err.Clear
End Sub

Private Sub tmrLoginToFTPDelay_Timer()
On Local Error GoTo ErrHandler
tmrLoginToFTPDelay.Enabled = False
ctlFTP1 = New clsDU298
ctlFTP1.LoginToFTP
Exit Sub
ErrHandler:
    ProcessError "Private Sub tmrLoginToFTPDelay_Timer()", Err.Description
    Err.Clear
End Sub

Private Sub tmrTimeOut_Timer()
On Local Error GoTo ErrHandler
ctlFTP1.CloseConnection
SetUpdateBusy False
AddToStatus "Connection Timeout, disconnected."
tmrTimeOut.Enabled = False
SetMainFormCheckForUpdatesEnabled True
Exit Sub
ErrHandler:
    ProcessError "Private Sub tmrTimeOut_Timer()", Err.Description
    Err.Clear
End Sub

Private Sub txtPassword_GotFocus()
On Local Error GoTo ErrHandler
txtPassword.SelStart = 0
txtPassword.SelLength = Len(txtPassword.Text)
Exit Sub
ErrHandler:
    ProcessError "Private Sub txtPassword_GotFocus()", Err.Description
    Err.Clear
End Sub

Private Sub txtUsername_GotFocus()
On Local Error GoTo ErrHandler
txtUsername.SelStart = 0
txtUsername.SelLength = Len(txtUsername.Text)
Exit Sub
ErrHandler:
    ProcessError "Private Sub txtUsername_GotFocus()", Err.Description
    Err.Clear
End Sub
