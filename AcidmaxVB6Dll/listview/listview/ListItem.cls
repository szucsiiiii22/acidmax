VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ListItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_strText()     As String
Private m_blnSel        As Boolean
Private m_lngTag        As Long
Private m_blnChecked    As Boolean
Private m_lngPictureIdx As Long

Public Property Get PictureIndex() As Long
    PictureIndex = m_lngPictureIdx
End Property

Public Property Let PictureIndex(ByVal lngIdx As Long)
    m_lngPictureIdx = lngIdx
End Property

Public Property Get Checked() As Boolean
    Checked = m_blnChecked
End Property

Public Property Let Checked(ByVal blnVal As Boolean)
    m_blnChecked = blnVal
End Property

Public Property Get Tag() As Long
    Tag = m_lngTag
End Property

Public Property Let Tag(ByVal lngTag As Long)
    m_lngTag = lngTag
End Property

Public Property Get Selected() As Boolean
    Selected = m_blnSel
End Property

Public Property Let Selected(ByVal blnVal As Boolean)
    m_blnSel = blnVal
End Property

Public Property Get Text(ByVal Index As Long) As String
    Text = m_strText(Index)
End Property

Public Property Let Text(ByVal Index As Long, ByVal strText As String)
    m_strText(Index) = strText
End Property

Public Sub SetSubItemCount(ByVal items As Long)
    ReDim m_strText(items - 1) As String
End Sub
