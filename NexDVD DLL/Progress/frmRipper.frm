VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{EE128208-4F73-11D3-83BB-C47C02EE3D01}#1.0#0"; "ControlResizer.ocx"
Begin VB.Form frmRipper 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Ripper"
   ClientHeight    =   3300
   ClientLeft      =   4740
   ClientTop       =   3765
   ClientWidth     =   4845
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmRipper.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3300
   ScaleWidth      =   4845
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Timer tmrProcessDVDRip 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   600
      Top             =   3600
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   735
      Left            =   0
      ScaleHeight     =   735
      ScaleWidth      =   5295
      TabIndex        =   4
      Top             =   2760
      Width           =   5295
      Begin VB.CommandButton cmdCancel 
         Cancel          =   -1  'True
         Caption         =   "&Cancel"
         Height          =   315
         Left            =   120
         TabIndex        =   8
         Top             =   120
         Width           =   855
      End
      Begin VB.CommandButton cmdBack 
         Caption         =   "< &Back"
         Enabled         =   0   'False
         Height          =   315
         Left            =   1800
         TabIndex        =   7
         Top             =   120
         Width           =   835
      End
      Begin VB.CommandButton cmdNext 
         Caption         =   "&Next >"
         Default         =   -1  'True
         Height          =   315
         Left            =   2760
         TabIndex        =   6
         Top             =   120
         Width           =   835
      End
      Begin VB.CommandButton cmdFinish 
         Caption         =   "&Finish"
         Enabled         =   0   'False
         Height          =   315
         Left            =   3840
         TabIndex        =   5
         Top             =   120
         Width           =   855
      End
      Begin VB.Line Line3 
         X1              =   1080
         X2              =   1080
         Y1              =   720
         Y2              =   0
      End
      Begin VB.Line Line2 
         X1              =   3720
         X2              =   3720
         Y1              =   720
         Y2              =   0
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   4
         X1              =   0
         X2              =   4920
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.PictureBox ctlRipper 
      Height          =   375
      Left            =   120
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   21
      Top             =   3600
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 1 - Welcome"
      Height          =   2655
      Index           =   1
      Left            =   0
      TabIndex        =   0
      Top             =   -120
      Visible         =   0   'False
      Width           =   4935
      Begin ControlResizer.AutoResizer AutoResizer1 
         Height          =   375
         Left            =   1200
         Top             =   1560
         Visible         =   0   'False
         Width           =   375
         _ExtentX        =   661
         _ExtentY        =   661
      End
      Begin VB.Image Image4 
         Height          =   1605
         Left            =   3240
         Picture         =   "frmRipper.frx":0CCA
         Top             =   960
         Width           =   1500
      End
      Begin VB.Label lblMessage 
         Caption         =   $"frmRipper.frx":2313
         Height          =   1095
         Left            =   720
         TabIndex        =   1
         Top             =   240
         Width           =   3975
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":23FE
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 3 - Select Files"
      Height          =   2655
      Index           =   3
      Left            =   0
      TabIndex        =   2
      Top             =   -120
      Visible         =   0   'False
      Width           =   4815
      Begin VB.CommandButton cmdNewDir 
         Caption         =   "New"
         Height          =   315
         Left            =   720
         TabIndex        =   30
         Top             =   1850
         Width           =   855
      End
      Begin VB.TextBox txtDVDName 
         BackColor       =   &H00000000&
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   1680
         TabIndex        =   24
         Top             =   840
         Width           =   3015
      End
      Begin VB.DriveListBox Drive1 
         BackColor       =   &H00000000&
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   1680
         TabIndex        =   23
         Top             =   2280
         Width           =   3015
      End
      Begin VB.DirListBox Dir1 
         BackColor       =   &H00000000&
         ForeColor       =   &H00FFFFFF&
         Height          =   990
         Left            =   1680
         TabIndex        =   22
         Top             =   1200
         Width           =   3015
      End
      Begin VB.Label Label7 
         Caption         =   "Destination:"
         Height          =   255
         Left            =   720
         TabIndex        =   29
         Top             =   1200
         Width           =   1335
      End
      Begin VB.Label lblDVDName 
         Caption         =   "Name:"
         Height          =   255
         Left            =   720
         TabIndex        =   25
         Top             =   840
         Width           =   1935
      End
      Begin VB.Label Label1 
         Caption         =   "Select name and location of DVD"
         Height          =   615
         Left            =   720
         TabIndex        =   3
         Top             =   240
         Width           =   4095
      End
      Begin VB.Image Image2 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":30C8
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 2 - Search for Files"
      Height          =   2655
      Index           =   2
      Left            =   0
      TabIndex        =   10
      Top             =   -120
      Visible         =   0   'False
      Width           =   4815
      Begin VB.Image imgSearch 
         Height          =   1605
         Left            =   3240
         Picture         =   "frmRipper.frx":3D92
         Top             =   960
         Width           =   1500
      End
      Begin VB.Label lblSearch 
         Caption         =   $"frmRipper.frx":5419
         Height          =   1095
         Left            =   720
         TabIndex        =   11
         Top             =   240
         Width           =   3615
      End
      Begin VB.Image Image3 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":54F4
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 5 - Copy progress"
      Height          =   2655
      Index           =   7
      Left            =   0
      TabIndex        =   18
      Top             =   -120
      Visible         =   0   'False
      Width           =   4815
      Begin VB.Image Image8 
         Height          =   1605
         Left            =   3240
         Picture         =   "frmRipper.frx":61BE
         Top             =   960
         Width           =   1500
      End
      Begin VB.Label Label6 
         Caption         =   "DVD Copy complete"
         Height          =   615
         Left            =   720
         TabIndex        =   19
         Top             =   240
         Width           =   4095
      End
      Begin VB.Image Image7 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":7807
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 5 - Copy progress"
      Height          =   2655
      Index           =   5
      Left            =   0
      TabIndex        =   31
      Top             =   -120
      Visible         =   0   'False
      Width           =   4815
      Begin VB.Image Image10 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":84D1
         Top             =   240
         Width           =   480
      End
      Begin VB.Label Label8 
         Caption         =   "Ready to copy file(s), click 'Next' to proceed"
         Height          =   615
         Left            =   720
         TabIndex        =   32
         Top             =   240
         Width           =   4095
      End
      Begin VB.Image Image9 
         Height          =   1605
         Left            =   3240
         Picture         =   "frmRipper.frx":919B
         Top             =   960
         Width           =   1500
      End
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 5 - Copy progress"
      Height          =   2655
      Index           =   6
      Left            =   0
      TabIndex        =   14
      Top             =   -120
      Visible         =   0   'False
      Width           =   4815
      Begin VB.CommandButton cmdSkip 
         Caption         =   "Skip"
         Height          =   315
         Left            =   1080
         TabIndex        =   38
         Top             =   2280
         Width           =   855
      End
      Begin VB.CommandButton cmdStopRip 
         Caption         =   "Stop"
         Height          =   315
         Left            =   120
         TabIndex        =   37
         Top             =   2280
         Width           =   855
      End
      Begin MSComctlLib.ProgressBar ProgressBar 
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   1800
         Width           =   4575
         _ExtentX        =   8070
         _ExtentY        =   661
         _Version        =   393216
         Appearance      =   0
      End
      Begin VB.Label lblFilename 
         Caption         =   "-"
         Height          =   255
         Left            =   2280
         TabIndex        =   36
         Top             =   840
         Width           =   2415
      End
      Begin VB.Label Label10 
         Caption         =   "Filename:"
         Height          =   255
         Left            =   120
         TabIndex        =   35
         Top             =   840
         Width           =   2055
      End
      Begin VB.Label lblKeys 
         Caption         =   "-"
         Height          =   255
         Left            =   2280
         TabIndex        =   34
         Top             =   1080
         Width           =   2415
      End
      Begin VB.Label Label9 
         Caption         =   "Keys:"
         Height          =   255
         Left            =   120
         TabIndex        =   33
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label Label5 
         Caption         =   "Status:"
         Height          =   255
         Left            =   120
         TabIndex        =   28
         Top             =   1560
         Width           =   2055
      End
      Begin VB.Label Label2 
         Caption         =   "Time Left:"
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   1320
         Width           =   2055
      End
      Begin VB.Label lblTimeLeft 
         Caption         =   "-"
         Height          =   255
         Left            =   2280
         TabIndex        =   20
         Top             =   1320
         Width           =   2415
      End
      Begin VB.Label lblCopyStatus 
         Caption         =   "-"
         Height          =   255
         Left            =   2280
         TabIndex        =   17
         Top             =   1560
         Width           =   2415
      End
      Begin VB.Label Label4 
         Caption         =   "Copying DVD files, please wait ..."
         Height          =   615
         Left            =   720
         TabIndex        =   15
         Top             =   240
         Width           =   4095
      End
      Begin VB.Image Image6 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":A7E4
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Frame fraWizard 
      BorderStyle     =   0  'None
      Caption         =   "Step 4 - Select settings"
      Height          =   2655
      Index           =   4
      Left            =   0
      TabIndex        =   12
      Top             =   -120
      Visible         =   0   'False
      Width           =   4815
      Begin VB.ListBox lstFiles 
         BackColor       =   &H00000000&
         ForeColor       =   &H00FFFFFF&
         Height          =   1860
         Left            =   720
         Style           =   1  'Checkbox
         TabIndex        =   26
         Top             =   720
         Width           =   3975
      End
      Begin VB.Image Image5 
         Height          =   480
         Left            =   120
         Picture         =   "frmRipper.frx":B4AE
         Top             =   240
         Width           =   480
      End
      Begin VB.Label Label3 
         Caption         =   "Select the file(s) you wish to copy"
         Height          =   615
         Left            =   720
         TabIndex        =   13
         Top             =   240
         Width           =   4095
      End
   End
   Begin VB.Image imgSearch2 
      Height          =   1605
      Left            =   0
      Picture         =   "frmRipper.frx":C178
      Top             =   0
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Image imgSearch1 
      Height          =   1605
      Left            =   0
      Picture         =   "frmRipper.frx":D808
      Top             =   0
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Label lblStep 
      Caption         =   "Wizard not started"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   2520
      Width           =   4095
   End
