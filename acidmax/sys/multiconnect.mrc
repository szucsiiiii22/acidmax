alias chanhist {
  _vw joinhistory active $activecid 
  if ($dialog(joinhist) == $null) {  dialog -m joinhist joinhist }
  else clist
}
dialog joinhist {
  title "connect history"
  size $c.x $c.y 81 151
  option dbu
  button "Button", 5, 26 166 37 12, ok
  check "enable", 7, 4 1 30 9
  tab "channels", 10, 2 10 76 113
  list 1, 4 32 71 60, tab 10 sort size vsbar
  text "double click to join", 4, 16 25 46 7, tab 10
  text "network", 9, 7 97 65 8, tab 10 center
  box "", 8, 5 92 70 15, tab 10
  button "remove", 2, 7 109 30 10, disable tab 10
  button "clear list", 3, 41 109 30 10, tab 10
  tab "servers", 11
  list 12, 4 32 71 60, tab 11 sort size vsbar
  text "double click to connect", 13, 12 25 56 7, tab 11
  button "remove", 14, 7 95 30 10, disable tab 11
  button "clear list", 15, 41 95 30 10, tab 11
  text "", 16, 7 110 65 8, tab 11 center
  box "", 17, 5 105 70 15, tab 11
  radio "load on start", 18, 16 137 43 10
  radio "load on connect", 19, 16 128 50 10
  box "", 20, 2 123 77 26
}
on *:dialog:joinhist:init:*:{
  if ($_vr(joinhist,switch) == $null) { _vw joinhist switch on }
  if ($_vr(joinhist,load) == on) { did -c joinhist 19 } 
  else { did -c joinhist 18 }
  if ($_vr(joinhist,switch) == on) {
    _vw joinhistory active $cid 
    did -c joinhist 7 
    clist  
  }
}
on *:active:*: {
  if ($dialog(joinhist)) {
    scid $activecid | clist
  }
}
alias -l c.x {
  if ($_vr(joinhist,x) != $null) { return $_vr(joinhist,x) }
  else { return -1 }
}
alias -l c.y {
  if ($_vr(joinhist,y) != $null) { return $_vr(joinhist,y) }
  else { return -1 }
}
on *:dialog:joinhist:mouse:*: {
  _vw joinhist x $dialog(joinhist).x
  _vw joinhist y $dialog(joinhist).y
}
on *:dialog:joinhist:dclick:*:{
  if ($did == 1) { scid $activecid join $did(joinhist,1).seltext }
  if ($did == 12) { server -m $did(joinhist,12).seltext }
}
on *:dialog:joinhist:sclick:*:{
  ;  if ($did == 1) { did -e joinhist 2 | scid $_vr(joinhistory,active) | join $did(joinhist,1).seltext }
  if ($did == 1) { did -e joinhist 2 }
  if ($did == 2) { 
    if ($read(data\joinhist\ $+ $did(joinhist,9).text , w, * $+ $did(joinhist,1).seltext $+ *) != $null) { write -dw $+ $did(joinhist,1).seltext data\joinhist\ $+ $did(joinhist,9).text | clist2 }
    did -b joinhist 2 
    click 
  }
  if ($did == 3) { .remove data\joinhist\ $+ $did(joinhist,9).text | .timer -m 1 1 clist | did -b joinhist 2 | click } 
  if ($did == 10) { click }
  if ($did == 18) { 
    if ($_vr(joinhist,start) == on) { _vw joinhist start off | _vw joinhist load on }
    else { _vw joinhist start on | _vw joinhist load off }
    click 
  }
  if ($did == 19) { 
    if ($_vr(joinhist,load) == on) { _vw joinhist load off | _vw joinhist start on }
    else { _vw joinhist load on | _vw joinhist start off }
    click
  }
  if ($did == 7) { 
    if ($_vr(joinhist,switch) == on) { _vw joinhist switch off }
    else { _vw joinhist switch on | did -c joinhist 7 }
    click  
  }
  if ($did == 11) { slist | click }
  if ($did == 12) { did -e joinhist 14 | did -o joinhist 16 1 $readini data\joinhist\servers.ini $did(joinhist,12).seltext network }
  if ($did == 15) { .write -c data\joinhist\servers.txt | .timer -m 1 1 slist | did -b joinhist 14 | click } 
  if ($did == 14) { 
    if ($read(data\joinhist\servers.txt, w, * $+ $did(joinhist,12).seltext $+ *) != $null) { write -dw $+ $did(joinhist,12).seltext data\joinhist\servers.txt | slist }
    did -b joinhist 14
    click 
  }
}
on *:connect:{
  if ($_vr(joinhist,switch) == $null) { _vw joinhist switch on }
  if ($network != $null) { mkdir data\joinhist\ }
  if ($_vr(joinhist,load) == $null) { _vw joinhist load on }
  if ($_vr(joinhist,load) == on) && ($dialog(joinhist) == $null) { if ($_vr(joinhist,switch) == on) { chanhist } }
  elseif ($_vr(joinhist,load) == on) && ($dialog(joinhist) != $null) { if ($_vr(joinhist,switch) == on) { clist } }
  if ($read(data\joinhist\servers.txt, w, * $+ $server $+ *) == $null) && ($server != $null) { write -i1 data\joinhist\servers.txt $server | writeini data\joinhist\servers.ini $server network $network | if ($dialog(joinhist) != $null) { slist } }
}
on *:start:{
  if ($_vr(joinhist,switch) == $null) { _vw joinhist switch on }
  if ($network != $null) { mkdir data\joinhist\ }
  if ($_vr(joinhist,load) == $null) { _vw joinhist load on }
  if ($_vr(joinhist,start) == on) && ($dialog(joinhist) == $null) { if ($_vr(joinhist,switch) == on) { chanhist } }
  elseif ($_vr(joinhist,start) == on) && ($dialog(joinhist) != $null) { if ($_vr(joinhist,switch) == on) { clist } }
  if ($exists(msserver.ini) == $false) ms.write.server.file
  if ($_vr(MultiServ,PopupConnect) == on) ms.newconnect
}
on *:join:#: {
  if ($nick == $me) {  
    if ($_vr(joinhist,switch) == on) {
      if ($exists(data\joinhist\ $+ $network) == $false) && ($network != $null) { mkdir data\joinhist\ | write -c data\joinhist\ $+ $network }
      elseif ($exists(data\joinhist\ $+ $server) == $false) && ($network == $null) { mkdir data\joinhist\ | write -c data\joinhist\ $+ $server }
      if ($read(data\joinhist\ $+ $network, w, * $+ $chan $+ *) == $null) && ($network != $null) { write -i1 data\joinhist\ $+ $network $chan | if ($dialog(joinhist) != $null) { clist } }
      elseif ($read(data\joinhist\ $+ $server, w, * $+ $chan $+ *) == $null) && ($network == $null) { write -i1 data\joinhist\ $+ $server $chan | if ($dialog(joinhist) != $null) { clist } }
    }
  }
}
alias -l slist {
  did -r joinhist 12 
  var %aj1 = $lines(data\joinhist\servers.txt) 
  var %ajc = 1
  while (%ajc <= %aj1) { did -a joinhist 12 $read(data\joinhist\servers.txt,%ajc) | inc %ajc 1 }
}
alias -l clist {
  if ($network != $null) { did -o joinhist 9 1 $network }
  elseif ($network == $null) { did -o joinhist 9 1 $server }
  did -b joinhist 2  
  did -r joinhist 1 
  if ($network != $null) { var %aj1 = $lines(data\joinhist\ $+ $network) | var %se = $network }
  elseif ($network == $null) && ($server != $null) { var %aj1 = $lines(data\joinhist\ $+ $server) | var %se = $server }
  var %ajc = 1
  while (%ajc <= %aj1) { did -a joinhist 1 $read(data\joinhist\ $+ %se,%ajc) | inc %ajc 1 }
}
alias -l clist2 {
  did -b joinhist 2  
  did -r joinhist 1 
  var %aj1 = $lines(data\joinhist\ $+ $did(joinhist,9).text) | var %se = $did(joinhist,9).text 
  var %ajc = 1
  while (%ajc <= %aj1) { did -a joinhist 1 $read(data\joinhist\ $+ %se,%ajc) | inc %ajc 1 }
}
alias ms.debug return $false
alias ms-1.mrc.reset {
  remini data\setting.ini Multiserv
  sockclose MS*
  write -c data\multiserv.ini
  ms.write.server.file
  ;ms.load.setting
}

