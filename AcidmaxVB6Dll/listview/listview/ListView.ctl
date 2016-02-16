VERSION 5.00
Begin VB.UserControl ListView 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   240
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   320
   Begin VB.Timer tmrMove 
      Enabled         =   0   'False
      Interval        =   15
      Left            =   1200
      Top             =   2325
   End
End
Attribute VB_Name = "ListView"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Implements ICustomDraw


Public Event Reorder()

Public Event DblClick(ByVal ItemIndex As Long)
Public Event Click(ByVal ItemIndex As Long)

Public Event ColumnClick(ByVal ColumnIndex As Long)

Public Event MouseDown( _
    ByVal ItemIndex As Long, _
    ByVal MouseButton As Integer, ByVal Shift As Integer, _
    ByVal X As Single, ByVal Y As Single _
)

Public Event MouseUp( _
    ByVal ItemIndex As Long, _
    ByVal MouseButton As Integer, ByVal Shift As Integer, _
    ByVal X As Single, ByVal Y As Single _
)

Public Event KeyDown(KeyCode As Integer, Shift As Integer)
Public Event KeyUp(KeyCode As Integer, Shift As Integer)
Public Event KeyPress(KeyAscii As Integer)
Public Event ItemCheck(ByVal ItemIndex As Long)

Public Event OLEDragDrop( _
    Data As DataObject, Effect As Long, _
    MouseButton As Integer, Shift As Integer, _
    X As Single, Y As Single _
)

Public Event OLEDragOver( _
    Data As DataObject, Effect As Long, _
    Button As Integer, Shift As Integer, _
    X As Single, Y As Single, state As Integer _
)

Public Event OLECompleteDrag(Effect As Long)
Public Event OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)
Public Event OLESetData(Data As DataObject, DataFormat As Integer)
Public Event OLEStartDrag(Data As DataObject, AllowedEffects As Long)


Private WithEvents m_clsSB      As Scrollbars
Attribute m_clsSB.VB_VarHelpID = -1


Public Enum SortOrderConstants
    SortAscending
    SortDescending
End Enum

Public Enum OLEDropModeConstants
    OLEDropNone
    OLEDropManual
End Enum

Public Enum TextAlignConstants
    TextAlignLeft
    TextAlignRight
    TextAlignCenter
End Enum

Public Enum LVBorderStyleConstants
    BorderStyleNone
    BorderStyleThin
    BorderStyleThick
End Enum

Private Enum MouseOverBehaviour
    MouseOverFree
    MouseOverResizeColumn
    MouseOverMultiselect
    MouseOverReorder
    MouseOverColumnClick
End Enum

Private m_lngPaddingTop         As Long
Private m_lngPaddingBottom      As Long
Private m_lngPaddingLeft        As Long
Private m_lngPaddingRight       As Long

Private m_lngPictureHeight      As Long
Private m_lngPictureWidth       As Long
Private m_blnShowPictures       As Boolean

Private WithEvents m_clsFont    As StdFont
Attribute m_clsFont.VB_VarHelpID = -1
Private m_lngFontHeight         As Long
Private m_hFont                 As Long

Private m_udeMouseOver          As MouseOverBehaviour
Private m_lngColumnResize       As Long
Private m_blnMultiSelRem        As Boolean
Private m_blnItemDragged        As Boolean
Private m_lngMultiSelStart      As Long

Private m_clsBackColor          As Color
Private m_clsForeColor          As Color
Private m_clsSelectedBackColor  As Color
Private m_clsSelectedForeColor  As Color
Private m_clsFocusRectColor     As Color
Private m_clsCustBGColor        As Color
Private m_clsCustFGColor        As Color
Private m_clsCheckBoxColor      As Color
Private m_clsCheckBoxSelColor   As Color

Private m_udeBorderStyle        As LVBorderStyleConstants
Private m_blnReorder            As Boolean
Private m_blnMultiSelect        As Boolean
Private m_blnColumnsAutoSize    As Boolean
Private m_blnColumnsVisible     As Boolean
Private m_blnEnabled            As Boolean
Private m_blnSolidFocusRect     As Boolean
Private m_blnGotFocus           As Boolean
Private m_blnCheckBoxes         As Boolean
Private m_blnSortable           As Boolean

Private m_colColumns            As ColumnCollection
Private m_clsItems              As ListItemCollection

Private m_hDCBack               As Long
Private m_hDCBackBmp            As Long
Private m_hDCBackOldBmp         As Long
Private m_hOldFont              As Long
Private m_hOldPen               As Long

Private m_udtUCRect             As RECT     ' User Control Rect
Private m_udtCLRect             As RECT     ' Columns Rect
Private m_udtITRect             As RECT     ' Items Rect

Private m_lngSelItemIndex       As Long
Private m_lngColumnsWidth       As Long

Private m_clsCustDrawCB         As ICustomDraw
Private m_blnRedraw             As Boolean

Private m_clsPictures()         As c32bppDIB
Private m_lngPictureCount       As Long

Private m_blnItemAutoSize       As Boolean

Private Const IMG_LEFT          As Long = 2
Private Const IMG_PAD_RIGHT     As Long = 3

Private Const CHECKBOX_HEIGHT   As Long = 12
Private Const CHECKBOX_WIDTH    As Long = 12
Private Const CHECKBOX_MARGIN   As Long = 3


Public Property Get PictureCount() As Long
    PictureCount = m_lngPictureCount
End Property

Public Function AddPictureFromRes(ByVal ResIndex As Variant, ByVal resSection As Variant) As Boolean
    ReDim Preserve m_clsPictures(m_lngPictureCount) As c32bppDIB
    Set m_clsPictures(m_lngPictureCount) = New c32bppDIB
    
    With m_clsPictures(m_lngPictureCount)
        .Alpha = True
        .HighQualityInterpolation = False   ' true would be extremly slow, but also very beautiful
        AddPictureFromRes = .LoadPicture_Resource(ResIndex, resSection, , m_lngPictureWidth, m_lngPictureHeight)
    End With
    
    m_lngPictureCount = m_lngPictureCount + 1
End Function

Public Function AddPicture(ByVal strFilename As String) As Boolean
    ReDim Preserve m_clsPictures(m_lngPictureCount) As c32bppDIB
    Set m_clsPictures(m_lngPictureCount) = New c32bppDIB
    
    With m_clsPictures(m_lngPictureCount)
        .Alpha = True
        .HighQualityInterpolation = False   ' true would be extremly slow, but also very beautiful
        AddPicture = .LoadPicture_File(strFilename, m_lngPictureWidth, m_lngPictureHeight)
    End With
        
    m_lngPictureCount = m_lngPictureCount + 1
End Function


Public Property Get SelectedItem() As Long
Attribute SelectedItem.VB_MemberFlags = "400"
    SelectedItem = m_lngSelItemIndex
End Property

Public Property Let SelectedItem(ByVal lngVal As Long)
    m_lngSelItemIndex = lngVal
    DrawListView
End Property

Public Property Get ItemCount() As Long
    ItemCount = m_clsItems.ItemCount
End Property

Public Property Get ItemTag(ByVal Index As Long) As Long
    ItemTag = m_clsItems.Item(Index).Tag
End Property

Public Property Let ItemTag(ByVal Index As Long, ByVal lngTag As Long)
    m_clsItems.Item(Index).Tag = lngTag
    DrawListView
End Property

Public Property Get ItemSelected(ByVal Index As Long) As Boolean
    ItemSelected = m_clsItems.Item(Index).Selected
End Property

Public Property Let ItemSelected(ByVal Index As Long, ByVal blnVal As Boolean)
    m_clsItems.Item(Index).Selected = blnVal
    DrawListView
End Property

Public Property Get ItemText(ByVal Index As Long, ByVal Column As Long) As String
    ItemText = m_clsItems.Item(Index).Text(Column)
End Property

Public Property Let ItemText(ByVal Index As Long, ByVal Column As Long, ByVal strText As String)
    m_clsItems.Item(Index).Text(Column) = strText
    DrawListView
End Property

Public Property Get ItemChecked(ByVal Index As Long) As Boolean
    ItemChecked = m_clsItems.Item(Index).Checked
End Property

Public Property Let ItemChecked(ByVal Index As Long, ByVal blnVal As Boolean)
    m_clsItems.Item(Index).Checked = blnVal
    DrawListView
End Property

Public Function AddItem(Optional InsertAt As Long = -1, Optional ByVal strText As String, Optional ByVal lngPictureIndex As Long = -1) As Long
    If m_colColumns.Count = 0 Then
        Err.Raise 31, , "can not add items when there are no columns"
    End If
    
    With m_clsItems.AddItem(InsertAt)
        .Text(0) = strText
        .PictureIndex = lngPictureIndex
    End With
    
    If InsertAt <= m_lngSelItemIndex And InsertAt > -1 Then
        m_lngSelItemIndex = m_lngSelItemIndex + 1
    End If
    
    If InsertAt > -1 Then
        AddItem = InsertAt
    Else
        AddItem = m_clsItems.ItemCount - 1
    End If
    
    UpdateVScroll
    DrawListView
End Function

Public Sub RemoveItem(ByVal Index As Long)
    m_clsItems.RemoveItem Index
    
    If m_lngSelItemIndex > Index Then
        m_lngSelItemIndex = m_lngSelItemIndex - 1
        If m_lngSelItemIndex < 0 Then
            If m_clsItems.ItemCount > 0 Then
                m_lngSelItemIndex = 0
            End If
        End If
    End If
    
    If m_lngSelItemIndex > m_clsItems.ItemCount - 1 Then
        m_lngSelItemIndex = m_clsItems.ItemCount - 1
    End If
    
    UpdateVScroll
    DrawListView
