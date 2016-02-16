VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Advanced System Stats"
   ClientHeight    =   4935
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7320
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   329
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   488
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   690
      Left            =   0
      TabIndex        =   6
      Top             =   4305
      Width           =   7335
      Begin VB.TextBox txtChannel 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1560
         TabIndex        =   8
         Top             =   120
         Width           =   3375
      End
      Begin Stats.isButton cmdSend 
         Height          =   345
         Left            =   6240
         TabIndex        =   7
         Top             =   80
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   609
         Icon            =   "frmMain.frx":0CCA
         Style           =   8
         Caption         =   "&Send"
         iNonThemeStyle  =   0
         Tooltiptitle    =   ""
         ToolTipIcon     =   0
         ToolTipType     =   1
         ttForeColor     =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
         MaskColor       =   0
         RoundedBordersByTheme=   0   'False
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Channel/User:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   480
         TabIndex        =   9
         Top             =   120
         Width           =   1575
      End
      Begin VB.Image imgStyle 
         Height          =   345
         Left            =   120
         Picture         =   "frmMain.frx":0CE6
         Top             =   60
         Visible         =   0   'False
         Width           =   285
      End
   End
   Begin Stats.ctlListView lvwItems 
      Height          =   1425
      Left            =   0
      TabIndex        =   1
      Top             =   315
      Width           =   7215
      _ExtentX        =   12726
      _ExtentY        =   2514
   End
   Begin Stats.ctlListView lvwClasses 
      Height          =   2415
      Left            =   0
      TabIndex        =   2
      Top             =   1800
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   4260
   End
   Begin Stats.ctlListView lvwInfo 
      Height          =   2415
      Left            =   2055
      TabIndex        =   0
      Top             =   1800
      Width           =   5160
      _ExtentX        =   9102
      _ExtentY        =   4260
   End
   Begin Stats.isButton cmdStat 
      Height          =   300
      Index           =   0
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   495
      _ExtentX        =   873
      _ExtentY        =   529
      Icon            =   "frmMain.frx":128C
      Style           =   2
      Caption         =   "CPU"
      iNonThemeStyle  =   0
      Tooltiptitle    =   ""
      ToolTipIcon     =   0
      ToolTipType     =   1
      ttForeColor     =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaskColor       =   0
      RoundedBordersByTheme=   0   'False
   End
   Begin Stats.isButton cmdStat 
      Height          =   300
      Index           =   1
      Left            =   495
      TabIndex        =   4
      Top             =   0
      Width           =   840
      _ExtentX        =   1482
      _ExtentY        =   529
      Icon            =   "frmMain.frx":12A8
      Style           =   2
      Caption         =   "DEVICES"
      iNonThemeStyle  =   0
      Tooltiptitle    =   ""
      ToolTipIcon     =   0
      ToolTipType     =   1
      ttForeColor     =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaskColor       =   0
      RoundedBordersByTheme=   0   'False
   End
   Begin Stats.isButton cmdStat 
      Height          =   300
      Index           =   2
      Left            =   1335
      TabIndex        =   5
      Top             =   0
      Width           =   480
      _ExtentX        =   847
      _ExtentY        =   529
      Icon            =   "frmMain.frx":12C4
      Style           =   2
      Caption         =   "OS"
      iNonThemeStyle  =   0
      Tooltiptitle    =   ""
      ToolTipIcon     =   0
      ToolTipType     =   1
      ttForeColor     =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaskColor       =   0
      RoundedBordersByTheme=   0   'False
   End
   Begin VB.Image imgNet 
      Height          =   240
      Left            =   1920
      Picture         =   "frmMain.frx":12E0
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgKB 
      Height          =   240
      Left            =   2280
      Picture         =   "frmMain.frx":1718
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgKey 
      Height          =   240
      Left            =   2640
      Picture         =   "frmMain.frx":1997
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgSPK 
      Height          =   240
      Left            =   3000
      Picture         =   "frmMain.frx":1C19
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgDrive 
      Height          =   240
      Left            =   3360
      Picture         =   "frmMain.frx":202D
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgFlop 
      Height          =   240
      Left            =   3720
      Picture         =   "frmMain.frx":2446
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgCD 
      Height          =   240
      Left            =   4080
      Picture         =   "frmMain.frx":26B3
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgMonitor 
      Height          =   255
      Left            =   4440
      Picture         =   "frmMain.frx":2AEC
      Top             =   4200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgHardDrive 
      Height          =   240
      Left            =   4800
      Picture         =   "frmMain.frx":2F33
      Top             =   4200
      Visible         =   0   'False
      Width           =   255
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim objShell As Object
Private Const MAX_PATH As Integer = 260
Private Const REG_SZ = 1
Private Const REG_BINARY = 3
Private Const ERROR_SUCCESS = 0&
Private Const HKEY_CURRENT_USER = &H80000001
Private Const HKEY_LOCAL_MACHINE = &H80000002
Private lStatsData As String
Private lCurrentClassData As String
Private lCurrentClassIndex As Integer
Private lCurrentItemData As String
Private lCurrentItemIndex As Integer
'Private lClickedFunction As String
Private lItemKey As String
Private lItemData As String