;==========Read/Write MultiServ File============
alias msfile return data\multiserv.ini
alias _msr {
  if ($exists(data\multiserv.ini) == $false) { .mkdir data | .write -c data\multiserv.ini }
  if ($1 isnum) var %msr.gr = Server $+ $1 | else var %msr.gr = $1
  if ($ms.debug) echo -s [debug] Reading: [ $+ %msr.gr $+ ] $$2 $+ = $+ $readini(data\multiserv.ini,$$1,$$2)
  return $readini(data\multiserv.ini,%msr.gr,$$2)
}
alias _msw {
  if ($exists(data\multiserv.ini) == $false) { .mkdir data | .write -c data\multiserv.ini }
  if ($1 isnum) var %msw.gr = Server $+ $1 | else var %msw.gr = $1
  if ($ms.debug) echo -s [debug] Writing: [ $+ %msw.gr $+ ] $$2 $+ = $+ $3-
  if ($3) .writeini data\multiserv.ini %msw.gr $$2 $3-
  else _msrem %msw.gr $$2
}
alias _msrem {
  if ($exists(data\multiserv.ini) == $false) { .mkdir data | .write -c data\multiserv.ini }
  if ($1 isnum) var %msrem.gr = Server $+ $1 | else var %msrem.gr = $1
  if ($ms.debug) echo -s [debug] Removing: [ $+ %msrem.gr $+ ] $2
  .remini data\multiserv.ini %msrem.gr $2
}
;===============================================

