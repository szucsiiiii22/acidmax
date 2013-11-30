VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSystemStats20"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long

Private Sub Class_Initialize()
On Local Error GoTo ErrHandler

Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub StartSystemStats(lData As String)
On Local Error GoTo ErrHandler
SetParentHwnd CLng(Trim(lData))
InitMainForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function returnNetworkAdapter(lData As String)
On Local Error GoTo ErrHandler
Dim lObject As Object, lObjectItem As Object, ltmp, lItem As Object, msg As String
Set lObject = GetObject("winmgmts:\\.\root\cimv2")
Set lObjectItem = lObject.execquery("Select * from Win32_NetworkAdapter", , 48)
For Each lItem In lObjectItem
    With lItem
        ltmp = ltmp + 1
        msg = LCase("adapter type: " & .AdapterType & ", manufacturer: " & .Manufacturer)
    End With
Next lItem
Set lObject = Nothing
Set lObjectItem = Nothing
returnNetworkAdapter = msg
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function returnOS(lData As String)
On Local Error GoTo ErrHandler
Dim lObject As Object, lObjectItem As Object, ltmp, lItem As Object, msg As String
Set lObject = GetObject("winmgmts:\\.\root\cimv2")
Set lObjectItem = lObject.execquery("Select * from Win32_OperatingSystem", , 48)
For Each lItem In lObjectItem
    With lItem
        ltmp = ltmp + 1
        msg = "build: " & .BuildNumber & ", csd: " & .CSDVersion & ", description: " & .Description & ", manufacturer: " & .Manufacturer & ", version: " & .Version
    End With
Next lItem
Set lObject = Nothing
Set lObjectItem = Nothing
returnOS = msg
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function returnMonitor(lData As String)
On Local Error GoTo ErrHandler
Dim lObject As Object, lObjectItem As Object, ltmp, lItem As Object, msg As String
Set lObject = GetObject("winmgmts:\\.\root\cimv2")
Set lObjectItem = lObject.execquery("Select * from Win32_DesktopMonitor", , 48)
For Each lItem In lObjectItem
    With lItem
        ltmp = ltmp + 1
        msg = LCase("description: " & .Description & ", manufacturer: " & .MonitorManufacturer & ", dimensions: " & .ScreenWidth & "X" & .ScreenHeight)
    End With
Next lItem
Set lObject = Nothing
Set lObjectItem = Nothing
returnMonitor = msg
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function


Public Function returnBios(lData As String)
On Local Error GoTo ErrHandler
Dim lObject As Object, lObjectItem As Object, ltmp, lItem As Object, msg As String
Set lObject = GetObject("winmgmts:\\.\root\cimv2")
Set lObjectItem = lObject.execquery("Select * from Win32_BIOS", , 48)
For Each lItem In lObjectItem
    With lItem
        ltmp = ltmp + 1
        msg = LCase("element id: " & .SoftwareElementID & ", manufacturer: " & .Manufacturer & ", version: " & .Version)
    End With
Next lItem
Set lObject = Nothing
Set lObjectItem = Nothing
returnBios = msg
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Sub Class_Terminate()
On Local Error GoTo ErrHandler
DestroyMainForm
CoFreeUnusedLibraries
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
