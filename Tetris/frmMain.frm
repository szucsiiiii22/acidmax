VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Tetris"
   ClientHeight    =   5970
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8040
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMain.frx":0CCA
   ScaleHeight     =   398
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   536
   ShowInTaskbar   =   0   'False
   Begin VB.Timer Timer2 
      Interval        =   1000
      Left            =   7020
      Top             =   1395
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7470
      Top             =   1395
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1530
      Left            =   2745
      MouseIcon       =   "frmMain.frx":506C
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":593E
      ScaleHeight     =   1500
      ScaleWidth      =   2850
      TabIndex        =   3
      Top             =   1485
      Width           =   2880
   End
   Begin VB.PictureBox Picture4 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1530
      Left            =   2745
      MouseIcon       =   "frmMain.frx":6645
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":6F17
      ScaleHeight     =   1500
      ScaleWidth      =   2850
      TabIndex        =   28
      Top             =   1485
      Visible         =   0   'False
      Width           =   2880
   End
   Begin VB.PictureBox Picture3 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1530
      Left            =   2745
      MouseIcon       =   "frmMain.frx":8044
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":8916
      ScaleHeight     =   1500
      ScaleWidth      =   2850
      TabIndex        =   1
      Top             =   1485
      Visible         =   0   'False
      Width           =   2880
   End
   Begin VB.PictureBox Picture2 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1530
      Left            =   2745
      MouseIcon       =   "frmMain.frx":9625
      MousePointer    =   99  'Custom
      Picture         =   "frmMain.frx":9EF7
      ScaleHeight     =   1500
      ScaleWidth      =   2850
      TabIndex        =   2
      Top             =   1485
      Visible         =   0   'False
      Width           =   2880
   End
   Begin VB.Image Image1 
      Height          =   495
      Left            =   120
      Top             =   4080
      Width           =   2055
   End
   Begin VB.Label Label14 
      BackStyle       =   0  'Transparent
      Height          =   465
      Left            =   1560
      MouseIcon       =   "frmMain.frx":AF48
      MousePointer    =   99  'Custom
      TabIndex        =   29
      Top             =   5400
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.Label Label13 
      BackStyle       =   0  'Transparent
      Height          =   465
      Left            =   240
      MouseIcon       =   "frmMain.frx":B81A
      MousePointer    =   99  'Custom
      TabIndex        =   17
      Top             =   5040
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   7155
      TabIndex        =   7
      Top             =   2790
      Width           =   510
   End
   Begin VB.Label Label11 
      BackStyle       =   0  'Transparent
      Height          =   465
      Left            =   1320
      MouseIcon       =   "frmMain.frx":C0EC
      MousePointer    =   99  'Custom
      TabIndex        =   9
      Top             =   5520
      Visible         =   0   'False
      Width           =   2040
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
      TabIndex        =   16
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
      Index           =   4
      Left            =   6930
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
      Index           =   3
      Left            =   6705
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
      Index           =   2
      Left            =   6525
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
      Index           =   1
      Left            =   6255
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
      Index           =   0
      Left            =   6030
      TabIndex        =   10
      Top             =   4995
      Width           =   195
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   315
      TabIndex        =   8
      Top             =   3510
      Width           =   1680
   End
   Begin VB.Label Label6 
      Caption         =   "Label6"
      Height          =   1905
      Left            =   7785
      TabIndex        =   26
      Top             =   3420
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.Label Label4 
      Caption         =   "Label4"
      Height          =   105
      Left            =   5940
      TabIndex        =   27
      Top             =   5310
      Visible         =   0   'False
      Width           =   1860
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   7155
      TabIndex        =   5
      Top             =   2520
      Width           =   510
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   7155
      TabIndex        =   4
      Top             =   2205
      Width           =   510
   End
   Begin VB.Label Label8 
      BackColor       =   &H000000FF&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   6
      Left            =   7380
      TabIndex        =   25
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H0000FFFF&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   5
      Left            =   7155
      TabIndex        =   24
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FF00FF&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   4
      Left            =   6930
      TabIndex        =   23
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H000080FF&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   3
      Left            =   6705
      TabIndex        =   22
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H0000FF00&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   2
      Left            =   6480
      TabIndex        =   21
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFFF00&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   1
      Left            =   6255
      TabIndex        =   20
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FF0000&
      ForeColor       =   &H00FF0000&
      Height          =   15
      Index           =   0
      Left            =   6030
      TabIndex        =   19
      Top             =   5265
      Width           =   210
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   315
      TabIndex        =   0
      Top             =   2070
      Width           =   1680
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   161
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   330
      Left            =   1440
      TabIndex        =   6
      Top             =   2565
      Width           =   510
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   161
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   2925
      TabIndex        =   18
      Top             =   5130
      Width           =   2445
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   7
      Left            =   5580
      Picture         =   "frmMain.frx":C9BE
      Stretch         =   -1  'True
      Top             =   2070
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   8
      Left            =   7110
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   7
      Left            =   6885
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   6
      Left            =   6660
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   5
      Left            =   6435
      Stretch         =   -1  'True
      Top             =   990
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   4
      Left            =   7110
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   3
      Left            =   6885
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   2
      Left            =   6660
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image31 
      Height          =   225
      Index           =   1
      Left            =   6435
      Stretch         =   -1  'True
      Top             =   765
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   6
      Left            =   5580
      Picture         =   "frmMain.frx":D466
      Stretch         =   -1  'True
      Top             =   1800
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   5
      Left            =   5580
      Picture         =   "frmMain.frx":D9EB
      Stretch         =   -1  'True
      Top             =   1485
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   4
      Left            =   5580
      Picture         =   "frmMain.frx":DF92
      Stretch         =   -1  'True
      Top             =   1170
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   3
      Left            =   5580
      Picture         =   "frmMain.frx":E541
      Stretch         =   -1  'True
      Top             =   855
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   2
      Left            =   5580
      Picture         =   "frmMain.frx":EAEF
      Stretch         =   -1  'True
      Top             =   585
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Image Image5 
      Height          =   225
      Index           =   1
      Left            =   5580
      Picture         =   "frmMain.frx":F0AE
      Stretch         =   -1  'True
      Top             =   315
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
      Left            =   5580
      Picture         =   "frmMain.frx":F665
      Stretch         =   -1  'True
      Top             =   45
      Visible         =   0   'False
      Width           =   225
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const WM_SETTEXT = &HC
Private Const WM_CHAR = &H102
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Sub ReleaseCapture Lib "user32" ()
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Enum eWindowThemes
    wWindowClassic = 1
    wWindowXP = 2
