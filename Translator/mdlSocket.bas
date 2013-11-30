Attribute VB_Name = "mdlSocket"
Option Explicit
Public Declare Sub api_CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Public Declare Function api_WSAGetLastError Lib "ws2_32.dll" Alias "WSAGetLastError" () As Long
Public Declare Function api_GlobalAlloc Lib "kernel32" Alias "GlobalAlloc" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
Public Declare Function api_GlobalFree Lib "kernel32" Alias "GlobalFree" (ByVal hMem As Long) As Long
Private Declare Function api_WSAStartup Lib "ws2_32.dll" Alias "WSAStartup" (ByVal wVersionRequired As Long, lpWSADATA As WSAData) As Long
Private Declare Function api_WSACleanup Lib "ws2_32.dll" Alias "WSACleanup" () As Long
Private Declare Function api_WSAAsyncGetHostByName Lib "ws2_32.dll" Alias "WSAAsyncGetHostByName" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal strHostName As String, buf As Any, ByVal buflen As Long) As Long
Private Declare Function api_WSAAsyncSelect Lib "wsock32.dll" Alias "WSAAsyncSelect" (ByVal s As Long, ByVal hWnd As Long, ByVal wMsg As Long, ByVal lEvent As Long) As Long
Private Declare Function api_CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hWndParent As Long, ByVal hMenu As Long, ByVal hInstance As Long, lpParam As Any) As Long
Private Declare Function api_DestroyWindow Lib "user32" Alias "DestroyWindow" (ByVal hWnd As Long) As Long
Private Declare Function api_lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As Any) As Long
Private Declare Function api_lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As Long) As Long
Public Const SOCKET_ERROR   As Integer = -1
Public Const INVALID_SOCKET As Integer = -1
Public Const INADDR_NONE As Long = &HFFFF
Private Const WSADESCRIPTION_LEN As Integer = 257
Private Const WSASYS_STATUS_LEN  As Integer = 129
Private Enum WinsockVersion
    SOCKET_VERSION_11 = &H101
    SOCKET_VERSION_22 = &H202
