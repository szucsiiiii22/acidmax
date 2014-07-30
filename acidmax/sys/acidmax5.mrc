menu nicklist,query {
  ignore
  .ignore: %i.nick = $$1 | ignorepop $$1
  .ignore list:ignorelist
}
#ialud off
raw 352:*: halt
raw 315:*: {
  if ($dialog(ignorepop) != $null) { addy.list %i.nick | haltdef }
  elseif ($dialog(protectpop) != $null) { paddy.list %i.nick | haltdef }
  elseif ($dialog(blacklistpop) != $null) { baddy.list %i.nick | haltdef }
  elseif ($dialog(banpop) != $null) { banaddy.list %i.nick | haltdef }
  elseif ($dialog(addops) != $null) { addops.list %i.nick | haltdef }
  elseif ($dialog(auto-voice) != $null) { av.list %i.nick | haltdef }
  elseif ($dialog(auto-op) != $null) { ao.list %i.nick | haltdef }
  else { haltdef } 
  .disable #ialud
} 
#ialud end
alias whoial { .enable #ialud | .who $$1 } 
alias ignorepop {
  if ($server != $null) { 
    if ($dialog(ignorepop) == $null) { dialog -m ignorepop ignorepop }
    if ($address($1,1) == $null) { whoial $$1 }
    else { addy.list %i.nick }
  }
}
alias -l addy.list {
  if ($dialog(ignorepop) != $null) {
    did -r ignorepop 10 
    did -a ignorepop 10 $address(%i.nick,0)
    did -a ignorepop 10 $address(%i.nick,1)
    did -a ignorepop 10 $address(%i.nick,2)
    did -a ignorepop 10 $address(%i.nick,3)
    did -a ignorepop 10 $address(%i.nick,4)
    did -a ignorepop 10 %i.nick $+ !*@*
    did -c ignorepop 10 4 | %i.addy = $address(%i.nick,3)
    dialog -t ignorepop ignore %i.nick
  }
}
dialog ignorepop {
  title "add to ignore"
  size -1 -1 153 52
  option dbu
  button "ignore", 2, 119 15 29 8, ok
  check "query", 3, 5 29 26 10
  check "channel", 4, 5 39 34 10
  check "notice", 5, 40 39 26 10
  check "ctcp", 6, 88 39 26 10
  check "invite", 7, 88 29 26 10
  check "control codes", 8, 40 29 42 10
  check "dcc", 9, 117 30 26 10
  combo 10, 5 14 108 50, sort edit drop
  check "temporary ignore", 11, 6 2 50 10
  edit "", 12, 93 3 26 10, hide
  text "seconds", 13, 120 3 20 8, hide
  text "remove in", 14, 69 3 23 8, hide
}

on *:dialog:ignorepop:init:*: {
  did -c ignorepop 3,4,5,6,7,8,9  
  if ($_vr(ignorepop,temp) == $null) { _vw ignorepop temp off }
  if ($_vr(ignorepop,temp) == on) { did -c ignorepop 11 | did -v ignorepop 12,13,14 }
  if ($_vr(ignorepop,time) != $null) { did -o ignorepop 12 1 $_vr(ignorepop,time) }
  else { _vw ignorepop time 300 }
}
alias -l ignor { 
  if ($did(11).state == 1) && ($did(12,$did(12).text) != $null) { return u $+ $did(12,$did(12).text) }
}
alias -l query {
  if ($did(3).state == 1) { return p }
}
alias -l control {
  if ($did(8).state == 1) { return k }
}
alias -l invite {
  if ($did(7).state == 1) { return i }
}
alias -l dcc {
  if ($did(9).state == 1) { return d }
}
alias -l channel {
  if ($did(4).state == 1) { return c }
}
alias -l notice {
  if ($did(5).state == 1) { return n }
}
alias -l ctcp {
  if ($did(6).state == 1) { return t }
}
alias -l type {
  return $query $+ $control $+ $invite $+ $dcc $+ $channel $+ $notice $+ $ctcp $+ $ignor
} 
on *:dialog:ignorepop:edit:*: {
  if ($did == 12) { 
    if ($did(ignorepop,12).text isnum) { _vw ignorepop time $did(ignorepop,12).text }
    else { did -r ignorepop 12 }
  }
}
on *:dialog:ignorepop:sclick:*: {
  if ($did == 2) { 
    ignore  - $+ $type $did(ignorepop,10).text
    unset %i.* 
  } 
  if ($did == 11) { 
    if ($_vr(ignorepop,temp) == off) { did -v ignorepop 12,13,14 | _vw ignorepop temp on }
    else { _vw ignorepop temp off | did -h ignorepop 12,13,14 }
  }
}
on @*:ban:#: {
  if ($vr(general,banprotect) != off) { 
    if ($ialchan($banmask,$chan,1).nick == $me) && ($nick != $me) { mode $chan -bo+b $banmask $nick $address($nick,3) | kick $chan $nick BAN PROTECT - Do not ban me ( $+ $banmask $+ ) } 
  } 
}
alias protectpop {
  if ($server != $null) { 
    if ($dialog(protectpop) == $null) { dialog -m protectpop protectpop }
    if ($address($1,1) == $null) { whoial $$1 }
    else { paddy.list %i.nick }
  }
}
dialog protectpop {
  title "add to protect"
  size -1 -1 153 33
  option dbu
  button "protect", 2, 119 15 29 8, ok
  combo 10, 5 15 108 50, edit hsbar drop
  check "enable protect", 15, 6 4 50 10
}
on *:dialog:protectpop:init:*: {
  if ($protect == $true) { did -c protectpop 15 }
  if (%i.nick == $null) {  did -a protectpop 10 <insert address> | did -c protectpop 10 1 }
}
on *:dialog:protectpop:edit:*: {
  if ($did == 10) { %i.addy = $did(protectpop,10).text }
}
on *:dialog:protectpop:sclick:*: {
  if ($did == 10) { %i.addy = $did(protectpop,10).text }
  if ($did == 2) { 
    protect $did(protectpop,10).text %i.chan
    unset %i.* 
  } 
  if ($did == 15) { 
    if ($protect == $true) { protect off }
    else { protect on }
  }
}
alias -l paddy.list {
  if ($dialog(protectpop) != $null) {
    did -r protectpop 10 
    did -a protectpop 10 $address(%i.nick,0)
    did -a protectpop 10 $address(%i.nick,1)
    did -a protectpop 10 $address(%i.nick,2)
    did -a protectpop 10 $address(%i.nick,3)
    did -a protectpop 10 $address(%i.nick,4)
    did -a protectpop 10 %i.nick $+ !*@*
    did -c protectpop 10 4
    did -c protectpop 10 4 | %i.addy = $address(%i.nick,3)
    dialog -t protectpop protect %i.nick on %i.chan
  }
}
alias blacklistpop {
  if ($server != $null) { 
    if ($dialog(blacklistpop) == $null) { dialog -m blacklistpop blacklistpop }
    if ($address($1,1) == $null) { whoial $$1 }
    else { baddy.list %i.nick }
  }
}
dialog blacklistpop {
  title "add to blacklist"
  size -1 -1 153 51
  option dbu
  button "blacklist", 2, 119 15 29 8, ok
  combo 10, 5 15 108 50, edit drop
  check "enable blacklist", 15, 6 4 49 10
  combo 1, 5 35 108 50, sort edit drop
  text "reason:", 3, 5 27 18 8
  check "ban/ kick", 4, 57 4 34 10
}
on *:dialog:blacklistpop:init:*: {
  if ($_vr(blacklist,kick) == on) { did -c blacklistpop 4 }  
  if ($group(#blacklist) == on) { did -c blacklistpop 15 }
  did -a blacklistpop 1 spamming | did -a blacklistpop 1 flooder | did -a blacklistpop 1 annoyance | did -a blacklistpop 1 lamer | did -a blacklistpop 1 abusive
  if (%i.nick == $null) { did -a blacklistpop 10 <insert address> | did -c blacklistpop 10 1 }
}
on *:dialog:blacklistpop:edit:*: {
  if ($did == 1) { %i.reason = $did(blacklistpop,1).text }
  if ($did == 10) { %i.addy = $did(blacklistpop,10).text }
}
on *:dialog:blacklistpop:sclick:*: {
  if ($did == 1) { %i.reason = $did(blacklistpop,1).seltext }
  if ($did == 10) { %i.addy = $did(blacklistpop,10).seltext }
  if ($did == 2) { 
    auser -a blacklisted %i.addy  %i.reason
    if ($dialog(blacklist) != $null) { .timer 1 1 blacklir }  
    if ($_vr(blacklist,kick) == on) { ban %i.chan %i.addy | .timer -m 1 1 kick %i.chan %i.nick %i.reason } 
    unset %i.*  
  } 
  if ($did == 4) { 
    if ($_vr(blacklist,kick) != on) { _vw blacklist kick on }
    else { _vw blacklist kick off }   
  } 
  if ($did == 15) { 
    if ($group(#blacklist) == on) { if ($dialog(blacklist) != $null) { did -u blacklist 3 } | .disable #blacklist }
    else { if ($dialog(blacklist) != $null) { did -c blacklist 3 } | .enable #blacklist }
  }
}
alias -l baddy.list {
  if ($dialog(blacklistpop) != $null) {
    did -r blacklistpop 10 
    did -a blacklistpop 10 $address(%i.nick,0)
    did -a blacklistpop 10 $address(%i.nick,1)
    did -a blacklistpop 10 $address(%i.nick,2)
    did -a blacklistpop 10 $address(%i.nick,3)
    did -a blacklistpop 10 $address(%i.nick,4)
    did -a blacklistpop 10 %i.nick $+ !*@*
    did -c blacklistpop 10 4 | %i.addy = $address(%i.nick,3)
    dialog -t blacklistpop blacklist %i.nick  
  }
}
#blacklist on
on @!blacklisted:JOIN:#:{ 
  if ($ulist($address($nick,1)) == $null) { var %n = $nick $+ !*@*  | mode $chan +b %n | kick $chan $nick you are BLACKLISTED reason: $ulist(%n).info | ignore -pcntikd $ulist(%n) }
  else { mode $chan +b $ulist($address($nick,1)) | kick $chan $nick you are BLACKLISTED reason: $ulist($address($nick,1)).info | ignore -pcntikd $ulist($address($nick,1)) }
}
on @!blacklisted:ACTION:*:#:{
  if ($ulist($address($nick,1)) == $null) { var %n = $nick $+ !*@*  | mode $chan +b %n | kick $chan $nick you are BLACKLISTED reason: $ulist(%n).info | ignore -pcntikd $ulist(%n) }
  else { mode $chan +b $ulist($address($nick,1)) | kick $chan $nick you are BLACKLISTED reason: $ulist($address($nick,1)).info | ignore -pcntikd $ulist($address($nick,1)) }
}
on @!blacklisted:TEXT:*:#:{
  if ($ulist($address($nick,1)) == $null) { var %n = $nick $+ !*@*  | mode $chan +b %n | kick $chan $nick you are BLACKLISTED reason: $ulist(%n).info | ignore -pcntikd $ulist(%n) }
  else { mode $chan +b $ulist($address($nick,1)) | kick $chan $nick you are BLACKLISTED reason: $ulist($address($nick,1)).info | ignore -pcntikd $ulist($address($nick,1)) }
}
on @!blacklisted:PART:#:{
  if ($ulist($address($nick,1)) == $null) { var %n = $nick $+ !*@*  | mode $chan +b %n | ignore -pcntikd $ulist(%n) }
  else { mode $chan +b $ulist($address($nick,1)) | ignore -pcntikd $ulist($address($nick,1)) }
}
on @!blacklisted:MODE:#:{
  if ($ulist($address($nick,1)) == $null) { var %n = $nick $+ !*@*  | mode $chan +b %n | kick $chan $nick you are BLACKLISTED reason: $ulist(%n).info | ignore -pcntikd $ulist(%n) }
  else { mode $chan +b $ulist($address($nick,1)) | kick $chan $nick you are BLACKLISTED reason: $ulist($address($nick,1)).info | ignore -pcntikd $ulist($address($nick,1)) }
}
#blacklist end
alias avpop {
  if ($server != $null) { 
    if ($dialog(auto-voice) == $null) { dialog -m auto-voice auto-voice }
    if ($address($1,1) == $null) { whoial $$1 }
    else { av.list %i.nick }
  }
}
alias -l av.list {
  if ($dialog(auto-voice) != $null) {
    did -r auto-voice 10    
    did -a auto-voice 10 $address(%i.nick,0)
    did -a auto-voice 10 $address(%i.nick,1)
    did -a auto-voice 10 $address(%i.nick,2)
    did -a auto-voice 10 $address(%i.nick,3)
    did -a auto-voice 10 $address(%i.nick,4)
    did -a auto-voice 10 %i.nick $+ !*@*
    did -c auto-voice 10 4 | %i.addy = $address(%i.nick,3)
    dialog -t auto-voice auto-voice %i.nick  
    did -a auto-voice 5 $avoice($address(%i.nick,3)1).type
  }
}
dialog auto-voice {
  title "add to auto-voice"
  size -1 -1 119 126
  option dbu
  button "apply", 2, 46 112 29 9, ok
  combo 10, 5 15 108 50, edit hsbar drop
  check "enable auto-voice", 15, 6 4 60 10
  edit "", 1, 4 48 75 10, disable autohs
  text "add channel:", 3, 5 40 31 8
  button "add", 4, 83 48 29 9, disable
  list 5, 4 67 111 40, disable sort size vsbar
  text "auto-voice in:", 6, 6 59 35 8
  check "voice in all channels", 7, 6 28 60 10
}
on *:dialog:auto-voice:init:*: {
  if ($avoice == $true) { did -c auto-voice 15 }
  did -o auto-voice 1 1 %i.chan
  did -c auto-voice 7
}
alias -l avchan {
  var %i = 2
  %autovc = $did(auto-voice,5,1).text  
  :loop 
  if ($did(auto-voice,5,%i).text != $null) { %autovc = %autovc  $+ , $+ $did(auto-voice,5,%i).text | %autovc = %autovc | inc %i | goto loop }
  else { return %autovc }
}
on *:dialog:auto-voice:sclick:*: {
  if ($did == 2) { 
    if ($did(auto-voice,7).state == 1) && ($did(auto-voice,10).seltext != $null) { avoice $did(auto-voice,10).seltext | if ($dialog(voicelist) != $null) { .timer 1 1 voicelir } }
    elseif ($did(auto-voice,7).state == 1) && ($did(auto-voice,10).text != $null) { avoice $did(auto-voice,10).text | if ($dialog(voicelist) != $null) { .timer 1 1 voicelir } }
    elseif ($did(auto-voice,7).state == 0) && ($did(auto-voice,10).seltext != $null) { avoice $did(auto-voice,10).seltext $avchan | unset %autovc | if ($dialog(voicelist) != $null) { .timer 1 1 voicelir } }
    elseif ($did(auto-voice,7).state == 0) && ($did(auto-voice,10).text != $null) { avoice $did(auto-voice,10).text $avchan | unset %autovc | if ($dialog(voicelist) != $null) { .timer 1 1 voicelir } }
  }
  if ($did == 4) { if ($did(auto-voice,1) != $null) { did -i auto-voice 5 1 $did(auto-voice,1).text | did -e auto-voice 5 | did -r auto-voice 1 } }
  if ($did == 15) {
    if ($avoice == $true) { if ($dialog(voicelist) != $null) { did -u voicelist 3 } | .avoice off | did -u auto-voice 15 }
    else { if ($dialog(voicelist) != $null) { did -c voicelist 3 } | .avoice on | did -c auto-voice 15 }
  }
  if ($did == 7) {
    if ($did(auto-voice,7).state == 1) { did -b auto-voice 1,4,5 | did -r auto-voice 5 }
    elseif ($did(auto-voice,7).state == 0) { did -e auto-voice 1,4,5 }
  }
}

