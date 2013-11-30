VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsFTP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private session As Long, server As Long, Transfer As Long, Adresa As String, ID As String, Pass As String, port As Integer, strPath As String, adr As String, Klic As String
Private Declare Function GetTickCount& Lib "kernel32" ()
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As String, ByVal lpFileName As String) As Long
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function InternetOpen Lib "wininet.dll" Alias "InternetOpenA" (ByVal sAgent As String, ByVal lAccessType As Long, ByVal sProxyName As String, ByVal sProxyBypass As String, ByVal lFlags As Long) As Long
Private Declare Function InternetOpenUrl Lib "wininet.dll" Alias "InternetOpenUrlA" (ByVal pub_lngInternetSession As Long, ByVal lpszUrl As String, ByVal lpszHeaders As String, ByVal dwHeadersLength As Long, ByVal dwFlags As Long, ByVal dwContext As Long) As Long
Private Declare Sub InternetSetStatusCallback Lib "wininet.dll" (ByVal pub_lngInternetSession As Long, ByVal lpfnInternetCallback As Long)
Private Declare Function InternetConnect Lib "wininet.dll" Alias "InternetConnectA" (ByVal pub_lngInternetSession As Long, ByVal sServerName As String, ByVal nServerPort As Integer, ByVal sUsername As String, ByVal sPassword As String, ByVal lService As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Private Declare Function HttpOpenRequest Lib "wininet.dll" Alias "HttpOpenRequestA" (ByVal hHttpSession As Long, ByVal sVerb As String, ByVal sObjectName As String, ByVal sVersion As String, ByVal sReferer As String, ByVal something As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Private Declare Function HttpSendRequest Lib "wininet.dll" Alias "HttpSendRequestA" (ByVal hHttpRequest As Long, ByVal sHeaders As String, ByVal lHeadersLength As Long, sOptional As Any, ByVal lOptionalLength As Long) As Integer
Private Declare Function HttpQueryInfo Lib "wininet.dll" Alias "HttpQueryInfoA" (ByVal hHttpRequest As Long, ByVal lInfoLevel As Long, ByRef sBuffer As Any, ByRef lBufferLength As Long, ByRef lIndex As Long) As Integer
Private Declare Function InternetReadFile Lib "wininet.dll" (ByVal hFile As Long, ByVal sBuffer As String, ByVal lNumBytesToRead As Long, lNumberOfBytesRead As Long) As Integer
Private Declare Function InternetWriteFile Lib "wininet.dll" (ByVal hFile As Long, ByVal sBuffer As String, ByVal lNumBytesToWrite As Long, dwNumberOfBytesWritten As Long) As Integer
Private Declare Function InternetCloseHandle Lib "wininet.dll" (ByVal hInet As Long) As Integer
Private Declare Function InternetQueryDataAvailable Lib "wininet.dll" (ByVal hInet As Long, dwAvail As Long, ByVal dwFlags As Long, ByVal dwContext As Long) As Boolean
Private Declare Function InternetTimeToSystemTime Lib "wininet.dll" (ByVal lpszTime As String, ByRef pst As SYSTEMTIME, ByVal dwReserved As Long) As Long
Private Declare Function FtpFindFirstFile Lib "wininet.dll" Alias "FtpFindFirstFileA" (ByVal hFtpSession As Long, ByVal lpszSearchFile As String, lpFindFileData As WIN32_FIND_DATA, ByVal dwFlags As Long, ByVal dwContext As Long) As Long
Private Declare Function InternetFindNextFile Lib "wininet.dll" Alias "InternetFindNextFileA" (ByVal hFind As Long, lpvFindData As WIN32_FIND_DATA) As Long
Private Declare Function InternetGetLastResponseInfo Lib "wininet.dll" Alias "InternetGetLastResponseInfoA" (lpdwError As Long, ByVal lpszBuffer As String, lpdwBufferLength As Long) As Long
Private Declare Function FtpOpenFile Lib "wininet.dll" Alias "FtpOpenFileA" (ByVal hFtpSession As Long, ByVal lpszFileName As String, ByVal fdwAccess As Long, ByVal dwFlags As Long, ByVal dwContext As Long) As Long
Private Declare Function FtpGetFile Lib "wininet.dll" Alias "FtpGetFileA" (ByVal hFtpSession As Long, ByVal lpszRemoteFile As String, ByVal lpszNewFile As String, ByVal fFailIfExists As Long, ByVal dwFlagsAndAttributes As Long, ByVal dwFlags As Long, ByVal dwContext As Long) As Long
Private Declare Function FtpPutFile Lib "wininet.dll" Alias "FtpPutFileA" (ByVal hFtpSession As Long, ByVal lpszLocalFile As String, ByVal lpszNewRemoteFile As String, ByVal dwFlags As Long, ByVal dwContext As Long) As Long
Private Declare Function FtpCreateDirectory Lib "wininet.dll" Alias "FtpCreateDirectoryA" (ByVal hFtpSession As Long, ByVal lpszDirectory As String) As Long
Private Declare Function FtpDeleteFile Lib "wininet.dll" Alias "FtpDeleteFileA" (ByVal hFtpSession As Long, ByVal lpszFileName As String) As Long
Private Declare Function FtpRemoveDirectory Lib "wininet.dll" Alias "FtpRemoveDirectoryA" (ByVal hFtpSession As Long, ByVal lpszDirectory As String) As Long
Private Declare Function FtpRenameFile Lib "wininet.dll" Alias "FtpRenameFileA" (ByVal hFtpSession As Long, ByVal lpszExisting As String, ByVal lpszNew As String) As Long
Private Declare Function FtpSetCurrentDirectory Lib "wininet.dll" Alias "FtpSetCurrentDirectoryA" (ByVal hFtpSession As Long, ByVal lpszDirectory As String) As Boolean
Private Declare Function FtpGetCurrentDirectory Lib "wininet.dll" Alias "FtpGetCurrentDirectoryA" (ByVal hFtpSession As Long, ByVal lpszCurrentDirectory As String, lpdwCurrentDirectory As Long) As Long
Private Const sReadBuffer = 1024
Private Const INTERNET_OPEN_TYPE_PRECONFIG = 0
Private Const INTERNET_OPEN_TYPE_DIRECT = 1
Private Const INTERNET_INVALID_PORT_NUMBER = 0
Private Const INTERNET_DEFAULT_FTP_PORT = 21
Private Const INTERNET_DEFAULT_GOPHER_PORT = 70
Private Const INTERNET_DEFAULT_HTTP_PORT = 80
Private Const INTERNET_DEFAULT_HTTPS_PORT = 443
Private Const INTERNET_DEFAULT_SOCKS_PORT = 1080
Private Const INTERNET_SERVICE_FTP = 1
Private Const INTERNET_SERVICE_GOPHER = 2
Private Const INTERNET_SERVICE_HTTP = 3
Private Const INTERNET_FLAG_RELOAD = &H80000000
Private Const ERROR_NO_MORE_FILES = 18
Private Const FTP_TRANSFER_TYPE_UNKNOWN As Long = &H0
Private Const FTP_TRANSFER_TYPE_ASCII As Long = &H1
Private Const FTP_TRANSFER_TYPE_BINARY  As Long = &H2
Private Const HTTP_QUERY_CONTENT_TYPE = 1
Private Const HTTP_QUERY_CONTENT_LENGTH = 5
Private Const HTTP_QUERY_EXPIRES = 10
Private Const HTTP_QUERY_LAST_MODIFIED = 11
Private Const HTTP_QUERY_PRAGMA = 17
Private Const HTTP_QUERY_VERSION = 18
Private Const HTTP_QUERY_STATUS_CODE = 19
Private Const HTTP_QUERY_STATUS_TEXT = 20
Private Const HTTP_QUERY_RAW_HEADERS = 21
Private Const HTTP_QUERY_RAW_HEADERS_CRLF = 22
Private Const HTTP_QUERY_FORWARDED = 30
Private Const HTTP_QUERY_SERVER = 37
Private Const HTTP_QUERY_USER_AGENT = 39
Private Const HTTP_QUERY_SET_COOKIE = 43
Private Const HTTP_QUERY_REQUEST_METHOD = 45
Private Const HTTP_QUERY_FLAG_REQUEST_HEADERS = &H80000000
Private Const INTERNET_FLAG_RAW_DATA = &H40000000
Private Const INTERNET_FLAG_EXISTING_CONNECT = &H20000000
Private Const INTERNET_FLAG_TRANSFER_ASCII = &H1&
Private Const INTERNET_FLAG_TRANSFER_BINARY = &H2&
Private Const INTERNET_FLAG_ASYNC = &H10000000
Private Const INTERNET_FLAG_PASSIVE = &H8000000
Private Const INTERNET_FLAG_DONT_CACHE = &H4000000
Private Const INTERNET_FLAG_MAKE_PERSISTENT = &H2000000
Private Const INTERNET_FLAG_OFFLINE = &H1000000
Private Type INTERNET_ASYNC_RESULT
    dwResult As Long
    dwError As Long
End Type
Private Const INTERNET_FLAG_NO_CACHE_WRITE = &H4000000
Private Const INTERNET_STATUS_RESOLVING_NAME = 10
Private Const INTERNET_STATUS_NAME_RESOLVED = 11
Private Const INTERNET_STATUS_CONNECTING_TO_SERVER = 20
Private Const INTERNET_STATUS_CONNECTED_TO_SERVER = 21
Private Const INTERNET_STATUS_SENDING_REQUEST = 30
Private Const INTERNET_STATUS_REQUEST_SENT = 31
Private Const INTERNET_STATUS_RECEIVING_RESPONSE = 40
Private Const INTERNET_STATUS_RESPONSE_RECEIVED = 41
Private Const INTERNET_STATUS_CTL_RESPONSE_RECEIVED = 42
Private Const INTERNET_STATUS_PREFETCH = 43
Private Const INTERNET_STATUS_CLOSING_CONNECTION = 50
Private Const INTERNET_STATUS_CONNECTION_CLOSED = 51
Private Const INTERNET_STATUS_HANDLE_CREATED = 60
Private Const INTERNET_STATUS_HANDLE_CLOSING = 70
Private Const INTERNET_STATUS_REQUEST_COMPLETE = 100
Private Const INTERNET_STATUS_REDIRECT = 110
Private Const INTERNET_STATUS_STATE_CHANGE = 200
Private Const INTERNET_ERROR_BASE = 12000
Private Const ERROR_INTERNET_OUT_OF_HANDLES = 12001
Private Const ERROR_INTERNET_TIMEOUT = 12002
Private Const ERROR_INTERNET_EXTENDED_ERROR = 12003
Private Const ERROR_INTERNET_INTERNAL_ERROR = 12004
Private Const ERROR_INTERNET_INVALID_URL = 12005
Private Const ERROR_INTERNET_UNRECOGNIZED_SCHEME = 12006
Private Const ERROR_INTERNET_NAME_NOT_RESOLVED = 12007
Private Const ERROR_INTERNET_PROTOCOL_NOT_FOUND = 12008
Private Const ERROR_INTERNET_INVALID_OPTION = 12009
Private Const ERROR_INTERNET_BAD_OPTION_LENGTH = 12010
Private Const ERROR_INTERNET_OPTION_NOT_SETTABLE = 12011
Private Const ERROR_INTERNET_SHUTDOWN = 12012
Private Const ERROR_INTERNET_INCORRECT_USER_NAME = 12013
Private Const ERROR_INTERNET_INCORRECT_PASSWORD = 12014
Private Const ERROR_INTERNET_LOGIN_FAILURE = 12015
Private Const ERROR_INTERNET_INVALID_OPERATION = 12016
Private Const ERROR_INTERNET_OPERATION_CANCELLED = 12017
Private Const ERROR_INTERNET_INCORRECT_HANDLE_TYPE = 12018
Private Const ERROR_INTERNET_INCORRECT_HANDLE_STATE = 12019
Private Const ERROR_INTERNET_NOT_PROXY_REQUEST = 12020
Private Const ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND = 12021
Private Const ERROR_INTERNET_BAD_REGISTRY_PARAMETER = 12022
Private Const ERROR_INTERNET_NO_DIRECT_ACCESS = 12023
Private Const ERROR_INTERNET_NO_CONTEXT = 12024
Private Const ERROR_INTERNET_NO_CALLBACK = 12025
Private Const ERROR_INTERNET_REQUEST_PENDING = 12026
Private Const ERROR_INTERNET_INCORRECT_FORMAT = 12027
Private Const ERROR_INTERNET_ITEM_NOT_FOUND = 12028
Private Const ERROR_INTERNET_CANNOT_CONNECT = 12029
Private Const ERROR_INTERNET_CONNECTION_ABORTED = 12030
Private Const ERROR_INTERNET_CONNECTION_RESET = 12031
Private Const ERROR_INTERNET_FORCE_RETRY = 12032
Private Const ERROR_INTERNET_INVALID_PROXY_REQUEST = 12033
Private Const ERROR_INTERNET_NEED_UI = 12034
Private Const ERROR_INTERNET_HANDLE_EXISTS = 12036
Private Const ERROR_INTERNET_SEC_CERT_DATE_INVALID = 12037
Private Const ERROR_INTERNET_SEC_CERT_CN_INVALID = 12038
Private Const ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR = 12039
Private Const ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR = 12040
Private Const ERROR_INTERNET_MIXED_SECURITY = 12041
Private Const ERROR_INTERNET_CHG_POST_IS_NON_SECURE = 12042
Private Const ERROR_INTERNET_POST_IS_NON_SECURE = 12043
Private Const ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED = 12044
Private Const ERROR_INTERNET_INVALID_CA = 12045
Private Const ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP = 12046
Private Const ERROR_INTERNET_ASYNC_THREAD_FAILED = 12047
Private Const ERROR_INTERNET_REDIRECT_SCHEME_CHANGE = 12048
Private Const ERROR_FTP_TRANSFER_IN_PROGRESS = 12110
Private Const ERROR_FTP_DROPPED = 12111
Private Const ERROR_GOPHER_PROTOCOL_ERROR = 12130
Private Const ERROR_GOPHER_NOT_FILE = 12131
Private Const ERROR_GOPHER_DATA_ERROR = 12132
Private Const ERROR_GOPHER_END_OF_DATA = 12133
Private Const ERROR_GOPHER_INVALID_LOCATOR = 12134
Private Const ERROR_GOPHER_INCORRECT_LOCATOR_TYPE = 12135
Private Const ERROR_GOPHER_NOT_GOPHER_PLUS = 12136
Private Const ERROR_GOPHER_ATTRIBUTE_NOT_FOUND = 12137
Private Const ERROR_GOPHER_UNKNOWN_LOCATOR = 12138
Private Const ERROR_HTTP_HEADER_NOT_FOUND = 12150
Private Const ERROR_HTTP_DOWNLEVEL_SERVER = 12151
Private Const ERROR_HTTP_INVALID_SERVER_RESPONSE = 12152
Private Const ERROR_HTTP_INVALID_HEADER = 12153
Private Const ERROR_HTTP_INVALID_QUERY_REQUEST = 12154
Private Const ERROR_HTTP_HEADER_ALREADY_EXISTS = 12155
Private Const ERROR_HTTP_REDIRECT_FAILED = 12156
Private Const ERROR_HTTP_NOT_REDIRECTED = 12160
Private Const ERROR_INTERNET_SECURITY_CHANNEL_ERROR = 12157
Private Const ERROR_INTERNET_UNABLE_TO_CACHE_FILE = 12158
Private Const ERROR_INTERNET_TCPIP_NOT_INSTALLED = 12159
Private Const INTERNET_ERROR_LAST = 12159
Private Const MAX_PATH = 260
Private Const FILE_ATTRIBUTE_TEMPORARY = &H100
Private Const FILE_ATTRIBUTE_SYSTEM = &H4
Private Const FILE_ATTRIBUTE_READONLY = &H1
Private Const FILE_ATTRIBUTE_NORMAL = &H80
Private Const FILE_ATTRIBUTE_HIDDEN = &H2
Private Const FILE_ATTRIBUTE_DIRECTORY = &H10
Private Const FILE_ATTRIBUTE_COMPRESSED = &H800
Private Const FILE_ATTRIBUTE_ARCHIVE = &H20
Private Const FILE_BEGIN = 0
Private Const FILE_CURRENT = 1
Private Const FILE_END = 2
Private Const GENERIC_READ = &H80000000
Private Const GENERIC_WRITE = &H40000000
Private Const OPEN_ALWAYS = 4
Private Type SYSTEMTIME
    wYear As Integer
    wMonth As Integer
    wDayOfWeek As Integer
    wDay As Integer
    wHour As Integer
    wMinute As Integer
    wSecond As Integer
    wMilliseconds As Integer
End Type
Private Type FILETIME
    dwLowDateTime As Long
    dwHighDateTime As Long
End Type
Private Type WIN32_FIND_DATA
    dwFileAttributes As Long
    ftCreationTime As FILETIME
    ftLastAccessTime As FILETIME
    ftLastWriteTime As FILETIME
    nFileSizeHigh As Long
    nFileSizeLow As Long
    dwReserved0 As Long
    dwReserved1 As Long
    cFileName As String * MAX_PATH
    cAlternate As String * 14
End Type
Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Long
End Type
Private Type OVERLAPPED
    Internal As Long
    InternalHigh As Long
    offset As Long
    OffsetHigh As Long
    hEvent As Long
End Type
Private Declare Function GetLastError Lib "kernel32" () As Long
Private Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long
Private Declare Function ReadFile Lib "kernel32" (ByVal hFile As Long, lpBuffer As Any, ByVal nNumberOfBytesToRead As Long, lpNumberOfBytesRead As Long, lpOverlapped As OVERLAPPED) As Long
Private Declare Function WriteFile Lib "kernel32" (ByVal hFile As Long, ByVal lpBuffer As Any, ByVal nNumberOfBytesToWrite As Long, lpNumberOfBytesWritten As Long, lpOverlapped As OVERLAPPED) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function FindFirstFile Lib "kernel32" Alias "FindFirstFileA" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATA) As Long
Private Declare Function FileTimeToSystemTime& Lib "kernel32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME)
Private Declare Function GetTimeFormat Lib "kernel32" Alias "GetTimeFormatA" (ByVal Locale As Long, ByVal dwFlags As Long, lpTime As SYSTEMTIME, ByVal lpFormat As String, ByVal lpTimeStr As String, ByVal cchTime As Long) As Long
Private Declare Function GetDateFormat Lib "kernel32" Alias "GetDateFormatA" (ByVal Locale As Long, ByVal dwFlags As Long, lpDate As SYSTEMTIME, ByVal lpFormat As String, ByVal lpDateStr As String, ByVal cchDate As Long) As Long
Private Declare Function FormatMessage Lib "kernel32" Alias "FormatMessageA" (ByVal dwFlags As Long, lpSource As Any, ByVal dwMessageId As Long, ByVal dwLanguageId As Long, ByVal lpBuffer As String, ByVal nSize As Long, Arguments As Long) As Long
Private Declare Function GetModuleHandle Lib "kernel32" Alias "GetModuleHandleA" (ByVal lpModuleName As String) As Long
Private Const FORMAT_MESSAGE_FROM_HMODULE = &H800
Private Const LANG_USER_DEFAULT = &H400&
Private Const SWP_DRAWFRAME = &H20
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOSIZE = &H1
Private Const SWP_NOZORDER = &H4
Private Const SWP_FLAGS = SWP_NOZORDER Or SWP_NOSIZE Or SWP_NOMOVE Or SWP_DRAWFRAME
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal Cx As Long, ByVal Cy As Long, ByVal wFlags As Long) As Long
Private Const RAS_MAXENTRYNAME As Integer = 256
Private Const RAS_MAXDEVICETYPE As Integer = 16
Private Const RAS_MAXDEVICENAME As Integer = 128
Private Const RAS_RASCONNSIZE As Integer = 412
Private Type RASCONN
    dwSize As Long
    hRasConn As Long
    szEntryName(RAS_MAXENTRYNAME) As Byte
    szDeviceType(RAS_MAXDEVICETYPE) As Byte
    szDeviceName(RAS_MAXDEVICENAME) As Byte
