Attribute VB_Name = "mdlMouseHook"
Public Const WH_MOUSE = 7
Public hHook As Long
Declare Function SetWindowsHookEx Lib "user32" Alias "SetWindowsHookExA" (ByVal idHook As Long, ByVal lpfn As Long, ByVal hmod As Long, ByVal dwThreadId As Long) As Long
Declare Function UnhookWindowsHookEx Lib "user32" (ByVal hHook As Long) As Long

Public Function MouseProc(ByVal idHook As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
On Local Error Resume Next
If wParam = 515 Then
'If wParam = 514 Then (single click)
    If lSettings.sSingleClickToExitFullScreen = True And lPlayer.pFullscreen = True Then FullScreen False
End If
If wParam = 517 Then 'RIGHT MOUSE UP
    frmMain.PopupMenu frmMain.mnuControls
End If
If Err.Number <> 0 Then SetError "MouseProc", Err.Description
End Function

Public Sub UnloadProg()
On Local Error Resume Next
SetForm False, frmMain
frmMain.Visible = False
'If lSettings.sUseDVDInterface = True Then frmInterface.Visible = False
If lPlayer.pStatus = sPlaying Then PlayerState eStopped
HookStatus False
'frmMain.ctlDVD.SubpictureOn
If lSettings.sShowIconInSystray = True Then Call Shell_NotifyIcon(NIM_DELETE, try)
If Err.Number <> 0 Then SetError "UnloadProg", Err.Description
End
End Sub

Public Sub HookStatus(lValue As Boolean)
On Local Error Resume Next
If lValue = True Then
    hHook = SetWindowsHookEx(WH_MOUSE, AddressOf MouseProc, App.hInstance, App.ThreadID)
Else
    UnhookWindowsHookEx hHook
End If
If Err.Number <> 0 Then SetError "HookStatus", Err.Description
End Sub
