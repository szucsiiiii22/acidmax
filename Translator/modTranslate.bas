Attribute VB_Name = "modTranslate"
'Option Explicit

Global DefLang As String

'URL de traduction
Const WebURL As String = "http://translate.google.com/translate_t"

'Chaine situé juste avant le début de la traduction
Const SearchString As String = "PHYSICAL>"

'Chaine situé à la fin de la traduction
Const EndString As String = "</"

Global glbTraduction As String '/ pour la valeur de retour de la touche F2


Public Function Traduction(InputText As String, LangueTrad As String) As String
'But        = Traduire un texte en une autre langue
'
'InputText  = Texte à traduire
'
'LangueTrad = Traduire dans la langue..
'
'Par        = Robert Simard (logipro2000@homtmail.com http://www.logicielappui.com/tips)
'
'Crée le    = 20 septembre 2004

Dim TMPString As String
Dim StartPos  As Long
Dim DebString As String

If IsConnected = False Then
   MsgBox "Vous devez être connecté à Internet pour traduire un texte !", vbInformation, "Traduction"
   Traduction = ""
   Exit Function
End If

'InputText
TMPString = GetHTMLFromURL(WebURL & "?langpair=" & LangueTrad & "&text=" & InputText)

StartPos = InStr(1, TMPString, SearchString, vbTextCompare)
If StartPos = 0 Then
   Traduction = ""
   Exit Function
End If

DebString = Right(TMPString, Len(TMPString) - (StartPos + Len(SearchString) - 1))

StartPos = InStr(1, DebString, EndString, vbTextCompare)

Traduction = Left(DebString, StartPos - 1)

End Function





