;Nickserv-id v1.2
;Team Nexgen 2002 by KnightFal
;team-nexgen.com

menu channel,status {
  $iif($nickn == $true, $network ident):nickservid
}
on *:connect: { 
  ;if ($network == DALnet) || ($network == WonderNet) || ($network == action-irc) || ($network == newnet) || ($network == BrasIRC) || ($network == ChatCafe) || ($network == ChatNet) || ($network == Castlenet-irc) || ($network == SexNet) || ($network == Webnet) || ($network == Christian) { .timer 1 1 nick-init }
  ;elseif ($server == irc.interlinkchat.net) || ($server == irc.sp33d.net) { .timer 1 1 nick-init }
}
alias -l nickn  { 
  if ($network == DALnet) || ($network == fryingdutchmen) || ($network == Telstra)  || ($network == FireWirez) || ($network == dynastynet) || ($network == BeyondIRC) || ($network == Aniverse) || ($network == ChatUniverse) || ($network == gamesnet) || ($network == WonderNet) || ($network == Templar-Rock-IRC) || ($network == Webnet) || ($network == grnet) || ($network == NEXnet) || ($network == action-irc) || ($network == Chatfreaks) || ($network == newnet) || ($network == BrasIRC) || ($network == ChatCafe) || ($network == ChatNet) || ($network == SexNet) || ($network == Castlenet-irc) || ($network == Christian) { return $true }
  elseif ($server == irc.interlinkchat.net) { return $true }
}
on *:notice:*:*:{
  if (*This nick is owned by someone else* iswm $1-) && ($nick == NickServ) { nick-init }
  elseif (*This nickname is registered and protected* iswm $1-) && ($nick == NickServ) { nick-init }
  if (*Password accepted for* iswm $1-) && ($nick == NickServ) { if ($dialog(nickservid) != $null) { dialog -x nickservid } }

}
alias autid {
  nick-init
}
alias nickservid { if ($_vr(nickservid,switch) == $null) { _vw nickservid switch on } | if ($dialog(nickservid) == $null) { dialog -m nickservid nickservid } }
dialog nickservid {
  title "nickserv ident console v1.2"
  size -1 -1 400 192
  option pixels
  button "", 20, 10 25 25 20
  button "", 21, 10 50 25 20
  button "", 22, 10 75 25 20
  button "", 23, 10 100 25 20
  button "ok", 2, 167 158 60 20, ok
  text "ident", 14, 10 5 36 20
  text "nick", 6, 46 5 50 15
  text "password", 16, 145 5 50 15
  edit "", 7, 45 25 100 20, autohs
  edit "", 8, 45 50 100 20, autohs
  edit "", 9, 45 75 100 20, autohs
  edit "", 10, 45 100 100 20, autohs
  edit "", 11, 145 25 100 20, disable pass autohs
  edit "", 12, 145 50 100 20, disable pass autohs
  edit "", 13, 145 75 100 20, disable pass autohs
  edit "", 15, 145 100 100 20, disable pass autohs
  check "load on nickserv password request", 17, 10 125 195 20
  check "close on identify", 18, 9 145 100 20
  check "", 40, 255 25 20 20, disable
  check "", 41, 255 50 20 20, disable
  check "", 42, 255 75 20 20, disable
  check "", 43, 255 100 20 20, disable
  text "auto ident", 44, 236 5 57 19
  button "recover", 1, 280 25 51 21, disable
  button "recover", 3, 279 50 51 21, disable
  button "recover", 4, 278 74 51 21, disable
  button "recover", 5, 278 98 51 21, disable
  button "ghost", 19, 334 25 51 21, disable
  button "ghost", 24, 334 49 51 21, disable
  button "ghost", 25, 334 72 51 21, disable
  button "ghost", 26, 334 97 51 21, disable
}
on *:dialog:nickservid:init:*:{
  if ($_vr(nickservid,switch) == on) { did -c nickservid 17 } 
  if ($_vr(nickservid,close) == on) { did -c nickservid 18 } 
  if ($_vr(nickservid,nick1) != $null) { did -e nickservid 11,40,1,19 | did -a nickservid 7 $_vr(nickservid,nick1) } 
  if ($_vr(nickservid,nick2) != $null) { did -e nickservid 12,41,3,24 | did -a nickservid 8 $_vr(nickservid,nick2) } 
  if ($_vr(nickservid,nick3) != $null) { did -e nickservid 13,42,4,25 | did -a nickservid 9 $_vr(nickservid,nick3) } 
  if ($_vr(nickservid,nick4) != $null) { did -e nickservid 15,43,5,26 | did -a nickservid 10 $_vr(nickservid,nick4) } 
  if ($_vr(nickservid,pass1) != $null) { did -a nickservid 11 $_vr(nickservid,pass1) } 
  if ($_vr(nickservid,pass2) != $null) { did -a nickservid 12 $_vr(nickservid,pass2) } 
  if ($_vr(nickservid,pass3) != $null) { did -a nickservid 13 $_vr(nickservid,pass3) } 
  if ($_vr(nickservid,pass4) != $null) { did -a nickservid 15 $_vr(nickservid,pass4) } 
  if ($_vr(nickservid,auto1) == on) { did -c nickservid 40 }
  elseif ($_vr(nickservid,auto2) == on) { did -c nickservid 41 }
  elseif ($_vr(nickservid,auto3) == on) { did -c nickservid 42 }
  elseif ($_vr(nickservid,auto4) == on) { did -c nickservid 43 }
}
alias nickserv.net {
  if ($network == DALnet) { return .msg NickServ@services.dal.net }
  elseif ($network == IRC-HOLICS) { return .msg nickserv } 
  elseif ($network == newnet) { return .msg nickserv } 
  else { return nickserv }  
}
on *:dialog:nickservid:sclick:*:{
  if ($did == 1) { $nickserv.net  recover $did(nickservid,7).text $did(nickservid,11).text }
  if ($did == 3) { $nickserv.net recover $did(nickservid,8).text $did(nickservid,12).text }
  if ($did == 4) { $nickserv.net recover $did(nickservid,9).text $did(nickservid,13).text }
  if ($did == 5) { $nickserv.net recover $did(nickservid,10).text $did(nickservid,15).text }
  if ($did == 19) { $nickserv.net ghost $did(nickservid,7).text $did(nickservid,11).text }
  if ($did == 24) { $nickserv.net ghost $did(nickservid,8).text $did(nickservid,12).text }
  if ($did == 25) { $nickserv.net ghost $did(nickservid,9).text $did(nickservid,13).text }
  if ($did == 26) { $nickserv.net ghost $did(nickservid,10).text $did(nickservid,15).text }

  if ($did == 17) { if ($_vr(nickservid,switch) != on) { _vw nickservid switch on | did -c nickservid 17 | halt } | else _vw nickservid switch off | did -u nickservid 17 }
  if ($did == 18) { if ($_vr(nickservid,close) != on) { _vw nickservid close on | did -c nickservid 18 | halt } | else _vw nickservid close off | did -u nickservid 18 }
  if ($did == 20) { if ($did(nickservid,7).text != $null) && ($did(nickservid,11).text != $null) { nick $did(nickservid,7).text | .timer 1 3 $nickserv.net identify $did(nickservid,11).text | beep } }
  if ($did == 21) { if ($did(nickservid,8).text != $null) && ($did(nickservid,12).text != $null) { nick $did(nickservid,8).text | .timer 1 3 $nickserv.net identify $did(nickservid,12).text } }
  if ($did == 22) { if ($did(nickservid,9).text != $null) && ($did(nickservid,13).text != $null) { nick $did(nickservid,9).text | .timer 1 3 $nickserv.net identify $did(nickservid,13).text } }
  if ($did == 23) { if ($did(nickservid,10).text != $null) && ($did(nickservid,15).text != $null) { nick $did(nickservid,10).text | .timer 1 3 $nickserv.net identify $did(nickservid,15).text } }
  if ($did == 40) {
    if ($did(nickservid,40).state != 1) { did -u nickservid 40 | _vw nickservid auto1 off | sclick | halt } 
    else did -u nickservid 41,42,43 | did -c nickservid 40 | _vw nickservid auto1 on | _vw nickservid auto2 off | _vw nickservid auto3 off | _vw nickservid auto4 off 
  }
  if ($did == 41) { 
    if ($did(nickservid,41).state != 1) { did -u nickservid 41 | _vw nickservid auto2 off | sclick | halt } 
    else did -u nickservid 40,42,43 | did -c nickservid 41 | _vw nickservid auto2 on | _vw nickservid auto1 off | _vw nickservid auto3 off | _vw nickservid auto4 off 
  }
  if ($did == 42) { 
    if ($did(nickservid,42).state != 1) { did -u nickservid 42 | _vw nickservid auto3 off | sclick | halt } 
    did -u nickservid 41,40,43 | did -c nickservid 42 | _vw nickservid auto3 on | _vw nickservid auto2 off | _vw nickservid auto1 off | _vw nickservid auto4 off 
  }
  if ($did == 43) { 
    if ($did(nickservid,43).state != 1) { did -u nickservid 43 | _vw nickservid auto4 off | sclick | halt } 
    did -u nickservid 41,42,40 | did -c nickservid 43 | _vw nickservid auto4 on | _vw nickservid auto2 off | _vw nickservid auto3 off | _vw nickservid auto1 off 
  }
  sclick
}
alias -l nsidclose  if ($_vr(nickservid,close) == on) && ($dialog(nickservid) != $null) { dialog -x nickservid } 
on *:dialog:nickservid:edit:*:{
  if ($did(nickservid,7).text == $null) { _vrem nickservid pass1 | _vw nickservid auto1 off | did -r nickservid 11 | did -u nickservid 40 | did -b nickservid 11,40,1,19 } 
  if ($did(nickservid,8).text == $null) { _vrem nickservid pass2 | _vw nickservid auto2 off | did -r nickservid 12 | did -u nickservid 41 | did -b nickservid 12,41,3,24 } 
  if ($did(nickservid,9).text == $null) { _vrem nickservid pass3 | _vw nickservid auto3 off | did -r nickservid 13 | did -u nickservid 42 | did -b nickservid 13,42,4,25 } 
  if ($did(nickservid,10).text == $null) { _vrem nickservid pass4 | _vw nickservid auto4 off | did -r nickservid 15 | did -u nickservid 43 | did -b nickservid 15,43,5,26 } 
  if ($did == 7) { if ($did(nickservid,7).text != $null) { did -e nickservid 11,40,19,1 | _vw nickservid nick1 $did(nickservid,7).text } | else _vrem nickservid nick1 }
  if ($did == 8) { if ($did(nickservid,8).text != $null) { did -e nickservid 12,41,3,24 | _vw nickservid nick2 $did(nickservid,8).text } | else _vrem nickservid nick2 }
  if ($did == 9) { if ($did(nickservid,9).text != $null) { did -e nickservid 13,42,4,25 | _vw nickservid nick3 $did(nickservid,9).text } | else _vrem nickservid nick3 }
  if ($did == 10) { if ($did(nickservid,10).text != $null) { did -e nickservid 15,43,5,26 | _vw nickservid nick4 $did(nickservid,10).text } | else _vrem nickservid nick4 }
  if ($did == 11) { if ($did(nickservid,11).text != $null) { _vw nickservid pass1 $did(nickservid,11).text } | else _vrem nickservid pass1 }
  if ($did == 12) { if ($did(nickservid,12).text != $null) { _vw nickservid pass2 $did(nickservid,12).text } | else _vrem nickservid pass2 }
  if ($did == 13) { if ($did(nickservid,13).text != $null) { _vw nickservid pass3 $did(nickservid,13).text } | else _vrem nickservid pass3 }
  if ($did == 15) { if ($did(nickservid,15).text != $null) { _vw nickservid pass4 $did(nickservid,15).text } | else _vrem nickservid pass4 }
}
alias nick-init {
  if ($_vr(nickservid,auto1) == on) { $ae  $+ $colour(info) $+ •• Initiating auto-identify with $network NickServ... | nick $_vr(nickservid,nick1) | .timer 1 10 $nickserv.net identify $_vr(nickservid,pass1) | .timer 1 12 $ae  $+ $colour(info) $+ •• Identify sent to $network NickServ. | nsidclose }
  elseif ($_vr(nickservid,auto2) == on) { $ae  $+ $colour(info) $+ •• Initiating auto-identify with $network NickServ... | nick $_vr(nickservid,nick2) | .timer 1 10 $nickserv.net identify $_vr(nickservid,pass2) | .timer 1 12 $ae  $+ $colour(info) $+ •• Identify sent to $network NickServ. | nsidclose }
  elseif ($_vr(nickservid,auto3) == on) { $ae  $+ $colour(info) $+ •• Initiating auto-identify with $network NickServ... | nick $_vr(nickservid,nick3) | .timer 1 10 $nickserv.net identify $_vr(nickservid,pass3) | .timer 1 12 $ae  $+ $colour(info) $+ •• Identify sent to $network NickServ. | nsidclose }
  elseif ($_vr(nickservid,auto4) == on) { $ae  $+ $colour(info) $+ •• Initiating auto-identify with $network NickServ... | nick $_vr(nickservid,nick4) | .timer 1 10 $nickserv.net identify $_vr(nickservid,pass4) | .timer 1 12 $ae  $+ $colour(info) $+ •• Identify sent to $network NickServ. | nsidclose }
  if ($_vr(nickservid,switch) == $null) { _vw nickservid switch on }  
  elseif ($_vr(nickservid,switch) == on) { nickservid }  
}
