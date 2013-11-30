Attribute VB_Name = "mdlReadINI"
Option Explicit
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
#If Win32 Then
    Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
#Else
    Private Declare Function ShellExecute Lib "shell.dll" (ByVal hWnd As Integer, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Integer) As Integer
#End If

Public Function ReadINI(ByVal lFile As String, ByVal Section As String, ByVal Key As String, Optional lDefault As String)
On Local Error Resume Next
Dim msg As String, RetVal As String, Worked As Integer
RetVal = String$(255, 0)
Worked = GetPrivateProfileString(Section, Key, "", RetVal, Len(RetVal), lFile)
If Worked = 0 Then
    ReadINI = lDefault
Else
    ReadINI = Left(RetVal, InStr(RetVal, Chr(0)) - 1)
End If
End Function

Public Sub WriteINI(ByVal lFile As String, ByVal Section As String, ByVal Key As String, ByVal Value As String)
On Local Error Resume Next
WritePrivateProfileString Section, Key, Value, lFile
End Sub
