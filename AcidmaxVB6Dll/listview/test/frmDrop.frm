VERSION 5.00
Object = "*\A..\listview\RMListView.vbp"
Begin VB.Form frmDrop 
   Caption         =   "Explorer Drop"
   ClientHeight    =   3660
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5295
   LinkTopic       =   "Form2"
   ScaleHeight     =   244
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   353
   StartUpPosition =   3  'Windows-Standard
   Begin RMListView.ListView ListView1 
      Height          =   2865
      Left            =   150
      TabIndex        =   2
      Top             =   525
      Width           =   4890
      _ExtentX        =   8625
      _ExtentY        =   5054
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      OLEDropMode     =   1
      PictureWidth    =   16
      PictureHeight   =   16
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "drop files on the listview"
      Height          =   195
      Left            =   3000
      TabIndex        =   1
      Top             =   150
      Width           =   1680
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Explorer Drag'n'Drop"
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
      Width           =   2550
   End
End
Attribute VB_Name = "frmDrop"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private m_lngLastDropItem As Long

Private Sub Form_Load()
    Dim i       As Long
    Dim lngIt   As Long
    
    ListView1.AddColumn "col1", "Dateiname", TextAlignLeft, 100
    ListView1.AddColumn "col2", "Pfad", TextAlignCenter, 120
    ListView1.AddColumn "col3", "Größe", TextAlignRight, 50
    
    m_lngLastDropItem = -1
End Sub

Private Sub Form_Resize()
    With ListView1
        If Me.ScaleWidth - .Left * 2 > 0 Then .Width = Me.ScaleWidth - .Left * 2
        If Me.ScaleHeight - (.Top - Label1.Height + 8) * 2 > 0 Then .Height = Me.ScaleHeight - (.Top - Label1.Height + 8) * 2
    End With
End Sub

Private Function GetFilesize(ByVal strFile As String) As Long
    On Error Resume Next
    GetFilesize = FileLen(strFile)
End Function

Private Function GetPath(ByVal strPath As String) As String
    If InStrRev(strPath, "\") > 0 Then
        GetPath = Mid$(strPath, 1, InStrRev(strPath, "\"))
    Else
        GetPath = strPath
    End If
End Function

Private Function GetFilename(ByVal strPath As String) As String
    If InStrRev(strPath, "\") > 0 Then
        GetFilename = Mid$(strPath, InStrRev(strPath, "\") + 1)
    Else
        GetFilename = strPath
    End If
End Function

Private Sub ListView1_OLEDragDrop(Data As DataObject, Effect As Long, MouseButton As Integer, Shift As Integer, X As Single, y As Single)
    Dim i           As Long
    Dim lngItem     As Long
    Dim lngOver     As Long
    
    lngOver = ListView1.RowFromPoint(X, y)
    If ListView1.RowFromPoint(X, y + 4) > lngOver Then lngOver = lngOver + 1
    If lngOver > ListView1.ItemCount - 1 Then lngOver = -1
    If lngOver < 0 Then lngOver = -1
    
    ListView1.Redraw = False
    
    For i = 1 To Data.Files.Count
        lngItem = ListView1.AddItem(lngOver, GetFilename(Data.Files(i)))
        ListView1.ItemText(lngItem, 1) = GetPath(Data.Files(i))
        ListView1.ItemText(lngItem, 2) = GetFilesize(Data.Files(i))
    Next
    
    ListView1.Redraw = True
End Sub

Private Sub ListView1_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, y As Single, state As Integer)
    Dim lngDropItem As Long
    
    ' user is dragging some data over the listview
    '
    ' show where the data would be dropped
    
    lngDropItem = ListView1.RowFromPoint(X, y)
    
    If lngDropItem <> m_lngLastDropItem Then
        If m_lngLastDropItem > -1 Then
            ListView1.ItemSelected(m_lngLastDropItem) = False
            m_lngLastDropItem = lngDropItem
        End If
    End If
    
    If lngDropItem >= 0 And lngDropItem <= ListView1.ItemCount - 1 Then
        ListView1.ItemSelected(lngDropItem) = True
        m_lngLastDropItem = lngDropItem
    Else
        m_lngLastDropItem = -1
    End If
End Sub
