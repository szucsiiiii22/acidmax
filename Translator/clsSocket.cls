VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSocket"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Declare Function api_socket Lib "ws2_32.dll" Alias "socket" (ByVal af As Long, ByVal s_type As Long, ByVal Protocol As Long) As Long
Private Declare Function api_GlobalLock Lib "kernel32" Alias "GlobalLock" (ByVal hMem As Long) As Long
Private Declare Function api_GlobalUnlock Lib "kernel32" Alias "GlobalUnlock" (ByVal hMem As Long) As Long
Private Declare Function api_htons Lib "ws2_32.dll" Alias "htons" (ByVal hostshort As Integer) As Integer
Private Declare Function api_ntohs Lib "ws2_32.dll" Alias "ntohs" (ByVal netshort As Integer) As Integer
Private Declare Function api_connect Lib "ws2_32.dll" Alias "connect" (ByVal s As Long, ByRef name As sockaddr_in, ByVal namelen As Long) As Long
Private Declare Function api_gethostname Lib "ws2_32.dll" Alias "gethostname" (ByVal host_name As String, ByVal namelen As Long) As Long
Private Declare Function api_gethostbyname Lib "ws2_32.dll" Alias "gethostbyname" (ByVal host_name As String) As Long
Private Declare Function api_bind Lib "ws2_32.dll" Alias "bind" (ByVal s As Long, ByRef name As sockaddr_in, ByRef namelen As Long) As Long
Private Declare Function api_getsockname Lib "ws2_32.dll" Alias "getsockname" (ByVal s As Long, ByRef name As sockaddr_in, ByRef namelen As Long) As Long
Private Declare Function api_getpeername Lib "ws2_32.dll" Alias "getpeername" (ByVal s As Long, ByRef name As sockaddr_in, ByRef namelen As Long) As Long
Private Declare Function api_inet_addr Lib "ws2_32.dll" Alias "inet_addr" (ByVal cp As String) As Long
Private Declare Function api_send Lib "ws2_32.dll" Alias "send" (ByVal s As Long, ByRef buf As Any, ByVal buflen As Long, ByVal flags As Long) As Long
Private Declare Function api_sendto Lib "ws2_32.dll" Alias "sendto" (ByVal s As Long, ByRef buf As Any, ByVal buflen As Long, ByVal flags As Long, ByRef toaddr As sockaddr_in, ByVal tolen As Long) As Long
Private Declare Function api_getsockopt Lib "ws2_32.dll" Alias "getsockopt" (ByVal s As Long, ByVal level As Long, ByVal optname As Long, optval As Any, optlen As Long) As Long
Private Declare Function api_setsockopt Lib "ws2_32.dll" Alias "setsockopt" (ByVal s As Long, ByVal level As Long, ByVal optname As Long, optval As Any, ByVal optlen As Long) As Long
Private Declare Function api_recv Lib "ws2_32.dll" Alias "recv" (ByVal s As Long, ByRef buf As Any, ByVal buflen As Long, ByVal flags As Long) As Long
Private Declare Function api_recvfrom Lib "ws2_32.dll" Alias "recvfrom" (ByVal s As Long, ByRef buf As Any, ByVal buflen As Long, ByVal flags As Long, ByRef from As sockaddr_in, ByRef fromlen As Long) As Long
Private Declare Function api_WSACancelAsyncRequest Lib "ws2_32.dll" Alias "WSACancelAsyncRequest" (ByVal hAsyncTaskHandle As Long) As Long
Private Declare Function api_listen Lib "ws2_32.dll" Alias "listen" (ByVal s As Long, ByVal backlog As Long) As Long
Private Declare Function api_accept Lib "ws2_32.dll" Alias "accept" (ByVal s As Long, ByRef addr As sockaddr_in, ByRef addrlen As Long) As Long
Private Declare Function api_inet_ntoa Lib "ws2_32.dll" Alias "inet_ntoa" (ByVal inn As Long) As Long
Private Declare Function api_gethostbyaddr Lib "ws2_32.dll" Alias "gethostbyaddr" (addr As Long, ByVal addr_len As Long, ByVal addr_type As Long) As Long
Private Declare Function api_ioctlsocket Lib "ws2_32.dll" Alias "ioctlsocket" (ByVal s As Long, ByVal cmd As Long, ByRef argp As Long) As Long
Private Declare Function api_closesocket Lib "ws2_32.dll" Alias "closesocket" (ByVal s As Long) As Long
Public Enum SockState
    sckClosed = 0
    sckOpen
    sckListening
    sckConnectionPending
    sckResolvingHost
    sckHostResolved
    sckConnecting
    sckConnected
    sckClosing
    sckError
End Enum
Public Enum DestResolucion
    destConnect = 0
End Enum
Private Const SOMAXCONN As Long = 5
Public Enum ProtocolConstants
    sckTCPProtocol = 0
    sckUDPProtocol = 1
