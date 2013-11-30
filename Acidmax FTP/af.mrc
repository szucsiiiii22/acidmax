;Acidmax FTP
;guidex@tnexgen.com

on 1:CLOSE:@AF:.comclose lAF

menu query,channel,status,menubar {
  .acidmax ftp
  ..show acidmax ftp: frmAF.Load
  ..close acidmax ftp: frmAF.Unload
}

alias frmAF.Init {
  .comopen lAF AF.clsAF
  if ($comerr) {
    .comreg AF\AF.dll
    .comopen lAF AF.clsAF
    if ($comerr) halt
  }
}

alias frmAF.Load {
  window -rik +te @AF 40 40 423 248 AF\AF.ico
  frmAF.Init
  var %k = $com(lAF,DoStartup,3,bstr,2 : $window(@AF).hwnd : $color(background) : $file(mirc.exe).longfn : 1. : 0)
}

alias AF {
  frmAF.Load
}

alias frmAF.Unload {
  .comclose lAF
  window -c @AF
}
