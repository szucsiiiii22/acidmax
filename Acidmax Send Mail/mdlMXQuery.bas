Attribute VB_Name = "mdlMXQuery"
Option Explicit
Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Const EM_LINESCROLL = &HB6
Private Const DNS_RECURSION As Byte = 1
Private Const AF_INET = 2
Private Const SOCKET_ERROR = -1
Private Const ERROR_BUFFER_OVERFLOW = 111
Private Const SOCK_DGRAM = 2
Private Const INADDR_NONE = &HFFFFFFFF
Private Const ERROR_SUCCESS = 0&
Private Const HKEY_LOCAL_MACHINE = &H80000002
Private Const KEY_QUERY_VALUE = &H1&
Private Const KEY_ENUMERATE_SUB_KEYS = &H8&
Private Const KEY_NOTIFY = &H10&
Private Const READ_CONTROL = &H20000
Private Const STANDARD_RIGHTS_READ = READ_CONTROL
Private Const KEY_READ = STANDARD_RIGHTS_READ Or KEY_QUERY_VALUE Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY
Private Type WSADATA
    wversion As Integer
    wHighVersion As Integer
    szDescription(256) As Byte
    szSystemStatus(128) As Byte
    iMaxSockets As Integer
    iMaxUdpDg As Integer
    lpVendorInfo As Long
End Type
Private Type DNS_HEADER
    qryID As Integer
    Options As Byte
    response As Byte
    qdcount As Integer
    ancount As Integer
    nscount As Integer
    arcount As Integer
End Type
Private Type IP_ADDRESS_STRING
    IpAddressStr(4 * 4 - 1) As Byte
End Type
Private Type IP_MASK_STRING
    IpMaskString(4 * 4 - 1) As Byte
End Type
Private Type IP_ADDR_STRING
    Next                    As Long
    IpAddress               As IP_ADDRESS_STRING
    IpMask                  As IP_MASK_STRING
    Context                 As Long
End Type
Private Type FIXED_INFO
    hostname(128 + 4 - 1)   As Byte
    DomainName(128 + 4 - 1) As Byte
    CurrentDnsServer        As Long
    DnsServerList           As IP_ADDR_STRING
    NodeType                As Long
    ScopeId(256 + 4 - 1)    As Byte
    EnableRouting           As Long
    EnableProxy             As Long
    EnableDns               As Long
End Type
Private Type sockaddr
    sin_family              As Integer
    sin_port                As Integer
    sin_addr                As Long
    sin_zero                As String * 8
End Type
Private Type HOSTENT
    h_name                  As Long
    h_aliases               As Long
    h_addrtype              As Integer
    h_length                As Integer
    h_addr_list             As Long
End Type
Public Type DNS_INFO
    Servers()               As String
    Count                   As Long
    LocalDomain             As String
    RootDomain              As String
End Type
Public Type MX_RECORD
    Server                  As String
    Pref                    As Integer
End Type
Public Type MX_INFO
    Best                    As String
    Domain                  As String
    List()                  As MX_RECORD
    Count                   As Long
