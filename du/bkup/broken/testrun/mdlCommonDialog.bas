Attribute VB_Name = "mdlCommonDialog"
Option Explicit
Private Type OPENFILENAME
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    lpstrFilter As String
    lpstrCustomFilter As String
    nMaxCustFilter As Long
    nFilterIndex As Long
    lpstrFile As String
    nMaxFile As Long
    lpstrFileTitle As String
    nMaxFileTitle As Long
    lpstrInitialDir As String
    lpstrTitle As String
    flags As Long
    nFileOffset As Integer
    nFileExtension As Integer
    lpstrDefExt As String
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type
Private Const OFN_READONLY = &H1
Private Const OFN_OVERWRITEPROMPT = &H2
Private Const OFN_HIDEREADONLY = &H4
Private Const OFN_NOCHANGEDIR = &H8
Private Const OFN_SHOWHELP = &H10
Private Const OFN_ENABLEHOOK = &H20
Private Const OFN_ENABLETEMPLATE = &H40
Private Const OFN_ENABLETEMPLATEHANDLE = &H80
Private Const OFN_NOVALIDATE = &H100
Private Const OFN_ALLOWMULTISELECT = &H200
Private Const OFN_EXTENSIONDIFFERENT = &H400
Private Const OFN_PATHMUSTEXIST = &H800
Private Const OFN_FILEMUSTEXIST = &H1000
Private Const OFN_CREATEPROMPT = &H2000
Private Const OFN_SHAREAWARE = &H4000
Private Const OFN_NOREADONLYRETURN = &H8000
Private Const OFN_NOTESTFILECREATE = &H10000
Private Const OFN_NONETWORKBUTTON = &H20000
Private Const OFN_NOLONGNAMES = &H40000
Private Const OFN_EXPLORER = &H80000
Private Const OFN_NODEREFERENCELINKS = &H100000
Private Const OFN_LONGNAMES = &H200000
Private Const OFN_SHAREFALLTHROUGH = 2
Private Const OFN_SHARENOWARN = 1
Private Const OFN_SHAREWARN = 0
Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long

Function SaveDialog(Form1 As Form, Filter As String, Title As String, InitDir As String) As String
On Local Error GoTo ErrHandler
Dim ofn As OPENFILENAME, a As Long
ofn.lStructSize = Len(ofn)
ofn.hwndOwner = Form1.hwnd
ofn.hInstance = App.hInstance
If Right$(Filter, 1) <> "|" Then Filter = Filter + "|"
For a = 1 To Len(Filter)
    If Mid$(Filter, a, 1) = "|" Then Mid$(Filter, a, 1) = Chr$(0)
Next
ofn.lpstrFilter = Filter
ofn.lpstrFile = Space$(254)
ofn.nMaxFile = 255
ofn.lpstrFileTitle = Space$(254)
ofn.nMaxFileTitle = 255
ofn.lpstrInitialDir = InitDir
ofn.lpstrTitle = Title
ofn.flags = OFN_HIDEREADONLY Or OFN_OVERWRITEPROMPT Or OFN_CREATEPROMPT
a = GetSaveFileName(ofn)
If (a) Then
    SaveDialog = Trim$(ofn.lpstrFile)
Else
    SaveDialog = ""
End If
Exit Function
ErrHandler:
    ProcessError "Function SaveDialog(Form1 As Form, Filter As String, Title As String, InitDir As String) As String", Err.Description
    Err.Clear
End Function

Function OpenDialog(Form1 As Form, Filter As String, Title As String, InitDir As String) As String
On Local Error GoTo ErrHandler
Dim ofn As OPENFILENAME, a As Long
ofn.lStructSize = Len(ofn)
ofn.hwndOwner = Form1.hwnd
ofn.hInstance = App.hInstance
If Right$(Filter, 1) <> "|" Then Filter = Filter + "|"
For a = 1 To Len(Filter)
    If Mid$(Filter, a, 1) = "|" Then Mid$(Filter, a, 1) = Chr$(0)
Next
ofn.lpstrFilter = Filter
ofn.lpstrFile = Space$(254)
ofn.nMaxFile = 255
ofn.lpstrFileTitle = Space$(254)
ofn.nMaxFileTitle = 255
ofn.lpstrInitialDir = InitDir
ofn.lpstrTitle = Title
ofn.flags = OFN_HIDEREADONLY Or OFN_FILEMUSTEXIST
a = GetOpenFileName(ofn)
If (a) Then
    Dim msg As String
    msg = Trim$(ofn.lpstrFile)
    OpenDialog = Left(msg, Len(msg) - 1)
Else
    OpenDialog = ""
End If
Exit Function
ErrHandler:
    ProcessError "Function OpenDialog(Form1 As Form, Filter As String, Title As String, InitDir As String) As String", Err.Description
    Err.Clear
End Function