alias banpop {
  if ($server != $null) { 
    if ($dialog(banpop) == $null) { dialog -m banpop banpop }
    if ($address($1,1) == $null) { whoial $$1 }
    else { banaddy.list %i.nick }
  }
}
dialog banpop {
  title "ban/ kick"
  size -1 -1 153 51
  option dbu
  button "go!", 2, 119 15 29 10, ok
  combo 10, 5 15 108 50, edit drop
  check "kick", 15, 6 4 26 10
  combo 1, 5 35 108 50, sort edit drop
  text "reason:", 3, 5 27 18 8
  check "temporary", 4, 32 4 42 10
  edit "", 5, 98 2 26 10, hide
  text "unban", 6, 82 4 15 8, hide
  text "secs", 7, 126 4 21 8, hide
}
on *:dialog:banpop:init:*: {
  if ($_vr(banpop,temp) == $null) { _vw banop temp off }
  did -a banpop 1 spamming | did -a banpop 1 flooder | did -a banpop 1 annoyance | did -a banpop 1 lamer | did -a banpop 1 abusive
  if (%i.nick == $null) {  did -a banpop 10 <insert address> | did -c banpop 10 1 }
  if ($_vr(banpop,kick) == on) { did -c banpop 15 }
  if ($_vr(banpop,temp) == on) { did -c banpop 4 | did -v banpop 5,6,7 }
  if (%iw.time != $null) { did -o banpop 5 1 %iw.time }
  else { %iw.time = 300 | did -o banpop 5 1 %iw.time }
}
on *:dialog:banpop:edit:*: {
  if ($did == 1) { %i.reason = $did(1,$did(1).text) }
  if ($did == 5) { %iw.time = $did(5,$did(5).text) }
  if ($did == 10) { %i.addy = $did(10,$did(10).text) }
}
on *:dialog:banpop:sclick:*: {
  if ($did == 1) { %i.reason = $did(1,$did(1).sel) } 
  if ($did == 2) { 
    $odeop(%i.chan,%i.nick) 

    if ($_vr(banpop,temp) == on) { ban -u $+ %iw.time %i.chan %i.addy }
    else { ban %i.chan %i.addy }
    bkick
    unset %i.* 
  } 
  if ($did == 4) { 
    if ($_vr(banpop,temp) == off) { did -v banpop 5,6,7 | _vw banpop temp on }
    else { _vw banpop temp off | did -h banpop 5,6,7 }
  }
  if ($did == 10) { %i.addy = $did(banpop,10).text }
  if ($did == 15) { 
    if ($_vr(banpop,kick) != off) { _vw banpop kick off }
    else { _vw banpop kick on }
  }
}
alias -l bkick {
  if ($_vr(banpop,kick) == on) { kick %i.chan %i.nick %i.reason } 
}
alias -l banaddy.list {
  if ($dialog(banpop) != $null) {
    did -r banpop 10    
    did -a banpop 10 $address(%i.nick,0)
    did -a banpop 10 $address(%i.nick,1)
    did -a banpop 10 $address(%i.nick,2)
    did -a banpop 10 $address(%i.nick,3)
    did -a banpop 10 $address(%i.nick,4)
    did -a banpop 10 %i.nick $+ !*@*
    did -c banpop 10 4 | %i.addy = $address(%i.nick,3)
    dialog -t banpop ban/ kick %i.nick  
  }
}
alias popload  if ($dialog(popload) == $null) { dialog -m popload popload }
dialog popload {
  title "popup loader"
  size -1 -1 325 227
  tab "pops", 1, 7 30 311 187
  list 14, 16 84 132 116, tab 1 sort size hsbar vsbar
  edit "", 22, 16 60 292 21, tab 1 read autohs
  button "load", 28, 176 182 51 17, disable tab 1
  text "all popup files must be in sys\popups folder in order to be listed and loaded.", 6, 167 121 134 44, tab 1
  box "", 7, 160 112 148 56, tab 1
  check "reset to default on connect", 15, 156 89 148 20, tab 1
  button "unload", 16, 236 182 51 17, tab 1
  tab "remote pops", 8
  list 18, 16 84 132 100, tab 8 sort size hsbar vsbar
  list 20, 176 84 132 100, tab 8 sort size hsbar vsbar
  text "avalable remote popups", 23, 18 64 123 16, tab 8
  text "loaded remote popups", 24, 177 64 114 16, tab 8
  button "load", 25, 18 189 51 17, disable tab 8
  button "unload", 26, 177 189 51 17, disable tab 8
  radio "menubar", 2, 9 4 68 20, disable
  radio "status", 3, 80 4 52 20, disable
  radio "channel", 4, 138 4 60 20, disable
  radio "query", 5, 205 4 52 20, disable
  button "Button", 19, 48 356 75 25, ok
  radio "nicklist", 27, 262 5 60 20, disable
}
on *:dialog:popload:init:*: {
  if ($_vr(popload,reset) == $null) { _vw popload reset on }
  if ($_vr(popload,reset) == on) { did -c popload 15 }
  did -o popload 22 1 $readini(mirc.ini, pfiles, n3)
  poplist
  poprlist
  loadedp 
  popr
}
on *:dialog:popload:sclick:*: {
  if ($did == 1) { did -v popload 27,5,2,3,4 }
  if ($did == 2) && ($did(popload,14).sel != $null) { did -e popload 28 | did -o popload 22 1 $readini(mirc.ini, pfiles, n4) }
  if ($did == 3) && ($did(popload,14).sel != $null) { did -e popload 28 | did -o popload 22 1 $readini(mirc.ini, pfiles, n0) }
  if ($did == 4) && ($did(popload,14).sel != $null) { did -e popload 28 | did -o popload 22 1 $readini(mirc.ini, pfiles, n1) }
  if ($did == 5) && ($did(popload,14).sel != $null) { did -e popload 28 | did -o popload 22 1 $readini(mirc.ini, pfiles, n2) }
  if ($did == 8) { loadedp | did -ubh popload 27,5,2,3,4 }
  if ($did == 14) { did -b popload 28 | did -u popload 2,3,4,5,27 | popt }
  if ($did == 15) { 
    if ($_vr(popload,reset) == on) { _vw popload reset off }
    else { _vw popload reset on }
  }
  if ($did == 16) { def.pop | did -ub popload 27,5,2,3,4 | did -o popload 22 1 $readini(mirc.ini, pfiles, n0) | popr  }
  if ($did == 18) { did -e popload 25 }
  if ($did == 20) { did -e popload 26 }
  if ($did == 25) { .load -rs sys\popups\ $+ $did(popload,18).seltext | write -ds $+ $did(popload,18).seltext sys\popups\pops.dat | write sys\popups\pops.dat $did(popload,18).seltext | loadedp } 
  if ($did == 26) { .unload -rs sys\popups\ $+ $did(popload,20).seltext | .timer -m 1 1 write -ds $+ $did(popload,20).seltext sys\popups\pops.dat | .timer -m 1 1 loadedp } 
  if ($did == 27) && ($did(popload,14).sel != $null) { did -e popload 28 | did -o popload 22 1 $readini(mirc.ini, pfiles, n3) }
  if ($did == 28) { load $ntype sys\popups\ $+ $did(popload,14).seltext | popupsv }
}
alias -l popr {
  if ($read($usw2, s, [cpopup]) != $null) { did -e popload 4 }
  if ($read($usw2, s, [qpopup]) != $null) { did -e popload 5 }
  if ($read($usw2, s, [lpopup]) != $null) { did -e popload 27 }
  if ($read($usw2, s, [bpopup]) != $null) { did -e popload 2 }
  if ($read($usw2, s, [mpopup]) != $null) { did -e popload 3 }
}
alias -l usw2 {
  return $did(popload,22).text
}

