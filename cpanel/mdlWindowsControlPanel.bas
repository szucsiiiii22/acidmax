Attribute VB_Name = "mdlWindowsControlPanel"
Option Explicit
Enum eWinCPanelItem
    wAddRemovePrograms = 1
    wDateAndTime = 2
    wDialingProperties = 3
    wDisplaySettings = 4
    wJoystick = 5
    wInternetExplorerProperties = 6
    wModem = 7
    wMultimediaProperties = 8
    wNetworkProperties = 9
    wODBCDataSourceAdministrator = 10
    wPassword = 11
    wPowercfg = 12
    wRegionalSettingsProperties = 13
    wSystemProperties = 14
End Enum

Public Sub LoadWinCPanelItem(lWinCPanelItem As eWinCPanelItem)
Dim d As Double, msg As String
Select Case lWinCPanelItem
Case 1
    msg = "Appwiz.cpl"
Case 2
    msg = "Timedate.cpl"
Case 3
    msg = "Telephon.cpl"
Case 4
    msg = "Desk.cpl"
Case 5
    msg = "Joy.cpl"
Case 6
    msg = "Inetcpl.cpl"
Case 7
    msg = "Modem.cpl"
Case 8
    msg = "MMSys.cpl"
Case 9
    msg = "Netcpl.cpl"
Case 10
    msg = "ODBCcp32.cpl"
Case 11
    msg = "Password.cpl"
Case 12
    msg = "Powercfg.cpl"
Case 13
    msg = "Intl.cpl"
Case 14
    msg = "Sysdm.cpl"
End Select
d = Shell("Control " & lWinCPanelItem, vbNormalFocus)
End Sub
