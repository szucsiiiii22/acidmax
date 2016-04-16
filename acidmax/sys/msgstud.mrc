;Message Studio v1.14
;Team Nexgen 2003 by KnightFal
;team-nexgen.com

on *:load:{ 
  if ($version < 5.91) echo -a  $+ $colour(info2) $+ *** This addon will not work properly with mIRC $version $+ , you need latest mirc in order to use this addon. | beep 
  echo -a  4Team Nexgen's Message  Studio v1.14 | echo -a  4Please type: /message.stud in channel to begin dialog.
}
;[read write data/setting.ini]
alias _vr {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  return $readini data\setting.ini $$1 $$2 
}
alias _vw {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  writeini data\setting.ini $$1 $$2 $$3-
}
alias _vrem {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  remini data\setting.ini $$1 $$2 
}
menu channel {
  $iif($acid == $true,• utilities)
  .message studio: message.stud 
  $iif($acid != $true,msg studio):message.stud 
}
alias message.stud {
  if ($version < 5.91) { echo -s 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($dialog(message.stud) == $null) { set %ascbc $active | $message.stud.dialog } 
}
alias message.stud.dialog {
  if ($_vr(message.stud,ontop) == on) { return dialog -m message.stud message.stud }
  else return dialog -mdie message.stud message.stud
}
dialog message.stud {
  title "Message Studio v1.14"
  size -1 -1 160 192
  option dbu
  button "close", 12, 64 171 29 12, cancel
  tab "main", 13, 2 -1 155 187
  list 15, 8 37 50 81, disable tab 13 sort size hsbar
  button "send", 21, 11 141 45 12, disable tab 13
  box "nicklist", 31, 5 28 58 130, disable tab 13
  check "apply to nick", 36, 13 128 42 10, tab 13
  box "send via:", 41, 65 120 42 38, tab 13
  radio "notice", 38, 69 128 26 10, tab 13
  radio "query", 39, 69 136 34 10, tab 13
  radio "channel", 40, 69 144 34 10, tab 13
  edit "", 96, 5 17 58 10, tab 13 read autohs
  check "stay on top", 101, 7 160 42 10, tab 13
  check "include logo", 102, 64 160 42 10, tab 13
  check "auto-refresh", 1, 13 118 43 10, tab 13
  tab "create", 14
  edit "", 7, 11 136 138 10, tab 14 autohs
  button "delete", 11, 65 118 21 8, disable tab 14
  button "save", 8, 10 148 29 8, disable tab 14
  button "edit", 24, 88 118 21 8, disable tab 14
  edit "", 25, 11 117 50 10, tab 14 autohs
  text "label", 33, 12 108 11 8, tab 14
  text "single line message", 34, 11 128 62 8, tab 14
  button "clear", 35, 41 148 29 8, disable tab 14
  button "rename", 37, 111 118 21 8, disable tab 14
  radio "support", 42, 17 25 34 10, tab 14 push
  radio "comedy", 43, 17 36 34 10, tab 14 push
  radio "hello/bye", 44, 17 47 34 10, tab 14 push
  radio "insults", 45, 17 58 34 10, tab 14 push
  radio "love", 46, 17 69 34 10, tab 14 push
  radio "rules", 47, 17 80 34 10, tab 14 push
  box "catagories", 48, 9 16 50 90, tab 14
  radio "misc", 49, 17 91 34 10, tab 14 push
  button "open", 50, 134 118 21 8, disable tab 14
  button "erase", 51, 121 148 29 8, disable tab 14
  edit "", 52, 125 168 26 10, tab 14 read autohs center
  text "lines", 53, 125 160 11 8, tab 14
  check "make into multi line", 54, 11 158 58 10, hide tab 14
  button "text editor", 98, 72 148 29 8, disable tab 14
  button "refresh", 99, 74 108 21 8, tab 14
  tab "automated", 70
  list 71, 4 129 58 30, tab 70 size hsbar
  radio "join", 72, 21 56 34 10, tab 70
  radio "part", 73, 21 66 34 10, tab 70
  radio "op", 74, 21 76 26 10, tab 70
  radio "deop", 75, 21 86 34 10, tab 70
  radio "voice", 76, 21 96 34 10, tab 70
  radio "devoice", 77, 21 106 34 10, tab 70
  radio "kick", 78, 21 47 34 10, tab 70
  button "add", 79, 74 108 21 8, disable tab 70
  text "active message(s)", 81, 5 121 50 8, tab 70
  box "activate on", 87, 16 38 42 82, tab 70
  button "remove", 86, 4 161 21 8, disable tab 70
  check "channel", 91, 71 130 34 10, tab 70
  check "notice", 93, 71 139 34 10, tab 70
  check "query", 94, 71 148 26 10, tab 70
  box "send via:", 95, 65 123 42 38, tab 70
  check "enable automated", 97, 7 16 58 10, tab 70
  check "active when closed", 100, 7 25 58 10, tab 70
  list 22, 73 24 74 82, sort size hsbar
  link "team-nexgen.com", 61, 10 174 45 8
  box "catagory", 69, 109 109 42 74
  check "support", 62, 113 117 34 10
  check "comedy", 63, 113 126 34 10
  check "misc", 68, 113 171 26 10
  check "rules", 67, 113 162 26 10
  check "love", 66, 113 153 26 10
  check "insults", 65, 113 144 34 10
  check "hello/bye", 64, 113 135 34 10
  text "select message", 83, 74 16 37 8
  button "+", 84, 72 128 5 0
}
on *:dialog:message.stud:init:*:{
  chcount
  msg.list
  active.msg.list 
  did -o message.stud 96 1 %ascbc
  if ($_vr(message.stud,nick) == on) { did -c message.stud 36 | did -e message.stud 15,31 }
  did -c message.stud 40 | _vw message.stud send channel
  if ($_vr(message.stud,cat) == support) { did -c message.stud 42,62 } 
  elseif ($_vr(message.stud,cat) == comedy) { did -c message.stud 43,63 } 
  elseif ($_vr(message.stud,cat) == greet) { did -c message.stud 44,64 } 
  elseif ($_vr(message.stud,cat) == insult) { did -c message.stud 45,65 } 
  elseif ($_vr(message.stud,cat) == love) { did -c message.stud 46,66 } 
  elseif ($_vr(message.stud,cat) == rules) { did -c message.stud 47,67 } 
  elseif ($_vr(message.stud,cat) == misc) { did -c message.stud 49,68 } 
  elseif  ($_vr(message.stud,cat) == $null) { _vw message.stud cat misc | did -c message.stud 49,68 }
  if ($_vr(message.stud,via) == channel) { did -c message.stud 91 }
  elseif ($_vr(message.stud,via) == notice) { did -c message.stud 93 }
  elseif ($_vr(message.stud,via) == query) { did -c message.stud 94 }
  if ($_vr(message.stud,autoswitch) == on) { did -c message.stud 97 }
  if ($_vr(message.stud,ref) == on) { did -c message.stud 1 }
  if ($_vr(message.stud,act) == kick) { did -c message.stud 78 }
  elseif ($_vr(message.stud,act) == join) { did -c message.stud 72 }
  elseif ($_vr(message.stud,act) == part) { did -c message.stud 73 }
  elseif ($_vr(message.stud,act) == op) { did -c message.stud 74 }
  elseif ($_vr(message.stud,act) == deop) { did -c message.stud 75 }
  elseif ($_vr(message.stud,act) == voice) { did -c message.stud 76 }
  elseif ($_vr(message.stud,act) == devoice) { did -c message.stud 77 }
  if ($_vr(message.stud,s.active) == on) { did -c message.stud 100 }
  if ($_vr(message.stud,ontop) == on) { did -c message.stud 101 }
  if ($_vr(message.stud,logo) == on) { did -c message.stud 102 }
  elseif ($_vr(message.stud,logo) == $null) { _vw message.stud logo on | did -c message.stud 102 }

  did -z message.stud 71,22
}
on *:dialog:message.stud:edit:*:{
  if ($did == 7) { if ($did(25) != $null) { did -e message.stud 8,35 } }
  if ($did == 25) {
    if ($did(25) != $null) { did -e message.stud 37,98 } 
    if ($did(25) == $null) { did -b message.stud 37,98 }
  }
}
on *:dialog:message.stud:dclick:*:{
  if ($did == 22) { msg.list }
  if ($did == 15) { _ch.count }
}
on *:dialog:message.stud:sclick:*:{
  if ($did == 13) { did -v message.stud 62,63,64,65,66,67,68,69 } 
  if ($did == 14) { did -h message.stud 62,63,64,65,66,67,68,69 } 
  if ($did == 70) { did -v message.stud 62,63,64,65,66,67,68,69 } 
  if ($did == 15) { 
    if ($did(15,$did(15).sel) == $null) && ($did(22,$did(22).sel) != $null) && ($_vr(message.stud,nick) != on) { did -e message.stud 21 }
    elseif ($did(15,$did(15).sel) != $null) && ($did(22,$did(22).sel) != $null) && ($_vr(message.stud,nick) == on) { did -e message.stud 21 }
  }
  if ($did == 22) { 
    did -b message.stud 37,98  
    did -e message.stud 79  
    if ($did(15,$did(15).sel) == $null) && ($did(22,$did(22).sel) != $null) && ($_vr(message.stud,nick) != on) { did -e message.stud 21 }
    elseif ($did(15,$did(15).sel) != $null) && ($did(22,$did(22).sel) != $null) && ($_vr(message.stud,nick) == on) { did -e message.stud 21 }
    set %rtto $did(22,$did(22).sel) | did -o message.stud 52 1 $lines($msg.dir $+ %rtto) | did -b message.stud 8,35 | did -r message.stud 7,25 | did -h message.stud 54
    if ($lines($msg.dir $+ %rtto) <= 1) { did -e message.stud 7,25,11,24,50,51 }
    elseif ($lines($msg.dir $+ %rtto) >= 2) { did -e message.stud 11,24,50,51 | did -f message.stud 21 }  
  }
  if ($did == 8) { 
    set %ms.label " $+ $msg.dir $+ $did(message.stud,25,1).text $+ " | mkdir $msg.dir 
    if ($_vr(message.stud,multiline) == on) { write %ms.label $did(message.stud,7,1).text }
    else { write -c %ms.label | write %ms.label $did(message.stud,7,1).text }
    did -r message.stud 7,25,52 | msg.list | unset %ms.label | _vrem message.stud multiline | did -h message.stud 54 | did -b message.stud 51,8,35
  }
  if ($did == 21) { 
    var %uio = $read($msg.dir $+ %rtto) 
    var %t = $remove($did(15,$did(15).sel),@,+) 
    if ($_vr(message.stud,send) == notice) && ($_vr(message.stud,nick) == on) { notice %t %uio }
    elseif ($_vr(message.stud,send) == notice) && ($_vr(message.stud,nick) != on) { notice %ascbc %uio $msg.stud.logo }
    elseif ($_vr(message.stud,send) == query) { msg %t %uio $msg.stud.logo }
    elseif ($_vr(message.stud,send) == channel) && ($_vr(message.stud,nick) != on) { msg %ascbc %uio $msg.stud.logo }
    elseif ($_vr(message.stud,send) == channel) { msg %ascbc %t $+ , %uio $msg.stud.logo } 
  }
  if ($did == 24) { 
    if ($lines($msg.dir $+ %rtto) <= 1) { var %uio = $read($msg.dir $+ %rtto) | did -o message.stud 7 1 %uio | did -o message.stud 25 1 $remove(%rtto,.txt) | did -ev message.stud 8,35,7,25,54 }
    elseif ($lines($msg.dir $+ %rtto) >= 2) { run notepad " $+ $msg.dir $+ %rtto $+ " | did -re message.stud 7,25 }  
  }  
  if ($did == 35) { did -r message.stud 7,25 }
  if ($did == 11) { set  %ms.remove " $+ $msg.dir $+ %rtto $+ " | msg.stud.del | did -r message.stud 52 }
  if ($did == 36) { 
    if ($_vr(message.stud,nick) == on) { _vw message.stud nick off | did -b message.stud 15,31,39 | did -u message.stud 39,38 | did -c message.stud 40 | _vw message.stud send channel }
    else { _vw message.stud nick on | did -c message.stud 36 | did -e message.stud 15,31,39 }
  }
  if ($did == 37) { if ($did(25,$did(25).text) != $null) { .rename " $+ $msg.dir $+ %rtto $+ " " $+ $msg.dir $+ $did(message.stud,25,1).text $+ " | .timer -m 1 1 msg.list } }
  if ($did == 38) { if ($did(message.stud,38).state == 1) { _vw message.stud send notice } }
  if ($did == 39) { if ($did(message.stud,39).state == 1) { _vw message.stud send query } }
  if ($did == 40) { if ($did(message.stud,40).state == 1) { _vw message.stud send channel } }
  if ($did == 42) { if ($did(message.stud,42).state == 1) { _vw message.stud cat support | did -c message.stud 62 | did -u message.stud 63,64,65,66,67,68 | msg.list } }
  if ($did == 43) { if ($did(message.stud,43).state == 1) { _vw message.stud cat comedy | did -c message.stud 63 | did -u message.stud 62,64,65,66,67,68 | msg.list } }
  if ($did == 44) { if ($did(message.stud,44).state == 1) { _vw message.stud cat greet | did -c message.stud 64 | did -u message.stud 63,62,65,66,67,68 | msg.list } }
  if ($did == 45) { if ($did(message.stud,45).state == 1) { _vw message.stud cat insult | did -c message.stud 65 | did -u message.stud 63,64,62,66,67,68 | msg.list } }
  if ($did == 46) { if ($did(message.stud,46).state == 1) { _vw message.stud cat love | did -c message.stud 66 | did -u message.stud 63,64,65,62,67,68 | msg.list } }
  if ($did == 47) { if ($did(message.stud,47).state == 1) { _vw message.stud cat rules | did -c message.stud 67 | did -u message.stud 63,64,65,66,62,68 | msg.list } }
  if ($did == 49) { if ($did(message.stud,49).state == 1) { _vw message.stud cat misc | did -c message.stud 68 | did -u message.stud 63,64,65,66,67,62 | msg.list } }
  if ($did == 50) { run notepad " $+ $msg.dir $+ %rtto $+ " }
  if ($did == 51) { msg.stud.erase }
  if ($did == 1) { 
    if ($_vr(message.stud,ref) == on) { _vw message.stud ref off }
    else { _vw message.stud ref on | did -c message.stud 1 }
  }
  if ($did == 54) { 
    if ($_vr(message.stud,multiline) == on) { _vw message.stud multiline off }
    else { _vw message.stud multiline on | did -c message.stud 54 | did -r message.stud 7 }
  }
  if ($did == 61) { run http://team-nexgen.com }
  if ($did == 62) { _vw message.stud cat support | did -c message.stud 42 | did -u message.stud 43,63,44,64,45,65,46,66,47,67,49,68 | msg.list | check } 
  if ($did == 63) { _vw message.stud cat comedy | did -c message.stud 43 | did -u message.stud 42,62,44,64,45,65,46,66,47,67,49,68 | msg.list | check } 
  if ($did == 64) { _vw message.stud cat greet | did -c message.stud 44 | did -u message.stud 43,63,42,62,45,65,46,66,47,67,49,68 | msg.list | check } 
  if ($did == 65) { _vw message.stud cat insult | did -c message.stud 45 | did -u message.stud 43,63,44,64,42,62,46,66,47,67,49,68 | msg.list | check } 
  if ($did == 66) { _vw message.stud cat love | did -c message.stud 46 | did -u message.stud 43,63,44,64,45,65,42,62,47,67,49,68 | msg.list | check } 
  if ($did == 67) { _vw message.stud cat rules | did -c message.stud 47 | did -u message.stud 43,63,44,64,45,65,46,66,42,63,49,68 | msg.list | check } 
  if ($did == 68) { _vw message.stud cat misc | did -c message.stud 49 | did -u message.stud 43,63,44,64,45,65,46,66,47,67,42,62 | msg.list | check } 
  if ($did == 71) { did -e message.stud 86 }
  if ($did == 72) { _vw message.stud act join | active.msg.list }
  if ($did == 73) { _vw message.stud act part | active.msg.list }
  if ($did == 74) { _vw message.stud act op | active.msg.list }
  if ($did == 75) { _vw message.stud act deop | active.msg.list }
  if ($did == 76) { _vw message.stud act voice | active.msg.list }
  if ($did == 77) { _vw message.stud act devoice | active.msg.list }
  if ($did == 78) { _vw message.stud act kick | active.msg.list }
  if ($did == 79) { 
    did -a message.stud 71 %rtto 
    set %ms.label2 " $+ $msg.dir2 $+ $act $+ " | mkdir " $+ $msg.dir2 $+ " 
    write %ms.label2 " $+ $msg.dir $+ $did(22,$did(22).sel) $+ " 
  }
  if ($did == 86) { var %ii = $did(71,$did(71).sel) | var %uif = $didwm(message.stud,71,%ii) | write -dl $+ %uif $msg.dir2 $+ $act | did -b message.stud 86) | active.msg.list }
  if ($did == 91) { _vw message.stud via channel | did -u message.stud 93,94 | check }
  if ($did == 93) { _vw message.stud via notice | did -u message.stud 91,94 | check }
  if ($did == 94) { _vw message.stud via query | did -u message.stud 93,91 | check }
  if ($did == 97) {
    if ($_vr(message.stud,autoswitch) == on) { _vw message.stud autoswitch off }
    else { _vw message.stud autoswitch on | did -c message.stud 97 }
  }
  if ($did == 98) { write -c " $+ $msg.dir $+ $did(message.stud,25,1).text $+ " | run notepad.exe " $+ $msg.dir  $+ $did(message.stud,25,1).text $+ " | msg.list }
  if ($did == 99) { msg.list }
  if ($did == 100) { 
    if ($_vr(message.stud,s.active) == on) { _vw message.stud s.active off }
    else { _vw message.stud s.active on | did -c message.stud 100 }
  }
  if ($did == 101) { 
    if ($_vr(message.stud,ontop) == on) { _vw message.stud ontop off | dialog -x message.stud message.stud | .timer -m 1 1 message.stud }
    else { _vw message.stud ontop on | did -c message.stud 101 | dialog -x message.stud message.stud | .timer -m 1 1 message.stud }
  }
  if ($did == 102) { 
    if ($_vr(message.stud,logo) == on) { _vw message.stud logo off }
    else { _vw message.stud logo on | did -c message.stud 102 }
  }
}
alias -l act {
  return $_vr(message.stud,act)
}
alias -l check {
  did -c message.stud $did
}
alias -l msg.dir {
  return $mircdirmsgstud $+ \ $+ $_vr(message.stud,cat) $+ \
}
alias -l msg.dir2 {
  return $mircdirmsgstud $+ \ 
}
alias -l msg.list {
  did -e message.stud 7,25 
  did -b message.stud 21,11,24,50,51,37
  did -r message.stud 22,52,25 
  var %f = 0
  :loop 
  inc %f 
  var %fs =  $nopath($findfile($msg.dir,*.*, %f ,1))
  if (%fs != $null) { did -a message.stud 22  %fs | goto loop }
  else return
}
alias -l active.msg.list {
  var %tot = $msg.dir2 $+ $act
  did -r message.stud 71 
  var %tyt = $lines(%tot)
  var %f1 = 0
  :loop 
  inc %f1 
  ;  var %f2s =  $read(%tot,%f1) 
  if (%f1 <= %tyt) { did -a message.stud 71 $nopath($read(%tot,%f1)) | goto loop }
  else return
}
alias  _ch.count {
  if ($_vr(message.stud,ref) == on) { 
    if ($dialog(message.stud) != $null) { did -r message.stud 15 1 }
    if ($_vr(message.stud,nick) == on) && ($dialog(message.stud) != $null) { did -b message.stud 21 } 
    set %i22 $nick(%ascbc,0,a)
    :loop
    if ($dialog(message.stud) != $null) { did -i message.stud 15 1 $_ov $+ $nick(%ascbc,%i22) }
    if (%i22 <= 0) goto end
    else dec %i22 1 | goto loop
    :end
    if ($dialog(message.stud) != $null) { did -d message.stud 15 1 }
    unset %i22
  }
}
alias -l chcount {
  if ($dialog(message.stud) != $null) { did -r message.stud 15 1 }
  if ($_vr(message.stud,nick) == on) && ($dialog(message.stud) != $null) { did -b message.stud 21 } 
  set %i22 $nick(%ascbc,0,a)
  :loop
  if ($dialog(message.stud) != $null) { did -i message.stud 15 1 $_ov $+ $nick(%ascbc,%i22) }
  if (%i22 <= 0) goto end
  else dec %i22 1 | goto loop
  :end
  if ($dialog(message.stud) != $null) { did -d message.stud 15 1 }
  unset %i22
}
alias -l _ov {
  if ($nick(%ascbc,%i22) isop %ascbc) return $chr(64) 
  elseif  ($nick(%ascbc,%i22) isvoice %ascbc) return $chr(43) 
  elseif  ($nick(%ascbc,%i22) ishop %ascbc) return $chr(37) 
  else return $chr(160)
}
alias -l msg.stud.del { set -q %del $iif($$?!="delete this message?" == $true,yes,no) | msg.del }
alias -l msg.del {
  if (%del == yes) { .remove %ms.remove | unset %del | .timer -m 1 1 msg.list | unset %ms.remove | beep } 
  else { unset %del | unset %ms.remove }
}
alias -l msg.stud.erase { set -q %del $iif($$?!="erase all messages in label?" == $true,yes,no) | msg.erase }
alias -l msg.erase {
  var %msg.erase = $msg.dir $+ %rtto
  if (%del == yes) { write -c  %msg.erase | unset %del | .timer -m 1 1 msg.list | beep } 
  else { unset %del }
}
alias -l msg.stud.logo { 
  if ($_vr(message.stud,logo) == on) { return 14:.:4message studio14:.: }
  else return
}
alias -l c.act {
  if ($1 = 1) { return kick }
  elseif ($1 = 2) { return join }
  elseif ($1 = 3) { return part }
  elseif ($1 = 4) { return op }
  elseif ($1 = 5) { return deop }
  elseif ($1 = 6) { return voice }
  elseif ($1 = 7) { return devoice }
}
alias -l active.send {
  var %l.count = 0
  var %a = 0
  :active
  inc %a 
  if (%a <= 7) { var %c.act = $c.act(%a)
    if ($_vr(message.stud,resp) == %c.act) { goto next } 
    else goto active  
  }
  else return
  :next
  inc %l.count 
  var %labels = $lines($msg.dir2 $+ %c.act)
  if (%labels == $null) { goto active }
  var %mdir = $msg.dir2 $+ %c.act
  var %c.label = $read($read(%mdir))
  if (%c.label != $null) { 
    if ($_vr(message.stud,via) ==  channel) { msg %ascbc %c.label $msg.stud.logo }
    elseif ($_vr(message.stud,via) ==  notice) { notice %ms.nick %c.label $msg.stud.logo }
    elseif ($_vr(message.stud,via) ==  query) { query %ms.nick %c.label $msg.stud.logo }
    goto active 
  }
  else goto active
}
on *:join:%ascbc:{
  if ($dialog(message.stud) != $null) { .timer 1 1 _ch.count }
  if ($me != $nick) && ($_vr(message.stud,s.active) == on) { %ms.nick = $nick | _vw message.stud resp join | active.send }
}
on *:nick:if ($dialog(message.stud) != $null) .timer 1 1 _ch.count
on *:part:%ascbc:{
  if ($dialog(message.stud) != $null) { _ch.count } 
  if ($me != $nick) && ($_vr(message.stud,s.active) == on) { %ms.nick = $nick | _vw message.stud resp part | active.send }
}
on *:quit:if ($dialog(message.stud) != $null) _ch.count 
on *:KICK:%ascbc:{
  if ($dialog(message.stud) != $null) { _ch.count }
  if ($me != $knick) && ($_vr(message.stud,s.active) == on) { %ms.nick = $knick | _vw message.stud resp kick | active.send }
}
on *:op:%ascbc:{
  if ($dialog(message.stud) != $null) { _ch.count } 
  if ($me != $opnick) && ($_vr(message.stud,s.active) == on) { _vw message.stud resp op | set %ms.nick $opnick | active.send }
}
on *:deop:%ascbc:{
  if ($dialog(message.stud) != $null) { _ch.count }
  if ($me != $opnick) && ($_vr(message.stud,s.active) == on) { _vw message.stud resp deop |  set %ms.nick $opnick | active.send }
}
on *:voice:%ascbc:{
  if ($dialog(message.stud) != $null) { _ch.count } 
  if ($me != $vnick) && ($_vr(message.stud,s.active) == on) { _vw message.stud resp voice | active.send | set %ms.nick $vnick }
}
on *:devoice:%ascbc:{
  if ($dialog(message.stud) != $null) { _ch.count } 
  if ($me != $vnick) && ($_vr(message.stud,s.active) == on) { set %ms.nick $vnick | _vw message.stud resp devoice | active.send }
}