End Enum
Public Const MAXGETHOSTSTRUCT = 1024
Public Const AF_INET        As Long = 2
Public Const SOCK_STREAM    As Long = 1
Public Const SOCK_DGRAM     As Long = 2
Public Const IPPROTO_TCP    As Long = 6
Public Const IPPROTO_UDP    As Long = 17
Public Const FD_READ = &H1&
Public Const FD_WRITE = &H2&
Public Const FD_ACCEPT = &H8&
Public Const FD_CONNECT = &H10&
Public Const FD_CLOSE = &H20&
Private Const OFFSET_2 = 65536
Private Const MAXINT_2 = 32767
Public Const GMEM_FIXED = &H0
Public Const LOCAL_HOST_BUFF As Integer = 256
Public Const SOL_SOCKET         As Long = 65535
Public Const SO_SNDBUF          As Long = &H1001&
Public Const SO_RCVBUF          As Long = &H1002&
Public Const SO_MAX_MSG_SIZE    As Long = &H2003
Public Const SO_BROADCAST       As Long = &H20
Public Const FIONREAD           As Long = &H4004667F
Public Const WSABASEERR         As Long = 10000
Public Const WSAEINTR           As Long = (WSABASEERR + 4)
Public Const WSAEACCES          As Long = (WSABASEERR + 13)
Public Const WSAEFAULT          As Long = (WSABASEERR + 14)
Public Const WSAEINVAL          As Long = (WSABASEERR + 22)
Public Const WSAEMFILE          As Long = (WSABASEERR + 24)
Public Const WSAEWOULDBLOCK     As Long = (WSABASEERR + 35)
Public Const WSAEINPROGRESS     As Long = (WSABASEERR + 36)
Public Const WSAEALREADY        As Long = (WSABASEERR + 37)
Public Const WSAENOTSOCK        As Long = (WSABASEERR + 38)
Public Const WSAEDESTADDRREQ    As Long = (WSABASEERR + 39)
Public Const WSAEMSGSIZE        As Long = (WSABASEERR + 40)
Public Const WSAEPROTOTYPE      As Long = (WSABASEERR + 41)
Public Const WSAENOPROTOOPT     As Long = (WSABASEERR + 42)
Public Const WSAEPROTONOSUPPORT As Long = (WSABASEERR + 43)
Public Const WSAESOCKTNOSUPPORT As Long = (WSABASEERR + 44)
Public Const WSAEOPNOTSUPP      As Long = (WSABASEERR + 45)
Public Const WSAEPFNOSUPPORT    As Long = (WSABASEERR + 46)
Public Const WSAEAFNOSUPPORT    As Long = (WSABASEERR + 47)
Public Const WSAEADDRINUSE      As Long = (WSABASEERR + 48)
Public Const WSAEADDRNOTAVAIL   As Long = (WSABASEERR + 49)
Public Const WSAENETDOWN        As Long = (WSABASEERR + 50)
Public Const WSAENETUNREACH     As Long = (WSABASEERR + 51)
Public Const WSAENETRESET       As Long = (WSABASEERR + 52)
Public Const WSAECONNABORTED    As Long = (WSABASEERR + 53)
Public Const WSAECONNRESET      As Long = (WSABASEERR + 54)
Public Const WSAENOBUFS         As Long = (WSABASEERR + 55)
Public Const WSAEISCONN         As Long = (WSABASEERR + 56)
Public Const WSAENOTCONN        As Long = (WSABASEERR + 57)
Public Const WSAESHUTDOWN       As Long = (WSABASEERR + 58)
Public Const WSAETIMEDOUT       As Long = (WSABASEERR + 60)
Public Const WSAEHOSTUNREACH    As Long = (WSABASEERR + 65)
Public Const WSAECONNREFUSED    As Long = (WSABASEERR + 61)
Public Const WSAEPROCLIM        As Long = (WSABASEERR + 67)
Public Const WSASYSNOTREADY     As Long = (WSABASEERR + 91)
Public Const WSAVERNOTSUPPORTED As Long = (WSABASEERR + 92)
Public Const WSANOTINITIALISED  As Long = (WSABASEERR + 93)
Public Const WSAHOST_NOT_FOUND  As Long = (WSABASEERR + 1001)
Public Const WSATRY_AGAIN       As Long = (WSABASEERR + 1002)
Public Const WSANO_RECOVERY     As Long = (WSABASEERR + 1003)
Public Const WSANO_DATA         As Long = (WSABASEERR + 1004)
Public Const sckOutOfMemory = 7
Public Const sckBadState = 40006
Public Const sckInvalidArg = 40014
Public Const sckUnsupported = 40018
Public Const sckInvalidOp = 40020
Private Type WSAData
   wVersion       As Integer
   wHighVersion   As Integer
   szDescription  As String * WSADESCRIPTION_LEN
   szSystemStatus As String * WSASYS_STATUS_LEN
   iMaxSockets    As Integer
   iMaxUdpDg      As Integer
   lpVendorInfo   As Long
End Type

Public Type HOSTENT
    hName     As Long
    hAliases  As Long
    hAddrType As Integer
    hLength   As Integer
    hAddrList As Long
End Type
Public Type sockaddr_in
    sin_family       As Integer
    sin_port         As Integer
    sin_addr         As Long
    sin_zero(1 To 8) As Byte
End Type
Private m_blnInitiated          As Boolean
Private m_lngSocksQuantity      As Long
Private m_colSocketsInst        As Collection
Private m_colAcceptList         As Collection
Private m_lngWindowHandle       As Long
Private Declare Function api_IsWindow Lib "user32" Alias "IsWindow" (ByVal hWnd As Long) As Long
Private Declare Function api_GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
Private Declare Function api_SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function api_GetModuleHandle Lib "kernel32" Alias "GetModuleHandleA" (ByVal lpModuleName As String) As Long
Private Declare Function api_GetProcAddress Lib "kernel32" Alias "GetProcAddress" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Private Const PATCH_06 As Long = 106
Private Const PATCH_09 As Long = 137
Private Const GWL_WNDPROC = (-4)
Private Const WM_USER = &H400
Public Const RESOLVE_MESSAGE As Long = WM_USER + &H400
Public Const SOCKET_MESSAGE  As Long = WM_USER + &H401
Private lngMsgCntA      As Long
Private lngMsgCntB      As Long
Private lngTableA1()    As Long
Private lngTableA2()    As Long
Private lngTableB1()    As Long
Private lngTableB2()    As Long
Private hWndSub         As Long
Private nAddrSubclass   As Long
Private nAddrOriginal   As Long

