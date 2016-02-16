VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SystemStats"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private osInfo As OSVERSIONINFO
Private activeProcessorMask As String
Private systemInfo As SYSTEM_INFO
Private numberOfCpus As Integer
Private processorType As String
Private osVersion As String
Private osBuild As String
Private inited As Boolean
Private osInfoBuildNumber As String
Private osInfoMajorVersion As String
Private osInfoMinorVersion As String
Private osInfoOSVersionInfoSize As String
Private osInfoPlatformId As String
Private osInfoCSDVersion As String
Private availablePhysicalMemory As String
Private totalPhysicalMemory As String
Private oemID As String
Private reserved As String
Private cpu() As gSystemStatsCpu

Public Function GetProcessorInfo() As String
On Error GoTo ErrHandler
Dim result As String, i As Integer, c As gSystemStatsCpu
If (inited = False) Then Init
For i = 0 To UBound(cpu) - 1
    Dim msg As String
    msg = cpu(i).Name & " " & cpu(i).Description
    If (Len(Trim(msg)) <> 0) Then
        If (Len(result) <> 0) Then
            result = result & ", " & msg
        Else
            result = msg
        End If
    End If
Next i
GetProcessorInfo = result
Exit Function
ErrHandler:
End Function

Public Function GetBIOS() As String
On Error GoTo ErrHandler
Dim objWMI As Object, objItem As Object, Item As Object
If Len(MultiItem$) = 0 Then lstMultItems.ListItems.Clear
    Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
    Set objItem = objWMI.execquery("Select * from Win32_BIOS", , 48)
    For Each Item In objItem
        With Item
            Dim newItem As gSystemStatsBios
            newItem.BuildNumber = .BuildNumber
            newItem.Description = .Description
            
            'If DoesListItemExist(.SoftwareElementID, lstMultItems) = False Then lstMultItems.ListItems.Add , "d" & .SoftwareElementID, .SoftwareElementID
            'If Len(.Description) <> 0 Then itmX.SubItems(1) = .Description
            'If Len(.BuildNumber) <> 0 Then itmX.SubItems(1) = CStr(.BuildNumber)
            'If Len(.LanguageEdition) <> 0 Then itmX.SubItems(1) = CStr(.LanguageEdition)
            'If Len(CStr(.Manufacturer)) <> 0 Then itmX.SubItems(1) = CStr(.Manufacturer)
            'If Len(.Version) <> 0 Then itmX.SubItems(1) = .Version
        End If
    End With
Next Item
lstClasses.ListItems.Clear
lstClasses.ListItems.Add , "Win32_BIOS", "System BIOS"
Set objWMI = Nothing
Set objItem = Nothing
End Function

Private Function GetProcessorInfoLoad() As gSystemStatsCpu()
On Error GoTo ErrHandler
Dim result(3) As gSystemStatsCpu
Dim objWMI As Object
Dim objItem As Object
Dim Item As Object
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_Processor", , 48)
Dim n As Integer
n = 0
For Each Item In objItem
    With Item
        Dim newItem As gSystemStatsCpu
        newItem.Name = .Name
        newItem.Description = .Description
        newItem.SocketDesignation = .SocketDesignation
        newItem.Manufacturer = .Manufacturer
        newItem.MaxClockSpeed = .MaxClockSpeed
        result(n) = newItem
        n = n + 1
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
GetProcessorInfoLoad = result
Exit Function
ErrHandler:
End Function

Public Function GetAvailablePhysicalMemory() As String
Init
GetAvailablePhysicalMemory = availablePhysicalMemory
End Function

Public Function GetReserved() As String
If (inited = False) Then Init
GetReserved = reserved
End Function

Public Function GetOemID() As String
If (inited = False) Then Init
GetOemID = oemID
End Function

Public Function GetTotalPhysicalMemory() As String
If (inited = False) Then Init
GetTotalPhysicalMemory = totalPhysicalMemory
End Function

Public Function GetOSInfoBuildNumber() As String
If (inited = False) Then Init
GetOSInfoBuildNumber = osInfoBuildNumber
End Function

Public Function GetOSInfoMajorVersion() As String
If (inited = False) Then Init
GetOSInfoMajorVersion = osInfoMajorVersion
End Function