End Type
Private Declare Function RasEnumConnections Lib "rasapi32.dll" Alias "RasEnumConnectionsA" (udtRasConn As Any, lpcb As Long, lpcConnections As Long) As Long
Private Declare Function RasHangUp Lib "rasapi32.dll" Alias "RasHangUpA" (ByVal hRasConn As Long) As Long
Private lConnected As Boolean
Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Private Declare Function GetExitCodeThread Lib "kernel32" (ByVal hThread As Long, lpExitCode As Long) As Long
Private Declare Function CreateThread Lib "kernel32" (ByVal lpThreadAttributes As Long, ByVal dwStackSize As Long, ByVal lpStartAddress As Long, ByVal lpParameter As Long, ByVal dwCreationFlags As Long, lpThreadId As Long) As Long
Private Declare Function GlobalAlloc Lib "kernel32" (ByVal Flags As Long, ByVal Size As Long) As Long
Private Declare Function GlobalFree Lib "kernel32" (ByVal Mem As Long) As Long
Private Declare Function MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Dest As Any, ByRef Src As Any, ByVal Size As Long) As Long
Private Const GMEM_FIXED As Long = 0&

Private Function CallFuncPtr(FuncPtr As Long, ParamArray Params() As Variant) As Long
Const MAX_CODESIZE  As Long = 65536
Dim i               As Long
Dim pCodeData       As Long
Dim pParamData()    As Long
Dim PC              As Long
Dim Operand         As Long
Dim RetValue        As Long
Dim StrValue        As String
Dim LongValue       As Long
Dim dwThreadID      As Long
Dim hThread         As Long
Dim dwExit          As Long
ReDim pParamData(UBound(Params)) As Long
pCodeData = GlobalAlloc(GMEM_FIXED, MAX_CODESIZE)
PC = pCodeData
AddByte PC, &H55
For i = UBound(Params) To 0 Step -1
    If VarType(Params(i)) = vbString Then
        pParamData(i) = GlobalAlloc(GMEM_FIXED, LenB(Params(i)))
        StrValue = Params(i)
        MoveMemory ByVal pParamData(i), ByVal StrValue, LenB(StrValue)
        Operand = pParamData(i)
    Else
        Operand = Params(i)
    End If
    AddByte PC, &H68
    AddLong PC, Operand
