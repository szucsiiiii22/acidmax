VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Color"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_lngOLEColor   As ole_color
Private m_lngRGBColor   As ole_color
Private m_lngGDIBrush   As HBRUSH
Private m_lngGDIPen     As HPEN
Private m_blnGotBrush   As Boolean
Private m_blnGotPen     As Boolean

Public Property Get OLEColor() As ole_color
    OLEColor = m_lngOLEColor
End Property

Public Property Get RGBColor() As ole_color
    RGBColor = m_lngRGBColor
End Property

Public Property Get GDIBrush() As HBRUSH
    GDIBrush = m_lngGDIBrush
End Property

Public Property Get GotGDIBrush() As Boolean
    GotGDIBrush = m_blnGotBrush
End Property

Public Property Get GDIPen() As HPEN
    GDIPen = m_lngGDIPen
End Property

Public Property Get GotGDIPen() As Boolean
    GotGDIPen = m_blnGotPen
End Property

Public Sub Dispose()
    If m_blnGotBrush Then
        DeleteObject m_lngGDIBrush
        m_lngGDIBrush = INVALID_HANDLE
        m_blnGotBrush = False
    End If
    
    If m_blnGotPen Then
        DeleteObject m_lngGDIPen
        m_lngGDIPen = INVALID_HANDLE
        m_blnGotPen = False
    End If
    
    m_lngOLEColor = CLR_INVALID
    m_lngRGBColor = CLR_INVALID
End Sub

Public Sub Update()
    If m_blnGotBrush Then
        DeleteObject m_lngGDIBrush
        m_lngGDIBrush = 0
    End If
    
    If m_blnGotPen Then
        DeleteObject m_lngGDIPen
        m_lngGDIPen = 0
    End If

    If OleTranslateColor(OLEColor, 0, m_lngRGBColor) <> 0 Then
        m_lngRGBColor = INVALID_HANDLE
        m_lngGDIBrush = INVALID_HANDLE
        m_lngGDIPen = INVALID_HANDLE
        
        m_blnGotBrush = False
        m_blnGotPen = False
    Else
        If m_blnGotBrush Then
            m_lngGDIBrush = CreateSolidBrush(m_lngRGBColor)
        End If
        
        If m_blnGotPen Then
            m_lngGDIPen = CreatePen(PS_SOLID, 1, m_lngRGBColor)
        End If
    End If
End Sub

Public Function SetColor(ByVal OLEColor As ole_color, Optional ByVal CreateBrush As Boolean = False, Optional ByVal CreatePen As Boolean = False) As Boolean
    If m_blnGotBrush Then
        DeleteObject m_lngGDIBrush
        m_lngGDIBrush = 0
    End If
    
    If m_blnGotPen Then
        DeleteObject m_lngGDIPen
        m_lngGDIPen = 0
    End If
    
    m_lngOLEColor = OLEColor

    If OleTranslateColor(OLEColor, 0, m_lngRGBColor) <> 0 Then
        m_lngRGBColor = INVALID_HANDLE
        m_lngGDIBrush = INVALID_HANDLE
        m_lngGDIPen = INVALID_HANDLE
        
        m_blnGotBrush = False
        m_blnGotPen = False
        
        SetColor = False
    Else
        If CreateBrush Then
            m_lngGDIBrush = modAPI.CreateSolidBrush(m_lngRGBColor)
            m_blnGotBrush = True
        End If
        
        If CreatePen Then
            m_lngGDIPen = modAPI.CreatePen(PS_SOLID, 1, m_lngRGBColor)
            m_blnGotPen = True
        End If
        
        SetColor = True
    End If
End Function

Private Sub Class_Initialize()
    m_lngOLEColor = CLR_INVALID
    m_lngRGBColor = CLR_INVALID
End Sub

Private Sub Class_Terminate()
    Dispose
End Sub