Public Function InitiateProcesses() As Long
On Local Error Resume Next
InitiateProcesses = 0
m_lngSocksQuantity = m_lngSocksQuantity + 1
If Not m_blnInitiated Then
    Subclass_Initialize
    m_blnInitiated = True
    Dim lngResult As Long
    lngResult = InitiateService
    If lngResult = 0 Then
        Debug.Print "OK Winsock service initiated"
    Else
        Debug.Print "ERROR trying to initiate winsock service"
        Err.Raise lngResult, "mdlSocket.InitiateProcesses", GetErrorDescription(lngResult)
        InitiateProcesses = lngResult
    End If
End If
End Function

Private Function InitiateService() As Long
On Local Error Resume Next
Dim udtWSAData As WSAData, lngResult As Long
lngResult = api_WSAStartup(SOCKET_VERSION_11, udtWSAData)
InitiateService = lngResult
End Function

Public Function FinalizeProcesses() As Long
On Local Error Resume Next
FinalizeProcesses = 0
m_lngSocksQuantity = m_lngSocksQuantity - 1
If m_blnInitiated And m_lngSocksQuantity = 0 Then
    If FinalizeService = SOCKET_ERROR Then
        Dim lngErrorCode As Long
        lngErrorCode = Err.LastDllError
        FinalizeProcesses = lngErrorCode
        Err.Raise lngErrorCode, "mdlSocket.FinalizeProcesses", GetErrorDescription(lngErrorCode)
    Else
        Debug.Print "OK Winsock service finalized"
    End If
    Subclass_Terminate
    m_blnInitiated = False
End If
End Function

Private Function FinalizeService() As Long
On Local Error Resume Next
Dim lngResultado As Long
lngResultado = api_WSACleanup
FinalizeService = lngResultado
End Function

Public Function GetErrorDescription(ByVal lngErrorCode As Long) As String
On Local Error Resume Next
Select Case lngErrorCode
Case WSAEACCES
    GetErrorDescription = "Permission denied."
Case WSAEADDRINUSE
    GetErrorDescription = "Address already in use."
Case WSAEADDRNOTAVAIL
    GetErrorDescription = "Cannot assign requested address."
Case WSAEAFNOSUPPORT
    GetErrorDescription = "Address family not supported by protocol family."
Case WSAEALREADY
    GetErrorDescription = "Operation already in progress."
Case WSAECONNABORTED
    GetErrorDescription = "Software caused connection abort."
Case WSAECONNREFUSED
    GetErrorDescription = "Connection refused."
Case WSAECONNRESET
    GetErrorDescription = "Connection reset by peer."
Case WSAEDESTADDRREQ
    GetErrorDescription = "Destination address required."
Case WSAEFAULT
    GetErrorDescription = "Bad address."
Case WSAEHOSTUNREACH
    GetErrorDescription = "No route to host."
Case WSAEINPROGRESS
    GetErrorDescription = "Operation now in progress."
Case WSAEINTR
    GetErrorDescription = "Interrupted function call."
Case WSAEINVAL
    GetErrorDescription = "Invalid argument."
Case WSAEISCONN
    GetErrorDescription = "Socket is already connected."
Case WSAEMFILE
    GetErrorDescription = "Too many open files."
Case WSAEMSGSIZE
    GetErrorDescription = "Message too long."
Case WSAENETDOWN
    GetErrorDescription = "Network is down."
Case WSAENETRESET
    GetErrorDescription = "Network dropped connection on reset."
Case WSAENETUNREACH
    GetErrorDescription = "Network is unreachable."
Case WSAENOBUFS
    GetErrorDescription = "No buffer space available."
Case WSAENOPROTOOPT
    GetErrorDescription = "Bad protocol option."
Case WSAENOTCONN
    GetErrorDescription = "Socket is not connected."
Case WSAENOTSOCK
    GetErrorDescription = "Socket operation on nonsocket."
Case WSAEOPNOTSUPP
    GetErrorDescription = "Operation not supported."
Case WSAEPFNOSUPPORT
    GetErrorDescription = "Protocol family not supported."
Case WSAEPROCLIM
    GetErrorDescription = "Too many processes."
Case WSAEPROTONOSUPPORT
    GetErrorDescription = "Protocol not supported."
Case WSAEPROTOTYPE
    GetErrorDescription = "Protocol wrong type for socket."
Case WSAESHUTDOWN
    GetErrorDescription = "Cannot send after socket shutdown."
Case WSAESOCKTNOSUPPORT
    GetErrorDescription = "Socket type not supported."