Next
AddByte PC, &HB8
AddLong PC, FuncPtr
AddInt PC, &HD0FF
AddByte PC, &HBA
AddLong PC, VarPtr(RetValue)
AddInt PC, &H289
AddByte PC, &H5D
AddInt PC, &HC033
AddByte PC, &HC2
AddInt PC, &H8
hThread = CreateThread(0, 0, pCodeData, 0, 0, dwThreadID)
Do
    GetExitCodeThread hThread, dwExit
    If dwExit <> 259 Then Exit Do
    DoEvents
Loop
GlobalFree pCodeData
For i = 0 To UBound(Params)
    If pParamData(i) <> 0 Then
        GlobalFree pParamData(i)
    End If
Next
CallFuncPtr = RetValue
End Function

Private Sub AddByte(ByRef PC As Long, ByVal ByteValue As Byte)
MoveMemory ByVal PC, ByteValue, 1
PC = PC + 1
End Sub

Private Sub AddInt(ByRef PC As Long, ByVal IntValue As Integer)
MoveMemory ByVal PC, IntValue, 2
PC = PC + 2
End Sub

Private Sub AddLong(ByRef PC As Long, ByVal LongValue As Long)
MoveMemory ByVal PC, LongValue, 4
PC = PC + 4
End Sub

'Public Function ReturnThread(lModule As String, lProcName As String, lParam1 As Variant, lParam2 As Variant, lUseParam1 As Boolean, lUseParam2 As Boolean) As Long
'On Local Error GoTo ErrHandler
'Dim l As Long
'l = GetProcAddress(LoadLibrary(lModule), lProcName)
'If lUseParam1 = True And lUseParam2 = True Then
'    ReturnThread = CallFuncPtr(l, 0, lParam1, lParam2)
'ElseIf lUseParam1 = True And lUseParam2 = False Then
'    ReturnThread = CallFuncPtr(l, 0, lParam1)
'End If

