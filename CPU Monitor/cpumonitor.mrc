; Acidmax 3 - CPU Monitor DLL
; guidex@team-nexgen.com

on 1:START:frmCPUMonitor.Load

menu query,channel,status,menubar {
  .CPU Monitor
  ..Load CPU Monitor: frmCPUMonitor.Load
  ..Close CPU Monitor: frmCPUMonitor.Unload
}

alias frmCPUMonitor.Initialize {
  comopen lCPUMonitor CPUMonitor.clsAcidmaxDirector
  if ($comerr) {
    .comreg cpumonitor\cpumonitor.dll
    comopen lCPUMonitor CPUMonitor.clsAcidmaxDirector
    if ($comerr) halt
  }
}

alias frmCPUMonitor.Load {
  frmCPUMonitor.Initialize
  var %k = $com(lCPUMonitor,DoStartup,3,bstr,$window(1).hwnd : $file(mirc.exe).longfn)
}

alias frmCPUMonitor.Unload {
  comclose lCPUMonitor
}
