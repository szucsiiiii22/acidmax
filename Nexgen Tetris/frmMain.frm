VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Nexgen Tetris"
   ClientHeight    =   6000
   ClientLeft      =   2880
   ClientTop       =   2730
   ClientWidth     =   11175
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   12
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C00000&
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMain.frx":0CCA
   ScaleHeight     =   400
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   745
   Begin VB.Timer tmrForShow 
      Interval        =   1000
      Left            =   2280
      Top             =   3120
   End
   Begin VB.CheckBox chkConnectedToUploadManager 
      Appearance      =   0  'Flat
      BackColor       =   &H00404040&
      Caption         =   "Upload Mgr"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   0
      TabIndex        =   43
      TabStop         =   0   'False
      Top             =   4560
      Width           =   1335
   End
   Begin VB.CheckBox chkClient 
      Appearance      =   0  'Flat
      BackColor       =   &H00404040&
      Caption         =   "Client"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   1440
      TabIndex        =   42
      TabStop         =   0   'False
      Top             =   4320
      Width           =   855
   End
   Begin VB.CheckBox chkServer 
      Appearance      =   0  'Flat
      BackColor       =   &H00404040&
      Caption         =   "Server"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   0
      TabIndex        =   41
      TabStop         =   0   'False
      Top             =   4320
      Width           =   975
   End
   Begin VB.Timer tmrDownloadOponentGFX 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   1800
      Top             =   3120
   End
   Begin VB.PictureBox picOponent 
      BorderStyle     =   0  'None
      Height          =   210
      Left            =   0
      ScaleHeight     =   14
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   17
      TabIndex        =   33
      TabStop         =   0   'False
      Top             =   0
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.Timer tmrCleanupGraphics 
      Interval        =   1000
      Left            =   360
      Top             =   3120
   End
   Begin VB.ListBox lstGFXCleanup 
      Enabled         =   0   'False
      Height          =   345
      Left            =   360
      TabIndex        =   32
      Top             =   6120
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Timer tmrUpdateCapture 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   840
      Top             =   3120
   End
   Begin VB.ListBox lstWindows 
      Height          =   345
      IntegralHeight  =   0   'False
      Left            =   360
      TabIndex        =   31
      Top             =   6600
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.PictureBox picDestination 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   5010
      Left            =   8070
      ScaleHeight     =   334
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   201
      TabIndex        =   29
      TabStop         =   0   'False
      Top             =   360
      Width           =   3015
   End
   Begin VB.Timer tmrDrop 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1320
      Top             =   3120
   End
   Begin VB.PictureBox picSnapshot 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   5010
      Left            =   8070
      ScaleHeight     =   334
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   201
      TabIndex        =   46
      TabStop         =   0   'False
      Top             =   300
      Width           =   3015
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1455
      Left            =   3120
      MouseIcon       =   "frmMain.frx":4388
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":44DA
      ScaleHeight     =   1455
      ScaleWidth      =   2085
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   1485
      Width           =   2085
   End
   Begin VB.PictureBox Picture2 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1455
      Left            =   3120
      MouseIcon       =   "frmMain.frx":4923
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":4A75
      ScaleHeight     =   1455
      ScaleWidth      =   2085
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   1485
      Visible         =   0   'False
      Width           =   2085
   End
   Begin VB.PictureBox Picture4 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1455
      Left            =   3120
      MouseIcon       =   "frmMain.frx":4F81
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":50D3
      ScaleHeight     =   1455
      ScaleWidth      =   2085
      TabIndex        =   26
      Top             =   1485
      Visible         =   0   'False
      Width           =   2085
   End
   Begin VB.PictureBox Picture3 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1455
      Left            =   3120
      MouseIcon       =   "frmMain.frx":5407
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":5559
      ScaleHeight     =   1455
      ScaleWidth      =   2085
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   1485
      Visible         =   0   'False
      Width           =   2085
   End
   Begin VB.Label lblNickname 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1440
      TabIndex        =   45
      Top             =   4800
      Width           =   1455
   End
   Begin VB.Label Label17 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Nickname:"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   0
      TabIndex        =   44
      Top             =   4800
      Width           =   1455
   End
   Begin VB.Label lblSnapshotNumber 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1440
      TabIndex        =   40
      Top             =   4080
      Width           =   1455
   End
   Begin VB.Label Label14 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Snapshot Numb:"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   0
      TabIndex        =   39
      Top             =   4080
      Width           =   1455
   End
   Begin VB.Label lblClientOponentNick 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1440
      TabIndex        =   38
      Top             =   3840
      Width           =   1455
   End
   Begin VB.Label Label13 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "ClintOponentNick:"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   0
      TabIndex        =   37
      Top             =   3840
      Width           =   1455
   End
   Begin VB.Label lblOponentsNick 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1440
      TabIndex        =   36
      Top             =   3600
      Width           =   1455
   End
   Begin VB.Label Label11 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "ServOponentNick:"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   0
      TabIndex        =   35
      Top             =   3600
      Width           =   1455
   End
   Begin VB.Label lblOponent 
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   8040
      TabIndex        =   34
      Top             =   0
      Width           =   3015
   End
   Begin VB.Label Label18 
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   240
      MouseIcon       =   "frmMain.frx":583E
      MousePointer    =   99  'Custom
      TabIndex        =   30
      Top             =   2730
      Width           =   1935
   End
   Begin VB.Label Label16 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      MouseIcon       =   "frmMain.frx":5990
      MousePointer    =   99  'Custom
      TabIndex        =   28
      Top             =   2430
      Width           =   1935
   End
   Begin VB.Label Label15 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      MouseIcon       =   "frmMain.frx":5AE2
      MousePointer    =   99  'Custom
      TabIndex        =   27
      Top             =   2115
      Width           =   1935
   End
   Begin VB.Label Label12 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   7080
      TabIndex        =   7
      Top             =   2760
      Width           =   510
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   6
      Left            =   7380
      TabIndex        =   15
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   5
      Left            =   7155
      TabIndex        =   14
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   4
      Left            =   6930
      TabIndex        =   13
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   3
      Left            =   6705
      TabIndex        =   12
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   2
      Left            =   6525
      TabIndex        =   11
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   1
      Left            =   6255
      TabIndex        =   10
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   0
      Left            =   6030
      TabIndex        =   9
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   270
      Left            =   1440
      TabIndex        =   8
      Top             =   990
      Width           =   720
   End
   Begin VB.Label Label6 
      Caption         =   "Label6"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1905
      Left            =   7785
      TabIndex        =   24
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.Label Label4 
      Caption         =   "Label4"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   105
      Left            =   5940
      TabIndex        =   25
      Top             =   5310
      Visible         =   0   'False
      Width           =   1860
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   7080
      TabIndex        =   5
      Top             =   2505
      Width           =   510
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   7080
      TabIndex        =   4
      Top             =   2235
      Width           =   510
   End
   Begin VB.Label Label8 
      BackColor       =   &H000000FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   6
      Left            =   7380
      TabIndex        =   23
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H0000FFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   5
      Left            =   7155
      TabIndex        =   22
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FF00FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   4
      Left            =   6930
      TabIndex        =   21
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H000080FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   3
      Left            =   6705
      TabIndex        =   20
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   2
      Left            =   6480
      TabIndex        =   19
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFFF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   1
      Left            =   6255
      TabIndex        =   18
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FF0000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   0
      Left            =   6030
      TabIndex        =   17
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   1440
      TabIndex        =   0
      Top             =   300
      Width           =   720
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   330
      Left            =   1440
      TabIndex        =   6
      Top             =   645
      Width           =   735
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   3000
      TabIndex        =   16
      Top             =   5160
      Width           =   2445
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   7
      Left            =   60
      Picture         =   "frmMain.frx":5C34
      Stretch         =   -1  'True
      Top             =   8190
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   8
      Left            =   6990
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   7
      Left            =   6765
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   6
      Left            =   6540
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   5
      Left            =   6315
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   4
      Left            =   6990
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   3
      Left            =   6765
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   2
      Left            =   6540
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   1
      Left            =   6315
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   6
      Left            =   60
      Picture         =   "frmMain.frx":66DC
      Stretch         =   -1  'True
      Top             =   7920
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   5
      Left            =   60
      Picture         =   "frmMain.frx":6C61
      Stretch         =   -1  'True
      Top             =   7605
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   4
      Left            =   60
      Picture         =   "frmMain.frx":7208
      Stretch         =   -1  'True
      Top             =   7290
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   3
      Left            =   60
      Picture         =   "frmMain.frx":77B7
      Stretch         =   -1  'True
      Top             =   6975
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   2
      Left            =   60
      Picture         =   "frmMain.frx":7D65
      Stretch         =   -1  'True
      Top             =   6705
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   1
      Left            =   60
      Picture         =   "frmMain.frx":8324
      Stretch         =   -1  'True
      Top             =   6435
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   44
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   199
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   198
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   197
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   196
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   195
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   194
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   193
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   192
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   191
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   190
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   4905
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   189
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   188
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   187
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   186
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   185
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   184
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   183
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   182
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   181
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   180
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   4665
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   179
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   178
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   177
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   176
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   175
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   174
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   173
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   172
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   171
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   170
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   4425
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   169
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   168
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   167
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   166
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   165
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   164
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   163
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   162
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   161
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   160
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   4185
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   159
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   158
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   157
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   156
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   155
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   154
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   153
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   152
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   151
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   150
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   3945
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   149
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   148
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   147
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   146
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   145
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   144
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   143
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   142
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   141
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   140
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   3705
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   139
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   138
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   137
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   136
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   135
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   134
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   133
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   132
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   131
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   130
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   3465
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   129
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   128
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   127
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   126
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   125
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   124
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   123
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   122
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   121
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   120
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   3225
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   119
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   118
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   117
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   116
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   115
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   114
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   113
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   112
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   111
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   110
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   2985
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   109
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   108
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   107
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   106
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   105
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   104
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   103
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   102
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   101
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   100
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   2745
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   99
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   98
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   97
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   96
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   95
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   94
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   93
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   92
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   91
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   90
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   2505
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   89
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   88
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   87
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   86
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   85
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   84
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   83
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   82
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   81
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   80
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   2265
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   79
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   78
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   77
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   76
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   75
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   74
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   73
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   72
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   71
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   70
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   2025
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   69
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   68
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   67
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   66
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   65
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   64
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   63
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   62
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   61
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   60
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   1785
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   59
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   58
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   57
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   56
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   55
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   54
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   53
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   52
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   51
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   50
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   1545
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   49
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   48
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   47
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   46
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   45
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   43
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   42
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   41
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   40
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   1305
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   39
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   38
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   37
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   36
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   35
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   34
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   33
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   32
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   31
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   30
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   1065
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   29
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   28
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   27
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   26
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   25
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   24
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   23
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   22
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   21
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   20
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   825
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   19
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   18
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   17
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   16
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   15
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   14
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   13
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   12
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   11
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   10
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   585
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   9
      Left            =   5145
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   8
      Left            =   4905
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   7
      Left            =   4665
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   6
      Left            =   4425
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   5
      Left            =   4185
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   4
      Left            =   3945
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   3
      Left            =   3705
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   2
      Left            =   3465
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   1
      Left            =   3225
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image29 
      Height          =   225
      Index           =   0
      Left            =   2985
      Stretch         =   -1  'True
      Top             =   345
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   0
      Left            =   60
      Picture         =   "frmMain.frx":88DB
      Stretch         =   -1  'True
      Top             =   6165
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Menu mnufile 
      Caption         =   "&File"
      Begin VB.Menu mnuexit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuoptions 
      Caption         =   "&Options"
      Begin VB.Menu mnulevelstart 
         Caption         =   "Start"
         Begin VB.Menu mnu1 
            Caption         =   "1"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnu4 
            Caption         =   "4"
         End
         Begin VB.Menu mnu7 
            Caption         =   "7"
         End
      End
      Begin VB.Menu mnusound 
         Caption         =   "Audio"
         Begin VB.Menu mnusoundon 
            Caption         =   "On"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnusoundoff 
            Caption         =   "Off"
         End
      End
   End
   Begin VB.Menu mnuMultiplayer 
      Caption         =   "Multiplayer"
      Begin VB.Menu mnuShowPlayer2 
         Caption         =   "Show Player 2"
      End
      Begin VB.Menu mnuSep23907130 
         Caption         =   "-"
      End
      Begin VB.Menu mnuShowServer 
         Caption         =   "Show Server (Wait for Connections)"
      End
      Begin VB.Menu mnuShowClient 
         Caption         =   "Show Client (Connect to Game)"
      End
      Begin VB.Menu mnuCloseUploadManager 
         Caption         =   "Close Upload Manager"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Rotation(0 To 6, 0 To 1) As Integer
