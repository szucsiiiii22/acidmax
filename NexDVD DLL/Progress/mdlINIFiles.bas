Attribute VB_Name = "mdlINIFiles"
Option Explicit
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function WritePrivateProfileString& Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal AppName$, ByVal KeyName$, ByVal keydefault$, ByVal FileName$)
#If Win32 Then
    Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
#Else
    Public Declare Function ShellExecute Lib "shell.dll" (ByVal hwnd As Integer, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Integer) As Integer
#End If
Public Const SW_SHOWNORMAL = 1

Public Function ReadINI(ByVal lFile As String, ByVal Section As String, ByVal Key As String, lDefault As String)
On Local Error Resume Next
Dim msg As String, RetVal As String, Worked As Integer
RetVal = String$(255, 0)
Worked = GetPrivateProfileString(Section, Key, "", RetVal, Len(RetVal), lFile)
If Worked = 0 Then
    ReadINI = lDefault
Else
    ReadINI = Left(RetVal, InStr(RetVal, Chr(0)) - 1)
End If
If Err.Number <> 0 Then SetError "ReadINI", Err.Description
End Function

Public Sub WriteINI(ByVal lFile As String, ByVal Section As String, ByVal Key As String, ByVal Value As String)
On Local Error Resume Next
WritePrivateProfileString Section, Key, Value, lFile
If Err.Number <> 0 Then SetError "WriteINI", Err.Description
End Sub