'l = GetProcAddress(LoadLibrary("user32"), "MessageBoxA")
'If CallFuncPtr(l, 0, "MessageBoxA test", "Title", 1) = 1 Then
'    MsgBox "You pressed OK"
'Else
'    MsgBox "You pressed cancel"
'End If
'Exit Function
'ErrHandler:
'    MsgBox "ReturnThread " & Err.Description
'    Err.Clear
'End Function

Public Sub SetConnected(lValue As Boolean)
On Local Error Resume Next
lConnected = lValue
End Sub

Public Function ReturnConnected() As Boolean
On Local Error Resume Next
ReturnConnected = lConnected
End Function

Public Function ReturnAdr() As String
On Local Error GoTo ErrHandler
ReturnAdr = adr
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function LoginToFTP() As Boolean
On Local Error GoTo ErrHandler
If FTPConnect("Team Nexgen", "ftp.tnexgen.com", "21", "du@tnexgen.com", "pepsi", True, True) = True Then
    LoginToFTP = True
Else
    LoginToFTP = False
End If
Exit Function
ErrHandler:
    Err.Clear
End Function

Private Function FTPConnect(lSiteName As String, lServer As String, lPort As String, lUserId As String, lPassword As String, lBinary As Boolean, lPassive As Boolean) As Boolean
On Local Error Resume Next
Dim Service As Long
If Len(lServer) <= 6 Then
    Exit Function