Public Function GetOSInfoMinorVersion() As String
If (inited = False) Then Init
GetOSInfoMinorVersion = osInfoMinorVersion
End Function

Public Function GetOSInfoOSVersionInfoSize() As String
If (inited = False) Then Init
GetOSInfoOSVersionInfoSize = osInfoOSVersionInfoSize
End Function

Public Function GetOSInfoPlatformId() As String
If (inited = False) Then Init
GetOSInfoPlatformId = osInfoPlatformId
End Function

Public Function GetOSInfoCSDVersion() As String
If (inited = False) Then Init
GetOSInfoCSDVersion = osInfoCSDVersion
End Function

Public Function Run() As String
End Function

Private Sub Class_Initialize()
Init
End Sub

Private Sub Class_Terminate()
'DestroyMainForm
CoFreeUnusedLibraries
End Sub

Public Function Initialize(hWnd As String)
SetParentHwnd CLng(Trim(hWnd))
InitMainForm
End Function

Private Sub LoadSystemStats()
'Dim dwLen As Long
'Dim strString As String
'Dim strSave As String, ret As Long, x As Integer
'Dim strUserName As String
'strSave = String(255, Chr$(0))
'ret& = GetLogicalDriveStrings(255, strSave)
'For x = 1 To 100
    'If Left$(strSave, InStr(1, strSave, Chr$(0))) = Chr$(0) Then Exit For
    'cboDrive.AddItem Left$(strSave, InStr(1, strSave, Chr$(0)) - 1)
    'strSave = Right$(strSave, Len(strSave) - InStr(1, strSave, Chr$(0)))
'Next x
'cboDrive.ListIndex = 1
'dwLen = MAX_COMPUTERNAME_LENGTH + 1
'strString = String(dwLen, "X")
'Get the computer name
'GetComputerName strString, dwLen
'get only the actual data
'strString = Left(strString, dwLen)
'lblCompName.Caption = strString
'strUserName = String(100, Chr$(0))
'Get the username
'GetUserName strUserName, 100
'strip the rest of the buffer
'strUserName = Left$(strUserName, InStr(strUserName, Chr$(0)) - 1)
'lblUser.Caption = strUserName
'user = strUserName
'Dim MemStat As MEMORYSTATUS
'Dim lngPhysMem As Long
'Dim lngAPhysMem As Long
'Dim lngPPhysMem As Long
'Dim lngVirMem As Long
'Dim lngAVirMem As Long
'Dim lngPVirMem As Long
'Dim lngPageFile As Long
'Dim lngAPageFile As Long
'Dim lngPPageFile As Long
'GlobalMemoryStatus MemStat
'lngPhysMem = MemStat.dwTotalPhys '/ 1024
'lngAPhysMem = MemStat.dwAvailPhys '/ 1024
'lngPPhysMem = Percent(lngPhysMem, lngAPhysMem, lblInfo(0).Width)
'lblInfo(0).Caption = "Physical Memory (" & Percent(lngPhysMem, lngAPhysMem, 100) & "%)"
'Debug.Print lngPPhysMem & "%", "Physical"
'shpStatus(0).Width = lngPPhysMem
'lblInfo2(0).Caption = ConvertMegaBytes(lngAPhysMem, 2) & " Of " & ConvertMegaBytes(lngPhysMem, 2)
'lngVirMem = MemStat.dwTotalVirtual / 1024
'lngAVirMem = MemStat.dwAvailVirtual / 1024
'lngPVirMem = Percent(lngVirMem, lngAVirMem, lblInfo(1).Width)
'lblInfo(1).Caption = "Virtual Memory (" & Percent(lngVirMem, lngAVirMem, 100) & "%)"
'Debug.Print lngPVirMem & "%", "Virtual"
'shpStatus(1).Width = lngPVirMem
'lblInfo2(1).Caption = ConvertMegaBytes(lngAVirMem, 2) & " Of " & ConvertMegaBytes(lngVirMem, 2)
'lblInfo2(1).Caption = ""
'lngPageFile = MemStat.dwTotalPageFile '/ 1024
'lngAPageFile = MemStat.dwAvailPageFile '/ 1024
'lngPPageFile = Percent(lngPageFile, lngAPageFile, lblInfo(2).Width)
'lblInfo(2).Caption = "Page File (" & Percent(lngPageFile, lngAPageFile, 100) & "%)"
'Debug.Print lngPPageFile & "%", "Pagefile"
'shpStatus(2).Width = lngPPageFile
'lblInfo2(2).Caption = ConvertMegaBytes(lngAPageFile, 2) & " Of " & ConvertMegaBytes(lngPageFile, 2)
'lblInfo(3).Caption = "Memory Load (" & MemStat.dwMemoryLoad & "%)"
'shpStatus(3).Width = Percent(100, MemStat.dwMemoryLoad, lblInfo(3).Width)
'Dim SInfo As SYSTEM_INFO
'Dim ret2 As Long
'Get Version Info
'OSInfo.dwOSVersionInfoSize = Len(OSInfo)
'ret2& = GetVersionEx(OSInfo)
'Select Case OSInfo.dwPlatformId
  'Case 0
    'PId = "Windows 32s"
  'Case 1
    'PId = "Windows 95/98/98SE/ME"
  'Case 2
    'PId = "Windows NT/2000/XP/VISTA/7/8/8.1/10"
