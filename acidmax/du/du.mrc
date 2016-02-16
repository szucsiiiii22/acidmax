; direct update
; guide_X@live.com

; ************************
; ************************
; on 1:START://echo Type /DU to check for Updates
; on 1:EXIT:.comclose lDU
; on 1:START:frmDU.Init

on 1:CLOSE:@du:.comclose lDU

menu query,channel,status,menubar {
  • utilities
  .direct update
  ..show direct update: Click | frmDU.Load
  ..close direct update: Click | frmDU.Unload
}

alias frmDU.Init {
  .comopen lDU du.clsDU299
  if ($comerr) {
    .comreg du\du299.dll
    .comopen lDU du.clsDU299
    if ($comerr) halt
  }
}

alias frmDU.Load {
  ;window -K @du acidmax.ico
  window -rik +te @du 40 20 748 485 acidmax.ico
  frmDU.Init
  var %k = $com(lDU,Init,3,bstr,$window(@du).hwnd)
}

alias frmDU.Reload {
  var %k = $com(lDU,DU,3,bstr,$window(@du).hwnd)
}

alias frmDU.Unload {
  .comclose lDU
}