VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form frmDownloadFile 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Download"
   ClientHeight    =   1410
   ClientLeft      =   255
   ClientTop       =   525
   ClientWidth     =   4455
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmDownloadFile.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1410
   ScaleWidth      =   4455
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Visible         =   0   'False
   WindowState     =   1  'Minimized
   Begin VB.CommandButton cmdDownload 
      Caption         =   "Download"
      Default         =   -1  'True
      Height          =   375
      Left            =   3120
      TabIndex        =   4
      Top             =   1560
      Width           =   1215
   End
   Begin VB.TextBox txtSaveAs 
      Height          =   285
      Left            =   840
      TabIndex        =   3
      Top             =   960
      Width           =   3495
   End
   Begin VB.TextBox txtURL 
      Height          =   285
      Left            =   840
      TabIndex        =   1
      Top             =   600
      Width           =   3495
   End
   Begin InetCtlsObjects.Inet ctlWebDL 
      Left            =   120
      Top             =   1440
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin VB.Label Label2 
      Caption         =   "Please wait while information is retrieved from the Addon Update Location."
      Height          =   495
      Left            =   480
      TabIndex        =   5
      Top             =   120
      Width           =   3855
   End
   Begin VB.Image Image1 
      Height          =   240
      Left            =   120
      Picture         =   "frmDownloadFile.frx":0CCA
      Top             =   120
      Width           =   240
   End
   Begin VB.Label lblSaveAs 
      Caption         =   "Save As:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "URL:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   2055
   End
End
Attribute VB_Name = "frmDownloadFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Sub ClickDownloadButton(lUrl As String, lFile As String)
On Local Error Resume Next
If Len(lUrl) <> 0 And Len(lFile) <> 0 Then
    txtSaveAs.Text = lFile
    txtURL.Text = lUrl
    cmdDownload_Click
End If
End Sub

Private Sub cmdDownload_Click()
On Local Error Resume Next
Dim lUrl As String, lFile As String, lData() As Byte
cmdDownload.Caption = "Please Wait"
cmdDownload.Enabled = False
txtURL.Enabled = False
txtSaveAs.Enabled = False
lUrl = txtURL.Text
lFile = txtSaveAs.Text
lData() = ctlWebDL.OpenURL(lUrl, icByteArray)
Open lFile For Binary Access Write As #1
    Put #1, , lData()
Close #1
Unload Me
End Sub
