Attribute VB_Name = "mdlMain"
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
Private Const lKey = "W34NSD84D"

Function SaveDialog(Form1 As Form, Filter As String, Title As String, InitDir As String) As String
On Local Error Resume Next
Dim o As OPENFILENAME, l As Long
o.lStructSize = Len(o)
o.hwndOwner = Form1.hWnd
o.hInstance = App.hInstance
If Right$(Filter, 1) <> "|" Then Filter = Filter + "|"
For l = 1 To Len(Filter)
    If Mid$(Filter, l, 1) = "|" Then Mid$(Filter, l, 1) = Chr$(0)
Next
o.lpstrFilter = Filter
o.lpstrFile = Space$(254)
o.nMaxFile = 255
o.lpstrFileTitle = Space$(254)
o.nMaxFileTitle = 255
o.lpstrInitialDir = InitDir
o.lpstrTitle = Title
o.flags = o_HIDEREADONLY Or o_OVERWRITEPROMPT Or o_CREATEPROMPT
l = GetSaveFileName(o)
If (l) Then
    SaveDialog = Trim$(o.lpstrFile)
Else
    SaveDialog = ""
End If
End Function

Function OpenDialog(Form1 As Form, Filter As String, Title As String, InitDir As String) As String
On Local Error Resume Next
Dim o As OPENFILENAME, l As Long
o.lStructSize = Len(o)
o.hwndOwner = Form1.hWnd
o.hInstance = App.hInstance
If Right$(Filter, 1) <> "|" Then Filter = Filter + "|"
For l = 1 To Len(Filter)
    If Mid$(Filter, l, 1) = "|" Then Mid$(Filter, l, 1) = Chr$(0)
Next
o.lpstrFilter = Filter
o.lpstrFile = Space$(254)
o.nMaxFile = 255
o.lpstrFileTitle = Space$(254)
o.nMaxFileTitle = 255
o.lpstrInitialDir = InitDir
o.lpstrTitle = Title
o.flags = o_HIDEREADONLY Or o_FILEMUSTEXIST
l = GetOpenFileName(o)
If (l) Then
    Dim msg As String
    msg = Trim$(o.lpstrFile)
    OpenDialog = left(msg, Len(msg) - 1)
Else
    OpenDialog = ""
End If
End Function

Public Function TestKeyValid(lUserName As String, lPassword As String) As Boolean
On Local Error Resume Next
Dim msg As String
msg = KeyGen(lUserName, lKey, 1)
If msg = lKey Then
    TestKeyValid = True
End If
End Function

Function KeyGen(kName As String, kPass As String, kType As Integer) As String
On Local Error Resume Next
Dim a(512) As Integer, b(16) As Integer, c(512) As Integer, d(16) As Integer, e(16) As Integer, f As Integer, g As Integer, h As Integer, i As Boolean, j As Integer, k As Integer, l As Integer, msg As String, m As Integer, n As Integer, o As Integer, P As Integer, q As Integer, r As Integer, s As Integer
Const nXor As Integer = 18
Const pXor As Integer = 25
Const cLw As Integer = 65
Const nLw As Integer = 48
Const sOffset As Integer = 0
m = Len(kName)
n = Len(kPass)
b(1) = 52
b(2) = 69
b(3) = 149
b(4) = 37
b(5) = 403
b(6) = 20
b(7) = 58
b(8) = 29
b(9) = 123
b(10) = 84
b(11) = 201
b(12) = 202
b(13) = 34
b(14) = 38
b(15) = 73
b(16) = 30
j = 0
For f = 0 To 512
    c(f) = f
Next f
For f = 0 To 512
    j = (sOffset + j + f) Mod 256
    k = c(f)
    c(f) = c(j)
    c(j) = k
Next f
If kType = 1 Then
    g = 0
    For f = 0 To 512
        a(c(f)) = (nLw + (g))
        g = g + 1
        If g = 10 Then g = 0
    Next f
    msg = String(16, " ")
ElseIf kType = 2 Then
    g = 0
    h = 0
    i = False
    For f = 0 To 512
        If i Then
            a(c(f)) = (nLw + g)
            g = g + 1
            If g = 10 Then g = 0
            i = False
        Else
            a(c(f)) = (cLw + h)
            h = h + 1
            If h = 26 Then h = 0
            i = True
        End If
    Next f
    msg = String(16, " ")
Else
    msg = String(19, " ")
End If
o = 1
For f = 1 To m
    d(o) = d(o) + Asc(Mid(kName, f, 1)) Xor nXor
    q = q + d(o)
    o = o + 1
    If o = 9 Then o = 1
Next f
For f = 1 To n
    e(o) = e(o) + Asc(Mid(kPass, f, 1)) Xor pXor
    r = r + e(o)
    o = o + 1
    If o = 9 Then o = 1
Next f
s = (q + r) Mod 512
o = 1
P = 1
For f = 1 To 16
    e(f) = e(f) Xor b(f)
    l = Abs(((d(f) Xor e(f)) Mod 512) - s)
    If kType = 3 Then
        If l < 16 Then
            Mid(msg, o, 2) = "0" & Hex(l)
        Else
            Mid(msg, o, 2) = Hex(l)
        End If
        If P = 2 And o < 18 Then
            o = o + 1
            Mid(msg, o + 1, 1) = "-"
        End If
        o = o + 2
        P = P + 1
        If P = 3 Then P = 1
    Else
        Mid(msg, f, 1) = Chr(a(l))
    End If
Next f
KeyGen = msg
End Function

Sub Main()

End Sub
