VERSION 5.00
Object = "{EE128208-4F73-11D3-83BB-C47C02EE3D01}#1.0#0"; "ControlResizer.ocx"
Begin VB.Form frmLatestVersionCheck 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Update Check"
   ClientHeight    =   3810
   ClientLeft      =   60
   ClientTop       =   3345
   ClientWidth     =   2880
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmLatestVersionCheck.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   254
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   192
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.CommandButton cmdExit 
      Cancel          =   -1  'True
      Caption         =   "Exit"
      Height          =   255
      Left            =   1920
      TabIndex        =   6
      ToolTipText     =   "Cancel/Hide this window"
      Top             =   3480
      Width           =   855
   End
   Begin VB.CommandButton cmdDownload 
      Caption         =   "Download"
      Default         =   -1  'True
      Enabled         =   0   'False
      Height          =   255
      Left            =   960
      TabIndex        =   5
      ToolTipText     =   "Get this upgrade"
      Top             =   3480
      Width           =   855
   End
   Begin VB.TextBox txtMyVersion 
      BackColor       =   &H00000000&
      Enabled         =   0   'False
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   1440
      TabIndex        =   3
      ToolTipText     =   "The Version you are using"
      Top             =   480
      Width           =   1335
   End
   Begin VB.TextBox txtLatestVersion 
      BackColor       =   &H00000000&
      Enabled         =   0   'False
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   1440
      TabIndex        =   1
      ToolTipText     =   "Latest version of this software available"
      Top             =   120
      Width           =   1335
   End
   Begin ControlResizer.AutoResizer AutoResizer1 
      Height          =   255
      Left            =   1080
      Top             =   2280
      Visible         =   0   'False
      Width           =   495
      _ExtentX        =   873
      _ExtentY        =   450
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   4
      X1              =   0
      X2              =   200
      Y1              =   56
      Y2              =   56
   End
   Begin VB.Line Line3 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   4
      X1              =   0
      X2              =   200
      Y1              =   224
      Y2              =   224
   End
   Begin VB.Label lblInfo 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      ForeColor       =   &H00000000&
      Height          =   2295
      Left            =   120
      TabIndex        =   4
      ToolTipText     =   "Information about the upgrade"
      Top             =   960
      Width           =   2655
   End
   Begin VB.Label Label2 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Your Version:"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   1335
   End
   Begin VB.Label Label1 
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Latest Version:"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "frmLatestVersionCheck"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDownload_Click()
On Local Error Resume Next
Dim msg As String, lini As String
msg = cmdDownload.Tag
If Len(msg) <> 0 Then
    Surf msg
End If
If Err.Number <> 0 Then SetError "cmdDownload_Click()", Err.Description
End Sub

Private Sub cmdExit_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdExit_Click()", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
AlwaysOnTop Me, True
txtMyVersion.Text = App.Major & "." & App.Minor
txtLatestVersion.Text = ReadINI(lINIFiles.iUpdate, "Settings", "Version", "")
If Len(txtLatestVersion.Text) = 0 Then
    Me.Visible = False
    lblInfo.Caption = "Unable to define the latest version, if you are not connected to the internet, connect and try again"
    Exit Sub
End If
If txtMyVersion.Text <> txtLatestVersion.Text Then
    lblInfo.Caption = ReadINI(lINIFiles.iUpdate, "Settings", "Description", "")
    cmdDownload.Tag = ReadINI(lINIFiles.iUpdate, "Settings", "Location", "")
    If Len(cmdDownload.Tag) <> 0 Then
        cmdDownload.Enabled = True
    End If
Else
    lblInfo.Caption = "You are running the latest version of nexDVD"
End If
SetForm True, Me
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
AlwaysOnTop Me, False
SetForm False, Me
frmMain.wskUpdate.Close
If Err.Number <> 0 Then SetError "Form_Unload", Err.Description
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
End Sub

Private Sub Label2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
End Sub

Private Sub lblInfo_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
End Sub

Private Sub picNexENCODE_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
End Sub
