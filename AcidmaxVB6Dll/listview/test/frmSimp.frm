VERSION 5.00
Object = "*\A..\listview\RMListView.vbp"
Begin VB.Form frmSimp 
   Caption         =   "Simple listview"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   OLEDropMode     =   1  'Manuell
   ScaleHeight     =   213
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   312
   StartUpPosition =   3  'Windows-Standard
   Begin RMListView.ListView ListView1 
      Height          =   2640
      Left            =   150
      TabIndex        =   1
      Top             =   450
      Width           =   4365
      _ExtentX        =   7699
      _ExtentY        =   4657
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      SolidFocusRect  =   0   'False
      PictureWidth    =   16
      PictureHeight   =   16
      Sortable        =   0   'False
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Simple"
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
      Width           =   825
   End
End
Attribute VB_Name = "frmSimp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Dim i       As Long
    Dim lngIt   As Long
    
    ListView1.Redraw = False
    
    ListView1.AddColumn "col1", "Col 1", TextAlignLeft, 80
    ListView1.AddColumn "col2", "Col 2", TextAlignCenter, 80
    ListView1.AddColumn "col3", "Col 3", TextAlignRight, 80
    
    For i = 1 To 100
        lngIt = ListView1.AddItem(strText:="Item " & i)
        ListView1.ItemText(lngIt, 1) = "Col 2"
        ListView1.ItemText(lngIt, 2) = "Col 3"
    Next
    
    ListView1.Redraw = True
End Sub

Private Sub Form_Resize()
    With ListView1
        If Me.ScaleWidth - .Left * 2 > 0 Then .Width = Me.ScaleWidth - .Left * 2
        If Me.ScaleHeight - (.Top - Label1.Height + 8) * 2 > 0 Then .Height = Me.ScaleHeight - (.Top - Label1.Height + 8) * 2
    End With
End Sub
