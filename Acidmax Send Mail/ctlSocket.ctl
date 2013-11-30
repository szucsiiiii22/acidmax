VERSION 5.00
Begin VB.UserControl ctlSocket 
   ClientHeight    =   375
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   375
   ScaleHeight     =   375
   ScaleWidth      =   375
End
Attribute VB_Name = "ctlSocket"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Public Event CloseSck()
Public Event Connect()
Public Event ConnectionRequest(ByVal requestID As Long)
Public Event DataArrival(ByVal bytesTotal As Long)
Public Event Error(ByVal Number As Integer, Description As String, ByVal sCode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
Public Event SendComplete()
Public Event SendProgress(ByVal bytesSent As Long, ByVal bytesRemaining As Long)
Private WithEvents cmSocket As clsSocket
Attribute cmSocket.VB_VarHelpID = -1

Private Sub UserControl_Initialize()
On Local Error Resume Next
Set cmSocket = New clsSocket
End Sub

Private Sub UserControl_Terminate()
On Local Error Resume Next
Set cmSocket = Nothing
End Sub

Private Sub UserControl_Resize()
On Local Error Resume Next
UserControl.Width = 420
UserControl.Height = 420
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
On Local Error Resume Next
Me.LocalPort = PropBag.ReadProperty("LocalPort", 0)
Me.Protocol = PropBag.ReadProperty("Protocol", 0)
Me.RemoteHost = PropBag.ReadProperty("RemoteHost", "")
Me.RemotePort = PropBag.ReadProperty("RemotePort", 0)
Me.Tag = PropBag.ReadProperty("Tag", "")
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
On Local Error Resume Next
PropBag.WriteProperty "LocalPort", Me.LocalPort, 0
PropBag.WriteProperty "Protocol", Me.Protocol, 0
PropBag.WriteProperty "RemoteHost", Me.RemoteHost, ""
PropBag.WriteProperty "RemotePort", Me.RemotePort, 0
PropBag.WriteProperty "Tag", Me.Tag, ""
End Sub

Private Sub cmSocket_CloseSck()
On Local Error Resume Next
RaiseEvent CloseSck
End Sub

Private Sub cmSocket_Connect()
On Local Error Resume Next
RaiseEvent Connect
End Sub

Private Sub cmSocket_ConnectionRequest(ByVal requestID As Long)
On Local Error Resume Next
RaiseEvent ConnectionRequest(requestID)
End Sub

Private Sub cmSocket_DataArrival(ByVal bytesTotal As Long)
On Local Error Resume Next
RaiseEvent DataArrival(bytesTotal)
End Sub

Private Sub cmSocket_Error(ByVal Number As Integer, Description As String, ByVal sCode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
On Local Error Resume Next
RaiseEvent Error(Number, Description, sCode, Source, HelpFile, HelpContext, CancelDisplay)
End Sub

Private Sub cmSocket_SendComplete()
On Local Error Resume Next
RaiseEvent SendComplete
End Sub

Private Sub cmSocket_SendProgress(ByVal bytesSent As Long, ByVal bytesRemaining As Long)
On Local Error Resume Next
RaiseEvent SendProgress(bytesSent, bytesRemaining)
End Sub

Public Property Get RemotePort() As Long
On Local Error Resume Next
RemotePort = cmSocket.RemotePort
End Property

Public Property Let RemotePort(ByVal lngPort As Long)
On Local Error Resume Next
cmSocket.RemotePort = lngPort
End Property

Public Property Get RemoteHost() As String
On Local Error Resume Next
RemoteHost = cmSocket.RemoteHost
End Property

Public Property Let RemoteHost(ByVal strHost As String)
On Local Error Resume Next
cmSocket.RemoteHost = strHost
End Property

Public Property Get RemoteHostIP() As String
On Local Error Resume Next
RemoteHostIP = cmSocket.RemoteHostIP
End Property

Public Property Get LocalPort() As Long
On Local Error Resume Next
LocalPort = cmSocket.LocalPort
End Property

Public Property Let LocalPort(ByVal lngPort As Long)
On Local Error Resume Next
cmSocket.LocalPort = lngPort
End Property

Public Property Get State() As SockState
On Local Error Resume Next
State = cmSocket.State
End Property

Public Property Get LocalHostName() As String
On Local Error Resume Next
LocalHostName = cmSocket.LocalHostName
End Property

Public Property Get LocalIP() As String
On Local Error Resume Next
LocalIP = cmSocket.LocalIP
End Property

Public Property Get BytesReceived() As Long
On Local Error Resume Next
BytesReceived = cmSocket.BytesReceived
End Property

Public Property Get SocketHandle() As Long
On Local Error Resume Next
SocketHandle = cmSocket.SocketHandle
End Property

Public Property Get Tag() As String
On Local Error Resume Next
Tag = cmSocket.Tag
End Property

Public Property Let Tag(ByVal strTag As String)
On Local Error Resume Next
cmSocket.Tag = strTag
End Property

Public Property Get Protocol() As ProtocolConstants
On Local Error Resume Next
Protocol = cmSocket.Protocol
End Property

Public Property Let Protocol(ByVal enmProtocol As ProtocolConstants)
On Local Error Resume Next
cmSocket.Protocol = enmProtocol
End Property

Public Sub Accept(requestID As Long)
On Local Error Resume Next
cmSocket.Accept requestID
End Sub

Public Sub Bind(Optional LocalPort As Variant, Optional LocalIP As Variant)
On Local Error Resume Next
cmSocket.Bind LocalPort, LocalIP
End Sub

Public Sub CloseSck()
On Local Error Resume Next
cmSocket.CloseSck
End Sub

Public Sub Connect(Optional RemoteHost As Variant, Optional RemotePort As Variant)
On Local Error Resume Next
cmSocket.Connect RemoteHost, RemotePort
End Sub

Public Sub GetData(ByRef data As Variant, Optional varType As Variant, Optional maxLen As Variant)
On Local Error Resume Next
cmSocket.GetData data, varType, maxLen
End Sub

Public Sub Listen()
On Local Error Resume Next
cmSocket.Listen
End Sub

Public Sub PeekData(ByRef data As Variant, Optional varType As Variant, Optional maxLen As Variant)
On Local Error Resume Next
cmSocket.PeekData data, varType, maxLen
End Sub

Public Sub SendData(data As Variant)
On Local Error Resume Next
cmSocket.SendData data
End Sub
