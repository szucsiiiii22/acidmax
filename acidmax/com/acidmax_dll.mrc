; acidmax dll v1.0 - alpha
; load -rs acidmax_dll.mrc
; guide_X@live.com
; C:\Windows\Microsoft.NET\Framework\v4.0.30319\RegAsm.exe /codebase C:\dev\team-nexgen\acidmax\acidmax\com\acidmax.dll

alias SSH.Init {
  comopen adll acidmax.SSH
}

alias SSH.Host {
  var %result = $com(adll, Host, 1, bstr, $2)
  echo -s 12ssh Host set to12 » $com(adll).result $1 
}

alias SSH.Port {
  var %result = $com(adll, Port, 1, bstr, $2)
  echo -s 12ssh port set to12 » $com(adll).result $1 
}

alias SSH.User {
  var %result = $com(adll, User, 1, bstr, $2)
  echo -s 12ssh user set to12 » $com(adll).result $1 
}

alias SSH.Password {
  var %result = $com(adll, Password, 1, bstr, $2)
  echo -s 12ssh password set to 12 » $com(adll).result $1 
}

alias SSH.Info {
  var %result = $com(adll, Info, 1)
  echo -s 12ssh info 12 » $com(adll).result $1 
}

alias SSH.Connect {
  echo -s 12ssh connecting
  var %result = $com(adll, Connect, 1)
  echo -s 12ssh connect 12 » $com(adll).result $1 
}

alias SSH.Connected {
  var %result = $com(adll, Connected, 1)
  echo -s 12ssh connected 12 » $com(adll).result $1 
}

alias SSH.Disconnect {
  var %result = $com(adll, Disconnect, 1)
  echo -s 12ssh disconnected 
}
alias SSH.List {
  var %result = $com(adll, List, 1)
  echo -s 12ssh list 12 » $com(adll).result $1 
}

alias SSH.Localhost {
  var %r1 = $com(adll, Host, 1, bstr, 192.168.1.142) 
  var %r2 = $com(adll, Port, 1, bstr, 2223) 
  var %r3 = $com(adll, User, 1, bstr, websites) 
  var %r4 = $com(adll, Password, 1, bstr, Betazoid#1)
  echo -s 12ssh info set 
}

alias SSH.SetInfo {
  var %r1 = $com(adll, Host, 1, bstr, $1) 
  var %r2 = $com(adll, Port, 1, bstr, $2) 
  var %r3 = $com(adll, User, 1, bstr, $3) 
  var %r4 = $com(adll, Password, 1, bstr, $4)
  SSH.Info
  ;echo -s 12ssh info set 
}

alias SSH.List {
  var %result = $com(adll, Connect, 1)
  echo -s 12ssh connect 12 » $com(adll).result $1 
}

alias SSH.Unload {
  .comclose adll
}