Dim BackTable(1 To 21, 1 To 12) As Integer
Dim ShapesTable(1 To 21, 1 To 12) As Integer
Dim TempBack(0 To 3) As Integer
Dim NextPiece As Integer
Dim CurPiece As Integer
Dim Play As Boolean
Dim level As Integer, PartPoints As Integer, Score As Long, TotalLines As Integer, TotalBricks As Integer
Dim Tiles(0 To 6) As Integer
Dim LinesLeft As Integer
Dim GGG As Integer
Dim myAddBlock As Boolean, BlocksCount As Integer
Dim myAddLine As Boolean, LinesCount As Integer
Dim MyUpper As Integer, TeTram As Integer
'Dim panos As Database, rstpanos As Recordset
Dim Sound As Boolean
Dim StartLevel As Integer

Public Sub StartNewGame()
On Local Error Resume Next
Picture1_Click
End Sub

Sub StartPlay()
On Local Error Resume Next
If Play Then
    level = level + 1
    LinesLeft = GetLevelLines(level)
    Label9.Caption = LinesLeft
    Label5.Caption = level
    If Sound Then
        'mm1.Command = "prev"
        'mm1.Command = "play"
    End If
    tmrDrop.Enabled = True
    Game
End If
End Sub

Sub Game()
On Local Error Resume Next
If Play Then
    CurPiece = NextPiece
    If myAddBlock Then
        BlocksCount = BlocksCount + 1
        If BlocksCount = 5 Then
            BlocksCount = 0
            AddNewBlock
        End If
    End If
    If myAddLine Then
        LinesCount = LinesCount + 1
        If LinesCount = 6 Then
            LinesCount = 0
            AddNewLine
        End If
    End If
    ShowCurpiece CurPiece
    TotalBricks = TotalBricks + 1
    FixStats CurPiece
    Label2.Caption = TotalBricks
    NextPiece = ChoosePiece
    ShowNextPiece NextPiece
    Me.SetFocus
End If
End Sub

Private Sub Command10_Click()
'Set picDestination.Picture = picDestination.Picture

End Sub

'Private Sub Command11_Click()

'Dim msg As String, l As Long
'l = ReturnWindowHwnd("Inet Tetris Upload", frmMain.lstWindows)
'SetProgramsText l, "422www.00freehost.com*nexgen-tetris.00freehost.com*dietpepsi"
'End Sub

Private Sub ctlTetrisServer_StateChanged(ByVal State As Integer)
'MsgBox State
End Sub

Private Sub Command1_Click()

End Sub