End Sub

Public Sub MoveItem(ByVal IndexFrom As Long, ByVal IndexTo As Long)
    m_clsItems.MoveItem IndexFrom, IndexTo
    DrawListView
End Sub

Public Sub Clear()
    m_clsItems.Clear
    m_lngSelItemIndex = -1
    DrawListView
End Sub


Public Property Get ColumnIndex(Index) As Long
    Dim i   As Long
    
    For i = 0 To ColumnCount - 1
        If Index = ColumnKey(i) Then
            ColumnIndex = i
        End If
    Next
End Property

Public Sub RemoveColumn(Index)
    If m_clsItems.ItemCount > 0 Then
        Err.Raise 33, , "can not add or remove columns when there are items"
    End If
    
    m_colColumns.Remove Index
    Refresh
End Sub

Public Sub AddColumn( _
    Optional ByVal key As String = vbNullString, _
    Optional ByVal Caption As String = vbNullString, _
    Optional ByVal TextAlign As TextAlignConstants = TextAlignLeft, _
    Optional ByVal Width As Long = 300, _
    Optional ByVal Resizable As Boolean = True, _
    Optional ByVal Visible As Boolean = True _
)

    Dim clsColumn   As Column
    Set clsColumn = New Column
    
    If m_clsItems.ItemCount > 0 Then
        Err.Raise 33, , "can not add or remove columns when there are items"
    End If
    
    With m_colColumns.Add(key)
        .Caption = Caption
        .TextAlign = TextAlign
        .Width = Width
        .Resizable = Resizable
        .Visible = Visible
    End With
    
    m_clsItems.ColumnCount = m_colColumns.Count
    
    Refresh
End Sub

Public Property Get ColumnCount() As Long
    ColumnCount = m_colColumns.Count
End Property

Public Property Get ColumnKey(Index) As String
    ColumnKey = m_colColumns.Item(Index).key
End Property

Public Property Get ColumnsVisible() As Boolean
    ColumnsVisible = m_blnColumnsVisible
End Property

Public Property Let ColumnsVisible(ByVal blnVal As Boolean)
    m_blnColumnsVisible = blnVal
    Refresh
    PropertyChanged "ColumnsVisible"
End Property

Public Property Get ColumnVisible(Index) As Boolean
    ColumnVisible = m_colColumns.Item(Index).Visible
End Property

Public Property Let ColumnVisible(Index, ByVal blnVis As Boolean)
    m_colColumns.Item(Index).Visible = blnVis
    Refresh
End Property

Public Property Get ColumnCaption(Index) As String
    ColumnCaption = m_colColumns.Item(Index).Caption
End Property

Public Property Let ColumnCaption(Index, ByVal strCaption As String)
    m_colColumns.Item(Index).Caption = strCaption
    DrawListView
End Property

Public Property Get ColumnWidth(Index) As Long
    ColumnWidth = m_colColumns.Item(Index).Width
End Property

Public Property Let ColumnWidth(Index, ByVal lngWidth As Long)
    m_colColumns.Item(Index).Width = lngWidth
    Refresh
End Property

Public Property Get ColumnResizable(Index) As Boolean
    ColumnResizable = m_colColumns.Item(Index).Resizable
End Property

Public Property Let ColumnResizable(Index, ByVal blnRes As Boolean)
    m_colColumns.Item(Index).Resizable = blnRes
    Refresh
End Property

Public Property Get ColumnTextAlign(Index) As TextAlignConstants
    ColumnTextAlign = m_colColumns.Item(Index).TextAlign
End Property

Public Property Let ColumnTextAlign(Index, ByVal udeAlign As TextAlignConstants)
    m_colColumns.Item(Index).TextAlign = udeAlign
    DrawListView
End Property


' ************************************************
' *** Einstellungen                            ***
' ************************************************

Public Property Get Sortable() As Boolean
    Sortable = m_blnSortable
End Property

Public Property Let Sortable(ByVal blnVal As Boolean)
    m_blnSortable = blnVal
    PropertyChanged "Sortable"
End Property

Public Property Get ItemsAutoSize() As Boolean
    ItemsAutoSize = m_blnItemAutoSize
End Property

Public Property Let ItemsAutoSize(ByVal blnVal As Boolean)
    m_blnItemAutoSize = blnVal
    DrawListView
    PropertyChanged "ItemsAutoSize"
End Property

Public Property Get PictureHeight() As Long
    PictureHeight = m_lngPictureHeight
End Property

Public Property Let PictureHeight(ByVal lngVal As Long)
    m_lngPictureHeight = lngVal
    DrawListView
    PropertyChanged "PictureHeight"
End Property

Public Property Get PictureWidth() As Long
    PictureWidth = m_lngPictureWidth
End Property

Public Property Let PictureWidth(ByVal lngVal As Long)
    m_lngPictureWidth = lngVal
    DrawListView
    PropertyChanged "PictureWidth"
End Property

Public Property Get PicturesVisible() As Boolean
    PicturesVisible = m_blnShowPictures
End Property

Public Property Let PicturesVisible(ByVal blnVal As Boolean)
    m_blnShowPictures = blnVal
    Refresh
    PropertyChanged "PicturesVisible"
End Property

Public Property Get ItemPaddingTop() As Long
    ItemPaddingTop = m_lngPaddingTop
End Property

Public Property Let ItemPaddingTop(ByVal lngVal As Long)
    m_lngPaddingTop = lngVal
    PropertyChanged "ItemPaddingTop"
    Refresh
End Property

Public Property Get ItemPaddingBottom() As Long
    ItemPaddingBottom = m_lngPaddingBottom
End Property

Public Property Let ItemPaddingBottom(ByVal lngVal As Long)
    m_lngPaddingBottom = lngVal
    PropertyChanged "ItemPaddingBottom"
    Refresh
End Property

Public Property Get ItemPaddingLeft() As Long
    ItemPaddingLeft = m_lngPaddingLeft
End Property

Public Property Let ItemPaddingLeft(ByVal lngVal As Long)
    m_lngPaddingLeft = lngVal
    DrawListView
    PropertyChanged "ItemPaddingLeft"
End Property

Public Property Get ItemPaddingRight() As Long
    ItemPaddingRight = m_lngPaddingRight
End Property

Public Property Let ItemPaddingRight(ByVal lngVal As Long)
    m_lngPaddingRight = lngVal
    DrawListView
    PropertyChanged "ItemPaddingRight"
End Property

Public Property Get Checkboxes() As Boolean
    Checkboxes = m_blnCheckBoxes
End Property

Public Property Let Checkboxes(ByVal blnVal As Boolean)
    m_blnCheckBoxes = blnVal
    DrawListView
    PropertyChanged "Checkboxes"
End Property

Public Property Get OLEDropMode() As OLEDropModeConstants
    OLEDropMode = UserControl.OLEDropMode
End Property

Public Property Let OLEDropMode(ByVal intVal As OLEDropModeConstants)
    UserControl.OLEDropMode = intVal
    PropertyChanged "OLEDropMode"
End Property

Public Property Get SolidFocusRect() As Boolean
    SolidFocusRect = m_blnSolidFocusRect
End Property

Public Property Let SolidFocusRect(ByVal blnVal As Boolean)
    m_blnSolidFocusRect = blnVal
    DrawListView
End Property

Public Property Get DrawCallback() As ICustomDraw
    Set DrawCallback = m_clsCustDrawCB
End Property

Public Property Set DrawCallback(ByVal cls As ICustomDraw)
    If cls Is Nothing Then
        Set m_clsCustDrawCB = Me
    Else
        Set m_clsCustDrawCB = cls
    End If
    DrawListView
End Property

Public Property Get BorderStyle() As LVBorderStyleConstants
    BorderStyle = m_udeBorderStyle
End Property

Public Property Let BorderStyle(ByVal udeBS As LVBorderStyleConstants)
    m_udeBorderStyle = udeBS
    pvSetBorderStyle UserControl.hwnd, m_udeBorderStyle
    PropertyChanged "BorderStyle"
End Property

Public Property Get Enabled() As Boolean
    Enabled = m_blnEnabled
End Property

Public Property Let Enabled(ByVal blnValue As Boolean)
    m_blnEnabled = blnValue
    Refresh
    PropertyChanged "Enabled"
End Property

Public Property Get ColumnsAutoSize() As Boolean
    ColumnsAutoSize = m_blnColumnsAutoSize
End Property

Public Property Let ColumnsAutoSize(ByVal blnValue As Boolean)
    m_blnColumnsAutoSize = blnValue
    Refresh
    PropertyChanged "ColumnsAutoSize"
End Property

Public Property Get Reorder() As Boolean
    Reorder = m_blnReorder
End Property

Public Property Let Reorder(ByVal blnValue As Boolean)
    m_blnReorder = blnValue
    PropertyChanged "Reorder"
End Property

Public Property Get MultiSelect() As Boolean
    MultiSelect = m_blnMultiSelect
End Property

Public Property Let MultiSelect(ByVal blnValue As Boolean)
    m_blnMultiSelect = blnValue
    PropertyChanged "MultiSelect"
End Property

Public Property Get CheckboxColor() As ole_color
    CheckboxColor = m_clsCheckBoxColor.OLEColor
End Property

Public Property Let CheckboxColor(ByVal lngOleColor As ole_color)
    m_clsCheckBoxColor.SetColor lngOleColor, , True
    DrawListView
    PropertyChanged "CheckboxColor"
End Property

Public Property Get CheckboxSelectedColor() As ole_color
    CheckboxSelectedColor = m_clsCheckBoxSelColor.OLEColor
