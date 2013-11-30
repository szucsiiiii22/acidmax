VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmAddMultipleFiles 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Add File(s)"
   ClientHeight    =   4020
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7695
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmAddMultipleFiles.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4020
   ScaleWidth      =   7695
   StartUpPosition =   1  'CenterOwner
   Begin AcidmaxSendMail.isButton cmdAdd 
      Default         =   -1  'True
      Height          =   345
      Left            =   5760
      TabIndex        =   4
      Top             =   3600
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   609
      Icon            =   "frmAddMultipleFiles.frx":0CCA
      Style           =   2
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
   Begin MSComctlLib.ListView lvwFiles 
      Height          =   3015
      Left            =   3240
      TabIndex        =   3
      Top             =   480
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   5318
      View            =   3
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      Checkboxes      =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   2
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "File"
         Object.Width           =   5292
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "Size"
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   7455
   End
   Begin VB.DirListBox Dir1 
      Height          =   3015
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   3015
   End
   Begin VB.FileListBox File1 
      Height          =   1650
      Left            =   3480
      TabIndex        =   2
      Top             =   1200
      Visible         =   0   'False
      Width           =   2295
   End
   Begin AcidmaxSendMail.isButton cmdExit 
      Cancel          =   -1  'True
      Height          =   345
      Left            =   6720
      TabIndex        =   5
      Top             =   3600
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   609
      Icon            =   "frmAddMultipleFiles.frx":0CE6
      Style           =   2
      Caption         =   "Exit"
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
   Begin AcidmaxSendMail.isButton cmdSelectAll 
      Height          =   345
      Left            =   3240
      TabIndex        =   6
      Top             =   3600
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   609
      Icon            =   "frmAddMultipleFiles.frx":0D02
      Style           =   2
      Caption         =   "Select All "
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
   Begin AcidmaxSendMail.isButton cmdDeselectAll 
      Height          =   345
      Left            =   4440
      TabIndex        =   7
      Top             =   3600
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   609
      Icon            =   "frmAddMultipleFiles.frx":0D1E
      Style           =   2
      Caption         =   "Deselect All"
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
End
Attribute VB_Name = "frmAddMultipleFiles"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAdd_Click()
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 1 To lvwFiles.ListItems.Count
    If lvwFiles.ListItems(i).Checked = True Then AddToFileListView lvwFiles.ListItems(i).Text, Dir1.Path & "\" & lvwFiles.ListItems(i).Text, Format(FileLen(Dir1.Path & "\" & lvwFiles.ListItems(i).Text), "###,###,###")
Next i
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdDeselectAll_Click()
On Local Error Resume Next
Dim i As Integer
For i = 1 To lvwFiles.ListItems.Count
    lvwFiles.ListItems(i).Checked = False
Next i
End Sub

Private Sub cmdExit_Click()
On Local Error GoTo ErrHandler
Unload Me
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdSelectAll_Click()
On Local Error Resume Next
Dim i As Integer
For i = 1 To lvwFiles.ListItems.Count
    lvwFiles.ListItems(i).Checked = True
Next i
End Sub

Private Sub Dir1_Change()
On Local Error Resume Next
File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
On Local Error Resume Next
Dir1.Path = Drive1.Drive
If Err.Number <> 0 Then
    'frmMain.ShowMessage Err.Description, Err.Number
    'MsgBox Err.Description, vbExclamation
    Err.Clear
End If
End Sub

Private Sub File1_PathChange()
On Local Error Resume Next
Dim i As Integer, lItem As ListItem
lvwFiles.ListItems.Clear
For i = 0 To File1.ListCount
    If Len(Trim(File1.List(i))) <> 0 Then
        Set lItem = lvwFiles.ListItems.Add(, , File1.List(i))
        lItem.Checked = True
        lItem.SubItems(1) = Format(FileLen(File1.Path & "\" & File1.List(i)), "###,###,###")
    End If
Next i
End Sub

Private Sub Form_Load()
On Local Error Resume Next
SetAddMultiOpen True
'Me.Icon = frmMain.Icon
Dir1.Path = Drive1.Drive
File1.Path = Dir1.Path
AlwaysOnTop Me, True
End Sub

Private Sub Form_Unload(Cancel As Integer)
SetAddMultiOpen False
End Sub