End
Attribute VB_Name = "frmRipper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Sub ShowWizFinish()
On Local Error Resume Next
cmdNext_Click
If Err.Number <> 0 Then SetError "ShowWizFinish()", Err.Description
End Sub

Private Sub cmdBack_Click()
On Local Error Resume Next
Dim i As Integer
For i = 1 To fraWizard.Count
    fraWizard(i).Visible = False
Next i
lFrame = lFrame - 1
If lFrame = 1 Then
    cmdBack.Enabled = False
    fraWizard(lFrame).Visible = True
Else
    fraWizard(lFrame).Visible = True
End If
If Err.Number <> 0 Then SetError "cmdCancel_Click()", Err.Description
End Sub

Private Sub cmdCancel_Click()
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
If lWizardFiles.wBusy = True Then
    mbox = MsgBox("Caution! Ripper is busy, ending it suddenly could cause program errors. Are you sure you wish to do this?", vbYesNo + vbExclamation)
    If mbox = vbYes Then
        ctlRipper.Stop
        Unload Me
        Exit Sub
    Else
        Exit Sub
    End If
Else
    Unload Me
End If
If Err.Number <> 0 Then SetError "cmdCancel_Click()", Err.Description
End Sub

Private Sub cmdFinish_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdFinish_Click()", Err.Description
End Sub