Case WSAETIMEDOUT
    GetErrorDescription = "Connection timed out."
Case WSAEWOULDBLOCK
    GetErrorDescription = "Resource temporarily unavailable."
Case WSAHOST_NOT_FOUND
    GetErrorDescription = "Host not found."
Case WSANOTINITIALISED
    GetErrorDescription = "Successful WSAStartup not yet performed."
Case WSANO_DATA
    GetErrorDescription = "Valid name, no data record of requested type."
Case WSANO_RECOVERY
    GetErrorDescription = "This is a nonrecoverable error."
Case WSASYSNOTREADY
    GetErrorDescription = "Network subsystem is unavailable."
Case WSATRY_AGAIN
    GetErrorDescription = "Nonauthoritative host not found."
Case WSAVERNOTSUPPORTED
    GetErrorDescription = "Winsock.dll version out of range."
Case Else
    GetErrorDescription = "Unknown error."
End Select
End Function

Private Function CreateWinsockMessageWindow() As Long
On Local Error Resume Next
m_lngWindowHandle = api_CreateWindowEx(0&, "STATIC", "SOCKET_WINDOW", 0&, 0&, 0&, 0&, 0&, 0&, 0&, App.hInstance, ByVal 0&)
If m_lngWindowHandle = 0 Then
    CreateWinsockMessageWindow = sckOutOfMemory
    Exit Function
Else
    CreateWinsockMessageWindow = 0
    Debug.Print "OK Created winsock message window " & m_lngWindowHandle
End If
End Function

Private Function DestroyWinsockMessageWindow() As Long
On Local Error Resume Next
DestroyWinsockMessageWindow = 0
If m_lngWindowHandle = 0 Then
    Debug.Print "WARNING lngWindowHandle is ZERO"
    Exit Function
End If
Dim lngResult As Long
lngResult = api_DestroyWindow(m_lngWindowHandle)
If lngResult = 0 Then
    DestroyWinsockMessageWindow = sckOutOfMemory
    Err.Raise sckOutOfMemory, "mdlSocket.DestroyWinsockMessageWindow", "Out of memory"
Else
    Debug.Print "OK Destroyed winsock message window " & m_lngWindowHandle
    m_lngWindowHandle = 0
End If
End Function

Public Function ResolveHost(ByVal strHost As String, ByVal lngHOSTENBuf As Long, ByVal lngObjectPointer As Long) As Long
On Local Error Resume Next
Dim lngAsynHandle As Long
lngAsynHandle = api_WSAAsyncGetHostByName(m_lngWindowHandle, RESOLVE_MESSAGE, strHost, ByVal lngHOSTENBuf, MAXGETHOSTSTRUCT)
If lngAsynHandle <> 0 Then Subclass_AddResolveMessage lngAsynHandle, lngObjectPointer
ResolveHost = lngAsynHandle
End Function

Public Function HiWord(lngValue As Long) As Long
On Local Error Resume Next
If (lngValue And &H80000000) = &H80000000 Then
    HiWord = ((lngValue And &H7FFF0000) \ &H10000) Or &H8000&
Else
    HiWord = (lngValue And &HFFFF0000) \ &H10000
End If
End Function

Public Function LoWord(lngValue As Long) As Long
On Local Error Resume Next
LoWord = (lngValue And &HFFFF&)
End Function

Public Function StringFromPointer(ByVal lPointer As Long) As String
On Local Error Resume Next
Dim strTemp As String, lRetVal As Long
strTemp = String$(api_lstrlen(ByVal lPointer), 0)
lRetVal = api_lstrcpy(ByVal strTemp, ByVal lPointer)
If lRetVal Then StringFromPointer = strTemp
End Function

Public Function UnsignedToInteger(Value As Long) As Integer
On Local Error Resume Next
If Value < 0 Or Value >= OFFSET_2 Then Error 6
If Value <= MAXINT_2 Then
    UnsignedToInteger = Value
Else
    UnsignedToInteger = Value - OFFSET_2
End If
End Function

Public Function IntegerToUnsigned(Value As Integer) As Long
On Local Error Resume Next
If Value < 0 Then
    IntegerToUnsigned = Value + OFFSET_2
Else
    IntegerToUnsigned = Value
End If
End Function

