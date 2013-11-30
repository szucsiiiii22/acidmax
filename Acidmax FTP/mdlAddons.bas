Attribute VB_Name = "mdlAddons"
Option Explicit
Private Type gAddon
    aActivate As Boolean
    aName As String
    aDescription As String
    aDirectory As String
    aStartupCommand As String
    aShutdownCommand As String
End Type
Private Type gAddons
    aAddon(32) As gAddon
    aCount As Integer
End Type
Private lAddons As gAddons

Public Function LoadAddons() As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
lAddons.aCount = ReadINI(App.Path & "\version.ini", "Addons", "Count", "")
If lAddons.aCount <> 0 Then
    For i = 0 To lAddons.aCount
        With lAddons.aAddon(i)
            If Int(ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Type", "")) = 2 Then
                .aName = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Name", "")
                If Len(.aName) <> 0 Then
                    AddAddonToListBox .aName
                    .aDescription = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Description", "")
                    .aDirectory = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Directory", "")
                    .aStartupCommand = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "StartupCommand", "")
                    .aShutdownCommand = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "ShutdownCommand", "")
                    .aActivate = CBool(ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Activate", False))
                End If
            End If
        End With
    Next i
End If
LoadAddons = True
Exit Function
ErrHandler:
    LoadAddons = False
    Err.Clear
End Function

Public Function ReturnAddonIndex(lName As String) As Integer
On Local Error Resume Next
Dim i As Integer
For i = 0 To lAddons.aCount
    If LCase(Trim(lName)) = LCase(Trim(lAddons.aAddon(i).aName)) Then
        ReturnAddonIndex = i
        Exit Function
    End If
Next i
End Function

Public Function ReturnAddonName(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnAddonName = lAddons.aAddon(lIndex).aName
Exit Function
ErrHandler:
    ReturnAddonName = ""
    Err.Clear
End Function

Public Function ReturnAddonDescription(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnAddonDescription = lAddons.aAddon(lIndex).aDescription
Exit Function
ErrHandler:
    ReturnAddonDescription = ""
    Err.Clear
End Function

Public Function ReturnAddonDirectory(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnAddonDirectory = lAddons.aAddon(lIndex).aDirectory
Exit Function
ErrHandler:
    ReturnAddonDirectory = ""
    Err.Clear
End Function