End Enum
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private lVarRect As RECT, lVarLong As Long
Private lTitleBarHeight As Long

Private Rotation(0 To 6, 0 To 1) As Integer
Private BackTable(1 To 21, 1 To 12) As Integer
Private ShapesTable(1 To 21, 1 To 12) As Integer
Private TempBack(0 To 3) As Integer
Private NextPiece As Integer
Private CurPiece As Integer
Private Play As Boolean
Private Level As Integer, PartPoints As Integer, Score As Long, TotalLines As Integer, TotalBricks As Integer
Private Tiles(0 To 6) As Integer
Private LinesLeft As Integer
Private GGG As Integer
Private myAddBlock As Boolean, BlocksCount As Integer
Private myAddLine As Boolean, LinesCount As Integer
Private MyUpper As Integer, TeTram As Integer
'Private panos As Database, rstpanos As Recordset
Private Sound As Boolean
Private StartLevel As Integer

Sub GetWindowSize(ByVal hWnd As Long, Width As Long, Height As Long)
'On Local Error Resume Next
Dim rc As RECT
GetWindowRect hWnd, rc
Width = rc.Right - rc.Left
Height = rc.Bottom - rc.Top
End Sub

Public Function DoesFileExist(lFileName As String) As Boolean
'On Local Error Resume Next
Dim msg As String
msg = Dir(lFileName)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
End Function

Public Function ReadFile(lFile As String) As String
'On Local Error Resume Next
Dim n As Integer, msg As String
n = FreeFile
If DoesFileExist(lFile) = True Then
    Open lFile For Input As #n
        msg = StrConv(InputB(LOF(n), n), vbUnicode)
        If Len(msg) <> 0 Then
            ReadFile = Left(msg, Len(msg) - 2)
        End If
    Close #n
End If
End Function