End Property

Public Property Let CheckboxSelectedColor(ByVal lngOleColor As ole_color)
    m_clsCheckBoxSelColor.SetColor lngOleColor, , True
    DrawListView
    PropertyChanged "CheckboxSelectedColor"
End Property

Public Property Get BackColor() As ole_color
    BackColor = m_clsBackColor.OLEColor
End Property

Public Property Let BackColor(ByVal lngOleColor As ole_color)
    m_clsBackColor.SetColor lngOleColor, True
    DrawListView
    PropertyChanged "BackColor"
End Property

Public Property Get ForeColor() As ole_color
    ForeColor = m_clsForeColor.OLEColor
End Property

Public Property Let ForeColor(ByVal lngOleColor As ole_color)
    m_clsForeColor.SetColor lngOleColor
    DrawListView
    PropertyChanged "ForeColor"
End Property

Public Property Get SelectedForeColor() As ole_color
    SelectedForeColor = m_clsSelectedForeColor.OLEColor
End Property

Public Property Let SelectedForeColor(ByVal lngOleColor As ole_color)
    m_clsSelectedForeColor.SetColor lngOleColor
    DrawListView
    PropertyChanged "SelectedForeColor"
End Property

Public Property Get SelectedBackColor() As ole_color
    SelectedBackColor = m_clsSelectedBackColor.OLEColor
End Property

Public Property Let SelectedBackColor(ByVal lngOleColor As ole_color)
    m_clsSelectedBackColor.SetColor lngOleColor, True
    DrawListView
    PropertyChanged "SelectedBackColor"
End Property

Public Property Get FocusRectColor() As ole_color
    FocusRectColor = m_clsFocusRectColor.OLEColor
End Property

Public Property Let FocusRectColor(ByVal lngOleColor As ole_color)
    m_clsFocusRectColor.SetColor lngOleColor, False, True
    If m_hDCBack <> 0 Then SelectObject m_hDCBack, m_clsFocusRectColor.GDIPen
    DrawListView
    PropertyChanged "FocusRectColor"
End Property

Public Property Get Font() As StdFont
    Set Font = m_clsFont
End Property

Public Property Set Font(ByVal clsNewFont As StdFont)
    Set m_clsFont = clsNewFont
    Refresh
    PropertyChanged "Font"
End Property

Public Property Get Redraw() As Boolean
Attribute Redraw.VB_MemberFlags = "400"
    Redraw = m_blnRedraw
End Property

Public Property Let Redraw(ByVal blnVal As Boolean)
    m_blnRedraw = blnVal
    If m_blnRedraw Then Refresh
End Property


Private Sub DrawListView()
    Dim udtUCRect       As RECT
    Dim X               As Long
    Dim ps              As PAINTSTRUCT
    Static Redrawing    As Boolean
    
    If Not m_blnRedraw Then Exit Sub
    
    If Redrawing Then
        ' we don't want to get recursion here at any time
        Exit Sub
    Else
        Redrawing = True
        
        With UserControl
            If m_lngColumnsWidth > m_udtUCRect.X2 Then
                udtUCRect.X2 = m_lngColumnsWidth
            Else
                udtUCRect.X2 = .ScaleWidth
            End If
            
            udtUCRect.Y2 = .ScaleHeight
        End With
        
        If m_hDCBack <> 0 Then
            ' BeginPaint really faster?
            BeginPaint UserControl.hwnd, ps
    
            DrawColumns
            DrawItems
            
            If m_lngColumnsWidth > m_udtUCRect.X2 Then
                X = m_clsSB.Value(efsHorizontal)
            End If
        
            EndPaint UserControl.hwnd, ps
        
            BitBlt UserControl.hDC, 0, 0, m_udtUCRect.X2, m_udtUCRect.Y2, _
                   m_hDCBack, X, 0, vbSrcCopy
        End If
        
        Redrawing = False
    End If
End Sub

Private Sub DrawItems()
    Dim i               As Long
    Dim j               As Long
    Dim udtItem         As RECT
    Dim udtRest         As RECT
    Dim lngFirstItem    As Long
    Dim lngVisItems     As Long
    Dim lngOldPen       As Long
    Dim lngCustBGColor  As Long
    Dim lngCustFGColor  As Long
    Dim lngLastFGColor  As Long
    Dim strColText      As String

    lngLastFGColor = -1

    If m_clsItems.ItemCount > 0 Then
        udtItem.Y1 = m_udtITRect.Y1
        udtItem.Y2 = m_udtITRect.Y1 + ItemHeight
        
        lngFirstItem = m_clsSB.Value(efsVertical)
        If lngFirstItem > m_clsItems.ItemCount - 1 Then lngFirstItem = m_clsItems.ItemCount - 1
        lngVisItems = VisibleItems
        If lngVisItems > m_clsItems.ItemCount Then lngVisItems = m_clsItems.ItemCount
        
        i = lngFirstItem
        Do
            For j = 0 To m_colColumns.Count - 1
                If m_colColumns.Item(j).Visible Then
                    If m_blnColumnsAutoSize Then
                        udtItem.X2 = udtItem.X2 + m_colColumns.Item(j).WidthAutoSized
                    Else
                        udtItem.X2 = udtItem.X2 + m_colColumns.Item(j).Width
                    End If

                    lngCustBGColor = -1
                    lngCustFGColor = -1

                    If m_clsCustDrawCB.CustomDraw(i, j, lngCustBGColor, lngCustFGColor) Then
                        ' back- and/or forecolor custom for this cell
                        If lngCustFGColor = -1 Then
                            If m_clsForeColor.RGBColor <> lngLastFGColor Then
                                SetTextColor m_hDCBack, m_clsForeColor.RGBColor
                                lngLastFGColor = m_clsForeColor.RGBColor
                            End If
                        Else
                            If lngCustFGColor <> m_clsCustFGColor.OLEColor Then
                                m_clsCustFGColor.SetColor lngCustFGColor
                            End If
                            
                            If m_clsCustFGColor.RGBColor <> lngLastFGColor Then
                                SetTextColor m_hDCBack, m_clsCustFGColor.RGBColor
                                lngLastFGColor = m_clsCustFGColor.RGBColor
                            End If
                        End If
                        
                        If lngCustBGColor = -1 Then
                            FillRect m_hDCBack, udtItem, m_clsBackColor.GDIBrush
                            lngCustBGColor = m_clsBackColor.RGBColor
                        Else
                            If lngCustBGColor <> m_clsCustBGColor.OLEColor Then
                                m_clsCustBGColor.SetColor lngCustBGColor, True
                            End If
                            FillRect m_hDCBack, udtItem, m_clsCustBGColor.GDIBrush
                            lngCustBGColor = m_clsCustBGColor.RGBColor
                        End If
                    Else
                        ' no custom colors for this cell
                        If m_clsItems.Item(i).Selected Then
                            If m_clsSelectedForeColor.RGBColor <> lngLastFGColor Then
                                SetTextColor m_hDCBack, m_clsSelectedForeColor.RGBColor
                                lngLastFGColor = m_clsSelectedForeColor.RGBColor
                            End If
                            
                            FillRect m_hDCBack, udtItem, m_clsSelectedBackColor.GDIBrush
                            lngCustBGColor = m_clsSelectedBackColor.RGBColor
                        Else
                            If m_clsForeColor.RGBColor <> lngLastFGColor Then
                                SetTextColor m_hDCBack, m_clsForeColor.RGBColor
                                lngLastFGColor = m_clsForeColor.RGBColor
                            End If
                            
                            FillRect m_hDCBack, udtItem, m_clsBackColor.GDIBrush
                            lngCustBGColor = m_clsBackColor.RGBColor
                        End If
                    End If
                    
                    With m_clsItems.Item(i)
                        If j = 0 Then
                            ' is this item associated with a picture?
                            If m_lngPictureCount > 0 And m_blnShowPictures Then
                                udtItem.X1 = IMG_LEFT
                                If .PictureIndex > -1 Then
                                    With m_clsPictures(.PictureIndex)
                                        .Render m_hDCBack, _
                                                udtItem.X1, Int((udtItem.Y1 + udtItem.Y2) / 2 - m_lngPictureHeight / 2) + 1, _
                                                m_lngPictureHeight, m_lngPictureWidth
                                    End With
                                End If
                                udtItem.X1 = udtItem.X1 + m_lngPictureWidth + IMG_PAD_RIGHT
                            End If

                            If m_blnCheckBoxes Then
                                DrawCheckbox udtItem, .Selected, .Checked
                                udtItem.X1 = udtItem.X1 + CHECKBOX_WIDTH + CHECKBOX_MARGIN * 2
                            End If
                        End If
                    
                        Select Case ColumnTextAlign(j)
                            Case TextAlignLeft
                                DrawText m_hDCBack, .Text(j), Len(.Text(j)), TempRectLRPadding(udtItem), DT_VCENTER Or DT_SINGLELINE Or DT_END_ELLIPSIS Or DT_LEFT
                            Case TextAlignCenter
                                DrawText m_hDCBack, .Text(j), Len(.Text(j)), TempRectLRPadding(udtItem), DT_VCENTER Or DT_SINGLELINE Or DT_END_ELLIPSIS Or DT_CENTER
                            Case TextAlignRight
                                DrawText m_hDCBack, .Text(j), Len(.Text(j)), TempRectLRPadding(udtItem), DT_VCENTER Or DT_SINGLELINE Or DT_END_ELLIPSIS Or DT_RIGHT
                        End Select
                    End With

                    udtItem.X1 = udtItem.X2
                End If
            Next

            If udtItem.X2 < m_udtITRect.X2 Then
                udtRest = udtItem
                udtRest.X2 = m_udtITRect.X2
                FillRect m_hDCBack, udtRest, m_clsBackColor.GDIBrush
            End If

            If i = m_lngSelItemIndex And m_blnGotFocus And m_blnEnabled Then
                If m_blnSolidFocusRect Then
                    ' draw solid focus rect
                    MoveToEx m_hDCBack, 0, udtItem.Y1, ByVal 0&
                    LineTo m_hDCBack, udtItem.X2 - 1, udtItem.Y1
                    LineTo m_hDCBack, udtItem.X2 - 1, udtItem.Y2 - 1
                    LineTo m_hDCBack, 0, udtItem.Y2 - 1
                    LineTo m_hDCBack, 0, udtItem.Y1
                Else
                    SetTextColor m_hDCBack, 0   ' why necessary???
                    lngLastFGColor = 0
                    
                    udtItem.X1 = 0
                    DrawFocusRect m_hDCBack, udtItem
                End If
            End If
            
            udtItem.X1 = 0
            udtItem.X2 = 0
            udtItem.Y1 = udtItem.Y1 + ItemHeight
            udtItem.Y2 = udtItem.Y2 + ItemHeight

            i = i + 1
        Loop While i <= lngFirstItem + lngVisItems And i <= m_clsItems.ItemCount - 1
        
        If udtItem.X2 < UserControl.ScaleHeight Then
            ' if there is some space left at the bottom, fill it with the
            ' listview's background color
            udtItem.Y2 = UserControl.ScaleHeight
            udtItem.X2 = m_udtITRect.X2
            FillRect m_hDCBack, udtItem, m_clsBackColor.GDIBrush
        End If
    Else
        ' no items, fill the whole listview with its background color
        FillRect m_hDCBack, m_udtITRect, m_clsBackColor.GDIBrush
    End If
