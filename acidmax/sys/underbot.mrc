;Underbot 2.04
;Team Nexgen 2001 by KnightFal
;team-nexgen.com

on *:load:{ echo -a  4TEAM NEXGEN'S UNDERBOT v2.04 | echo -a  4Please type: /underbot to begin. }
menu channel {
  $iif($network == undernet,undernet x):underbot
}
menu status {
  $iif($network == undernet,undernet x)
  .recovery
  ..unban yourself:msg x@channels.undernet.org unban $$?="channel?" $me
  ..invite yourself:msg x@channels.undernet.org invite $$?="channel?" $me
  ..clear mode:msg x@channels.undernet.org clearmode $$?="channel?"
}
on *:connect: if ($network == undernet) { .enable #undernet } | else .disable #undernet
alias -l ub {
  if (x ison %cbc) { return x@Channels.undernet.org }
  else unset %cbc | return
}
alias -l u-net {
  if (x ison $chan) { set %u-net  x@channels.undernet.org }
  else { $ae 0,4ERROR|0,14Unable to process request as X is not on $chan  | beep | halt } 
}
alias underbot { 
  if ($version < 5.91) { echo -s 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($network == undernet) { 
    if ($chan == $active) set %cbc $chan
    else unset %cbc 
    if ($ub != $null) { 
      if ($chan != $active) { underbot.chan | halt } 
    } 
    if ($dialog(underbot) == $null) { dialog -md underbot underbot }
  }
}
dialog underbot {
  title "undernet x control console v2.04"
  size -1 -1 192 200
  option dbu
  edit "", 4, 5 3 115 11, read autohs
  list 5, 5 17 62 125, extsel
  button "close", 201, 84 182 25 11, default ok cancel
  button "login", 24, 5 153 22 10
  edit "", 26, 30 153 40 11, pass autohs
  check "login w/ops", 27, 5 143 40 7
  button "chan/pass", 83, 5 168 37 10
  button "refresh", 86, 44 143 23 7
  tab "controls", 3, 72 15 108 135
  button "op", 6, 75 33 22 8, disable tab 3
  button "deop", 7, 75 43 22 8, disable tab 3
  button "add user", 69, 140 33 38 8, disable tab 3
  button "remove user", 70, 140 43 38 8, disable tab 3
  button "kick", 8, 75 79 22 8, disable tab 3
  edit "", 20, 102 78 65 11, disable tab 3 autohs
  box "ban central", 66, 82 91 90 46, tab 3
  box "level", 63, 144 99 26 22, tab 3
  box "hours ban", 62, 107 99 36 22, tab 3
  button "ban", 9, 83 108 22 10, disable tab 3
  edit "", 21, 124 106 17 11, disable tab 3 autohs
  combo 22, 146 106 22 43, disable tab 3 edit drop
  edit "", 23, 107 121 64 11, disable tab 3 autohs
  button "-", 60, 109 109 5 5, disable tab 3
  button "+", 61, 117 109 5 5, disable tab 3
  text "reason", 64, 85 122 20 10, tab 3
  button "Input", 67, 83 99 22 7, tab 3
  button "unban", 68, 83 138 22 10, disable tab 3
  button "voice", 11, 75 54 22 8, disable tab 3
  button "devoice", 12, 75 64 22 8, disable tab 3
  text "kick reason", 29, 102 70 28 8, tab 3
  button "suspend", 30, 140 54 38 8, disable tab 3
  button "unsuspend", 31, 140 65 38 8, disable tab 3
  box "", 78, 100 31 37 20, tab 3
  button "yes", 76, 103 36 12 7, disable tab 3
  text "auto-op", 79, 109 44 20 7, tab 3
  button "no", 77, 123 36 12 7, disable tab 3
  button "yes", 41, 103 52 12 7, disable tab 3
  button "no", 40, 123 52 12 7, disable tab 3
  text "auto-voice", 38, 105 60 28 7, tab 3
  box "", 39, 100 47 37 20, tab 3
  tab "other", 10
  box "modify user info", 82, 78 62 94 31, tab 10
  button "level", 74, 82 69 22 10, disable tab 10
  combo 75, 106 69 22 60, disable tab 10 edit drop
  button "update host", 80, 131 67 37 10, disable tab 10
  button "remove pass", 81, 132 80 37 10, disable tab 10
  button "new pass", 85, 81 81 26 9, disable tab 10
  button "info", 13, 107 33 30 10, tab 10
  button "ban list", 17, 106 47 31 9, tab 10
  button "topic", 14, 77 119 22 8, tab 10
  edit "", 15, 104 118 74 10, tab 10 multi return autohs
  button "status", 36, 74 47 30 10, tab 10
  button "access", 37, 74 33 30 10, tab 10
  tab "about", 42
  text "Group: Team Nexgen", 43, 84 59 51 8, tab 42
  text "Author: KnightFal", 44, 84 67 41 8, tab 42
  text "Email: guide_X@live.com", 45, 84 75 83 8, tab 42
  text "Addon: underbot", 46, 84 91 40 8, tab 42
  text "Version: 2.04", 47, 84 99 68 8, tab 42
  text "Home: team-nexgen.com", 48, 84 83 73 8, tab 42
  text "Released: 9-29-2001", 49, 84 107 50 8, tab 42
  box "", 50, 78 51 98 74, tab 42
  edit "", 18, 72 167 90 10, multi autohs
  text "command line", 19, 72 159 33 8
  button "send", 33, 164 167 21 10
  icon 35, 167 1 22 18}
}
alias ch.count {
  if ($dialog(underbot) != $null) { did -r underbot 5 1 }
  set %i $nick(%cbc,0,a)
  :loop
  if ($dialog(underbot) != $null) { did -i underbot 5 1 $ov $+ $nick(%cbc,%i) }
  if (%i <= 0) goto end
  else dec %i 1 | goto loop
  :end
  if ($dialog(underbot) != $null) { did -d underbot 5 1 }
  unset %i
}
alias ov {
  if ($nick(%cbc,%i) isop %cbc) return @ 
  elseif  ($nick(%cbc,%i) isvo %cbc) return +  
  else return $chr(160)
}

on *:dialog:underbot:init:*:{ 
  did -o underbot 21 1 $_vr(underbot,hoursban)
  did -o underbot 26 1 $chachk
  if ($shortfn($findfile($mircdir,help.ico,1)) != $null) did -g underbot 35 $shortfn($findfile($mircdir,help.ico,1))
  did -a underbot 22,75 75 | did -a underbot 22,75 100 | did -a underbot 22,75 200 | did -a underbot 22,75 400 | did -a underbot 22,75 450 
  if ($_vr(underbot,levelbanset) != $null) { did -c underbot 22 $_vr(underbot,levelbanset) } | else did -c underbot 22 1
  if ($_vr(underbot,modlevelset) != $null) { did -c underbot 75 $_vr(underbot,modlevelset) } | else did -c underbot 75 1
  if ($_vr(underbot,loginop) == 1) did -c underbot 27 
  ch.count
   if (x !ison %cbc) { did -b underbot 5,14,15,18,33,36,37,13,37,67,80,6,7,8,9,24,85,81,74,76,77,75,69,70,67,68,60,61,22,4,20,23,21,26,5 }

}
alias rc {
  var %i = $len($1)
  dec %i 1
  return  $right($1,%i)
}
on *:dialog:underbot:sclick:*:{ 
  if ($did == 5) { did -e underbot 6,7,8,9,11,12,20,21,22,23,30,31,40,41,60,61,68,69,70,74,75,76,77,80,85,81 | did -o underbot 4 1 $address($rc($did(5,$did(5).sel)),1) }
  if ($did == 6) { msg $ub op %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 7) { msg $ub deop %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 8) { msg $ub kick %cbc $rc($did(5,$did(5).sel)) $did(underbot,20).text | halt }
  if ($did == 9) { msg $ub ban %cbc $address($rc($did(5,$did(5).sel)),3) $_vr(underbot,hoursban) $_vr(underbot,levelban) $did(underbot,23).text | halt }
  if ($did == 11) { .msg $ub voice %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 12) { .msg $ub devoice %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 13) { .msg $ub info %cbc | halt }
  if ($did == 14) { msg $ub topic %cbc $did(underbot,15).text | halt }
  if ($did == 17) { .msg $ub banlist %cbc | halt }
  if ($did == 30) { msg $ub suspend %cbc $rc($did(5,$did(5).sel)) 5 d | halt }
  if ($did == 31) { msg $ub unsuspend %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 33) { msg $ub $did(underbot,18).text | halt }
  if ($did == 36) { .msg $ub status %cbc | halt }
  if ($did == 37) { msg $ub access %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 35) { run $findfile($mircdir,xcmds.hlp,1) | halt }
  if ($did == 40) { msg $ub modinfo %cbc automode $rc($did(5,$did(5).sel)) none | halt } 
  if ($did == 41) { msg $ub modinfo %cbc automode $rc($did(5,$did(5).sel)) voice | halt } 
  if ($did == 60) { dec %hoursban 1 | did -o underbot 21 1 %hoursban | _vw underbot hoursban %hoursban | halt }
  if ($did == 61) { inc %hoursban 1 | did -o underbot 21 1 %hoursban | _vw underbot hoursban %hoursban | halt }
  if ($did == 67) { underbot.input | halt }
  if ($did == 68) { underbot.unban | halt }
  if ($did == 69) { set %u.add $remove($did(5,$did(5).sel),@,+, ) | set %u.addn $rc($did(5,$did(5).sel)) | underbot.add | halt }
  if ($did == 70) { set %u.remove $address($rc($did(5,$did(5).sel)),3) | underbot.remove | halt }
  if ($did == 71) { set %u.suspend $rc($did(5,$did(5).sel)) | underbot.suspend | halt }
  if ($did == 73) { msg $ub unsuspend %cbc $rc($did(5,$did(5).sel)) | halt }
  if ($did == 74) { msg $ub modinfo %cbc access $remove($did(5,$did(5).sel),@,+, ) $did(underbot,75).text | halt } 
  if ($did == 76) { msg $ub modinfo %cbc automode $rc($did(5,$did(5).sel)) op | halt } 
  if ($did == 77) { msg $ub modinfo %cbc automode $rc($did(5,$did(5).sel)) none | halt } 
  if ($did == 80) { msg $ub modinfo %cbc match $rc($did(5,$did(5).sel)) $address($rc($did(5,$did(5).sel)),3) | halt } 
  if ($did == 81) { msg $ub modinfo %cbc rempass $address($rc($did(5,$did(5).sel)),3) | halt } 
  if ($did == 84) {
    if ($did(5,$did(5).sel) != $null) { msg $ub access %cbc $remove($did(5,$did(5).sel),@,+, ) } 
    else underbot.access
  }
  if ($did == 85) { underbot.newpass }
  if ($did == 86) { ch.count }
  if ($did == 87) { run $findfile($mircdir,xcmds.hlp,1) }
  if ($did == 22) {
    if ($did(underbot,$did,1).sel == 1) { _vw underbot levelban $did(22,$did(22).sel) | _vw underbot levelbanset 1 } 
    if ($did(underbot,$did,1).sel == 2) { _vw underbot levelban $did(22,$did(22).sel) | _vw underbot levelbanset 2 } 
    if ($did(underbot,$did,1).sel == 3) { _vw underbot levelban $did(22,$did(22).sel) | _vw underbot levelbanset 3 } 
    if ($did(underbot,$did,1).sel == 4) { _vw underbot levelban $did(22,$did(22).sel) | _vw underbot levelbanset 4 } 
    if ($did(underbot,$did,1).sel == 5) { _vw underbot levelban $did(22,$did(22).sel) | _vw underbot levelbanset 5 } 
    if ($did(underbot,$did,1).sel == 6) { _vw underbot levelban $did(22,$did(22).sel) | _vw underbot levelbanset 6 } 
  }
  if ($did == 24) {
    msg $ub login $usernx $chachk | if ($_vr(underbot,loginop) == on) .timer 1 2 msg $ub op %cbc $me | halt
  }
  if ($did == 27) _vw underbot loginop $did($did).state
  if ($did == 83) wxchanpass
}
on *:dialog:underbot:edit:*:{
  if ($did == 21) { if ($did(underbot,21).text != $null) { _vw underbot hoursban $did(underbot,21).text } }
  if ($did == 26) {
    if ($did(underbot,26).text != $null) { 
      if ($_vr(underbot,chanw1) == %cbc) { _vw underbot passw1 $did(underbot,26).text }
      elseif ($_vr(underbot,chanw2) == %cbc) { _vw underbot passw2 $did(underbot,26).text }
      elseif ($_vr(underbot,chanw3) == %cbc) { _vw underbot passw3 $did(underbot,26).text }
      elseif ($_vr(underbot,chanw4) == %cbc) { _vw underbot passw4 $did(underbot,26).text }
      elseif ($_vr(underbot,chanw5) == %cbc) { _vw underbot passw5 $did(underbot,26).text }
      elseif (x ison %cbc) && ($_vr(underbot,chanw1) == $null) { _vw underbot chanw1 %cbc | _vw underbot passw1 $did(underbot,26).text }
      elseif (x ison %cbc) && ($_vr(underbot,chanw2) == $null) { _vw underbot chanw2 %cbc | _vw underbot passw2 $did(underbot,26).text }
      elseif (x ison %cbc) && ($_vr(underbot,chanw3) == $null) { _vw underbot chanw3 %cbc | _vw underbot passw3 $did(underbot,26).text }
      elseif (x ison %cbc) && ($_vr(underbot,chanw4) == $null) { _vw underbot chanw4 %cbc | _vw underbot passw4 $did(underbot,26).text }
      elseif (x ison %cbc) && ($_vr(underbot,chanw5) == $null) { _vw underbot chanw5 %cbc | _vw underbot passw5 $did(underbot,26).text }
    }
  }
}
alias chachk {
  if ($_vr(underbot,chanw1) == %cbc) return $_vr(underbot,passw1)
  elseif ($_vr(underbot,chanw2) == %cbc) return $_vr(underbot,passw2)
  elseif ($_vr(underbot,chanw3) == %cbc) return $_vr(underbot,passw3)
  elseif ($_vr(underbot,chanw4) == %cbc) return $_vr(underbot,passw4)
  elseif ($_vr(underbot,chanw5) == %cbc) return $_vr(underbot,passw5)

  else haltdef 
}
alias usernx {
  if ($_vr(underbot,chanw1) == %cbc) return $_vr(underbot,username1)
  elseif ($_vr(underbot,chanw2) == %cbc) return $_vr(underbot,username2)
  elseif ($_vr(underbot,chanw3) == %cbc) return $_vr(underbot,username3)
  elseif ($_vr(underbot,chanw4) == %cbc) return $_vr(underbot,username4)
  elseif ($_vr(underbot,chanw5) == %cbc) return $_vr(underbot,username5)

  else haltdef 
}

alias underbot.access { if ($dialog(underbot.access) == $null) { dialog -m underbot.access underbot.access }  }
dialog underbot.access {
  title "Enter Nick or Address"
  size -1 -1 200 75
  button "Cancel", 2, 40 40 50 20,cancel
  button "Access", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}
on *:dialog:underbot.access:sclick:*:{
  if ($did == 1) { msg $ub access %cbc $did(underbot.access,3).text | dialog -x underbot.access | halt }
}
alias underbot.input { if ($dialog(underbot.input) == $null) { dialog -m underbot.input underbot.input  }  }
dialog underbot.input {
  title "Enter Nick or Address"
  size -1 -1 200 75
  button "Cancel", 2, 40 40 50 20,cancel
  button "Ban", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}
alias underbot.newpass { if ($dialog(underbot.newpass) == $null) { dialog -m underbot.newpass underbot.newpass }  }
dialog underbot.newpass {
  title "Enter new password"
  size -1 -1 200 75
  button "Cancel", 2, 40 40 50 20,cancel
  button "Apply", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}
on *:dialog:underbot.newpass:sclick:*:{
  if ($did == 1) { msg $ub newpass %cbc $did(underbot.newpass,3).text | dialog -x underbot.newpass | halt }
}
alias underbot.input { if ($dialog(underbot.input) == $null) { dialog -m underbot.input underbot.input  }  }
dialog underbot.input {
  title "Enter nick or address"
  size -1 -1 200 75
  button "CANCEL", 2, 40 40 50 20,cancel
  button "BAN", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}

on *:dialog:underbot.input:sclick:*:{
  if ($did == 1) { msg $ub ban %cbc $did(underbot.input,3).text $_vr(underbot,hoursban) $_vr(underbot,levelban) $did(underbot,23).text | dialog -x underbot.input | halt }
}
alias underbot.unban { if ($dialog(underbot.unban) == $null) { dialog -m underbot.unban underbot.unban  }  }
dialog underbot.unban {
  title "Enter address to unban"
  size -1 -1 200 75
  button "CANCEL", 2, 40 40 50 20,cancel
  button "UNBAN", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}
on *:dialog:underbot.unban:sclick:*:{
  if ($did == 1) { msg $ub unban %cbc $did(underbot.unban,3).text | dialog -x underbot.unban | halt }
}
alias underbot.add { if ($dialog(underbot.add) == $null) { dialog -m underbot.add underbot.add  } } 
dialog underbot.add {
  title "Add User"
  size -1 -1 150 150
  button "Close", 2, 20 120 50 20,cancel
  button "Add", 1, 80 120 50 20,ok
  edit "", 3, 5 10 140 22, autohs
  ;edit "", 21, 60 50 85 22, autohs
  edit "", 25, 35 90 85 22, autohs
  combo 22, 10 50 45 120, drop, edit
  text "Level", 23, 10 35 50 15
  ; text "Password", 24, 60 35 50 15
  text "Nick", 27, 35 75 50 15
}
on *:dialog:underbot.add:sclick:*:{
  if ($did == 1) {
    msg x@channels.undernet.org adduser %cbc $did(underbot.add,3).text $did(underbot.add,22).text | halt  
    else halt
  }

}
on *:dialog:underbot.add:init:*:{ 
  ; did -h underbot.add 3
  ;  set %u.add $address(%u.add,3) 
  did -a underbot.add 22 75 | did -a underbot.add 22 100 | did -a underbot.add 22 200 | did -a underbot.add 22 400 | did -a underbot.add 22 450 
  did -c underbot.add 22 1
  if (%u.addn !ison %cbc) did -v underbot.add 3 | did -o underbot.add 3 1 %u.add
  if (%u.addn ison %cbc) did -o underbot.add 25 1 %u.addn 
  unset %u.addn
}
alias underbot.remove { if ($dialog(underbot.remove) == $null) { dialog -m underbot.remove underbot.remove }  }
dialog underbot.remove {
  title "Enter nick/address"
  size -1 -1 200 75
  button "CANCEL", 2, 40 40 50 20,cancel
  button "REMOVE", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}
on *:dialog:underbot.remove:sclick:*:{
  if ($did == 1) { msg $ub remuser %cbc $did(underbot.remove,3).text | dialog -x underbot.remove | halt }
}
on *:dialog:underbot.remove:init:*:{ 
  did -o underbot.remove 3 1 %u.remove | unset %u.remove
}
alias underbot.suspend { if ($dialog(underbot.suspend) == $null) { dialog -m underbot.suspend underbot.suspend }  }
dialog underbot.suspend {
  title "Enter nick/address"
  size -1 -1 200 120
  button "CANCEL", 2, 40 80 55 20,cancel
  button "SUSPEND", 1, 100 80 65 20,default ok
  edit "", 3, 5 10 188 22, autohs
  button "-", 60, 10 50 10 10
  button "+", 61, 25 50 10 10
  edit "", 21, 40 45 30 22, autohs
  combo 22, 75 45 90 120, drop
}
on *:dialog:underbot.suspend:sclick:*:{
  if ($did == 1) { if ($did(underbot.suspend,3).text != $null) { msg $ub suspend %cbc $did(underbot.suspend,3).text $_vr(underbot,minsuspend) $_vr(underbot,timesuspend) | dialog -x underbot.suspend | halt } }
  if ($did == 60) { dec %minsuspend 1 | did -o underbot.suspend 21 1 %minsuspend | _vw underbot minsuspend %minsuspend | halt }
  if ($did == 61) { inc %minsuspend 1 | did -o underbot.suspend 21 1 %minsuspend | _vw underbot minsuspend %minsuspend | halt }
  if ($did == 22) {
    if ($did(underbot.suspend,$did,1).sel == 1) { _vw underbot timesuspend S } 
    if ($did(underbot.suspend,$did,1).sel == 2) { _vw underbot timesuspend M } 
    if ($did(underbot.suspend,$did,1).sel == 3) { _vw underbot timesuspend H } 
    if ($did(underbot.suspend,$did,1).sel == 4) { _vw underbot timesuspend D } 
  }
}
on *:dialog:underbot.suspend:init:*:{ 
  if (%u.suspend ison %cbc) did -o underbot.suspend 3 1 %u.suspend 
  unset %u.suspend
  _vw underbot timesuspend S
  did -a underbot.suspend 22 Seconds | did -a underbot.suspend 22 Minutes | did -a underbot.suspend 22 Hours | did -a underbot.suspend 22 Days  
  did -c underbot.suspend 22 1
  did -o underbot.suspend 21 1 $_vr(underbot,minsuspend)
}
on *:dialog:underbot.suspend:edit:*:{
  if ($did == 21) { if ($did(underbot,21).text != $null) { _vw underbot minsuspend $did(underbot,21).text } }
}
alias underbot.chan { if ($dialog(underbot.chan) == $null) { dialog -m underbot.chan underbot.chan }  }
dialog underbot.chan {
  title "Enter Channel"
  size -1 -1 200 75
  button "CANCEL", 2, 40 40 50 20,cancel
  button "OK", 1, 100 40 50 20,default ok
  edit "", 3, 5 10 188 22, autohs
}
on *:dialog:underbot.chan:sclick:*:{
  if ($did == 1) { set %cbc $did(underbot.chan,3).text | dialog -m underbot underbot | dialog -x underbot.chan | halt }
}
#undernet  end
;alias upial { set %ial. [ $+ [ $1 ] ] $1 | .who $1 }

on *:join:#: { 
  if (undernet == $network) {
    ;upial $chan 
    updatenl
    if ($me == $nick) {
      if ($dialog(underbot) != $null) .timer 1 1 ch.count 
      if ($chan == $_vr(underbot,chanw1)) {
        if ($_vr(underbot,loginw1) == 1) { .timer -m 1 1 .msg x@channels.undernet.org login $_vr(underbot,username1) $_vr(underbot,passw1) }
        if ($_vr(underbot,opw1) == 1) { .timerw1 1 5 .msg x@channels.undernet.org op $_vr(underbot,chanw1) $me }
      } 
      if ($chan == $_vr(underbot,chanw2)) {
        if ($_vr(underbot,loginw2) == 1) { .timer -m 1 1 .msg x@channels.undernet.org login $_vr(underbot,username2) $_vr(underbot,passw2) }
        if ($_vr(underbot,opw2) == 1) { .timerw2 1 5 .msg x@channels.undernet.org op $_vr(underbot,chanw2) $me }
      } 
      if ($chan == $_vr(underbot,chanw3)) {
        if ($_vr(underbot,loginw3) == 1) { .timer -m 1 1 .msg x@channels.undernet.org login $_vr(underbot,username3) $_vr(underbot,passw3) }
        if ($_vr(underbot,opw3) == 1) { .timerw3 1 5 .msg x@channels.undernet.org op $_vr(underbot,chanw3) $me }
      } 
      if ($chan == $_vr(underbot,chanw4)) {
        if ($_vr(underbot,loginw4) == 1) { .timer -m 1 1 .msg x@channels.undernet.org login $_vr(underbot,username4) $_vr(underbot,passw4) }
        if ($_vr(underbot,opw4) == 1) { .timerw4 15 .msg x@channels.undernet.org op $_vr(underbot,chanw4) $me }
      } 
      if ($chan == $_vr(underbot,chanw5)) {
        if ($_vr(underbot,loginw5) == 1) { .timer -m 1 1 .msg x@channels.undernet.org login $_vr(underbot,username5) $_vr(underbot,passw5) }
        if ($_vr(underbot,opw5) == 1) { .timerw5 1 5 .msg x@channels.undernet.org op $_vr(underbot,chanw5) $me }
      } 
    }
  }
}


alias chan.xw {
  did -r xw.chansetup 5 
  var %channum = 0
  :findchan
  inc %channum 1
  var %chan = $chan(%channum)
  if (%chan == $null) { goto end }
  did -i xw.chansetup 5 1 %chan
  goto findchan  
  :end
  did -c xw.chansetup 5 1 
}
alias wxchanpass {
  if ($dialog(wxchanpass) == $null) { dialog -m wxchanpass wxchanpass }
}
; dialog table generated by Dialog Studio

dialog wxchanpass {
  title "x channel password setup"
  size -1 -1 232 84
  option dbu
  button "OK", 3, 92 66 30 10, ok
  text "Username", 200, 25 2 40 6
  text "Channel", 4, 78 2 20 6
  text "Password", 5, 131 2 23 6
  text "AL", 6, 4 2 10 6
  text "AO", 7, 14 2 10 6
  text "AL = Auto Login", 8, 181 17 40 7
  text "AO = Auto Op", 9, 181 27 40 7
  check "", 20, 4 10 10 10
  check "", 21, 14 10 10 10, disable
  edit "", 40, 24 10 50 10, autohs
  edit "", 22, 77 10 50 10, autohs
  edit "", 23, 130 10 40 10, pass autohs
  check "", 24, 4 20 10 10
  check "", 25, 14 20 10 10, disable
  edit "", 41, 24 20 50 10, autohs
  edit "", 26, 77 20 50 10
  edit "", 27, 130 20 40 10, pass autohs
  check "", 28, 4 30 10 10
  check "", 29, 14 30 10 10, disable
  edit "", 42, 24 30 50 10, autohs
  edit "", 30, 77 30 50 10, autohs
  edit "", 31, 130 30 40 10, pass autohs
  check "", 32, 4 40 10 10
  check "", 33, 14 40 10 10, disable
  edit "", 43, 24 40 50 10, autohs
  edit "", 34, 77 40 50 10, autohs
  edit "", 35, 130 40 40 10, pass autohs
  check "", 36, 4 50 10 10
  check "", 37, 14 50 10 10, disable
  edit "", 44, 24 50 50 10, autohs
  edit "", 38, 77 50 50 10, autohs
  edit "", 39, 130 50 40 10, pass autohs
  box "", 1, 176 9 50 30
}

on *:dialog:wxchanpass:init:*:{
  if ($_vr(underbot,loginw1) == 1) { did -c wxchanpass 20 | did -e wxchanpass 21 }
  if ($_vr(underbot,opw1) == 1) did -c wxchanpass 21
  if ($_vr(underbot,loginw2) == 1) { did -c wxchanpass 24 | did -e wxchanpass 25 }
  if ($_vr(underbot,opw2) == 1) did -c wxchanpass 25 
  if ($_vr(underbot,loginw3) == 1) { did -c wxchanpass 28 | did -e wxchanpass 29 }
  if ($_vr(underbot,opw3) == 1) did -c wxchanpass 29
  if ($_vr(underbot,loginw4) == 1) { did -c wxchanpass 32 | did -e wxchanpass 33 }
  if ($_vr(underbot,opw4) == 1) did -c wxchanpass 38
  if ($_vr(underbot,loginw5) == 1) { did -c wxchanpass 37 | did -e wxchanpass 38 }
  if ($_vr(underbot,opw5) == 1) did -c wxchanpass 38

  did -o  wxchanpass 22 1 $_vr(underbot,chanw1)
  did -o  wxchanpass 23 1 $_vr(underbot,passw1)
  did -o  wxchanpass 26 1 $_vr(underbot,chanw2)
  did -o  wxchanpass 27 1 $_vr(underbot,passw2)
  did -o  wxchanpass 30 1 $_vr(underbot,chanw3)
  did -o  wxchanpass 31 1 $_vr(underbot,passw3)
  did -o  wxchanpass 34 1 $_vr(underbot,chanw4)
  did -o  wxchanpass 35 1 $_vr(underbot,passw4)
  did -o  wxchanpass 38 1 $_vr(underbot,chanw5)
  did -o  wxchanpass 39 1 $_vr(underbot,passw5)
  did -o  wxchanpass 40 1 $_vr(underbot,username1)
  did -o  wxchanpass 41 1 $_vr(underbot,username2)
  did -o  wxchanpass 42 1 $_vr(underbot,username3)
  did -o  wxchanpass 43 1 $_vr(underbot,username4)
  did -o  wxchanpass 44 1 $_vr(underbot,username5)

}
on *:dialog:wxchanpass:sclick:*:{
  if ($did == 20) {  _vw underbot loginw1 $did($did).state | if ($did($did).state == 1) did -e wxchanpass 21 | else { did -b wxchanpass 21 | did -u wxchanpass 21 | _vw underbot opw1 $did($did).state } }
  if ($did == 21) { _vw underbot opw1 $did($did).state }
  if ($did == 24) { _vw underbot loginw2 $did($did).state | if ($did($did).state == 1) did -e wxchanpass 25 | else { did -b wxchanpass 25 | did -u wxchanpass 25 | _vw underbot opw2 $did($did).state } }
  if ($did == 25) { _vw underbot opw2 $did($did).state }
  if ($did == 28) { _vw underbot loginw3 $did($did).state | if ($did($did).state == 1) did -e wxchanpass 29 | else { did -b wxchanpass 29 | did -u wxchanpass 29 | _vw underbot opw3 $did($did).state } }
  if ($did == 29) { _vw underbot opw3 $did($did).state }
  if ($did == 32) { _vw underbot loginw4 $did($did).state | if ($did($did).state == 1) did -e wxchanpass 33 | else { did -b wxchanpass 33 | did -u wxchanpass 33 | _vw underbot opw4 $did($did).state } }
  if ($did == 33) { _vw underbot opw4 $did($did).state }
  if ($did == 36) { _vw underbot loginw5 $did($did).state | if ($did($did).state == 1) did -e wxchanpass 37 | else { did -b wxchanpass 37 | did -u wxchanpass 37 | _vw underbot opw5 $did($did).state } }
  if ($did == 37) { _vw underbot opw5 $did($did).state }

}
on *:dialog:wxchanpass:edit:*:{
  if ($did == 22) { if ($did(wxchanpass,22).text != $null) { _vw underbot chanw1 $did(wxchanpass,22).text } | else _vrem underbot chanw1 }
  if ($did == 23) { if ($did(wxchanpass,23).text != $null) { _vw underbot passw1 $did(wxchanpass,23).text } | else _vrem underbot passw1 }
  if ($did == 26) { if ($did(wxchanpass,26).text != $null) { _vw underbot chanw2 $did(wxchanpass,26).text } | else _vrem underbot chanw2 }
  if ($did == 27) { if ($did(wxchanpass,27).text != $null) { _vw underbot pass2 $did(wxchanpass,27).text } | else _vrem underbot passw2 }

  if ($did == 30) { if ($did(wxchanpass,30).text != $null) { _vw underbot chanw3 $did(wxchanpass,30).text } | else _vrem underbot chanw3 }
  if ($did == 31) { if ($did(wxchanpass,31).text != $null) { _vw underbot passw3 $did(wxchanpass,31).text } | else _vrem underbot passw3 }
  if ($did == 34) { if ($did(wxchanpass,34).text != $null) { _vw underbot chanw4 $did(wxchanpass,34).text } | else _vrem underbot chanw4 }
  if ($did == 35) { if ($did(wxchanpass,35).text != $null) { _vw underbot passw4 $did(wxchanpass,35).text } | else _vrem underbot passw4 }
  if ($did == 38) { if ($did(wxchanpass,38).text != $null) { _vw underbot chanw5 $did(wxchanpass,38).text } | else _vrem underbot chanw5 }
  if ($did == 39) { if ($did(wxchanpass,39).text != $null) { _vw underbot passw5 $did(wxchanpass,39).text } | else _vrem underbot passw5 }
  if ($did == 40) { if ($did(wxchanpass,40).text != $null) { _vw underbot username1 $did(wxchanpass,40).text } | else _vrem underbot username1 }
  if ($did == 41) { if ($did(wxchanpass,41).text != $null) { _vw underbot username2 $did(wxchanpass,41).text } | else _vrem underbot username2 }
  if ($did == 42) { if ($did(wxchanpass,42).text != $null) { _vw underbot username3 $did(wxchanpass,42).text } | else _vrem underbot username3 }
  if ($did == 43) { if ($did(wxchanpass,43).text != $null) { _vw underbot username4 $did(wxchanpass,43).text } | else _vrem underbot username4 }
  if ($did == 44) { if ($did(wxchanpass,44).text != $null) { _vw underbot username5 $did(wxchanpass,44).text } | else _vrem underbot username5 }

}
on *:nick:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:part:%cbc:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:quit:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:kick:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:op:%cbc:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:deop:%cbc:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:voice:%cbc:if ($dialog(underbot) != $null) .timer 1 1 ch.count
on *:devoice:%cbc:if ($dialog(underbot) != $null) .timer 1 1 ch.count