alias -l popupsv {
  if ($did(popload,2).state == 1) { did -o popload 22 1 $readini(mirc.ini, pfiles, n4) }
  elseif ($did(popload,3).state == 1) { did -o popload 22 1 $readini(mirc.ini, pfiles, n0) }
  elseif ($did(popload,4).state == 1) { did -o popload 22 1 $readini(mirc.ini, pfiles, n1) }
  elseif ($did(popload,5).state == 1) { did -o popload 22 1 $readini(mirc.ini, pfiles, n2) }
  elseif ($did(popload,27).state == 1) { did -o popload 22 1 $readini(mirc.ini, pfiles, n3) }
}
alias -l ntype {
  if ($did(popload,2).state == 1) { return -pm }
  elseif ($did(popload,3).state == 1) { return -ps }
  elseif ($did(popload,4).state == 1) { return -pc }
  elseif ($did(popload,5).state == 1) { return -pq }
  elseif ($did(popload,27).state == 1) { return -pn }
}
alias -l poplist {
  var %t = $findfile(sys\popups,*.ini,0)
  var %t1 = 1 
  while (%t1 <= %t) { did -a popload 14 $nopath($findfile(sys\popups,*.ini,%t1)) | inc %t1 1 }
}
alias -l poprlist {
  var %t = $findfile(sys\popups,*.mrc,0)
  var %t1 = 1 
  while (%t1 <= %t) { did -a popload 18 $nopath($findfile(sys\popups,*.mrc,%t1)) | inc %t1 1 }
}
alias -l loadedp {
  did -r popload 20
  var %l = $lines(sys\popups\pops.dat)
  var %lw = 1
  while (%lw <= %l) { did -a popload 20 $read(sys\popups\pops.dat,%lw) | inc %lw } 
}
alias -l def.pop {
  .load -pm sys\popups\default.ini
  .load -ps sys\popups\default.ini
  .load -pq sys\popups\default.ini
  .load -pc sys\popups\default.ini
  .load -pn sys\popups\default.ini
}
on *:connect: {
  if ($_vr(popload,reset) == on) { def.pop }
}
alias -l usw {
  return sys\popups\ $+ $did(popload,14).seltext
}
alias -l popt {
  did -b popload 2,3,4,5,27 
  if ($read($usw, w, [cpopup]) != $null) { did -e popload 4 }
  if ($read($usw, w, [qpopup]) != $null) { did -e popload 5 }
  if ($read($usw, w, [lpopup]) != $null) { did -e popload 27 }
  if ($read($usw, w, [bpopup]) != $null) { did -e popload 2 }
  if ($read($usw, w, [mpopup]) != $null) { did -e popload 3 }
}
alias gender { 
  if ($_vr(info,gender) == male) { return his }
  elseif ($_vr(info,gender) == female) { return her }
  elseif ($_vr(info,gender) == unknown) { return his/her }
} 
alias gender2 { 
  if ($_vr(info,gender) == male) { return him }
  elseif ($_vr(info,gender) == female) { return her }
  elseif ($_vr(info,gender) == unknown) { return him/her }
} 
alias aopop {
  if ($server != $null) { 
    if ($dialog(auto-op) == $null) { dialog -m auto-op auto-op }
    if ($address($1,1) == $null) { whoial $$1 }
    else { ao.list %i.nick }
  }
}
alias -l ao.list {
  if ($dialog(auto-op) != $null) {
    did -r auto-op 10    
    did -a auto-op 10 $address(%i.nick,0)
    did -a auto-op 10 $address(%i.nick,1)
    did -a auto-op 10 $address(%i.nick,2)
    did -a auto-op 10 $address(%i.nick,3)
    did -a auto-op 10 $address(%i.nick,4)
    did -a auto-op 10 %i.nick $+ !*@*
    did -c auto-op 10 4 | %i.addy = $address(%i.nick,3)
    dialog -t auto-op auto-op %i.nick  
    did -a auto-op 5 $aop($address(%i.nick,3)1).type
  }
}
dialog auto-op {
  title "add to auto-op"
  size -1 -1 119 126
  option dbu
  button "apply", 2, 46 112 29 9, ok
  combo 10, 5 15 108 50, edit hsbar drop
  check "enable auto-op", 15, 6 4 60 10
  edit "", 1, 4 48 75 10, disable autohs
  text "add channel:", 3, 5 40 31 8
  button "add", 4, 83 48 29 9, disable
  list 5, 4 67 111 40, disable sort size vsbar
  text "auto-op in:", 6, 6 59 35 8
  check "op in all channels", 7, 6 28 60 10
}
on *:dialog:auto-op:init:*: {
  if ($aop == $true) { did -c auto-op 15 }
  did -o auto-op 1 1 %i.chan
  did -c auto-op 7
}
alias -l aochan {
  var %i = 2
  %autoop1 = $did(auto-op,5,1).text  
  :loop 
  if ($did(auto-op,5,%i).text != $null) { %autoop1 = %autoop1  $+ , $+ $did(auto-op,5,%i).text | %autoop1 = %autoop1 | inc %i | goto loop }
  else { return %autoop1 }
}
on *:dialog:auto-op:sclick:*: {
  if ($did == 2) { 
    if ($did(auto-op,7).state == 1) && ($did(auto-op,10).seltext != $null) { aop $did(auto-op,10).seltext | if ($dialog(aop1list) != $null) { .timer 1 1 aoplir } }
    elseif ($did(auto-op,7).state == 1) && ($did(auto-op,10).text != $null) { aop $did(auto-op,10).text | if ($dialog(aop1list) != $null) { .timer 1 1 aoplir } }
    elseif ($did(auto-op,7).state == 0) && ($did(auto-op,10).seltext != $null) { aop $did(auto-op,10).seltext $aochan | unset %autoop1 | if ($dialog(aop1list) != $null) { .timer 1 1 aoplir } }
    elseif ($did(auto-op,7).state == 0) && ($did(auto-op,10).text != $null) { aop $did(auto-op,10).text $aochan | unset %autoop1 | if ($dialog(aop1list) != $null) { .timer 1 1 aoplir } }
  }
  if ($did == 4) { if ($did(auto-op,1) != $null) { did -i auto-op 5 1 $did(auto-op,1).text | did -e auto-op 5 | did -r auto-op 1 } }
  if ($did == 15) {
    if ($aop == $true) { if ($dialog(aop1list) != $null) { did -u aop1list 3 } | .aop off | did -u auto-op 15 }
    else { if ($dialog(aop1list) != $null) { did -c aop1list 3 } | .aop on | did -c auto-op 15 }
  }
  if ($did == 7) {
    if ($did(auto-op,7).state == 1) { did -b auto-op 1,4,5 | did -r auto-op 5 }
    elseif ($did(auto-op,7).state == 0) { did -e auto-op 1,4,5 }
  }
}