'Private Sub Command9_Click()
'tmrCleanupGraphics.Enabled = True
'End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
Dim i As Integer, MyA(0 To 3) As Integer
If Play Then
    If KeyCode = vbKeyLeft Then
        For i = 3 To 0 Step -1
            If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 1) = -1 Then Exit Sub
        Next
        For i = 3 To 0 Step -1
            Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
        Next
        For i = 3 To 0 Step -1
            TempBack(i) = TempBack(i) - 1
            Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
        Next
    End If
    If KeyCode = vbKeyRight Then
        For i = 3 To 0 Step -1
            If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 3) = -1 Then Exit Sub
        Next
        For i = 3 To 0 Step -1
            Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
        Next
        For i = 3 To 0 Step -1
            TempBack(i) = TempBack(i) + 1
            Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
        Next
    End If
    If KeyCode = vbKeyDown Then
        Fall_Piece
    End If
    If KeyCode = vbKeyUp Or KeyCode = vbKeyZ Then
        Select Case CurPiece
        Case 1
            If GET_ROW_Temp(TempBack(0)) + 1 = 1 Then Exit Sub
            If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
                Rotation(CurPiece, 1) = 1
            Else
                Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
            End If
            Select Case Rotation(CurPiece, 1)
            Case 1
                MyA(3) = TempBack(3) - 10
                MyA(2) = TempBack(2) - 1
                MyA(1) = TempBack(1) - 8
                MyA(0) = TempBack(0) + 1
                If Right(GET_PIECE_Temp(TempBack(3)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 2
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 2
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 10
                TempBack(2) = TempBack(2) - 1
                TempBack(1) = TempBack(1) - 8
                TempBack(0) = TempBack(0) + 1
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 2
                MyA(3) = TempBack(3) + 10
                MyA(2) = TempBack(2) + 1
                MyA(1) = TempBack(1) + 8
                MyA(0) = TempBack(0) - 1
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 1
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 10
                TempBack(2) = TempBack(2) + 1
                TempBack(1) = TempBack(1) + 8
                TempBack(0) = TempBack(0) - 1
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            End Select
        Case 2
            If Right(GET_PIECE_Temp(TempBack(1)), 1) = "9" Then
                Rotation(CurPiece, 1) = 1
                Exit Sub
            End If
            If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
                Rotation(CurPiece, 1) = 1
            Else
                Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
            End If
            Select Case Rotation(CurPiece, 1)
            Case 1
                MyA(3) = TempBack(3) - 11
                MyA(2) = TempBack(2) - 10
                MyA(1) = TempBack(1) - 10
                MyA(0) = TempBack(0) - 2
                If Right(GET_PIECE_Temp(TempBack(1)), 1) = "0" Then
                    Rotation(CurPiece, 1) = 4
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 4
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 11
                TempBack(2) = TempBack(2) - 10
                TempBack(1) = TempBack(1) - 10
                TempBack(0) = TempBack(0) - 2
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 2
                MyA(3) = TempBack(3) + 9
                MyA(2) = TempBack(2) + 9
                MyA(1) = TempBack(1) + 9
                MyA(0) = TempBack(0)
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 1
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 9
                TempBack(2) = TempBack(2) + 9
                TempBack(1) = TempBack(1) + 9
                TempBack(0) = TempBack(0)
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 3
                MyA(3) = TempBack(3) + 2
                MyA(2) = TempBack(2) + 10
                MyA(1) = TempBack(1) + 10
                MyA(0) = TempBack(0) + 11
                If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 2
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 2
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 2
                TempBack(2) = TempBack(2) + 10
                TempBack(1) = TempBack(1) + 10
                TempBack(0) = TempBack(0) + 11
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 4
                MyA(3) = TempBack(3)
                MyA(2) = TempBack(2) - 9
                MyA(1) = TempBack(1) - 9
                MyA(0) = TempBack(0) - 9
                If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 3
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 3
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3)
                TempBack(2) = TempBack(2) - 9
                TempBack(1) = TempBack(1) - 9
                TempBack(0) = TempBack(0) - 9
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            End Select
        Case 3
            If GET_ROW_Temp(TempBack(0)) + 1 = 1 Then Exit Sub
            If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
                Rotation(CurPiece, 1) = 1
            Else
                Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
            End If
            Select Case Rotation(CurPiece, 1)
            Case 1
                MyA(3) = TempBack(3) - 9
                MyA(2) = TempBack(2) - 1
                MyA(1) = TempBack(1) - 10
                MyA(0) = TempBack(0) - 2
                If Right(GET_PIECE_Temp(TempBack(3)), 1) = "0" Then
                    Rotation(CurPiece, 1) = 2
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 2
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 9
                TempBack(2) = TempBack(2) - 1
                TempBack(1) = TempBack(1) - 10
                TempBack(0) = TempBack(0) - 2
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 2
                MyA(3) = TempBack(3) + 9
                MyA(2) = TempBack(2) + 1
                MyA(1) = TempBack(1) + 10
                MyA(0) = TempBack(0) + 2
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 1
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 9
                TempBack(2) = TempBack(2) + 1
                TempBack(1) = TempBack(1) + 10
                TempBack(0) = TempBack(0) + 2
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            End Select
        Case 4
            If GET_ROW_Temp(TempBack(1)) + 1 = 1 Then Exit Sub
            If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
                Rotation(CurPiece, 1) = 1
            Else
                Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
            End If
            Select Case Rotation(CurPiece, 1)
            Case 1
                MyA(3) = TempBack(3) - 11
                MyA(2) = TempBack(2) - 9
                MyA(1) = TempBack(1)
                MyA(0) = TempBack(0)
                If Right(GET_PIECE_Temp(TempBack(1)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 4
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 4
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 11
                TempBack(2) = TempBack(2) - 9
                TempBack(1) = TempBack(1)
                TempBack(0) = TempBack(0)
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 2
                MyA(3) = TempBack(3) + 1
                MyA(2) = TempBack(2) + 8
                MyA(1) = TempBack(1) - 1
                MyA(0) = TempBack(0) - 10
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 1
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 1
                TempBack(2) = TempBack(2) + 8
                TempBack(1) = TempBack(1) - 1
                TempBack(0) = TempBack(0) - 10
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 3
                MyA(3) = TempBack(3) + 1
                MyA(2) = TempBack(2) + 1
                MyA(1) = TempBack(1) + 10
                MyA(0) = TempBack(0) + 12
                If Right(GET_PIECE_Temp(TempBack(3)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 2
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 2
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 1
                TempBack(2) = TempBack(2) + 1
                TempBack(1) = TempBack(1) + 10
                TempBack(0) = TempBack(0) + 12
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 4
                MyA(3) = TempBack(3) + 9
                MyA(2) = TempBack(2)
                MyA(1) = TempBack(1) - 9
                MyA(0) = TempBack(0) - 2
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 3
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 9
                TempBack(2) = TempBack(2)
                TempBack(1) = TempBack(1) - 9
                TempBack(0) = TempBack(0) - 2
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            End Select
        Case 5
            If GET_ROW_Temp(TempBack(1)) + 1 = 1 Then Exit Sub
            If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
                Rotation(CurPiece, 1) = 1
            Else
                Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
            End If
            Select Case Rotation(CurPiece, 1)
            Case 1
                MyA(3) = TempBack(3) + 1
                MyA(2) = TempBack(2) - 8
                MyA(1) = TempBack(1)
                MyA(0) = TempBack(0) + 9
                If Right(GET_PIECE_Temp(TempBack(1)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 4
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 4
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 1
                TempBack(2) = TempBack(2) - 8
                TempBack(1) = TempBack(1)
                TempBack(0) = TempBack(0) + 9
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 2
                MyA(3) = TempBack(3) + 9
                MyA(2) = TempBack(2) + 9
                MyA(1) = TempBack(1) + 1
                MyA(0) = TempBack(0) + 1
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 1
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 9
                TempBack(2) = TempBack(2) + 9
                TempBack(1) = TempBack(1) + 1
                TempBack(0) = TempBack(0) + 1
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 3
                MyA(3) = TempBack(3) - 9
                MyA(2) = TempBack(2)
                MyA(1) = TempBack(1) + 8
                MyA(0) = TempBack(0) - 1
                If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Then
                    Rotation(CurPiece, 1) = 2
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 2
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 9
                TempBack(2) = TempBack(2)
                TempBack(1) = TempBack(1) + 8
                TempBack(0) = TempBack(0) - 1
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 4
                MyA(3) = TempBack(3) - 1
                MyA(2) = TempBack(2) - 1
                MyA(1) = TempBack(1) - 9
                MyA(0) = TempBack(0) - 9
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 3
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 1
                TempBack(2) = TempBack(2) - 1
                TempBack(1) = TempBack(1) - 9
                TempBack(0) = TempBack(0) - 9
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            End Select
        Case 6
            If GET_ROW_Temp(TempBack(0)) + 1 = 1 Or GET_ROW_Temp(TempBack(0)) + 1 = 2 Then Exit Sub
            If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
                Rotation(CurPiece, 1) = 1
            Else
                Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
            End If
            Select Case Rotation(CurPiece, 1)
            Case 1
                MyA(3) = TempBack(3) - 8
                MyA(2) = TempBack(2) + 1
                MyA(1) = TempBack(1) + 10
                MyA(0) = TempBack(0) + 19
                If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
                    Rotation(CurPiece, 1) = 2
                    Exit Sub
                End If
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 2
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) - 8
                TempBack(2) = TempBack(2) + 1
                TempBack(1) = TempBack(1) + 10
                TempBack(0) = TempBack(0) + 19
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
                    Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            Case 2
                MyA(3) = TempBack(3) + 8
                MyA(2) = TempBack(2) - 1
                MyA(1) = TempBack(1) - 10
                MyA(0) = TempBack(0) - 19
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
                        Rotation(CurPiece, 1) = 1
                        Exit Sub
                    End If
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
                Next
                TempBack(3) = TempBack(3) + 8
                TempBack(2) = TempBack(2) - 1
                TempBack(1) = TempBack(1) - 10
                TempBack(0) = TempBack(0) - 19
                For i = 3 To 0 Step -1
                    If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then Exit Sub
                Next
                For i = 3 To 0 Step -1
                    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
                Next
            End Select
        End Select
    End If
End If
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim i As Integer
If Len(fNickname) = 0 Then
    fNickname = GetSetting("Tetris", "Settings", "Nickname", "")
    If Len(fNickname) = 0 Then
        fNickname = InputBox("Enter Nickname:")
    End If
End If
frmMain.Width = 8070
CheckRequiredFiles
Sound = True
level = 0
Randomize
Init_BackTable
Init_ShapesTable
Init_Rotation
NextPiece = ChoosePiece
For i = 0 To 6
    Label8(i).Height = 0
    Label8(i).Top = Label4.Top
    Label10(i).Left = Label8(i).Left
Next
fUploadNumber = GetRnd(1000)
Me.Height = 6690
End Sub

Sub Init_Rotation()
On Local Error Resume Next
Rotation(1, 0) = 2
Rotation(1, 1) = 1
Rotation(2, 0) = 4
Rotation(2, 1) = 1
Rotation(3, 0) = 2
Rotation(3, 1) = 1
Rotation(4, 0) = 4
Rotation(4, 1) = 1
Rotation(5, 0) = 4
Rotation(5, 1) = 1
Rotation(6, 0) = 2
Rotation(6, 1) = 1
End Sub

Sub Init_BackTable()
On Local Error Resume Next
Dim i As Integer, j As Integer
For i = 1 To 21
    BackTable(i, 1) = -1
    BackTable(i, 12) = -1
Next
For i = 1 To 20
    For j = 2 To 11
        BackTable(i, j) = 0
    Next
Next
For i = 1 To 12
    BackTable(21, i) = -1
Next
End Sub

Sub Init_ShapesTable()
On Local Error Resume Next
Dim i As Integer, j As Integer
For i = 1 To 21
    ShapesTable(i, 1) = -1
    ShapesTable(i, 12) = -1
Next
For i = 1 To 20
    ShapesTable(i, 2) = (i - 1) * 10
    For j = 3 To 11
        ShapesTable(i, j) = ShapesTable(i, j - 1) + 1
    Next
Next
For i = 1 To 12
    ShapesTable(21, i) = -1
Next
End Sub

Sub PrintBackTable()
On Local Error Resume Next
Dim i As Integer, j As Integer, counter As Integer
For i = 1 To 21
    For j = 1 To 12
        counter = counter + 1
        If counter > 11 Then
            counter = 0
            Debug.Print BackTable(i, j)
        Else
            Debug.Print BackTable(i, j);
        End If
    Next
Next
End Sub

Sub PrintShapesTable()
On Local Error Resume Next
Dim i As Integer, j As Integer, counter As Integer
Debug.Print
Debug.Print
Debug.Print
Debug.Print
Debug.Print
For i = 1 To 21
    For j = 1 To 12
        counter = counter + 1
        If counter > 11 Then
            counter = 0
            Debug.Print ShapesTable(i, j)
        Else
            Debug.Print ShapesTable(i, j);
        End If
    Next
Next
End Sub

Function ChoosePiece() As Integer
On Local Error Resume Next
ChoosePiece = Int(Rnd * 7)
End Function

Sub ShowNextPiece(a As Integer)
On Local Error Resume Next
Dim i As Integer
For i = 1 To 8
    Image31(i).Picture = LoadPicture
Next
Select Case a
Case 0
    Image31(2).Picture = Image5(a).Picture
    Image31(3).Picture = Image5(a).Picture
    Image31(6).Picture = Image5(a).Picture
    Image31(7).Picture = Image5(a).Picture
Case 1
    Image31(2).Picture = Image5(a).Picture
    Image31(3).Picture = Image5(a).Picture
    Image31(5).Picture = Image5(a).Picture
    Image31(6).Picture = Image5(a).Picture
Case 2
    Image31(1).Picture = Image5(a).Picture
    Image31(2).Picture = Image5(a).Picture
    Image31(3).Picture = Image5(a).Picture
    Image31(6).Picture = Image5(a).Picture
Case 3
    Image31(1).Picture = Image5(a).Picture
    Image31(2).Picture = Image5(a).Picture
    Image31(6).Picture = Image5(a).Picture
    Image31(7).Picture = Image5(a).Picture
Case 4
    Image31(1).Picture = Image5(a).Picture
    Image31(2).Picture = Image5(a).Picture
    Image31(3).Picture = Image5(a).Picture
    Image31(5).Picture = Image5(a).Picture
Case 5
    Image31(1).Picture = Image5(a).Picture
    Image31(2).Picture = Image5(a).Picture
    Image31(3).Picture = Image5(a).Picture
    Image31(7).Picture = Image5(a).Picture
Case 6
    Image31(1).Picture = Image5(a).Picture
    Image31(2).Picture = Image5(a).Picture
    Image31(3).Picture = Image5(a).Picture
    Image31(4).Picture = Image5(a).Picture
End Select
End Sub

Sub ShowCurpiece(a As Integer)
On Local Error Resume Next
Dim i As Integer
Select Case a
Case 0
    Image29(4).Picture = Image5(a).Picture
    Image29(5).Picture = Image5(a).Picture
    Image29(14).Picture = Image5(a).Picture
    Image29(15).Picture = Image5(a).Picture
    TempBack(0) = 4
    TempBack(1) = 5
    TempBack(2) = 14
    TempBack(3) = 15
Case 1
    Image29(4).Picture = Image5(a).Picture
    Image29(5).Picture = Image5(a).Picture
    Image29(13).Picture = Image5(a).Picture
    Image29(14).Picture = Image5(a).Picture
    TempBack(0) = 4
    TempBack(1) = 5
    TempBack(2) = 13
    TempBack(3) = 14
Case 2
    Image29(4).Picture = Image5(a).Picture
    Image29(5).Picture = Image5(a).Picture
    Image29(3).Picture = Image5(a).Picture
    Image29(14).Picture = Image5(a).Picture
    TempBack(0) = 3
    TempBack(1) = 4
    TempBack(2) = 5
    TempBack(3) = 14
Case 3
    Image29(4).Picture = Image5(a).Picture
    Image29(15).Picture = Image5(a).Picture
    Image29(3).Picture = Image5(a).Picture
    Image29(14).Picture = Image5(a).Picture
    TempBack(0) = 3
    TempBack(1) = 4
    TempBack(2) = 14
    TempBack(3) = 15
Case 4
    Image29(4).Picture = Image5(a).Picture
    Image29(5).Picture = Image5(a).Picture
    Image29(3).Picture = Image5(a).Picture
    Image29(13).Picture = Image5(a).Picture
    TempBack(0) = 3
    TempBack(1) = 4
    TempBack(2) = 5
    TempBack(3) = 13
Case 5
    Image29(4).Picture = Image5(a).Picture
    Image29(5).Picture = Image5(a).Picture
    Image29(3).Picture = Image5(a).Picture
    Image29(15).Picture = Image5(a).Picture
    TempBack(0) = 3
    TempBack(1) = 4
    TempBack(2) = 5
    TempBack(3) = 15
Case 6
    Image29(4).Picture = Image5(a).Picture
    Image29(5).Picture = Image5(a).Picture
    Image29(3).Picture = Image5(a).Picture
    Image29(6).Picture = Image5(a).Picture
    TempBack(0) = 3
    TempBack(1) = 4
    TempBack(2) = 5
    TempBack(3) = 6
End Select
For i = 3 To 0 Step -1
    If BackTable(GET_ROW_Temp((TempBack(i))) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
        Play = False
        tmrDrop.Enabled = False
        'mm1.Command = "stop" 'StopMid
        PlayWav App.Path & "\died.wav"
        Picture3.Visible = True
        'Set panos = OpenDatabase(App.Path & "\scores.mdb")
        'Set rstpanos = panos.OpenRecordset("select * from score")
        'rstpanos.MoveLast
        'If Score >= rstpanos!Score Then
        'Dim aaa As String
        'aaa = InputBox("Enter your name", "High Score", "")
        'rstpanos.Delete
        'rstpanos.AddNew
        'rstpanos!Name = aaa
        'rstpanos!Score = Score
        'rstpanos!Level = Level
        'rstpanos!lines = TotalLines
        'rstpanos!TeTram = TeTram
        'rstpanos!bricks = TotalBricks
        'rstpanos.Update
        'Set panos = Nothing
        'Set rstpanos = Nothing
        'Form2.Show 1
    Else
        'Set panos = Nothing
        'Set rstpanos = Nothing
    End If
    Exit Sub
Next
End Sub

Sub Fall_Piece()
On Local Error Resume Next
Dim i As Integer, j As Integer
If Not Play Then Exit Sub
For i = 3 To 0 Step -1
    If BackTable(GET_ROW_Temp((TempBack(i))) + 2, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
        For j = 3 To 0 Step -1
            BackTable(GET_ROW_Temp(TempBack(j)) + 1, GET_PIECE_Temp(TempBack(j)) + 2) = -1
        Next
        If GET_ROW_Temp(TempBack(0)) < MyUpper Then MyUpper = GET_ROW_Temp(TempBack(0))
        PlayWav App.Path & "\drop.wav"
        DoEvents
        Label3.Caption = (20 - GET_ROW_Temp(TempBack(3))) * level * 2
        Score = Score + (20 - GET_ROW_Temp(TempBack(3))) * level * 2
        Label7.Caption = Format(Score, "#,000")
        CheckLine TempBack(3)
        Init_Rotation
        Game
        'If fConnectedToUploadManager = True Then
        '    If fServer = True And fClient = False Or fServer = False And fClient = True Then
                'If frmMain.tmrUpdateCapture.Enabled = False Then
                '    frmMain.tmrUpdateCapture.Enabled = True
                'End If
            'End If
        'End If
        Exit Sub
    End If
Next
For i = 3 To 0 Step -1
    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
    TempBack(i) = TempBack(i) + 10
    Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
End Sub

Function GET_ROW_Temp(ByVal a As String)
On Local Error Resume Next
Select Case Len(a)
Case 1
    GET_ROW_Temp = 0
Case 2
    GET_ROW_Temp = Val(Left(a, 1))
Case 3
    GET_ROW_Temp = Val(Left(a, 2))
End Select
End Function

Function GET_PIECE_Temp(ByVal a As String)
On Local Error Resume Next
Select Case Len(a)
Case 1
    GET_PIECE_Temp = a
Case 2
    GET_PIECE_Temp = Val(Right(a, 1))
Case 3
    GET_PIECE_Temp = Val(Right(a, 1))
End Select
End Function

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
Dim i As Integer, msg As String
If fConnectedToUploadManager = True Then
    Do While lstGFXCleanup.ListCount <> 0
        msg = lstGFXCleanup.List(0)
        lstGFXCleanup.RemoveItem 0
        If DoesFileExist(App.Path & "\" & msg) = True Then
            Kill App.Path & "\" & msg
            If DoesFileExist(App.Path & "\" & Left(msg, Len(msg) - 4) & ".bmp") = True Then
                Kill App.Path & "\" & Left(msg, Len(msg) - 4) & ".bmp": DoEvents
            End If
        End If
    Loop
    If DoesFileExist(App.Path & "\" & fNickname & ".ini") = True Then Kill App.Path & "\" & fNickname & ".ini"
    CloseExistingUploadManager
End If
DoEvents
End
End Sub

Private Sub Label11_Click()
On Local Error Resume Next
If Play Then
    Play = False
    tmrDrop.Enabled = False
    Picture4.Visible = True
Else
    Play = True
    tmrDrop.Enabled = True
    Picture4.Visible = False
End If
End Sub

Private Sub Label13_Click()
On Local Error Resume Next
'Form2.Show 1
End Sub

Private Sub Label14_Click()
On Local Error Resume Next
'Form3.Show 1
End Sub

Private Sub Label15_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error Resume Next
If Play Then
    Play = False
    tmrDrop.Enabled = False
    Picture4.Visible = True
Else
    Play = True
    tmrDrop.Enabled = True
    Picture4.Visible = False
End If
End Sub

Private Sub Label16_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Picture1_Click
End Sub

Private Sub Label18_Click()
mnuShowPlayer2_Click
End Sub

Private Sub mnu1_Click()
On Local Error Resume Next
mnu1.Checked = True
mnu4.Checked = False
mnu7.Checked = False
StartLevel = 0
End Sub

Private Sub mnu4_Click()
On Local Error Resume Next
mnu1.Checked = False
mnu4.Checked = True
mnu7.Checked = False
StartLevel = 3
End Sub

Private Sub mnu7_Click()
On Local Error Resume Next
mnu1.Checked = False
mnu4.Checked = False
mnu7.Checked = True
StartLevel = 6
End Sub

Private Sub mnuCloseUploadManager_Click()
On Local Error Resume Next
CloseExistingUploadManager
End Sub

Private Sub mnuexit_Click()
On Local Error Resume Next
Unload Me
End Sub

Private Sub mnuShowClient_Click()
On Local Error Resume Next
frmClient.Show
AlwaysOnTop frmClient, True
End Sub

Private Sub mnuShowPlayer2_Click()
On Local Error Resume Next
'Dim lLeft As Long, lTop As Long
'lLeft = Me.Left
'lTop = Me.Top
If mnuShowPlayer2.Caption = "Show Player 2" Then
'    picDestination.Visible = True
    frmMain.Width = 11370
    frmMain.Left = 0
    frmMain.Top = 850
    mnuShowPlayer2.Caption = "Hide Player 2"
'    DoEvents
'    SaveCapture
'    LoadCapture
ElseIf mnuShowPlayer2.Caption = "Hide Player 2" Then
    'picDestination.Visible = False
    frmMain.Width = 8070
    frmMain.Left = 0
    frmMain.Top = 850
    mnuShowPlayer2.Caption = "Show Player 2"
End If
End Sub

Private Sub mnuShowServer_Click()
On Local Error Resume Next
frmServer.Show
End Sub

Private Sub mnusoundoff_Click()
On Local Error Resume Next
Sound = False
mnusoundon.Checked = False
mnusoundoff.Checked = True
'Timer2.Enabled = False
'mm1.Command = "stop"
'mm1.Command = "play"
End Sub

Private Sub mnusoundon_Click()
On Local Error Resume Next
Sound = True
mnusoundon.Checked = True
mnusoundoff.Checked = False
'Timer2.Enabled = True
GGG = 0
If Play Then
'    mm1.Command = "prev"
'    mm1.Command = "play"
Else
'    Mm2.Command = "prev"
'    Mm2.Command = "play"
End If
End Sub

Private Sub optServer_Click()

End Sub

Private Sub picDestination_GotFocus()
frmMain.SetFocus
End Sub

Private Sub picDestination_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
Form_KeyDown KeyCode, Shift
End Sub

Private Sub picOponent_GotFocus()
frmMain.SetFocus
End Sub

Private Sub Picture1_Click()
On Local Error Resume Next
Dim i As Integer
'Picture1.SetFocus
BlocksCount = 0
LinesCount = 0
TeTram = 0
mnulevelstart.Enabled = False
Label12.Caption = TeTram
Score = 0
MyUpper = 20
';mm1.Command = "prev"
Label7.Caption = Score
level = StartLevel
Randomize
Init_BackTable
Init_ShapesTable
Init_Rotation
NextPiece = ChoosePiece
For i = 0 To 199
    Image29(i).Picture = LoadPicture
Next
NextPiece = ChoosePiece
For i = 0 To 6
    Label8(i).Height = 0
    Label8(i).Top = Label4.Top
    Label10(i).Left = Label8(i).Left
    Label10(i).Top = Label8(i).Top - Label10(i).Height
    Tiles(i) = 0
Next
TotalLines = 0
Label1.Caption = TotalLines
TotalBricks = 0
Label2.Caption = TotalBricks
Play = True
GGG = 0
StartPlay
Picture1.Visible = False
'End If
End Sub

Private Sub Picture1_GotFocus()
On Local Error Resume Next
frmMain.SetFocus
End Sub

Private Sub Picture1_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
If KeyCode = vbKeyReturn Then
    Picture1_Click
End If
End Sub

Private Sub Picture2_Click()
On Local Error Resume Next
Dim i As Integer
Randomize
Init_BackTable
MyUpper = 20
Init_Rotation
BlocksCount = 0
LinesCount = 0
NextPiece = ChoosePiece
For i = 0 To 199
    Image29(i).Picture = LoadPicture
Next
'Mm2.Command = "stop"
Play = True
GGG = 0
StartPlay
Picture2.Visible = False
End Sub

Private Sub Picture2_GotFocus()
On Local Error Resume Next
frmMain.SetFocus
End Sub

Private Sub Picture2_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
If KeyCode = vbKeyReturn Then
Picture2_Click
End If
End Sub

Private Sub Picture3_Click()
On Local Error Resume Next
mnulevelstart.Enabled = True
Picture3.Visible = False
Picture1.Visible = True
End Sub

Private Sub Picture3_GotFocus()
On Local Error Resume Next
frmMain.SetFocus
End Sub

Private Sub Picture3_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
If KeyCode = vbKeyReturn Then
    Picture3_Click
End If
End Sub

Private Sub Picture4_Click()
On Local Error Resume Next
Label11_Click
End Sub

Private Sub Picture4_GotFocus()
On Local Error Resume Next
frmMain.SetFocus
End Sub

Private Sub Picture4_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
If KeyCode = vbKeyReturn Then
    Picture4_Click
End If
End Sub

Private Sub tmrClientDownloadMultiGFX_Timer()
On Local Error Resume Next
End Sub

Private Sub tmrDownloadOponentGFX_Timer()
On Local Error Resume Next
Dim f As New frmDownloadFile, i As Integer
Set f = New frmDownloadFile
tmrDownloadOponentGFX.Enabled = False
If DoesFileExist(App.Path & "\" & lblOponent.Caption & ".ini") = True Then Kill App.Path & "\" & lblOponent.Caption & ".ini"
f.ClickDownloadButton "http://www.nexgen-tetris.00freehost.com/tetris/" & Trim(lblOponent.Caption) & ".ini", App.Path & "\" & Trim(lblOponent.Caption) & ".ini"
Do While f.ctlWebDL.StillExecuting = True
    DoEvents
Loop
i = Int(ReadINI(App.Path & "\" & Trim(lblOponent.Caption) & ".ini", "Settings", "Count", 0))
If i <> 0 Then
    Dim m As New frmDownloadFile, msg As String
    Set m = New frmDownloadFile
    If fServer = True And fClient = False Then
        msg = ReadINI(App.Path & "\" & fClientOponentNickname & ".ini", Trim(Str(i)), "Filename", "")
        DoEvents
        'm.ClickDownloadButton "http://www.nexgen-tetris.00freehost.com/tetris/" & fClientOponentNickname & Trim(Str(i)) & ".jpg", App.Path & "\" & fClientOponentNickname & Trim(Str(i)) & ".jpg"
        m.ClickDownloadButton "http://www.nexgen-tetris.00freehost.com/tetris/" & msg, App.Path & "\" & msg
        Do While m.ctlWebDL.StillExecuting = True
            DoEvents
        Loop
        If InStr(msg, lblOponent.Caption) Then
            frmMain.picDestination.Picture = LoadPicture(App.Path & "\" & msg): DoEvents
        End If
    ElseIf fServer = False And fClient = True Then
        msg = ReadINI(App.Path & "\" & fServerOponentNickname & ".ini", Trim(Str(i)), "Filename", "")
        DoEvents
        m.ClickDownloadButton "http://www.nexgen-tetris.00freehost.com/tetris/" & msg, App.Path & "\" & msg
        Do While m.ctlWebDL.StillExecuting = True
            DoEvents
        Loop
        If InStr(msg, lblOponent.Caption) Then
            frmMain.picDestination.Picture = LoadPicture(App.Path & "\" & msg): DoEvents
        End If
    ElseIf fServer = False And fClient = False Then
    '    Stop
      '  tmrDownloadOponentGFX.Enabled = False
    ElseIf fServer = True And fClient = True Then
     '   Stop
      '  fServer = False
      '  fClient = False
      '  tmrDownloadOponentGFX.Enabled = False
    End If
End If
tmrDownloadOponentGFX.Enabled = True
End Sub

Private Sub tmrDrop_Timer()
On Local Error Resume Next
If Play Then
    Fall_Piece
End If
End Sub

Sub CheckLine(mystart As Integer)
On Local Error Resume Next
Dim a, i As Integer, j As Integer, myok As Boolean, counter As Integer
myok = True
a = GET_ROW_Temp(mystart)
For i = a * 10 To 1 Step -10
    For j = i To i + 9
        If Image29(j).Picture = 0 Then
            myok = False
            Exit For
        End If
    Next
    If myok = True Then
        Play = False
        tmrDrop.Enabled = False
        counter = counter + 1
        EraseLine i
        i = i + 10
        myok = True
    Else
        myok = True
    End If
Next
Select Case counter
Case 1
    Label3.Caption = "Single line 100 points"
    TotalLines = TotalLines + 1
    Label1.Caption = TotalLines
    Score = Score + 100
    Label7.Caption = Format(Score, "#,000")
Case 2
    Label3.Caption = "Double line 300 points"
    TotalLines = TotalLines + 2
    Label1.Caption = TotalLines
    Score = Score + 300
    Label7.Caption = Format(Score, "#,000")
Case 3
    Label3.Caption = "Triple line 500 points"
    TotalLines = TotalLines + 3
    Label1.Caption = TotalLines
    Score = Score + 500
    Label7.Caption = Format(Score, "#,000")
Case 4
    Label3.Caption = "tetRAM!!! " & 1000 * level & " points"
    TotalLines = TotalLines + 4
    Label1.Caption = TotalLines
    Score = Score + 1000 * level
    Label7.Caption = Format(Score, "#,000")
    TeTram = TeTram + 1
    Label12.Caption = TeTram
End Select
Play = True
tmrDrop.Enabled = True
LinesLeft = LinesLeft - counter
Label9.Caption = LinesLeft
If LinesLeft <= 0 Then
    LinesLeft = 0
    Label9.Caption = LinesLeft
    tmrDrop.Enabled = False
    Play = False
    If Sound Then
        'mm1.Command = "stop"
        Delay 0.5
        GGG = 0
        'Mm2.Command = "prev"
        'Mm2.Command = "play"
    End If
    CheckforBonusLines
End If
End Sub

Sub EraseLine(whatline As Integer)
On Local Error Resume Next
Dim k As Integer, i As Integer, j As Integer
For k = whatline To whatline + 9
    Image29(k).Picture = Image5(7).Picture
Next
Delay 0.2
For k = whatline To whatline + 9
    Image29(k).Picture = LoadPicture
    BackTable(GET_ROW_Temp(k) + 1, GET_PIECE_Temp(k) + 2) = 0
Next
PlayWav App.Path & "\erase.wav"
If MyUpper <= 2 Then MyUpper = 3
For i = GET_ROW_Temp(whatline) + 1 To MyUpper - 1 Step -1
    For j = 2 To 11
        BackTable(i, j) = BackTable(i - 1, j)
        Image29((i - 1) * 10 + j - 2).Picture = Image29((i - 1) * 10 + j - 2 - 10).Picture
    Next
Next
MyUpper = MyUpper + 1
End Sub

Private Sub Timer2_Timer()
On Local Error Resume Next
GGG = GGG + 1
If GGG = 100 Then
    GGG = 0
    If Play Then
        'mm1.Command = "prev"
        'mm1.Command = "play"
    Else
        'Mm2.Command = "prev"
        'Mm2.Command = "play"
    End If
End If
End Sub

Sub FixStats(a As Integer)
On Local Error Resume Next
Dim i As Integer
Tiles(a) = Tiles(a) + 1
For i = 0 To 6
    Label8(i).Height = Label6.Height * Tiles(i) / TotalBricks
    Label8(i).Top = Label4.Top - Label8(i).Height
    Label10(i).Caption = Tiles(i)
    Label10(i).Top = Label8(i).Top - Label10(i).Height
Next
End Sub

Function GetLevelLines(a As Integer)
On Local Error Resume Next
Select Case a
Case 1
    GetLevelLines = 5
    myAddBlock = False
    myAddLine = False
    tmrDrop.Interval = 1000
Case 2
    myAddBlock = False
    myAddLine = False
    GetLevelLines = 10
    tmrDrop.Interval = 900
Case 3
    myAddBlock = False
    myAddLine = False
    GetLevelLines = 12
    tmrDrop.Interval = 850
Case 4
    myAddBlock = False
    myAddLine = False
    GetLevelLines = 10
    tmrDrop.Interval = 550
    InitLevel a
Case 5
    myAddBlock = False
    myAddLine = False
    GetLevelLines = 13
    tmrDrop.Interval = 550
    InitLevel a
Case 6
    myAddBlock = False
    myAddLine = False
    GetLevelLines = 16
    tmrDrop.Interval = 500
    InitLevel a
Case 7
    myAddBlock = True
    myAddLine = False
    GetLevelLines = 10
    tmrDrop.Interval = 450
Case 8
    myAddBlock = True
    myAddLine = False
    GetLevelLines = 13
    tmrDrop.Interval = 450
Case 9
    myAddLine = False
    myAddBlock = True
    GetLevelLines = 16
    tmrDrop.Interval = 400
Case 10
    GetLevelLines = 12
    tmrDrop.Interval = 350
    myAddBlock = False
    myAddLine = True
Case 11
    GetLevelLines = 16
    tmrDrop.Interval = 350
    myAddBlock = False
    myAddLine = True
Case 12
    GetLevelLines = 20
    tmrDrop.Interval = 300
    myAddBlock = False
    myAddLine = True
Case 13
    GetLevelLines = 12
    tmrDrop.Interval = 250
    myAddBlock = False
    myAddLine = False
    InitLevel a
Case 14
    GetLevelLines = 16
    tmrDrop.Interval = 250
    myAddBlock = False
    myAddLine = False
    InitLevel a
Case 15
    GetLevelLines = 20
    tmrDrop.Interval = 200
    myAddBlock = False
    myAddLine = False
    InitLevel a
Case 16 To 18
    GetLevelLines = 20
    tmrDrop.Interval = 150
    InitLevel a
Case 19
    GetLevelLines = 12
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 20
    GetLevelLines = 16
    tmrDrop.Interval = 130
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 21
    GetLevelLines = 18
    tmrDrop.Interval = 100
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 22
    GetLevelLines = 12
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 23
    GetLevelLines = 16
    tmrDrop.Interval = 130
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 24
    GetLevelLines = 18
    tmrDrop.Interval = 100
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 25, 26, 27
    GetLevelLines = 20
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = False
Case 28
    GetLevelLines = 12
    tmrDrop.Interval = 150
    myAddBlock = True
    myAddLine = True
Case 29
    GetLevelLines = 16
    tmrDrop.Interval = 150
    myAddBlock = True
    myAddLine = True
Case 30
    GetLevelLines = 18
    tmrDrop.Interval = 150
    myAddBlock = True
    myAddLine = True
Case 31
    GetLevelLines = 12
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case 32
    GetLevelLines = 16
    tmrDrop.Interval = 130
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case 33
    GetLevelLines = 18
    tmrDrop.Interval = 100
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case 34
    GetLevelLines = 12
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case 35
    GetLevelLines = 16
    tmrDrop.Interval = 130
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case 36
    GetLevelLines = 18
    tmrDrop.Interval = 100
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case 37 To 39
    GetLevelLines = 20
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = True
Case Is > 39
    GetLevelLines = 12
    tmrDrop.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = True
End Select
End Function

Sub CheckforBonusLines()
On Local Error Resume Next
Dim i As Integer, j As Integer, k As Integer, myok As Boolean
myok = True
For i = 0 To MyUpper - 1
    For j = 0 To 9
        If Image29(j + (i * 10)).Picture <> 0 Then
            myok = False
            Exit For
        End If
    Next
    If myok Then
        For k = 0 To 9
            Image29(k + (i * 10)).Picture = Image5(7).Picture
        Next
        Score = Score + 100 * level
        Label7.Caption = Format(Score, "#,000")
        Label3.Caption = "Bonus " & 100 * level & " points"
        PlayWav App.Path & "\levelup.wav"
        Delay 0.2
    End If
    myok = True
Next
Picture2.Visible = True
End Sub

Sub InitLevel(f As Integer)
On Local Error Resume Next
Dim i As Integer, j As Integer
Select Case f
Case 4, 19, 31
    For i = 12 To 19
        j = Int(Rnd * 7)
        BackTable(i + 1, 2) = -1
        Image29(i * 10) = Image5(j)
        j = Int(Rnd * 7)
        BackTable(i + 1, 11) = -1
        Image29(i * 10 + 9) = Image5(j)
    Next
Case 5, 20, 32
    j = Int(Rnd * 7)
    BackTable(20, 3) = -1
    Image29(191).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 8) = -1
    Image29(196).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 5) = -1
    Image29(183).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 10) = -1
    Image29(188).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(18, 7) = -1
    Image29(175).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 4) = -1
    Image29(162).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 8) = -1
    Image29(166).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 9) = -1
    Image29(167).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(16, 2) = -1
    Image29(150).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(16, 6) = -1
    Image29(154).Picture = Image5(j).Picture
Case 6, 21, 33
    j = Int(Rnd * 7)
    BackTable(20, 2) = -1
    Image29(190).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 3) = -1
    Image29(191).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 5) = -1
    Image29(193).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 6) = -1
    Image29(194).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 7) = -1
    Image29(195).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 8) = -1
    Image29(196).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 10) = -1
    Image29(198).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(20, 11) = -1
    Image29(199).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 3) = -1
    Image29(181).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 4) = -1
    Image29(182).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 6) = -1
    Image29(184).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 7) = -1
    Image29(185).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 9) = -1
    Image29(187).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(19, 10) = -1
    Image29(188).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(18, 4) = -1
    Image29(172).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(18, 5) = -1
    Image29(173).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(18, 8) = -1
    Image29(176).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(18, 9) = -1
    Image29(177).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 5) = -1
    Image29(163).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 6) = -1
    Image29(164).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 7) = -1
    Image29(165).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(17, 8) = -1
    Image29(166).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(16, 6) = -1
    Image29(154).Picture = Image5(j).Picture
    j = Int(Rnd * 7)
    BackTable(16, 7) = -1
    Image29(155).Picture = Image5(j).Picture