Sub GetDesktopMonitor(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_DesktopMonitor", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, Trim(CStr(.Caption))) = False Then lvwItems.ItemAdd tmpCnt&, Trim(CStr(.Caption)), 0, 0
        If Trim(MultiItem$) = Trim(CStr(.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Description", CStr(.Description)
            AddToInfo 1, "MonitorManufacturer", CStr(.MonitorManufacturer)
            AddToInfo 2, "ScreenHeight", CStr(.ScreenHeight)
            AddToInfo 3, "ScreenWidth", CStr(.ScreenWidth)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetLogicalDisk(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
If Trim(MultiItem) <> "" Then
    Set objItem = objWMI.execquery("Select * from Win32_LogicalDisk where DeviceID = """ & MultiItem & """", , 48)
Else
    Set objItem = objWMI.execquery("Select * from Win32_LogicalDisk", , 48)
End If
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        'if DoesItemExistInListView(
        'If DoesItemExistInListView(Trim(.DeviceID), lvwItems) = False Then lvwItems.ItemAdd tmpCnt&, Trim(.DeviceID), 0, 0
'        MsgBox "!" & Trim(.DeviceID) & "!"
        If DoesItemExistInListView(lvwItems, Trim(.DeviceID)) = False Then lvwItems.ItemAdd tmpCnt&, Trim(.DeviceID), 0, 0
        If tmpCnt& = 1 Then
            AddToInfo 0, "Description", CStr(.Description)
            AddToInfo 1, "Device ID", CStr(.DeviceID)
            AddToInfo 2, "File System", CStr(.FileSystem)
            AddToInfo 3, "Free Space", FormatByteSize(.FreeSpace, "Free")
            AddToInfo 4, "Size", FormatByteSize(.Size)
            AddToInfo 5, "Status", CStr(.Status)
            AddToInfo 6, "Volume Name", CStr(.VolumeName)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetLogMemConfig(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
If Trim(MultiItem) <> "" Then
    Set objItem = objWMI.execquery("Select * from Win32_LogicalMemoryConfiguration where SettingID = """ & MultiItem & """", , 48)
Else
    Set objItem = objWMI.execquery("Select * from Win32_LogicalMemoryConfiguration", , 48)
End If
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(.Caption, lvwItems) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.Caption), 0, 0
        If tmpCnt& = 1 Then
            AddToInfo 0, "Available Virtual Memory", FormatByteSize(.AvailableVirtualMemory)
            AddToInfo 1, "Total Page File Space", Len(.TotalPageFileSpace)
            AddToInfo 2, "Total Physical Memory", FormatByteSize(.TotalPhysicalMemory)
            AddToInfo 3, "Total Virtual Memory", FormatByteSize(.TotalVirtualMemory)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
lvwClasses.Clear
lvwClasses.ItemAdd 0, "Logical Memory Config", 0, 0
End Sub

Sub GetTimeZone(Optional MultiItem$)
On Local Error GoTo ErrHandler
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_TimeZone", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(.Description, lvwItems) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.Description), 0, 0
        If tmpCnt& = 1 Then
            AddToInfo 0, "Bias", CStr(.Bias)
            AddToInfo 1, "Daylight Bias", CStr(.DayLightBias)
            AddToInfo 2, "Description", CStr(.Description)
            AddToInfo 3, "Setting ID", CStr(.SettingID)
            AddToInfo 4, "Standard Name", CStr(.StandardName)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
lvwClasses.Clear
lvwClasses.ItemAdd 0, "Time Zone", 0, 0
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function DoesItemExistInListView(lListView As ctlListView, lData As String) As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
If Len(lData) <> 0 Then
    For i = 0 To lListView.Count - 1
        'MsgBox lListView.ItemText(i)
        If Trim(LCase(lData)) = Trim(LCase(lListView.ItemText(i))) Then
            DoesItemExistInListView = True
            Exit Function
        End If
    Next i
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Sub GetPnPEntity(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_PnPEntity", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        'If DoesItemExistInListView(lvwItems, CStr(.Description)) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.Description), 0, 0
        If DoesItemExistInListView(lvwItems, CStr(.PNPDeviceID)) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.PNPDeviceID), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Class Guild", CStr(.ClassGuid)
            AddToInfo 1, "Description", CStr(.Description)
            AddToInfo 2, "Device ID", CStr(.PNPDeviceID)
            If MultiItem$ <> "" Then GoTo KillObj
        End If
    End With
Next Item
KillObj:
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetNetworkAdapter(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object, i&
'If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_NetworkAdapter", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, .Description) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.Description), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Adapter Type", CStr(.AdapterType)
            AddToInfo 1, "Manufacturer", CStr(.Manufacturer)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetIDEController(Optional MultiItem$, Optional lSkip)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_IDEController", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.Description)) = False Then
            lvwItems.ItemAdd 0, CStr(.Description), 0, 0
            'lvwitems CStr(.DeviceID),
        End If
        If Trim(MultiItem$) = Trim(CStr(Item.Description)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Manufacturer", CStr(.Manufacturer)
            AddToInfo 1, "Name", CStr(.Name)
            AddToInfo 2, "Plug-N-Play Device ID", CStr(.PNPDeviceID)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetFloppyController(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_FloppyController", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.Description)) = False Then lvwItems.ItemAdd 0, CStr(.Description), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Device ID", CStr(.DeviceID)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Public Sub AddToInfo(lIndex As Integer, lText As String, lSubItem As String)
On Local Error Resume Next
If Len(lText) And Len(lSubItem) <> 0 Then
    lvwInfo.ItemAdd lIndex, lText, 0, 0
    lvwInfo.SubItemSet lIndex, 1, lSubItem, 0
End If
End Sub

Sub GetDiskDrive(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_DiskDrive", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.DeviceID)) = False Then lvwItems.ItemAdd 0, CStr(.DeviceID), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Model", CStr(.Model)
            AddToInfo 1, "Size", FormatByteSize(.Size)
            AddToInfo 2, "Total Cylenders", GroupDigits(.TotalCylinders)
            AddToInfo 3, "Total Heads", GroupDigits(.TotalHeads)
            AddToInfo 4, "Total Sectors", GroupDigits(.TotalSectors)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetOperatingSystem(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_OperatingSystem", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.Caption)) = False Then lvwItems.ItemAdd 0, CStr(.Caption), 0, 0
        If Trim(MultiItem$) = Trim(CStr(.Name)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Build Number", CStr(.BuildNumber)
            AddToInfo 1, "CSD Version", CStr(.CSDVersion)
            AddToInfo 2, "Description", CStr(.Description)
            AddToInfo 3, "Manufacturer", CStr(.Manufacturer)
            AddToInfo 4, "Version", CStr(.Version)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
lvwClasses.Clear
lvwClasses.ItemAdd 0, "OS", 0, -1
lvwClasses.ItemAdd 1, "Boot", 0, -1
lvwClasses.ItemAdd 2, "Bios", 0, -1
End Sub

Sub GetSoundDevice(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
'If Len(MultiItem$) = 0 Then lstMultItems.ListItems.Clear
'lstInfo.ListItems.Clear
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_SoundDevice", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        'lstMultItems.ColumnHeaders(1).Text = "Sound Devices"
        'If DoesListItemExist(.Description, lstMultItems) = False Then lstMultItems.ListItems.Add , "d" & CStr(.DeviceID), CStr(.Description)
        If DoesItemExistInListView(lvwItems, CStr(.DeviceID)) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.DeviceID), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Description", CStr(.Description)
            AddToInfo 1, "Manufacturer", CStr(.Manufacturer)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Private Function QueryInfo(ClassID$, Optional MultiItem$) As Boolean
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Select Case ClassID
'Case "System"
'    GetSystem
Case "Win32_SoundDevice"
    GetSoundDevice MultiItem
Case "Win32_OperatingSystem"
    GetOperatingSystem MultiItem
Case "Win32_Processor"
    GetProcessorInfo MultiItem
Case "Win32_BIOS"
    GetBios MultiItem
Case "Win32_BootConfiguration"
    GetBootConfig MultiItem
Case "Win32_DiskPartition"
    GetDiskPartition MultiItem
Case "Win32_CDROMDrive"
    GetCDROM MultiItem
Case "Win32_DiskDrive"
    GetDiskDrive MultiItem
Case "Win32_FloppyController"
    GetFloppyController MultiItem
Case "Win32_IDEController"
    GetIDEController MultiItem
Case "Win32_Keyboard"
    GetKeyBoard MultiItem
Case "Win32_MotherBoardDevice"
    GetMotherBoard MultiItem
Case "Win32_NetworkAdapter"
    GetNetworkAdapter MultiItem
Case "Win32_PnPEntity"
    GetPnPEntity MultiItem
Case "Win32_VideoController"
    GetVidController MultiItem
Case "Win32_LogicalDisk"
    GetLogicalDisk MultiItem
Case "Win32_DesktopMonitor"
    GetDesktopMonitor MultiItem
'Case "Win32_LogicalMemoryConfiguration"
'    GetLogMemConfig MultiItem
End Select
'If Len(lCurrentItemData) = 0 Then
'lCurrentItemData = MultiItem
'lCurrentItemIndex = 0
'End If
'If Len(lCurrentClassData) = 0 Then
'lCurrentClassData = lvwClasses.ItemText(0)
'lCurrentClassIndex = 0
'End If
CreateStatsMessage
End Function

Public Function FindListViewItem(lListView As ctlListView, lText As String) As Integer
On Local Error Resume Next
Dim i As Integer
If Len(lText) <> 0 Then
    For i = 0 To lListView.Count
        If Trim(LCase(lListView.ItemText(i))) = Trim(LCase(lText)) Then
            FindListViewItem = i
            Exit Function
        End If
    Next i
End If
End Function

Private Sub CreateStatsMessage()
On Local Error Resume Next
Dim lClass As String, lMultiItem As String, lInfo As String, msg As String, msg2 As String, i As Integer
lClass = lCurrentClassData
lMultiItem = lCurrentItemData
'lClass = lCurrentClassData
'MsgBox lClass
'lMultiItem = lCurrentItemData
If Len(lClass) = 0 Then lClass = lvwClasses.ItemText(0)
If Len(lMultiItem) = 0 Then lMultiItem = lvwItems.ItemText(0)
If Len(lMultiItem) <> 0 Then
    msg = "0[" & lClass & ": " & lMultiItem & "] 12"
Else
    msg = "0[" & lClass & "] 12"
End If
If lvwInfo.Count <> 0 Then
    For i = 0 To lvwInfo.Count
        If Len(lvwInfo.ItemText(i)) <> 0 And lvwInfo.SubItemText(i, 1) Then
            If Len(msg2) <> 0 Then
                msg2 = msg2 & ", " & lvwInfo.ItemText(i) & ": " & lvwInfo.SubItemText(i, 1)
            Else
                msg2 = lvwInfo.ItemText(i) & ": " & lvwInfo.SubItemText(i, 1)
            End If
        End If
    Next i
End If
'If Len(msg2) <> 0 Then lStatsData = msg & msg2 & " 0::acidmax::"
msg2 = Trim(msg2)
If Right(msg2, 1) = ":" Then
    msg2 = Left(msg2, Len(msg2) - 1)
    msg2 = Trim(msg2)
    If Right(msg2, 1) = "," Then msg2 = Left(msg2, Len(msg2) - 1)
End If
lStatsData = msg & msg2 & " 0::acidmax::"
End Sub

Sub GetVidController(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object, i&
'If Len(MultiItem$) = 0 Then lstMultItems.ListItems.Clear
'lstInfo.ListItems.Clear
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_VideoController", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        'lstMultItems.ColumnHeaders(1).Text = "Video Controllers"
        'If DoesListItemExist(CStr(.Description), lstMultItems) = False Then lstMultItems.ListItems.Add , "d" & CStr(.DeviceID), CStr(.Description)
        If DoesItemExistInListView(lvwItems, CStr(.Description)) = False Then lvwItems.ItemAdd tmpCnt&, CStr(.Description), 0, 0
        If Trim(MultiItem$) = Trim(CStr(.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            'Set itmX = lstInfo.ListItems.Add(, , "Accelerator Capabilities")
            'tmpBuffer = ""
            AddToInfo 0, "Ram", FormatByteSize(.AdapterRAM)
            AddToInfo 1, "Color Count", GroupDigits(.CurrentNumberOfColors)
            AddToInfo 2, "Driver Version", CStr(.DriverVersion)
            AddToInfo 3, "INI File", CStr(.InfFilename)
            AddToInfo 4, "Video Mode", CStr(.VideoMode)
            'AddToInfo 5, "Video Mode Description", CStr(.VideoModeDescription)
            'If Len(FormatByteSize(.AdapterRAM)) <> 0 Then Set itmX = lstInfo.ListItems.Add(, , "RAM")
            'If Len(FormatByteSize(.AdapterRAM)) <> 0 Then itmX.SubItems(1) = FormatByteSize(.AdapterRAM)
            'If Len(GroupDigits(.CurrentNumberOfColors)) <> 0 Then Set itmX = lstInfo.ListItems.Add(, , "Color Count")
            'If Len(GroupDigits(.CurrentNumberOfColors)) <> 0 Then itmX.SubItems(1) = GroupDigits(.CurrentNumberOfColors)
            'If Len(CStr(.DriverVersion)) <> 0 Then Set itmX = lstInfo.ListItems.Add(, , "Version")
            'If Len(CStr(.DriverVersion)) <> 0 Then itmX.SubItems(1) = CStr(.DriverVersion)
            'If Len(CStr(.InfFilename)) <> 0 Then Set itmX = lstInfo.ListItems.Add(, , "INF")
            'If Len(CStr(.InfFilename)) <> 0 Then itmX.SubItems(1) = CStr(.InfFilename)
            'If Len(.VideoMode) <> 0 Then Set itmX = lstInfo.ListItems.Add(, , "Video Mode")
            'If Len(.VideoMode) <> 0 Then itmX.SubItems(1) = CStr(.VideoMode)
            'If Len(CStr(.VideoModeDescription)) <> 0 Then Set itmX = lstInfo.ListItems.Add(, , "Video Mode Description")
            'If Len(CStr(.VideoModeDescription)) <> 0 Then itmX.SubItems(1) = CStr(.VideoModeDescription)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetMotherBoard(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_MotherBoardDevice", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.Description)) = False Then lvwItems.ItemAdd 0, CStr(.Description), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Description", CStr(.Description)
            AddToInfo 1, "Primary Bus Type", CStr(.PrimaryBusType)
            AddToInfo 2, "Secondary Bus Type", CStr(.SecondaryBusType)
            'AddToInfo 3, "Revision Number", CStr(.RevisionNumber)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetKeyBoard(Optional MultiItem$)
On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_Keyboard", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.DeviceID)) = False Then lvwItems.ItemAdd 0, CStr(.DeviceID), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Description", CStr(.Description)
            AddToInfo 1, "DeviceID", CStr(.DeviceID)
            AddToInfo 2, "Name", CStr(.Name)
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub


Sub GetCDROM(MultiItem$)
''On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_CDROMDrive", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, CStr(.Name)) = False Then lvwItems.ItemAdd 0, CStr(.Name), 0, 0
        lItemKey = CStr(.DeviceID)
        lItemData = CStr(.Name)
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            lvwInfo.ItemAdd 0, "Manufacturer", 0, 0
            lvwInfo.SubItemSet 0, 1, CStr(.Manufacturer), 0
            lvwInfo.ItemAdd 1, "Name", 0, 0
            lvwInfo.SubItemSet 1, 1, .Name, 0
            lvwInfo.ItemAdd 2, "Size", 0, 0
            lvwInfo.SubItemSet 2, 1, FormatByteSize(.Size), 0
        End If
    End With
Next Item
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetBootConfig(Optional MultiItem$)
'''On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_BootConfiguration", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, .Name) = False Then lvwItems.ItemAdd 0, .Name, 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.Name)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            lvwInfo.ItemAdd 0, "Boot Directory", 0, 0
            lvwInfo.SubItemSet 0, 1, .BootDirectory, 0
            lvwInfo.ItemAdd 1, "Description", 0, 0
            lvwInfo.SubItemSet 1, 1, CStr(.Description), 0
            lvwInfo.ItemAdd 2, "Last Drive", 0, 0
            lvwInfo.SubItemSet 2, 1, CStr(.LastDrive), 0
            lvwInfo.ItemAdd 3, "Temp Directory", 0, 0
            lvwInfo.SubItemSet 3, 1, .TempDirectory, 0
        End If
    End With
Next Item
'lvwClasses.Clear
'lvwClasses.ItemAdd 0, "Boot Config", 0, 0
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Sub GetBios(Optional MultiItem$)
'''On Local Error Resume Next
Dim lObject As Object, lObjectItem As Object, ltmp, lItem As Object, msg As String
If Len(MultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set lObject = GetObject("winmgmts:\\.\root\cimv2")
Set lObjectItem = lObject.execquery("Select * from Win32_BIOS", , 48)
For Each lItem In lObjectItem
    With lItem
        ltmp = ltmp + 1
        If DoesItemExistInListView(lvwItems, Trim(CStr(.SoftwareElementID))) = False Then lvwItems.ItemAdd 0, Trim(CStr(.SoftwareElementID)), 0, 0
        AddToInfo 0, "Element ID", .SoftwareElementID
        AddToInfo 1, "Manufacturer", .Manufacturer
        AddToInfo 2, "Version", .Version
    End With
Next lItem
Set lObject = Nothing
Set lObjectItem = Nothing
End Sub

Sub GetDiskPartition(Optional MultiItem$)
'''On Local Error Resume Next
Dim objWMI As Object, objItem As Object, tmpCnt&, tmpBuffer$, Item As Object
If Len(MultiItem$) = 0 Then lvwItems.Clear
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set objItem = objWMI.execquery("Select * from Win32_DiskPartition", , 48)
For Each Item In objItem
    With Item
        tmpCnt& = tmpCnt& + 1
        If DoesItemExistInListView(lvwItems, Trim(CStr(.DeviceID))) = False Then lvwItems.ItemAdd 0, Trim(CStr(.DeviceID)), 0, 0
        If Trim(MultiItem$) = Trim(CStr(Item.DeviceID)) Or Len(MultiItem$) = 0 And tmpCnt& = 1 Then
            AddToInfo 0, "Bootable", CBoolStr(.Bootable)
            AddToInfo 1, "Description", CStr(.Description)
            AddToInfo 2, "Device ID", CStr(.DeviceID)
            AddToInfo 3, "Number of Blocks", GroupDigits(.NumberOfBlocks)
            AddToInfo 4, "Size", FormatByteSize(.Size)
        End If
    End With
Next Item
lvwClasses.Clear
lvwClasses.ItemAdd 0, "Disk Partitions", 0, 4
lvwClasses.ItemAdd 1, "CDROM Drives", 0, 2
lvwClasses.ItemAdd 2, "Disk Drives", 0, 0
lvwClasses.ItemAdd 3, "Floppy Controller", 0, 3
lvwClasses.ItemAdd 4, "IDE Controller", 0, 4
lvwClasses.ItemAdd 5, "Keyboard", 0, 6
lvwClasses.ItemAdd 6, "Motherboard", 0, -1
lvwClasses.ItemAdd 7, "Network Adapters", 0, 7
lvwClasses.ItemAdd 8, "Plug-N-Play Device ID", 0, -1
lvwClasses.ItemAdd 9, "Audio Devices", 0, 5
lvwClasses.ItemAdd 10, "Logical Disks", 0, -1
'lvwClasses.ItemAdd 11, "Win32_ParallelPort", 0, -1
'lvwClasses.ItemAdd 12, "Win32_SerialPort", 0, -1
'lvwClasses.ItemAdd 13, "Win32_USBController", 0, -1
'lvwClasses.ItemAdd 14, "Win32_USBHub", 0, -1
lvwClasses.ItemAdd 10, "Desktop Monitor", 0, 1
lvwClasses.ItemAdd 11, "Video Devices", 0, 1
Set objWMI = Nothing
Set objItem = Nothing
End Sub

Public Sub GetProcessorInfo(Optional lMultiItem$)
'''On Local Error Resume Next
Dim lObject As Object, lObjectItem As Object, ltmp, lItem As Object, msg As String
If Len(lMultiItem$) = 0 Then lvwItems.Clear
lvwInfo.Clear
Set lObject = GetObject("winmgmts:\\.\root\cimv2")
Set lObjectItem = lObject.execquery("Select * from Win32_Processor", , 48)
For Each lItem In lObjectItem
    With lItem
        ltmp = ltmp + 1
        If DoesItemExistInListView(lvwItems, .DeviceID) = False Then lvwItems.ItemAdd 0, .DeviceID, 0, 0
        If Trim(lMultiItem$) = Trim(CStr(lItem.DeviceID)) Or Len(lMultiItem$) = 0 And ltmp = 1 Then
            lvwInfo.ItemAdd 0, "Description", 0, 0
            lvwInfo.SubItemSet 0, 1, .Description, 0
            lvwInfo.ItemAdd 1, "Manufacturer", 0, 0
            lvwInfo.SubItemSet 1, 1, .Manufacturer, 0
            lvwInfo.ItemAdd 2, "Max Clock Speed", 0, 0
            lvwInfo.SubItemSet 2, 1, CStr(.MaxClockSpeed), 0
            lvwInfo.ItemAdd 3, "Name", 0, 0
            lvwInfo.SubItemSet 3, 1, .Name, 0
            lvwInfo.ItemAdd 4, "Socket", 0, 0
            lvwInfo.SubItemSet 4, 1, .SocketDesignation, 0
        End If
    End With
Next lItem
lvwClasses.Clear
lvwClasses.ItemAdd 0, "Processors", 0, 0
Set lObject = Nothing
Set lObjectItem = Nothing
End Sub

Private Sub cmdSend_Click()
'''On Local Error Resume Next
'MsgBox lStatsData
'mIRCStatusSend "TEST"
mIRCStatusSend "/msg " & txtChannel.Text & " " & lStatsData & vbCrLf
End Sub

Private Sub cmdStat_Click(Index As Integer)
'''On Local Error Resume Next
Dim i As Integer
DoEvents
lCurrentClassData = ""
lCurrentItemData = ""
'lCurrentClassData = lvwClasses.ItemText(0)
'lCurrentClassIndex = 0
For i = 0 To cmdStat.Count - 1
    cmdStat(i).Font.Bold = False
    cmdStat(i).Refresh
Next i
cmdStat(Index).Font.Bold = True
cmdStat(Index).Refresh
Select Case Index
Case 0
    QueryInfo "Win32_Processor"
'Case 1
'    QueryInfo "System"
'Case 2
'    QueryInfo "Win32_BootConfiguration"
Case 1
    QueryInfo "Win32_DiskPartition"
Case 2
    QueryInfo "Win32_OperatingSystem"
'Case 5
'    QueryInfo "Win32_TimeZone"
End Select
lvwClasses.ItemSelected(0) = True
lvwItems.ItemSelected(0) = True
'lCurrentClassData = lvwClasses.ItemText(0)
'lCurrentClassIndex = 0
End Sub

Private Sub Form_GotFocus()
'''On Local Error Resume Next
lvwClasses.Enabled = True
lvwInfo.Enabled = True
lvwItems.Enabled = True
End Sub

Private Sub Form_Load()
'''On Local Error Resume Next
SetWindowToChild Me.hWnd
txtChannel.Text = ReadINI(App.Path & "\ass.ini", "Settings", "Channel", "")
lvwItems.Initialize
lvwItems.BorderStyle = bsThin
lvwItems.ViewMode = vmDetails
lvwItems.ColumnAdd 0, "Items", 447, [caLeft]
lvwItems.Font.Name = "Tahoma"
lvwItems.FullRowSelect = True
lvwItems.HeaderFlat = False
lvwItems.HeaderHide = False
lvwItems.Font = "Tahoma"
lvwClasses.Initialize
lvwClasses.BorderStyle = bsThin
lvwClasses.ViewMode = vmDetails
lvwClasses.ColumnAdd 0, "Class", 110, [caLeft]
lvwClasses.Font.Name = "Tahoma"
lvwClasses.FullRowSelect = True
lvwClasses.HeaderFlat = False
lvwClasses.HeaderHide = False
lvwClasses.Font = "Tahoma"
lvwClasses.InitializeImageListSmall
lvwClasses.ImageListSmall_AddBitmap imgHardDrive.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgMonitor.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgCD.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgFlop.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgDrive.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgSPK.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgKB.Picture, vbWhite
lvwClasses.ImageListSmall_AddBitmap imgNet.Picture, vbWhite
lvwInfo.Initialize
lvwInfo.BorderStyle = bsThin
lvwInfo.ViewMode = vmDetails
lvwInfo.ColumnAdd 0, "Name", 130, [caLeft]
lvwInfo.ColumnAdd 1, "Value", 197, [caLeft]
lvwInfo.Font.Name = "Tahoma"
lvwInfo.FullRowSelect = True
lvwInfo.HeaderFlat = False
lvwInfo.HeaderHide = False
lvwInfo.Font = "Tahoma"
cmdStat_Click 0
End Sub

Private Sub isButton1_Click()
frmStyle.Show 1
End Sub

Private Sub lvwClasses_ItemClick(Item As Integer)
'''On Local Error Resume Next
lCurrentClassIndex = Item
lCurrentClassData = lvwClasses.ItemText(Item)
Select Case LCase(Trim(lvwClasses.ItemText(Item)))
Case "processors"
    QueryInfo "Win32_Processor"
Case "audio devices"
    QueryInfo "Win32_SoundDevice"
Case "bios"
    QueryInfo "Win32_BIOS"
Case "boot"
    QueryInfo "Win32_BootConfiguration"
Case "disk partitions"
    QueryInfo "Win32_DiskPartition"
Case "cdrom drives"
    QueryInfo "Win32_CDROMDrive"
Case "disk drives"
    QueryInfo "Win32_DiskDrive"
Case "floppy controller"
    QueryInfo "Win32_FloppyController"
Case "ide controller"
    QueryInfo "Win32_IDEController"
Case "keyboard"
    QueryInfo "Win32_Keyboard"
Case "motherboard"
    QueryInfo "Win32_MotherBoardDevice"
Case "network adapters"
    QueryInfo "Win32_NetworkAdapter"
Case "plug-n-play device id"
    QueryInfo "Win32_PnPEntity"
Case "video devices"
    QueryInfo "Win32_VideoController"
Case "os"
    QueryInfo "Win32_OperatingSystem"
Case "time zone"
    QueryInfo "Win32_TimeZone"
Case "logical disks"
    QueryInfo "Win32_LogicalDisk"
Case "desktop monitor"
    QueryInfo "Win32_DesktopMonitor"
End Select
lvwItems.ItemSelected(0) = True
End Sub

Private Sub lvwItems_ItemClick(Item As Integer)
On Local Error GoTo ErrHandler
Dim i As Integer
lCurrentItemIndex = Item
lCurrentItemData = lvwItems.ItemText(Item)
'MsgBox "!" & lvwItems.ItemText(Item) & "!"
'MsgBox lCurrentItemData
Select Case Trim(LCase(lvwClasses.ItemText(lCurrentClassIndex)))
Case "disk drives"
    QueryInfo "Win32_DiskDrive", lvwItems.ItemText(Item)
Case "disk partitions"
    QueryInfo "Win32_DiskPartition", lvwItems.ItemText(Item)
Case "network adapters"
    QueryInfo "Win32_NetworkAdapter", Str(Item + 1)
Case "keyboard"
    QueryInfo "Win32_Keyboard", lvwItems.ItemText(Item)
Case "floppy controller"
    QueryInfo "Win32_FloppyController"
Case "cdrom drives"
    QueryInfo "Win32_CDROMDrive", lItemKey
Case "ide controller"
    QueryInfo "Win32_IDEController", lvwItems.ItemText(Item)
Case "plug-n-play device id"
    QueryInfo "Win32_PnPEntity", lvwItems.ItemText(Item)
Case "audio devices"
    QueryInfo "Win32_SoundDevice", lvwItems.ItemText(Item)
Case "video devices"
    QueryInfo "Win32_VideoDevices", lvwItems.ItemText(Item)
Case "time zone"
    QueryInfo "Win32_TimeZone", lvwItems.ItemText(Item)
Case "logical disks"
    QueryInfo "Win32_LogicalDisk", lvwItems.ItemText(Item)
End Select
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Function CBoolStr(bVal) As String
'''On Local Error Resume Next
If IsNull(bVal) = True Then
    Exit Function
End If
If bVal = True Then CBoolStr = "True" Else CBoolStr = "False"
End Function

Function FormatByteSize(ByVal bSize, Optional strAppend$ = "") As String
On Error GoTo errH
Dim tmpBuffer$
If IsNull(bSize) = True Then FormatByteSize = "<Undetermined Size>": Exit Function
If bSize = 0 Then FormatByteSize = "0 Bytes " & strAppend$: Exit Function
If bSize < 1024 Then FormatByteSize = FormatNumber(bSize, 0, , , vbTrue) & " Bytes " & strAppend$: Exit Function
If bSize >= 1024 Then bSize = bSize / 1024: tmpBuffer = " KB's " & strAppend$
If bSize >= 1024 Then bSize = bSize / 1024: tmpBuffer = " MB's " & strAppend$
If bSize >= 1024 Then bSize = bSize / 1024: tmpBuffer = " GB's " & strAppend$
If bSize >= 1024 Then bSize = bSize / 1024: tmpBuffer = " TB's " & strAppend$
FormatByteSize = CStr(FormatNumber(bSize, 0, , , vbTrue)) & tmpBuffer: tmpBuffer = ""
Exit Function
errH:
    FormatByteSize = IIf(IsNull(bSize), "", bSize & " bytes")
End Function

Function GroupDigits(ByVal bNum) As String
'''On Local Error Resume Next
If IsNull(bNum) = True Then GroupDigits = "<Undetermined>": Exit Function
GroupDigits = FormatNumber$(bNum, 0, , , vbTrue)
End Function