Private Sub cmdNewDir_Click()
On Local Error Resume Next
Dim msg As String
msg = InputBox("Enter path:", "New Directory", Dir1.Path)
If Len(msg) <> 0 Then
    MakeDir msg
    Dir1.Path = msg
End If
If Err.Number <> 0 Then SetError "cmdNewDir_Click()", Err.Description
End Sub

Private Sub cmdNext_Click()
On Local Error Resume Next
Dim i As Integer, msg As String, f As Integer, msg2 As String
For i = 1 To fraWizard.Count
    fraWizard(i).Visible = False
Next i
lFrame = lFrame + 1
If lFrame = 7 Then
    lblStep.Caption = "Step 7 of 7: Copy Complete"
    cmdFinish.Enabled = True
    fraWizard(7).Visible = True
ElseIf lFrame = 0 Then
    lFrame = 1
    fraWizard(1).Visible = True
Else
    fraWizard(lFrame).Visible = True
    cmdBack.Enabled = True
    Select Case lFrame
    Case 1
        lblStep.Caption = "Step 1 of 7: Welcome"
    Case 2
        lblStep.Caption = "Step 2 of 7: Search"
        frmSearch.Show 1
        imgSearch.Picture = imgSearch2.Picture
        lblSearch.Caption = "Done searching, click 'Next'"
    Case 3
        lblStep.Caption = "Step 3 of 7: Input Name and location of dvd"
        txtDVDName.Text = LCase(lPlayer.pTitle)
        If Len(txtDVDName.Text) <> 0 Then
            msg = App.Path & "\" & txtDVDName.Text
            If DoesDirExist(msg) = False Then MakeDir msg
        Else
            msg = App.Path & "\dvd video\"
            If DoesDirExist(msg) = False Then MakeDir msg
            txtDVDName.Text = "dvd video"
        End If
        Drive1.Drive = Left(msg, 1)
        DoEvents
        Dir1.Path = msg
    Case 4
        lblStep.Caption = "Step 4 of 7: Select File(s)"
        If Len(txtDVDName.Text) = 0 Then
            cmdBack_Click
            MsgBox "Please select a name", vbExclamation
            txtDVDName.SetFocus
            Exit Sub
        Else
            lWizardFiles.wPath = Dir1.Path & "\"
            lWizardFiles.wDescription = txtDVDName.Text
            For f = 1 To lWizardFiles.wCount
                With lWizardFiles.wFile(f)
                    .wDestinationPath = lWizardFiles.wPath
                    lstFiles.AddItem .wFile
                End With
            Next f
        End If
    Case 5
        Dim bool As Boolean
        For f = 1 To lWizardFiles.wCount
            If lWizardFiles.wFile(f).wEnabled = True Then bool = True
        Next f
        If bool = False Then
            cmdBack_Click
            MsgBox "You must select at least one file", vbExclamation
            Exit Sub
        End If
        lblStep.Caption = "Step 5 of 7: Ready to copy"
    Case 6
        lblStep.Caption = "Step 6 of 7: Copy Files"
        tmrProcessDVDRip.Enabled = True
    Case 7
        lblStep.Caption = "Step 7 of 7: Copy Complete"
    End Select