Case 13, 22, 34
    For i = 15 To 19
        j = Int(Rnd * 7)
        BackTable(i + 1, 2) = -1
        Image29(i * 10) = Image5(j)
        j = Int(Rnd * 7)
        BackTable(i + 1, 11) = -1
        Image29(i * 10 + 9) = Image5(j)
    Next
    For i = 16 To 18
        j = Int(Rnd * 7)
        BackTable(i + 1, 3) = -1
        Image29(i * 10 + 1) = Image5(j)
        j = Int(Rnd * 7)
        BackTable(i + 1, 10) = -1
        Image29(i * 10 + 8) = Image5(j)
    Next
    j = Int(Rnd * 7)
    BackTable(18, 4) = -1
    Image29(172) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(18, 9) = -1
    Image29(177) = Image5(j)
Case 14, 23, 35
    j = Int(Rnd * 7)
    BackTable(19, 6) = -1
    Image29(184) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(19, 7) = -1
    Image29(185) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(17, 4) = -1
    Image29(162) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(17, 9) = -1
    Image29(167) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(15, 6) = -1
    Image29(144) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(15, 7) = -1
    Image29(145) = Image5(j)
Case 15, 24, 36
    j = Int(Rnd * 7)
    BackTable(20, 2) = -1
    Image29(190) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(20, 9) = -1
    Image29(197) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(19, 3) = -1
    Image29(181) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(19, 10) = -1
    Image29(188) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(18, 4) = -1
    Image29(172) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(18, 11) = -1
    Image29(179) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(17, 5) = -1
    Image29(163) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(17, 8) = -1
    Image29(166) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(16, 9) = -1
    Image29(157) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(15, 2) = -1
    Image29(140) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(15, 10) = -1
    Image29(148) = Image5(j)
    j = Int(Rnd * 7)
    BackTable(14, 3) = -1
    Image29(131) = Image5(j)
