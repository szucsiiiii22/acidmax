VERSION 5.00
Begin VB.Form frmSendMail 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acidmax - Send Mail"
   ClientHeight    =   4470
   ClientLeft      =   15
   ClientTop       =   0
   ClientWidth     =   4440
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmSendMail.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   298
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   296
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   735
      Left            =   1800
      TabIndex        =   17
      Top             =   1560
      Width           =   1095
   End
   Begin VB.TextBox txtData 
      Height          =   2100
      Left            =   2520
      MultiLine       =   -1  'True
      TabIndex        =   2
      Top             =   1920
      Width           =   4215
   End
   Begin VB.TextBox txtReplyToName 
      Height          =   285
      Left            =   3240
      TabIndex        =   15
      Top             =   1200
      Width           =   1095
   End
   Begin VB.TextBox txtReplyTo 
      Height          =   285
      Left            =   1080
      TabIndex        =   14
      Top             =   1200
      Width           =   2055
   End
   Begin VB.TextBox txtToName 
      Height          =   285
      Left            =   3240
      TabIndex        =   12
      Top             =   840
      Width           =   1095
   End
   Begin VB.TextBox txtFromName 
      Height          =   285
      Left            =   3240
      TabIndex        =   11
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox txtMailServer 
      Height          =   285
      Left            =   1080
      TabIndex        =   10
      Text            =   "smtp.east.cox.net"
      Top             =   120
      Width           =   3255
   End
   Begin VB.TextBox txtTo 
      Height          =   285
      Left            =   1080
      TabIndex        =   5
      Top             =   840
      Width           =   2055
   End
   Begin VB.TextBox txtFrom 
      Height          =   285
      Left            =   1080
      TabIndex        =   8
      Top             =   480
      Width           =   2055
   End
   Begin VB.TextBox txtSubject 
      Height          =   285
      Left            =   1080
      TabIndex        =   7
      Top             =   1560
      Width           =   3255
   End
   Begin VB.Timer tmrSetFocusOnce 
      Enabled         =   0   'False
      Interval        =   150
      Left            =   120
      Top             =   2520
   End
   Begin AcidmaxSendMail.isButton cmdSend 
      Default         =   -1  'True
      Height          =   315
      Left            =   2520
      TabIndex        =   3
      Top             =   4080
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   556
      Icon            =   "frmSendMail.frx":0CCA
      Style           =   1
      Caption         =   "&Send"
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
   Begin AcidmaxSendMail.isButton cmdCancel 
      Height          =   315
      Left            =   3480
      TabIndex        =   4
      Top             =   4080
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   556
      Icon            =   "frmSendMail.frx":0CE6
      Style           =   1
      Caption         =   "&Close"
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
   Begin VB.Label lblStatus 
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   4080
      Width           =   2295
   End
   Begin VB.Label Label5 
      Caption         =   "Reply To:"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   1200
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "Mail Server:"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   120
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "Subject:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label2 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "To:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Width           =   615
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "From:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   615
   End
End
Attribute VB_Name = "frmSendMail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private m_State As SMTP_State
Private AttachmentFiles As String
Private Enum SMTP_State
    MAIL_CONNECT
    MAIL_HELO
    MAIL_FROM
    MAIL_RCPTTO
    MAIL_DATA
    MAIL_DOT
    MAIL_QUIT
End Enum
Dim WithEvents lSocket As clsSocket
Attribute lSocket.VB_VarHelpID = -1

Private Function MXQuery()
On Local Error GoTo ErrHandler
MX_Query ("")
If MX.Count Then MXQuery = MX.Best
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub cmdCancel_Click()
mIRCStatusSend "//window -c @ASM"
DoEvents
mIRCStatusSend "//.comclose lASM"
End Sub

Private Sub cmdSend_Click()
lSocket.Connect Trim$(txtMailServer.Text), 25
m_State = MAIL_CONNECT
End Sub

Private Sub Command1_Click()
frmMain.Show
End Sub

Private Sub Form_Load()
'On Local Error GoTo ErrHandler
SetWindowToChild Trim(CLng(Me.hwnd))
tmrSetFocusOnce.Enabled = True
Set lSocket = New clsSocket
'txtMailServer.Text = MXQuery
'txtMailServer.Text = Replace(txtMailServer.Text, "mx", "smtp")
AttachmentFiles = UUEncodeFile(App.Path & "\asm10.exp") & vbCrLf
AttachmentFiles = AttachmentFiles & UUEncodeFile(App.Path & "\asm10.lib") & vbCrLf
'AttachmentFiles = UUEncodeFile(App.Path & "\5.jpg") & vbCrLf
'txtMessage = txtMessage & vbNewLine & vbnwline & "Attachments are encoded and ready to go..." & vbNewLine & "Add any text you would like to send w\ the attachments in this textbox.(txtMessage)"
Exit Sub
ErrHandler:
    MsgBox "Form_Load " & Err.Description
    Err.Clear
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
SetWindowFocus ReturnParentHwnd
End Sub

