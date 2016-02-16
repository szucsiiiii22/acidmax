VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Test"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Private Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long

Public Function Run() As String

End Function

Private Sub Class_Terminate()
DestroyMainForm
CoFreeUnusedLibraries
End Sub

Public Function Initialize(hWnd As String)
SetParentHwnd CLng(Trim(hWnd))
InitMainForm
End Function

Public Function HelloWorld() As String
HelloWorld = "Hello World!!!"
End Function
