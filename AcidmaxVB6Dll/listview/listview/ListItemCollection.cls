VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ListItemCollection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_clsItems()        As ListItem
Private m_lngItemCount      As Long
Private m_lngArraySize      As Long
Private m_lngColumnCount    As Long

Public Property Get ColumnCount() As Long
    ColumnCount = m_lngColumnCount
End Property

Public Property Let ColumnCount(ByVal lngValue As Long)
    m_lngColumnCount = lngValue
End Property

Public Property Get Item(ByVal index As Long) As ListItem
    Set Item = m_clsItems(index)
End Property

Public Property Get ItemCount() As Long
    ItemCount = m_lngItemCount
End Property

Public Sub Clear()
    ReDim m_clsItems(m_lngArraySize - 1) As ListItem
    m_lngItemCount = 0
End Sub

Public Sub Sort(ByVal Column As Long, ByVal Order As SortOrderConstants)
    If m_lngItemCount > 0 Then
        If Column >= 0 And Column < ColumnCount Then
            modSortCallback.SortColumn = Column
            modSortCallback.SortOrder = Order
            modShellSort.ShellSortAny VarPtr(m_clsItems(0)), m_lngItemCount, 4, AddressOf ColumnCompare
        End If
    End If
End Sub

Public Sub MoveItem(ByVal IndexFrom As Long, ByVal IndexTo As Long)
    Dim pItem   As Long
    
    CopyMemory pItem, m_clsItems(IndexFrom), 4
    
    If IndexTo > IndexFrom Then
        CopyMemory m_clsItems(IndexFrom), m_clsItems(IndexFrom + 1), 4 * (IndexTo - IndexFrom)
    ElseIf IndexTo < IndexFrom Then
        CopyMemory m_clsItems(IndexTo + 1), m_clsItems(IndexTo), 4 * (IndexFrom - IndexTo)
    End If
    
    CopyMemory ByVal VarPtr(m_clsItems(IndexTo)), pItem, 4
End Sub

Public Sub RemoveItem(ByVal index As Long)
    If index >= 0 And index <= m_lngItemCount - 1 Then
        Set m_clsItems(index) = Nothing
        CopyMemory m_clsItems(index), m_clsItems(index + 1), 4 * (m_lngItemCount - (index + 1))
        ZeroMemory m_clsItems(m_lngItemCount - 1), 4
        m_lngItemCount = m_lngItemCount - 1
    Else
        Err.Raise 9
    End If
End Sub

Public Function AddItem(Optional ByVal InsertAt As Long = -1) As ListItem
    If InsertAt > -1 Then
        CopyMemory m_clsItems(InsertAt + 1), m_clsItems(InsertAt), 4 * (m_lngItemCount - InsertAt)
        ZeroMemory m_clsItems(InsertAt), 4
        
        Set m_clsItems(InsertAt) = New ListItem
        m_clsItems(InsertAt).SetSubItemCount ColumnCount
        Set AddItem = m_clsItems(InsertAt)
    Else
        Set m_clsItems(m_lngItemCount) = New ListItem
        m_clsItems(m_lngItemCount).SetSubItemCount ColumnCount
        Set AddItem = m_clsItems(m_lngItemCount)
    End If
    
    m_lngItemCount = m_lngItemCount + 1
    If m_lngItemCount > m_lngArraySize - 1 Then
        m_lngArraySize = m_lngArraySize + (m_lngArraySize / 2)
        ReDim Preserve m_clsItems(m_lngArraySize - 1) As ListItem
    End If
End Function

Public Sub PrepareForItems(ByVal lngCount As Long)
    ReDim m_clsItems(lngCount - 1) As ListItem
    m_lngArraySize = lngCount
End Sub

Private Sub Class_Initialize()
    m_lngArraySize = 1000
    m_lngItemCount = 0
    ReDim m_clsItems(m_lngArraySize - 1) As ListItem
End Sub

