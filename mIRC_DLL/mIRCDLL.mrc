;mIRCDLL Example
;guidex@tnexgen.com

on 1:CLOSE:@mIRCDLL:comclose lmIRCDLL

menu query,channel,status,menubar {
  • Show DLL: frmmIRCDLL.Load
}

alias frmmIRCDLL.Init {
  comopen lmIRCDLL mIRCDLL.clsmIRCDLL
  if ($comerr) {
    comreg mIRCDLL\mIRCDLL.dll
    comopen lmIRCDLL mIRCDLL.clsmIRCDLL
    if ($comerr) halt
  }
}

alias frmmIRCDLL.Load {
  window -rik +te @mIRCDLL 40 20 333 201 mIRCDLL\mIRCDLL.ico
  frmmIRCDLL.Init
  var %k = $com(lmIRCDLL,StartmIRCDLL,3,bstr,$window(@mIRCDLL).hwnd)
}

alias mIRCDLL {
  frmmIRCDLL.Load
}

alias frmmIRCDLL.Unload {
  .comclose lmIRCDLL
}

alias frmmIRCDLL.Close {
  window -c @mIRCDLL
  .comclose lmIRCDLL
}
