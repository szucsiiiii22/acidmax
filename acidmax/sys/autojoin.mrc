;Auto-Join v3.01
;Team Nexgen 2002 by KnightFal
;team-nexgen.com

on *:load:{ 
  if ($version < 5.91) echo -a  $+ $colour(info2) $+ *** You need mirc 5.91 or greator in order to use this addon. | beep 
  echo -a  4TEAM NEXGEN'S AUTO-JOIN v3.01 | echo -a  4Please type: /aj to begin dialog, type: /ajoin to rejoin set channels.
}
;on *:start:{
;  var %l = $lines(data/ajserv.txt)
;  var %l2 = 1
;  while (%l2 <= %l) { server -m $read(data/ajserv.txt,%l2) | inc %l2 1 }
;}
on *:start:{
  if ($_ar(general,switch) == on) { 
    if ($lines(data\ajserv.txt) != 0) { server $read(data\ajserv.txt,1) | goto mlti }
    :mlti
    var %xxx = 2
    while (%xxx <= $lines(data\ajserv.txt)) {
      server -m $read(data\ajserv.txt,%xxx) 
      inc %xxx
    }
  }
}
menu Status,Menubar {
  auto-join
  .console:aj
  .rejoin channels:ajoin
  .switch  $aj.switch
  .. $aj.switch :  if ($_ar(general,switch) == on) {  if ($dialog(_ajoin) != $null) { did -b _ajoin 1,2,3,5 | did -u _ajoin 13 } | _aw general switch off | haltdef } | else {  if ($dialog(_ajoin) != $null) { did -c _ajoin 13 | did -e _ajoin 1,2,3,5 } | _aw general switch on | haltdef } 
}
menu channel {
  auto-join
  .add # to auto-join: write data/ $+ $network $+ .txt # 
  .switch  $aj.switch
  .. $aj.switch :  if ($_ar(general,switch) == on) {  if ($dialog(_ajoin) != $null) { did -b _ajoin 1,2,3,5 | did -u _ajoin 13 } | _aw general switch off | haltdef } | else {  if ($dialog(_ajoin) != $null) { did -c _ajoin 13 | did -e _ajoin 1,2,3,5 } | _aw general switch on | haltdef } 
}
alias -l aj.switch {
  if ($_ar(general,switch) == off) { return $chr(91) $+ off $+ $chr(93) }
  else { return $chr(91) $+ on $+ $chr(93) } 
}
;[read write data/autojoin.ini]
alias -l _ar {
  if ($exists(data\autojoin.ini) == $false) { mkdir data | write -c data\autojoin.ini }
  return $readini data\autojoin.ini $$1 $$2 
}
alias -l _aw {
  if ($exists(data\autojoin.ini) == $false) { mkdir data | write -c data\autojoin.ini }
  writeini data\autojoin.ini $$1 $$2 $$3-
}
alias -l _arem {
  if ($exists(data\autojoin.ini) == $false) { mkdir data | write -c data\autojoin.ini }
  remini data\autojoin.ini $$1 $$2 
}
alias aj {
  if ($version < 5.91) { echo -a 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if $dialog(_ajoin) == $null) { dialog -m _ajoin _ajoin } 
}
on *:connect: {
  if ($_ar(general,switch) == on) {
    if ($_ar(general,delay) == on) { .timer 1 15 aj.join }
    else aj.join
  }
}
alias ajoin {
  if ($version < 5.91) { echo -a 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($aj.network == $true) && ($_ar(general,switch) == on) { aj.join }
}
dialog _ajoin {
  title "auto-join v3.1"
  size -1 -1 186 142
  option dbu
  button "exit", 4, 250 250 15 10, ok
  list 1, 7 43 50 80, disable size hsbar
  edit "", 2, 7 21 50 10, disable autohs
  button "add", 3, 8 33 21 8, disable
  button "del", 5, 35 33 21 8, disable
  list 6, 68 43 50 60, disable sort size hsbar
  button "add", 7, 69 33 21 8, disable
  button "del", 8, 96 33 21 8, disable
  edit "", 9, 68 21 50 10, disable autohs
  box "network", 10, 4 13 58 112
  box "auto-join channel", 11, 64 13 58 112
  check "enable", 13, 6 2 30 10
  button "join now", 14, 78 128 29 10
  check "delay join", 12, 8 128 50 10
  box "auto-connect server", 15, 124 13 58 112
  list 16, 128 43 50 80, disable sort size hsbar
  button "add", 17, 129 33 21 8, disable
  button "del", 18, 156 33 21 8, disable
  combo 19, 127 21 52 50, size edit hsbar drop
  button "connect now", 20, 137 128 34 10
  box "", 21, 64 123 58 17
  box "", 22, 124 123 58 17
  edit "", 23, 68 113 50 10, disable
  text "channel key", 24, 69 104 44 8
}
alias -l serv2 {
  var %s = $scon(0).server
  var %s2 = 1
  while (%s2 <= %s) { did -a _ajoin 19 $scon(%s2).server | inc %s2 1 }
}
on *:dialog:_ajoin:edit:*:{
  if ($did == 23) { 
    if ($did(_ajoin,23).text  != $null) { _aw $did(_ajoin,1).seltext $did(_ajoin,6).seltext $did(_ajoin,23).text }
    else {  _arem $did(_ajoin,1).seltext $did(_ajoin,6).seltext }
  }
  if ($did == 19) && ($did(_ajoin,19).text != $null) { did -e _ajoin 17 } 
  elseif ($did == 19) && ($did(_ajoin,19).text == $null) { did -b _ajoin 17 } 
}
on *:dialog:_ajoin:init:*:{
  if ($_ar(general,switch) == on) { did -c _ajoin 13 | did -e _ajoin 1,2,3,5 } 
  if ($_ar(general,delay) == on) { did -c _ajoin 12 } 
  did -o _ajoin 2 1 $net.check 
  aj.refresh
  serv
  serv2
  did -c _ajoin 19 1 
  if ($did(_ajoin,19).text != $null) { did -e _ajoin 17 }
}
alias -l net.check {
  if ($_ar(general,switch) == on) { 
    if ($network != $null) { return $network }
    else return $server 
  }
}
alias -l aj.netc {
  if ($_ar(network,count) != $null) { return $_ar(network,count) }
  else return 0
}
alias -l aj.chanc {
  if ($_ar($did(1).sel,count) != $null) && ($_ar($did(1).sel,count) >= 1) { return $_ar($did(1).sel,count) }
  else return 0
}
alias -l aj.refresh {
  did -r _ajoin 1,6
  var %aj1 = $aj.netc
  var %ajc = 1
  :loop
  if (%ajc <= %aj1) { did -a _ajoin 1 $_ar(network,%ajc) } 
  else { goto end }
  inc %ajc
  goto loop
  :end
}
alias -l net {
  var %asas = " $+ $findfile($mircdirdata, $net.check $+ .txt,1) $+ "
  if (%asas  != $null) {
    return %asas
  }
}
alias -l serv {
  did -r _ajoin 16 
  var %l = $lines(data/ajserv.txt)
  var %l2 = 1
  while (%l2 <= %l) { did -a _ajoin 16 $read(data/ajserv.txt,%l2) | inc %l2 1 | did -z _ajoin 16 | did -e _ajoin 16 }
}
alias -l aj.join {
  var %aj1 = $lines($net) 
  var %ajc = 1
  while (%ajc <= %aj1) { join $read($net ,%ajc) $_ar($net.check,$read($net ,%ajc)) | inc %ajc 1 }
}
alias -l aj.channel {
  did -r _ajoin 6
  var %aj1 = $lines(data/ $+ $_ar(network,$_ar(network,current)) $+ .txt) 
  var %ajc = 1
  while (%ajc <= %aj1)  { did -a _ajoin 6 $read(data/ $+ $_ar(network,$_ar(network,current)) $+ .txt,%ajc) | inc %ajc 1 }
}
alias -l aj.network {
  var %aj1 = $aj.netc
  var %ajc = 1
  :loop
  if (%ajc > %aj1) { return $false | goto end }  
  elseif ($_ar(network,%ajc) == $net.check) { return $true } 
  else { return $false | goto end }
  inc %ajc
  goto loop
  :end
}
alias -l del.ajset { remove $findfile($mircdirdata,autojoin.ini,1) } 
on *:dialog:_ajoin:dclick:*:{ 
  if ($did == 16)  && ($did(_ajoin,16).seltext != $null) { server -m $did(_ajoin,16).seltext }
  if ($did == 6)  && ($did(_ajoin,6).seltext != $null) { server -m $did(_ajoin,6).seltext }
}
on *:dialog:_ajoin:sclick:*:{
  if ($did == 3) && ($did(_ajoin,2).text != $null) { _aw network count $calc($aj.netc + 1) | _aw network $aj.netc $did(2).text | did -a _ajoin 1 $did(_ajoin,2).text | did -r _ajoin 2 }
  if ($did == 5) && ($did(_ajoin,1).seltext != $null) { var %ajq =  $_ar(network,$_ar(network,current)) | _arem network $aj.netc $did(1).sel | _aw network count $calc($aj.netc - 1) |  if (data/ $+ $did(_ajoin,1).seltext  $+ .txt != $null) { remove data/ $+ $did(_ajoin,1).seltext $+ .txt } | aj.refresh | aj.channel }
  if ($did == 1) && ($did(_ajoin,1).seltext != $null) { if ($left($active,1) == $chr(35)) { did -o _ajoin 9 1 $active } | did -e _ajoin 6,9,7,8 | _aw network current $did(_ajoin,1).sel | aj.channel | did -b _ajoin 23 | did -r _ajoin 23 } 
  ;  if ($did == 7) && ($did(_ajoin,1).seltext != $null) { if ($did(_ajoin,9).text) != $null) { write data/ $+ $did(_ajoin,1).seltext $+ .txt $did(_ajoin,9).text | did -a _ajoin 6 $did(_ajoin,9).text | did -r _ajoin 19 } }
  if ($did == 7) && ($did(_ajoin,1).seltext != $null) { if ($did(_ajoin,9).text != $null) { write data/ $+ $did(_ajoin,1).seltext $+ .txt $did(_ajoin,9).text | did -a _ajoin 6 $did(_ajoin,9).text | did -r _ajoin 19 } }
  ;  if ($did == 23) && ($did(_ajoin,1).seltext != $null)  
  if ($did == 6) { did -r _ajoin 23 | did -e _ajoin 23 | did -o _ajoin 23 1 $_ar($did(_ajoin,1).seltext,$did(_ajoin,6).seltext)  } 
  if ($did == 16) { did -e _ajoin 18 }
  if ($did == 17) { 
    if ($did(_ajoin,19).seltext != $null) { write data/ajserv.txt $did(_ajoin,19).seltext | .timer -m 1 1 serv | did -e _ajoin 16 }
    elseif ($did(_ajoin,19).text != $null) { write data/ajserv.txt $did(_ajoin,19).text | .timer -m 1 1 serv | did -e _ajoin 16 }
  }   
  if ($did == 19) && ($did(_ajoin,19).text != $null) { did -e _ajoin 17 } 
  if ($did == 8) && ($did(_ajoin,6).seltext != $null) { write -ds $+ $did(_ajoin,6).seltext data/ $+ $did(_ajoin,1).seltext $+ .txt | .timer -m 1 1 aj.channel }
  if ($did == 18) && ($did(_ajoin,16).seltext != $null) { write -ds $+ $did(_ajoin,16).seltext data/ajserv.txt | .timer -m 1 1 serv }
  if ($did == 12) { 
    if ($_ar(general,delay) == on) { _aw general delay off }
    else { _aw general delay on }
  }
  if ($did == 20)  && ($did(_ajoin,16).seltext != $null) { server -m $did(_ajoin,16).seltext }
  if ($did == 13) { 
    if ($_ar(general,switch) == on) { did -b _ajoin 1,2,3,5 | did -u _ajoin 13 | _aw general switch off | haltdef }
    else { did -c _ajoin 13 | did -e _ajoin 1,2,3,5 | _aw general switch on | haltdef }
  }
  if ($did == 14)  { aj.join }
}
