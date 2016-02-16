VERSION 5.00
Object = "*\A..\listview\RMListView.vbp"
Begin VB.Form frmPlaylist 
   Caption         =   "Playlist"
   ClientHeight    =   4800
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6285
   LinkTopic       =   "Form1"
   ScaleHeight     =   320
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   419
   StartUpPosition =   3  'Windows-Standard
   Begin RMListView.ListView ListView1 
      Height          =   4140
      Left            =   150
      TabIndex        =   1
      Top             =   450
      Width           =   5940
      _ExtentX        =   10478
      _ExtentY        =   7303
      BackColor       =   16777215
      ColumnsAutoSize =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnsVisible  =   0   'False
      PictureWidth    =   16
      PictureHeight   =   16
      ItemsAutoSize   =   0   'False
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "ListView Playlist Demo"
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
      Width           =   2790
   End
   Begin VB.Menu mnuRClick 
      Caption         =   "RClick"
      Visible         =   0   'False
      Begin VB.Menu mnuArtist 
         Caption         =   "Artist:"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuAlbum 
         Caption         =   "Album:"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuTitle 
         Caption         =   "Title:"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuS1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRemItem 
         Caption         =   "remove selected Item(s)"
      End
   End
End
Attribute VB_Name = "frmPlaylist"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Implements ICustomDraw

Private m_lngSel            As Long
Private m_blnCRC32Init      As Boolean
Private m_lngCRC32LookUp()  As Long

Private Sub AddTrack(ByVal strArtist As String, ByVal strAlbum As String, ByVal strTrackNr As String, ByVal strTitle As String, ByVal lngSeconds As Long)
    Dim lngItem As Long
    
    With ListView1
        lngItem = .AddItem()
        .ItemText(lngItem, 3) = strArtist
        .ItemText(lngItem, 4) = strAlbum
        .ItemText(lngItem, 7) = strTrackNr
        .ItemText(lngItem, 8) = strTitle
        .ItemText(lngItem, 10) = FormatSeconds(lngSeconds)
    End With
End Sub

Private Function FormatSeconds(ByVal secs As Long) As String
    FormatSeconds = (secs \ 60) & ":" & Format(secs Mod 60, "00")
End Function

Private Sub Form_Load()
    Dim i   As Long
    
    With ListView1
        .Redraw = False
        .AddColumn "num", "Nummer", TextAlignCenter, 40, False, True
        .AddColumn "stroke1", "-", TextAlignCenter, 1, False, True
        .AddColumn "artbg", "ArtBg", TextAlignCenter, 4, False, True
        .AddColumn "artist", "Künstler", TextAlignLeft, 40, True, True
        .AddColumn "album", "Album", TextAlignRight, 40, True, True
        .AddColumn "albumbg", "AlbumBg", TextAlignCenter, 4, False, True
        .AddColumn "stroke2", "-", TextAlignCenter, 1, False, True
        .AddColumn "trackno", "Track Nummer", TextAlignRight, 25, False, True
        .AddColumn "track", "Track", TextAlignLeft, 70, True, True
        .AddColumn "stroke3", "-", TextAlignCenter, 1, False, True
        .AddColumn "length", "Länge", TextAlignCenter, 40, False, True
    End With
    
    ListView1.BackColor = RGB(240, 240, 240)
    ListView1.FocusRectColor = RGB(142, 217, 253)
    
    Set ListView1.DrawCallback = Me
    
    AddItems
    
    ListView1.Redraw = True
End Sub

Private Sub AddItems()
    Dim i   As Long
    
    For i = 1 To 4
        AddTrack "artist", "His Album", CStr(i), "Track " & Format(i, "00"), 100 + (i * 10) Mod 50
    Next
    
    For i = 1 To 5
        AddTrack "other artist", "Album", CStr(i), "Track " & Format(i, "00"), 100 + (i * 10) Mod 50
    Next
    
    For i = 1 To 7
        AddTrack "anjsnsf", "asdaetwe", CStr(i), "Track " & Format(i, "00"), 100 + (i * 10) Mod 50
    Next
    
    For i = 1 To 15
        AddTrack "total", "egal", CStr(i), "Track " & Format(i, "00"), 100 + (i * 10) Mod 50
    Next
