VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmJunk 
   Caption         =   "Form1"
   ClientHeight    =   5430
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6585
   LinkTopic       =   "Form1"
   ScaleHeight     =   5430
   ScaleWidth      =   6585
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox CmbType 
      Height          =   315
      ItemData        =   "frmJunk.frx":0000
      Left            =   0
      List            =   "frmJunk.frx":000A
      TabIndex        =   2
      Text            =   "Files in Directories"
      Top             =   2040
      Width           =   5280
   End
   Begin VB.CheckBox ChkSubDirectorys 
      Caption         =   "&Include Sub-Directories"
      Height          =   330
      Left            =   3315
      TabIndex        =   0
      Top             =   3960
      Width           =   1995
   End
   Begin MSComctlLib.ListView ListView1 
      Height          =   1485
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5280
      _ExtentX        =   9313
      _ExtentY        =   2619
      View            =   3
      Sorted          =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   4
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Path"
         Object.Width           =   5292
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Alignment       =   1
         SubItemIndex    =   1
         Text            =   "Size"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   2
         Text            =   "DateTime"
         Object.Width           =   2646
      EndProperty
      BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   3
         Text            =   "Attr"
         Object.Width           =   882
      EndProperty
   End
   Begin VB.Label LblType 
      Caption         =   "Search Type"
      Height          =   240
      Left            =   75
      TabIndex        =   4
      Top             =   1800
      Width           =   6720
   End
   Begin VB.Label LblStatus 
      Alignment       =   1  'Right Justify
      Caption         =   "Total: 0 Results"
      Height          =   240
      Left            =   0
      TabIndex        =   3
      Top             =   1560
      Width           =   5280
   End
End
Attribute VB_Name = "frmJunk"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

