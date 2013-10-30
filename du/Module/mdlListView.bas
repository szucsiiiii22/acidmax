Attribute VB_Name = "mdlListViewEx"
Option Explicit
Private Type POINTAPI
    x As Long
    y As Long
End Type
Private Type LVITEM_lp
    mask As Long
    iItem As Long
    iSubItem As Long
    State As Long
    stateMask As Long
    pszText As Long
    cchTextMax As Long
    iImage As Long
    lParam As Long
    iIndent As Long
End Type
Private Type LVFINDINFO
    flags As Long
    psz As Long
    lParam As Long
    pt As POINTAPI
    vkDirection As Long
End Type
Private Const LVFI_PARAM As Long = &H1
Private Const LVIF_TEXT As Long = &H1
Private Const LVM_FIRST As Long = &H1000
Private Const LVM_FINDITEM As Long = (LVM_FIRST + 13)
Private Const LVM_GETITEMTEXT As Long = (LVM_FIRST + 45)
Private Const LVM_SORTITEMSEX As Long = (LVM_FIRST + 81)
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private m_uLVFI As LVFINDINFO
Private m_uLVI As LVITEM_lp
Private m_lColumn As Long
Private m_PRECEDE As Long
Private m_FOLLOW As Long

Private Function pvCompareIndex(ByVal lParam1 As Long, ByVal lParam2 As Long, ByVal hWnd As Long) As Long
On Local Error GoTo ErrHandler
If (lParam1 > lParam2) Then
    pvCompareIndex = m_PRECEDE
ElseIf (lParam1 < lParam2) Then
    pvCompareIndex = m_FOLLOW
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvCompareText(ByVal lParam1 As Long, ByVal lParam2 As Long, ByVal hWnd As Long) As Long
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
msg = LCase$(pvGetItemText(hWnd, lParam1))
msg2 = LCase$(pvGetItemText(hWnd, lParam2))
If (msg > msg2) Then
    pvCompareText = m_PRECEDE
ElseIf (msg < msg2) Then
    pvCompareText = m_FOLLOW
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvCompareTextSensitive(ByVal lParam1 As Long, ByVal lParam2 As Long, ByVal hWnd As Long) As Long
On Local Error GoTo ErrHandler
Dim msg As String, msg2 As String
msg = pvGetItemText(hWnd, lParam1)
msg2 = pvGetItemText(hWnd, lParam2)
If (msg > msg2) Then
    pvCompareTextSensitive = m_PRECEDE
ElseIf (msg < msg2) Then
    pvCompareTextSensitive = m_FOLLOW
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvCompareValue(ByVal lParam1 As Long, ByVal lParam2 As Long, ByVal hWnd As Long) As Long
On Local Error GoTo ErrHandler
Dim msg As Double, d As Double
msg = pvGetItemValue(hWnd, lParam1)
d = pvGetItemValue(hWnd, lParam2)
If (msg > d) Then
    pvCompareValue = m_PRECEDE
ElseIf (msg < d) Then
    pvCompareValue = m_FOLLOW
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvCompareDate(ByVal lParam1 As Long, ByVal lParam2 As Long, ByVal hWnd As Long) As Long
On Local Error GoTo ErrHandler
Dim a As Date, t As Date
a = pvGetItemDate(hWnd, lParam1)
t = pvGetItemDate(hWnd, lParam2)
If (a > t) Then
    pvCompareDate = m_PRECEDE
ElseIf (a < t) Then
    pvCompareDate = m_FOLLOW
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvGetItemText(ByVal hWnd As Long, ByVal lParam As Long) As String
On Local Error GoTo ErrHandler
Dim l As Long, b(261) As Byte, o As Long
With m_uLVI
    .mask = LVIF_TEXT
    .pszText = VarPtr(b(0))
    .cchTextMax = UBound(b)
    .iSubItem = m_lColumn
End With
o = SendMessage(hWnd, LVM_GETITEMTEXT, lParam, m_uLVI)
pvGetItemText = Left$(StrConv(b(), vbUnicode), o)
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvGetItemValue(ByVal hWnd As Long, ByVal lParam As Long) As Double
On Local Error GoTo ErrHandler
Dim l As Long, b(261) As Byte, o As Long
With m_uLVI
    .mask = LVIF_TEXT
    .pszText = VarPtr(b(0))
    .cchTextMax = UBound(b)
    .iSubItem = m_lColumn
End With
o = SendMessage(hWnd, LVM_GETITEMTEXT, lParam, m_uLVI)
If (o) Then
    pvGetItemValue = CDbl(Left$(StrConv(b(), vbUnicode), o))
Else
    pvGetItemValue = 0
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function pvGetItemDate(ByVal hWnd As Long, ByVal lParam As Long) As Date
On Local Error GoTo ErrHandler
Dim lIdx As Long, a(261) As Byte, sText As String, lLen As Long
With m_uLVI
    .mask = LVIF_TEXT
    .pszText = VarPtr(a(0))
    .cchTextMax = UBound(a)
    .iSubItem = m_lColumn
End With
lLen = SendMessage(hWnd, LVM_GETITEMTEXT, lParam, m_uLVI)
sText = Left$(StrConv(a(), vbUnicode), lLen)
If (IsDate(sText)) Then
    pvGetItemDate = sText
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function AddressOfFunction(lpfn As Long) As Long
On Local Error GoTo ErrHandler
AddressOfFunction = lpfn
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function Sort(ByVal hListView As Long, ByVal Column As Integer, ByVal SortOrder As eSortOrderConstants, ByVal SortType As eSortTypeConstants) As Boolean
On Local Error GoTo ErrHandler
Dim l As Long
m_lColumn = CLng(Column)
Select Case SortOrder
Case [soDefault]
    m_PRECEDE = 1
    m_FOLLOW = -1
    l = SendMessageLong(hListView, LVM_SORTITEMSEX, hListView, AddressOfFunction(AddressOf pvCompareIndex))
Case [soAscending], [soDescending]
    m_PRECEDE = SortOrder
    m_FOLLOW = -SortOrder
    Select Case SortType
    Case [stString]
        l = SendMessageLong(hListView, LVM_SORTITEMSEX, hListView, AddressOfFunction(AddressOf pvCompareText))
    Case [stStringSensitive]
        l = SendMessageLong(hListView, LVM_SORTITEMSEX, hListView, AddressOfFunction(AddressOf pvCompareTextSensitive))
    Case [stNumeric]
        l = SendMessageLong(hListView, LVM_SORTITEMSEX, hListView, AddressOfFunction(AddressOf pvCompareValue))
    Case [stDate]
        l = SendMessageLong(hListView, LVM_SORTITEMSEX, hListView, AddressOfFunction(AddressOf pvCompareDate))
    End Select
End Select
Sort = CBool(l)
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

