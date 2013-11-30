VERSION 5.00
Begin VB.Form frmConnectToServer 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Connect To FServe"
   ClientHeight    =   840
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4515
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmConnectToServer.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   840
   ScaleWidth      =   4515
   StartUpPosition =   3  'Windows Default
   Begin AcidmaxPlayer.isButton cmdAdd 
      Height          =   300
      Left            =   840
      TabIndex        =   2
      Top             =   480
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   529
      Icon            =   "frmConnectToServer.frx":0CCA
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
   Begin VB.ComboBox cboServer 
      Height          =   315
      Left            =   840
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   120
      Width           =   3615
   End
   Begin AcidmaxPlayer.isButton cmdRemove 
      Height          =   300
      Left            =   1800
      TabIndex        =   3
      Top             =   480
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   529
      Icon            =   "frmConnectToServer.frx":0CE6
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
   Begin AcidmaxPlayer.isButton cmdConnect 
      Default         =   -1  'True
      Height          =   300
      Left            =   3600
      TabIndex        =   4
      Top             =   480
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   529
      Icon            =   "frmConnectToServer.frx":0D02
      Style           =   1
      Caption         =   "Connect"
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
   Begin VB.Label Label1 
      Caption         =   "Select:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1935
   End
End
Attribute VB_Name = "frmConnectToServer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAdd_Click()
'On Local Error Resume Next
Dim msg As String, msg2 As String, msg3 As String
msg3 = InputBox("Enter Description of FServe")
msg = InputBox("Enter IP Address:")
msg2 = InputBox("Enter Port:")
cboServer.AddItem msg3
AddFServe msg3, msg, CLng(Trim(msg2))
End Sub

Private Sub cmdConnect_Click()
'On Local Error Resume Next
ConnectToFServe ReturnFServeIp(cboServer.Text), ReturnFServePort(cboServer.Text)
End Sub

Private Sub cmdRemove_Click()
'On Local Error Resume Next

End Sub

Private Sub Form_Load()
'On Local Error Resume Next
Dim i As Integer, msg As String
If ReturnFServeCount <> 0 Then
    For i = 1 To ReturnFServeCount
        If Len(ReturnFServeDescription(i)) <> 0 Then
            cboServer.AddItem ReturnFServeDescription(i)
        End If
    Next i
End If
End Sub
