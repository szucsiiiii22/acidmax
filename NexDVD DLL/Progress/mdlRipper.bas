Attribute VB_Name = "mdlRipper"
Option Explicit

Public Function AddRip(lInputFilePath As String, lOutputFilePath As String, lOutputFileName As String) As Boolean
On Local Error Resume Next
If Len(lInputFilePath) <> 0 And Len(lOutputFileName) <> 0 And Len(lOutputFilePath) <> 0 Then
    lWizardFiles.wCount = lWizardFiles.wCount + 1
    With lWizardFiles.wFile(lWizardFiles.wCount)
        .wDestinationPath = lOutputFilePath
        .wEnabled = False
        .wFile = lOutputFileName
        .wPath = lInputFilePath
    End With
    lWizardFiles.wPath = lInputFilePath
    AddRip = True
Else
    SetError "AddRip", "Unable to add rip event due to incomplete parameters"
    AddRip = False
End If
If Err.Number <> 0 Then SetError "AddRip", Err.Description
End Function

Public Function FindFileIndex(lFile As String)
On Local Error Resume Next
Dim i As Integer
For i = 1 To lWizardFiles.wCount
    If lWizardFiles.wFile(i).wFile = lFile Then
        FindFileIndex = i
        Exit Function
    End If
Next i
If Err.Number <> 0 Then SetError "FindFileIndex()", Err.Description
End Function

Public Sub ProcessNextRip()
On Local Error Resume Next
Dim i As Integer, msg As Boolean
If lWizardFiles.wBusy = False Then
    For i = 1 To lWizardFiles.wCount
        With lWizardFiles.wFile(i)
            If .wEnabled = True Then
                If CheckFileConstants(.wDestinationPath, .wFile) = True Then
                    frmRipper.tmrProcessDVDRip.Enabled = False
                    msg = True
                    .wEnabled = False
                    frmRipper.ctlRipper.Strip .wPath & .wFile, .wDestinationPath & .wFile
                    frmRipper.lblFilename.Caption = .wFile
                    lWizardFiles.wBusy = True
                    frmRipper.cmdNext.Enabled = False
                    Exit For
                End If
            End If
        End With
    Next i
    If msg = False Then
        frmRipper.cmdBack.Enabled = True
        frmRipper.ShowWizFinish
    End If
Else
    frmRipper.tmrProcessDVDRip.Enabled = False
End If
If Err.Number <> 0 Then SetError "ProcessNextRip", Err.Description
End Sub
