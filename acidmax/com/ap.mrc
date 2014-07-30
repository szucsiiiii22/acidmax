; acidmax player
; guidex@tnexgen.com

menu query,channel,status,menubar {
  • media
  .acidmax player: Click | frmAP.Load
}

alias frmAP.Init {
  comopen lAP AcidmaxPlayer.clsAP13
  if ($comerr) {
    comreg com\ap13.dll
    comopen lAP AcidmaxPlayer.clsAP13
    if ($comerr) halt
  }
}

alias frmAP.Load {
;  frmAP.Init
  var %k = $com(lAP,StartAcidmaxPlayer,3,bstr,$window(-3).hwnd)
}

alias AP {
  frmAP.Load
}

alias frmAP.Unload {
  .comclose lAP
}