End Sub

Private Sub DrawColumns()
    Dim i               As Long
    Dim udtColumn       As RECT
    Dim udtText         As RECT
    Dim lngLastColWidth As Long
    Dim hBrBg           As Long
    
    If m_blnColumnsVisible Then
        hBrBg = CreateSolidBrush(TranslateColor(vbButtonFace))
        SetTextColor m_hDCBack, TranslateColor(vbButtonText)
        
        udtColumn.Y2 = m_udtCLRect.Y2
        
        For i = 0 To m_colColumns.Count - 1
            If m_colColumns.Item(i).Visible Then
                If i > 0 Then
                    If m_blnColumnsAutoSize Then
                        udtColumn.X1 = udtColumn.X1 + m_colColumns.Item(i - 1).WidthAutoSized
                    Else
                        udtColumn.X1 = udtColumn.X1 + m_colColumns.Item(i - 1).Width
                    End If
                End If
                
                If m_blnColumnsAutoSize Then
                    udtColumn.X2 = udtColumn.X1 + m_colColumns.Item(i).WidthAutoSized
                Else
                    udtColumn.X2 = udtColumn.X1 + m_colColumns.Item(i).Width
                End If
                
                FillRect m_hDCBack, udtColumn, hBrBg
                
                If m_colColumns.Item(i).Pushed Then
                    DrawEdge m_hDCBack, udtColumn, EDGE_ETCHED, BF_RECT
                Else
                    DrawEdge m_hDCBack, udtColumn, EDGE_RAISED, BF_RECT
                End If
                
                udtText = udtColumn
                
                udtText.X1 = udtText.X1 + m_lngPaddingLeft
                udtText.X2 = udtText.X2 - m_lngPaddingRight
                
                If (udtText.X2 - udtText.X1) > 0 Then
                    With m_colColumns.Item(i)
                        Select Case .TextAlign
                            Case TextAlignLeft
                                DrawText m_hDCBack, .Caption, Len(.Caption), udtText, DT_VCENTER Or DT_SINGLELINE Or DT_END_ELLIPSIS
                            Case TextAlignRight
                                DrawText m_hDCBack, .Caption, Len(.Caption), udtText, DT_VCENTER Or DT_SINGLELINE Or DT_END_ELLIPSIS Or DT_RIGHT
                            Case TextAlignCenter
                                DrawText m_hDCBack, .Caption, Len(.Caption), udtText, DT_VCENTER Or DT_SINGLELINE Or DT_END_ELLIPSIS Or DT_CENTER
                        End Select
                    End With
                End If
                
                If m_blnColumnsAutoSize Then
                    lngLastColWidth = m_colColumns.Item(i).WidthAutoSized
                Else
                    lngLastColWidth = m_colColumns.Item(i).Width
                End If
            End If
        Next
        
        If udtColumn.X2 < m_udtCLRect.X2 Then
            udtColumn.X1 = udtColumn.X1 + lngLastColWidth
            udtColumn.X2 = m_udtCLRect.X2
            FillRect m_hDCBack, udtColumn, hBrBg
            DrawEdge m_hDCBack, udtColumn, EDGE_RAISED, BF_LEFT Or BF_BOTTOM Or BF_TOP
        End If
        
        DeleteObject hBrBg
    End If
End Sub

' http://pscode.com/vb/scripts/ShowCode.asp?txtCodeId=40157&lngWId=1
Private Sub DrawCheckbox(udtItem As RECT, ByVal Selected As Boolean, ByVal Checked As Boolean)
    Dim X       As Long, Y As Long
    Dim hPenOld As Long

    If Selected Then
        hPenOld = SelectObject(m_hDCBack, m_clsCheckBoxSelColor.GDIPen)
    Else
        hPenOld = SelectObject(m_hDCBack, m_clsCheckBoxColor.GDIPen)
    End If

    X = udtItem.X1 + CHECKBOX_MARGIN
    Y = (udtItem.Y1 + udtItem.Y2) / 2 - CHECKBOX_HEIGHT / 2 - 0.5
    
    ' Rand (2px dick)
    MoveToEx m_hDCBack, X, Y, ByVal 0&
    LineTo m_hDCBack, X + CHECKBOX_WIDTH, Y
    LineTo m_hDCBack, X + CHECKBOX_WIDTH, Y + CHECKBOX_HEIGHT
    LineTo m_hDCBack, X, Y + CHECKBOX_HEIGHT
    LineTo m_hDCBack, X, Y
    MoveToEx m_hDCBack, X - 1, Y - 1, ByVal 0&
    LineTo m_hDCBack, X + CHECKBOX_WIDTH + 1, Y - 1
    LineTo m_hDCBack, X + CHECKBOX_WIDTH + 1, Y + CHECKBOX_HEIGHT + 1
    LineTo m_hDCBack, X - 1, Y + CHECKBOX_HEIGHT + 1
    LineTo m_hDCBack, X - 1, Y - 1
    
    If Checked Then
        ' Haken
        MoveToEx m_hDCBack, X + 9, Y + 5, ByVal 0&
        LineTo m_hDCBack, X + 5, Y + 9
        MoveToEx m_hDCBack, X + 9, Y + 4, ByVal 0&
        LineTo m_hDCBack, X + 4, Y + 9
        MoveToEx m_hDCBack, X + 9, Y + 3, ByVal 0&
        LineTo m_hDCBack, X + 3, Y + 9
        MoveToEx m_hDCBack, X + 3, Y + 5, ByVal 0&
        LineTo m_hDCBack, X + 5, Y + 8
        MoveToEx m_hDCBack, X + 3, Y + 6, ByVal 0&
        LineTo m_hDCBack, X + 6, Y + 9
        MoveToEx m_hDCBack, X + 3, Y + 7, ByVal 0&
        LineTo m_hDCBack, X + 6, Y + 10
        MoveToEx m_hDCBack, X + 3, Y + 7, ByVal 0&
        LineTo m_hDCBack, X + 7, Y + 9
    End If
    
    SelectObject m_hDCBack, hPenOld
End Sub

Private Function TempRectLRPadding(rc As RECT) As RECT
    Dim rcTemp As RECT
    
    rcTemp = rc
    rcTemp.X1 = rcTemp.X1 + m_lngPaddingLeft
    rcTemp.X2 = rcTemp.X2 - m_lngPaddingRight
    
    TempRectLRPadding = rcTemp
End Function

Private Sub pvSetBorderStyle(ByVal lHWnd As Long, ByVal eStyle As LVBorderStyleConstants)
    Select Case eStyle
        Case BorderStyleNone
            Call pvSetWinExStyle(lHWnd, GWL_STYLE, 0, WS_BORDER Or WS_THICKFRAME)
            Call pvSetWinExStyle(lHWnd, GWL_EXSTYLE, 0, WS_EX_STATICEDGE Or WS_EX_CLIENTEDGE Or WS_EX_WINDOWEDGE)
        Case BorderStyleThin
            Call pvSetWinExStyle(lHWnd, GWL_STYLE, 0, WS_BORDER Or WS_THICKFRAME)
            Call pvSetWinExStyle(lHWnd, GWL_EXSTYLE, WS_EX_STATICEDGE, WS_EX_CLIENTEDGE Or WS_EX_WINDOWEDGE)
        Case BorderStyleThick
            Call pvSetWinExStyle(lHWnd, GWL_STYLE, 0, WS_BORDER Or WS_THICKFRAME)
            Call pvSetWinExStyle(lHWnd, GWL_EXSTYLE, WS_EX_CLIENTEDGE, WS_EX_STATICEDGE Or WS_EX_WINDOWEDGE)
    End Select
End Sub

