:SEND MAIL
;guidex@tnexgen.com

on 1:CLOSE:@ASM:.comclose lASM

menu query,channel,status,menubar {
  .email
  ..new message: Click | frmASM.Load
}

alias frmASM.Init {
  .comopen lASM AcidmaxSendMail.clsSendMail
  if ($comerr) {
    .comreg ASM\ASM11.DLL
    .comopen lASM AcidmaxSendMail.clsSendMail
    if ($comerr) halt
  }
}

alias frmASM.Load {
  window -rik +te @ASM 40 20 300 322 DU\DU.ico
  frmASM.Init
  var %k = $com(lASM,SendMail,3,bstr,$window(@ASM).hwnd)
}

alias ASM {
  frmASM.Load
}

alias frmASM.Unload {
  .comclose lASM
}

alias frmASM.Close {
  window -c @ASM
  .comclose lASM
}
