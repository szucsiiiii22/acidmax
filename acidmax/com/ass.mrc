;Advanced System Stats
;guidex@tnexgen.com

on 1:CLOSE:@ASS:.comclose lASS

menu query,channel,status,menubar {
  • utilities
  .stats: frmASS.Load
}

alias frmASS.Init {
  .comopen lASS ASS.clsSystemStats20
  if ($comerr) {
    .comreg COM\ASS20.DLL
    .comopen lASS ASS.clsSystemStats20
    if ($comerr) halt
  }
}

alias frmASS.Load {
  window -rik +te @ASS 40 20 489 350 DU\DU.ico
  frmASS.Init
  var %k = $com(lASS,StartSystemStats,3,bstr,$window(@ASS).hwnd)
}

alias ASS {
  frmASS.Load
}

alias frmASS.Unload {
  .comclose lASS
}

alias frmASS.Close {
  window -c @ASS
  .comclose lASS
}

;alias comchans {
;  set %x 1
;  set %chans $null
;  while (%x <= $comchan($$1,0)) {
;    set %chan $comchan($$1,%x)
;    set %chans $addtok(%chans,%chan,44)
;    //echo %chans
;  inc %x 1
;  }
;  return %chans
;}
