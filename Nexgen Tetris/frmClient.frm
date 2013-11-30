VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmClient 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Connect to Game"
   ClientHeight    =   3900
   ClientLeft      =   285
   ClientTop       =   555
   ClientWidth     =   5400
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   12
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmClient.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3900
   ScaleWidth      =   5400
   StartUpPosition =   1  'CenterOwner
   Begin MSWinsockLib.Winsock wskClient 
      Left            =   0
      Top             =   1200
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.TextBox txtYourPort 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   4320
      TabIndex        =   11
      Text            =   "0"
      Top             =   840
      Width           =   975
   End
   Begin VB.TextBox txtPort 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   4320
      TabIndex        =   9
      Text            =   "0"
      ToolTipText     =   "Port"
      Top             =   120
      Width           =   975
   End
   Begin VB.TextBox txtNickname 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   2040
      TabIndex        =   8
      Top             =   480
      Width           =   3255
   End
   Begin VB.ListBox lstUsers 
      BackColor       =   &H00FFFFFF&
      Height          =   1695
      IntegralHeight  =   0   'False
      ItemData        =   "frmClient.frx":0CCA
      Left            =   3720
      List            =   "frmClient.frx":0CCC
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1560
      Width           =   1575
   End
   Begin VB.TextBox txtOutgoing 
      BackColor       =   &H00FFFFFF&
      Height          =   405
      Left            =   120
      TabIndex        =   5
      Top             =   3360
      Width           =   5175
   End
   Begin VB.TextBox txtIncoming 
      BackColor       =   &H00FFFFFF&
      Height          =   1695
      Left            =   120
      Locked          =   -1  'True
      MousePointer    =   1  'Arrow
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   1560
      Width           =   3495
   End
   Begin VB.CommandButton cmdDisconnect 
      Caption         =   "&Quit"
      Enabled         =   0   'False
      Height          =   315
      Left            =   3720
      TabIndex        =   4
      Top             =   1200
      Width           =   1575
   End
   Begin VB.CommandButton cmdConnect 
      Caption         =   "&Connect"
      Height          =   315
      Left            =   2040
      TabIndex        =   3
      Top             =   1200
      Width           =   1575
   End
   Begin VB.TextBox txtServerIP 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   2040
      TabIndex        =   2
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Your Port:"
      ForeColor       =   &H00404040&
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   840
      Width           =   1935
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Nickname:"
      ForeColor       =   &H00404040&
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   480
      Width           =   1935
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Server IP/Port:"
      ForeColor       =   &H00404040&
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1935
   End
End
Attribute VB_Name = "frmClient"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub AddText(lTextBox As TextBox, lText As String)
On Local Error Resume Next
lTextBox.Text = lTextBox.Text & vbCrLf & lText
End Sub

Private Sub cmdConnect_Click()
On Local Error Resume Next
'LoginToUploadManager True
If Len(txtNickname.Text) <> 0 Then
    fClient = True
    fServer = False
    fNickname = txtNickname.Text
    wskClient.Close: DoEvents
    wskClient.LocalPort = Int(txtYourPort.Text)
    wskClient.Connect txtServerIP.Text, Int(txtPort.Text)
    cmdConnect.Enabled = False
    cmdDisconnect.Enabled = True
    txtNickname.Enabled = False
    txtPort.Enabled = False
    txtServerIP.Enabled = False
Else
    MsgBox "Nickname not set, unable to connect!", vbExclamation
End If
End Sub

Private Sub cmdDisconnect_Click()
On Local Error Resume Next
wskClient.SendData "300Game Over" & vbCrLf: DoEvents
AddText txtIncoming, "Disconnected"
cmdConnect.Enabled = True
cmdDisconnect.Enabled = False
txtNickname.Enabled = True
txtPort.Enabled = True
txtServerIP.Enabled = True
lstUsers.Clear
wskClient.Close
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
If fServer = True Then
    mbox = MsgBox("You are currently a server, would you like to switch to a client?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        fServer = False
    End If
End If
If frmServer.Visible = True Then Unload frmServer
txtNickname.Text = GetSetting("Tetris", "Settings", "Nickname", "")
txtYourPort.Text = GetRnd(9000)
'txtYourPort.Text = Str(GetSetting("Tetris", "Settings", "YourPort", 4301))
txtPort.Text = Str(GetSetting("Tetris", "Settings", "Port", 4300))
txtServerIP.Text = wskClient.LocalIP
txtIncoming.Text = "Client Window"
wskClient.Close
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
SaveSetting "Tetris", "Settings", "Nickname", txtNickname.Text
'SaveSetting "Tetris", "Settings", "YourPort", txtYourPort.Text
SaveSetting "Tetris", "Settings", "Port", txtPort.Text
wskClient.Close
End Sub

Private Sub txtIncoming_Change()
On Local Error Resume Next
txtIncoming.SelStart = Len(txtIncoming.Text)
End Sub

Private Sub txtOutgoing_KeyPress(KeyAscii As Integer)
On Local Error Resume Next
If KeyAscii = 13 Then
    wskClient.SendData "200" & txtOutgoing.Text & vbCrLf
    KeyAscii = 0
    txtOutgoing.Text = ""
End If
End Sub

Private Sub wskClient_Close()
On Local Error Resume Next
cmdDisconnect.Enabled = False
cmdConnect.Enabled = True
lstUsers.Clear
txtNickname.Enabled = True
txtServerIP.Enabled = True
txtPort.Enabled = True
AddText txtIncoming, "Disconnected"
CloseExistingUploadManager
End Sub

Private Sub wskClient_Connect()
On Local Error Resume Next
wskClient.SendData "100" & txtNickname.Text & vbCrLf
AddText txtIncoming, "Connecting"
AddText txtIncoming, "Sending Nickname"
End Sub

Private Sub wskClient_DataArrival(ByVal bytesTotal As Long)
On Local Error Resume Next
Dim msg As String, i As Integer, lNickname As String
wskClient.GetData msg
i = Int(Left(msg, 3))
If Right(msg, 1) = vbCrLf Then msg = Left(msg, Len(msg) - 2)
If Right(msg, 1) = Chr(10) Then msg = Left(msg, Len(msg) - 1)
If Right(msg, 1) = Chr(13) Then msg = Left(msg, Len(msg) - 1)
msg = Right(msg, Len(msg) - 3)
DoEvents
Select Case i
Case 200
    AddText txtIncoming, msg
Case 300
Case 557
    Dim mbox As VbMsgBoxResult
    mbox = MsgBox(msg & " challenges you to a game of multiplayer Tetris, would you like to accept?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        frmMain.tmrUpdateCapture.Enabled = True
        fServerOponentNickname = msg
        frmMain.lblOponent.Caption = msg
        wskClient.SendData "558" & txtNickname.Text & vbCrLf
        frmMain.Width = 11370
        frmMain.Left = 0
        frmMain.Top = 850
        frmMain.mnuShowPlayer2.Caption = "Hide Player 2"
        frmMain.StartNewGame
        frmMain.tmrDownloadOponentGFX.Enabled = True
    End If
Case 500
    AddText txtIncoming, msg & " Connected"
    lstUsers.AddItem msg
Case 501
    lstUsers.RemoveItem FindListBoxIndex(msg, lstUsers)
End Select
End Sub

Private Sub wskClient_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
On Local Error Resume Next
AddText txtIncoming, "Connection Error: " & Description
wskClient.Close
cmdConnect.Enabled = True
cmdDisconnect.Enabled = False
txtNickname.Enabled = True
txtPort.Enabled = True
txtServerIP.Enabled = True
End Sub