End Sub

Private Sub Form_Resize()
    With ListView1
        If Me.ScaleWidth - .Left * 2 > 0 Then .Width = Me.ScaleWidth - .Left * 2
        If Me.ScaleHeight - (.Top - Label1.Height + 8) * 2 > 0 Then .Height = Me.ScaleHeight - (.Top - Label1.Height + 8) * 2
    End With
End Sub

Private Function ICustomDraw_CustomDraw(ByVal ItemIndex As Long, ByVal ColumnIndex As Long, BackColor As Long, ForeColor As Long) As Boolean
    Dim blnSelected As Boolean
    Dim lngTag      As Long
    
    ' this mimics a complex Foobar 2000 style
    
    blnSelected = ListView1.ItemSelected(ItemIndex)
    lngTag = ListView1.ItemTag(ItemIndex)

    If ColumnIndex = 0 Then
        ListView1.ItemText(ItemIndex, 0) = CStr(ItemIndex + 1)
    End If

    If lngTag = 1 Then
        ForeColor = vbWhite
        BackColor = &H1AAFF
        If blnSelected Then BackColor = &HF9D577
    Else
        ForeColor = &H888888
        If blnSelected Then ForeColor = &HD39725
        
        If ItemIndex Mod 2 Then
            BackColor = &HFAFAFA
            If blnSelected Then BackColor = &HFEECB4
        Else
            BackColor = &HF7F7F7
            If blnSelected Then BackColor = &HFEEFBF
        End If
    End If
    
    Select Case ColumnIndex
    
        ' Index, Length
        Case 0, 10:
            If lngTag = 1 Then
                BackColor = &H19CE8
                If blnSelected Then BackColor = &HEEBF33
            Else
                If ItemIndex Mod 2 Then
                    BackColor = &HE8E8E8
                    If blnSelected Then BackColor = &HF5DEAD
                Else
                    BackColor = &HE5E5E5
                    If blnSelected Then BackColor = &HF8E3BA
                End If
            End If
    
        ' Artist Color
        Case 2:
            If lngTag = 1 Then
                BackColor = &H191D7
                If blnSelected Then BackColor = &HEEBF33
            Else
                BackColor = HSLtoRGB((CRC32(ListView1.ItemText(ItemIndex, ColumnIndex + 1)) \ 41) Mod 240, 240, 200)
                
                If blnSelected Then
                    If ItemIndex Mod 2 Then
                        BackColor = &HF5DEAD
                    Else
                        BackColor = &HF8E3BA
                    End If
                End If
            End If
        
        ' Album Color
        Case 5:
            If lngTag = 1 Then
                BackColor = &H191D7
                If blnSelected Then BackColor = &HEEC139
            Else
                BackColor = HSLtoRGB((CRC32(ListView1.ItemText(ItemIndex, ColumnIndex - 1)) \ 41) Mod 240, 240, 200)
                
                If blnSelected Then
                    If ItemIndex Mod 2 Then
                        BackColor = &HF4D395
                    Else
                        BackColor = &HF4D69D
                    End If
                End If
            End If
    
        ' 1px dividers
        Case 1, 6, 9:
            If lngTag = 1 Then
                BackColor = &H191D7
                If blnSelected Then
                    If ColumnIndex = 6 Then
                        BackColor = &HE0AD12
                    ElseIf ColumnIndex = 1 Or ColumnIndex = 9 Then
                        BackColor = &HEEBF33
                    End If
                End If
            Else
                If ItemIndex Mod 2 Then
                    BackColor = &HD8D8D8
                    If blnSelected Then BackColor = &HF4D395
                Else
                    BackColor = &HD5D5D5
                    If blnSelected Then BackColor = &HF4D69D
                End If
            End If
    
        ' Artist
        Case 3:
            If lngTag <> 1 Then
                ForeColor = HSLtoRGB((CRC32(ListView1.ItemText(ItemIndex, ColumnIndex)) \ 41) Mod 240, 240, 80)
                If blnSelected Then ForeColor = &HD39725
            End If
    
        ' TNO
        Case 7:
            If lngTag <> 1 Then
                ForeColor = &HAAAAAA
                If blnSelected Then ForeColor = &HD39725
            End If
            
    End Select
    
    ICustomDraw_CustomDraw = True
