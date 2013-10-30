;Direct Update
;guidex@tnexgen.com

;on 1:START://echo Type /DU to check for Updates
;on 1:EXIT:.comclose lDU
;on 1:START:frmDU.Init
on 1:CLOSE:@DU:.comclose lDU

menu query,channel,status,menubar {
  .direct update
  ..show direct update: Click | frmDU.Load
  ..close direct update: Click | frmDU.Unload
}

alias frmDU.Init {
  .comopen lDU DU.clsDU296
  if ($comerr) {
    .comreg DU\DU296.dll
    .comopen lDU DU.clsDU296
    if ($comerr) halt
  }
}

alias frmDU.Return {

}

alias frmDU.Load {
  window -rik +te @DU 40 20 740 482 DU\DU.ico
  frmDU.Init
  var %k = $com(lDU,DoStartup,3,bstr,2 : $window(@DU).hwnd : $file(mirc.exe).longfn : 1. : 0)
}

alias DU {
  frmDU.Load
}

alias frmDU.Unload {
  .comclose lDU
  window -c @DU
}

alias frmDU.BetaLoad {
  window -rik +te @DU 40 20 740 482 DU\DU.ico
  frmDU.Init
  var %k = $com(lDU,DoBetaStartup,3,bstr,2 : $window(@DU).hwnd : $file(mirc.exe).longfn : 1. : 0)
}

alias DUBETA {
  frmDU.BetaLoad {
}

alias frmDU.Admin {
  var %k = $com(lDU,ShowAdmin,3,bstr,1)
}