Public Function GetFileTitle(lFileName As String) As String
'On Local Error Resume Next
Dim msg() As String
If Len(lFileName) <> 0 Then
    msg = Split(lFileName, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

Public Sub FormDrag(lForm As Form)
'On Local Error GoTo ErrHandler
ReleaseCapture
Call SendMessage(lForm.hWnd, &HA1, 2, 0&)
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Sub mIRCStatusSend(lData As String)
'On Local Error Resume Next
Dim lmIRC As Long, lMdiClient As Long, lmIRCStatus As Long, lEditBox As Long
lmIRC = FindWindow("mIRC", vbNullString)
lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20A", vbNullString)
Call SendMessageByString(lEditBox, WM_SETTEXT, 0&, lData)
If lEditBox = 0 Then Exit Sub
Do
    DoEvents
    lmIRC = FindWindow("mIRC", vbNullString)
    lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
    lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
    lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20A", vbNullString)
    Call SendMessageLong(lEditBox, WM_CHAR, 13, 0&)
Loop Until lEditBox <> 0
End Sub

Sub StartPlay()
If Play Then
    Level = Level + 1
    LinesLeft = GetLevelLines(Level)
    Label9.Caption = LinesLeft
    Label5.Caption = Level
    If Sound Then
        'mm1.Command = "prev"
        'mm1.Command = "play"
    End If
    Timer1.Enabled = True
    Game
End If
End Sub

Sub Game()
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
    'Timer1.Enabled = True
    Me.SetFocus
End If
End Sub

Private Sub Command1_Click()
Level = 38
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim i As Integer
Dim MyA(0 To 3) As Integer
If Play Then
    If KeyCode = 88 Then
        If Timer1.Enabled = True Then
            Timer1.Enabled = False
            'Picture5.Visible = True
            'Picture5.Width = Me.ScaleWidth
            'Picture5.Height = Me.ScaleHeight
            Me.Caption = ""
            Me.WindowState = vbMinimized
        Else
            Timer1.Enabled = True
            Me.Caption = "Tetris"
        End If
    End If
    If KeyCode = vbKeyLeft Then
        For i = 3 To 0 Step -1
            If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 1) = -1 Then
                Exit Sub
            End If
        Next i
        For i = 3 To 0 Step -1
            Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
        Next i
        For i = 3 To 0 Step -1
            TempBack(i) = TempBack(i) - 1
            Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
        Next
    End If
    If KeyCode = vbKeyRight Then
        For i = 3 To 0 Step -1
            If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 3) = -1 Then
                Exit Sub
            End If
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
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

Case 2
MyA(3) = TempBack(3) + 10
MyA(2) = TempBack(2) + 1
MyA(1) = TempBack(1) + 8
MyA(0) = TempBack(0) - 1
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 1
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 10
TempBack(2) = TempBack(2) + 1
TempBack(1) = TempBack(1) + 8
TempBack(0) = TempBack(0) - 1
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

End Select


Case 2
If Right(GET_PIECE_Temp(TempBack(1)), 1) = "9" Then
Rotation(CurPiece, 1) = 1
Exit Sub
End If
'*****************************************
If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
Rotation(CurPiece, 1) = 1
Else
Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
End If
'*************************************************
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

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) - 11
TempBack(2) = TempBack(2) - 10
TempBack(1) = TempBack(1) - 10
TempBack(0) = TempBack(0) - 2
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

Case 2
MyA(3) = TempBack(3) + 9
MyA(2) = TempBack(2) + 9
MyA(1) = TempBack(1) + 9
MyA(0) = TempBack(0)
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 1
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 9
TempBack(2) = TempBack(2) + 9
TempBack(1) = TempBack(1) + 9
TempBack(0) = TempBack(0)
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************
Case 3
MyA(3) = TempBack(3) + 2
MyA(2) = TempBack(2) + 10
MyA(1) = TempBack(1) + 10
MyA(0) = TempBack(0) + 11
If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
Rotation(CurPiece, 1) = 2
Exit Sub
End If

'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 2
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 2
TempBack(2) = TempBack(2) + 10
TempBack(1) = TempBack(1) + 10
TempBack(0) = TempBack(0) + 11
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************
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

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3)
TempBack(2) = TempBack(2) - 9
TempBack(1) = TempBack(1) - 9
TempBack(0) = TempBack(0) - 9
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

End Select



Case 3
If GET_ROW_Temp(TempBack(0)) + 1 = 1 Then Exit Sub
'*****************************************
If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
Rotation(CurPiece, 1) = 1
Else
Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
End If
'*************************************************
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

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) - 9
TempBack(2) = TempBack(2) - 1
TempBack(1) = TempBack(1) - 10
TempBack(0) = TempBack(0) - 2
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