Private Sub pvSetWinExStyle(ByVal lHWnd As Long, ByVal lType As Long, ByVal lStyle As Long, ByVal lStyleNot As Long)
    Dim lS As Long
    
    lS = GetWindowLong(lHWnd, lType)
    lS = (lS And Not lStyleNot) Or lStyle
    SetWindowLong lHWnd, lType, lS
    SetWindowPos lHWnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOOWNERZORDER Or SWP_NOZORDER Or SWP_FRAMECHANGED
End Sub

Private Property Get VisibleItems() As Long
    VisibleItems = (m_udtITRect.Y2 - m_udtITRect.Y1 + 1) / ItemHeight + 0.5
End Property

Public Property Get ItemHeight() As Long
    Dim lngHeight As Long
    
    If Not m_blnItemAutoSize Then
        ItemHeight = m_lngFontHeight + m_lngPaddingTop + m_lngPaddingBottom
    Else
        lngHeight = m_lngFontHeight + 4
        
        If m_blnCheckBoxes Then
            lngHeight = Max(lngHeight, CHECKBOX_HEIGHT + 7)
        End If
        
        If m_blnShowPictures And m_lngPictureCount > 0 Then
            lngHeight = Max(lngHeight, m_lngPictureHeight + 3)
        End If
        
        If lngHeight = 0 Then ItemHeight = 1 Else ItemHeight = lngHeight
    End If
End Property

Private Function TranslateColor(ByVal oClr As ole_color, Optional hPal As Long = 0) As Long
    If OleTranslateColor(oClr, hPal, TranslateColor) Then TranslateColor = CLR_INVALID
End Function

Private Function ICustomDraw_CustomDraw(ByVal ItemIndex As Long, ByVal ColumnIndex As Long, BackColor As Long, ForeColor As Long) As Boolean
    '
End Function

Private Sub CreateDrawPlane()
    Dim dX As Long
    
    If m_hDCBack = 0 Then
        m_hDCBack = CreateCompatibleDC(UserControl.hDC)
        m_hOldFont = GetCurrentObject(m_hDCBack, OBJ_FONT)
        m_hOldPen = GetCurrentObject(m_hDCBack, OBJ_PEN)
    End If
    
    If m_hDCBackBmp <> 0 Then
        SelectObject m_hDCBack, m_hDCBackOldBmp
        DeleteObject m_hDCBackBmp
        m_hDCBackBmp = 0
        m_hDCBackOldBmp = 0
    End If
    
    If m_lngColumnsWidth > UserControl.ScaleWidth Then
        dX = m_lngColumnsWidth
    Else
        dX = UserControl.ScaleWidth
    End If
    
    m_hDCBackBmp = CreateCompatibleBitmap(UserControl.hDC, dX, UserControl.ScaleHeight)
    If m_hDCBackBmp <> 0 Then
        m_hDCBackOldBmp = SelectObject(m_hDCBack, m_hDCBackBmp)
        SetBkMode m_hDCBack, 1
    End If
End Sub

Private Function Max(ByVal val1 As Long, ByVal val2 As Long) As Long
    If val1 > val2 Then Max = val1 Else Max = val2
End Function

Private Function Min(ByVal val1 As Long, ByVal val2 As Long) As Long
    If val1 < val2 Then Min = val1 Else Min = val2
End Function


Public Sub Sort(Index, ByVal SortOrder As SortOrderConstants)
    m_clsItems.Sort ColumnIndex(Index), SortOrder
End Sub

Public Function ColumnFromPoint(ByVal X As Long, ByVal Y As Long) As Long
    Dim i           As Long
    Dim lngWidth    As Long
    
    ' get the index of a column relative to the listview's (x,y)
    
    X = X + m_clsSB.Value(efsHorizontal)
    
    If X > m_lngColumnsWidth - 1 Then
        ColumnFromPoint = -1
    Else
        For i = 0 To m_colColumns.Count - 1
            lngWidth = lngWidth + m_colColumns.Item(i).Width
            If lngWidth > X Then
                ColumnFromPoint = i
                Exit For
            End If
        Next
    End If
End Function

Public Function RowFromPoint(ByVal X As Long, ByVal Y As Long, Optional ByVal HitTest As Boolean = False) As Long
    Dim lngItem As Long
    
    ' get the index of a row relative to the listview's (x,y) and the first visible item
    
    lngItem = CLng((Y - m_udtCLRect.Y2) / ItemHeight - 0.5) + m_clsSB.Value(efsVertical)
    
    If HitTest Then
        If X > m_lngColumnsWidth - 1 Then
            lngItem = -1
        Else
            If lngItem > ItemCount - 1 Or lngItem < 0 Then
                RowFromPoint = -1
            Else
                RowFromPoint = lngItem
            End If
        End If
    Else
        RowFromPoint = lngItem
    End If
End Function

Private Sub UpdateVScroll()
    Dim rc          As RECT

    If m_blnEnabled Then
        If ItemCount - VisibleItems >= 0 Then
            If Not m_clsSB.Enabled(efsVertical) Then m_clsSB.Enabled(efsVertical) = True
            m_clsSB.Max(efsVertical) = ItemCount - VisibleItems
        Else
            If m_clsSB.Enabled(efsVertical) Then
                m_clsSB.Enabled(efsVertical) = False
                m_clsSB.Max(efsVertical) = 0
                m_clsSB.Value(efsVertical) = 0
            End If
        End If
    Else
        m_clsSB.Enabled(efsVertical) = False
    End If
End Sub

Private Sub m_clsSB_Change(eBar As EFSScrollBarConstants)
    DrawListView
End Sub

Private Sub m_clsSB_Scroll(eBar As EFSScrollBarConstants)
    DrawListView
End Sub

Private Sub m_clsSB_ScrollClick(eBar As EFSScrollBarConstants, eButton As MouseButtonConstants)
    DrawListView
End Sub

Public Sub Refresh()
    DoSizing
    UpdateVScroll
    DrawListView
End Sub

Private Sub tmrMove_Timer()
    Dim udtCursor   As POINTAPI
    Dim udtRC       As POINTAPI
    
    GetCursorPos udtCursor
    ClientToScreen UserControl.hwnd, udtRC

    If ScrollWithMouse(udtCursor.Y - udtRC.Y) Then
        UserControl_MouseMove vbLeftButton, 0, udtCursor.X - udtRC.X, udtCursor.Y - udtRC.Y
    End If
End Sub

Private Sub UserControl_Click()
    If m_lngSelItemIndex >= 0 And m_lngSelItemIndex <= m_clsItems.ItemCount - 1 Then
        RaiseEvent Click(m_lngSelItemIndex)
    End If
End Sub

Private Sub UserControl_DblClick()
    If m_lngSelItemIndex >= 0 And m_lngSelItemIndex <= m_clsItems.ItemCount - 1 Then
        If m_clsItems.Item(m_lngSelItemIndex).Selected Then
            RaiseEvent DblClick(m_lngSelItemIndex)
        End If
    End If
End Sub

Public Sub MakeSureVisible(ByVal lngItem As Long, Optional ByVal lngColumn As Long = -1)
    Dim i           As Long
    Dim lngColLeft  As Long
    
    ' Item
    m_clsSB.Value(efsVertical) = lngItem
    
    ' Column
    If lngColumn > -1 And (Not m_blnColumnsAutoSize) Then
        If m_lngColumnsWidth > UserControl.ScaleWidth Then
            For i = 0 To lngColumn - 1
                With m_colColumns.Item(i)
                    If .Visible Then lngColLeft = lngColLeft + .Width
                End With
            Next
            
            m_clsSB.Value(efsHorizontal) = lngColLeft
        End If
    End If
    
    DrawListView
End Sub

Public Sub SelectAll()
    Dim i   As Long
    
    If m_blnMultiSelect Then
        For i = 0 To m_clsItems.ItemCount - 1
            m_clsItems.Item(i).Selected = True
        Next
    End If
End Sub

Public Sub UnSelectAll()
    Dim i   As Long
    
    For i = 0 To m_clsItems.ItemCount - 1
        m_clsItems.Item(i).Selected = False
    Next
End Sub

Private Sub UserControl_GotFocus()
    m_blnGotFocus = True
    DrawListView
End Sub

Private Sub UserControl_KeyPress(KeyAscii As Integer)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent KeyPress(KeyAscii)
End Sub

Private Sub UserControl_KeyUp(KeyCode As Integer, Shift As Integer)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent KeyUp(KeyCode, Shift)
End Sub

Private Sub UserControl_LostFocus()
    m_blnGotFocus = False
    DrawListView