Case 16, 17, 18, 25, 26, 27, 37, 38, 39, Is > 39
    For i = 16 To 19
        BackTable(i + 1, 2) = -1
        Image29(i * 10) = Image5(6)
        BackTable(i + 1, 5) = -1
        Image29(i * 10 + 3) = Image5(2)
        BackTable(i + 1, 7) = -1
        Image29(i * 10 + 5) = Image5(2)
        BackTable(i + 1, 8) = -1
        Image29(i * 10 + 6) = Image5(0)
        BackTable(i + 1, 10) = -1
        Image29(i * 10 + 8) = Image5(0)
    Next
    BackTable(16, 6) = -1
    Image29(154) = Image5(2)
    BackTable(18, 6) = -1
    Image29(174) = Image5(2)
    BackTable(16, 8) = -1
    Image29(156) = Image5(0)
    BackTable(16, 10) = -1
    Image29(158) = Image5(0)
    BackTable(17, 9) = -1
    Image29(167) = Image5(0)
    For i = 2 To 4
        BackTable(16, i) = -1
        Image29(148 + i).Picture = Image5(6)
    Next
    BackTable(17, 4) = -1
    Image29(162) = Image5(6)
    BackTable(18, 4) = -1
    Image29(172) = Image5(6)
    BackTable(18, 3) = -1
    Image29(171) = Image5(6)
    BackTable(19, 3) = -1
    Image29(181) = Image5(6)
    BackTable(20, 4) = -1
    Image29(192) = Image5(6)
