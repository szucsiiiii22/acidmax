Attribute VB_Name = "mdlOLE"
Option Explicit
Public Type IPAOHookStruct
    lpVTable As Long
    IPAOReal As IOleInPlaceActiveObject
    Ctl As ctlListView
    ThisPointer As Long
End Type
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function IsEqualGUID Lib "ole32" (iid1 As GUID, iid2 As GUID) As Long
Private Type GUID
    Data1 As Long
    Data2 As Integer
    Data3 As Integer
    Data4(0 To 7) As Byte
End Type
Private Const S_FALSE As Long = 1
Private Const S_OK As Long = 0
Private IID_IOleInPlaceActiveObject As GUID
Private m_IPAOVTable(9) As Long

Public Sub InitIPAO(IPAOHookStruct As IPAOHookStruct, Ctl As ctlListView)
On Local Error GoTo ErrHandler
Dim IPAO As IOleInPlaceActiveObject
With IPAOHookStruct
    Set IPAO = Ctl
    Call CopyMemory(.IPAOReal, IPAO, 4)
    Call CopyMemory(.Ctl, Ctl, 4)
    .lpVTable = GetVTable
    .ThisPointer = VarPtr(IPAOHookStruct)
End With
Exit Sub
ErrHandler:
    ProcessError "Public Sub InitIPAO(IPAOHookStruct As IPAOHookStruct, Ctl As ctlListView)", Err.Description
End Sub

Public Sub TerminateIPAO(IPAOHookStruct As IPAOHookStruct)
On Local Error GoTo ErrHandler
With IPAOHookStruct
    Call CopyMemory(.IPAOReal, 0&, 4)
    Call CopyMemory(.Ctl, 0&, 4)
End With
Exit Sub
ErrHandler:
    ProcessError "Public Sub TerminateIPAO(IPAOHookStruct As IPAOHookStruct)", Err.Description
End Sub

Private Function GetVTable() As Long
On Local Error GoTo ErrHandler
If (m_IPAOVTable(0) = 0) Then
    m_IPAOVTable(0) = AddressOfFunction(AddressOf QueryInterface)
    m_IPAOVTable(1) = AddressOfFunction(AddressOf AddRef)
    m_IPAOVTable(2) = AddressOfFunction(AddressOf Release)
    m_IPAOVTable(3) = AddressOfFunction(AddressOf GetWindow)
    m_IPAOVTable(4) = AddressOfFunction(AddressOf ContextSensitiveHelp)
    m_IPAOVTable(5) = AddressOfFunction(AddressOf TranslateAccelerator)
    m_IPAOVTable(6) = AddressOfFunction(AddressOf OnFrameWindowActivate)
    m_IPAOVTable(7) = AddressOfFunction(AddressOf OnDocWindowActivate)
    m_IPAOVTable(8) = AddressOfFunction(AddressOf ResizeBorder)
    m_IPAOVTable(9) = AddressOfFunction(AddressOf EnableModeless)
    With IID_IOleInPlaceActiveObject
        .Data1 = &H117&
        .Data4(0) = &HC0
        .Data4(7) = &H46
    End With
End If
GetVTable = VarPtr(m_IPAOVTable(0))
Exit Function
ErrHandler:
    ProcessError "Private Function GetVTable() As Long", Err.Description
End Function

Private Function AddressOfFunction(lpfn As Long) As Long
On Local Error GoTo ErrHandler
AddressOfFunction = lpfn
Exit Function
ErrHandler:
    ProcessError "Private Function AddressOfFunction(lpfn As Long) As Long", Err.Description
End Function

Private Function AddRef(This As IPAOHookStruct) As Long
On Local Error GoTo ErrHandler
AddRef = This.IPAOReal.AddRef
Exit Function
ErrHandler:
    ProcessError "Private Function AddRef(This As IPAOHookStruct) As Long", Err.Description
End Function

Private Function Release(This As IPAOHookStruct) As Long
On Local Error GoTo ErrHandler
'If Not This Is Nothing Then
If Not This.IPAOReal Is Nothing Then
    Release = This.IPAOReal.Release