End Sub

Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
    If Not m_blnEnabled Then Exit Sub
    
    RaiseEvent KeyDown(KeyCode, Shift)

    Select Case KeyCode
        Case vbKeyUp, vbKeyDown, vbKeyPageDown, vbKeyPageUp
            If Shift = 0 Or Not m_blnMultiSelect Then
                UnSelectAll
                m_blnMultiSelRem = False
            End If
            
            Select Case KeyCode
                Case vbKeyUp
                    m_lngSelItemIndex = m_lngSelItemIndex - 1
                    If m_lngSelItemIndex < 0 Then m_lngSelItemIndex = 0
                    If m_lngSelItemIndex < m_clsSB.Value(efsVertical) Then m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) - 1
                    RaiseEvent Click(m_lngSelItemIndex)
                Case vbKeyDown
                    m_lngSelItemIndex = m_lngSelItemIndex + 1
                    If m_lngSelItemIndex > m_clsItems.ItemCount - 1 Then m_lngSelItemIndex = m_clsItems.ItemCount - 1
                    If m_lngSelItemIndex > m_clsSB.Value(efsVertical) + VisibleItems - 2 Then m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) + 1
                    RaiseEvent Click(m_lngSelItemIndex)
                Case vbKeyPageUp
                    m_lngSelItemIndex = m_lngSelItemIndex - VisibleItems + 1
                    If m_lngSelItemIndex < 0 Then m_lngSelItemIndex = 0
                    If m_lngSelItemIndex < m_clsSB.Value(efsVertical) Then m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) - VisibleItems + 1
                    RaiseEvent Click(m_lngSelItemIndex)
                Case vbKeyPageDown
                    m_lngSelItemIndex = m_lngSelItemIndex + VisibleItems - 1
                    If m_lngSelItemIndex > m_clsItems.ItemCount - 1 Then m_lngSelItemIndex = m_clsItems.ItemCount - 1
                    If m_lngSelItemIndex > m_clsSB.Value(efsVertical) + VisibleItems - 2 Then m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) + VisibleItems - 1
                    RaiseEvent Click(m_lngSelItemIndex)
            End Select
            
            If Shift <> 2 Or Not m_blnMultiSelect Then
                m_clsItems.Item(m_lngSelItemIndex).Selected = Not m_blnMultiSelRem
            End If

        Case vbKeySpace
            If Shift = 2 And m_blnMultiSelect Then
                m_clsItems.Item(m_lngSelItemIndex).Selected = Not m_clsItems.Item(m_lngSelItemIndex).Selected
                m_blnMultiSelRem = Not m_clsItems.Item(m_lngSelItemIndex).Selected
            End If
            
            If m_blnCheckBoxes Then
                ItemChecked(m_lngSelItemIndex) = Not ItemChecked(m_lngSelItemIndex)
            End If
            
'        Case vbKeyReturn
'            UnSelectAll
'            If m_lngSelItemIndex >= 0 And m_lngSelItemIndex <= m_clsItems.ItemCount - 1 Then
'                m_clsItems.Item(m_lngSelItemIndex).Selected = True
'                RaiseEvent DblClick(m_lngSelItemIndex)
'            End If
            
    End Select
    
    DrawListView
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim lngColumnLeft   As Long
    Dim lngClickedItem  As Long
    Dim lngLastWidth    As Long
    Dim lngStep         As Long
    Dim i               As Long
    
    If Not m_blnEnabled Then Exit Sub
    
    X = X + m_clsSB.Value(efsHorizontal)

    If X <= m_lngColumnsWidth Then
    
        If m_blnColumnsVisible And (Y >= m_udtCLRect.Y1 And Y <= m_udtCLRect.Y2) Then
            ' resize column?
            For i = 0 To m_colColumns.Count - 1
                If m_blnColumnsAutoSize Then
                    lngColumnLeft = lngColumnLeft + m_colColumns.Item(i).WidthAutoSized
                Else
                    lngColumnLeft = lngColumnLeft + ColumnWidth(i)
                End If
                
                If Abs(X - lngColumnLeft) < 5 Then
                    ' resize column!
                    If m_colColumns.Item(i).Resizable Then
                        m_udeMouseOver = MouseOverResizeColumn
                        m_lngColumnResize = i
                    End If
                    Exit Sub
                    
                ElseIf X > lngLastWidth + 5 And X < lngColumnLeft - 5 Then
                    ' clicked on a column button
                    m_colColumns.Item(i).Pushed = True
                    m_udeMouseOver = MouseOverColumnClick
                    DrawListView
                    Exit Sub
                End If

                lngLastWidth = lngColumnLeft
            Next
            
        ElseIf Y >= m_udtITRect.Y1 And Y <= m_udtITRect.Y2 Then
            lngClickedItem = CLng((Y - m_udtCLRect.Y2) / ItemHeight - 0.5) + m_clsSB.Value(efsVertical)
            
            If lngClickedItem <= m_clsItems.ItemCount - 1 And lngClickedItem >= 0 Then
                
                ' Checkbox click?
                If m_blnCheckBoxes Then
                    If ColumnFromPoint(X, Y) = 0 Then
                        If m_blnShowPictures And m_lngPictureCount > 0 Then
                            If X > CHECKBOX_MARGIN + IMG_LEFT + IMG_PAD_RIGHT + m_lngPictureWidth And X < m_lngPictureWidth + IMG_LEFT + IMG_PAD_RIGHT + CHECKBOX_MARGIN + CHECKBOX_WIDTH Then
                                ItemChecked(lngClickedItem) = Not ItemChecked(lngClickedItem)
                                RaiseEvent ItemCheck(lngClickedItem)
                                DrawListView
                                Exit Sub
                            End If
                        Else
                            If X > CHECKBOX_MARGIN And X < CHECKBOX_MARGIN + CHECKBOX_WIDTH Then
                                ItemChecked(lngClickedItem) = Not ItemChecked(lngClickedItem)
                                RaiseEvent ItemCheck(lngClickedItem)
                                DrawListView
                                Exit Sub
                            End If
                        End If
                    End If
                End If
                
                ' Item click?
                If Not m_clsItems.Item(lngClickedItem).Selected Or Shift = 1 Then
                    If Shift = 0 Or Not m_blnMultiSelect Then
                        For i = 0 To m_clsItems.ItemCount - 1
                            m_clsItems.Item(i).Selected = False
                        Next
                        If m_blnMultiSelect Then
                            m_udeMouseOver = MouseOverMultiselect
                            tmrMove.Enabled = True
                        End If
                    ElseIf Shift = 1 And m_blnMultiSelect Then
                        If m_lngSelItemIndex > lngClickedItem Then
                            lngStep = -1
                        Else
                            lngStep = 1
                        End If
                        
                        For i = m_lngSelItemIndex To lngClickedItem Step lngStep
                            m_clsItems.Item(i).Selected = Not m_blnMultiSelRem
                        Next
                    End If
                End If
                
                ' "Not m_blnMultiselect" for one-click-reorder
                If m_clsItems.Item(lngClickedItem).Selected Or Not m_blnMultiSelect Then
                    ' Items umsiedeln wenn kein Shift oder Strg
                    If Shift = 0 Then
                        ' no m_blnReorder condition here so that
                        ' for a single click the selection gets removed in
                        ' UserControl_MouseUp
                        m_udeMouseOver = MouseOverReorder
                        tmrMove.Enabled = m_blnReorder
                        m_blnItemDragged = False
                    End If
                End If
                
                m_lngSelItemIndex = lngClickedItem

                If Shift = vbCtrlMask Then      ' STRG
                    m_clsItems.Item(m_lngSelItemIndex).Selected = Not m_clsItems.Item(m_lngSelItemIndex).Selected
                    m_blnMultiSelRem = Not m_clsItems.Item(m_lngSelItemIndex).Selected
                ElseIf Shift = vbShiftMask Then ' SHIFT
                    m_clsItems.Item(m_lngSelItemIndex).Selected = Not m_blnMultiSelRem
                Else
                    m_clsItems.Item(m_lngSelItemIndex).Selected = True
                    m_blnMultiSelRem = False
                End If
                
                m_lngMultiSelStart = lngClickedItem
            Else
                ' no item hit
                If Button = vbLeftButton Then
                    For i = 0 To m_clsItems.ItemCount - 1
                        m_clsItems.Item(i).Selected = False
                    Next
                End If
                
                lngClickedItem = -1
            End If
    
            DrawListView
            
            RaiseEvent MouseDown(lngClickedItem, Button, Shift, X - m_clsSB.Value(efsHorizontal), Y)
        End If
    Else
        ' no item hit
        If Button = vbLeftButton Then
            For i = 0 To m_clsItems.ItemCount - 1
                m_clsItems.Item(i).Selected = False
            Next
        End If
        
        DrawListView
        
        RaiseEvent MouseDown(-1, Button, Shift, X - m_clsSB.Value(efsHorizontal), Y)
    End If
