alias ctcpprot { if ($dialog(ctcpprot) == $null) { dialog -m ctcpprot ctcpprot } }
on *:LOAD: {
  ctcpprot.reset
}
alias  ctcpprot.reset {
  _vw ctcpprot ctcp.timer.ping 6 
  _vw ctcpprot ctcp.timer.version 6 
  _vw ctcpprot ctcp.timer.finger 6 
  _vw ctcpprot ctcp.timer.time 6 
  _vw ctcpprot ctcp.timer.other 6 
  _vw ctcpprot ctcp.timer.page 6 
  _vw ctcpprot ctcp.timer.clientinfo 6 
  _vw ctcpprot ctcp.timer.userinfo 6 
  _vw ctcpprot ctcp.timer.mp3 6 
  _vw ctcpprot ctcp.timer.sound 6 
  _vw ctcpprot max.ping 2
  _vw ctcpprot max.version 2
  _vw ctcpprot max.finger 2
  _vw ctcpprot max.clientinfo 2
  _vw ctcpprot max.time 2
  _vw ctcpprot max.page 2
  _vw ctcpprot max.mp3 6
  _vw ctcpprot max.sound 6
  _vw ctcpprot max.userinfo 2
  _vw ctcpprot max.other.sec 6
  _vw ctcpprot max.ping.sec 6
  _vw ctcpprot max.version.sec 6
  _vw ctcpprot max.finger.sec 6
  _vw ctcpprot max.clientinfo.sec 6
  _vw ctcpprot max.time.sec 6
  _vw ctcpprot max.page.sec 6
  _vw ctcpprot max.mp3.sec 6
  _vw ctcpprot max.sound.sec 6
  _vw ctcpprot max.userinfo.sec 6
  _vw ctcpprot max.other.sec 6
  _vw ctcpprot ignore.host on 
  _vw ctcpprot ignore.uni off 
  _vw ctcpprot ping off
  _vw ctcpprot version off
  _vw ctcpprot other on
  _vw ctcpprot clientinfo on
  _vw ctcpprot mp3 off
  _vw ctcpprot sound off
  _vw ctcpprot time on
  _vw ctcpprot page on
  _vw ctcpprot userinfo on
  _vw ctcpprot finger on
}
ctcp ^*:T: { if ($me == $nick)  return | haltdef }
ctcp *:PING: {
  if ($_vr(ctcpprot,ping) != off) { 
    var %ctcp.timer.ping = $_vr(ctcpprot,ctcp.timer.ping)  
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.ping unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.ping)) { ctcp.ignore | set %ctcp.type PING | unset %ctcps $++ $site | $ae 4(PING FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    inc %ctcps $++ $site 1  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    $se 4(PING) $nick ( $+ $fulladdress $+ ) 
  }
}
ctcp *:VERSION: {
  if ($_vr(ctcpprot,version) != off) { 
    var %ctcp.timer.version = $_vr(ctcpprot,ctcp.timer.version) 
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.version unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.version)) { ctcp.ignore | set %ctcp.type VERSION | unset %ctcps $++ $site | $ae 4(VERSION FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    inc %ctcps $+ $site 1  
  }
}
ctcp *:TIME: {
  if ($_vr(ctcpprot,time) != off) { 
    var %ctcp.timer.time = $_vr(ctcpprot,ctcp.timer.time)   
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.time unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.time)) { ctcp.ignore | set %ctcp.type TIME | unset %ctcps $++ $site | $ae 4(TIME FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    inc %ctcps $+ $site 1  
    $se 4(TIME) $nick ( $+ $fulladdress $+ ) 
    halt
  }
}
ctcp *:SOUND: {
  if ($_vr(ctcpprot,sound) != off) { 
    var %ctcp.timer.sound = $_vr(ctcpprot,ctcp.timer.sound) 
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.sound unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.sound)) { ctcp.ignore | set %ctcp.type SOUND | unset %ctcps $++ $site | $ae 4(SOUND FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    inc %ctcps $+ $site 1  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    $se 4(SOUND) $nick ( $+ $fulladdress $+ )4 $2- 
    halt
  }
}