Public Function RegisterSocket(ByVal lngSocket As Long, ByVal lngObjectPointer As Long, ByVal blnEvents As Boolean) As Boolean
On Local Error Resume Next
If m_colSocketsInst Is Nothing Then
    Set m_colSocketsInst = New Collection
    Debug.Print "OK Created socket collection"
    If CreateWinsockMessageWindow <> 0 Then
        Err.Raise sckOutOfMemory, "mdlSocket.RegisterSocket", "Out of memory"
    End If
    Subclass_Subclass (m_lngWindowHandle)
End If
Subclass_AddSocketMessage lngSocket, lngObjectPointer
If blnEvents Then
    Dim lngEvents As Long, lngResult As Long, lngErrorCode As Long
    lngEvents = FD_READ Or FD_WRITE Or FD_ACCEPT Or FD_CONNECT Or FD_CLOSE
    lngResult = api_WSAAsyncSelect(lngSocket, m_lngWindowHandle, SOCKET_MESSAGE, lngEvents)
    If lngResult = SOCKET_ERROR Then
        Debug.Print "ERROR trying to register events from socket " & lngSocket
        lngErrorCode = Err.LastDllError
        Err.Raise lngErrorCode, "mdlSocket.RegisterSocket", GetErrorDescription(lngErrorCode)
    Else
        Debug.Print "OK Registered events from socket " & lngSocket
    End If
End If
m_colSocketsInst.Add lngObjectPointer, "S" & lngSocket
RegisterSocket = True
End Function

Public Sub UnregisterSocket(ByVal lngSocket As Long)
On Local Error Resume Next
Subclass_DelSocketMessage lngSocket
On Error Resume Next
m_colSocketsInst.Remove "S" & lngSocket
If m_colSocketsInst.Count = 0 Then
    Set m_colSocketsInst = Nothing
    Subclass_UnSubclass
    DestroyWinsockMessageWindow
    Debug.Print "OK Destroyed socket collection"
End If
End Sub

Public Function IsSocketRegistered(ByVal lngSocket As Long) As Boolean
On Error GoTo ErrHandler
m_colSocketsInst.Item ("S" & lngSocket)
IsSocketRegistered = True
Exit Function
ErrHandler:
    IsSocketRegistered = False
End Function

Public Sub UnregisterResolution(ByVal lngAsynHandle As Long)
On Local Error Resume Next
Subclass_DelResolveMessage lngAsynHandle
End Sub

Private Function SocketObjectFromPointer(ByVal lngPointer As Long) As clsSocket
On Local Error Resume Next
Dim objSocket As clsSocket
api_CopyMemory objSocket, lngPointer, 4&
Set SocketObjectFromPointer = objSocket
api_CopyMemory objSocket, 0&, 4&
End Function

Public Sub RegisterAccept(ByVal lngSocket As Long)
On Local Error Resume Next
If m_colAcceptList Is Nothing Then
    Set m_colAcceptList = New Collection
    Debug.Print "OK Created accept collection"
End If
Dim Socket As clsSocket
Set Socket = New clsSocket
Socket.Accept lngSocket
m_colAcceptList.Add Socket, "S" & lngSocket
End Sub

Public Function IsAcceptRegistered(ByVal lngSocket As Long) As Boolean
On Local Error GoTo ErrHandler
m_colAcceptList.Item ("S" & lngSocket)
IsAcceptRegistered = True
Exit Function
ErrHandler:
    Err.Clear
    IsAcceptRegistered = False
End Function

Public Sub UnregisterAccept(ByVal lngSocket As Long)
On Local Error Resume Next
m_colAcceptList.Remove "S" & lngSocket
If m_colAcceptList.Count = 0 Then
    Set m_colAcceptList = Nothing
    Debug.Print "OK Destroyed accept collection"
End If
End Sub

Public Function GetAcceptClass(ByVal lngSocket As Long) As clsSocket
On Local Error Resume Next
Set GetAcceptClass = m_colAcceptList("S" & lngSocket)
End Function

