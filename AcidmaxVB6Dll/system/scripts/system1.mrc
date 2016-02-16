menu query, channel, status, menubar {
  .dll
  ..control panel: frmAD.ControlPanel
}
;on 1:close: {
  ;@AD:comclose AD
;}
on *:start: {
  var %mirc_required_version = 6.43
  if (($version < %mirc_required_version) || ($bits != 32)) {
    echo 4 -s *** You must be running a mIRC %mirc_required_version 32bit or higher! Unloading script...
    unload -rs $script 
  }
  comopen AD AcidmaxDll.ControlPanel
  if ($comerr) {
    comreg system\bin\AcidmaxDll.dll
    comopen AD AcidmaxDll.ControlPanel
    if ($comerr) {
      echo 4 -s *** DLL LOAD FAILURE
      halt
    }
  }
  window -rik +stenx @AD 40 20 472 404 content\ico\nexgen.ico
  var %k = $com(AD,Initialize,3,bstr,$window(@AD).hwnd)
}
;on *:load:{ .timer 1 60 AcidmaxLoad }
alias netcomreg {
  var %regasm = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\regasm.exe"
  ;var %regasm $shortfn($findfile(C:\,regasm.exe,1))
  if ($1 == -u) {
    run %regasm /unregister $shortfn($2-)
  }
  else {
    run %regasm /codebase $shortfn($1-)
  }
}