End If
If Err.Number <> 0 Then SetError "cmdNext_Click()", Err.Description
End Sub

Private Sub cmdSkip_Click()
On Local Error Resume Next
ctlRipper.Stop
lblTimeLeft.Caption = "-"
lblFilename.Caption = "-"
lblCopyStatus.Caption = "-"
lblKeys.Caption = "-"
ProgressBar.Value = 0
tmrProcessDVDRip.Enabled = True
If Err.Number <> 0 Then SetError "cmdSkip_Click()", Err.Description
End Sub

Private Sub cmdStopRip_Click()
On Local Error Resume Next
tmrProcessDVDRip.Enabled = False
ctlRipper.Stop
lblTimeLeft.Caption = "-"
lblFilename.Caption = "-"
lblCopyStatus.Caption = "-"
lblKeys.Caption = "-"
ProgressBar.Value = 0
If Err.Number <> 0 Then SetError "cmdStopRip_Click", Err.Description
End Sub

Private Sub ctlRipper_PercentDone(ByVal nPercent As Double)
On Local Error Resume Next
lblCopyStatus.Caption = Format(nPercent, "00") & " %"
ProgressBar.Value = nPercent
If Err.Number <> 0 Then SetError "ctlRipper_PercentDone()", Err.Description
End Sub