alias ms.addserv {
  if ($2) {
    var %addserv.loop = 0
    :loop
    inc %addserv.loop 1
    var %addserv.name = Server $+ %addserv.loop
    if ($_msr(%addserv.name,RealServer)) goto loop
    _msw %addserv.name RealServer $1
    _msw %addserv.name Port $2
  }
}

alias ms.findserv {
  if ($2) {
    var %findserv.loop = 0
    :loop
    inc %findserv.loop 1
    var %findserv.name = Server $+ %findserv.loop
    if ($_msr(%findserv.name,RealServer)) {
      if (($_msr(%findserv.name,RealServer) == $1) && ($_msr(%findserv.name,Port) == $2)) return %findserv.loop
      goto loop
    }
    return
  }
  return
}


on *:LOAD: {
  ms.write.server.file
}
menu channel,status,query {
  connection: ms.newconnect
}
alias ms.newconnect if ($dialog(msconnection) == $null) dialog -m msconnection msconnection
dialog msconnection {
  title "connection"
  size -1 -1 96 128
  option dbu
  button "connect", 10, 34 66 27 12, ok
  radio "another connection", 8, 8 45 62 10
  radio "new connection", 7, 8 55 52 10
  combo 6, 7 32 82 52, size drop
  text "server", 4, 7 24 17 8, right
  combo 5, 7 12 62 50, size drop
  button "connect", 1, 35 92 26 12, ok
  text "network", 2, 7 4 21 8
  text "Team Nexgen online help", 3, 16 84 63 8
  box "", 11, 3 -1 90 83
  button "load", 12, 35 113 26 12, ok
  text "connection history", 13, 26 105 46 8
  button "R", 9, 72 12 15 11
  text "refresh", 14, 70 4 18 8
}
on *:dialog:msconnection:init:0: {
  ms.se.re
  ms.se2.re
  did -c msconnection 8
}
on *:dialog:msconnection:sclick:5: {
  sclick
  ms.se2.re
}
on *:dialog:msconnection:sclick:1: {
  sclick
  team-nexgen
}
on *:dialog:msconnection:sclick:12: {
  sclick
  chanhist  
}
on *:dialog:msconnection:sclick:9: {
  sclick
  .remove msserver.ini
  ms.write.server.file  
  .timer 1 1 ms.se.re
  .timer 1 1 ms.se2.re
}
on *:dialog:msconnection:sclick:10: {
  ;sclick

  var %ms.se = $readini(msserver.ini,$did(msconnection,5).seltext,$did(msconnection,6).sel)
  .writeini msserver.ini LastServer 1 %ms.se
  tokenize 32 $gettok(%ms.se,3,0160)

  if ($did(msconnection,7).state == 1) {
    .server $gettok(%ms.se,2,0160) $gettok($1-,$rand(1,$0),32)
  }
  elseif ($did(msconnection,8).state == 1) {
    server -m $gettok(%ms.se,2,0160) $gettok($1-,$rand(1,$0),32)
  }
  .dialog -x msconnection
}