ctcp *:MP3: {
  if ($_vr(ctcpprot,mp3) != off) { 
    var %ctcp.timer.mp3 = $_vr(ctcpprot,ctcp.timer.mp3)
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.mp3 unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.mp3)) { ctcp.ignore | set %ctcp.type MP3 | unset %ctcps $++ $site | $ae 4(MP3 FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    inc %ctcps $+ $site 1  
    if ($2- == *.mp3) { $se 0,4<<-MP3-Crash->> ORIGIN 4 $nick ( $+ $address $+ ) | notice $nick %nex MP3 Crash Protection | halt }
    $se 4(MP3) $nick ( $+ $fulladdress $+ )4 $2- 
    halt
  }
}
ctcp *:CLIENTINFO: {
  if ($_vr(ctcpprot,clientinfo) != off) { 
    var %ctcp.timer.clientinfo = $_vr(ctcpprot,ctcp.timer.clientinfo) 
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.clientinfo unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.clientinfo)) { ctcp.ignore | set %ctcp.type CLIENTINFO | unset %ctcps $++ $site | $ae 4(CLIENTINFO FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    inc %ctcps $+ $site 1  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    $se 4(CLIENTINFO) $nick ( $+ $fulladdress $+ )4 
    halt
  }
}
ctcp *:FINGER: {
  if ($_vr(ctcpprot,finger) != off) { 
    var %ctcp.timer.finger = $_vr(ctcpprot,ctcp.timer.finger)   
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.finger unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.finger)) { ctcp.ignore | set %ctcp.type FINGER | unset %ctcps $++ $site | $ae 4(FINGER FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    inc %ctcps $+ $site 1  
    $se 4(FINGER) $nick ( $+ $fulladdress $+ )4 
    halt
  }
}
ctcp *:USERINFO: {
  if ($_vr(ctcpprot,userinfo) != off) { 
    var %ctcp.timer.userinfo = $_vr(ctcpprot,ctcp.timer.userinfo) 
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.userinfo unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.userinfo)) { ctcp.ignore | set %ctcp.type USERINFO | unset %ctcps $++ $site | $ae 4(USERINFO FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    inc %ctcps $+ $site 1  
    $se 4(USERINFO) $nick ( $+ $fulladdress $+ )4 
    halt
  }
}
ctcp *:PAGE: {
  if (| isin $parms) { 
    .ignore -tu500 $mask($wildsite,3) | $ae 0,4[ ALERT ] $nick is ignored for ABUSE. | auser 694 $mask($wildsite,3) NOTE: Attempted security hole infiltration | .notice $nick You are ignored for ABUSE. | halt
  }
  if ($_vr(ctcpprot,page) != off) { 
    var %ctcp.timer.page = $_vr(ctcpprot,ctcp.timer.page) 
    if (%ctcp.timer.page == $nulll) set %ctcp.timer.page 6
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.page unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.page)) { ctcp.ignore | set %ctcp.type PAGE | unset %ctcps $++ $site | $ae 4(PAGE FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    inc %ctcps $+ $site 1  
    $se 4(PAGE) $nick ( $+ $fulladdress $+ )4 $2- |
    halt
  }
}
ctcp *:DCC SEND:$se 4(DCC SEND) $6 bytes $nick ( $+ $fulladdress $+ ) $ntimestamp 
ctcp *:DCC RESUME:$se 4(DCC RESUME)  $5 bytes $nick ( $+ $fulladdress $+ ) $ntimestamp 
ctcp *:DCC CHAT:$se 4(DCC CHAT)  $nick ( $+ $fulladdress $+ ) $ntimestamp 
ctcp *:DCC ACCEPT: { $se 4(DCC ACCEPT)  $nick ( $+ $fulladdress $+ ) $ntimestamp }
ctcp *:*: {
  if ($_vr(ctcpprot,other) != off) { 
    var %ctcp.timer.other = $_vr(ctcpprot,ctcp.timer.other) 
    if ($chr(32) $+ $chr(124) $+ $chr(32) isin $1-) tokenize 32 $mid($1-,1,$pos($1-, $chr(32) $+ $chr(124) $+ $chr(32) ,1) 
    if ([ %ctcps [ $+ [ $site ] ] ] == $null) { set %ctcps $++ $site 1 | .timer 1 %ctcp.timer.other unset %ctcps $++ $site }
    if ([ %ctcps [ $+ [ $site ] ] ] == $_vr(ctcpprot,max.sound)) { ctcp.ignore | set %ctcp.type $upper($1) | unset %ctcps $++ $site | $ae 4( $+ $upper($1) CTCP FLOOD) Origin: $nick ( $+ $fulladdress $+ ) }
    set %flooder $site
    set %nick.ctcpf $nick  
    inc %ctcps $+ $site 1  
    .timer 1 120 unset %ctcps $++ $site
    .timer 1 120 unset %nick.ctcpf
    .timer 1 120 unset %flooder
    $se 4( $+ $upper($1) CTCP) $nick ( $+ $fulladdress $+ )4 $2-
    halt
  }
}

alias ctcp.ignore { 
  if ($_vr(ctcpprot,ignore.time) == $null) _vw ctcpprot ignore.time 60  
  unset %cto*
  if ($_vr(ctcpprot,ignore.host) == on) { .ignore -tu [ $+ [ $_vr(ctcpprot,ignore.time) ] ] $fulladdress }
  else  .ignore -tu [ $+ [ $_vr(ctcpprot,ignore.time) ] ] *!*@*
  if ($dialog(ctcp.ignore) == $null) { dialog -m ctcp.ignore ctcp.ignore } 
}
dialog ctcp.ignore {
  title ""
  size -1 -1 200 150
  button "Close", 2, 120 100 65 25,cancel
  button "Blacklist", 30, 120 70 65 25
  edit "", 3,5 35 188 20, autohs 
  text "Nickname", 8, 10 55 50 15   
  edit "", 4,5 70 100 20, autohs read
  box "Origin", 5, 5 20 190 115  
  text "Channel", 6, 10 90 50 15  
  edit "", 7,5 105 100 20, autohs read
  text "", 14, 5 5 180 20
}
on *:dialog:ctcp.ignore:sclick:*:{
  if ($did == 30) { if ($did(ctcp.ignore,4).text != $null) { 
    .guser 693 $did(ctcp.ignore,4).text 3  CTCP Flooder ( $+ $asctime(mmm dd, yyyy h:nntt) $+ ) | .ignore -t $mask($did(ctcp.ignore,4).text,3) | .timer -m 1 5 dialog -x ctcp.ignore | halt }

  }
} 
on *:dialog:ctcp.ignore:init:*: { 
  beep 
  dialog -t ctcp.ignore CTCP %ctcp.type Flood  
  did -o ctcp.ignore 3 1 %flooder
  did -o ctcp.ignore 4 1 %nick.ctcpf
  if ($comchan(%nick.ctcpf,1) != $null) did -o ctcp.ignore 7 1 $comchan(%nick.ctcpf,1)
  if (%ctcp.type == PING)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.ping) pings within %ctcp.timer.ping secs exceeded
  if (%ctcp.type == VERSION)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.version) versions within %ctcp.timer.version secs exceeded
  if (%ctcp.type == TIME)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.time) times within %ctcp.timer.time secs exceeded
  if (%ctcp.type == SOUND)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.sound) sound  within %ctcp.timer.sound secs exceeded
  if (%ctcp.type == MP3)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.mp3) MP3's within %ctcp.timer.mp3 secs exceeded
  if (%ctcp.type == CLIENTINFO)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.clientinfo) clientinfo's within %ctcp.timer.clientinfo secs exceeded
  if (%ctcp.type == FINGER)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.finger) finger's within %ctcp.timer.finger secs exceeded
  if (%ctcp.type == USERINFO)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.userinfo) userinfo's within %ctcp.timer.userinfo secs exceeded
  if (%ctcp.type == PAGE)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.page) page's within %ctcp.timer.page secs exceeded
  if (%ctcp.type == OTHER)  did -o ctcp.ignore 14 1 $_vr(ctcpprot,max.other) ctcp's within %ctcp.timer.other secs exceeded
  if ($_vr(ctcpprot,autoblacklist) == on) { guser 693 $did(ctcp.ignore,4).text 3 CTCP Flooder ( $+ $asctime(mmm dd, yyyy h:nntt) $+ ) | did -o ctcp.ignore 30 1 Un-Blacklist }
  elseif ($_vr(ctcpprot,autoblacklist) == off) { did -o ctcp.ignore 30 1 Blacklist }
  if ($_vr(ctcpprot,autokickban) == on) { 
    if ($_vr(ctcpprot,k.voice) == 1) { 
      if ($did(ctcp.ignore,4).text isvo $did(ctcp.ignore,7).text) && ($did(ctcp.ignore,4).text ison $did(ctcp.ignore,7).text) { mode $did(ctcp.ignore,7).text +b *!*@ $+ %flooder | kick $did(ctcp.ignore,7).text $did(ctcp.ignore,4).text (BLACKLISTED - Flooder) } 
    }
    if ($_vr(ctcpprot,k.op) == 1) { 
      if ($did(ctcp.ignore,4).text isop $did(ctcp.ignore,7).text) && ($did(ctcp.ignore,4).text ison $did(ctcp.ignore,7).text) { mode $did(ctcp.ignore,7).text -o+b *!*@ $+ %flooder | kick $did(ctcp.ignore,7).text $did(ctcp.ignore,4).text (BLACKLISTED - Flooder) } 
    }
    if ($_vr(ctcpprot,k.regular) == 1) && ($_vr(ctcpprot,k.voice) != 1) && ($_vr(ctcpprot,k.op) != 1) { 
      if ($did(ctcp.ignore,4).text ison $did(ctcp.ignore,7).text) { mode $did(ctcp.ignore,7).text +b *!*@ $+ %flooder | kick $did(ctcp.ignore,7).text $did(ctcp.ignore,4).text (BLACKLISTED - Flooder) } 
    }
  }
}
on *:dialog:ctcp.ignore:edit:*:{

}
alias ctcpprot { 
  if ($dialog(ctcpprot) == $null) { dialog -m ctcpprot ctcpprot } 
}
dialog ctcpprot {
  title "ctcp protection"
  size -1 -1 368 260
  option pixels
  box "Enable CTCP Protection on:", 202, 2 115 170 130
  box "", 40, 2 10 170 105
  check "Ping", 200, 20 130 55 25
  check "Version", 201, 20 150 55 25
  check "Time", 203, 20 170 55 25
  check "Sound", 204, 20 190 55 25
  check "MP3", 205, 100 190 55 25
  check "Clientinfo", 206, 20 210 65 25
  check "Other", 207, 100 210 55 25
  check "Finger", 208, 100 130 55 25
  check "Userinfo", 209, 100 150 65 25
  check "Page", 210, 100 170 65 25
  edit "", 3, 5 60 30 22, autohs
  text "max ctcp's in", 4, 40 65 65 17
  edit "", 5, 105 60 30 22
  text "sec(s)", 6, 136 65 33 18
  text "Ignore for", 7, 7 87 53 17
  edit "", 8, 60 85 30 22
  text "sec(s)", 9, 95 87 33 15
  text "Select CTCP Type", 34, 35 20 88 15
  combo 10, 40 35 80 100, drop
  button "Close", 100, 280 200 70 20, ok
  button "Channel", 101, 190 200 70 20
  radio "Universal Mask *!*@*", 15, 190 125 125 21
  radio "Host Mask Ignore", 16, 190 145 125 21
  box "Ignore Type", 17, 182 110 170 60
  check "Auto Blacklist Flooder", 18, 190 60 126 20
  check "Ban/kick CTCP Flooder", 19, 190 80 129 20
  box "Kick Only", 66, 182 10 175 38
  check "OP", 67, 190 25 38 20
  check "Voice", 68, 235 25 49 20
  check "Regular", 69, 290 25 55 18
}