End Enum
Private Const MSG_PEEK  As Long = &H2
Public Event CloseSck()
Public Event Connect()
Public Event ConnectionRequest(ByVal requestID As Long)
Public Event DataArrival(ByVal bytesTotal As Long)
Public Event Error(ByVal Number As Integer, Description As String, ByVal sCode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
Public Event SendComplete()
Public Event SendProgress(ByVal bytesSent As Long, ByVal bytesRemaining As Long)
Private m_lngSocketHandle       As Long
Private m_enmState              As SockState
Private m_strTag                As String
Private m_strRemoteHost         As String
Private m_lngRemotePort         As Long
Private m_strRemoteHostIP       As String
Private m_lngLocalPort          As Long
Private m_lngLocalPortBind      As Long
Private m_strLocalIP            As String
Private m_enmProtocol           As ProtocolConstants
Private m_lngMemoryPointer  As Long
Private m_lngMemoryHandle   As Long
Private m_lngSendBufferLen  As Long
Private m_lngRecvBufferLen  As Long
Private m_strSendBuffer As String
Private m_strRecvBuffer As String
Private m_blnAcceptClass As Boolean
Private m_colWaitingResolutions As Collection

Public Sub WndProc(ByVal hwnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
On Local Error Resume Next
Select Case uMsg
Case RESOLVE_MESSAGE
    PostResolution wParam, HiWord(lParam)
Case SOCKET_MESSAGE
    PostSocket LoWord(lParam), HiWord(lParam)
End Select
End Sub

Private Sub Class_Initialize()
On Local Error Resume Next
m_lngSocketHandle = INVALID_SOCKET
Set m_colWaitingResolutions = New Collection
mdlSocket.InitiateProcesses
End Sub

Private Sub Class_Terminate()
On Local Error Resume Next
CleanResolutionSystem
If Not m_blnAcceptClass Then DestroySocket
mdlSocket.FinalizeProcesses
Set m_colWaitingResolutions = Nothing
End Sub

Public Property Get RemotePort() As Long
On Local Error Resume Next
RemotePort = m_lngRemotePort
End Property

Public Property Let RemotePort(ByVal lngPort As Long)
On Local Error Resume Next
If m_enmProtocol = sckTCPProtocol And m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.RemotePort", "Invalid operation at current state"
End If
If lngPort < 0 Or lngPort > 65535 Then
    Err.Raise sckInvalidArg, "clsSocket.RemotePort", "The argument passed to a function was not in the correct format or in the specified range."
Else
    m_lngRemotePort = lngPort
End If
End Property

Public Property Get RemoteHost() As String
On Local Error Resume Next
RemoteHost = m_strRemoteHost
End Property

Public Property Let RemoteHost(ByVal strHost As String)
On Local Error Resume Next
If m_enmProtocol = sckTCPProtocol And m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.RemoteHost", "Invalid operation at current state"
End If
m_strRemoteHost = strHost
End Property

Public Property Get RemoteHostIP() As String
On Local Error Resume Next
RemoteHostIP = m_strRemoteHostIP
End Property

Public Property Get LocalPort() As Long
On Local Error Resume Next
If m_lngLocalPortBind = 0 Then
    LocalPort = m_lngLocalPort
Else
    LocalPort = m_lngLocalPortBind
End If
End Property

Public Property Let LocalPort(ByVal lngPort As Long)
On Local Error Resume Next
If m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.LocalPort", "Invalid operation at current state"
End If
If lngPort < 0 Or lngPort > 65535 Then
    Err.Raise sckInvalidArg, "clsSocket.LocalPort", "The argument passed to a function was not in the correct format or in the specified range."
Else
    m_lngLocalPort = lngPort
End If
End Property

Public Property Get State() As SockState
On Local Error Resume Next
State = m_enmState
End Property

Public Property Get LocalHostName() As String
On Local Error Resume Next
LocalHostName = GetLocalHostName
End Property

Public Property Get LocalIP() As String
On Local Error Resume Next
If m_enmState = sckOpen Or m_enmState = sckListening Then
    LocalIP = m_strLocalIP
Else
    LocalIP = GetLocalIP
End If
End Property

Public Property Get BytesReceived() As Long
On Local Error Resume Next
If m_enmProtocol = sckTCPProtocol Then
    BytesReceived = Len(m_strRecvBuffer)
Else
    BytesReceived = GetBufferLenUDP
End If
End Property

Public Property Get SocketHandle() As Long
On Local Error Resume Next
SocketHandle = m_lngSocketHandle
End Property

Public Property Get Tag() As String
On Local Error Resume Next
Tag = m_strTag
End Property

Public Property Let Tag(ByVal strTag As String)
On Local Error Resume Next
m_strTag = strTag
End Property

Public Property Get Protocol() As ProtocolConstants
On Local Error Resume Next
Protocol = m_enmProtocol
End Property

Public Property Let Protocol(ByVal enmProtocol As ProtocolConstants)
On Local Error Resume Next
If m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.Protocol", "Invalid operation at current state"
Else
    m_enmProtocol = enmProtocol
End If
End Property

Private Sub DestroySocket()
On Local Error Resume Next
If Not m_lngSocketHandle = INVALID_SOCKET Then
    Dim lngResult As Long
    lngResult = api_closesocket(m_lngSocketHandle)
    If lngResult = SOCKET_ERROR Then
        m_enmState = sckError: Debug.Print "STATE: sckError"
        Dim lngErrorCode As Long
        lngErrorCode = Err.LastDllError
        Err.Raise lngErrorCode, "clsSocket.DestroySocket", GetErrorDescription(lngErrorCode)
    Else
        Debug.Print "OK Destroyed socket " & m_lngSocketHandle
        mdlSocket.UnregisterSocket m_lngSocketHandle
        m_lngSocketHandle = INVALID_SOCKET
    End If
End If
End Sub

Public Sub CloseSck()
On Local Error Resume Next
If m_lngSocketHandle = INVALID_SOCKET Then Exit Sub
m_enmState = sckClosing: Debug.Print "STATE: sckClosing"
CleanResolutionSystem
DestroySocket
m_lngLocalPortBind = 0
m_strRemoteHostIP = ""
m_strRecvBuffer = ""
m_strSendBuffer = ""
m_lngSendBufferLen = 0
m_lngRecvBufferLen = 0
m_enmState = sckClosed: Debug.Print "STATE: sckClosed"
End Sub

Private Function SocketExists() As Boolean
On Local Error Resume Next
SocketExists = True
Dim lngResult As Long, lngErrorCode As Long
If m_lngSocketHandle = INVALID_SOCKET Then
    If m_enmProtocol = sckTCPProtocol Then
        lngResult = api_socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    Else
        lngResult = api_socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
    End If
    If lngResult = INVALID_SOCKET Then
        m_enmState = sckError: Debug.Print "STATE: sckError"
        Debug.Print "ERROR trying to create socket"
        SocketExists = False
        lngErrorCode = Err.LastDllError
        Dim blnCancelDisplay As Boolean
        blnCancelDisplay = True
        RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.SocketExists", "", 0, blnCancelDisplay)
        If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.SocketExists"
    Else
        Debug.Print "OK Created socket: " & lngResult
        m_lngSocketHandle = lngResult
        ProcessOptions
        SocketExists = mdlSocket.RegisterSocket(m_lngSocketHandle, ObjPtr(Me), True)
    End If
End If
End Function

Public Sub Connect(Optional RemoteHost As Variant, Optional RemotePort As Variant)
On Local Error Resume Next
If m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.Connect", "Invalid operation at current state"
End If
If Not IsMissing(RemoteHost) Then
    m_strRemoteHost = CStr(RemoteHost)
End If
If m_strRemoteHost = vbNullString Then
    m_strRemoteHost = ""
End If
If Not IsMissing(RemotePort) Then
    If IsNumeric(RemotePort) Then
        If CLng(RemotePort) > 65535 Or CLng(RemotePort) < 1 Then
            Err.Raise sckInvalidArg, "clsSocket.Connect", "The argument passed to a function was not in the correct format or in the specified range."
        Else
            m_lngRemotePort = CLng(RemotePort)
        End If
    Else
        Err.Raise sckUnsupported, "clsSocket.Connect", "Unsupported variant type."
    End If
End If
If Not SocketExists Then Exit Sub
If m_enmProtocol = sckUDPProtocol Then
    If BindInternal Then
        m_enmState = sckOpen: Debug.Print "STATE: sckOpen"
    End If
    Exit Sub
End If
Dim lngAddress As Long
lngAddress = ResolveIfHostname(m_strRemoteHost, destConnect)
If lngAddress <> vbNull Then
    ConnectToIP lngAddress, 0
End If
End Sub

Private Sub PostResolution(ByVal lngAsynHandle As Long, ByVal lngErrorCode As Long)
On Local Error Resume Next
If m_enmState <> sckResolvingHost Then Exit Sub
Dim enmDestination As DestResolucion
enmDestination = m_colWaitingResolutions.Item("R" & lngAsynHandle)
m_colWaitingResolutions.Remove "R" & lngAsynHandle
If lngErrorCode = 0 Then
    m_enmState = sckHostResolved: Debug.Print "STATE: sckHostResolved"
    Dim udtHostent As HOSTENT, lngPtrToIP As Long, arrIpAddress(1 To 4) As Byte, lngRemoteHostAddress As Long, Count As Integer, strIpAddress As String
    api_CopyMemory udtHostent, ByVal m_lngMemoryPointer, LenB(udtHostent)
    api_CopyMemory lngPtrToIP, ByVal udtHostent.hAddrList, 4
    api_CopyMemory arrIpAddress(1), ByVal lngPtrToIP, 4
    api_CopyMemory lngRemoteHostAddress, ByVal lngPtrToIP, 4
    FreeMemory
    For Count = 1 To 4
        strIpAddress = strIpAddress & arrIpAddress(Count) & "."
    Next
    strIpAddress = Left$(strIpAddress, Len(strIpAddress) - 1)
    Select Case enmDestination
    Case destConnect
        ConnectToIP lngRemoteHostAddress, 0
    End Select
Else
    FreeMemory
    Select Case enmDestination
    Case destConnect
        ConnectToIP vbNull, lngErrorCode
    End Select
End If
End Sub

Private Sub PostSocket(ByVal lngEventID As Long, ByVal lngErrorCode As Long)
On Local Error Resume Next
If lngErrorCode <> 0 Then
    m_enmState = sckError: Debug.Print "STATE: sckError"
    Dim blnCancelDisplay As Boolean
    blnCancelDisplay = True
    RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.PostSocket", "", 0, blnCancelDisplay)
    If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.PostSocket"
    Exit Sub
End If
Dim udtSockAddr As sockaddr_in, lngResult As Long, lngBytesReceived As Long
Select Case lngEventID
Case FD_CONNECT
    Debug.Print "FD_CONNECT " & m_lngSocketHandle
    If m_enmState <> sckConnecting Then
        Debug.Print "WARNING: Omitting FD_CONNECT"
        Exit Sub
    End If
    lngResult = api_getpeername(m_lngSocketHandle, udtSockAddr, LenB(udtSockAddr))
    If lngResult = 0 Then
        m_lngRemotePort = mdlSocket.IntegerToUnsigned(api_ntohs(udtSockAddr.sin_port))
        m_strRemoteHostIP = StringFromPointer(api_inet_ntoa(udtSockAddr.sin_addr))
    End If
    m_enmState = sckConnected: Debug.Print "STATE: sckConnected"
    RaiseEvent Connect
Case FD_WRITE
    Debug.Print "FD_WRITE " & m_lngSocketHandle
    If m_enmState <> sckConnected Then
        Debug.Print "WARNING: Omitting FD_WRITE"
        Exit Sub
    End If
    If Len(m_strSendBuffer) > 0 Then
        SendBufferedData
    End If
Case FD_READ
    Debug.Print "FD_READ " & m_lngSocketHandle
    If m_enmProtocol = sckTCPProtocol Then
        If m_enmState <> sckConnected Then
            Debug.Print "WARNING: Omitting FD_READ"
            Exit Sub
        End If
        lngBytesReceived = RecvDataToBuffer
        If lngBytesReceived > 0 Then
            RaiseEvent DataArrival(Len(m_strRecvBuffer))
        End If
    Else
        If m_enmState <> sckOpen Then
            Debug.Print "WARNING: Omitting FD_READ"
            Exit Sub
        End If
        lngBytesReceived = GetBufferLenUDP
        If lngBytesReceived > 0 Then
            RaiseEvent DataArrival(lngBytesReceived)
        End If
        EmptyBuffer
    End If
Case FD_ACCEPT
    Debug.Print "FD_ACCEPT " & m_lngSocketHandle
    If m_enmState <> sckListening Then
        Debug.Print "WARNING: Omitting FD_ACCEPT"
        Exit Sub
    End If
    lngResult = api_accept(m_lngSocketHandle, udtSockAddr, LenB(udtSockAddr))
    If lngResult = INVALID_SOCKET Then
        lngErrorCode = Err.LastDllError
        Err.Raise lngErrorCode, "clsSocket.PostSocket", GetErrorDescription(lngErrorCode)
    Else
        mdlSocket.RegisterAccept lngResult
        Dim lngTempRP As Long, strTempRHIP As String, strTempRH As String
        lngTempRP = m_lngRemotePort
        strTempRHIP = m_strRemoteHostIP
        strTempRH = m_strRemoteHost
        GetRemoteInfo lngResult, m_lngRemotePort, m_strRemoteHostIP, m_strRemoteHost
        Debug.Print "OK Accepted socket: " & lngResult
        RaiseEvent ConnectionRequest(lngResult)
        If m_enmState = sckListening Then
             m_lngRemotePort = lngTempRP
             m_strRemoteHostIP = strTempRHIP
             m_strRemoteHost = strTempRH
        End If
        If IsAcceptRegistered(lngResult) Then
            api_closesocket lngResult
            mdlSocket.UnregisterSocket lngResult
            mdlSocket.UnregisterAccept lngResult
            Debug.Print "OK Closed accepted socket: " & lngResult
        End If
    End If
Case FD_CLOSE
    Debug.Print "FD_CLOSE " & m_lngSocketHandle
    If m_enmState <> sckConnected Then
        Debug.Print "WARNING: Omitting FD_CLOSE"
        Exit Sub
    End If
    m_enmState = sckClosing: Debug.Print "STATE: sckClosing"
    RaiseEvent CloseSck
End Select
End Sub

Private Sub ConnectToIP(ByVal lngRemoteHostAddress As Long, ByVal lngErrorCode As Long)
On Local Error Resume Next
Dim blnCancelDisplay As Boolean
If lngErrorCode <> 0 Then
    m_enmState = sckError: Debug.Print "STATE: sckError"
    blnCancelDisplay = True
    RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.ConnectToIP", "", 0, blnCancelDisplay)
    If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.ConnectToIP"
    Exit Sub
End If
If Not BindInternal Then Exit Sub
Debug.Print "OK Connecting to: " + m_strRemoteHost + " " + m_strRemoteHostIP
m_enmState = sckConnecting: Debug.Print "STATE: sckConnecting"
Dim udtSockAddr As sockaddr_in
Dim lngResult As Long
With udtSockAddr
    .sin_addr = lngRemoteHostAddress
    .sin_family = AF_INET
    .sin_port = api_htons(mdlSocket.UnsignedToInteger(m_lngRemotePort))
End With
lngResult = api_connect(m_lngSocketHandle, udtSockAddr, LenB(udtSockAddr))
If lngResult = SOCKET_ERROR Then
    lngErrorCode = Err.LastDllError
    If lngErrorCode <> WSAEWOULDBLOCK Then
        If lngErrorCode = WSAEADDRNOTAVAIL Then
            Err.Raise WSAEADDRNOTAVAIL, "clsSocket.ConnectToIP", GetErrorDescription(WSAEADDRNOTAVAIL)
        Else
            m_enmState = sckError: Debug.Print "STATE: sckError"
            blnCancelDisplay = True
            RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.ConnectToIP", "", 0, blnCancelDisplay)
            If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.ConnectToIP"
        End If
    End If
End If
End Sub

Public Sub Bind(Optional LocalPort As Variant, Optional LocalIP As Variant)
On Local Error Resume Next
If m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.Bind", "Invalid operation at current state"
End If
If BindInternal(LocalPort, LocalIP) Then
    m_enmState = sckOpen: Debug.Print "STATE: sckOpen"
End If
End Sub

Private Function BindInternal(Optional ByVal varLocalPort As Variant, Optional ByVal varLocalIP As Variant) As Boolean
On Local Error Resume Next
If m_enmState = sckOpen Then
    BindInternal = True
    Exit Function
End If
Dim lngLocalPortInternal As Long, strLocalHostInternal As String, strIP As String, lngAddressInternal As Long, lngResult As Long, lngErrorCode As Long
BindInternal = False
If Not IsMissing(varLocalPort) Then
    If IsNumeric(varLocalPort) Then
        If varLocalPort < 0 Or varLocalPort > 65535 Then
            BindInternal = False
            Err.Raise sckInvalidArg, "clsSocket.BindInternal", "The argument passed to a function was not in the correct format or in the specified range."
        Else
            lngLocalPortInternal = CLng(varLocalPort)
        End If
    Else
        BindInternal = False
        Err.Raise sckUnsupported, "clsSocket.BindInternal", "Unsupported variant type."
    End If
Else
    lngLocalPortInternal = m_lngLocalPort
End If
If Not IsMissing(varLocalIP) Then
    If varLocalIP <> vbNullString Then
        strLocalHostInternal = CStr(varLocalIP)
    Else
        strLocalHostInternal = GetLocalIP
    End If
Else
    strLocalHostInternal = GetLocalIP
End If
lngAddressInternal = ResolveIfHostnameSync(strLocalHostInternal, strIP, lngResult)
If lngResult <> 0 Then
    Err.Raise sckInvalidArg, "clsSocket.BindInternal", "Invalid argument"
End If
If Not SocketExists Then Exit Function
Dim udtSockAddr As sockaddr_in
With udtSockAddr
    .sin_addr = lngAddressInternal
    .sin_family = AF_INET
    .sin_port = api_htons(mdlSocket.UnsignedToInteger(lngLocalPortInternal))
End With
lngResult = api_bind(m_lngSocketHandle, udtSockAddr, LenB(udtSockAddr))
If lngResult = SOCKET_ERROR Then
    lngErrorCode = Err.LastDllError
    Err.Raise lngErrorCode, "clsSocket.BindInternal", GetErrorDescription(lngErrorCode)
Else
    m_strLocalIP = strIP
    If lngLocalPortInternal <> 0 Then
        Debug.Print "OK Bind HOST: " & strLocalHostInternal & " PORT: " & lngLocalPortInternal
        m_lngLocalPort = lngLocalPortInternal
    Else
        lngResult = GetLocalPort(m_lngSocketHandle)
        If lngResult = SOCKET_ERROR Then
            lngErrorCode = Err.LastDllError
            Err.Raise lngErrorCode, "clsSocket.BindInternal", GetErrorDescription(lngErrorCode)
        Else
            Debug.Print "OK Bind HOST: " & strLocalHostInternal & " PORT: " & lngResult
            m_lngLocalPortBind = lngResult
        End If
        
    End If
    
    BindInternal = True
End If
End Function

Private Function AllocateMemory() As Long
On Local Error Resume Next
m_lngMemoryHandle = api_GlobalAlloc(GMEM_FIXED, MAXGETHOSTSTRUCT)
If m_lngMemoryHandle <> 0 Then
    m_lngMemoryPointer = api_GlobalLock(m_lngMemoryHandle)
    If m_lngMemoryPointer <> 0 Then
        api_GlobalUnlock (m_lngMemoryHandle)
        AllocateMemory = m_lngMemoryPointer
    Else
        api_GlobalFree (m_lngMemoryHandle)
        AllocateMemory = m_lngMemoryPointer '0
    End If
Else
    AllocateMemory = m_lngMemoryHandle '0
End If
End Function

Private Sub FreeMemory()
On Local Error Resume Next
If m_lngMemoryHandle <> 0 Then
    m_lngMemoryHandle = 0
    m_lngMemoryPointer = 0
    api_GlobalFree m_lngMemoryHandle
End If
End Sub

Private Function GetLocalHostName() As String
On Local Error Resume Next
Dim strHostNameBuf As String * LOCAL_HOST_BUFF
Dim lngResult As Long
lngResult = api_gethostname(strHostNameBuf, LOCAL_HOST_BUFF)
If lngResult = SOCKET_ERROR Then
    GetLocalHostName = vbNullString
    Dim lngErrorCode As Long
    lngErrorCode = Err.LastDllError
    Err.Raise lngErrorCode, "clsSocket.GetLocalHostName", GetErrorDescription(lngErrorCode)
Else
    GetLocalHostName = Left(strHostNameBuf, InStr(1, strHostNameBuf, Chr(0)) - 1)
End If
End Function

Private Function GetLocalIP() As String
On Local Error Resume Next
Dim lngResult As Long, lngPtrToIP As Long, strLocalHost As String, arrIpAddress(1 To 4) As Byte, Count As Integer, udtHostent As HOSTENT, strIpAddress As String
strLocalHost = GetLocalHostName
lngResult = api_gethostbyname(strLocalHost)
If lngResult = 0 Then
    GetLocalIP = vbNullString
    Dim lngErrorCode As Long
    lngErrorCode = Err.LastDllError
    Err.Raise lngErrorCode, "clsSocket.GetLocalIP", GetErrorDescription(lngErrorCode)
Else
    api_CopyMemory udtHostent, ByVal lngResult, LenB(udtHostent)
    api_CopyMemory lngPtrToIP, ByVal udtHostent.hAddrList, 4
    api_CopyMemory arrIpAddress(1), ByVal lngPtrToIP, 4
    For Count = 1 To 4
        strIpAddress = strIpAddress & arrIpAddress(Count) & "."
    Next
    strIpAddress = Left$(strIpAddress, Len(strIpAddress) - 1)
    GetLocalIP = strIpAddress
End If
End Function

Private Function ResolveIfHostname(ByVal Host As String, ByVal enmDestination As DestResolucion) As Long
On Local Error Resume Next
Dim lngAddress As Long
lngAddress = api_inet_addr(Host)
If lngAddress = INADDR_NONE Then
    ResolveIfHostname = vbNull
    m_enmState = sckResolvingHost: Debug.Print "STATE: sckResolvingHost"
    If AllocateMemory Then
        Dim lngAsynHandle As Long
        lngAsynHandle = mdlSocket.ResolveHost(Host, m_lngMemoryPointer, ObjPtr(Me))
        If lngAsynHandle = 0 Then
            FreeMemory
            m_enmState = sckError: Debug.Print "STATE: sckError"
            Dim lngErrorCode As Long
            lngErrorCode = Err.LastDllError
            Dim blnCancelDisplay As Boolean
            blnCancelDisplay = True
            RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.ResolveIfHostname", "", 0, blnCancelDisplay)
            If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.ResolveIfHostname"
        Else
            m_colWaitingResolutions.Add enmDestination, "R" & lngAsynHandle
            Debug.Print "Resolving host " & Host; " with handle " & lngAsynHandle
        End If
    Else
        m_enmState = sckError: Debug.Print "STATE: sckError"
        Debug.Print "Error trying to allocate memory"
        Err.Raise sckOutOfMemory, "clsSocket.ResolveIfHostname", "Out of memory"
    End If
Else
    ResolveIfHostname = lngAddress
End If
End Function

Private Function ResolveIfHostnameSync(ByVal Host As String, ByRef strHostIP As String, ByRef lngErrorCode As Long) As Long
On Local Error Resume Next
Dim lngPtrToHOSTENT As Long, udtHostent As HOSTENT, lngAddress As Long, lngPtrToIP As Long, arrIpAddress(1 To 4) As Byte, Count As Integer
If Host = vbNullString Then
    strHostIP = vbNullString
    lngErrorCode = WSAEAFNOSUPPORT
    ResolveIfHostnameSync = vbNull
    Exit Function
End If
lngAddress = api_inet_addr(Host)
If lngAddress = INADDR_NONE Then
    lngPtrToHOSTENT = api_gethostbyname(Host)
    If lngPtrToHOSTENT = 0 Then
        lngErrorCode = Err.LastDllError
        strHostIP = vbNullString
        ResolveIfHostnameSync = vbNull
    Else
        api_CopyMemory udtHostent, ByVal lngPtrToHOSTENT, LenB(udtHostent)
        api_CopyMemory lngPtrToIP, ByVal udtHostent.hAddrList, 4
        api_CopyMemory arrIpAddress(1), ByVal lngPtrToIP, 4
        api_CopyMemory lngAddress, ByVal lngPtrToIP, 4
        For Count = 1 To 4
            strHostIP = strHostIP & arrIpAddress(Count) & "."
        Next
        strHostIP = Left$(strHostIP, Len(strHostIP) - 1)
        lngErrorCode = 0
        ResolveIfHostnameSync = lngAddress
    End If
Else
    lngErrorCode = 0
    strHostIP = Host
    ResolveIfHostnameSync = lngAddress
End If
End Function

Private Function GetLocalPort(ByVal lngSocket As Long) As Long
On Local Error Resume Next
Dim udtSockAddr As sockaddr_in, lngResult As Long
lngResult = api_getsockname(lngSocket, udtSockAddr, LenB(udtSockAddr))
If lngResult = SOCKET_ERROR Then
    GetLocalPort = SOCKET_ERROR
Else
    GetLocalPort = mdlSocket.IntegerToUnsigned(api_ntohs(udtSockAddr.sin_port))
End If
End Function

Public Sub SendData(data As Variant)
On Local Error Resume Next
Dim arrData() As Byte
If m_enmProtocol = sckTCPProtocol Then
    If m_enmState <> sckConnected Then
        Err.Raise sckBadState, "clsSocket.SendData", "Wrong protocol or connection state for the requested transaction or request"
        Exit Sub
    End If
Else
    If Not SocketExists Then Exit Sub
    If Not BindInternal Then Exit Sub
    m_enmState = sckOpen: Debug.Print "STATE: sckOpen"
End If
Select Case varType(data)
Case vbString
    Dim strdata As String
    strdata = CStr(data)
    If Len(strdata) = 0 Then Exit Sub
    ReDim arrData(Len(strdata) - 1)
    arrData() = StrConv(strdata, vbFromUnicode)
Case vbArray + vbByte
    Dim strArray As String
    strArray = StrConv(data, vbUnicode)
    If Len(strArray) = 0 Then Exit Sub
    arrData() = StrConv(strArray, vbFromUnicode)
Case vbBoolean
    Dim blnData As Boolean
    blnData = CBool(data)
    ReDim arrData(LenB(blnData) - 1)
    api_CopyMemory arrData(0), blnData, LenB(blnData)
Case vbByte
    Dim bytData As Byte
    bytData = CByte(data)
    ReDim arrData(LenB(bytData) - 1)
    api_CopyMemory arrData(0), bytData, LenB(bytData)
Case vbCurrency
    Dim curData As Currency
    curData = CCur(data)
    ReDim arrData(LenB(curData) - 1)
    api_CopyMemory arrData(0), curData, LenB(curData)
Case vbDate
    Dim datData As Date
    datData = CDate(data)
    ReDim arrData(LenB(datData) - 1)
    api_CopyMemory arrData(0), datData, LenB(datData)
Case vbDouble
    Dim dblData As Double
    dblData = CDbl(data)
    ReDim arrData(LenB(dblData) - 1)
    api_CopyMemory arrData(0), dblData, LenB(dblData)
Case vbInteger
    Dim intData As Integer
    intData = CInt(data)
    ReDim arrData(LenB(intData) - 1)
    api_CopyMemory arrData(0), intData, LenB(intData)
Case vbLong
    Dim lngData As Long
    lngData = CLng(data)
    ReDim arrData(LenB(lngData) - 1)
    api_CopyMemory arrData(0), lngData, LenB(lngData)
Case vbSingle
    Dim sngData As Single
    sngData = CSng(data)
    ReDim arrData(LenB(sngData) - 1)
    api_CopyMemory arrData(0), sngData, LenB(sngData)
Case Else
    Err.Raise sckUnsupported, "clsSocket.SendData", "Unsupported variant type."
End Select
If Len(m_strSendBuffer) > 0 Then
    m_strSendBuffer = m_strSendBuffer + StrConv(arrData(), vbUnicode)
    Exit Sub
Else
    m_strSendBuffer = m_strSendBuffer + StrConv(arrData(), vbUnicode)
End If
SendBufferedData
End Sub

Private Sub SendBufferedData()
On Local Error Resume Next
If m_enmProtocol = sckTCPProtocol Then
    SendBufferedDataTCP
Else
    SendBufferedDataUDP
End If
End Sub

Private Sub SendBufferedDataUDP()
On Local Error Resume Next
Dim lngAddress As Long, udtSockAddr As sockaddr_in, arrData() As Byte, lngBufferLength As Long, lngResult As Long, lngErrorCode As Long, strTemp As String
lngAddress = ResolveIfHostnameSync(m_strRemoteHost, strTemp, lngErrorCode)
If lngErrorCode <> 0 Then
    m_strSendBuffer = ""
    If lngErrorCode = WSAEAFNOSUPPORT Then
        Err.Raise lngErrorCode, "clsSocket.SendBufferedDataUDP", GetErrorDescription(lngErrorCode)
    Else
        Err.Raise sckInvalidArg, "clsSocket.SendBufferedDataUDP", "Invalid argument"
    End If
End If
With udtSockAddr
    .sin_addr = lngAddress
    .sin_family = AF_INET
    .sin_port = api_htons(mdlSocket.UnsignedToInteger(m_lngRemotePort))
End With
lngBufferLength = Len(m_strSendBuffer)
arrData() = StrConv(m_strSendBuffer, vbFromUnicode)
m_strSendBuffer = ""
lngResult = api_sendto(m_lngSocketHandle, arrData(0), lngBufferLength, 0&, udtSockAddr, LenB(udtSockAddr))
If lngResult = SOCKET_ERROR Then
    lngErrorCode = Err.LastDllError
    m_enmState = sckError: Debug.Print "STATE: sckError"
    Dim blnCancelDisplay As Boolean
    blnCancelDisplay = True
    RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.SendBufferedDataUDP", "", 0, blnCancelDisplay)
    If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.SendBufferedDataUDP"
End If
End Sub

Private Sub SendBufferedDataTCP()
On Local Error Resume Next
Dim arrData() As Byte, lngBufferLength As Long, lngResult As Long, lngTotalSent As Long
Do Until lngResult = SOCKET_ERROR Or Len(m_strSendBuffer) = 0
    lngBufferLength = Len(m_strSendBuffer)
    If lngBufferLength > m_lngSendBufferLen Then
        lngBufferLength = m_lngSendBufferLen
        arrData() = StrConv(Left$(m_strSendBuffer, m_lngSendBufferLen), vbFromUnicode)
    Else
        arrData() = StrConv(m_strSendBuffer, vbFromUnicode)
    End If
    lngResult = api_send(m_lngSocketHandle, arrData(0), lngBufferLength, 0&)
    If lngResult = SOCKET_ERROR Then
        Dim lngErrorCode As Long
        lngErrorCode = Err.LastDllError
        If lngErrorCode = WSAEWOULDBLOCK Then
            Debug.Print "WARNING: Send buffer full, waiting..."
            If lngTotalSent > 0 Then RaiseEvent SendProgress(lngTotalSent, Len(m_strSendBuffer))
        Else
            m_enmState = sckError: Debug.Print "STATE: sckError"
            Dim blnCancelDisplay As Boolean
            blnCancelDisplay = True
            RaiseEvent Error(lngErrorCode, GetErrorDescription(lngErrorCode), 0, "clsSocket.SendBufferedData", "", 0, blnCancelDisplay)
            If blnCancelDisplay = False Then MsgBox GetErrorDescription(lngErrorCode), vbOKOnly, "clsSocket.SendBufferedData"
        End If
    Else
        Debug.Print "OK Bytes sent: " & lngResult
        lngTotalSent = lngTotalSent + lngResult
        If Len(m_strSendBuffer) > lngResult Then
            m_strSendBuffer = Mid$(m_strSendBuffer, lngResult + 1)
        Else
            Debug.Print "OK Finished SENDING"
            m_strSendBuffer = ""
            Dim lngTemp As Long
            lngTemp = lngTotalSent
            lngTotalSent = 0
            RaiseEvent SendProgress(lngTemp, 0)
            RaiseEvent SendComplete
        End If
    End If
Loop
End Sub

Private Function RecvDataToBuffer() As Long
On Local Error Resume Next
Dim arrBuffer() As Byte, lngBytesReceived As Long, strBuffTemporal As String
ReDim arrBuffer(m_lngRecvBufferLen - 1)
lngBytesReceived = api_recv(m_lngSocketHandle, arrBuffer(0), m_lngRecvBufferLen, 0&)
If lngBytesReceived = SOCKET_ERROR Then
    m_enmState = sckError: Debug.Print "STATE: sckError"
    Dim lngErrorCode As Long
    lngErrorCode = Err.LastDllError
    Err.Raise lngErrorCode, "clsSocket.RecvDataToBuffer", GetErrorDescription(lngErrorCode)
ElseIf lngBytesReceived > 0 Then
    strBuffTemporal = StrConv(arrBuffer(), vbUnicode)
    m_strRecvBuffer = m_strRecvBuffer & Left$(strBuffTemporal, lngBytesReceived)
    RecvDataToBuffer = lngBytesReceived
End If
End Function

Private Sub ProcessOptions()
On Local Error Resume Next
Dim lngResult As Long, lngBuffer As Long, lngErrorCode As Long
If m_enmProtocol = sckTCPProtocol Then
    lngResult = api_getsockopt(m_lngSocketHandle, SOL_SOCKET, SO_RCVBUF, lngBuffer, LenB(lngBuffer))
    If lngResult = SOCKET_ERROR Then
        lngErrorCode = Err.LastDllError
        Err.Raise lngErrorCode, "clsSocket.ProcessOptions", GetErrorDescription(lngErrorCode)
    Else
        m_lngRecvBufferLen = lngBuffer
    End If
    lngResult = api_getsockopt(m_lngSocketHandle, SOL_SOCKET, SO_SNDBUF, lngBuffer, LenB(lngBuffer))
    If lngResult = SOCKET_ERROR Then
        lngErrorCode = Err.LastDllError
        Err.Raise lngErrorCode, "clsSocket.ProcessOptions", GetErrorDescription(lngErrorCode)
    Else
        m_lngSendBufferLen = lngBuffer
    End If
Else
    lngBuffer = 1
    lngResult = api_setsockopt(m_lngSocketHandle, SOL_SOCKET, SO_BROADCAST, lngBuffer, LenB(lngBuffer))
    lngResult = api_getsockopt(m_lngSocketHandle, SOL_SOCKET, SO_MAX_MSG_SIZE, lngBuffer, LenB(lngBuffer))
    If lngResult = SOCKET_ERROR Then
        lngErrorCode = Err.LastDllError
        Err.Raise lngErrorCode, "clsSocket.ProcessOptions", GetErrorDescription(lngErrorCode)
    Else
        m_lngRecvBufferLen = lngBuffer
        m_lngSendBufferLen = lngBuffer
    End If
End If
Debug.Print "Winsock buffer size for sends: " & m_lngRecvBufferLen
Debug.Print "Winsock buffer size for receives: " & m_lngSendBufferLen
End Sub

Public Sub GetData(ByRef data As Variant, Optional varType As Variant, Optional maxLen As Variant)
On Local Error Resume Next
If m_enmProtocol = sckTCPProtocol Then
    If m_enmState <> sckConnected And Not m_blnAcceptClass Then
        Err.Raise sckBadState, "clsSocket.GetData", "Wrong protocol or connection state for the requested transaction or request"
        Exit Sub
    End If
Else
    If m_enmState <> sckOpen Then
        Err.Raise sckBadState, "clsSocket.GetData", "Wrong protocol or connection state for the requested transaction or request"
        Exit Sub
    End If
    If GetBufferLenUDP = 0 Then Exit Sub
End If
If Not IsMissing(maxLen) Then
    If IsNumeric(maxLen) Then
        If CLng(maxLen) < 0 Then
            Err.Raise sckInvalidArg, "clsSocket.GetData", "The argument passed to a function was not in the correct format or in the specified range."
        End If
    Else
        If m_enmProtocol = sckTCPProtocol Then
            maxLen = Len(m_strRecvBuffer)
        Else
            maxLen = GetBufferLenUDP
        End If
    End If
End If
Dim lngBytesRecibidos  As Long
lngBytesRecibidos = RecvData(data, False, varType, maxLen)
Debug.Print "OK Bytes obtained from buffer: " & lngBytesRecibidos
End Sub

Public Sub PeekData(ByRef data As Variant, Optional varType As Variant, Optional maxLen As Variant)
On Local Error Resume Next
If m_enmProtocol = sckTCPProtocol Then
    If m_enmState <> sckConnected Then
        Err.Raise sckBadState, "clsSocket.PeekData", "Wrong protocol or connection state for the requested transaction or request"
        Exit Sub
    End If
Else
    If m_enmState <> sckOpen Then
        Err.Raise sckBadState, "clsSocket.PeekData", "Wrong protocol or connection state for the requested transaction or request"
        Exit Sub
    End If
    If GetBufferLenUDP = 0 Then Exit Sub
End If
If Not IsMissing(maxLen) Then
    If IsNumeric(maxLen) Then
        If CLng(maxLen) < 0 Then
            Err.Raise sckInvalidArg, "clsSocket.PeekData", "The argument passed to a function was not in the correct format or in the specified range."
        End If
    Else
        If m_enmProtocol = sckTCPProtocol Then
            maxLen = Len(m_strRecvBuffer)
        Else
            maxLen = GetBufferLenUDP
        End If
    End If
End If
Dim lngBytesRecibidos  As Long
lngBytesRecibidos = RecvData(data, True, varType, maxLen)
Debug.Print "OK Bytes obtained from buffer: " & lngBytesRecibidos
End Sub

Private Function RecvData(ByRef data As Variant, ByVal blnPeek As Boolean, Optional varClass As Variant, Optional maxLen As Variant) As Long
On Local Error Resume Next
Dim blnMaxLenMiss   As Boolean, blnClassMiss As Boolean, strRecvData   As String, lngBufferLen   As Long, arrBuffer()    As Byte, lngErrorCode   As Long
If m_enmProtocol = sckTCPProtocol Then
    lngBufferLen = Len(m_strRecvBuffer)
Else
    lngBufferLen = GetBufferLenUDP
End If
blnMaxLenMiss = IsMissing(maxLen)
blnClassMiss = IsMissing(varClass)
If varType(data) = vbEmpty Then
    If blnClassMiss Then varClass = vbArray + vbByte
Else
    varClass = varType(data)
End If
If varClass = vbString Or varClass = vbArray + vbByte Then
    If blnMaxLenMiss Then
        If lngBufferLen = 0 Then
            RecvData = 0
            arrBuffer = StrConv("", vbFromUnicode)
            data = arrBuffer
            Exit Function
        Else
            RecvData = lngBufferLen
            arrBuffer = BuildArray(lngBufferLen, blnPeek, lngErrorCode)
        End If
    Else
        If maxLen = 0 Or lngBufferLen = 0 Then
            RecvData = 0
            arrBuffer = StrConv("", vbFromUnicode)
            data = arrBuffer
            If m_enmProtocol = sckUDPProtocol Then
                EmptyBuffer
                Err.Raise WSAEMSGSIZE, "clsSocket.RecvData", GetErrorDescription(WSAEMSGSIZE)
            End If
            Exit Function
        ElseIf maxLen > lngBufferLen Then
            RecvData = lngBufferLen
            arrBuffer = BuildArray(lngBufferLen, blnPeek, lngErrorCode)
        Else
            RecvData = CLng(maxLen)
            arrBuffer() = BuildArray(CLng(maxLen), blnPeek, lngErrorCode)
        End If
    End If
End If
Select Case varClass
Case vbString
    Dim strdata As String
    strdata = StrConv(arrBuffer(), vbUnicode)
    data = strdata
Case vbArray + vbByte
    data = arrBuffer
Case vbBoolean
    Dim blnData As Boolean
    If LenB(blnData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(blnData), blnPeek, lngErrorCode)
    RecvData = LenB(blnData)
    api_CopyMemory blnData, arrBuffer(0), LenB(blnData)
    data = blnData
Case vbByte
    Dim bytData As Byte
    If LenB(bytData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(bytData), blnPeek, lngErrorCode)
    RecvData = LenB(bytData)
    api_CopyMemory bytData, arrBuffer(0), LenB(bytData)
    data = bytData
Case vbCurrency
    Dim curData As Currency
    If LenB(curData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(curData), blnPeek, lngErrorCode)
    RecvData = LenB(curData)
    api_CopyMemory curData, arrBuffer(0), LenB(curData)
    data = curData
Case vbDate
    Dim datData As Date
    If LenB(datData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(datData), blnPeek, lngErrorCode)
    RecvData = LenB(datData)
    api_CopyMemory datData, arrBuffer(0), LenB(datData)
    data = datData
Case vbDouble
    Dim dblData As Double
    If LenB(dblData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(dblData), blnPeek, lngErrorCode)
    RecvData = LenB(dblData)
    api_CopyMemory dblData, arrBuffer(0), LenB(dblData)
    data = dblData
Case vbInteger
    Dim intData As Integer
    If LenB(intData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(intData), blnPeek, lngErrorCode)
    RecvData = LenB(intData)
    api_CopyMemory intData, arrBuffer(0), LenB(intData)
    data = intData
Case vbLong
    Dim lngData As Long
    If LenB(lngData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(lngData), blnPeek, lngErrorCode)
    RecvData = LenB(lngData)
    api_CopyMemory lngData, arrBuffer(0), LenB(lngData)
    data = lngData
Case vbSingle
    Dim sngData As Single
    If LenB(sngData) > lngBufferLen Then Exit Function
    arrBuffer = BuildArray(LenB(sngData), blnPeek, lngErrorCode)
    RecvData = LenB(sngData)
    api_CopyMemory sngData, arrBuffer(0), LenB(sngData)
    data = sngData
Case Else
    Err.Raise sckUnsupported, "clsSocket.RecvData", "Unsupported variant type."
End Select
If lngErrorCode <> 0 Then
    Err.Raise lngErrorCode, "clsSocket.RecvData", GetErrorDescription(lngErrorCode)
End If
End Function

Private Function BuildArray(ByVal Size As Long, ByVal blnPeek As Boolean, ByRef lngErrorCode As Long) As Byte()
On Local Error Resume Next
Dim strdata As String
If m_enmProtocol = sckTCPProtocol Then
    strdata = Left$(m_strRecvBuffer, CLng(Size))
    BuildArray = StrConv(strdata, vbFromUnicode)
    If Not blnPeek Then
        m_strRecvBuffer = Mid$(m_strRecvBuffer, Size + 1)
    End If
Else
    Dim arrBuffer() As Byte, lngResult As Long, udtSockAddr As sockaddr_in, lngFlags As Long
    If blnPeek Then lngFlags = MSG_PEEK
    ReDim arrBuffer(Size - 1)
    lngResult = api_recvfrom(m_lngSocketHandle, arrBuffer(0), Size, lngFlags, udtSockAddr, LenB(udtSockAddr))
    If lngResult = SOCKET_ERROR Then
        lngErrorCode = Err.LastDllError
    End If
    BuildArray = arrBuffer
    GetRemoteInfoFromSI udtSockAddr, m_lngRemotePort, m_strRemoteHostIP, m_strRemoteHost
End If
End Function

Private Sub CleanResolutionSystem()
On Local Error Resume Next
Dim varAsynHandle As Variant
For Each varAsynHandle In m_colWaitingResolutions
    api_WSACancelAsyncRequest varAsynHandle
    mdlSocket.UnregisterResolution varAsynHandle
Next
FreeMemory
End Sub

Public Sub Listen()
On Local Error Resume Next
If m_enmState <> sckClosed And m_enmState <> sckOpen Then
    Err.Raise sckInvalidOp, "clsSocket.Listen", "Invalid operation at current state"
End If
If Not SocketExists Then Exit Sub
If Not BindInternal Then Exit Sub
Dim lngResult As Long
lngResult = api_listen(m_lngSocketHandle, SOMAXCONN)
If lngResult = SOCKET_ERROR Then
    Dim lngErrorCode As Long
    lngErrorCode = Err.LastDllError
    Err.Raise lngErrorCode, "clsSocket.Listen", GetErrorDescription(lngErrorCode)
Else
    m_enmState = sckListening: Debug.Print "STATE: sckListening"
End If
End Sub

Public Sub Accept(requestID As Long)
On Local Error Resume Next
If m_enmState <> sckClosed Then
    Err.Raise sckInvalidOp, "clsSocket.Accept", "Invalid operation at current state"
End If
Dim lngResult As Long
Dim udtSockAddr As sockaddr_in
Dim lngErrorCode As Long
m_lngSocketHandle = requestID
m_enmProtocol = sckTCPProtocol
ProcessOptions
If Not mdlSocket.IsAcceptRegistered(requestID) Then
    If IsSocketRegistered(requestID) Then
        Err.Raise sckBadState, "clsSocket.Accept", "Wrong protocol or connection state for the requested transaction or request"
    Else
        m_blnAcceptClass = True
        m_enmState = sckConnected: Debug.Print "STATE: sckConnected"
        mdlSocket.RegisterSocket m_lngSocketHandle, ObjPtr(Me), False
        Exit Sub
    End If
End If
Dim clsSocket As clsSocket
Set clsSocket = GetAcceptClass(requestID)
mdlSocket.UnregisterAccept requestID
lngResult = api_getsockname(m_lngSocketHandle, udtSockAddr, LenB(udtSockAddr))
If lngResult = SOCKET_ERROR Then
    lngErrorCode = Err.LastDllError
    Err.Raise lngErrorCode, "clsSocket.Accept", GetErrorDescription(lngErrorCode)
Else
    m_lngLocalPortBind = IntegerToUnsigned(api_ntohs(udtSockAddr.sin_port))
    m_strLocalIP = StringFromPointer(api_inet_ntoa(udtSockAddr.sin_addr))
End If
GetRemoteInfo m_lngSocketHandle, m_lngRemotePort, m_strRemoteHostIP, m_strRemoteHost
m_enmState = sckConnected: Debug.Print "STATE: sckConnected"
If clsSocket.BytesReceived > 0 Then
    clsSocket.GetData m_strRecvBuffer
End If
mdlSocket.Subclass_ChangeOwner requestID, ObjPtr(Me)
If Len(m_strRecvBuffer) > 0 Then RaiseEvent DataArrival(Len(m_strRecvBuffer))
If clsSocket.State = sckClosing Then
    m_enmState = sckClosing: Debug.Print "STATE: sckClosing"
    RaiseEvent CloseSck
End If
Set clsSocket = Nothing
End Sub

Private Function GetRemoteInfo(ByVal lngSocket As Long, ByRef lngRemotePort As Long, ByRef strRemoteHostIP As String, ByRef strRemoteHost As String) As Boolean
On Local Error Resume Next
Dim lngResult As Long, udtSockAddr As sockaddr_in
GetRemoteInfo = False
lngResult = api_getpeername(lngSocket, udtSockAddr, LenB(udtSockAddr))
If lngResult = 0 Then
    GetRemoteInfo = True
    GetRemoteInfoFromSI udtSockAddr, lngRemotePort, strRemoteHostIP, strRemoteHost
Else
   lngRemotePort = 0
   strRemoteHostIP = ""
   strRemoteHost = ""
End If
End Function

Private Sub GetRemoteInfoFromSI(ByRef udtSockAddr As sockaddr_in, ByRef lngRemotePort As Long, ByRef strRemoteHostIP As String, ByRef strRemoteHost As String)
On Local Error Resume Next
lngRemotePort = IntegerToUnsigned(api_ntohs(udtSockAddr.sin_port))
strRemoteHostIP = StringFromPointer(api_inet_ntoa(udtSockAddr.sin_addr))
m_strRemoteHost = ""
End Sub

Private Function GetBufferLenUDP() As Long
On Local Error Resume Next
Dim lngResult As Long, lngBuffer As Long
lngResult = api_ioctlsocket(m_lngSocketHandle, FIONREAD, lngBuffer)
If lngResult = SOCKET_ERROR Then
    GetBufferLenUDP = 0
Else
    GetBufferLenUDP = lngBuffer
End If
End Function

Private Sub EmptyBuffer()
On Local Error Resume Next
Dim B As Byte
api_recv m_lngSocketHandle, B, Len(B), 0&
End Sub
