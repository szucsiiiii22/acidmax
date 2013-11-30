VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAcidmaxDirector"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private lStarted As Boolean

Public Function DoStartup(lData As String)
On Local Error Resume Next
Dim i As Integer, msg() As String
If lStarted = False Then
    msg = Split(lData, " : ")
    For i = 0 To UBound(msg)
        msg(i) = Trim(msg(i))
        Select Case i
        Case 0
            SetChildHWND CLng(msg(i))
        Case 1
            SetmIRCPath Replace(Trim(lData), "mirc.exe", "")
        End Select
    Next i
    ShowMainForm
    lStarted = True
End If
End Function

Public Function ReturnPhysicalMemory(lData As String)
On Local Error Resume Next
Dim rMEM() As Long
rMEM = frmMain.GetMEMORY
ReturnPhysicalMemory = rMEM(0)
End Function

Public Function ReturnVirtualMemory(lData As String)
On Local Error Resume Next
Dim rMEM() As Long
rMEM = frmMain.GetMEMORY
ReturnVirtualMemory = rMEM(1)
End Function

Public Function ReturnCPU(lCPU As String)
On Local Error Resume Next
ReturnCPU = frmMain.ReturnCPUPercent(CLng(lCPU))
End Function

'Public Function PublicCPU(lData As String)
'On Local Error Resume Next
'Dim rMEM() As Long
'rMEM = GetMEMORY
'mIRCSend "//echo Physical: " & rMEM(0) & " Virtual: " & rMEM(1) & " CPU1: " & ReturnCPUPercent(1)
'DrawProgressBar Me, 54, 2, 154, 15, 0, vbDGr, vbLGr, rMEM(0)
'DrawProgressBar Me, 201, 2, 301, 15, 0, vbDGr, vbLGr, rMEM(1)
'DrawProgressBar Me, 342, 2, 442, 15, 0, vbDGr, vbLGr, ReturnCPUPercent(1)
'End Function


Private Sub Class_Initialize()
On Local Error Resume Next

End Sub

Private Sub Class_Terminate()
On Local Error GoTo ErrHandler
Unload frmMain
Exit Sub
ErrHandler:
    MsgBox "Terminate: " & Err.Description
    Err.Clear
End Sub