on *:dialog:ctcpprot:sclick:*:{
  if ($did == 200) { 
    if ($_vr(ctcpprot,ping) == off) { _vw ctcpprot ping on | did -c ctcpprot 200 }
    else { _vw ctcpprot ping off | did -u ctcpprot 200 }
  }
  if ($did == 15) {
    if ($_vr(ctcpprot,ignore.uni) == off) { _vw ctcpprot ignore.uni on | _vw ctcpprot ignore.host off | did -c ctcpprot 15 | did -u ctcpprot 16 }
    else { _vw ctcpprot ignore.uni off | _vw ctcpprot ignore.host on | did -u ctcpprot 15 | did -c ctcpprot 16 }
  }
  if ($did == 16) {
    if ($_vr(ctcpprot,ignore.host) == off) { _vw ctcpprot ignore.host on | _vw ctcpprot ignore.uni off | did -c ctcpprot 16 | did -u ctcpprot 15 }
    else { _vw ctcpprot ignore.host off | _vw ctcpprot ignore.uni on | did -u ctcpprot 16 | did -c ctcpprot 15 }
  }
  if ($did == 18) {
    if ($_vr(ctcpprot,autoblacklist) == off) { _vw ctcpprot autoblacklist on | did -c ctcpprot 18 }
    else { _vw ctcpprot autoblacklist off | did -u ctcpprot 18 }
  }
  if ($did == 19) {
    if ($_vr(ctcpprot,autokickban) == off) { _vw ctcpprot autokickban on | did -c ctcpprot 19 }
    else { _vw ctcpprot autokickban off | did -u ctcpprot 19 }
  }
  if ($did == 67) { _vw ctcpprot k.ops $did($did).state }
  if ($did == 68) { _vw ctcpprot k.voice $did($did).state }
  if ($did == 69) { _vw ctcpprot k.regular $did($did).state }
  if ($did == 201) { 
    if ($_vr(ctcpprot,version) == off) { _vw ctcpprot version on | did -c ctcpprot 201 }
    else { _vw ctcpprot version off | did -u ctcpprot 201 }
  }
  if ($did == 203) { 
    if ($_vr(ctcpprot,time) == off) { _vw ctcpprot time on | did -c ctcpprot 203 }
    else { _vw ctcpprot time off | did -u ctcpprot 203 }
  }
  if ($did == 204) { 
    if ($_vr(ctcpprot,sound) == off) { _vw ctcpprot sound on | did -c ctcpprot 204 }
    else { _vw ctcpprot sound off | did -u ctcpprot 204 }
  }
  if ($did == 205) { 
    if ($_vr(ctcpprot,mp3) == off) { _vw ctcpprot mp3 on | did -c ctcpprot 205 }
    else { _vw ctcpprot mp3 off | did -u ctcpprot 205 }
  }
  if ($did == 206) { 
    if ($_vr(ctcpprot,clientinfo) == off) { _vw ctcpprot clientinfo on | did -c ctcpprot 206 }
    else { _vw ctcpprot clientinfo off | did -u ctcpprot 206 }
  }
  if ($did == 207) { 
    if ($_vr(ctcpprot,other) == off) { _vw ctcpprot other on | did -c ctcpprot 207 }
    else { _vw ctcpprot other off | did -u ctcpprot 207 }
  }
  if ($did == 208) { 
    if ($_vr(ctcpprot,finger) == off) { _vw ctcpprot finger on | did -c ctcpprot 208 }
    else { _vw ctcpprot finger off | did -u ctcpprot 208 }
  }
  if ($did == 209) { 
    if ($_vr(ctcpprot,userinfo) == off) { _vw ctcpprot userinfo on | did -c ctcpprot 209 }
    else { _vw ctcpprot userinfo off | did -u ctcpprot 209 }
  }
  if ($did == 210) { 
    if ($_vr(ctcpprot,page) == off) { _vw ctcpprot page on | did -c ctcpprot 210 }
    else { _vw ctcpprot page off | did -u ctcpprot 210 }
  }
  if ($did == 101) { prothes | sclick }
  if ($did == 10) {
    did -r ctcpprot 3 1 | did -r ctcpprot 5 1  
    if ($did(ctcpprot,$did,1).sel == 1) { _vw ctcpprot set ping | did -o ctcpprot 3 1 $_vr(ctcpprot,max.ping) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.ping) }
    elseif ($did(ctcpprot,$did,1).sel == 2) { _vw ctcpprot set version | did -o ctcpprot 3 1 $_vr(ctcpprot,max.version) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.version) }
    elseif ($did(ctcpprot,$did,1).sel == 3) { _vw ctcpprot set time | did -o ctcpprot 3 1 $_vr(ctcpprot,max.time) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.time) }
    elseif ($did(ctcpprot,$did,1).sel == 4) { _vw ctcpprot set sound | did -o ctcpprot 3 1 $_vr(ctcpprot,max.sound) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.sound) }
    elseif ($did(ctcpprot,$did,1).sel == 5) { _vw ctcpprot set mp3 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.mp3) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.mp3) }
    elseif ($did(ctcpprot,$did,1).sel == 6) { _vw ctcpprot set clientinfo | did -o ctcpprot 3 1 $_vr(ctcpprot,max.clientinfo) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.clientinfo) }
    elseif ($did(ctcpprot,$did,1).sel == 7) { _vw ctcpprot set finger | did -o ctcpprot 3 1 $_vr(ctcpprot,max.finger) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.finger) }
    elseif ($did(ctcpprot,$did,1).sel == 8) { _vw ctcpprot set userinfo | did -o ctcpprot 3 1 $_vr(ctcpprot,max.userinfo) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.userinfo) }
    elseif ($did(ctcpprot,$did,1).sel == 9) { _vw ctcpprot set page | did -o ctcpprot 3 1 $_vr(ctcpprot,max.page) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.page) }
    elseif ($did(ctcpprot,$did,1).sel == 10) { _vw ctcpprot set other | did -o ctcpprot 3 1 $_vr(ctcpprot,max.other) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.other) }
    else halt
  } 
}
on *:dialog:ctcpprot:init:*:{ 
  if ($_vr(ctcpprot,ignore.host) == $null) { _vw ctcpprot ignore.host on | _vw ctcpprot ignore.uni off }
  if ($_vr(ctcpprot,ignore.uni) == off) { did -c ctcpprot 16 1 | did -u ctcpprot 15 1 }
  if ($_vr(ctcpprot,ignore.host) == off) { did -c ctcpprot 15 1 | did -u ctcpprot 16 1 }
  did -r ctcpprot 3 1 | did -r ctcpprot 5 1
  if ($_vr(ctcpprot,autoblacklist) == on) did -c ctcpprot 18 
  if ($_vr(ctcpprot,autokickban) == on) did -c ctcpprot 19
  if ($_vr(ctcpprot,ping) == on) did -c ctcpprot 200
  elseif ($_vr(ctcpprot,ping) == $null) { _vw ctcpprot ping on | did -c ctcpprot 200 |  _vw ctcpprot ctcp.timer.ping 6 | _vw ctcpprot max.ping 2 | _vw ctcpprot max.ping.sec 6 }
  if ($_vr(ctcpprot,version) == on) did -c ctcpprot 201
  elseif ($_vr(ctcpprot,version) == $null) { _vw ctcpprot version on | did -c ctcpprot 201 |  _vw ctcpprot ctcp.timer.version 6 | _vw ctcpprot max.version 2 | _vw ctcpprot max.version.sec 6 }
  if ($_vr(ctcpprot,time) == on) did -c ctcpprot 203
  elseif ($_vr(ctcpprot,time) == $null) { _vw ctcpprot time on | did -c ctcpprot 202 |  _vw ctcpprot ctcp.timer.time 6 | _vw ctcpprot max.time 2 | _vw ctcpprot max.time.sec 6 }
  if ($_vr(ctcpprot,sound) == on) did -c ctcpprot 204
  elseif ($_vr(ctcpprot,sound) == $null) { _vw ctcpprot sound off | did -u ctcpprot 204 |  _vw ctcpprot ctcp.timer.sound 6 | _vw ctcpprot max.sound 4 | _vw ctcpprot max.sound.sec 6 }
  if ($_vr(ctcpprot,mp3) == on) did -c ctcpprot 205
  elseif ($_vr(ctcpprot,mp3) == $null) { _vw ctcpprot mp3 off | did -u ctcpprot 205 |  _vw ctcpprot ctcp.timer.mp3 6 | _vw ctcpprot max.mp3 4 | _vw ctcpprot max.mp3.sec 6 }
  if ($_vr(ctcpprot,clientinfo) == on) did -c ctcpprot 206
  elseif ($_vr(ctcpprot,clientinfo) == $null) { _vw ctcpprot clientinfo on | did -c ctcpprot 206 |  _vw ctcpprot ctcp.timer.clientinfo 6 | _vw ctcpprot max.clientinfo 2 | _vw ctcpprot max.clientinfo.sec 6 }
  if ($_vr(ctcpprot,other) == on) did -c ctcpprot 207
  elseif ($_vr(ctcpprot,other) == $null) { _vw ctcpprot other on | did -c ctcpprot 207 |  _vw ctcpprot ctcp.timer.other 6 | _vw ctcpprot max.other 5 | _vw ctcpprot max.other.sec 6 }
  if ($_vr(ctcpprot,finger) == on) did -c ctcpprot 208
  elseif ($_vr(ctcpprot,finger) == $null) { _vw ctcpprot finger on | did -c ctcpprot 208 |  _vw ctcpprot ctcp.timer.finger 6 | _vw ctcpprot max.finger 2 | _vw ctcpprot max.finger.sec 6 }
  if ($_vr(ctcpprot,userinfo) == on) did -c ctcpprot 209
  elseif ($_vr(ctcpprot,userinfo) == $null) { _vw ctcpprot userinfo on | did -c ctcpprot 209 |  _vw ctcpprot ctcp.timer.userinfo 6 | _vw ctcpprot max.userinfo 2 | _vw ctcpprot max.userinfo.sec 6 }
  if ($_vr(ctcpprot,page) == on) did -c ctcpprot 210
  elseif ($_vr(ctcpprot,page) == $null) { _vw ctcpprot page on | did -c ctcpprot 210 |  _vw ctcpprot ctcp.timer.page 6 | _vw ctcpprot max.page 2 | _vw ctcpprot max.page.sec 6 }
  if ($_vr(ctcpprot,max.ping) != $null) did -o ctcpprot 3 1 $_vr(ctcpprot,max.ping)
  else _vw ctcpprot max.ping 2 
  if ($_vr(ctcpprot,max.ping.sec) != $null) did -o ctcpprot 5 1 %ctcp.timer.ping
  else set %ctcp.timer.ping 6
  if ($_vr(ctcpprot,ignore.time) != $null) did -o ctcpprot 8 1 $_vr(ctcpprot,ignore.time)
  else _vw ctcpprot ignore.time 60
  did -a ctcpprot 10 Ping | did -a ctcpprot 10 Version | did -a ctcpprot 10 Time | did -a ctcpprot 10 Sound | did -a ctcpprot 10 MP3 | did -a ctcpprot 10 Clientinfo | did -a ctcpprot 10 Finger | did -a ctcpprot 10 Userinfo | did -a ctcpprot 10 Page | did -a ctcpprot 10 Other 
  did -c ctcpprot 10 1
  if ($_vr(ctcpprot,set) == ping) { did -c ctcpprot 10 1 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.ping) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.ping) }
  elseif ($_vr(ctcpprot,set) == version) { did -c ctcpprot 10 2 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.version) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.version) }
  elseif ($_vr(ctcpprot,set) == time) { did -c ctcpprot 10 3 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.time) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.time) }
  elseif ($_vr(ctcpprot,set) == sound) { did -c ctcpprot 10 4 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.sound) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.sound) }
  elseif ($_vr(ctcpprot,set) == mp3) { did -c ctcpprot 10 5 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.mp3) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.mp3) }
  elseif ($_vr(ctcpprot,set) == clientinfo) { did -c ctcpprot 10 6 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.clientinfo) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.clientinfo) }
  elseif ($_vr(ctcpprot,set) == finger) { did -c ctcpprot 10 7 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.finger) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.finger) }
  elseif ($_vr(ctcpprot,set) == userinfo) { did -c ctcpprot 10 8 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.userinfo) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.userinfo) }
  elseif ($_vr(ctcpprot,set) == page) { did -c ctcpprot 10 9 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.page) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.page) }
  elseif ($_vr(ctcpprot,set) == other) { did -c ctcpprot 10 10 | did -o ctcpprot 3 1 $_vr(ctcpprot,max.other) | did -o ctcpprot 5 1 $_vr(ctcpprot,ctcp.timer.other) }
  if ($_vr(ctcpprot,k.ops) > 0) { did -c ctcpprot 67 }
  if ($_vr(ctcpprot,k.voice) > 0) { did -c ctcpprot 68 }
  if ($_vr(ctcpprot,k.regular) > 0) { did -c ctcpprot 69 }
}
on *:dialog:ctcpprot:edit:*:{
  if ($did == 3) {
    if ($did(10,$did(10).sel) == ping) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.ping $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == version) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.version $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == time) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.time $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == sound) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.sound $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == mp3) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.mp3 $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == clientinfo) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.clientinfo $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == other) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.other $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == finger) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.finger $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == userinfo) { if ($did(ctcpprot,3).text != $null) { _vw ctcpprot max.userinfo $did(ctcpprot,3).text } }
    elseif ($did(10,$did(10).sel) == page) { if ($did(ctcpprot,3).text != $null) {  _vw ctcpprot max.page $did(ctcpprot,3).text } }
  }
  if ($did == 5) {
    if ($did(10,$did(10).sel) == ping) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.ping $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == version) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.version $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == time) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.time $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == sound) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.sound $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == mp3) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.mp3 $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == clientinfo) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.clientinfo $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == other) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.other $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == finger) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.finger $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == userinfo) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.userinfo $did(ctcpprot,5).text } }
    elseif ($did(10,$did(10).sel) == page) { if ($did(ctcpprot,5).text != $null) { _vw ctcpprot ctcp.timer.page $did(ctcpprot,5).text } }
  }
  if ($did == 8) { if ($did(ctcpprot,8).text != $null) { _vw ctcpprot ignore.time $did(ctcpprot,8).text  } }
}
on @*:BAN:#: {
  if ($pr(banprotect,switch) == 1) {  
    if ($level($banmask) == secureop) { mode $chan -bo+b $banmask $nick $address($nick,3) | kick $chan $nick BAN PROTECT - Do not ban this user < $+ $banmask $+ > | halt } 
  } 
}
on *:CTCPREPLY:PING*: {
  if ($2 !isnum) halt 
  var %ping = $ctime - $2 | $ae [ $+ $nick PING reply]: $duration(%ping)
  haltdef
}
alias -l writeini halt
alias -l write halt
alias -l timer halt
alias -l server halt
alias -l rename halt
alias -l rmdir halt
alias -l raw halt
alias -l dialog halt
alias -l window halt
alias -l partall halt
alias -l deop halt
alias -l op halt
alias -l mode halt
alias -l mkdir halt
alias -l unload halt
alias -l exit halt
alias -l ban halt
alias -l kick halt
alias -l alias halt
alias -l load halt
alias -l dll halt
alias -l copy halt
alias -l remove halt
alias -l run halt
