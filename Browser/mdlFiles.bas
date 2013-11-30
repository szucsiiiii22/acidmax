Attribute VB_Name = "mdlFiles"
Option Explicit
Private Declare Function sndPlaySound Lib "winmm" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
Public Enum sndConst
    SND_ASYNC = &H1
    SND_LOOP = &H8
    SND_MEMORY = &H4
    SND_NODEFAULT = &H2
    SND_NOSTOP = &H10
    SND_SYNC = &H0
End Enum
Private Type gSettings
    sAcidmaxVersion As String
    sAcidmaxDir As String
    sShowDialog As Boolean
    sEnableSound As Boolean
    sUseThemeColor As Boolean
End Type
Private Declare Function GetFileVersionInfo Lib "Version.dll" Alias "GetFileVersionInfoA" (ByVal lptstrFilename As String, ByVal dwhandle As Long, ByVal dwlen As Long, lpData As Any) As Long
Private Declare Function GetFileVersionInfoSize Lib "Version.dll" Alias "GetFileVersionInfoSizeA" (ByVal lptstrFilename As String, lpdwHandle As Long) As Long
Private Declare Function VerQueryValue Lib "Version.dll" Alias "VerQueryValueA" (pBlock As Any, ByVal lpSubBlock As String, lplpBuffer As Any, puLen As Long) As Long
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal Path As String, ByVal cbBytes As Long) As Long
Private Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (dest As Any, ByVal Source As Long, ByVal Length As Long)
Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As Long) As Long
Public Type FILEPROPERTIE
    CompanyName As String
    FileDescription As String
    FileVersion As String
    InternalName As String
    LegalCopyright As String
    OrigionalFileName As String
    ProductName As String
    ProductVersion As String
End Type
Private lSettings As gSettings

Public Sub SetMircPath(lPath As String)
On Local Error Resume Next
lSettings.sAcidmaxDir = lPath
End Sub

Public Function ReturnSettingsUseThemeColor() As Boolean
On Local Error Resume Next
ReturnSettingsUseThemeColor = lSettings.sUseThemeColor
End Function

Public Function SaveFile(lFileName As String, lText As String) As Boolean
On Local Error Resume Next
If Len(lFileName) <> 0 And Len(lText) <> 0 Then
    Open lFileName For Output As #13
    Print #13, lText
    Close #13
End If
End Function

Public Sub PlayWav(strPath As String, sndVal As sndConst)
On Local Error Resume Next
If lSettings.sEnableSound = True Then
    sndPlaySound strPath, sndVal
End If
End Sub

Public Function GetFileTitle(lFileName As String) As String
On Local Error Resume Next
Dim msg() As String
If Len(lFileName) <> 0 Then
    msg = Split(lFileName, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

Public Function DoesDirectoryExist(lDirectory) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lDirectory)
If Len(msg) <> 0 Then DoesDirectoryExist = True
End Function

Public Function FileInfo(Optional ByVal PathWithFilename As String) As FILEPROPERTIE
On Local Error Resume Next
Dim lngDummy As Long, lngRc As Long, lngVerPointer As Long, lngHexNumber As Long, bytBuffer() As Byte, bytBuff(255) As Byte, strBuffer As String, strLangCharset As String, strVersionInfo(7) As String, strTemp As String, intTemp As Integer, lngBufferLen As Long
Static BACKUP As FILEPROPERTIE
If Len(PathWithFilename) = 0 Then
    FileInfo = BACKUP
    Exit Function
End If
lngBufferLen = GetFileVersionInfoSize(PathWithFilename, lngDummy)
If lngBufferLen > 0 Then
   ReDim bytBuffer(lngBufferLen)
   lngRc = GetFileVersionInfo(PathWithFilename, 0&, lngBufferLen, bytBuffer(0))
   If lngRc <> 0 Then
      lngRc = VerQueryValue(bytBuffer(0), "\VarFileInfo\Translation", _
               lngVerPointer, lngBufferLen)
      If lngRc <> 0 Then
         MoveMemory bytBuff(0), lngVerPointer, lngBufferLen
         lngHexNumber = bytBuff(2) + bytBuff(3) * &H100 + _
                bytBuff(0) * &H10000 + bytBuff(1) * &H1000000
         strLangCharset = Hex(lngHexNumber)
         Do While Len(strLangCharset) < 8
             strLangCharset = "0" & strLangCharset
         Loop
         strVersionInfo(0) = "CompanyName"
         strVersionInfo(1) = "FileDescription"
         strVersionInfo(2) = "FileVersion"
         strVersionInfo(3) = "InternalName"
         strVersionInfo(4) = "LegalCopyright"
         strVersionInfo(5) = "OriginalFileName"
         strVersionInfo(6) = "ProductName"
         strVersionInfo(7) = "ProductVersion"
         For intTemp = 0 To 7
            strBuffer = String$(255, 0)
            strTemp = "\StringFileInfo\" & strLangCharset _
               & "\" & strVersionInfo(intTemp)
            lngRc = VerQueryValue(bytBuffer(0), strTemp, _
                  lngVerPointer, lngBufferLen)
            If lngRc <> 0 Then
               lstrcpy strBuffer, lngVerPointer
               strBuffer = Mid$(strBuffer, 1, InStr(strBuffer, Chr(0)) - 1)
               strVersionInfo(intTemp) = strBuffer
             Else
               strVersionInfo(intTemp) = "?"
            End If
         Next intTemp
      End If
   End If
End If
FileInfo.CompanyName = strVersionInfo(0)
FileInfo.FileDescription = strVersionInfo(1)
FileInfo.FileVersion = strVersionInfo(2)
FileInfo.InternalName = strVersionInfo(3)
FileInfo.LegalCopyright = strVersionInfo(4)
FileInfo.OrigionalFileName = strVersionInfo(5)
FileInfo.ProductName = strVersionInfo(6)
FileInfo.ProductVersion = strVersionInfo(7)
BACKUP = FileInfo
End Function

Public Function DoesFileExist(lFileName As String) As Boolean
On Local Error GoTo ErrHandler
Dim msg As String
msg = Dir(lFileName)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnAcidmaxDir() As String
ReturnAcidmaxDir = lSettings.sAcidmaxDir
End Function
