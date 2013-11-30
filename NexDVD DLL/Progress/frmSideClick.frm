VERSION 5.00
Begin VB.Form frmSideClick 
   BorderStyle     =   0  'None
   ClientHeight    =   810
   ClientLeft      =   0
   ClientTop       =   405
   ClientWidth     =   150
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   Picture         =   "frmSideClick.frx":0000
   ScaleHeight     =   810
   ScaleWidth      =   150
   ShowInTaskbar   =   0   'False
End
Attribute VB_Name = "frmSideClick"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Dim t As Single
Dim rtn As Long
t = Timer
If Me.Picture <> 0 Then
    Call SetAutoRgn(Me)
End If
SetParentAcidmax Me
End Sub