Case 2
MyA(3) = TempBack(3) + 9
MyA(2) = TempBack(2) + 1
MyA(1) = TempBack(1) + 10
MyA(0) = TempBack(0) + 2
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 1
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 9
TempBack(2) = TempBack(2) + 1
TempBack(1) = TempBack(1) + 10
TempBack(0) = TempBack(0) + 2
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

End Select




Case 4
If GET_ROW_Temp(TempBack(1)) + 1 = 1 Then Exit Sub

'If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
'Rotation(CurPiece, 1) = 3
'Exit Sub
'End If
'*****************************************
If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
Rotation(CurPiece, 1) = 1
Else
Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
End If
'*************************************************
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

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) - 11
TempBack(2) = TempBack(2) - 9
TempBack(1) = TempBack(1)
TempBack(0) = TempBack(0)
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

Case 2
MyA(3) = TempBack(3) + 1
MyA(2) = TempBack(2) + 8
MyA(1) = TempBack(1) - 1
MyA(0) = TempBack(0) - 10
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 1
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 1
TempBack(2) = TempBack(2) + 8
TempBack(1) = TempBack(1) - 1
TempBack(0) = TempBack(0) - 10
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************
Case 3
MyA(3) = TempBack(3) + 1
MyA(2) = TempBack(2) + 1
MyA(1) = TempBack(1) + 10
MyA(0) = TempBack(0) + 12
If Right(GET_PIECE_Temp(TempBack(3)), 1) = "9" Then
Rotation(CurPiece, 1) = 2
Exit Sub
End If
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 2
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 1
TempBack(2) = TempBack(2) + 1
TempBack(1) = TempBack(1) + 10
TempBack(0) = TempBack(0) + 12
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************
Case 4
MyA(3) = TempBack(3) + 9
MyA(2) = TempBack(2)
MyA(1) = TempBack(1) - 9
MyA(0) = TempBack(0) - 2
'If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
'Rotation(CurPiece, 1) = 3
'Exit Sub
'End If



For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 3
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 9
TempBack(2) = TempBack(2)
TempBack(1) = TempBack(1) - 9
TempBack(0) = TempBack(0) - 2
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

End Select





Case 5
If GET_ROW_Temp(TempBack(1)) + 1 = 1 Then Exit Sub

'If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
'Rotation(CurPiece, 1) = 3
'Exit Sub
'End If
'*****************************************
If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
Rotation(CurPiece, 1) = 1
Else
Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
End If
'*************************************************
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

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 1
TempBack(2) = TempBack(2) - 8
TempBack(1) = TempBack(1)
TempBack(0) = TempBack(0) + 9
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

Case 2
MyA(3) = TempBack(3) + 9
MyA(2) = TempBack(2) + 9
MyA(1) = TempBack(1) + 1
MyA(0) = TempBack(0) + 1
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 1
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 9
TempBack(2) = TempBack(2) + 9
TempBack(1) = TempBack(1) + 1
TempBack(0) = TempBack(0) + 1
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************
Case 3
MyA(3) = TempBack(3) - 9
MyA(2) = TempBack(2)
MyA(1) = TempBack(1) + 8
MyA(0) = TempBack(0) - 1
If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Then
Rotation(CurPiece, 1) = 2
Exit Sub
End If
'If Right(GET_PIECE_Temp(TempBack(0)), 1) = "0" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "8" Or Right(GET_PIECE_Temp(TempBack(0)), 1) = "9" Then
'Rotation(CurPiece, 1) = 2
'Exit Sub
'End If


For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 2
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) - 9
TempBack(2) = TempBack(2)
TempBack(1) = TempBack(1) + 8
TempBack(0) = TempBack(0) - 1
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************
Case 4
MyA(3) = TempBack(3) - 1
MyA(2) = TempBack(2) - 1
MyA(1) = TempBack(1) - 9
MyA(0) = TempBack(0) - 9
'If Right(GET_PIECE_Temp(TempBack(2)), 1) = "9" Then
'Rotation(CurPiece, 1) = 3
'Exit Sub
'End If



For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(MyA(i)) + 1, GET_PIECE_Temp(MyA(i)) + 2) = -1 Then
Rotation(CurPiece, 1) = 3
Exit Sub
End If
Next

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) - 1
TempBack(2) = TempBack(2) - 1
TempBack(1) = TempBack(1) - 9
TempBack(0) = TempBack(0) - 9
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

End Select






