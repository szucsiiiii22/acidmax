; acidmax browser
; guide_X@live.com

menu query,channel,status,menubar {
  • utilities
  .show browser: Click | frmAB.Load
}

alias frmAB.Init {
  .comopen lAB AB.clsAB11
  if ($comerr) {
    .comreg com\ab11.dll
    .comopen lAB AB.clsAB11
    if ($comerr) halt
  }
}

alias frmAB.Load {
  window @ab -k acidmax.ico
  var %k = $com(lAB,StartBrowser,3,bstr,$window(@ab).hwnd)
}

alias AB {
  frmAB.Load
}

alias frmAB.Unload {
  .comclose lAB
}
