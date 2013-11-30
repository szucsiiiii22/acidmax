VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsToolTip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Sub InitCommonControls Lib "comctl32.dll" ()
Private Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hWndParent As Long, ByVal hMenu As Long, ByVal hInstance As Long, lpParam As Any) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function DestroyWindow Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function GetClientRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private Const WM_USER = &H400
Private Const CW_USEDEFAULT = &H80000000
Private Const SWP_NOSIZE = &H1
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_NOMOVE = &H2
Private Const HWND_TOPMOST = -1
Private Type RECT
        Left As Long
        Top As Long
        Right As Long
        Bottom As Long
End Type
Private Const TTS_NOPREFIX = &H2
Private Const TTF_TRANSPARENT = &H100
Private Const TTF_CENTERTIP = &H2
Private Const TTM_ADDTOOLA = (WM_USER + 4)
Private Const TTM_ACTIVATE = WM_USER + 1
Private Const TTM_UPDATETIPTEXTA = (WM_USER + 12)
Private Const TTM_SETMAXTIPWIDTH = (WM_USER + 24)
Private Const TTM_SETTIPBKCOLOR = (WM_USER + 19)
Private Const TTM_SETTIPTEXTCOLOR = (WM_USER + 20)
Private Const TTM_SETTITLE = (WM_USER + 32)
Private Const TTS_BALLOON = &H40
Private Const TTS_ALWAYSTIP = &H1
Private Const TTF_SUBCLASS = &H10
Private Const TOOLTIPS_CLASSA = "tooltips_class32"
Private Type TOOLINFO
    lSize As Long
    lFlags As Long
    lhWnd As Long
    lId As Long
    lpRect As RECT
    hInstance As Long
    lpStr As String
    lParam As Long
End Type
Private mvarBackColor As Long
Private mvarTitle As String
Private mvarForeColor As Long
Private mvarParentControl As Object
Private mvarIcon As ttIconType
Private mvarCentered As Boolean
Private mvarTipText As String
'Private mvarStyle As ttStyleEnum
Public Enum ttIconType
    TTNoIcon = 0
    TTIconInfo = 1
    TTIconWarning = 2
    TTIconError = 3
End Enum
Public Enum ttStyleEnum
    TTStandard
    TTBalloon
End Enum
Private lhWnd As Long
Private ti As TOOLINFO

'Public Property Let Style(ByVal vData As ttStyleEnum)
'mvarStyle = vData
'End Property

'Public Property Get Style() As ttStyleEnum
'Set Style = mvarStyle
'End Property

Public Property Let Centered(ByVal vData As Boolean)
mvarCentered = vData
End Property

Public Property Get Centered() As Boolean
Centered = mvarCentered
End Property

Public Function Create() As Boolean
Dim lpRect As RECT, lWinStyle As Long
If lhWnd <> 0 Then
    DestroyWindow lhWnd
End If
lWinStyle = TTS_ALWAYSTIP Or TTS_NOPREFIX
'If mvarStyle = TTBalloon Then lWinStyle = lWinStyle Or TTS_BALLOON
lWinStyle = TTS_BALLOON
If Not mvarParentControl Is Nothing Then
    lhWnd = CreateWindowEx(0&, TOOLTIPS_CLASSA, vbNullString, lWinStyle, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, mvarParentControl.hWnd, 0&, App.hInstance, 0&)
    SetWindowPos lhWnd, HWND_TOPMOST, 0&, 0&, 0&, 0&, SWP_NOACTIVATE Or SWP_NOSIZE Or SWP_NOMOVE
    GetClientRect mvarParentControl.hWnd, lpRect
    With ti
        If mvarCentered Then
            .lFlags = TTF_SUBCLASS Or TTF_CENTERTIP
        Else
            .lFlags = TTF_SUBCLASS
        End If
        .lhWnd = mvarParentControl.hWnd
        .lId = 0
        .hInstance = App.hInstance
        .lpRect = lpRect
    End With
    SendMessage lhWnd, TTM_ADDTOOLA, 0&, ti
    
    
    'If mvarTitle <> vbNullString Or mvarIcon <> TTNoIcon Then
    SendMessage lhWnd, TTM_SETTITLE, CLng(TTIconInfo), ByVal mvarTitle
    'End If
    If mvarForeColor <> Empty Then
        SendMessage lhWnd, TTM_SETTIPTEXTCOLOR, mvarForeColor, 0&
    End If
    If mvarBackColor <> Empty Then
        SendMessage lhWnd, TTM_SETTIPBKCOLOR, mvarBackColor, 0&
    End If
End If
End Function

Public Property Set ParentControl(ByVal vData As Object)
Set mvarParentControl = vData
End Property

Public Property Get ParentControl() As Object
Set ParentControl = mvarParentControl
End Property

'Public Property Let Icon(ByVal vData As ttIconType)
'mvarIcon = vData
'If lHwnd <> 0 And mvarTitle <> Empty And mvarIcon <> TTNoIcon Then
'    SendMessage lHwnd, TTM_SETTITLE, CLng(mvarIcon), ByVal mvarTitle
'End If
'End Property

'Public Property Get Icon() As ttIconType
'Set Icon = mvarIcon
'End Property

Public Property Let ForeColor(ByVal vData As Long)
mvarForeColor = vData
If lhWnd <> 0 Then
    SendMessage lhWnd, TTM_SETTIPTEXTCOLOR, mvarForeColor, 0&
End If
End Property

Public Property Get ForeColor() As Long
ForeColor = mvarForeColor
End Property

Public Property Let Title(ByVal vData As String)
mvarTitle = vData
If lhWnd <> 0 And mvarTitle <> Empty And mvarIcon <> TTNoIcon Then
    SendMessage lhWnd, TTM_SETTITLE, CLng(mvarIcon), ByVal mvarTitle
End If
End Property

Public Property Get Title() As String
Title = ti.lpStr
End Property

Public Property Let BackColor(ByVal vData As Long)
mvarBackColor = vData
If lhWnd <> 0 Then
    SendMessage lhWnd, TTM_SETTIPBKCOLOR, mvarBackColor, 0&
End If
End Property

Public Property Get BackColor() As Long
BackColor = mvarBackColor
End Property

Public Property Let TipText(ByVal vData As String)
ti.lpStr = vData
If lhWnd <> 0 Then
    SendMessage lhWnd, TTM_UPDATETIPTEXTA, 0&, ti
End If
End Property

Public Property Get TipText() As String
TipText = mvarTipText
End Property

Private Sub Class_Terminate()
If lhWnd <> 0 Then
    DestroyWindow lhWnd
End If
End Sub

