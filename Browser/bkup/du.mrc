; Acidmax Browser
; guidex@tnexgen.com

;menu query,channel,status,menubar {
;  .direct update
;  ..show direct update: frmDU.Load
;  ..close direct update: frmDU.Unload
;}

alias frmAB.Init {
  .comopen lAB AB.clsAB10
  if ($comerr) {
    .comreg AB\AB10.dll
    .comopen lAB AB.clsAB10
    if ($comerr) halt
  }
}

alias frmAB.Load {
  window -rik +te @AB 40 40 423 248 ab\ab.ico
  frmAB.Init
  var %k = $com(lAB,DoStartup,3,bstr,2 : $window(@AB).hwnd : $color(background) : $file(mirc.exe).longfn)
}

alias AB {
  frmAB.Load
}

alias frmAB.Unload {
  .comclose lAB
  window -c @AB
}

on 1:CLOSE:@AB:.comclose lAB