End Sub

Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim i               As Long
    Dim lngColumnLeft   As Long
    Dim lngLeftRel      As Long
    Dim lngCursor       As Long
    Dim lngColWidthNew  As Long
    Dim lngItemOver     As Long
    Dim lngMoveDelta    As Long
    Dim lngStep         As Long
    Dim lngColAbsWidth  As Long
    Dim lngFixeds       As Long
    Dim lngDiffNext     As Long
    Dim clsDragItem     As ListItem
    Dim udtCursorPos    As POINTAPI
    Dim udtLV           As POINTAPI

    If Not m_blnEnabled Then Exit Sub

    X = m_clsSB.Value(efsHorizontal) + X

    Select Case m_udeMouseOver
        Case MouseOverFree

            If m_blnColumnsVisible And (Y >= m_udtCLRect.Y1 And Y <= m_udtCLRect.Y2) Then
                ' cursor between 2 columnbuttons?
                For i = 0 To ColumnCount - 1
                    If m_blnColumnsAutoSize Then
                        lngColumnLeft = lngColumnLeft + m_colColumns.Item(i).WidthAutoSized
                    Else
                        lngColumnLeft = lngColumnLeft + m_colColumns.Item(i).Width
                    End If
                    
                    If Abs(X - lngColumnLeft) < 5 Then
                        If ColumnResizable(i) And (Not m_blnColumnsAutoSize) Then
                            lngCursor = vbSizeWE
                            Exit For
                        End If
                    End If
                Next
            ElseIf Y > m_udtITRect.Y1 And Y <= m_udtITRect.Y2 Then
                lngCursor = vbArrow
            End If
            
            If UserControl.MousePointer <> lngCursor Then
                UserControl.MousePointer = lngCursor
            End If
            
        Case MouseOverResizeColumn
            ' resize column to cursor
            If Not m_blnColumnsAutoSize Then
                For i = 0 To m_lngColumnResize - 1
                    lngColumnLeft = lngColumnLeft + m_colColumns.Item(i).Width
                Next
                
                lngColWidthNew = X - lngColumnLeft
                If lngColWidthNew < 5 Then lngColWidthNew = 5
    
                m_colColumns.Item(i).Width = lngColWidthNew
            Else
                ' column resize with autosized columns not implemented
            End If
            
            DoSizing
            UpdateVScroll
            DrawListView
            
        Case MouseOverMultiselect
            ' select all items from start item to mouse cursor
            lngItemOver = CLng((Y - m_udtCLRect.Y2) / ItemHeight - 0.5) + m_clsSB.Value(efsVertical)
            
            GetCursorPos udtCursorPos
            ClientToScreen UserControl.hwnd, udtLV
            
            If lngItemOver > m_clsItems.ItemCount - 1 Then
                lngItemOver = m_clsItems.ItemCount - 1
            ElseIf lngItemOver < 0 Then
                lngItemOver = 0
            End If
            
            ' deselected all items around the selection
            If m_lngMultiSelStart > lngItemOver Then
                lngStep = -1
                For i = 0 To lngItemOver - 1
                    m_clsItems.Item(i).Selected = False
                Next
                For i = m_lngMultiSelStart + 1 To m_clsItems.ItemCount - 1
                    m_clsItems.Item(i).Selected = False
                Next
            Else
                lngStep = 1
                For i = 0 To m_lngMultiSelStart - 1
                    m_clsItems.Item(i).Selected = False
                Next
                For i = lngItemOver + 1 To m_clsItems.ItemCount - 1
                    m_clsItems.Item(i).Selected = False
                Next
            End If

            For i = m_lngMultiSelStart To lngItemOver Step lngStep
                m_clsItems.Item(i).Selected = True
            Next
            
            m_lngSelItemIndex = lngItemOver
            
            ' when the cursor is on top or under the listview, scroll
            If ItemCount - VisibleItems > 0 Then
                If udtCursorPos.Y < udtLV.Y + m_udtCLRect.Y2 Then
                    m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) - 1
                ElseIf udtCursorPos.Y > udtLV.Y + UserControl.ScaleHeight - 3 Then
                    m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) + 1
                End If
            End If
            
            DrawListView
            
        Case MouseOverReorder
            If m_blnReorder Then
                ' move selected items to an other index
                lngItemOver = CLng((Y - m_udtCLRect.Y2) / ItemHeight - 0.5) + m_clsSB.Value(efsVertical)
                lngMoveDelta = lngItemOver - m_lngSelItemIndex
    
                GetCursorPos udtCursorPos
                ClientToScreen UserControl.hwnd, udtLV
    
                ' move items upwards
                If lngMoveDelta < 0 Then
                    For i = 0 To m_clsItems.ItemCount - 1
                        If m_clsItems.Item(i).Selected Then
                            If i + lngMoveDelta < 0 Then
                                Exit For
                            Else
                                m_clsItems.MoveItem i, i + lngMoveDelta
                                
                                If i = m_lngSelItemIndex Then
                                    m_lngSelItemIndex = m_lngSelItemIndex + lngMoveDelta
                                End If
                                
                                m_blnItemDragged = True
                            End If
                        End If
                    Next
                ' move items downwards
                ElseIf lngMoveDelta > 0 Then
                    For i = m_clsItems.ItemCount - 1 To 0 Step -1
                        If m_clsItems.Item(i).Selected Then
                            If i + lngMoveDelta > m_clsItems.ItemCount - 1 Then
                                Exit For
                            Else
                                m_clsItems.MoveItem i, i + lngMoveDelta
                                
                                If i = m_lngSelItemIndex Then
                                    m_lngSelItemIndex = m_lngSelItemIndex + lngMoveDelta
                                End If
                                
                                m_blnItemDragged = True
                            End If
                        End If
                    Next
                End If
            End If
            
            If m_blnItemDragged Then
                RaiseEvent Reorder
                DrawListView
            End If
            
    End Select
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim i   As Long
        
    If m_udeMouseOver = MouseOverReorder And Button = vbLeftButton Then
        If Not m_blnItemDragged Then
            For i = 0 To m_clsItems.ItemCount - 1
                m_clsItems.Item(i).Selected = False
            Next
            
            m_clsItems.Item(m_lngSelItemIndex).Selected = True
            DrawListView
        End If
    ElseIf m_udeMouseOver = MouseOverColumnClick Then
        For i = 0 To m_colColumns.Count - 1
            With m_colColumns.Item(i)
                If .Pushed Then
                    If m_blnSortable Then
                        m_clsItems.Sort i, .LastSortOrder
                        
                        If .LastSortOrder = SortAscending Then
                            .LastSortOrder = SortDescending
                        Else
                            .LastSortOrder = SortAscending
                        End If
                    End If
                    
                    RaiseEvent ColumnClick(i)
                End If
                
                .Pushed = False
            End With
        Next
        DrawListView
    End If
    
    m_udeMouseOver = MouseOverFree
    tmrMove.Enabled = False

    RaiseEvent MouseUp(m_lngSelItemIndex, Button, Shift, X, Y)
End Sub

Private Function ScrollWithMouse(ByVal Y As Long) As Boolean
    If ItemCount - VisibleItems >= 0 Then
        If Y > UserControl.ScaleHeight - 3 Then
            m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) + 1
            ScrollWithMouse = True
        ElseIf Y < m_udtCLRect.Y2 - 3 Then
            m_clsSB.Value(efsVertical) = m_clsSB.Value(efsVertical) - 1
            ScrollWithMouse = True
        End If
    End If
End Function

Private Sub m_clsFont_FontChanged(ByVal PropertyName As String)
    CreateFont
End Sub

Private Sub CreateFont()
    Dim udtFontData As LOGFONT
    Dim lngTempFont As Long
    
    m_lngFontHeight = MulDiv(m_clsFont.Size, GetDeviceCaps(UserControl.hDC, LOGPIXELSY), 72)
    
    With udtFontData
        .lfCharSet = m_clsFont.Charset
        CopyMemory .lfFaceName(0), ByVal m_clsFont.Name, Min(Len(m_clsFont.Name), 32)
        .lfItalic = Abs(m_clsFont.Italic)
        .lfStrikeOut = Abs(m_clsFont.Strikethrough)
        .lfUnderline = Abs(m_clsFont.Underline)
        .lfWeight = m_clsFont.Weight
        .lfHeight = -m_lngFontHeight
    End With
    
    lngTempFont = CreateFontIndirect(udtFontData)
    SelectObject m_hDCBack, lngTempFont
    DeleteObject m_hFont
    m_hFont = lngTempFont
End Sub

Private Sub UserControl_OLECompleteDrag(Effect As Long)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent OLECompleteDrag(Effect)
End Sub

Private Sub UserControl_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent OLEDragDrop(Data, Effect, Button, Shift, X, Y)
End Sub

Private Sub UserControl_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, state As Integer)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent OLEDragOver(Data, Effect, Button, Shift, X, Y, state)
End Sub

Private Sub UserControl_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent OLEGiveFeedback(Effect, DefaultCursors)
End Sub

Private Sub UserControl_OLESetData(Data As DataObject, DataFormat As Integer)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent OLESetData(Data, DataFormat)
End Sub

Private Sub UserControl_OLEStartDrag(Data As DataObject, AllowedEffects As Long)
    If Not m_blnEnabled Then Exit Sub
    RaiseEvent OLEStartDrag(Data, AllowedEffects)
End Sub

Private Sub UserControl_Paint()
    DrawListView
End Sub

Private Sub DoSizing()
    Dim i               As Long
    Dim lngLastHPos     As Long
    Dim lngLastVPos     As Long
    Dim lngColumnLeft   As Long
    Dim lngColAbsWidth  As Long
    Dim lngFixeds       As Long

    GetClientRect UserControl.hwnd, m_udtUCRect

    ' width of the columns
    If m_blnColumnsAutoSize Then
        m_lngColumnsWidth = m_udtUCRect.X2
        
         For i = 0 To m_colColumns.Count - 1
            With m_colColumns.Item(i)
                If .Visible Then
                    If .Resizable Then
                        lngColAbsWidth = lngColAbsWidth + .Width
                    Else
                        lngFixeds = lngFixeds + .Width
                        .WidthAutoSized = .Width
                    End If
                End If
            End With
        Next
        
        For i = 0 To m_colColumns.Count - 1
            With m_colColumns.Item(i)
                If .Visible Then
                    If .Resizable Then
                        .WidthAutoSized = (.Width / lngColAbsWidth) * (m_udtUCRect.X2 - lngFixeds) + 0.5
                    End If
                    
                    If i = m_colColumns.Count - 1 And m_blnColumnsAutoSize Then
                        If .WidthAutoSized + lngColumnLeft > m_udtUCRect.X2 Then
                            .WidthAutoSized = m_udtUCRect.X2 - lngColumnLeft
                        End If
                    End If
                    
                    lngColumnLeft = lngColumnLeft + .WidthAutoSized
                End If
            End With
        Next
    Else
        m_lngColumnsWidth = 0
        For i = 0 To m_colColumns.Count - 1
            With m_colColumns.Item(i)
                If .Visible Then m_lngColumnsWidth = m_lngColumnsWidth + .Width
            End With
        Next
    End If

    If m_lngColumnsWidth > m_udtUCRect.X2 Then
        ' if the sum of all column widths is greater then the control's width
        ' a horizontal scrollbar is needed
        
        With m_clsSB
            .Visible(efsHorizontal) = True
    
            .Min(efsHorizontal) = 0
            .Max(efsHorizontal) = m_lngColumnsWidth - m_udtUCRect.X2 - 1
            .LargeChange(efsHorizontal) = m_lngColumnsWidth / 2
            .SmallChange(efsHorizontal) = 3
            
            .Enabled(efsHorizontal) = m_blnEnabled
        End With
        
        ' horizontal scrollbar visible now,
        ' get the size of the control again
        GetClientRect UserControl.hwnd, m_udtUCRect
        CreateDrawPlane
    Else
        With m_clsSB
            .Visible(efsHorizontal) = False
            .Value(efsHorizontal) = 0
        End With

        ' horizontal scrollbar maybe just disappeared, need size of the control
        GetClientRect UserControl.hwnd, m_udtUCRect
        CreateDrawPlane
    End If

    ' Column Header Rect
    With m_udtCLRect
        If m_blnColumnsVisible Then
            ' visible column header, reserve some space
            If m_lngColumnsWidth > m_udtUCRect.X2 Then
                .X2 = m_lngColumnsWidth
            Else
                .X2 = m_udtUCRect.X2
            End If
            
            '.Y2 = m_lngFontHeight + m_lngPaddingTop + m_lngPaddingBottom
            .Y2 = m_lngFontHeight + 8
        Else
            .X2 = 0
            .Y2 = 0
        End If
    End With

    ' Items Rect
    With m_udtITRect
        .Y1 = m_udtCLRect.Y2
        .Y2 = m_udtUCRect.Y2

        If m_lngColumnsWidth > m_udtUCRect.X2 Then
            .X2 = m_lngColumnsWidth
        Else
            .X2 = m_udtUCRect.X2
        End If
    End With