Case 6
If GET_ROW_Temp(TempBack(0)) + 1 = 1 Or GET_ROW_Temp(TempBack(0)) + 1 = 2 Then Exit Sub

'*****************************************
If Rotation(CurPiece, 1) = Rotation(CurPiece, 0) Then
Rotation(CurPiece, 1) = 1
Else
Rotation(CurPiece, 1) = Rotation(CurPiece, 1) + 1
End If
'*************************************************
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

'*****************************************
For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) - 8
TempBack(2) = TempBack(2) + 1
TempBack(1) = TempBack(1) + 10
TempBack(0) = TempBack(0) + 19
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next
'*****************************************

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

'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = LoadPicture
Next
'*****************************************
TempBack(3) = TempBack(3) + 8
TempBack(2) = TempBack(2) - 1
TempBack(1) = TempBack(1) - 10
TempBack(0) = TempBack(0) - 19
'*****************************************
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
Exit Sub
End If
Next
'*****************************************

For i = 3 To 0 Step -1
Image29(ShapesTable(GET_ROW_Temp(TempBack(i)) + 1, GET_PIECE_Temp(TempBack(i)) + 2)).Picture = Image5(CurPiece).Picture
Next

End Select


End Select


End If
End If
End Sub

Private Sub Form_Load()
Dim i As Integer
'Web1.Navigate "about:blank"
'mm1.FileName = App.Path & "\tetrisa.mid"
'mm1.Command = "open"
'Mm2.FileName = App.Path & "\tetrisb.mid"
'Mm2.Command = "open"
Sound = True
Level = 0
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
'PrintBackTable
'PrintShapesTable
lTitleBarHeight = ReturnWindowTitleBarHeight(ReturnParentWindow)
SetWindowToChild Me.hWnd
End Sub

Sub Init_Rotation()
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
Dim i As Integer, j As Integer
Dim counter As Integer

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
Dim i As Integer, j As Integer
Dim counter As Integer

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
ChoosePiece = Int(Rnd * 7)
End Function

Sub ShowNextPiece(a As Integer)
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
Timer1.Enabled = False
'mm1.Command = "stop" 'StopMid
PlayWav App.Path & "\died.wav"
Picture3.Visible = True
'Web1.Navigate "http://www.vellum.org.gr/tetram/addram.asp?name=ram" & "&score=" & Score & "&level=" & Level & "&bricks=" & TotalBricks & "&lines=" & TotalLines & "&tetrams=" & TeTram
'Form3.Show 1
'Set panos = OpenDatabase(App.Path & "\scores.mdb")
'Set rstpanos = panos.OpenRecordset("select * from score")
'rstpanos.MoveLast
'If Score >= rstpanos!Score Then
'Dim aaa As String
'aaa = InputBox("Name", "High Score", "RAMcomputer")
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
'Else
'Set panos = Nothing
'Set rstpanos = Nothing

'End If
Exit Sub
End If
Next

End Sub

Sub Fall_Piece()
Dim i As Integer, j As Integer
If Not Play Then Exit Sub
For i = 3 To 0 Step -1
If BackTable(GET_ROW_Temp((TempBack(i))) + 2, GET_PIECE_Temp(TempBack(i)) + 2) = -1 Then
For j = 3 To 0 Step -1
BackTable(GET_ROW_Temp(TempBack(j)) + 1, GET_PIECE_Temp(TempBack(j)) + 2) = -1
Next
If GET_ROW_Temp(TempBack(0)) < MyUpper Then MyUpper = GET_ROW_Temp(TempBack(0))
PlayWav App.Path & "\drop.wav"
Label3.Caption = (20 - GET_ROW_Temp(TempBack(3))) * Level * 2
Score = Score + (20 - GET_ROW_Temp(TempBack(3))) * Level * 2
Label7.Caption = Format(Score, "#,000")
CheckLine TempBack(3)
Init_Rotation
Game
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
Select Case Len(a)
Case 1
GET_PIECE_Temp = a
Case 2
GET_PIECE_Temp = Val(Right(a, 1))
Case 3
GET_PIECE_Temp = Val(Right(a, 1))
End Select
End Function

Private Sub Image1_Click()
If Timer1.Enabled = True Then
    Timer1.Enabled = False
    'Picture5.Visible = True
    'Picture5.Width = Me.ScaleWidth
    'Picture5.Height = Me.ScaleHeight
    Me.Caption = ""
    'Me.WindowState = vbMinimized