Private Sub Subclass_Initialize()
On Local Error Resume Next
Dim i As Long, nLen As Long, sHex As String, sCode As String
On Local Error Resume Next
Const PATCH_01 As Long = 15
Const PATCH_03 As Long = 76
Const PATCH_05 As Long = 100
Const FUNC_EBM As String = "EbMode"
Const FUNC_SWL As String = "SetWindowLongA"
Const FUNC_CWP As String = "CallWindowProcA"
Const MOD_VBA5 As String = "vba5"
Const MOD_VBA6 As String = "vba6"
Const MOD_USER As String = "user32"
sHex = "5850505589E55753515231C0EB0EE8xxxxx01x83F802742285C074258B45103D0008000074433D01080000745BE8200000005A595B5FC9C21400E813000000EBF168xxxxx02x6AFCFF750CE8xxxxx03xEBE0FF7518FF7514FF7510FF750C68xxxxx04xE8xxxxx05xC3BBxxxxx06x8B4514BFxxxxx07x89D9F2AF75B629CB4B8B1C9Dxxxxx08xEB1DBBxxxxx09x8B4514BFxxxxx0Ax89D9F2AF759729CB4B8B1C9Dxxxxx0Bx895D088B1B8B5B1C89D85A595B5FC9FFE0"
nLen = Len(sHex)
For i = 1 To nLen Step 2
    sCode = sCode & ChrB$(Val("&H" & Mid$(sHex, i, 2)))
Next i
nLen = LenB(sCode)
nAddrSubclass = api_GlobalAlloc(0, nLen)
Debug.Print "OK Subclass memory allocated at: " & nAddrSubclass
Call api_CopyMemory(ByVal nAddrSubclass, ByVal StrPtr(sCode), nLen)
If Subclass_InIDE Then
    Call api_CopyMemory(ByVal nAddrSubclass + 12, &H9090, 2)
    i = Subclass_AddrFunc(MOD_VBA6, FUNC_EBM)
    If i = 0 Then
        i = Subclass_AddrFunc(MOD_VBA5, FUNC_EBM)
    End If
    Debug.Assert i
    Call Subclass_PatchRel(PATCH_01, i)
End If
Call Subclass_PatchRel(PATCH_03, Subclass_AddrFunc(MOD_USER, FUNC_SWL))
Call Subclass_PatchRel(PATCH_05, Subclass_AddrFunc(MOD_USER, FUNC_CWP))
End Sub

Private Sub Subclass_Terminate()
On Local Error Resume Next
Call Subclass_UnSubclass
Call api_GlobalFree(nAddrSubclass)
Debug.Print "OK Freed subclass memory at: " & nAddrSubclass
nAddrSubclass = 0
ReDim lngTableA1(1 To 1)
ReDim lngTableA2(1 To 1)
ReDim lngTableB1(1 To 1)
ReDim lngTableB2(1 To 1)
End Sub

Private Function Subclass_InIDE() As Boolean
On Local Error Resume Next
Debug.Assert Subclass_SetTrue(Subclass_InIDE)
End Function

Private Function Subclass_Subclass(ByVal hWnd As Long) As Boolean
On Local Error Resume Next
Const PATCH_02 As Long = 66
Const PATCH_04 As Long = 95
If hWndSub = 0 Then
    Debug.Assert api_IsWindow(hWnd)
    hWndSub = hWnd
    nAddrOriginal = api_GetWindowLong(hWnd, GWL_WNDPROC)
    Call Subclass_PatchVal(PATCH_02, nAddrOriginal)
    Call Subclass_PatchVal(PATCH_04, nAddrOriginal)
    nAddrOriginal = api_SetWindowLong(hWnd, GWL_WNDPROC, nAddrSubclass)
    If nAddrOriginal <> 0 Then
        nAddrOriginal = 0
        Subclass_Subclass = True
    End If
End If
Debug.Assert Subclass_Subclass
End Function

Private Function Subclass_UnSubclass() As Boolean
On Local Error Resume Next
If hWndSub <> 0 Then
    lngMsgCntA = 0
    lngMsgCntB = 0
    Call Subclass_PatchVal(PATCH_06, lngMsgCntA)
    Call Subclass_PatchVal(PATCH_09, lngMsgCntB)
    Call api_SetWindowLong(hWndSub, GWL_WNDPROC, nAddrOriginal)
    hWndSub = 0
    Subclass_UnSubclass = True
End If
End Function

Private Function Subclass_AddrFunc(ByVal sDLL As String, ByVal sProc As String) As Long
On Local Error Resume Next
Subclass_AddrFunc = api_GetProcAddress(api_GetModuleHandle(sDLL), sProc)
End Function

Private Function Subclass_AddrMsgTbl(ByRef aMsgTbl() As Long) As Long
On Local Error Resume Next
Subclass_AddrMsgTbl = VarPtr(aMsgTbl(1))
On Error GoTo 0
End Function

