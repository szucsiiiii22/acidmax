alias oper {
  if ($1 != $null) && ($2 != $null) && ($_vr(oper.ini,userid) != $null) && ($_vr(oper.ini,pass) != $null) { oper $1 $2 }
  elseif ($dialog(oper.ini) == $null) { dialog -m oper.ini oper.ini | haltdef }
}
dialog oper.ini {
  title "oper initiate"
  size -1 -1 215 65
  edit "", 1, 111 18 100 21, pass autohs
  edit "", 2, 3 18 100 21, autohs
  text "user id", 3, 6 2 32 16
  text "password", 4, 114 2 46 16
  button "send", 5, 81 43 56 18, ok
  box "", 6, 8 40 66 17
  box "", 7, 144 41 66 17
}
on *:dialog:oper.ini:init:*:{ 
  if ($_vr(oper.ini,userid) != $null) { did -o oper.ini 2 1 $_vr(oper.ini,userid) }
  if ($_vr(oper.ini,pass) != $null) { did -o oper.ini 1 1 $_vr(oper.ini,pass) }
}
on *:dialog:oper.ini:sclick:*:{ 
  if ($did == 5) { .raw oper $did(2,$did(2).text) $did(1,$did(1).text) }
}
on *:dialog:oper.ini:edit:*:{
  if ($did == 2) { if ($did(oper.ini,2).text != $null) { _vw oper.ini userid $did(oper.ini,2).text } | else _vrem oper.ini userid }
  if ($did == 1) { if ($did(oper.ini,1).text != $null) { _vw oper.ini pass $did(oper.ini,1).text } | else _vrem oper.ini pass }
}
menu gchannel {
  &deoper: deoper
  -
  &config stats
  .&C.Lines: stats c
  .&D.Lines: stats d
  .&H.Lines: stats h
  .&i.Lines: stats i
  .&K/Z.Lines: stats k
  .&N.Lines: stats n
  .&O.Lines: stats o
  .&Q.Lines: stats Q
  .&U.Lines: stats U
  .&Y.Lines: stats y
  server stats
  .Connection &1: stats l $?="nick?"
  .Connection &2: stats L $?="nick?"
  .U&sage count: stats m
  .&Q.Lines: stats q
  .U&ptime: stats u
  .&Raw info: stats t
  .&Load: stats w
  .&Missing servers: stats x
  .M&emory: stats z
  &modes change
  .+
  ..+&s (server msgs):mode $me +s
  ..+&w (wallops):mode $me +w
  ..+&g (globops):mode $me +g
  ..+&c (dis)connects:mode $me +c
  ..+&k (kills):mode $me +k
  ..+&f (flood q's):mode $me +f
  ..+&h (helpop):mode $me +h
  ..+&a (services admin):mode $me +a
  ..+&A (server admin):mode $me +A
  ..+&b (chatops): mode $me +b
  ..+&e (whois):mode $me +e
  ..+&C (co-admin):mode $me +C
  .$chr(45)
  ..-&o (deoper):mode $me -o
  ..-&s (server msgs):mode $me -s
  ..-&w (wallops):mode $me -w
  ..-&g (globops):mode $me -g
  ..-&c (dis)connects:mode $me -c
  ..-&k (kills):mode $me -k
  ..-&f (flood q's):mode $me -f
  ..-&h (helpop):mode $me -h
  ..-&a (services admin):mode $me -a
  ..-&A (server admin):mode $me -A
  ..-&b (chatops): mode $me -b
  ..-&e (whois):mode $me -e
  ..-&C (co-admin):mode $me -C
  oper &talk
  .&globops:globops $$?="msg"
  .&wallops:wallops $$?="msg"
  .&locops:locops $$?="msg"
  .&chatops:chatops : $+ $$?="msg"
  &other
  .&rehash:rehash
  .r&estart:restart
  .&close:raw close
  .k&ill:kill $$?="user" $$?="reason"
  .-
  .&kline:kline $$?="nickname OR user@hostmask" : $+ $?="reason?"
  .&unkline:unkline $$?="nickname OR user@hostmask"
  .-
  .&zline:zline $$?="ip address"
  .u&nzline:unzline $$?="ip address"
  &nonoper
  .&motd:motd
  .&lusers:lusers
  .l&inks:links
  .&version: version $$?="server:"
  .&trace: trace $$?="server or nick:"
  .&help:raw help
}
