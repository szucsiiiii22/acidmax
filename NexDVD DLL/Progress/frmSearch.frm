VERSION 5.00
Begin VB.Form frmSearchDVD 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Please wait ..."
   ClientHeight    =   1845
   ClientLeft      =   3735
   ClientTop       =   5205
   ClientWidth     =   3750
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmSearch.frx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1845
   ScaleWidth      =   3750
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.CommandButton CmdExit 
      Caption         =   "E&xit"
      Height          =   330
      Left            =   2370
      TabIndex        =   3
      Top             =   1440
      Width           =   1275
   End
   Begin VB.TextBox TxtFilters 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   45
      TabIndex        =   1
      Top             =   1095
      Visible         =   0   'False
      Width           =   3600
   End
   Begin VB.TextBox TxtPaths 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   45
      TabIndex        =   0
      Top             =   375
      Width           =   3600
   End
   Begin VB.CommandButton CmdSearch 
      Caption         =   "&Search"
      Default         =   -1  'True
      Height          =   330
      Left            =   960
      TabIndex        =   2
      Top             =   1440
      Width           =   1275
   End
   Begin VB.Label LblFilters 
      Caption         =   "File Filter"
      Height          =   240
      Left            =   45
      TabIndex        =   5
      Top             =   825
      Visible         =   0   'False
      Width           =   6720
   End
   Begin VB.Label LblPaths 
      Caption         =   "Search in Path"
      Height          =   240
      Left            =   45
      TabIndex        =   4
      Top             =   105
      Width           =   6720
   End
End
Attribute VB_Name = "frmSearchDVD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub SearchDiscsNow(lDiscs As String)
On Local Error Resume Next
TxtPaths.Text = lDiscs
CmdSearch_Click
If Err.Number <> 0 Then SetError "SearchDiscsNow", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
LoadDrives
TxtPaths.Text = lDrives.dHardDrives
TxtFilters.Text = "*.vob"
Dim i As Integer
For i = 1 To lDrives.dCount
    frmSearch.SearchDiscsNow lDrives.dDrive(lDrives.dCount).dLetter
Next i
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub CmdSearch_Click()
On Local Error Resume Next
Dim i As Integer, lTmp1 As Long, cCol As tSearch, msg As String, lPath As String
GetSubFiles TxtPaths.Text, TxtFilters.Text, vbDirectory, vbArchive, cCol
For lTmp1 = 1 To cCol.Count
    msg = cCol.Path(lTmp1)
    msg = GetFileTitle(msg)
    If LCase(msg) <> "vts_01_0.vob" And LCase(msg) <> "video_ts.vob" Then
        lPath = Left(cCol.Path(lTmp1), Len(cCol.Path(lTmp1)) - Len(msg))
'        AddRip lPath, App.Path & "\dvd video\", msg
    End If
Next
Unload Me
If Err.Number <> 0 Then SetError "cmdSearch_Click", Err.Description
End Sub

Private Sub cmdExit_Click()
On Local Error Resume Next
Unload Me
If Err.Number <> 0 Then SetError "cmdExit_Click", Err.Description
End Sub

Function sAttr(Attr As VbFileAttribute) As String
On Local Error Resume Next
Dim sStr1 As String
sStr1 = ""
If Attr And vbReadOnly Then sStr1 = "r" Else sStr1 = "-"
If Attr And vbArchive Then sStr1 = sStr1 + "a" Else sStr1 = sStr1 + "-"
If Attr And vbHidden Then sStr1 = sStr1 + "h" Else sStr1 = sStr1 + "-"
If Attr And vbSystem Then sStr1 = sStr1 + "s" Else sStr1 = sStr1 + "-"
sAttr = sStr1
If Err.Number <> 0 Then SetError "sAttr", Err.Description
End Function