Else
    Timer1.Enabled = True
    Me.Caption = "Tetris"
End If
End Sub

Private Sub Label11_Click()
If Play Then
Play = False
Timer1.Enabled = False
Picture4.Visible = True
Else
Play = True
Timer1.Enabled = True
Picture4.Visible = False
End If
End Sub

Private Sub Label13_Click()
'Form2.Show 1
End Sub

Private Sub Label14_Click()
'Form3.Show 1
End Sub

Private Sub mnu1_Click()
'mnu1.Checked = True
'mnu4.Checked = False
'mnu7.Checked = False
StartLevel = 0
End Sub

Private Sub mnu4_Click()
'mnu1.Checked = False
'mnu4.Checked = True
'mnu7.Checked = False
StartLevel = 3

End Sub

Private Sub mnu7_Click()
'mnu1.Checked = False
'mnu4.Checked = False
'mnu7.Checked = True
StartLevel = 6

End Sub

Private Sub mnuabout_Click()

End Sub

Private Sub mnuexit_Click()
Unload Me
End Sub

Private Sub mnusoundoff_Click()
Sound = False
'mnusoundon.Checked = False
'mnusoundoff.Checked = True
Timer2.Enabled = False
'mm1.Command = "stop"
'mm1.Command = "play"

End Sub

Private Sub mnusoundon_Click()
Sound = True
'mnusoundon.Checked = True
'mnusoundoff.Checked = False
Timer2.Enabled = True
GGG = 0
If Play Then
'mm1.Command = "prev"
'mm1.Command = "play"
Else
'Mm2.Command = "prev"
'Mm2.Command = "play"

End If

End Sub

Private Sub Picture1_Click()
Dim i As Integer
'GetLevelLines = 20
'Timer1.Interval = 150
'InitLevel a
'myAddBlock = True
'myAddLine = True


BlocksCount = 0
LinesCount = 0
TeTram = 0
Label12.Caption = TeTram
Score = 0
MyUpper = 20
Label7.Caption = Score
Level = StartLevel
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
End Sub

Private Sub Picture1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
Picture1_Click
End If

End Sub

Private Sub Picture2_Click()
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

Private Sub Picture2_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
Picture2_Click
End If
End Sub

Private Sub Picture3_Click()
'mnulevelstart.Enabled = True
Picture3.Visible = False
Picture1.Visible = True
End Sub

Private Sub Picture3_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
Picture3_Click
End If
End Sub

Private Sub Picture4_Click()
Label11_Click
End Sub

Private Sub Picture4_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
Picture4_Click
End If
End Sub

Private Sub Picture5_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'Picture5.Visible = False
Timer1.Enabled = True
End Sub

Private Sub Timer1_Timer()
If Play Then
Fall_Piece
End If
End Sub