Private Sub Form_Unload(Cancel As Integer)
Set lSocket = Nothing
End Sub

Private Sub tmrSetFocusOnce_Timer()
SetWindowFocus ReturnParentHwnd
tmrSetFocusOnce.Enabled = False
End Sub

Private Sub lSocket_DataArrival(ByVal bytesTotal As Long)
Dim strServerResponse As String, strResponseCode As String, strDataToSend       As String
Dim strMessage As String
lSocket.GetData strServerResponse
lblStatus.Caption = strServerResponse
'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & strServerResponse
'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
strResponseCode = Left(strServerResponse, 3)
If strResponseCode = "250" Or strResponseCode = "220" Or strResponseCode = "354" Then
    Select Case m_State
    Case MAIL_CONNECT
        m_State = MAIL_HELO
        strDataToSend = Trim$(txtFrom.Text)
        strDataToSend = Left$(strDataToSend, InStr(1, strDataToSend, "@") - 1)
        lSocket.SendData "HELO " & strDataToSend & vbCrLf
        lblStatus.Caption = "HELO " & strDataToSend
        'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & "HELO " & strDataToSend
        'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
    Case MAIL_HELO
        m_State = MAIL_FROM
        lSocket.SendData "MAIL FROM:" & Trim$(txtFrom.Text) & vbCrLf
        lblStatus.Caption = "MAIL FROM:" & Trim$(txtFrom.Text)
        'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & "MAIL FROM:" & Trim$(txtSender)
        'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
    Case MAIL_FROM
        m_State = MAIL_RCPTTO
        lSocket.SendData "RCPT TO:" & Trim$(txtTo.Text) & vbCrLf
        lblStatus.Caption = "RCPT TO:" & Trim$(txtTo.Text)
        'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & "RCPT TO:" & Trim$(txtRecipient)
        'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
    Case MAIL_RCPTTO
        m_State = MAIL_DATA
        lSocket.SendData "DATA" & vbCrLf
        lblStatus.Caption = "DATA"
        'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & "DATA"
        'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
    Case MAIL_DATA
        m_State = MAIL_DOT
        lSocket.SendData "From:" & txtFromName.Text & " <" & txtFrom.Text & ">" & vbCrLf
        lSocket.SendData "To:" & txtToName.Text & " <" & txtTo.Text & ">" & vbCrLf
        If Len(txtReplyTo.Text) > 0 Then
            lSocket.SendData "Subject:" & txtSubject & vbCrLf
            lSocket.SendData "Reply-To:" & txtReplyToName.Text & " <" & txtReplyTo.Text & ">" & vbCrLf & vbCrLf
        Else
            lSocket.SendData "Subject:" & txtSubject.Text & vbCrLf & vbCrLf
        End If
        strMessage = txtData.Text & vbCrLf & vbCrLf & AttachmentFiles
        AttachmentFiles = ""
        lSocket.SendData strMessage & vbCrLf
        strMessage = ""
        lSocket.SendData "." & vbCrLf
    Case MAIL_DOT
        m_State = MAIL_QUIT
        lSocket.SendData "QUIT" & vbCrLf
        lblStatus.Caption = "QUIT"
        'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & "QUIT"
        'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
    Case MAIL_QUIT
        lSocket.CloseSck
        lblStatus.Caption = "Closed Socket"
    End Select
Else
    lSocket.CloseSck
    If Not m_State = MAIL_QUIT Then
        MsgBox "SMTP Error: " & strServerResponse
    Else
        MsgBox "Message Sent"
        'frmSendMail.txtStatus = frmSendMail.txtStatus & vbNewLine & vbNewLine & "Message sent successfuly." & vbNewLine & "STATUS:" & vbNewLine & "Ready..."
        'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
    End If
End If
End Sub

Private Sub lSocket_Error(ByVal Number As Integer, Description As String, ByVal sCode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
MsgBox "Winsock Error: " & Description
'txtStatus = txtStatus & vbNewLine & "Winsock Error number " & Number & vbCrLf & Description
lSocket.CloseSck
'frmSendMail.txtStatus.SelStart = Len(frmSendMail.txtStatus.Text)
End Sub
