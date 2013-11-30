;DU Pre Update
;guidex@tnexgen.com

;on 1:START:frmDUPreUpdate.Load
;on 1:EXIT:.comclose lDUPreUpdate

menu query,channel,status,menubar {
  .direct update
  ..check for new versions: frmDUPreUpdate.Load
}

alias frmDUPreUpdate.Init {
  .comopen lDUPreUpdate DUPreUpdate.clsDUPreUpdate
  if ($comerr) {
    .comreg DUPREUPDATE\DUPREUPDATE.DLL
    .comopen lDUPreUpdate DUPreUpdate.clsDUPreUpdate
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
