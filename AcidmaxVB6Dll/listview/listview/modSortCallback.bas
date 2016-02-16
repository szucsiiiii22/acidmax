Attribute VB_Name = "modSortCallback"
Option Explicit

Private m_lngSortCol    As Long
Private m_udeOrder      As SortOrderConstants

Public Property Get SortColumn() As Long
    SortColumn = m_lngSortCol
End Property

Public Property Let SortColumn(ByVal lngCol As Long)
    m_lngSortCol = lngCol
End Property

Public Property Get SortOrder() As SortOrderConstants
    SortOrder = m_udeOrder
End Property

Public Property Let SortOrder(ByVal udeVal As SortOrderConstants)
    m_udeOrder = udeVal
End Property

Public Function ColumnCompare(First As ListItem, Second As ListItem, ByVal unused1 As Long, ByVal unused2 As Long) As eCompareResult
    Dim lngRet  As Long
    
    lngRet = StrComp(First.Text(m_lngSortCol), Second.Text(m_lngSortCol), vbTextCompare)
    
    If m_udeOrder = SortDescending Then
        If lngRet = -1 Then
            lngRet = 1
        ElseIf lngRet = 1 Then
            lngRet = -1
        End If
    End If
    
    ColumnCompare = lngRet
End Function