End If
Adresa = lServer
ID = lUserId
Pass = lPassword
port = lPort
Klic = ""
If lSiteName = "" Then
    lSiteName = App.Title
End If
If lBinary = True Then
    Transfer = FTP_TRANSFER_TYPE_BINARY
ElseIf lBinary = False Then
    Transfer = FTP_TRANSFER_TYPE_ASCII
End If
If lPassive = True Then
    Service = INTERNET_FLAG_PASSIVE
ElseIf lPassive = False Then
    Service = INTERNET_FLAG_EXISTING_CONNECT
End If
'session = InternetOpen(lSiteName, INTERNET_OPEN_TYPE_DIRECT, "", "", INTERNET_FLAG_NO_CACHE_WRITE)
Dim l As Long, o As Long
l = GetProcAddress(LoadLibrary("wininet.dll"), "InternetOpenA")
session = CallFuncPtr(l, lSiteName, INTERNET_OPEN_TYPE_DIRECT, "", "", INTERNET_FLAG_NO_CACHE_WRITE)
If session <> 0 Then
    'server = InternetConnect(session, Adresa, port, ID, Pass, INTERNET_SERVICE_FTP, Service, &H0)
    o = GetProcAddress(LoadLibrary("wininet.dll"), "InternetConnectA")
    server = CallFuncPtr(o, session, Adresa, port, ID, Pass, INTERNET_SERVICE_FTP, Service, &H0)
    If server = 0 Then
        InternetCloseHandle session
        FTPConnect = False
        Exit Function
    Else
        FTPConnect = True
        SetConnected True
        adr = Space(260)
        FtpGetCurrentDirectory server, adr, Len(adr)
        adr = Left(adr, InStr(1, adr, Chr(0)) - 1)
        adr = adr & IIf((Right(adr, 1) = "/"), "*.*", "/*.*")
        adr = Replace(adr, "*.**.*", "*.*")
        Klic = "/"
        If DoesFileExist(App.Path & "\version.ini") = True Then Kill App.Path & "\version.ini"
        DoEvents
        'ListFTPDirectory
    End If