Private Sub Subclass_PatchRel(ByVal nOffset As Long, ByVal nTargetAddr As Long)
On Local Error Resume Next
Call api_CopyMemory(ByVal (nAddrSubclass + nOffset), nTargetAddr - nAddrSubclass - nOffset - 4, 4)
End Sub

Private Sub Subclass_PatchVal(ByVal nOffset As Long, ByVal nValue As Long)
On Local Error Resume Next
Call api_CopyMemory(ByVal (nAddrSubclass + nOffset), nValue, 4)
End Sub

Private Function Subclass_SetTrue(bValue As Boolean) As Boolean
On Local Error Resume Next
Subclass_SetTrue = True
bValue = True
End Function

Private Sub Subclass_AddResolveMessage(ByVal lngAsync As Long, ByVal lngObjectPointer As Long)
On Local Error Resume Next
Dim Count As Long
For Count = 1 To lngMsgCntA
    Select Case lngTableA1(Count)
    Case -1
        lngTableA1(Count) = lngAsync
        lngTableA2(Count) = lngObjectPointer
        Exit Sub
    Case lngAsync
        Debug.Print "WARNING: Async already registered!"
        Exit Sub
    End Select
Next Count
lngMsgCntA = lngMsgCntA + 1
ReDim Preserve lngTableA1(1 To lngMsgCntA)
ReDim Preserve lngTableA2(1 To lngMsgCntA)
lngTableA1(lngMsgCntA) = lngAsync
lngTableA2(lngMsgCntA) = lngObjectPointer
Subclass_PatchTableA
End Sub

Private Sub Subclass_AddSocketMessage(ByVal lngSocket As Long, ByVal lngObjectPointer As Long)
On Local Error Resume Next
Dim Count As Long
For Count = 1 To lngMsgCntB
    Select Case lngTableB1(Count)
    Case -1
        lngTableB1(Count) = lngSocket
        lngTableB2(Count) = lngObjectPointer
        Exit Sub
    Case lngSocket
        Debug.Print "WARNING: Socket already registered!"
        Exit Sub
    End Select
Next Count
lngMsgCntB = lngMsgCntB + 1
ReDim Preserve lngTableB1(1 To lngMsgCntB)
ReDim Preserve lngTableB2(1 To lngMsgCntB)
lngTableB1(lngMsgCntB) = lngSocket
lngTableB2(lngMsgCntB) = lngObjectPointer
Subclass_PatchTableB
End Sub

Private Sub Subclass_DelResolveMessage(ByVal lngAsync As Long)
On Local Error Resume Next
Dim Count As Long
For Count = 1 To lngMsgCntA
    If lngTableA1(Count) = lngAsync Then
        lngTableA1(Count) = -1
        lngTableA2(Count) = -1
        Exit Sub
    End If
Next Count
End Sub

Private Sub Subclass_DelSocketMessage(ByVal lngSocket As Long)
On Local Error Resume Next
Dim Count As Long
For Count = 1 To lngMsgCntB
    If lngTableB1(Count) = lngSocket Then
        lngTableB1(Count) = -1
        lngTableB2(Count) = -1
        Exit Sub
    End If
Next Count
End Sub

Private Sub Subclass_PatchTableA()
On Local Error Resume Next
Const PATCH_07 As Long = 114
Const PATCH_08 As Long = 130
Call Subclass_PatchVal(PATCH_06, lngMsgCntA)
Call Subclass_PatchVal(PATCH_07, Subclass_AddrMsgTbl(lngTableA1))
Call Subclass_PatchVal(PATCH_08, Subclass_AddrMsgTbl(lngTableA2))
End Sub

Private Sub Subclass_PatchTableB()
On Local Error Resume Next
Const PATCH_0A As Long = 145
Const PATCH_0B As Long = 161
Call Subclass_PatchVal(PATCH_09, lngMsgCntB)
Call Subclass_PatchVal(PATCH_0A, Subclass_AddrMsgTbl(lngTableB1))
Call Subclass_PatchVal(PATCH_0B, Subclass_AddrMsgTbl(lngTableB2))
End Sub

Public Sub Subclass_ChangeOwner(ByVal lngSocket As Long, ByVal lngObjectPointer As Long)
On Local Error Resume Next
Dim Count As Long
For Count = 1 To lngMsgCntB
    If lngTableB1(Count) = lngSocket Then
        lngTableB2(Count) = lngObjectPointer
        Exit Sub
    End If
Next Count
End Sub
