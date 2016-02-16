VERSION 5.00
Object = "{35150E64-66A3-439E-8E80-3B7C1B896EB5}#2.0#0"; "RMListView.ocx"
Begin VB.Form frmControlPanel 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   ClientHeight    =   6060
   ClientLeft      =   120
   ClientTop       =   120
   ClientWidth     =   7080
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6060
   ScaleWidth      =   7080
   Begin VB.Timer tmrWatchMircWindow 
      Interval        =   500
      Left            =   3000
      Top             =   2760
   End
   Begin RMListView.ListView lvwControlPanel 
      Height          =   5055
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6960
      _ExtentX        =   12277
      _ExtentY        =   8916
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PictureWidth    =   16
      PictureHeight   =   16
   End
End
Attribute VB_Name = "frmControlPanel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Implements ICustomDraw
Private m_blnCRC32Init As Boolean
Private m_lngCRC32LookUp() As Long

Private Sub Form_Load()
Dim n As Long, b As Boolean, appPath As String, l As Long
appPath = App.Path
If (Right(appPath, 1) <> "\") Then
    appPath = appPath & "\"
End If
SetWindowToChild Me.hWnd
With lvwControlPanel
    .Redraw = True
    .PictureHeight = 32
    .PictureWidth = 32
    .AddColumn "img", " ", TextAlignLeft, 32, True, True
    .AddColumn "des", "Description", TextAlignLeft, 350, True, True
    .BorderStyle = BorderStyleNone
    .ColumnsVisible = True
    .ColumnsAutoSize = False
    'b = .AddPicture(App.Path & "\content\ico\address_book.ico")
    'b = .AddPicture(App.Path & "\content\ico\browser.ico")
    b = .AddPicture(App.Path & "\content\ico\audio.ico")
    'b = .AddPicture(App.Path & "\content\ico\lag_meter.ico")
    'b = .AddPicture(App.Path & "\content\ico\movies.ico")
    'b = .AddPicture(App.Path & "\content\ico\website.ico")
    'l = .AddItem(0, "", 0)
    '.ItemText(l, 1) = "Address Book"
    'l = .AddItem(1, "", 1)
    '.ItemText(l, 1) = "Browser"
    l = .AddItem(0, "", 0)
    .ItemText(l, 1) = "Audio"
    'l = .AddItem(3, "", 3)
    '.ItemText(l, 1) = "Lag Meter"
    'l = .AddItem(4, "", 4)
    '.ItemText(l, 1) = "Movies"
    'l = .AddItem(5, "", 5)
    '.ItemText(l, 1) = "Team Nexgen Website"
End With
Set lvwControlPanel.DrawCallback = Me
Common.SetWindowText Common.lParenthWnd, "Acidmax Control Panel"
End Sub


Private Sub Form_Resize()
lvwControlPanel.Width = Me.ScaleWidth
lvwControlPanel.Height = Me.ScaleHeight
End Sub

Private Function ICustomDraw_CustomDraw(ByVal ItemIndex As Long, ByVal ColumnIndex As Long, BackColor As Long, ForeColor As Long) As Boolean
    Dim blnSelected As Boolean
    Dim lngTag      As Long
    
    ' this mimics a complex Foobar 2000 style
    
    blnSelected = lvwControlPanel.ItemSelected(ItemIndex)
    lngTag = lvwControlPanel.ItemTag(ItemIndex)

    If ColumnIndex = 0 Then
        lvwControlPanel.ItemText(ItemIndex, 0) = CStr(ItemIndex + 1)
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
                BackColor = HSLtoRGB((CRC32(lvwControlPanel.ItemText(ItemIndex, ColumnIndex + 1)) \ 41) Mod 240, 240, 200)
                
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
                BackColor = HSLtoRGB((CRC32(lvwControlPanel.ItemText(ItemIndex, ColumnIndex - 1)) \ 41) Mod 240, 240, 200)
                
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
                ForeColor = HSLtoRGB((CRC32(lvwControlPanel.ItemText(ItemIndex, ColumnIndex)) \ 41) Mod 240, 240, 80)
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
    Dim i As Long
    Dim Index As Long
    If Not m_blnCRC32Init Then CRC32_Init
    For i = 1 To Len(Text)
        Index = (nResult And &HFF) Xor AscW(Mid$(Text, i, 1))
        nResult = (((nResult And &HFFFFFF00) \ &H100) And 16777215) Xor m_lngCRC32LookUp(Index)
    Next i
    CRC32 = Not nResult
End Function

Private Sub lvwControlPanel_DblClick(ByVal ItemIndex As Long)
Select Case lvwControlPanel.ItemText(ItemIndex, 1)
Case "Audio"
    RunAudica
End Select
End Sub

Private Sub tmrWatchMircWindow_Timer()
Dim r As RECT
If Common.GetWindowRect(Common.lParenthWnd, r) Then
    Dim w As Integer, h As Integer
    w = r.Right - r.Left
    h = r.Bottom - r.Top
    Me.Width = w * Screen.TwipsPerPixelX
    Me.Height = h * Screen.TwipsPerPixelY
End If
End Sub
