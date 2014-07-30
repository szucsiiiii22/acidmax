;Acidmax Translator
;guidex@tnexgen.com

on 1:CLOSE:@AT:.comclose lAT

menu query,channel,status,menubar {
  • utilities
  .translator: Click | frmAT.Load
}

alias frmAT.Init {
  .comopen lAT AcidmaxTranslator.clsTranslator
  if ($comerr) {
    .comreg COM\AT10.DLL
    .comopen lAT AcidmaxTranslator.clsTranslator
    if ($comerr) halt
  }
}

alias frmAT.Load {
  window -rik +te @AT 40 20 333 201 COM\AT.ico
  frmAT.Init
  var %k = $com(lAT,StartTranslator,3,bstr,$window(@AT).hwnd)
}

alias frmAT.Unload {
  .comclose lAT
}

alias frmAT.Close {
  window -c @AT
  .comclose lAT
}