End Select
End Sub

Sub AddNewBlock()
On Local Error Resume Next
Dim j As Integer, i As Integer
j = Int(Rnd * 10) + 2
For i = 0 To 19
    If BackTable(i + 1, j) = -1 Then
        If i = 0 Then
            Play = False
            tmrDrop.Enabled = False
            'mm1.Command = "stop"
            PlayWav App.Path & "\died.wav"
            Picture3.Visible = True
            Exit Sub
        End If
        BackTable(i, j) = -1
        Image29(((i - 1) * 10) + j - 2).Picture = Image5(7).Picture
        PlayWav App.Path & "\scratch.wav"
        If GET_ROW_Temp(((i - 1) * 10) + j - 2) < MyUpper Then MyUpper = GET_ROW_Temp(((i - 1) * 10) + j - 2)
        DoEvents
        CheckLine ((i - 1) * 10) + j - 2
        Exit Sub
    End If
Next
AddNewBlock
End Sub

Sub AddNewLine()
On Local Error Resume Next
Dim i As Integer, j As Integer, k As Integer, h As Integer
For i = MyUpper - 1 To 18
    For j = 2 To 11
        BackTable(i + 1, j) = BackTable(i + 2, j)
        Image29(i * 10 + j - 2).Picture = Image29(i * 10 + j - 2 + 10).Picture
    Next
