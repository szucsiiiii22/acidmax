Attribute VB_Name = "mdlINIFiles"
Option Explicit
Private Declare Function GetPrivateProfileString Lib "Kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function WritePrivateProfileString& Lib "Kernel32" Alias "WritePrivateProfileStringA" (ByVal AppName$, ByVal KeyName$, ByVal keydefault$, ByVal FileName$)

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
