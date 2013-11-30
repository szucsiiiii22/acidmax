VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Acidmax Translator"
   ClientHeight    =   2670
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4950
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   178
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   330
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtWords 
      Height          =   885
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   3
      Top             =   480
      Width           =   4695
   End
   Begin VB.TextBox txtTranslation 
      Height          =   1095
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   2
      Top             =   1440
      Width           =   4695
   End
   Begin AcidmaxTranslator.isButton cmdTranslate 
      Height          =   315
      Left            =   3720
      TabIndex        =   1
      Top             =   120
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
      Icon            =   "frmMain.frx":0CCA
      Style           =   8
      Caption         =   "Translate"
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
   Begin VB.ComboBox cboLanguage 
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   120
      Width           =   3495
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private WithEvents lSocket As clsSocket
Attribute lSocket.VB_VarHelpID = -1
Private lLanguage As String
Private lTextToTranslate As String
Private lServerURL As String
Private lServerPort As String
Private lInData As String

Private Sub cboLanguage_Click()
On Local Error GoTo ErrHandler
Dim msg As String, l As Long
'SetWindowFocus ReturnParentHwnd
l = cboLanguage.ListIndex
Select Case l
Case 0
    msg = "en_zh"
Case 1
    msg = "en_fr"
Case 2
    msg = "en_de"
Case 3
    msg = "en_it"
Case 4
    msg = "en_ja"
Case 5
    msg = "en_ko"
Case 6
    msg = "en_pt"
Case 7
    msg = "en_es"
Case 8
    msg = "zh_en"
Case 9
    msg = "fr_en"
Case 10
    msg = "fr_de"
Case 11
    msg = "de_en"
Case 12
    msg = "de_fr"
Case 13
    msg = "it_en"
Case 14
    msg = "ja_en"
Case 15
    msg = "ko_en"
Case 16
    msg = "pt_en"
Case 17
    msg = "ru_en"
Case 18
    msg = "es_en"
End Select
lLanguage = msg
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub ConnectToTranslator()
On Local Error GoTo ErrHandler
lTextToTranslate = txtWords.Text
txtTranslation.Text = ""
lSocket.CloseSck
lSocket.Connect "babelfish.altavista.com", 80
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdTranslate_Click()
On Local Error GoTo ErrHandler
'SetWindowFocus ReturnParentHwnd
If Len(txtWords.Text) <> 0 Then ConnectToTranslator
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_GotFocus()
'SetWindowFocus ReturnParentHwnd
End Sub

Private Sub Form_Load()
On Local Error GoTo ErrHandler
SetWindowToChild Trim(CLng(Me.hWnd))
lServerURL = "babelfish.altavista.com"
lServerPort = "80"
Set lSocket = New clsSocket
With cboLanguage
    .AddItem "English to Chinese", 0
    .AddItem "English to French", 1
    .AddItem "English to German", 2
    .AddItem "English to Italian", 3
    .AddItem "English to Japanese", 4
    .AddItem "English to Korean", 5
    .AddItem "English to Portuguese", 6
    .AddItem "English to Spanish", 7
    .AddItem "Chinese to English", 8
    .AddItem "French to English", 9
    .AddItem "French to German", 10
    .AddItem "German to English", 11
    .AddItem "German to French", 12
    .AddItem "Italian to English", 13
    .AddItem "Japanese to English", 14
    .AddItem "Korean to English", 15
    .AddItem "Portuguese to English", 16
    .AddItem "Russian to English", 17
    .AddItem "Spanish to English", 18
'    .ListIndex = 7
    .ListIndex = ReadINI(App.Path & "\at.ini", "Settings", "Language", 7)
End With
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'SetWindowFocus ReturnParentHwnd
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error GoTo ErrHandler
lSocket.CloseSck
Set lSocket = Nothing
WriteINI App.Path & "\at.ini", "Settings", "Language", cboLanguage.ListIndex
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function Parse(lWhole As String, lStart As String, lEnd As String)
On Local Error GoTo ErrHandler
Dim len1 As Integer, len2 As Integer, Str1 As String, Str2 As String
len1 = InStr(lWhole, lStart)
len2 = InStr(lWhole, lEnd)
Str1 = Right(lWhole, Len(lWhole) - len1)
Str2 = Right(lWhole, Len(lWhole) - len2)
Parse = Left(Str1, Len(Str1) - Len(Str2) - 1)
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub lSocket_CloseSck()
On Local Error GoTo ErrHandler
Dim msg As String
If Len(lInData) <> 0 Then
    txtTranslation.Text = lInData
    msg = Parse(lInData, "http://www.altavista.com/web/results", "Search the web with this text")
    If Len(msg) <> 0 Then
        msg = Parse(msg, "style=padding:10px;>", "</div>")
        If Len(msg) <> 0 Then
            msg = Right(msg, Len(msg) - 19)
            txtTranslation.Text = msg
            txtTranslation.Text = Replace(txtTranslation.Text, Chr(10), vbCrLf)
            txtTranslation.Text = Replace(txtTranslation.Text, Chr(13), vbCrLf)
        End If
    End If
    lInData = ""
End If
lSocket.CloseSck
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lSocket_Connect()
On Local Error GoTo ErrHandler
Dim msg2 As String, msg As String
lSocket.Tag = "OPEN"
msg = "http://babelfish.altavista.com/babelfish/tr?urltext=" & Replace(lTextToTranslate, " ", "+") & "&lp=" & lLanguage
Clipboard.Clear
Clipboard.SetText msg
msg2 = "GET " + Right(msg, Len(msg) - Len(lServerURL) - 7) + " HTTP/1.0" + vbCrLf
msg2 = msg2 + "Accept: *.*, */*" + vbCrLf
msg2 = msg2 + "User-Agent: Acidmax - Team Nexgen" & vbCrLf
msg2 = msg2 + "Referer: " & lServerURL & vbCrLf
msg2 = msg2 + "Host: " & lServerURL & vbCrLf
msg2 = msg2 + vbCrLf
lSocket.SendData msg2
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lSocket_DataArrival(ByVal bytesTotal As Long)
On Local Error GoTo ErrHandler
Dim msg As String
lSocket.GetData msg, vbString
If Len(lInData) = 0 Then
    lInData = msg
Else
    lInData = lInData & vbCrLf & msg
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