Next
i = 0
j = 0
Do Until i <> j
    i = Int(Rnd * 10)
    j = Int(Rnd * 10)
Loop
For k = 1 To 10
    h = Int(Rnd * 7)
    Image29(189 + k).Picture = Image5(h).Picture
    BackTable(20, k + 1) = -1
Next
Image29(190 + i).Picture = LoadPicture
Image29(190 + j).Picture = LoadPicture
BackTable(20, i + 2) = 0
BackTable(20, j + 2) = 0
PlayWav App.Path & "\splat.wav"
MyUpper = MyUpper - 1
End Sub

Private Sub tmrCleanupGraphics_Timer()
On Local Error Resume Next
Dim l As Long, msg As String
If lstGFXCleanup.ListCount > 6 Then
    msg = lstGFXCleanup.List(0)
    lstGFXCleanup.RemoveItem 0
    If DoesFileExist(App.Path & "\" & msg) = True Then
        Kill App.Path & "\" & msg
        If DoesFileExist(App.Path & "\" & Left(msg, Len(msg) - 4) & ".bmp") = True Then
            Kill App.Path & "\" & Left(msg, Len(msg) - 4) & ".bmp"
        End If
    End If
End If
End Sub

Private Sub tmrForShow_Timer()
On Local Error Resume Next
lblClientOponentNick.Caption = fClientOponentNickname
lblOponentsNick.Caption = fServerOponentNickname
lblSnapshotNumber.Caption = Str(fSnapShotNumber)
If fServer = True Then
    chkServer.Value = 1
Else
    chkServer.Value = 0
End If
If fClient = True Then
    chkClient.Value = 1
Else
    chkClient.Value = 0
End If
If fConnectedToUploadManager = True Then
    chkConnectedToUploadManager.Value = 1
Else
    chkConnectedToUploadManager.Value = 0
End If
lblNickname.Caption = fNickname
End Sub

Private Sub tmrUpdateCapture_Timer()
On Local Error Resume Next
fConnectedToUploadManager = True
LoginToUploadManagerAndUpdateGraphic True: DoEvents
End Sub