End If
'End If
Exit Function
ErrHandler:
    ProcessError "Private Function Release(This As IPAOHookStruct) As Long", Err.Description
End Function

Private Function QueryInterface(This As IPAOHookStruct, riid As GUID, pvObj As Long) As Long
On Local Error GoTo ErrHandler
If (IsEqualGUID(riid, IID_IOleInPlaceActiveObject)) Then
    pvObj = This.ThisPointer
    AddRef This
    QueryInterface = 0
Else
    QueryInterface = This.IPAOReal.QueryInterface(ByVal VarPtr(riid), pvObj)
End If
Exit Function
ErrHandler:
    ProcessError "Private Function QueryInterface(This As IPAOHookStruct, riid As GUID, pvObj As Long) As Long", Err.Description
End Function

Private Function GetWindow(This As IPAOHookStruct, phwnd As Long) As Long
On Local Error GoTo ErrHandler
GetWindow = This.IPAOReal.GetWindow(phwnd)
Exit Function
ErrHandler:
    ProcessError "Private Function GetWindow(This As IPAOHookStruct, phwnd As Long) As Long", Err.Description
End Function

Private Function ContextSensitiveHelp(This As IPAOHookStruct, ByVal fEnterMode As Long) As Long
On Local Error GoTo ErrHandler
ContextSensitiveHelp = This.IPAOReal.ContextSensitiveHelp(fEnterMode)
Exit Function
ErrHandler:
    ProcessError "Private Function ContextSensitiveHelp(This As IPAOHookStruct, ByVal fEnterMode As Long) As Long", Err.Description
End Function

Private Function TranslateAccelerator(This As IPAOHookStruct, lpMsg As msg) As Long
On Local Error GoTo ErrHandler
If (This.Ctl.frTranslateAccel(lpMsg)) Then
    TranslateAccelerator = S_OK
Else
    TranslateAccelerator = This.IPAOReal.TranslateAccelerator(ByVal VarPtr(lpMsg))
End If
Exit Function
ErrHandler:
    ProcessError "Private Function TranslateAccelerator(This As IPAOHookStruct, lpMsg As msg) As Long", Err.Description
End Function

Private Function OnFrameWindowActivate(This As IPAOHookStruct, ByVal fActivate As Long) As Long
On Local Error GoTo ErrHandler
OnFrameWindowActivate = This.IPAOReal.OnFrameWindowActivate(fActivate)
Exit Function
ErrHandler:
    ProcessError "Private Function OnFrameWindowActivate(This As IPAOHookStruct, ByVal fActivate As Long) As Long", Err.Description
End Function

Private Function OnDocWindowActivate(This As IPAOHookStruct, ByVal fActivate As Long) As Long
On Local Error GoTo ErrHandler
OnDocWindowActivate = This.IPAOReal.OnDocWindowActivate(fActivate)
Exit Function
ErrHandler:
    ProcessError "Private Function OnDocWindowActivate(This As IPAOHookStruct, ByVal fActivate As Long) As Long", Err.Description
End Function

Private Function ResizeBorder(This As IPAOHookStruct, prcBorder As RECT, ByVal puiWindow As IOleInPlaceUIWindow, ByVal fFrameWindow As Long) As Long
On Local Error GoTo ErrHandler
ResizeBorder = This.IPAOReal.ResizeBorder(VarPtr(prcBorder), puiWindow, fFrameWindow)
Exit Function
ErrHandler:
    ProcessError "Private Function ResizeBorder(This As IPAOHookStruct, prcBorder As RECT, ByVal puiWindow As IOleInPlaceUIWindow, ByVal fFrameWindow As Long) As Long", Err.Description
End Function

Private Function EnableModeless(This As IPAOHookStruct, ByVal fEnable As Long) As Long
On Local Error GoTo ErrHandler
EnableModeless = This.IPAOReal.EnableModeless(fEnable)
Exit Function
ErrHandler:
    ProcessError "Private Function EnableModeless(This As IPAOHookStruct, ByVal fEnable As Long) As Long", Err.Description
End Function

