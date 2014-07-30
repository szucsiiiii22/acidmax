;DU Pre Update
;guidex@tnexgen.com
;********************************************
;********************************************
;on 1:START:frmDUPreUpdate.Load
;on 1:EXIT:.comclose lDUPreUpdate

menu query,channel,status,menubar {
  • utilities
  .direct update
  ..check for updates to direct update: CLICK | frmDUPreUpdate.Load
}

alias frmDUPreUpdate.Init {
  .comopen lDUPreUpdate DUPreUpdate.clsDUPreUpdate15
  if ($comerr) {
    .comreg DUPREUPDATE\DUPREUPDATE15.DLL
    .comopen lDUPreUpdate DUPreUpdate.clsDUPreUpdate15
    if ($comerr) halt
  }
}

alias frmDUPreUpdate.Load {
  frmDUPreUpdate.Init
  var %k = $com(lDUPreUpdate,DoStartup,3,bstr,$file(mirc.exe).longfn)
}

alias frmDUPreUpdate.Unload {
  .comclose lDUPreUpdate
}
