VERSION 5.00
Begin VB.Form frmSel 
   BorderStyle     =   1  'Fest Einfach
   Caption         =   "ListView Demo"
   ClientHeight    =   2955
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2295
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2955
   ScaleWidth      =   2295
   StartUpPosition =   3  'Windows-Standard
   Begin VB.CommandButton cmdIcons 
      Caption         =   "Big Icons"
      Height          =   390
      Left            =   375
      TabIndex        =   4
      Top             =   2325
      Width           =   1515
   End
   Begin VB.CommandButton cmdDrop 
      Caption         =   "Explorer Drop"
      Height          =   390
      Left            =   375
      TabIndex        =   3
      Top             =   1800
      Width           =   1515
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Simple"
      Height          =   390
      Left            =   375
      TabIndex        =   2
      Top             =   1275
      Width           =   1515
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Dark"
      Height          =   390
      Left            =   375
      TabIndex        =   1
      Top             =   750
      Width           =   1515
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Playlist"
      Height          =   390
      Left            =   375
      TabIndex        =   0
      Top             =   225
      Width           =   1515
   End
End
Attribute VB_Name = "frmSel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDrop_Click()
    frmDrop.Show , Me
End Sub

Private Sub cmdIcons_Click()
    frmBig.Show , Me
End Sub

Private Sub Command1_Click()
    frmPlaylist.Show , Me
End Sub

Private Sub Command2_Click()
    frmBlack.Show , Me
End Sub

Private Sub Command3_Click()
    frmSimp.Show , Me
End Sub