Private Sub ctlRipper_RegKeys(ByVal nReg As Long)
On Local Error Resume Next
'lblTimeLeft.Caption = Format(nReg, "00") & " keys found"
lblKeys.Caption = Format(nReg, "00") & " found"
If nReg = 20 Then
    lblKeys.Caption = "-"
    lblCopyStatus.Caption = "Begining copy ..."
    'lblTimeLeft.Caption = ""
End If
End Sub

Private Sub ctlRipper_TimeLeft(ByVal nTime As Double)
On Local Error Resume Next
If Format(nTime, "000.0") > 99 Then lWizardFiles.wTimeLeft = Format(Format(nTime, "000.00") / 60, "000.00")
If Format(nTime, "000.0") > 9.9 Then lWizardFiles.wTimeLeft = Format(Format(nTime, "00.00") / 60, "00.00")
If Format(nTime, "000.0") < 9.9 Then lWizardFiles.wTimeLeft = Format(nTime, "0.00")
If LCase(lWizardFiles.wTimeLeft) <> lblTimeLeft.Caption Then lblTimeLeft.Caption = lWizardFiles.wTimeLeft
If ProgressBar.Value = 100 Then
    ProgressBar.Value = 0
    'ctlRipper.Stop
    lblKeys.Caption = "-"
    lblFilename.Caption = "-"
    lblTimeLeft.Caption = "-"
    lblCopyStatus.Caption = "-"
    lWizardFiles.wBusy = False
    tmrProcessDVDRip.Enabled = True
End If
If Err.Number <> 0 Then SetError "DeDVD1_TimeLeft", Err.Description
End Sub

Private Sub ctlRipper_TotalKeysFound(ByVal nKeys As Long)
On Local Error Resume Next
'lblCopyStatus.Caption = Format(nKeys, "00") & " of 20 keys Found"
End Sub

Private Sub Drive1_Change()
On Local Error Resume Next
Dir1.Path = Drive1.Drive
If Err.Number <> 0 Then SetError "Drive1_Change", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
frmMain.Visible = False

'If lSettings.sUseDVDInterface = True Then frmInterface.Visible = False
If lWizardFiles.wCount <> 0 Then
    Dim i As Integer
    For i = 1 To lWizardFiles.wCount
        lWizardFiles.wFile(i).wDestinationPath = ""
        lWizardFiles.wFile(i).wEnabled = False
        lWizardFiles.wFile(i).wPath = ""
        lWizardFiles.wFile(i).wFile = ""
    Next i
    lWizardFiles.wCount = 0
End If
lWizardFiles.wDescription = ""
lWizardFiles.wPath = ""
If Len(lPlayer.pTitle) = 0 Then lPlayer.pTitle = "DVD Video"
lFrame = 0
cmdNext_Click
SetForm True, Me
AlwaysOnTop Me, True
If Err.Number <> 0 Then SetError "Form_Load()", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
frmMain.Visible = True
'If lSettings.sUseDVDInterface = True Then frmInterface.Visible = True
SetForm False, Me
AlwaysOnTop Me, False
If Err.Number <> 0 Then SetError "Form_Unload()", Err.Description
End Sub

Private Sub lstFiles_ItemCheck(Item As Integer)
On Local Error Resume Next
Dim msg As String, i As Integer
msg = lstFiles.List(Item)
i = FindFileIndex(msg)
If i <> 0 Then
    If lWizardFiles.wFile(i).wEnabled = True Then
        lWizardFiles.wFile(i).wEnabled = False
    Else
        lWizardFiles.wFile(i).wEnabled = True
    End If
End If
If Err.Number <> 0 Then SetError "Form_Unload()", Err.Description
End Sub

Private Sub tmrProcessDVDRip_Timer()
On Local Error Resume Next
If lWizardFiles.wBusy = False Then
    ProcessNextRip
Else
    tmrProcessDVDRip.Enabled = False
End If
If Err.Number <> 0 Then SetError "tmrProcessDVDRip_Timer()", Err.Description
End Sub
