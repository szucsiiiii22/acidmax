; cpanel
; guidex@tnexgen.com

alias frmCP.Init {
  .comopen lCP cpanel.clsCPanel
  if ($comerr) {
    .comreg cpanel\cpanel.dll
    .comopen lCP cpanel.clsCPanel
    if ($comerr) halt
  }
}

alias frmCP.Load {
  window -K @controlpanel acidmax.ico
  frmCP.Init
  var %k = $com(lCP,Startcpanel,3,bstr,$window(@controlpanel).hwnd)
}

alias frmCP.Reload {
  var %k = $com(lCP,Startcpanel,3,bstr,$window(@controlpanel).hwnd)
}

alias frmCP.Unload {
  .comclose lCP
}