Else
    InternetCloseHandle session
    Exit Function
End If
End Function

Public Sub ListFTPDirectory()
On Local Error Resume Next
Dim hFile As Long, udtWFD As WIN32_FIND_DATA, strFile As String, Img As Integer, R As Integer, l&, sTime As SYSTEMTIME, lTime As FILETIME, lExit As Boolean, msg As String
If session = 0 Or server = 0 Then
    Exit Sub
End If
adr = Replace(adr, "*.**.*", "*.*")
hFile = FtpFindFirstFile(server, adr, udtWFD, INTERNET_FLAG_RELOAD Or INTERNET_FLAG_NO_CACHE_WRITE, 0&): DoEvents
If hFile Then
    Do
        strFile = Left(udtWFD.cFileName, InStr(1, udtWFD.cFileName, Chr(0)) - 1)
        If Len(strFile) > 0 Then
            If udtWFD.dwFileAttributes And vbDirectory Then
            Else
                If Len(Trim(strFile)) <> 0 Then
                    lTime = udtWFD.ftLastWriteTime
                    FileTimeToSystemTime lTime, sTime
                    msg = strFile
                    msg = GetFileTitle(LCase(msg))
                    AddFile strFile, Trim(CalcFTime(sTime)), Str(udtWFD.nFileSizeLow), adr
                    DoEvents
                End If
            End If
        End If
        DoEvents
    Loop While InternetFindNextFile(hFile, udtWFD)
