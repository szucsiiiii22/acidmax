;nexcam
;guidex@tnexgen.com

on 1:CLOSE:@NexCam:.comclose lNexCam

menu query,channel,status,menubar {
  • utilities
  .nexcam: Click | frmNexCam.Load
}

alias frmNexCam.Init {
  .comopen lNexCam NexCam.clsNexCam10
  if ($comerr) {
    .comreg COM\NEXCAM.DLL
    .comopen lNexCam NexCam.clsNexCam10
    if ($comerr) halt
  }
}

alias frmNexCam.Reload {
  window -rik +te @NexCam 40 20 552 350 graphics\nexcam.ico
  var %k = $com(lNexCam,StartNexCam,3,bstr,$window(@NexCam).hwnd)
}

alias frmNexCam.Load {
  window -rik +te @NexCam 40 20 552 350 graphics\nexcam.ico
  frmNexCam.Init
  var %k = $com(lNexCam,StartNexCam,3,bstr,$window(@NexCam).hwnd)
}

alias NEXCAM {
  frmNexCam.Load
}

alias frmNexCam.Unload {
  .comclose lNexCam
}

alias frmNexCam.Close {
  window -c @NexCam
  .comclose lNexCam
}
