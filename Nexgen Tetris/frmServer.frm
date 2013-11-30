VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmServer 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Game Server"
   ClientHeight    =   4005
   ClientLeft      =   255
   ClientTop       =   525
   ClientWidth     =   5415
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   12
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmServer.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4005
   ScaleWidth      =   5415
   StartUpPosition =   1  'CenterOwner
   Visible         =   0   'False
   Begin VB.CommandButton cmdChallenge 
      Caption         =   "Challenge"
      Height          =   375
      Left            =   3840
      TabIndex        =   9
      Top             =   3000
      Width           =   1455
   End
   Begin MSWinsockLib.Winsock wskListen 
      Left            =   600
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock wskUsers 
      Index           =   0
      Left            =   120
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.TextBox txtPort 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   4200
      TabIndex        =   8
      Text            =   "0"
      ToolTipText     =   "Port"
      Top             =   120
      Width           =   1095
   End
   Begin VB.OptionButton optClosed 
      Caption         =   "Closed"
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   3720
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   480
      Value           =   -1  'True
      Width           =   1575
   End
   Begin VB.OptionButton optOpen 
      Caption         =   "Open"
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   2040
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   480
      Width           =   1575
   End
   Begin VB.TextBox txtEnterNickname 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   2040
      TabIndex        =   4
      Top             =   120
      Width           =   2055
   End
   Begin VB.TextBox txtOutgoing 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   405
      Left            =   120
      TabIndex        =   0
      Top             =   3480
      Width           =   5175
   End
   Begin VB.ListBox lstUsers 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   2055
      IntegralHeight  =   0   'False
      ItemData        =   "frmServer.frx":0CCA
      Left            =   3840
      List            =   "frmServer.frx":0CCC
      TabIndex        =   2
      Top             =   840
      Width           =   1455
   End
   Begin VB.TextBox txtIncoming 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   2535
      Left            =   120
      Locked          =   -1  'True
      MousePointer    =   1  'Arrow
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   840
      Width           =   3615
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Server Open?"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   480
      Width           =   2055
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Nickname/Port:"
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   2055
   End
End
Attribute VB_Name = "frmServer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim lConnectionCount As Integer

Private Sub AddText(lTextBox As TextBox, lText As String)
On Local Error Resume Next
lTextBox.Text = lTextBox.Text & vbCrLf & lText
End Sub

Public Sub CloseListen()
On Local Error Resume Next
wskListen.Close
Caption = "Game Server (Closed)"
End Sub

Public Sub InitListen()
On Local Error Resume Next
wskListen.Close
wskListen.LocalPort = Int(txtPort.Text)
wskListen.Listen
Caption = "Game Server (Listening)"
AddText txtIncoming, "Listening for Connections"
End Sub

Private Sub cmdChallenge_Click()
On Local Error Resume Next
Dim msg As String, i As Integer
If Len(lstUsers.Text) <> 0 Then
    msg = lstUsers.Text
    For i = 0 To wskUsers.Count
        If Trim(wskUsers(i).Tag) = Trim(msg) Then
            wskUsers(i).SendData "557" & txtEnterNickname.Text & vbCrLf
            Exit For
        End If
    Next i
End If
End Sub

Private Sub Form_Load()
On Local Error Resume Next
txtIncoming.Text = "Server Window"
txtEnterNickname.Text = GetSetting("Tetris", "Settings", "ServerNickname", "")
txtPort.Text = Str(GetSetting("Tetris", "Settings", "ServerPort", 4300))
Visible = True
If fClient = True Then Unload frmClient
fClient = False
fServer = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
SaveSetting "Tetris", "Settings", "ServerNickname", txtEnterNickname.Text
wskListen.Close
End Sub

Private Sub optClosed_Click()
On Local Error Resume Next
CloseListen
txtEnterNickname.Enabled = True
txtPort.Enabled = True
txtEnterNickname.Enabled = True
End Sub