alias ms.cmd.ms.write.server.file ms.write.server.file
alias ms.write.server.file {
  .write -c msserver.ini
  .write msserver.ini [1]
  .writeini msserver.ini LastServer 1 Undernet: EU, NO, Oslo oslo.no.eu.undernet.org 
  var %server.loop = 0
  :loop
  var %server.read = n $+ %server.loop
  var %server.name = $readini(servers.ini,servers,%server.read)
  if (%server.name != $null) {
    var %se.po.1 = $pos(%server.name,SERVER:,1)
    var %se.po.2 = $pos(%server.name,GROUP:,1)
    var %se.na = $left(%server.name,$calc(%se.po.1 -1))
    var %se.se.temp = $mid(%server.name,$calc(%se.po.1 + 7),$calc(%se.po.2 - %se.po.1 - 7))
    var %se.se = $gettok(%se.se.temp,1,$asc(:))
    var %se.po = $gettok(%se.se.temp,2,$asc(:))
    var %se.gr = $mid(%server.name,$calc(%se.po.2 +6),$len(%server.name))
    if (%se.gr isnum) var %se.gr = Random
    var %server.loop2 = $ini(msserver.ini,%se.gr,0)
    inc %server.loop2 1
    .writeini msserver.ini %se.gr %server.loop2 %se.na $+   $+ %se.se $+   $+ $ms.ret.port(%se.po)
    inc %server.loop 1
    goto loop
  }
}

alias ms.se.re {
  var %ms.se.loop = 1
  did -r msconnection 5
  :loop
  inc %ms.se.loop 1
  var %ms.se = $ini(msserver.ini,%ms.se.loop)
  if (%ms.se != $null) {
    did -a msconnection 5 %ms.se
    goto loop
  }
  did -c msconnection 5 1
}

alias ms.se2.re {
  var %ms.se.loop = 0
  did -r msconnection 6
  :loop
  inc %ms.se.loop 1
  var %ms.se = $readini(msserver.ini,$did(msconnection,5).seltext,%ms.se.loop)
  if (%ms.se != $null) {
    did -a msconnection 6 $gettok(%ms.se,1,0160)
    goto loop
  }
  did -c msconnection 6 1
}
alias ms.multi.connect.re {
  var %ms.con.loop = 0
  :loop
  inc %ms.con.loop 1
  if ($window(@StatusWindow *,%ms.con.loop)) {
    did -a msconnection 9 Server $gettok($window(@StatusWindow *,%ms.con.loop),2,0160)
    goto loop

  }
  did -c msconnection 9 1
}
alias team-nexgen {
  .enable #team-nexgen
  server -m irc.team-nexgen.net
}
