VERSION 5.00
Begin VB.Form frmFServeClient 
   Caption         =   "FServe Client"
   ClientHeight    =   3915
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6015
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmFServeClient.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3915
   ScaleWidth      =   6015
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtPath 
      Height          =   285
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6015
   End
   Begin VB.ListBox lsitFiles 
      Height          =   3375
      Left            =   0
      TabIndex        =   0
      Top             =   300
      Width           =   6015
   End
End
Attribute VB_Name = "frmFServeClient"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