Private Sub optOpen_Click()
On Local Error Resume Next
fNickname = txtEnterNickname.Text
fServer = True
If Len(txtEnterNickname.Text) = 0 Then
    MsgBox "You must enter a nickname before opening your server!", vbExclamation
    optClosed.Value = True
    Exit Sub
End If
txtEnterNickname.Enabled = False
txtPort.Enabled = False
InitListen
End Sub

Private Sub txtIncoming_Change()
On Local Error Resume Next
txtIncoming.SelStart = Len(txtIncoming.Text)
End Sub

Private Sub wskListen_Close()
On Local Error Resume Next
wskListen.Close
AddText txtIncoming, "Listening Socket Closed"
End Sub

Private Sub wskListen_ConnectionRequest(ByVal requestID As Long)
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
AddText txtIncoming, "New Connection: " & requestID
lConnectionCount = lConnectionCount + 1
Load wskUsers(lConnectionCount)
wskUsers(lConnectionCount).Accept requestID
InitListen
End Sub

Private Sub wskUsers_Close(Index As Integer)
On Local Error Resume Next
Dim i As Integer, msg As String
For i = 1 To lConnectionCount
    If wskUsers(i).State <> sckClosed Then wskUsers(i).SendData "501" & wskUsers(i).Tag
Next i
msg = wskUsers(Index).Tag
If Right(msg, 1) = Chr(10) Then msg = Left(msg, Len(msg) - 1)
If Right(msg, 1) = Chr(13) Then msg = Left(msg, Len(msg) - 1)
If Right(msg, 2) = vbCrLf Then msg = Left(msg, Len(msg) - 2)
lstUsers.RemoveItem FindListBoxIndex(msg, lstUsers)
End Sub

Private Sub wskUsers_Connect(Index As Integer)
On Local Error Resume Next
AddText txtIncoming, "wskUsers Connecting: " & Index
End Sub

Private Sub wskUsers_DataArrival(Index As Integer, ByVal bytesTotal As Long)
On Local Error Resume Next
Dim msg As String, i As Integer, lNickname As String
wskUsers(Index).GetData msg
i = Int(Left(msg, 3))
msg = Right(msg, Len(msg) - 3)
If Right(msg, 1) = vbCrLf Then msg = Left(msg, Len(msg) - 2)
If Right(msg, 1) = Chr(10) Then msg = Left(msg, Len(msg) - 1)
If Right(msg, 1) = Chr(13) Then msg = Left(msg, Len(msg) - 1)
Select Case i
Case 100
    wskUsers(Index).Tag = msg
    lNickname = wskUsers(Index).Tag
    AddText txtIncoming, lNickname & " Connected"
    For i = 1 To lConnectionCount
        If wskUsers(i).State <> sckClosed Then wskUsers(i).SendData "500" & lNickname & vbCrLf: DoEvents
    Next i
    i = 0
    lstUsers.AddItem msg
Case 200
    lNickname = wskUsers(Index).Tag
    AddText txtIncoming, "<" & lNickname & "> " & msg
    For i = 1 To lConnectionCount
        If wskUsers(i).State <> sckClosed Then
            wskUsers(i).SendData "200<" & Trim(wskUsers(Index).Tag) & "> " & msg & vbCrLf
        End If
    Next i
    i = 0
Case 558
    frmMain.tmrUpdateCapture.Enabled = True
    'MsgBox msg & " has accepted your multiplayer Tetris challenge", vbInformation
    frmMain.tmrDownloadOponentGFX.Enabled = True
    frmMain.lblOponent.Caption = msg
    frmMain.Width = 11370
    frmMain.Left = 0
    frmMain.Top = 850
    frmMain.mnuShowPlayer2.Caption = "Hide Player 2"
    frmMain.StartNewGame
    fClientOponentNickname = msg
Case 900
    lNickname = Left(wskUsers(Index).Tag, Len(wskUsers(Index).Tag) - 1)
    AddText txtIncoming, lNickname & " Disconnected"
'    MsgBox "!" & lNickname & "!"
    lstUsers.RemoveItem FindListBoxIndex(lNickname, lstUsers)
    wskUsers(Index).Close
End Select
End Sub
