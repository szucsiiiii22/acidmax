VERSION 5.00
Begin VB.Form frmChooseFiles 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Choose Files"
   ClientHeight    =   3600
   ClientLeft      =   105
   ClientTop       =   300
   ClientWidth     =   2685
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmChooseFiles.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3600
   ScaleWidth      =   2685
   StartUpPosition =   2  'CenterScreen
   Begin DU.ctlListView lvwFiles 
      Height          =   3015
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   2415
      _extentx        =   4260
      _extenty        =   5318
   End
   Begin DU.isButton cmdOK 
      Default         =   -1  'True
      Height          =   300
      Left            =   1800
      TabIndex        =   0
      Top             =   3240
      Width           =   735
      _extentx        =   1296
      _extenty        =   529
      icon            =   "frmChooseFiles.frx":0CCA
      style           =   8
      caption         =   "OK"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmChooseFiles.frx":0CE6
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin DU.isButton cmdSelect 
      Height          =   300
      Left            =   960
      TabIndex        =   2
      Top             =   3240
      Width           =   735
      _extentx        =   1296
      _extenty        =   529
      icon            =   "frmChooseFiles.frx":0D0E
      style           =   8
      caption         =   "All"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmChooseFiles.frx":0D2A
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
   Begin DU.isButton cmdNone 
      Height          =   300
      Left            =   120
      TabIndex        =   3
      Top             =   3240
      Width           =   735
      _extentx        =   1296
      _extenty        =   529
      icon            =   "frmChooseFiles.frx":0D52
      style           =   8
      caption         =   "None"
      inonthemestyle  =   0
      tooltiptitle    =   ""
      tooltipicon     =   0
      tooltiptype     =   1
      ttforecolor     =   0
      font            =   "frmChooseFiles.frx":0D6E
      maskcolor       =   0
      roundedbordersbytheme=   0   'False
   End
End
Attribute VB_Name = "frmChooseFiles"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private lFileList As Integer
Private lFileCount As Integer
Private lFileListCount As Integer

Private Sub cmdNone_Click()
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lvwFiles.Count
    lvwFiles.ItemChecked(i) = False
Next i
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdNone_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdOK_Click()
On Local Error GoTo ErrHandler
Dim i As Integer, n As Integer, msg As String
ClearMainFormFileList
For i = 0 To lvwFiles.Count
    msg = Trim(lvwFiles.ItemText(i))
    n = FindFileIndex(msg)
    If n <> 0 Then
        If lvwFiles.ItemChecked(i) = True Then
            'MsgBox "Item Checked " & msg
            AddToFileList msg, ReturnFileSize(i)
            SetFileNew n, True
        Else
            SetFileNew n, False
        End If
    End If
Next i
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdOK_Click()", Err.Description
    Err.Clear
End Sub

Private Sub cmdSelect_Click()
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lvwFiles.Count
    lvwFiles.ItemChecked(i) = True
Next i
Exit Sub
ErrHandler:
    ProcessError "Private Sub cmdSelect_Click()", Err.Description
    Err.Clear
End Sub

Private Sub Form_Load()
On Local Error GoTo ErrHandler
Dim i As Integer, c As Integer
lvwFiles.Initialize
lvwFiles.BorderStyle = bsThin
lvwFiles.ViewMode = vmDetails
lvwFiles.ColumnAdd 0, "File", 95, [caLeft]
lvwFiles.ColumnAdd 1, "Size", 55, [caLeft]
lvwFiles.Font.Name = "Tahoma"
lvwFiles.FullRowSelect = True
lvwFiles.HeaderFlat = False
lvwFiles.HeaderHide = False
lvwFiles.Font = "Tahoma"
lvwFiles.CheckBoxes = True
c = ReturnFileCount
For i = 0 To c
    If Len(ReturnFileName(i)) <> 0 Then
        AddListView ReturnFileName(i), ReturnFileSize(i), ReturnFileNew(i)
    End If
Next i
Exit Sub
ErrHandler:
    ProcessError "Private Sub Form_Load()", Err.Description
    Err.Clear
End Sub

Public Sub AddListView(lData As String, lSize, lChecked As Boolean)
On Local Error GoTo ErrHandler
Dim i As Integer
With lvwFiles
    lFileListCount = lFileListCount + 1
    .ItemAdd lFileListCount, lData, 0, 0
    For i = 0 To .Count
        If LCase(Trim(.ItemText(i))) = Trim(LCase(lData)) Then
            If lChecked = True Then
                .ItemChecked(i) = True
            Else
                .ItemChecked(i) = False
            End If
            .SubItemSet i, 1, lSize, 0
            Exit For
        End If
    Next i
End With
Exit Sub
ErrHandler:
    ProcessError "Public Sub AddListView(lData As String, lSize, lChecked As Boolean)", Err.Description
    Err.Clear
End Sub