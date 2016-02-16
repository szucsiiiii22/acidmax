; cpanel v1.0
; guide_X@live.com

alias frmCP.Load {
  if ($window(@cp)) {
	window -c @cp
	.comclose controlPanel
  }
  window -K @cp acidmax.ico
  .comopen controlPanel cpanel.clsCPanel
  if ($comerr) {
    .comreg cpanel\cp10.dll
    .comopen controlPanel cpanel.clsCPanel
    if ($comerr) halt
  }
  var %k = $com(controlPanel,Startcpanel,3,bstr,$window(@cp).hwnd)
}

alias frmCP.Unload {
  window -c @cp
}

on *:CLOSE:@cp: .comclose controlPanel