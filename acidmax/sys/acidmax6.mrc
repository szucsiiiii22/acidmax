#team-nexgen off
on *:connect: {
  if ($network == nexnet) { join #nexgen }
  .disable #team-nexgen
}
#team-nexgen end
alias nickr {
  if ($exists(data\nicks.ini) == $false) { mkdir data | write -c data\nicks.ini }
  return $readini data\nicks.ini $$1 $$2 
}
alias nickw {
  if ($file(data\nicks.ini).size > 54710) { .remove data\nicks.ini }
  if ($exists(data\nicks.ini) == $false) { mkdir data | write -c data\nicks.ini }
  writeini data\nicks.ini $$1 $$2 $$3-
}
alias prenick {
  if ($nickr($2,$3) == $nick) { return } 
  elseif ($nickr($2,$3) != $null) { return [aka: $nickr($2,$3) $+ $chr(93) }
}
on *:quit: {
  nickw $address($nick,3) $nick
}
on *:part:#: {
  nickw $chan $address($nick,3) $nick
}
on *:start: if ($file(data\nicks.ini).size > 54710) { .remove data\nicks.ini }
alias ignorelist if ($dialog(ignorelist) == $null) { dialog -m ignorelist ignorelist }
dialog ignorelist {
  title "ignore list"
  size -1 -1 311 157
  option pixels
  list 1, 3 27 305 102, sort size extsel hsbar vsbar
  button "close", 50, 252 132 55 20, default ok
  button "clear", 51, 130 132 55 20
  button "remove", 2, 70 132 55 20
  check "enable ignore", 3, 8 3 110 20
  button "add", 4, 10 132 55 20
}
on *:dialog:ignorelist:init:*: {
  if ($ignore == $true) { did -c ignorelist 3 }
  ignorelir
}
on *:dialog:ignorelist:sclick:*: {
  if ($did == 51) { if ($input(clear the ignore list?,8)) { ignore -r | did -r ignorelist 1 } }
  if ($did == 2) { ignore -r $did(ignorelist,1).seltext | ignorelir }
  if ($did == 4) { ignorepop }
  if ($did == 3) {
    if ($ignore == $true) { .ignore off | did -u ignorelist 3 }
    else { .ignore on | did -c ignorelist 3 }
  }
}
alias -l ignorelir {
  did -r ignorelist 1,1 | var %i = $ignore(0) | while (%i) { did -a ignorelist 1 $ignore(%i) | dec %i | did -z ignorelist 1 }
}
alias kick {
  if ($_vr(stats,kicksw) == $null) { _vw stats kicksw on }
  kick $$1- $kickcount
}
alias kickcount {
  if ($_vr(stats,kicksw) == on) {
  _vw stats kicks $calc($_vr(stats,kicks) + 1) | return $chr(91) $+ kick count: $+ $_vr(stats,kicks)) $+ $chr(93) }
}
alias blacklist {
  if ($dialog(blacklist) == $null)  { dialog -m blacklist blacklist }
}
dialog blacklist {
  title "blacklist"
  size -1 -1 311 157
  option pixels
  list 1, 3 27 305 102, sort size extsel hsbar vsbar
  button "close", 50, 252 132 55 20, default ok
  button "clear", 51, 130 132 55 20
  button "remove", 2, 70 132 55 20
  check "enable blacklist", 3, 8 3 110 20
  button "add", 4, 10 132 55 20
}
on *:dialog:blacklist:init:*: {
  if ($group(#blacklist) == on) { did -c blacklist 3 }
  blacklir
}
on *:dialog:blacklist:sclick:*: {
  if ($did == 51) { if ($input(clear the blacklist?,8)) { rlevel blacklisted | did -r blacklist 1 } }
  if ($did == 2) { ruser blacklisted $did(blacklist,1).seltext | blacklir }
  if ($did == 3) { 
    if ($group(#blacklist) == on) { if ($dialog(blacklistpop) != $null) { did -u blacklistpop 15 } | .disable #blacklist | did -u blacklist 3 }
    else { if ($dialog(blacklistpop) != $null) { did -c blacklistpop 15 } | .enable #blacklist | did -c blacklist 3 }
  }
  if ($did == 4) { blacklistpop }
}
alias blacklir {
  did -r blacklist 1,1 | var %i = $ulist(*,blacklisted) | while (%i) { if ($ulist(*,blacklisted,%i) != $null) { did -a blacklist 1 $ulist(*,blacklisted,%i) } | dec %i | did -z blacklist 1 }
}
alias voicelist if ($dialog(voicelist) == $null) { dialog -m voicelist voicelist }
dialog voicelist {
  title "auto-voice list"
  size -1 -1 311 157
  option pixels
  list 1, 3 27 305 102, sort size extsel hsbar vsbar
  button "close", 50, 252 132 55 20, default ok
  button "clear", 51, 130 132 55 20
  button "remove", 2, 70 132 55 20, disable
  check "enable auto-voice", 3, 8 3 110 20
  button "add", 4, 10 132 55 20
}
on *:dialog:voicelist:init:*: {
  voicelir
  if ($avoice == $true) { did -c voicelist 3 }
  if ($network == $null) { did -b voicelist 2,4 }
}
on *:dialog:voicelist:sclick:*: {
  if ($did == 1) && ($did(voicelist,1).seltext != $null) { did -e voicelist 2 }
  if ($did == 51) { if ($input(clear the auto-voice list?,8)) { voice.clear } }
  if ($did == 2) { avoice -rw $did(voicelist,1).seltext | voicelir }
  if ($did == 4) { avpop }
  if ($did == 3) {
    if ($avoice == $true) { if ($dialog(auto-voice) != $null) { did -u auto-voice 15 } | .avoice off | did -u voicelist 3 }
    else { if ($dialog(auto-voice) != $null) { did -c auto-voice 15 } | .avoice on | did -c voicelist 3 }
  }
}
alias voicelir {
  did -b voicelist 2 | did -r voicelist 1,1 | var %i = $avoice(0) | while (%i) { did -a voicelist 1 $avoice(%i) | dec %i | did -z voicelist 1 }
}
alias -l voice.clear {
  var %i = $avoice(0) | while (%i) { avoice -r $avoice(%i) | dec %i | did -r voicelist 1 }
}
alias aoplist if ($dialog(aop1list) == $null) { dialog -m aop1list aop1list }
dialog aop1list {
  title "auto-op list"
  size -1 -1 311 157
  option pixels
  list 1, 3 27 305 102, sort size extsel hsbar vsbar
  button "close", 50, 252 132 55 20, default ok
  button "clear", 51, 130 132 55 20
  button "remove", 2, 70 132 55 20, disable
  check "enable auto-op", 3, 8 3 110 20
  button "add", 4, 10 132 55 20
}
on *:dialog:aop1list:init:*: {
  if ($aop == $true) { did -c aop1list 3 }
  aoplir
}
on *:dialog:aop1list:sclick:*: {
  if ($did == 1) && ($did(aop1list,1).seltext != $null) { did -e aop1list 2 }
  if ($did == 51) { if ($input(clear the auto-aop list?,8)) { aop.clear } }
  if ($did == 2) { aop -rw $did(aop1list,1).seltext | aoplir }
  if ($did == 4) { aopop }
  if ($did == 3) {
    if ($aop == $true) { if ($dialog(auto-op) != $null) { did -u auto-op 15 } | .aop off | did -u aop1list 3 }
    else { if ($dialog(auto-op) != $null) { did -c auto-op 15 } | .aop on | did -c aop1list 3 }
  }
}
alias aoplir {
  did -b aop1list 2 | did -r aop1list 1,1 | var %i = $aop(0) | while (%i) { did -a aop1list 1 $aop(%i) | dec %i | did -z aop1list 1 }
}
alias -l aop.clear {
  var %i = $aop(0) | while (%i) { aop -r $aop(%i) | dec %i | did -r aop1list 1 }
}

;*** MSGPOP by RAIN
alias msgpop {
  if ($_vr(general,querypop) == on) {  
    window -Baprkhod +Ld @msgpop 250 150 150 100
    window -Barpkod +Ld @msgpop 250 150 150 100
    drawrect -rf @msgpop $rgb(78,113,160) 0 0 0 150 100
    drawrect -r @msgpop $rgb(222,198,164) 2 0 0 150 100
    drawrect -rf @msgpop $rgb(222,198,164) 0 8 20 134 64
    drawtext -r @msgpop $rgb(241,230,216) Tahoma 11 8 3 Query active
    drawtext -ro @msgpop $rgb(241,230,216) Tahoma 11 135 2 ::
    drawtext -r @msgpop $rgb(78,113,160) Tahoma 11 15 25 Query message from:
    drawtext -r @msgpop $rgb(78,113,160) Tahoma 11 15 70 $asctime(hh:nn tt)
    .timerclose 1 6 window -c @msgpop
  }
}
on *:OPEN:?:*: {
  if ($_vr(general,querypop) == on) { 
    if ($appstate == minimized) { msgpop | drawrect -r @msgpop $rgb(222,198,164) 0 14 41 127 18 | drawtext -ro @msgpop $rgb(78,113,160) Tahoma 11 16 43 $nick }
    if ($appactive == $false) { msgpop | drawrect -r @msgpop $rgb(222,198,164) 0 14 41 127 18 | drawtext -ro @msgpop $rgb(78,113,160) Tahoma 11 16 43 $nick }
    else { return }
  }
}
;%cbc = active channel
;%cbn = total users
alias channel {
  if ($server != $null) { 
    if ($_vr(opcon,switch) == $null) { _vw opcon switch on }
    if ($_vr(opcon,switch) == on) { opcon }
    else channel
  }
  else { echo -a •4• error » not connected to server.  }
}
alias opcon { %cbc = $chan | if ($_vr(opcon,size) == $null) { _vw opcon size small } | if ($ial == $false) ial on | updatenl | %cbn = $nick(%cbc,0,a) | %ocops = $opnick($chan,0) | if ($me isop %cbc) %cbc.op = yes | if ($dialog(opcon) == $null) { if (%cbc != $null) { dialog -m opcon opcon } | else halt } }
dialog opcon {
  title ""
  size -1 -1 330 314
  option pixels
  button "op", 1, 174 64 40 18, disable
  list 4, 6 54 160 146, sort size hsbar vsbar
  edit "", 5, 184 196 30 20, read center
  text "total", 10, 188 180 26 14
  edit "", 16, 216 196 30 20, read autohs center
  text "op(s)", 9, 220 180 28 14
  edit "", 19, 248 196 30 20, read autohs center
  text "voice", 18, 250 180 28 14
  edit "", 26, 8 232 282 20, disable autohs
  text "op notice", 27, 8 218 48 14, disable
  button "send", 28, 294 232 30 18, disable
  edit "", 8, 26 30 202 20, read autohs
  button "deop", 11, 174 84 40 18, disable
  button "kick", 20, 174 104 40 18, disable
  button "ban", 24, 174 124 40 18, disable
  button "+v", 12, 220 64 40 18, disable
  button "-v", 14, 220 84 40 18, disable
  button "+b Kick", 25, 220 104 40 18, disable
  button " ", 37, 220 124 40 18, disable
  box "", 13, 172 54 92 92
  check "replace channel central", 44, 4 4 142 20
  list 46, 8 480 314 110, sort size hsbar vsbar
  button "unban", 98, 8 594 48 18, disable
  edit "", 100, 8 450 266 20, autohs
  text "topic:", 101, 8 434 32 14, disable
  button "apply", 102, 278 452 44 18, disable
  button "save as default", 103, 48 432 84 16, disable
  button "use default", 104, 138 432 64 16, disable
  check "secret [+s]", 204, 6 316 76 20
  check "invite only [+i]", 205, 6 336 92 20
  check "limited user [+l]", 206, 6 356 94 20
  edit "", 260, 106 356 40 20, autohs
  check "moderated [+m]", 207, 6 376 100 20
  check "private [+p]", 208, 184 318 82 20
  check "key [+k]", 209, 184 338 60 20
  check "topic [+t]", 210, 184 358 72 20
  check "external messages [+n]", 211, 184 378 140 20
  edit "", 250, 248 338 70 20, autohs
  button "Button", 3, 114 668 74 24, cancel
  button "send", 7, 294 266 30 18
  edit "", 15, 8 266 282 20, autohs
  text "channel notice", 17, 8 252 70 14
  button "copy", 21, 230 30 30 18, disable
  text "halfop", 22, 280 180 30 14
  edit "", 23, 280 196 30 20, read autohs center
  box "channel stats", 29, 178 166 140 58
  button "auto-op", 30, 266 48 60 18, disable
  button "auto-voice", 31, 266 68 60 18, disable
  button "protect", 32, 266 88 60 18, disable
  button "ignore", 33, 266 110 60 18, disable
  button "blacklist", 34, 266 130 60 18, disable
  button "channel central", 36, 4 290 88 18
  check "auto refresh list", 38, 8 200 100 20
  button "refresh", 2, 120 202 47 18
  text "", 6, 139 6 185 16, right
  button "R", 35, 8 31 16 16
  text "idle in chan:", 39, 173 151 61 16
  text "", 40, 233 151 91 16
  button "apply modes", 41, 215 398 71 20, disable
  check "registered users only", 42, 6 396 124 20, hide
}
on *:nick: if ($dialog(opcon) != $null)  { updatenl | if ($_vr(opcon,refresh) == on) { opcon.refresh } }
on *:join:   if ($dialog(opcon) != $null) && ($nick ison %cbc) { did -i opcon 4 1 -  $nick | updatenl  | if ($_vr(opcon,refresh) == on) { opcon.stat } }
on *:part: if ($dialog(opcon) != $null) && ($nick ison %cbc) { did -d opcon 4 1 $nick(%cbc,%cbn.1) | updatenl | if ($_vr(opcon,refresh) == on) { opcon.stat } } 
on *:quit: if ($dialog(opcon) != $null) && ($nick ison %cbc) { did -d opcon 4 1 $ov $nick(%cbc,%cbn.1) | updatenl | if ($_vr(opcon,refresh) == on) { opcon.stat } }
on *:kick: if ($dialog(opcon) != $null) && ($nick ison %cbc) { did -d opcon 4 1 $ov $nick(%cbc,%cbn.1) | updatenl |if ($_vr(opcon,refresh) == on) {  opcon.stat } }
on *:op:%cbc: if ($dialog(opcon) != $null)  { if ($_vr(opcon,refresh) == on) { opcon.refresh } }
on *:deop:%cbc: if ($dialog(opcon) != $null) { if ($_vr(opcon,refresh) == on) { opcon.refresh } }
on *:voice:%cbc: if ($dialog(opcon) != $null) { if ($_vr(opcon,refresh) == on) { opcon.refresh } }
on *:devoice:%cbc: if ($dialog(opcon) != $null) { if ($_vr(opcon,refresh) == on) { opcon.refresh } }
on *:topic:%cbc: if ($dialog(opcon) != $null) { did -o opcon 100 1 $chan(%cbc).topic  }
alias -l opcon.stat {
  did -o opcon 5 1 $nick(%cbc,0,a) | did -o opcon 16 1 $nick(%cbc,0,o,hvr) | did -o opcon 19 1 $nick(%cbc,0,v,rho) | did -o opcon 23 1 $nick(%cbc,0,h,rvho) 
}
alias -l opcon.c {
  set %cbn $nick(%cbc,0,a)
}
on *:active:*: {
  if ($dialog(opcon)) {
    if ($_vr(opcon,switch) == on) {
      did -r opcon 40,8,39     
      scid $activecid | %cbc = $chan | opcon.refresh
    }
  }
}
alias -l opcon.refresh {
  did -b opcon 21,30,31,32,33,34
  dialog -t opcon v3.02 operator central ( $+ %cbc $+ )
  did -o opcon 6 1 %cbc 
  did -r opcon 4,39,40,8
  did -o opcon 100 1 $chan(%cbc).topic 
  oc.mode 
  opcon.c 
  opcon.stat
  set %i $nick(%cbc,0,a)
  :loop
  did -i opcon 4 1 $ov $+ $nick(%cbc,%i)
  if (%i <= 0) goto end
  else dec %i 1 | goto loop
  :end
  did -d opcon 4 1
  unset %i
  if ($me isop %cbc) { 
    did -e opcon 46,11,20,24,12,14,25,1,26,98,27,28,101,103,104,41
    if ($network == undernet) { did -v opcon 42 | did -e opcon 42 } 
    if ($network !== undernet) { did -h opcon 42 } 
    ; if (l !isin %oc.mode) did -b opcon 260
    ; if (k !isin %oc.mode) did -b opcon 250
  }
  elseif ($me !isop %cbc) {
    did -b opcon 11,20,24,12,14,25,1,26,98,28,27,101,103,104,41
    if ($network != undernet) { did -h opcon 42 | did -b opcon 42 } 

  }
  if (%oc.l != $null) did -a opcon 260 %oc.l
  if (%oc.k != $null) did -a opcon 250 %oc.k
}
alias -l ov {
  if ($nick(%cbc,%i) isop %cbc) return $chr(64) 
  elseif  ($nick(%cbc,%i) isvo %cbc) return $chr(43)  
  else return $chr(160) 
}

on *:dialog:opcon:init:*:{
  if ($_vr(opcon,size) == big) { dialog -s opcon -1 -1 330 618 }
  elseif ($_vr(opcon,size) == small) { dialog -s opcon -1 -1 330 314 }
  opcon.init
  if ($_vr(opcon,switch) == $null) { _vw opcon switch on }
  if ($_vr(opcon,switch) == on) { did -c opcon 44 }
  if ($_vr(opcon,refresh) == on) { did -c opcon 38 }
  did -r opcon 39
}
alias -l opcon.init {
  if ($nick(%cbc,2) != $null) { did -f opcon 1 }
  did -r opcon 46,8
  mode %cbc b
  did -r opcon 46,8
  ;  if (%oc.l != $null) did -a opcon 260 %oc.l 
  opcon.refresh
}
alias -l addy1 {
  set %oc.1 $len($did(opcon,4).seltext) 
  if ($did(opcon,4).seltext isop %cbc) { dec %oc.1 2 }
  elseif ($did(opcon,4).seltext isvo %cbc) { dec %oc.1 2 }
  else  dec %oc.1 3
  set %addy21 $did(opcon,4, $did(opcon,4,1).sel).text
  set %addy21 $mid(%addy21,3,$len(%addy21))
  return $address(%addy21,1)
}

alias -l rc2 {
  var %i = $len($1)
  dec %i 1
  return  $right($1,%i)
}
on *:dialog:opcon:dclick:*:if ($did == 4) { query $rc2($did(opcon,4).seltext) }
on *:dialog:opcon:sclick:*:{
  updatenl
  if ($did == 41) { 
    set %oc.p +
    set %oc.m -
    unset %oc.a
    if ($did(opcon,42).state == 1) && ($network == undernet) { mode %cbc +r }
    elseif ($did(opcon,42).state != 1) && ($network == undernet) {  mode %cbc -r }
    if ($did(opcon,204).state == 1) set %oc.p %oc.p $+ s
    else set %oc.m %oc.m $+ s
    if ($did(opcon,205).state == 1) set %oc.p %oc.p $+ i
    else set %oc.m %oc.m $+ i
    if ($did == 206) {  
      if (($did(opcon,206).state == 1) && ($did(opcon,260).text != $null) && ($did(opcon,260).text isnum)) { set %oc.p %oc.p $+ l | set %oc.a $did(opcon,260).text }
      else { set %oc.m %oc.m $+ l }
    }
    if ($did(opcon,207).state == 1) set %oc.p %oc.p $+ m
    else set %oc.m %oc.m $+ m
    if ($did(opcon,208).state == 1) set %oc.p %oc.p $+ p
    else set %oc.m %oc.m $+ p
    if ($did == 209) { 
      if (($did(opcon,209).state == 1) && ($did(opcon,250).text != $null)) { %oc.p = %oc.p $+ k | %oc.a = %oc.a $did(opcon,250).text }
      else { set %oc.m %oc.m $+ k | set %oc.a %oc.a $chan(%cbc).key }
    } 
    if ($did(opcon,210).state == 1) set %oc.p %oc.p $+ t
    else set %oc.m %oc.m $+ t
    if ($did(opcon,211).state == 1) set %oc.p %oc.p $+ n
    else set %oc.m %oc.m $+ n
    if ($me isop %cbc)  mode %cbc %oc.p $+ %oc.m %oc.a
  }
  if ($did == 24) { if ($did(4).sel != $null) { mode %cbc -o $rc($did(opcon,4).seltext) | ban %cbc $address($rc($did(opcon,4).seltext),1) | opcon.init } }
  if ($did == 25) { 
    if ($did(4).sel != $null) { 
      mode %cbc -o $address($rc($did(opcon,4).seltext),1) 
      ban %cbc $address($rc($did(opcon,4).seltext),1)
      kick %cbc $rc2($did(opcon,4).seltext)  
      opcon.init  
    } 
  }
  if ($did == 4) {   
    did -o opcon 8 1 $address($rc2($did(opcon,4).seltext),1)  
    if ($did(opcon,8).text != null) { did -e opcon 21,30,31,32,33,34 | did -r opcon 40 | did -o opcon 39 1 idle in chan: | did -o opcon 40 1 $duration($nick(%cbc,$rc2($did(opcon,4).seltext)).idle) }  
    else { did -b opcon 21 | did -r opcon 40,39 }  
  }
  if ($did == 1) { if ($did(4).sel != $null) { mode %cbc +o $rc2($did(opcon,4).seltext) } }
  if ($did == 11) { if ($did(4).sel != $null) { mode %cbc -o $rc2($did(opcon,4).seltext) } }
  if ($did == 12) { if ($did(4).sel != $null) { mode %cbc +v $rc2($did(opcon,4).seltext) } }
  if ($did == 14) { if ($did(4).sel != $null) { mode %cbc -v $rc2($did(opcon,4).seltext) } }
  if ($did == 20) { if ($did(4).sel != $null) { kick %cbc $rc2($did(opcon,4).seltext) } }
  if ($did == 21) { if ($did(opcon,8).text != null) { clipboard $did(opcon,8).text } }
  if ($did == 28) { onotice %cbc $did(opcon,26).text | did -o opcon 26 1 }
  if ($did == 30) { %i.nick = $rc2($did(opcon,4).seltext) | aopop $rc2($did(opcon,4).seltext) }
  if ($did == 31) { %i.nick = $rc2($did(opcon,4).seltext) | %i.chan = %cbc | avpop $rc2($did(opcon,4).seltext) }
  if ($did == 32) { %i.nick = $rc2($did(opcon,4).seltext) | %i.chan = %cbc | protectpop $rc2($did(opcon,4).seltext) }
  if ($did == 33) { %i.nick = $rc2($did(opcon,4).seltext) | ignorepop $rc2($did(opcon,4).seltext) }
  if ($did == 34) { %i.nick = $rc2($did(opcon,4).seltext) | %i.chan = %cbc | blacklistpop $rc2($did(opcon,4).seltext) }
  if ($did == 2) { opcon.refresh }
  if ($did == 35) { did -r opcon 39,40 | did -b opcon 21 | .who %cbc | did -o opcon 8 1 refreshing Internal Address List... | .timer 1 10 did -o opcon 8 1 refreshing complete | opcon.refresh }
  if ($did == 38) {
    if ($_vr(opcon,refresh) != on) { _vw opcon refresh on }
    else { _vw opcon refresh off }
  }  
  if ($did == 102) {
    if ($did(opcon,100).text != $null) topic %cbc $did(opcon,100).text
    else topic %cbc $chr(160) 
  }
  if ($did == 103) { if ($did(opcon,100).text != $null) { _vw opcon deftopic $did(opcon,100).text } }
  if ($did == 104) { if ($_vr(opcon,deftopic) != $null) { did -o opcon 100 1 $_vr(opcon,deftopic) } }
  if ($did == 36) { 
    if ($_vr(opcon,size) == small) { _vw opcon size big | dialog -s opcon -1 -1 330 618 }  
    elseif ($_vr(opcon,size) == big) { _vw opcon size small | dialog -s opcon -1 -1 330 314 }
  }
  if ($did == 99) { %cbc = $did(opcon,99).seltext | opcon.init }
  if ($did == 98) {
    var %oc.unban1 = 0
    var %oc.unban = 0
    :unban
    inc %oc.unban 1
    inc %oc.unban1 1
    if ($did(opcon,46,%oc.unban).sel != $null) {
      if ($me isop %cbc) {
        set %oc.ban %oc.ban $mid($did(opcon,46,$did(opcon,46,%oc.unban).sel).text,1,$calc($pos($did(opcon,46,$did(opcon,46,%oc.unban).sel).text,$chr(32),1)-1)  )
        if ($calc(%oc.unban1 % 4) == 0) { mode %cbc -bbbb %oc.ban | unset %oc.ban | set %oc.unban1 0 }
      }
      goto unban
    }
    dec %oc.unban1
    if (%oc.ban != $null) { mode %cbc $str(-b,%oc.unban1) %oc.ban | unset %oc.ban | set %oc.unban1 0 }
    var %oc.unban = 0
    :unban1
    inc %oc.unban 1
    if ($did(opcon,46,1).sel != $null) { did -d opcon 46 $did(opcon,46,1).sel | goto unban1 }
  }
  if ($did == 44) { if ($_vr(opcon,switch) == off) { _vw opcon switch on } 
    else _vw opcon switch off 
  }
}
raw 367:*: {
  if ($dialog(opcon) != $null) {
    if (%cbc == $2) {
      did -a opcon 46 $3-4 $asctime($5)
      haltdef  
    }
  }
  else { halt }
}
raw 368:*: { halt }
alias oc.mode {
  did -u opcon 204,205,206,207,208,209,210,211
  did -e opcon 204,205,206,207,208,209,210,211
  if ($chr(32) isin $chan(%cbc).mode) var %oc.mode = $mid($chan(%cbc).mode,2,$calc($pos($chan(%cbc).mode,$chr(32),1)-2))
  else var %oc.mode = $mid($chan(%cbc).mode,2,$len($chan(%cbc).mode) )
  if (l isin %oc.mode) {
    if (k isin %oc.mode) {
      var %oc.l = $mid($chan(%cbc).mode,$calc($pos($chan(%cbc).mode,$chr(32),1)+1),$calc($pos($chan(%cbc).mode,$chr(32),2)))
      var %oc.k = $mid($chan(%cbc).mode,$calc($pos($chan(%cbc).mode,$chr(32),2)+1),$len($chan(%cbc).mode))
      var %oc.l = $remove(%oc.l, %oc.k)
    }
    else {
      var %oc.l = $mid($chan(%cbc).mode,$calc($pos($chan(%cbc).mode,$chr(32),1)+1),$len($chan(%cbc).mode))
    }
  }
  elseif (k isin %oc.mode) var %oc.k = $mid($chan(%cbc).mode,$calc($pos($chan(%cbc).mode,$chr(32),1)+1),$len($chan(%cbc).mode))
  if ($me !isop %cbc) {
    did -b opcon 204,205,206,207,208,209,210,211
    if ($network == undernet) { did -v opcon 42 | did -b opcon 42 } 
    if ($network !== undernet) { did -h opcon 42 }
  }
  if ($me isop %cbc) || ($me !isop %cbc) {
    if (s isin %oc.mode) did -c opcon 204
    if (i isin %oc.mode) did -c opcon 205
    if (l isin %oc.mode) did -c opcon 206
    if (m isin %oc.mode) did -c opcon 207
    if (p isin %oc.mode) did -c opcon 208
    if (k isin %oc.mode) did -c opcon 209
    if (t isin %oc.mode) did -c opcon 210 | did -e opcon 102
    if (t !isin %oc.mode) did -b opcon 102
    if (n isin %oc.mode) did -c opcon 211
    if (r isin %oc.mode) did -c opcon 42
  }
}
raw 367:*: if ($dialog(opcon) != $null) halt 
raw 368:*: if ($dialog(opcon) != $null) halt 
raw 352:*: if ($dialog(opcon) != $null) halt 
raw 315:*: if ($dialog(opcon) != $null) halt 
alias -l nw {
  if ($network != $null) { return 14»4» $network $+ : }
  else { return 14»4» $server $+ : }
}
on *:SNOTICE:*:{
  if ($_vr(snotices,switch) == $null) { _vw snotices switch off }
  if ($_vr(snotices,switch) == on) {
    if ($window(@snotices) == $null) { window -eRnk0 @snotices -1 -1 450 330 }
    aline @snotices $timestamp $nw 14 $+ $1-
  }
}