End Type
Public DNS                  As DNS_INFO
Public MX                   As MX_INFO
Private Declare Function gethostbyname Lib "WSOCK32.DLL" (ByVal host_name As String) As Long
Private Declare Function inet_addr Lib "WSOCK32.DLL" (ByVal cp As String) As Long
Private Declare Function recvfrom Lib "WSOCK32.DLL" (ByVal s As Long, buf As Any, ByVal buflen As Long, ByVal Flags As Long, from As sockaddr, fromlen As Long) As Long
Private Declare Function socket Lib "WSOCK32.DLL" (ByVal af As Long, ByVal s_type As Long, ByVal protocol As Long) As Long
Private Declare Function htons Lib "WSOCK32.DLL" (ByVal hostshort As Long) As Integer
Private Declare Function ntohs Lib "WSOCK32.DLL" (ByVal netshort As Long) As Integer
Private Declare Function sendto Lib "WSOCK32.DLL" (ByVal s As Long, buf As Any, ByVal buflen As Long, ByVal Flags As Long, to_addr As sockaddr, ByVal tolen As Long) As Long
Private Declare Function WSAStartup Lib "WSOCK32.DLL" (ByVal wVersionRequired As Long, lpWSADATA As WSADATA) As Long
Private Declare Function WSACleanup Lib "WSOCK32.DLL" () As Long
Private Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, phkResult As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, ByVal lpData As String, lpcbData As Long) As Long
Private Declare Function GetNetworkParams Lib "iphlpapi.dll" (pFixedInfo As Any, pOutBufLen As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function GetModuleHandle Lib "kernel32" Alias "GetModuleHandleA" (ByVal lpModuleName As String) As Long
Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long

Public Sub GetDNSInfo()
On Local Error GoTo ErrHandler
Dim sBuffer As String, sDNSBuff As String, sDomainBuff As String, sKey As String, lngFixedInfoNeeded As Long, bytFixedInfoBuffer() As Byte, udtFixedInfo As FIXED_INFO, lngIpAddrStringPtr As Long, udtIpAddrString As IP_ADDR_STRING, strDnsIpAddress As String, nRet As Long, sTmp() As String
If Exported("iphlpapi.dll", "GetNetworkParams") Then
    nRet = GetNetworkParams(ByVal vbNullString, lngFixedInfoNeeded)
    If nRet = ERROR_BUFFER_OVERFLOW Then
        ReDim bytFixedInfoBuffer(lngFixedInfoNeeded)
        nRet = GetNetworkParams(bytFixedInfoBuffer(0), lngFixedInfoNeeded)
        CopyMemory udtFixedInfo, bytFixedInfoBuffer(0), Len(udtFixedInfo)
        With udtFixedInfo
            lngIpAddrStringPtr = VarPtr(.DnsServerList)
            Do While lngIpAddrStringPtr
                CopyMemory udtIpAddrString, ByVal lngIpAddrStringPtr, Len(udtIpAddrString)
                With udtIpAddrString
                    strDnsIpAddress = StripTerminator(StrConv(.IpAddress.IpAddressStr, vbUnicode))
                    sDNSBuff = sDNSBuff & strDnsIpAddress & ","
                    lngIpAddrStringPtr = .Next
                End With
            Loop
            sDomainBuff = StripTerminator(StrConv(.DomainName, vbUnicode))
        End With
    End If
End If
If Len(sDNSBuff) = 0 Or Len(sDomainBuff) = 0 Then
    sKey = "System\CurrentControlSet\Services\VxD\MSTCP"
    sBuffer = GetRegStr(HKEY_LOCAL_MACHINE, sKey, "NameServer", "")
    If Len(sBuffer) Then sDNSBuff = sBuffer & ","
    sBuffer = GetRegStr(HKEY_LOCAL_MACHINE, sKey, "Domain", "")
    If Len(sBuffer) Then sDomainBuff = sBuffer
    sKey = "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
    sBuffer = GetRegStr(HKEY_LOCAL_MACHINE, sKey, "NameServer", "")
    If Len(sBuffer) Then sDNSBuff = sBuffer & ","
    sBuffer = GetRegStr(HKEY_LOCAL_MACHINE, sKey, "Domain", "")
    If Len(sBuffer) Then sDomainBuff = sBuffer
    sKey = "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
    sBuffer = GetRegStr(HKEY_LOCAL_MACHINE, sKey, "DhcpNameServer", "")
    If Len(sBuffer) Then sDNSBuff = sBuffer & ","
    sBuffer = GetRegStr(HKEY_LOCAL_MACHINE, sKey, "DHCPDomain", "")
    If Len(sBuffer) Then sDomainBuff = sBuffer
End If
sDNSBuff = Replace(sDNSBuff, " ", ",")
If Right(sDNSBuff, 1) = "," Then sDNSBuff = Left(sDNSBuff, Len(sDNSBuff) - 1)
DNS.Servers = Split(sDNSBuff, ",")
DNS.Count = UBound(DNS.Servers) + 1
DNS.LocalDomain = sDomainBuff
sTmp = Split(sDomainBuff, ".")
nRet = UBound(sTmp)
If nRet > 0 Then
    DNS.RootDomain = sTmp(nRet - 1) & "." & sTmp(nRet)
Else
    DNS.RootDomain = sDomainBuff
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function MX_Query(ByVal ms_Domain As String) As String
On Local Error GoTo ErrHandler
Dim StartupData As WSADATA, SocketBuffer As sockaddr, IpAddr As Long, iRC As Integer, dnsHead As DNS_HEADER, iSock As Integer, dnsQuery() As Byte, sQName As String, dnsQueryNdx As Integer, ITemp As Integer, iNdx As Integer, dnsReply(2048) As Byte, iAnCount As Integer
MX.Count = 0
MX.Best = vbNullString
ReDim MX.List(0)
If DNS.Count = 0 Then GetDNSInfo
If DNS.Count = 0 Then Exit Function
If Len(ms_Domain) = 0 Then ms_Domain = DNS.LocalDomain
If Len(ms_Domain) < 5 Then Exit Function
MX.Domain = ms_Domain
If WSAStartup(&H101, StartupData) <> ERROR_SUCCESS Then
    iRC = WSACleanup
    Exit Function
End If
iSock = socket(AF_INET, SOCK_DGRAM, 0)
If iSock = SOCKET_ERROR Then Exit Function
IpAddr = GetHostByNameAlias(DNS.Servers(0))
If IpAddr = -1 Then Exit Function
SocketBuffer.sin_family = AF_INET
SocketBuffer.sin_port = htons(53)
SocketBuffer.sin_addr = IpAddr
SocketBuffer.sin_zero = String$(8, 0)
dnsHead.qryID = htons(&H11DF)
dnsHead.Options = DNS_RECURSION
dnsHead.qdcount = htons(1)
dnsHead.ancount = 0
dnsHead.nscount = 0
dnsHead.arcount = 0
dnsQueryNdx = 0
ReDim dnsQuery(4000)
CopyMemory dnsQuery(dnsQueryNdx), dnsHead, 12
dnsQueryNdx = dnsQueryNdx + 12
sQName = MakeQName(MX.Domain)
iNdx = 0
While (iNdx < Len(sQName))
    dnsQuery(dnsQueryNdx + iNdx) = Asc(Mid(sQName, iNdx + 1, 1))
    iNdx = iNdx + 1
Wend
dnsQueryNdx = dnsQueryNdx + Len(sQName)
dnsQuery(dnsQueryNdx) = &H0
dnsQueryNdx = dnsQueryNdx + 1
ITemp = htons(15)
CopyMemory dnsQuery(dnsQueryNdx), ITemp, Len(ITemp)
dnsQueryNdx = dnsQueryNdx + Len(ITemp)
ITemp = htons(1)
CopyMemory dnsQuery(dnsQueryNdx), ITemp, Len(ITemp)
dnsQueryNdx = dnsQueryNdx + Len(ITemp)
ReDim Preserve dnsQuery(dnsQueryNdx - 1)
iRC = sendto(iSock, dnsQuery(0), dnsQueryNdx + 1, 0, SocketBuffer, Len(SocketBuffer))
If (iRC = SOCKET_ERROR) Or (iRC = 0) Then
    Err.Raise 20000, "MXQuery", "Problem sending MX query"
    iRC = WSACleanup
    Exit Function
End If
iRC = recvfrom(iSock, dnsReply(0), 2048, 0, SocketBuffer, Len(SocketBuffer))
If (iRC = SOCKET_ERROR) Or (iRC = 0) Then
    Err.Raise 20000, "MXQuery", "Problem receiving MX query"
    iRC = WSACleanup
    Exit Function
End If
CopyMemory iAnCount, dnsReply(6), 2
iAnCount = ntohs(iAnCount)
iRC = WSACleanup
If iAnCount Then
    MX_Query = GetMXName(dnsReply(), 12, iAnCount)
Else
    If InStr(MX.Domain, DNS.RootDomain) > 1 Then
        MX.Domain = Mid$(MX.Domain, InStr(MX.Domain, ".") + 1)
        MX_Query = MX_Query(MX.Domain)
    End If
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub ParseName(dnsReply() As Byte, iNdx As Integer, sName As String)
On Local Error GoTo ErrHandler
Dim iCompress As Integer, iChCount As Integer
While (dnsReply(iNdx) <> 0)
    iChCount = dnsReply(iNdx)
    If (iChCount = 192) Then
        iCompress = dnsReply(iNdx + 1)
        ParseName dnsReply(), iCompress, sName
        iNdx = iNdx + 2
        Exit Sub
    End If
    iNdx = iNdx + 1
    While (iChCount)
        sName = sName + Chr(dnsReply(iNdx))
        iChCount = iChCount - 1
        iNdx = iNdx + 1
    Wend
    If (dnsReply(iNdx) <> 0) Then sName = sName + "."
Wend
Exit Sub
ErrHandler:
    MsgBox Err.Description
    'If hKey Then Call RegCloseKey(hKey)
    Err.Clear
End Sub

Private Function GetMXName(dnsReply() As Byte, iNdx As Integer, iAnCount As Integer) As String
On Local Error GoTo ErrHandler
Dim sTemp As String, iBestPref As Integer, iMXCount As Integer
MX.Count = 0
MX.Best = vbNullString
ReDim MX.List(0)
iMXCount = 0
iBestPref = -1
ParseName dnsReply(), iNdx, sTemp
iNdx = iNdx + 2
iNdx = iNdx + 6
While (iAnCount)
    If (dnsReply(iNdx) = 15) Then
        Dim sName As String
        Dim iPref As Integer
        sName = ""
        iNdx = iNdx + 1 + 6
        iNdx = iNdx + 2
        CopyMemory iPref, dnsReply(iNdx), 2
        iPref = ntohs(iPref)
        iNdx = iNdx + 2
        ParseName dnsReply(), iNdx, sName
        If Trim(sName) <> "" Then
            iMXCount = iMXCount + 1
            ReDim Preserve MX.List(iMXCount - 1)
            MX.List(iMXCount - 1).Server = sName
            MX.List(iMXCount - 1).Pref = iPref
            MX.Count = iMXCount
            If (iBestPref = -1 Or iPref < iBestPref) Then
                iBestPref = iPref
                MX.Best = sName
            End If
        End If
        iNdx = iNdx + 3
    Else
        GetMXName = MX.Best
        SortMX MX.List
        Exit Function
    End If
    iAnCount = iAnCount - 1
Wend
SortMX MX.List
GetMXName = MX.Best
Exit Function
ErrHandler:
    MsgBox Err.Description
'    If hKey Then Call RegCloseKey(hKey)
    Err.Clear
End Function

Private Function MakeQName(sDomain As String) As String
On Local Error GoTo ErrHandler
Dim iQCount As Integer, iNdx As Integer, iCount As Integer, sQName As String, sDotName  As String, sChar As String
iNdx = 1
iQCount = 0
iCount = Len(sDomain)
While (iNdx <= iCount)
    sChar = Mid(sDomain, iNdx, 1)
    If (sChar = ".") Then
        sQName = sQName & Chr(iQCount) & sDotName
        iQCount = 0
        sDotName = ""
    Else
        sDotName = sDotName + sChar
        iQCount = iQCount + 1
    End If
    iNdx = iNdx + 1
Wend
sQName = sQName & Chr(iQCount) & sDotName
MakeQName = sQName
Exit Function
ErrHandler:
    MsgBox Err.Description
    'If hKey Then Call RegCloseKey(hKey)
    Err.Clear
End Function

Private Function GetHostByNameAlias(ByVal sHostName As String) As Long
On Local Error GoTo ErrHandler
Dim phe As Long, heDestHost As HOSTENT, addrList As Long, retIP As Long
retIP = inet_addr(sHostName)
If retIP = INADDR_NONE Then
    phe = gethostbyname(sHostName)
    If phe <> 0 Then
        CopyMemory heDestHost, ByVal phe, LenB(heDestHost)
        CopyMemory addrList, ByVal heDestHost.h_addr_list, 4
        CopyMemory retIP, ByVal addrList, heDestHost.h_length
    Else
        retIP = INADDR_NONE
    End If
End If
GetHostByNameAlias = retIP
Exit Function
ErrHandler:
    MsgBox Err.Description
    'If hKey Then Call RegCloseKey(hKey)
    Err.Clear
End Function

Private Function StripTerminator(ByVal strString As String) As String
On Local Error GoTo ErrHandler
Dim intZeroPos As Integer
intZeroPos = InStr(strString, vbNullChar)
If intZeroPos > 1 Then
    StripTerminator = Trim$(Left$(strString, intZeroPos - 1))
ElseIf intZeroPos = 1 Then
    StripTerminator = vbNullString
Else
    StripTerminator = strString
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    'If hKey Then Call RegCloseKey(hKey)
    Err.Clear
End Function

Private Function GetRegStr(hKeyRoot As Long, ByVal sKeyName As String, ByVal sValueName As String, Optional ByVal Default As String = "") As String
On Local Error GoTo ErrHandler
Dim lRet As Long, hKey As Long, lType As Long, lBytes As Long, sBuff As String
GetRegStr = Default
lRet = RegOpenKeyEx(hKeyRoot, sKeyName, 0&, KEY_READ, hKey)
If lRet = ERROR_SUCCESS Then
   lRet = RegQueryValueEx(hKey, sValueName, 0&, lType, ByVal sBuff, lBytes)
   If lRet = ERROR_SUCCESS Then
      If lBytes > 0 Then
         sBuff = Space(lBytes)
         lRet = RegQueryValueEx(hKey, sValueName, 0&, lType, ByVal sBuff, Len(sBuff))
         If lRet = ERROR_SUCCESS Then
            GetRegStr = Left(sBuff, lBytes - 1)
         End If
      End If
   End If
   Call RegCloseKey(hKey)
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    'If hKey Then Call RegCloseKey(hKey)
    Err.Clear
End Function

Private Function Exported(ByVal ModuleName As String, ByVal ProcName As String) As Boolean
On Local Error GoTo ErrHandler
Dim hModule As Long, lpProc As Long, FreeLib As Boolean
hModule = GetModuleHandle(ModuleName)
If hModule = 0 Then
    hModule = LoadLibrary(ModuleName)
    FreeLib = True
End If
If hModule Then
    lpProc = GetProcAddress(hModule, ProcName)
    Exported = (lpProc <> 0)
End If
If FreeLib Then Call FreeLibrary(hModule)
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub SortMX(arr() As MX_RECORD, Optional ByVal bSortDesc As Boolean = False)
On Local Error GoTo ErrHandler
Dim ValMX As MX_RECORD, index As Long, firstItem As Long, indexLimit As Long, lastSwap As Long
firstItem = LBound(arr)
lastSwap = UBound(arr)
Do
    indexLimit = lastSwap - 1
    lastSwap = 0
    For index = firstItem To indexLimit
        ValMX.Pref = arr(index).Pref
        ValMX.Server = arr(index).Server
        If (ValMX.Pref > arr(index + 1).Pref) Xor bSortDesc Then
            arr(index).Pref = arr(index + 1).Pref
            arr(index).Server = arr(index + 1).Server
            arr(index + 1).Pref = ValMX.Pref
            arr(index + 1).Server = ValMX.Server
            lastSwap = index
        End If
    Next
Loop While lastSwap
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