End Function

Private Sub ListView1_DblClick(ByVal ItemIndex As Long)
    Dim i   As Long
    
    ListView1.ItemTag(m_lngSel) = 0
    ListView1.ItemTag(ItemIndex) = 1
    m_lngSel = ItemIndex
End Sub

Private Sub ListView1_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        ListView1.UnSelectAll
        ListView1.ItemSelected(ListView1.SelectedItem) = True
        ListView1_DblClick ListView1.SelectedItem
    End If
End Sub

Private Sub ListView1_MouseUp(ByVal ItemIndex As Long, ByVal MouseButton As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal y As Single)
    If MouseButton = vbRightButton Then
        If ItemIndex > -1 Then
            mnuArtist.Caption = "Artist: " & ListView1.ItemText(ItemIndex, 3)
            mnuAlbum.Caption = "Album: " & ListView1.ItemText(ItemIndex, 4)
            mnuTitle.Caption = "Title: " & ListView1.ItemText(ItemIndex, 8)
        Else
            mnuArtist.Caption = "Artist:"
            mnuAlbum.Caption = "Album:"
            mnuTitle.Caption = "Title:"
        End If
        
        PopupMenu mnuRClick
    End If
End Sub

Private Sub ListView1_Reorder()
    Dim i   As Long
    
    For i = 0 To ListView1.ItemCount - 1
        If ListView1.ItemTag(i) = 1 Then
            m_lngSel = i
            Exit For
        End If
    Next
End Sub

Private Sub mnuRemItem_Click()
    Dim i   As Long
    
    For i = ListView1.ItemCount - 1 To 0 Step -1
        If ListView1.ItemSelected(i) Then
            ListView1.RemoveItem i
            If i = m_lngSel Then m_lngSel = 0
        End If
    Next
End Sub

Public Sub CRC32_Init()
    Const nPolynom = &HEDB88320

    Dim i           As Long
    Dim u           As Long
    Dim lngCRC32    As Long

    If Not m_blnCRC32Init Then
        ReDim m_lngCRC32LookUp(255)
    
        For i = 0 To 255
            lngCRC32 = i
            For u = 0 To 7
                If (lngCRC32 And 1) Then
                    lngCRC32 = (((lngCRC32 And &HFFFFFFFE) \ 2&) And &H7FFFFFFF) Xor nPolynom
                Else
                    lngCRC32 = ((lngCRC32 And &HFFFFFFFE) \ 2&) And &H7FFFFFFF
                End If
            Next u
            m_lngCRC32LookUp(i) = lngCRC32
        Next i
        
        m_blnCRC32Init = True
    End If
End Sub

Public Function CRC32(ByVal Text As String, Optional ByVal nResult As Long = &HFFFFFFFF) As Long
    Dim i       As Long
    Dim index   As Long
  
    If Not m_blnCRC32Init Then CRC32_Init

    For i = 1 To Len(Text)
        index = (nResult And &HFF) Xor AscW(Mid$(Text, i, 1))
        nResult = (((nResult And &HFFFFFF00) \ &H100) And 16777215) Xor m_lngCRC32LookUp(index)
    Next i

    CRC32 = Not nResult
End Function