End Sub

Private Sub UserControl_Resize()
    DoSizing
    UpdateVScroll
    DrawListView
End Sub

Private Sub UserControl_InitProperties()
    BackColor = SystemColorConstants.vbWindowBackground
    ForeColor = SystemColorConstants.vbWindowText
    SelectedBackColor = SystemColorConstants.vbHighlight
    SelectedForeColor = SystemColorConstants.vbHighlightText
    FocusRectColor = SystemColorConstants.vbHighlight
    CheckboxColor = vbBlack
    CheckboxSelectedColor = vbWhite
    Reorder = True
    MultiSelect = True
    ColumnsAutoSize = False
    ColumnsVisible = True
    Enabled = True
    BorderStyle = BorderStyleThin
    SolidFocusRect = True
    Checkboxes = False

    ItemPaddingBottom = 4
    ItemPaddingLeft = 4
    ItemPaddingRight = 5
    ItemPaddingTop = 4
    
    PictureHeight = 16
    PictureWidth = 16
    PicturesVisible = True
    
    m_blnSortable = True
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    If Ambient.UserMode Then
        With m_clsSB
            .Create UserControl.hwnd
            .Orientation = efsoBoth
            .Visible(efsVertical) = True
            .Visible(efsHorizontal) = True
            .Enabled(efsHorizontal) = True
            .Enabled(efsVertical) = False
            .LargeChange(efsVertical) = 10
        End With
    End If
    
    Redraw = False
    
    CreateDrawPlane
    
    With PropBag
        BackColor = .ReadProperty("BackColor", SystemColorConstants.vbWindowBackground)
        ForeColor = .ReadProperty("ForeColor", SystemColorConstants.vbWindowText)
        SelectedBackColor = .ReadProperty("SelectedBackColor", SystemColorConstants.vbHighlight)
        SelectedForeColor = .ReadProperty("SelectedForeColor", SystemColorConstants.vbHighlightText)
        FocusRectColor = .ReadProperty("FocusRectColor", SystemColorConstants.vbHighlight)
        Reorder = .ReadProperty("Reorder", True)
        MultiSelect = .ReadProperty("MultiSelect", True)
        ColumnsAutoSize = .ReadProperty("ColumnsAutoSize", False)
        Enabled = .ReadProperty("Enabled", True)
        BorderStyle = .ReadProperty("BorderStyle", BorderStyleThin)
        Set m_clsFont = .ReadProperty("Font", New StdFont)
        ColumnsVisible = .ReadProperty("ColumnsVisible", True)
        SolidFocusRect = .ReadProperty("SolidFocusRect", True)
        OLEDropMode = .ReadProperty("OLEDropMode", 0)
        Checkboxes = .ReadProperty("Checkboxes", False)
        CheckboxColor = .ReadProperty("CheckboxColor", vbBlack)
        CheckboxSelectedColor = .ReadProperty("CheckboxSelectedColor", vbWhite)
        ItemPaddingTop = .ReadProperty("ItemPaddingTop", 4)
        ItemPaddingBottom = .ReadProperty("ItemPaddingBottom", 4)
        ItemPaddingLeft = .ReadProperty("ItemPaddingLeft", 4)
        ItemPaddingRight = .ReadProperty("ItemPaddingRight", 5)
        PictureWidth = .ReadProperty("PictureWidth", 13)
        PictureHeight = .ReadProperty("PictureHeight", 13)
        PicturesVisible = .ReadProperty("PicturesVisible", True)
        ItemsAutoSize = .ReadProperty("ItemsAutoSize", True)
        Sortable = .ReadProperty("Sortable", True)
    End With
    
    CreateFont
    
    Redraw = True
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    With PropBag
        .WriteProperty "BackColor", BackColor, SystemColorConstants.vbWindowBackground
        .WriteProperty "ForeColor", ForeColor, SystemColorConstants.vbWindowText
        .WriteProperty "SelectedBackColor", SelectedBackColor, SystemColorConstants.vbHighlight
        .WriteProperty "SelectedForeColor", SelectedForeColor, SystemColorConstants.vbHighlightText
        .WriteProperty "FocusRectColor", FocusRectColor, SystemColorConstants.vbHighlight
        .WriteProperty "Reorder", Reorder, True
        .WriteProperty "MultiSelect", MultiSelect, True
        .WriteProperty "ColumnsAutoSize", ColumnsAutoSize, False
        .WriteProperty "Enabled", Enabled, True
        .WriteProperty "BorderStyle", BorderStyle, BorderStyleThin
        .WriteProperty "Font", m_clsFont, New StdFont
        .WriteProperty "ColumnsVisible", ColumnsVisible, True
        .WriteProperty "SolidFocusRect", SolidFocusRect, True
        .WriteProperty "OLEDropMode", OLEDropMode, 0
        .WriteProperty "Checkboxes", Checkboxes, False
        .WriteProperty "CheckboxColor", CheckboxColor, vbBlack
        .WriteProperty "CheckboxSelectedColor", CheckboxSelectedColor, vbWhite
        .WriteProperty "ItemPaddingTop", ItemPaddingTop, 4
        .WriteProperty "ItemPaddingBottom", ItemPaddingBottom, 4
        .WriteProperty "ItemPaddingLeft", ItemPaddingLeft, 4
        .WriteProperty "ItemPaddingRight", ItemPaddingRight, 5
        .WriteProperty "PictureWidth", PictureWidth, 13
        .WriteProperty "PictureHeight", PictureHeight, 13
        .WriteProperty "PicturesVisible", PicturesVisible, True
        .WriteProperty "ItemsAutoSize", ItemsAutoSize, True
        .WriteProperty "Sortable", Sortable, True
    End With
End Sub

Private Sub UserControl_Initialize()
    Set m_clsSB = New Scrollbars
    Set m_colColumns = New ColumnCollection
    Set m_clsItems = New ListItemCollection

    Set m_clsFont = New StdFont
    
    Set m_clsCustDrawCB = Me

    Set m_clsBackColor = New Color
    Set m_clsForeColor = New Color
    Set m_clsFocusRectColor = New Color
    Set m_clsSelectedBackColor = New Color
    Set m_clsSelectedForeColor = New Color
    Set m_clsCustBGColor = New Color
    Set m_clsCustFGColor = New Color
    Set m_clsCheckBoxColor = New Color
    Set m_clsCheckBoxSelColor = New Color

    m_lngSelItemIndex = -1
    m_blnRedraw = True
    
    m_lngPaddingBottom = 4
    m_lngPaddingLeft = 4
    m_lngPaddingRight = 5
    m_lngPaddingTop = 4
    
    m_lngPictureHeight = 16
    m_lngPictureWidth = 16
    m_blnShowPictures = True
    m_blnItemAutoSize = True
    m_blnSortable = True
End Sub

Private Sub UserControl_Terminate()
    Set m_clsSelectedForeColor = Nothing
    Set m_clsSelectedBackColor = Nothing
    Set m_clsFocusRectColor = Nothing
    Set m_clsForeColor = Nothing
    Set m_clsBackColor = Nothing
    Set m_clsCustBGColor = Nothing
    Set m_clsCustFGColor = Nothing
    Set m_clsCheckBoxColor = Nothing
    Set m_clsCheckBoxSelColor = Nothing

    Set m_clsFont = Nothing
    
    m_clsSB.Terminate
    Set m_clsSB = Nothing
    
    Erase m_clsPictures
    
    If m_hDCBack <> 0 Then
        If m_hDCBackOldBmp <> 0 Then SelectObject m_hDCBack, m_hDCBackOldBmp
        If m_hDCBackBmp <> 0 Then DeleteObject m_hDCBackBmp
        If m_hOldFont <> 0 Then SelectObject m_hDCBack, m_hOldFont
        If m_hFont <> 0 Then DeleteObject m_hFont
        If m_hOldPen <> 0 Then SelectObject m_hDCBack, m_hOldPen
        
        DeleteDC m_hDCBack
    End If
End Sub