Sub CheckLine(mystart As Integer)
Dim a, i As Integer, j As Integer
Dim myok As Boolean, counter As Integer
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
Timer1.Enabled = False
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
'Label3.Caption = "tetRAM!!! " & 1000 * Level & " points"
TotalLines = TotalLines + 4
Label1.Caption = TotalLines
Score = Score + 1000 * Level
Label7.Caption = Format(Score, "#,000")
TeTram = TeTram + 1
Label12.Caption = TeTram
End Select
Play = True
Timer1.Enabled = True
LinesLeft = LinesLeft - counter
Label9.Caption = LinesLeft
If LinesLeft <= 0 Then
LinesLeft = 0
Label9.Caption = LinesLeft
Timer1.Enabled = False
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
On Error Resume Next
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
Select Case a
Case 1
GetLevelLines = 5
myAddBlock = False
myAddLine = False
Timer1.Interval = 1000
Case 2
myAddBlock = False
myAddLine = False
GetLevelLines = 10
Timer1.Interval = 900
Case 3
myAddBlock = False
myAddLine = False
GetLevelLines = 12
Timer1.Interval = 850
'--------------------
Case 4
myAddBlock = False
myAddLine = False
GetLevelLines = 10
Timer1.Interval = 550
InitLevel a
Case 5
myAddBlock = False
myAddLine = False
GetLevelLines = 13
Timer1.Interval = 550
InitLevel a
Case 6
myAddBlock = False
myAddLine = False
GetLevelLines = 16
Timer1.Interval = 500
InitLevel a
'--------------------
Case 7
myAddBlock = True
myAddLine = False
GetLevelLines = 10
Timer1.Interval = 450
Case 8
myAddBlock = True
myAddLine = False
GetLevelLines = 13
Timer1.Interval = 450
Case 9
myAddLine = False
myAddBlock = True
GetLevelLines = 16
Timer1.Interval = 400
'--------------------
Case 10
GetLevelLines = 12
Timer1.Interval = 350
myAddBlock = False
myAddLine = True
Case 11
GetLevelLines = 16
Timer1.Interval = 350
myAddBlock = False
myAddLine = True
Case 12
GetLevelLines = 20
Timer1.Interval = 300
myAddBlock = False
myAddLine = True
'--------------------
Case 13
GetLevelLines = 12
Timer1.Interval = 250
myAddBlock = False
myAddLine = False
InitLevel a
Case 14
GetLevelLines = 16
Timer1.Interval = 250
myAddBlock = False
myAddLine = False
InitLevel a
Case 15
GetLevelLines = 20
Timer1.Interval = 200
myAddBlock = False
myAddLine = False
InitLevel a
'--------------------
Case 16 To 18
GetLevelLines = 20
Timer1.Interval = 150
InitLevel a
'---------------------
Case 19
GetLevelLines = 12
Timer1.Interval = 150
InitLevel a
myAddBlock = True
myAddLine = False
Case 20
GetLevelLines = 16
Timer1.Interval = 130
InitLevel a
myAddBlock = True
myAddLine = False
Case 21
GetLevelLines = 18
Timer1.Interval = 100
InitLevel a
myAddBlock = True
myAddLine = False
'-------------------------
Case 22
GetLevelLines = 12
Timer1.Interval = 150
InitLevel a
myAddBlock = True
myAddLine = False
Case 23
GetLevelLines = 16
Timer1.Interval = 130
InitLevel a
myAddBlock = True
myAddLine = False
Case 24
GetLevelLines = 18
Timer1.Interval = 100
InitLevel a
myAddBlock = True
myAddLine = False
'---------------------------
Case 25, 26, 27
GetLevelLines = 20
Timer1.Interval = 150
InitLevel a
myAddBlock = True
myAddLine = False
'--------------------------
Case 28
GetLevelLines = 12
Timer1.Interval = 150
myAddBlock = True
myAddLine = True
Case 29
GetLevelLines = 16
Timer1.Interval = 150
myAddBlock = True
myAddLine = True
Case 30
GetLevelLines = 18
Timer1.Interval = 150
myAddBlock = True
myAddLine = True
'---------------------------
Case 31
GetLevelLines = 12
Timer1.Interval = 150
InitLevel a
myAddBlock = True
myAddLine = True

Case 32
GetLevelLines = 16
Timer1.Interval = 130
InitLevel a
myAddBlock = True
myAddLine = True

Case 33
GetLevelLines = 18
Timer1.Interval = 100
InitLevel a
myAddBlock = True
myAddLine = True

'---------------------------
Case 34
GetLevelLines = 12
Timer1.Interval = 150
InitLevel a
myAddBlock = True
myAddLine = True

Case 35
GetLevelLines = 16
Timer1.Interval = 130
InitLevel a
myAddBlock = True
myAddLine = True

Case 36
GetLevelLines = 18
Timer1.Interval = 100
InitLevel a
myAddBlock = True
myAddLine = True

'---------------------------
Case 37 To 39
GetLevelLines = 20
Timer1.Interval = 150
InitLevel a
myAddBlock = True
myAddLine = True

Case Is > 39
    GetLevelLines = 12
    Timer1.Interval = 150
    InitLevel a
    myAddBlock = True
    myAddLine = True
End Select
End Function

Sub CheckforBonusLines()
Dim i As Integer, j As Integer, k As Integer
Dim myok As Boolean

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
Score = Score + 100 * Level
Label7.Caption = Format(Score, "#,000")
Label3.Caption = "Bonus " & 100 * Level & " points"
PlayWav App.Path & "\levelup.wav"
Delay 0.2
End If

myok = True
Next
Picture2.Visible = True

End Sub

Sub InitLevel(f As Integer)
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
'---------------------------------------
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
'----------------------------------------
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
'----------------------------------------
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
'------------------------------------------
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
Dim j As Integer, i As Integer
j = Int(Rnd * 10) + 2
For i = 0 To 19
If BackTable(i + 1, j) = -1 Then
        If i = 0 Then
            Play = False
            Timer1.Enabled = False
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
