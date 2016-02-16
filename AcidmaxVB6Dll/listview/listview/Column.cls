VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Column"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_strKey            As String
Private m_strCaption        As String
Private m_udeAlign          As TextAlignConstants
Private m_lngWidth          As Long
Private m_lngWidthAutoSize  As Long
Private m_blnPushed         As Boolean
Private m_blnVisible        As Boolean
Private m_blnResizable      As Boolean
Private m_udeLastSortOrder  As SortOrderConstants

Public Property Get LastSortOrder() As SortOrderConstants
    LastSortOrder = m_udeLastSortOrder
End Property

Public Property Let LastSortOrder(ByVal udeVal As SortOrderConstants)
    m_udeLastSortOrder = udeVal
End Property

Public Property Get Pushed() As Boolean
    Pushed = m_blnPushed
End Property

Public Property Let Pushed(ByVal blnVal As Boolean)
    m_blnPushed = blnVal
End Property

Public Property Get Visible() As Boolean
    Visible = m_blnVisible
End Property

Public Property Let Visible(ByVal blnValue As Boolean)
    m_blnVisible = blnValue
End Property

Public Property Get key() As String
    key = m_strKey
End Property

Public Property Let key(ByVal strKey As String)
    m_strKey = strKey
End Property

Public Property Get Caption() As String
    Caption = m_strCaption
End Property

Public Property Let Caption(ByVal strText As String)
    m_strCaption = strText
End Property

Public Property Get TextAlign() As TextAlignConstants
    TextAlign = m_udeAlign
End Property

Public Property Let TextAlign(ByVal udeAlign As TextAlignConstants)
    m_udeAlign = udeAlign
End Property

Public Property Get Width() As Long
    Width = m_lngWidth
End Property

Public Property Let Width(ByVal lngWidth As Long)
    m_lngWidth = lngWidth
End Property

Public Property Get WidthAutoSized() As Long
    WidthAutoSized = m_lngWidthAutoSize
End Property

Public Property Let WidthAutoSized(ByVal lngWidthAuto As Long)
    m_lngWidthAutoSize = lngWidthAuto
End Property

Public Property Get Resizable() As Boolean
    Resizable = m_blnResizable
End Property

Public Property Let Resizable(ByVal blnValue As Boolean)
    m_blnResizable = blnValue
End Property