'End Select
'Get the system information
'GetSystemInfo SInfo
'lblSysInfo(0).Caption = "Number Of Proccessors: " & Str$(SInfo.dwNumberOrfProcessors)
'lblSysInfo(1).Caption = "Proccessor Type: " & Str$(SInfo.dwProcessorType)
'lblSysInfo(2).Caption = "OS: " & PId
'lblSysInfo(3).Caption = "Version:" & Str$(OSInfo.dwMajorVersion) & "." + LTrim(Str(OSInfo.dwMinorVersion))
'lblSysInfo(4).Caption = "Build: " & Str(OSInfo.dwBuildNumber) & " (" & Left$(OSInfo.szCSDVersion, InStr(1, OSInfo.szCSDVersion, Chr$(0)) - 1) & ")"
'msgbox osinfo.
'If OSInfo.dwPlatformId <> 2 Then
  'cmdLock.Enabled = False
'End If
'cmdLock.Caption = "E&xit System Stats"
'timStats.Enabled = True
End Sub

Public Function NumberOfProcessors() As String
If (inited = False) Then Init
NumberOfProcessors = numberOfCpus
End Function

Public Function GetProcessorType() As String
If (inited = False) Then Init
GetProcessorType = processorType
End Function

Public Function GetActiveProcessorMask() As String
If (inited = False) Then Init
GetActiveProcessorMask = activeProcessorMask
End Function

Public Sub Init()
Dim msg As String
GetSystemInfo systemInfo
numberOfCpus = systemInfo.dwNumberOrfProcessors
processorType = systemInfo.dwProcessorType
activeProcessorMask = systemInfo.dwActiveProcessorMask
oemID = systemInfo.dwOemID
reserved = systemInfo.dwReserved
Dim ret2 As String
ret2 = GetVersionEx(osInfo)
osInfoBuildNumber = osInfo.dwBuildNumber
osInfoMajorVersion = osInfo.dwMajorVersion
osInfoMinorVersion = osInfo.dwMinorVersion
osInfoOSVersionInfoSize = osInfo.dwOSVersionInfoSize
osInfoPlatformId = osInfo.dwPlatformId
osInfoCSDVersion = osInfo.szCSDVersion
Dim m As MEMORYSTATUS
GlobalMemoryStatus m
availablePhysicalMemory = m.dwAvailPhys
totalPhysicalMemory = m.dwTotalPhys
cpu = GetProcessorInfoLoad()
inited = True
'lblSysInfo(1).Caption = "Proccessor Type: " & Str$(SInfo.dwProcessorType)
'lblSysInfo(2).Caption = "OS: " & PId
'lblSysInfo(3).Caption = "Version:" & Str$(OSInfo.dwMajorVersion) & "." + LTrim(Str(OSInfo.dwMinorVersion))
'lblSysInfo(4).Caption = "Build: " & Str(OSInfo.dwBuildNumber) & " (" & Left$(OSInfo.szCSDVersion, InStr(1, OSInfo.szCSDVersion, Chr$(0)) - 1) & ")"
End Sub