End If
InternetCloseHandle hFile
End Sub

'Public Function EnterFTPDirectory(lDirectory As String) As Boolean
'On Local Error Resume Next
'If lDirectory = ".." Then
'    Klic = "/"
'    adr = Klic & "*.*"
'Else
'    Klic = lDirectory
'    adr = Klic & "*.*"
'End If
'adr = Replace(adr, "*.**.*", "*.*")
'FtpSetCurrentDirectory session, adr
'ListFTPDirectory
'End Function

Private Function CalcFTime(FTime As SYSTEMTIME) As String
On Local Error GoTo ErrHandler
Dim Datum$, Kdy$, aa$
With FTime
    Datum = .wDay & "." & .wMonth & "." & .wYear
    aa = .wMinute
    If Len(aa) = 1 Then aa = "0" & aa
    Kdy = .wHour & ":" & aa
    CalcFTime = Datum & Kdy
End With
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function DownloadFile(lFilename As String) As Boolean
On Local Error GoTo ErrHandler
Dim sBuffer As String, FileData As String, Ret As Long, SentBytes As Long, sAllBytes As Long, z As Long, i As Integer, FF As Integer, Kam As String, Ode As String, Fs As Long, StartT As Long, t As Long, Cnt As Long, p As Long, spRate As Single, hFile As Long, f As Integer, l As Long
If Len(lFilename) <> 0 Then
    'f = FindFileIndex(lFilename)
    'If f <> 0 Then
    'z = ReturnFileSize(f)
    spRate = 0
    sAllBytes = 0
    'p = 0
    'Ode = "/*.*"
    Ode = "/" & Replace(lFilename, "\", "")
    'Ode = Replace(ReturnFilesRemotePath(f) & lFilename, "*.*", "")
    'Kam = ReturnFileLocalPath(f) & lFilename
    Kam = App.Path & "\" & Replace(lFilename, "\", "")
'    MsgBox Ode
'    MsgBox Kam
    'hFile = FtpOpenFile(server, Ode, GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)
    l = GetProcAddress(LoadLibrary("wininet.dll"), "FtpOpenFileA")
    hFile = CallFuncPtr(l, server, Ode, GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)
    If hFile = 0 Then
        Exit Function
    End If
    sBuffer = Space(sReadBuffer)
    FileData = ""
    SentBytes = 0
    StartT = GetTickCount
    Do
        InternetReadFile hFile, sBuffer, sReadBuffer, Ret
        If Ret <> sReadBuffer Then
            sBuffer = Left$(sBuffer, Ret)
        End If
        FileData = FileData + sBuffer
        SentBytes = SentBytes + Ret
        sAllBytes = sAllBytes + Ret
        If SentBytes <> 0 Then
            t = GetTickCount - StartT
            If t <> 0 Then
                spRate = (spRate + ((SentBytes / 1000) / (t / 1000))) / 2
            End If
        End If
        Pause 0.0001
    Loop Until Ret <> sReadBuffer
    FF = FreeFile
    Open Kam For Binary As #FF
        Put #FF, , FileData
    Close #FF
    p = t / 1000
    InternetCloseHandle hFile
    'End If
End If
DownloadFile = True
Exit Function
ErrHandler:
    Err.Clear
End Function

'Public Function RemoveDirectory(lDirectory As String) As Boolean
'On Local Error GoTo ErrHandler
'If FtpRemoveDirectory(server, lDirectory) = False Then
'    Exit Function
'End If
'RemoveDirectory = True
'Exit Function
'ErrHandler:
'    Err.Clear
'End Function

Public Sub CloseConnection()
On Local Error GoTo ErrHandler
SetConnected False
InternetCloseHandle server
InternetCloseHandle session
Exit Sub
ErrHandler:
    Err.Clear
End Sub

'Public Function CreateDirectory(lRemoteDir As String) As Boolean
'On Local Error GoTo ErrHandler
'SetUpdateBusy True
'If FtpCreateDirectory(server, lRemoteDir) = False Then
'    Exit Function
'End If
'CreateDirectory = True
'Exit Function
'ErrHandler:
'    Err.Clear
'End Function

'Public Function DeleteFile(lFilename As String, lRemotePath As String) As Boolean
'On Local Error GoTo ErrHandler
'EnterFTPDirectory lRemotePath
'If FtpDeleteFile(server, lRemotePath & lFilename) = False Then
'    Exit Function
'End If
'DeleteFile = True
'Exit Function
'ErrHandler:
'    Err.Clear
'End Function

'Public Sub UploadFile(lFilePath As String, lFilename As String, lRemotePath As String)
'On Local Error Resume Next
'Dim Cnt As Long, nFileLen As Long, nRet As Long, nTotFileLen As Long, sBuffer As String * 1024, Ret As Long, SentBytes As Long, sAllBytes As Long, z As Long, i As Integer, Kam As String, Ode As String, Fs As Long, StartT As Long, t As Long, p As Long, spRate As Single, hFile As Long
'If ReturnConnected = False Then
'    Exit Sub
'End If
'spRate = 0
'sAllBytes = 0
'p = 0
'EnterFTPDirectory lRemotePath
'Ode = lFilePath & lFilename
'Kam = Klic & lFilename
'hFile = FtpOpenFile(server, Kam, GENERIC_WRITE, FTP_TRANSFER_TYPE_BINARY, 0)
'If hFile = 0 Then
'    Exit Sub
'End If
'SentBytes = 0
'nFileLen = 0
'StartT = GetTickCount
'Open Ode For Binary As #1
'    nTotFileLen = LOF(1)
'    Do
'        Get #1, , sBuffer
'        If nFileLen < nTotFileLen - sReadBuffer Then
'            If InternetWriteFile(hFile, sBuffer, sReadBuffer, nRet) = 0 Then
'                Exit Do
'            End If
'            SentBytes = SentBytes + sReadBuffer
'            sAllBytes = sAllBytes + sReadBuffer
'            nFileLen = nFileLen + sReadBuffer
'        Else
'            If InternetWriteFile(hFile, sBuffer, nTotFileLen - nFileLen, nRet) = 0 Then
'                Exit Do
'            End If
'            SentBytes = SentBytes + (nTotFileLen - nFileLen)
'            sAllBytes = sAllBytes + (nTotFileLen - nFileLen)
'            nFileLen = nTotFileLen
'        End If
'    Loop Until nFileLen >= nTotFileLen
'Close
'InternetCloseHandle hFile
'End Sub
