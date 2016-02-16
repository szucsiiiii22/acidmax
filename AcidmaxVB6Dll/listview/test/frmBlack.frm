VERSION 5.00
Object = "*\A..\listview\RMListView.vbp"
Begin VB.Form frmBlack 
   Caption         =   "ListView properties"
   ClientHeight    =   5265
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6405
   LinkTopic       =   "Form2"
   ScaleHeight     =   351
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   427
   Begin RMListView.ListView ListView1 
      Height          =   2415
      Left            =   150
      TabIndex        =   11
      Top             =   450
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   4260
      BackColor       =   0
      ForeColor       =   16777215
      FocusRectColor  =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      CheckboxColor   =   16777215
      PictureWidth    =   16
      PictureHeight   =   16
   End
   Begin VB.PictureBox picOpts 
      Height          =   1290
      Left            =   150
      ScaleHeight     =   1230
      ScaleWidth      =   4380
      TabIndex        =   1
      Top             =   2925
      Width           =   4440
      Begin VB.CheckBox chkItemAutoSize 
         Caption         =   "Item Autosize"
         Height          =   240
         Left            =   75
         TabIndex        =   9
         Top             =   975
         Width           =   1665
      End
      Begin VB.CheckBox chkIcons 
         Caption         =   "Icons"
         Height          =   240
         Left            =   1875
         TabIndex        =   10
         Top             =   750
         Width           =   1515
      End
      Begin VB.CheckBox chkCheckBox 
         Caption         =   "Checkboxes"
         Height          =   195
         Left            =   75
         TabIndex        =   8
         Top             =   750
         Width           =   1590
      End
      Begin VB.CheckBox chkEnabled 
         Caption         =   "Enabled"
         Height          =   240
         Left            =   1875
         TabIndex        =   7
         Top             =   525
         Width           =   1590
      End
      Begin VB.CheckBox chkFocusRect 
         Caption         =   "Solid Focus Rect"
         Height          =   195
         Left            =   75
         TabIndex        =   6
         Top             =   525
         Width           =   1515
      End
      Begin VB.CheckBox chkReorder 
         Caption         =   "Reorder Items"
         Height          =   240
         Left            =   1875
         TabIndex        =   5
         Top             =   300
         Width           =   1590
      End
      Begin VB.CheckBox chkMultiselect 
         Caption         =   "Multiselect"
         Height          =   240
         Left            =   75
         TabIndex        =   4
         Top             =   300
         Width           =   1590
      End
      Begin VB.CheckBox chkColVisible 
         Caption         =   "Columns Visible"
         Height          =   240
         Left            =   1875
         TabIndex        =   3
         Top             =   75
         Width           =   1590
      End
      Begin VB.CheckBox chkAutoSize 
         Caption         =   "Columns Autosize"
         Height          =   240
         Left            =   75
         TabIndex        =   2
         Top             =   75
         Width           =   1590
      End
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Dark ListView Demo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   150
      TabIndex        =   0
      Top             =   75
      Width           =   2475
   End
End
Attribute VB_Name = "frmBlack"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Implements ICustomDraw

Private Const PI    As Double = 3.14159265358979
Private Const PI2   As Double = 2 * PI

Private Sub chkAutoSize_Click()
    ListView1.ColumnsAutoSize = chkAutoSize.Value = 1
End Sub

Private Sub chkCheckBox_Click()
    ListView1.Checkboxes = chkCheckBox.Value = 1
End Sub

Private Sub chkColVisible_Click()
    ListView1.ColumnsVisible = chkColVisible.Value = 1
End Sub

Private Sub chkEnabled_Click()
    ListView1.Enabled = chkEnabled.Value = 1
End Sub

Private Sub chkFocusRect_Click()
    ListView1.SolidFocusRect = chkFocusRect.Value = 1
End Sub

Private Sub chkItemAutoSize_Click()
    ListView1.ItemsAutoSize = chkItemAutoSize.Value = 1
End Sub

Private Sub chkMultiselect_Click()
    ListView1.MultiSelect = chkMultiselect.Value = 1
End Sub

Private Sub chkIcons_Click()
    ListView1.PicturesVisible = chkIcons.Value = 1
End Sub

Private Sub chkReorder_Click()
    ListView1.Reorder = chkReorder.Value = 1
End Sub

Private Sub Form_Load()
    Dim i       As Long
    Dim lngItem As Long
    
    ListView1.Redraw = False
    
    ListView1.AddColumn "col1", "Col 1", TextAlignLeft, 80
    ListView1.AddColumn "col2", "Col 2", TextAlignCenter, 80
    ListView1.AddColumn "col3", "Col 3", TextAlignRight, 80
    
    For i = 1 To 6
        If Not ListView1.AddPicture(App.Path & "\icons\" & i & ".png") Then
            Debug.Print "Konnte PNG " & i & " nicht laden"
        End If
    Next
    
    Set ListView1.DrawCallback = Me
    
    For i = 1 To 100
        With ListView1
            lngItem = .AddItem(, "Item " & CStr(i), Int(Rnd() * 6))
            .ItemText(lngItem, 1) = "Spalte 2"
            .ItemText(lngItem, 2) = "Spalte 3"
        End With
    Next
    
    ListView1.Redraw = True
    
    chkAutoSize.Value = Abs(ListView1.ColumnsAutoSize)
    chkColVisible.Value = Abs(ListView1.ColumnsVisible)
    chkMultiselect.Value = Abs(ListView1.MultiSelect)
    chkReorder.Value = Abs(ListView1.Reorder)
    chkFocusRect.Value = Abs(ListView1.SolidFocusRect)
    chkEnabled.Value = Abs(ListView1.Enabled)
    chkIcons.Value = Abs(ListView1.PicturesVisible)
    chkItemAutoSize.Value = Abs(ListView1.ItemsAutoSize)
End Sub

Private Sub Form_Resize()
    With ListView1
        If Me.ScaleWidth - .Left * 2 > 0 Then .Width = Me.ScaleWidth - .Left * 2
        If Me.ScaleHeight - picOpts.Height - (.Top - Label1.Height + 8) * 2 > 0 Then .Height = Me.ScaleHeight - picOpts.Height - (.Top - Label1.Height + 8) * 2
    End With
    picOpts.Top = ListView1.Top + ListView1.Height + 2
    picOpts.Width = ListView1.Width
End Sub

Private Function ICustomDraw_CustomDraw(ByVal ItemIndex As Long, ByVal ColumnIndex As Long, BackColor As Long, ForeColor As Long) As Boolean
    If Not ListView1.ItemSelected(ItemIndex) Then
        ' wave background
        BackColor = HSLtoRGB(0, 0, Abs(Sin(PI2 * ItemIndex / 20)) * 100)
    Else
        ' simulate a see-through selection
        BackColor = HSLtoRGB(200, 100, Abs(Sin(PI2 * ItemIndex / 20)) * 100 + 50)
    End If
    
    ICustomDraw_CustomDraw = True
End Function
