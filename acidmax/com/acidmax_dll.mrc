; acidmax dll v1.0 - alpha
; load -rs acidmax_dll.mrc
; guide_X@live.com
; C:\Windows\Microsoft.NET\Framework\v4.0.30319\RegAsm.exe /codebase C:\dev\team-nexgen\acidmax\acidmax\com\acidmax.dll

alias adll.Init {
  .comopen adll acidmax.SSH
}

alias adll.TestMessage {
  var %result = $com(adll,TestMessage, 1)
  echo -s 12ssh test message12 » $com(adll).result $1 
}

alias adll.Unload {
  .comclose adll
}