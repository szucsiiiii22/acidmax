;Security v1.0
;Team Nexgen 2000 by KnightFal
;www.team-nexgen.org


alias pr {
  if ($exists(data\protect.ini) == $false) { write -c data\protect.ini }
  return $readini data\protect.ini $1 $2 
}
alias pw {
  if ($exists(data\protect.ini) == $false) { write -c data\protect.ini }
  writeini data\protect.ini $1 $$2 $$3-
}
alias prem {
  if ($exists(data\protect.ini) == $false) { write -c data\protect.ini }
  remini data\protect.ini $1 $2 
}
on *:LOAD: {
  if ($pr(banprotect,switch) == $null) { chanprot.load | ctcpprot.reset }
}
on @*:TEXT:*:#: if ($pr(kick,text) == 1) { protectu $nick $chan $1- }
on @*:ACTION:*:#: if ($pr(kick,action) == 1) { protectu $nick $chan $1- }
on @*:NOTICE:*:#: if ($pr(kick,notice) == 1) { protectu $nick $chan $1- }
on @*:JOIN:#: updatenl | if ($pr(kick,nick) == 1) { protectu $nick $chan $1- }
alias chanprot.load {
  pw banprotect switch 1
  pw flood status 0
  pw repeat status 0
  pw caps status 0
  pw flood punish 3
  pw flood lines 8
  pw flood secs 3
  pw flood tempban 1
  pw flood bantime 30
  pw flood mask 3
  pw repeat punish 3
  pw repeat lines 6
  pw repeat secs 10
  pw repeat tempban 1
  pw repeat bantime 30
  pw repeat mask 3
  pw caps punish 3
  pw caps percent 90
  pw caps tempban 1
  pw caps bantime 30
  pw caps mask 3
  pw kick regular 1
  pw kick notice 1
  pw kick action 1
  pw kick text 1
  pw kick voice 0
  pw kick ops 0
}
alias protectu {
  if ($1 isop $2) && ($pr(kick,ops) == 0) { halt }
  if ($1 isvo $2) && ($pr(kick,voice) == 0) { halt }
  if ($1 isreg $2) && ($pr(kick,regular) == 0) { halt }
  if ($pr(channel,all) == 0) && ($roomin($2) == $false) { halt }
  if ($pr(caps,percent) <= $caps($3-)) && ($len($3-) > 4) && ($pr(caps,status) == 1) { 
    if ($pr(caps,punish) == 1) { kick $2 $1 EXCESSIVE CAPS - $caps($3-) $+ $chr(37) caps detected. Max. $pr(caps,percent) $+ $chr(37) allowed. }
    elseif ($pr(caps,punish) == 2) {
      if ($pr(caps,tempban) == 1) && ($pr(caps,bantime) > 0) { ban -u [ $+ [ $pr(caps,bantime) ] ] $2 $1 $pr(caps,mask) }
      else { ban $2 $1 $pr(caps,mask) }
    }
    elseif ($pr(caps,punish) == 3) {
      if ($pr(caps,tempban) == 1) && ($pr(caps,bantime) > 0) { ban -u [ $+ [ $pr(caps,bantime) ] ] $2 $1 $pr(caps,mask)  | .timer 1 1 kick $2 $1 EXCESSIVE CAPS - $caps($3-) $+ $chr(37) caps detected. Max. $pr(caps,percent) $+ $chr(37) allowed. $pr(caps,bantime) second ban. }
      else { ban $2 $1 $pr(caps,mask) | .timer 1 1 kick $2 $1 EXCESSIVE CAPS - $caps($3-) $+ $chr(37) caps detected. Max. $pr(caps,percent) $+ $chr(37) allowed. - Perm Ban }
    }
  }
  if (%repeat.t. [ $+ [ $2 ] $+ [ $1 ] ] == $3-) && ($pr(repeat,status) == 1) { inc %repeat. [ $+ [ $2 ] $+ [ $1 ] ] }
  if (%repeat. [ $+ [ $2 ] $+ [ $1 ] ] == $pr(repeat,lines)) && ($pr(repeat,status) == 1) { 
    if ($pr(repeat,punish) == 1) { kick $2 $1 REPEATING - $pr(repeat,lines) lines in $pr(repeat,secs) sec(s) }
    elseif ($pr(repeat,punish) == 2) {
      if ($pr(repeat,tempban) == 1) && ($pr(repeat,bantime) > 0) { ban -u [ $+ [ $pr(repeat,bantime) ] ] $2 $1 $pr(repeat,mask) }
      else { ban $2 $1 $pr(repeat,mask) }
    }
    elseif ($pr(repeat,punish) == 3) {
      if ($pr(repeat,tempban) == 1) && ($pr(repeat,bantime) > 0) { ban -u [ $+ [ $pr(repeat,bantime) ] ] $2 $1 $pr(repeat,mask) | .timer 1 1 kick $2 $1 REPEATING - $pr(repeat,lines) lines in $pr(repeat,secs) sec(s). $pr(repeat,bantime) second ban }
      else { ban $2 $1 $pr(repeat,mask) | .timer 1 1 kick $2 $1 REPEATING - $pr(repeat,lines) lines in $pr(repeat,secs) sec(s). Perm Ban }
    }
  }
  if (%repeat. [ $+ [ $2 ] $+ [ $1 ] ] == $null) && ($pr(repeat,status) == 1) { set -u [ $+ [ $pr(repeat,secs) ] ] %repeat. [ $+ [ $2 ] $+ [ $1 ] ] 1 | set -u [ $+ [ $pr(repeat,secs) ] ] %repeat.t. [ $+ [ $2 ] $+ [ $1 ] ] $3- }

  if (%flood. [ $+ [ $2 ] $+ [ $1 ] ] != $null) && ($pr(flood,status) == 1) { inc %flood. [ $+ [ $2 ] $+ [ $1 ] ] }
  if (%flood. [ $+ [ $2 ] $+ [ $1 ] ] >= $pr(flood,lines)) && ($pr(flood,status) == 1) { 
    if ($pr(flood,punish) == 1) { kick $2 $1 FLOODING - $pr(flood,lines) lines in $pr(flood,secs) sec(s). }
    elseif ($pr(flood,punish) == 2) {
      if ($pr(flood,tempban) == 1) && ($pr(flood,bantime) > 0) { ban -u [ $+ [ $pr(flood,bantime) ] ] $2 $1 $pr(flood,mask) }
      else { ban $2 $1 $pr(flood,mask) }
    }
    elseif ($pr(flood,punish) == 3) {
      if ($pr(flood,tempban) == 1) && ($pr(flood,bantime) > 0) { ban -u [ $+ [ $pr(flood,bantime) ] ] $2 $1 $pr(flood,mask) | .timer 1 1 kick $2 $1 FLOODING - $pr(flood,lines) lines in $pr(flood,secs) sec(s). $pr(flood,bantime) second ban. }
      else { ban $2 $1 $pr(flood,mask) | .timer 1 1 kick $2 $1 FLOODING - $pr(flood,lines) lines in $pr(flood,secs) sec(s). Perm Ban }
    }
  }
  if (%flood. [ $+ [ $2 ] $+ [ $1 ] ] == $null) && ($pr(flood,status) == 1) { set -u [ $+ [ $pr(flood,secs) ] ] %flood. [ $+ [ $2 ] $+ [ $1 ] ] 1 }
}
menu channel,menubar,query,status {
  security 
  .channel:dialog -m pro pro | sclick
  .ctcp:dialog -m ctcpprot ctcpprot | sclick
}
dialog pro {
  title "channel protection"
  size -1 -1 310 205
  tab "event", 50, 5 5 295 175
  button "channels", 61, 216 85 64 25, tab 50
  box "kick events", 62, 26 54 175 38, tab 50
  check "text", 63, 36 69 42 20, tab 50
  check "action", 64, 86 69 50 20, tab 50
  check "notice", 65, 146 69 50 20, tab 50
  box "kick only", 66, 26 99 175 38, tab 50
  check "op", 67, 36 114 42 20, tab 50
  check "voice", 68, 86 114 50 20, tab 50
  check "regular", 69, 141 114 55 20, tab 50
  tab "text flood", 51
  box "", 1, 20 55 260 110, tab 51
  check "enable", 2, 20 35 90 25, tab 51
  edit "", 3, 70 65 30 22, tab 51 autohs
  text "lines in", 4, 105 70 37 16, tab 51
  edit "", 5, 140 65 30 22, tab 51
  text "sec(s)", 6, 175 70 40 16, tab 51
  radio "kick", 7, 70 90 50 20, group tab 51
  radio "Ban", 8, 120 90 50 20, tab 51
  radio "Kick/ban", 9, 170 90 65 20, tab 51
  check "Temp ban(secs)", 10, 70 110 95 25, disable tab 51
  edit "", 11, 170 110 30 22, disable tab 51
  edit "", 12, 70 140 30 22, disable tab 51
  text "Ban mask (0-10)", 13, 105 145 88 16, disable tab 51
  tab "repeat text", 52
  box "", 14, 20 55 260 110, tab 52
  check "enable", 15, 20 35 90 25, tab 52
  edit "", 16, 70 65 30 22, tab 52
  text "lines in", 17, 105 70 45 20, tab 52
  edit "", 18, 140 65 30 22, tab 52
  text "sec(s)", 19, 175 70 32 20, tab 52
  radio "kick", 20, 70 90 42 20, group tab 52
  radio "ban", 21, 120 90 50 20, tab 52
  radio "kick/ban", 22, 170 90 65 20, tab 52
  check "temp ban(secs)", 23, 70 110 95 25, disable tab 52
  edit "", 24, 170 110 30 22, disable tab 52
  edit "", 25, 70 140 30 22, disable tab 52
  text "ban mask (0-10)", 26, 105 145 88 16, disable tab 52
  tab "caps flood", 53
  box "", 27, 20 55 260 110, tab 53
  check "enable", 28, 20 35 90 25, tab 53
  edit "", 29, 70 65 30 22, tab 53
  text "% max. caps allowed", 30, 105 70 110 16, tab 53
  radio "kick", 31, 70 90 50 20, group tab 53
  radio "ban", 32, 120 90 50 20, tab 53
  radio "kick/ban", 33, 170 90 65 20, tab 53
  check "Temp ban(secs)", 34, 70 110 95 25, disable tab 53
  edit "", 35, 170 110 30 22, disable tab 53
  edit "", 36, 70 140 30 22, disable tab 53
  text "Ban mask (0-10)", 37, 105 145 96 16, disable tab 53
  button "close", 70, 230 180 70 20, default ok
  button "ctcp", 71, 150 180 70 20
}
dialog channel {
  title "add/ remove channel(s)"
  size -1 -1 240 160
  list 2, 5 30 150 130, sort
  edit "", 1, 5 5 150 20
  button "add", 3, 160 30 75 20
  button "remove", 4, 160 55 75 20
  button "close", 5, 160 80 75 20, OK
  check "all channels", 6, 40 140 90 20
}
on *:dialog:pro:init:*: { 
  set -u0 %repeat.status $pr(repeat,status)
  set -u0 %caps.status $pr(caps,status) 
  set -u0 %flood.punish $pr(flood,punish) 
  set -u0 %repeat.punish $pr(repeat,punish)
  set -u0 %caps.punish $pr(caps,punish) 
  if ($pr(flood,status) == 1) { did -c pro 2 } 
  if (%flood.punish > 1) { did -e pro 10,11,12,13 | did -c pro $calc(6 + %flood.punish ) } 
  if ($pr(repeat,status) == 1) { did -c pro 15 }
  if (%repeat.punish > 1) { did -e pro 23,24,25,26 | did -c pro $calc(19 + %repeat.punish ) }
  if ($pr(caps,status) == 1) { did -c pro 28 }
  if (%caps.punish > 1) { did -e pro 34,35,36,37 | did -c pro $calc(30 + %caps.punish ) }

  if ($pr(flood,punish) == 1) { did -c pro 7 }
  if ($pr(repeat,punish) == 1) { did -c pro 20 }
  if ($pr(caps,punish) == 1) { did -c pro 31 }
  if ($pr(flood,tempban) == 1) { did -c pro 10 }
  if ($pr(repeat,tempban) == 1) { did -c pro 23 }
  if ($pr(caps,tempban) == 1) { did -c pro 34 }
  if ($pr(flood,bantime) > 0) { did -a pro 11 $pr(flood,bantime) }
  if ($pr(repeat,bantime) > 0) { did -a pro 24 $pr(repeat,bantime) }
  if ($pr(caps,bantime) > 0) { did -a pro 35 $pr(caps,bantime) }
  if ($pr(flood,mask) >= 0) { did -a pro 12 $pr(flood,mask) }
  if ($pr(repeat,mask) >= 0) { did -a pro 25 $pr(repeat,mask) }
  if ($pr(caps,mask) >= 0) { did -a pro 36 $pr(caps,mask) }
  if ($pr(flood,lines) >= 0) { did -a pro 3 $pr(flood,lines) }
  if ($pr(flood,secs) >= 0) { did -a pro 5 $pr(flood,secs) }
  if ($pr(repeat,lines) >= 0) { did -a pro 16 $pr(repeat,lines) }
  if ($pr(repeat,secs) >= 0) { did -a pro 18 $pr(repeat,secs) }
  if ($pr(caps,percent) >= 0) { did -a pro 29 $pr(caps,percent) }
  if ($pr(kick,text) > 0) { did -c pro 63 }
  if ($pr(kick,action) > 0) { did -c pro 64 }
  if ($pr(kick,notice) > 0) { did -c pro 65 }
  if ($pr(kick,ops) > 0) { did -c pro 67 }
  if ($pr(kick,voice) > 0) { did -c pro 68 }
  if ($pr(kick,regular) > 0) { did -c pro 69 }
}
on *:dialog:channel:init:*: {
  if ($pr(channel,all) == 1) { did -c channel 6 }
  set -u0 %chan $lines(data/channel.txt)
  if (%chan == 0) || (%chan == $null) { goto end }
  :loop
  did -a channel 2 $read -l [ $+ [ %chan ] ] data/channel.txt
  dec %chan
  if (%chan =< 0) { goto end }
  goto loop
  :end
}

on *:dialog:pro:sclick:*: {
  if ($did == 2) { pw flood status $did($did).state }
  if ($did == 15) { pw repeat status $did($did).state }
  if ($did == 28) { pw caps status $did($did).state }
  if ($did == 7) { pw flood punish 1 | did -b pro 10,11,12,13 }
  if ($did == 8) { pw flood punish 2 | did -e pro 10,11,12,13 }
  if ($did == 9) { pw flood punish 3 | did -e pro 10,11,12,13 }
  if ($did == 20) { pw repeat punish 1 | did -b pro 23,24,25,26 }
  if ($did == 21) { pw repeat punish 2 | did -e pro 23,24,25,26 }
  if ($did == 22) { pw repeat punish 3 | did -e pro 23,24,25,26 }
  if ($did == 31) { pw caps punish 1 | did -b pro 34,35,36,37 }
  if ($did == 32) { pw caps punish 2 | did -e pro 34,35,36,37 }
  if ($did == 33) { pw caps punish 3 | did -e pro 34,35,36,37 }

  if ($did == 10) { pw flood tempban $did($did).state }
  if ($did == 23) { pw repeat tempban $did($did).state }
  if ($did == 34) { pw caps tempban $did($did).state }
  if ($did == 61) { eventdialog -m channel channel }
  if ($did == 63) { pw kick text $did($did).state }
  if ($did == 64) { pw kick action $did($did).state }
  if ($did == 65) { pw kick notice $did($did).state }
  if ($did == 67) { pw kick ops $did($did).state }
  if ($did == 68) { pw kick voice $did($did).state }
  if ($did == 69) { pw kick regular $did($did).state }
  if ($did == 71) { .timer -m 1 1 dialog -m ctcpprot ctcpprot | dialog -x pro | sclick }
}
on *:dialog:channel:sclick:*: {
  if ($did == 3) && ($len($did(1).text) > 0) && ($roomin($did(1).text) == $false) { did -a channel 2 $did(1).text | write data/channel.txt $did(1).text | did -r channel 1 | write data/channel.txt $did(1).text }
  if ($did == 4) && ($did(channel,2).sel > 0) { roomrem $did(channel,2).sel | did -d channel 2 $did(channel,2).sel }
  if ($did == 6) { pw channel all $did($did).state }
}
on *:dialog:pro:edit:*: {
  if ($did == 11) { pw flood bantime $did($did).text }
  if ($did == 24) { pw repeat bantime $did($did).text }
  if ($did == 35) { pw caps bantime $did($did).text }
  if ($did == 12) { pw flood mask $did($did).text }
  if ($did == 25) { pw repeat mask $did($did).text }
  if ($did == 36) { pw caps mask $did($did).text }
  if ($did == 3) { pw flood lines $did($did).text }
  if ($did == 5) { pw flood secs $did($did).text }
  if ($did == 16) { pw repeat lines $did($did).text }
  if ($did == 18) { pw repeat secs $did($did).text }
  if ($did == 29) { pw caps percent $did($did).text }
}
alias prothes {
  .timer -m 1 1 dialog -m pro pro
}
alias eventdialog .timer 1 .1 dialog $$1-
alias roomin set -u0 %chan $lines(data/channel.txt) | if (%chan == 0) || (%chan == $null) { return $false | goto end } | :loop | if ($1- == $read -l [ $+ [ %chan ] ] data/channel.txt) { return $true | goto end } | dec %chan | if (%chan =< 0) { return $false | goto end } | goto loop | :end
alias roomrem set -u0 %chan $lines(data/channel.txt) | if (%chan == 0) || (%chan == $null) { goto end } | :loop | if ($1- == $read -l [ $+ [ %chan ] ] data/channel.txt) { write -dl [ $+ [ %chan ] ] data/channel.txt | goto end } | dec %chan | if (%chan =< 0) { goto end } | goto loop | :end
alias caps set -u0 %caps $len($1-) | set -u0 %cap 0 | :loop | if ($asc($mid($1-,%caps,1)) > 64) && ($asc($mid($1-,%caps,1)) < 91) { inc %cap } | dec %caps | if (%caps <= 0) { return $round($calc(%cap / $len($1-) * 100),0) | halt } | goto loop
alias cscan {
  %cv1 = $active 
  if ($dialog(clonescan) == $null) { dialog -m clonescan clonescan }
  if ($$1 != %cloneban)  { %cloneban = $$1 }
  if (# isin %cv1) { %cloneban = %cv1 }  
  if ($me !isop %cloneban) { did -b clonescan 9,5,6,11 }
  unset %cv1 
  did -r clonescan 1,4
  .hfree -sw clones  
  hmake clones 500
  var %x = 1, %c = $iif($1 ischan,$1,$active),%ticks = $ticks,%clones
  if (%c ischan) && ($ialchan(*,%c,0) != $nick(%c,0)) { .enable #clones | did -o clonescan 4 1 updating IAL.. | .ial on | who %c }
  while ($nick(%c,%x)) {
    var %i = $ifmatch
    if ($hget(clones,$address(%i,2)) == $null) && ($ialchan($address(%i,2),%c,0) > 1) {
      inc %clones $ialchan($address(%i,2),%c,0)
      hadd clones $address(%i,2) $address(%i,2)
      var %temp,%a = 1
      while ($ialchan($address(%i,2),%c,%a)) {
        set %temp %temp $+ $chr(44) $ialchan($address(%i,2),%c,%a).nick
        inc %a
      }
      did -a clonescan 1 $ialchan($address(%i,2),%c,0) clones from $address(%i,2) $+ : $mid(%temp,2,$calc($len(%temp) - 1))
    }
    inc %x
  }
  did -o clonescan 4 1 Group(s) of clones found: $hmatch(clones,*,0) (Total: %clones $+ )
  ; did -o clonescan 4 1 Synsched in $duration($calc(($ticks - %ticks) / 1000)) $gettok($calc(($ticks - %ticks) / 1000),2,46) $+ millisecs
  hfree clones
}
#clones off
raw 315:*: cscan $2 | .disable #clones 
#clones end
on *:connect: if ($group(#clones) == on) { .disable #clones }
dialog clonescan {
  title "clonescan"
  size -1 -1 210 120
  option dbu
  list 1, 4 5 202 72, sort size hsbar vsbar
  button "scan", 2, 5 78 37 8
  button "Button", 3, 45 180 37 12, ok
  edit "", 4, 3 108 203 10, read
  button "ban", 5, 92 78 37 8
  button "kick", 6, 131 78 37 8
  check "auto-ban/kick", 7, 145 88 46 10
  check "auto warn clones", 8, 88 87 52 10
  button "warn", 9, 44 78 37 8
  edit "", 10, 3 97 82 10, autohs
  button "ban/kick", 11, 170 78 37 8
  text "warn notice:", 12, 4 89 31 8
  check "load on clone detect", 13, 145 97 59 10
  check "join clone detect", 14, 88 97 52 10
}
on *:dialog:clonescan:init:*:{
  dialog -t clonescan clonescan %cv1 
  ;  if ($me !isop %cloneban) { did -b clonescan 9,5,6,11 }
  if ($_vr(clonescan,notice) == $null) { _vw clonescan notice please remove all clones from channel. }
  if ($_vr(clonescan,notice) != $null) { did -o clonescan 10 1 $_vr(clonescan,notice) }
  if ($_vr(general,clonedetect) == on) { did -c clonescan 14 }
  if ($_vr(clonescan,load) == on) { did -c clonescan 13 } 
}
on *:dialog:clonescan:edit:*:{
  if ($did == 10) { _vw clonescan notice $did(clonescan,10).text }
}
on *:dialog:clonescan:sclick:*:{
  if ($did == 2) { did -r clonescan 1,4 | cscan %cloneban }
  if ($did == 5) { ban %cloneban $remove($gettok($did(clonescan,1).seltext,4,32),:) }
  if ($did == 7) { 
    if ($_vr(clonescan,aban) == on) { _vw clonescan aban off }
    else { _vw clonescan aban on }
  }
  if ($did == 8) { 
    if ($_vr(clonescan,warn) == on) { _vw clonescan warn off }
    else { _vw clonescan warn on }
  }
  if ($did == 9) { cnotice } 
  if ($did == 6) { ckick }
  if ($did == 11) { ban %cloneban $remove($gettok($did(clonescan,1).seltext,4,32),:) | ckick }
  if ($did == 13) { 
    if ($_vr(clonescan,load) == on) { _vw clonescan load off }
    else { _vw clonescan load on }
  }
  if ($did == 14) { 
    if ($_vr(general,clonedetect) == on) { _vw general clonedetect off }
    else { _vw general clonedetect on }
  }

}
alias -l ckick {
  var %jj = 5   
  var %t1 = $gettok($did(clonescan,1).seltext,1,32) 
  var %t = 1     
  :loop   
  if (%t < %t1) { kick %cloneban $left($gettok($did(clonescan,1).seltext,%jj,32),$calc($len($gettok($did(clonescan,1).seltext,%jj,32)) - 1)) clone %t of $gettok($did(clonescan,1).seltext,1,32) | inc %jj 1 | inc %t 1 | goto loop }
  elseif (%t == %t1) { kick %cloneban $gettok($did(clonescan,1).seltext,%jj,32) clone %t of $gettok($did(clonescan,1).seltext,1,32) }
}
alias -l cnotice {
  var %jj = 5   
  var %t1 = $gettok($did(clonescan,1).seltext,1,32) 
  var %t = 1     
  :loop   
  if (%t < %t1) { notice $left($gettok($did(clonescan,1).seltext,%jj,32),$calc($len($gettok($did(clonescan,1).seltext,%jj,32)) - 1)) $_vr(clonescan,notice) | inc %jj 1 | inc %t 1 | goto loop }
  elseif (%t == %t1) { notice $gettok($did(clonescan,1).seltext,%jj,32) $_vr(clonescan,notice) }
}
on *:join:#: {
  if ($_vr(general,clonedetect) == $null) { _vw general clonedetect on }
  if ($_vr(general,clonedetect) == on) {
    if ($nick == $me) { return }  
    var %c3 = 1
    var %c4 = $ialchan($address($nick,2),$chan,%c3).nick   
    if (%c4 != $nick) { 
      if ($_vr(clonescan,warn) == on) && ($me isop $chan) { .notice $nick $_vr(clonescan,notice) }  
      if ($_vr(clonescan,aban) == on) && ($me isop $chan) { ban $chan $address($nick,2) | .timer 1 1 kick $chan $nick }
      if ($_vr(clonescan,load) == on) && ($me isop $chan) { cs $chan | beep }
      echo $chan $space(2) »4» clones detected $chan $+ : $nick - %c4 ( $+  $address($nick,2) $+ ) | inc %c3 | var %c4 = $ialchan($address($nick,2),$chan,%c3).nick
    }
    else return
  }
}
alias ascii {
  var %v = 100
  while (%v != 300) { echo -s %v = $chr(%v) | inc %v 1 }
}
; $flood(nick/address,channel/query window/etc,seconds,limit,string).repeat
; $flood(description,nick/address,seconds,limit)
;on @*:join:#:if ($flood($+(revolve,$chan),$wildsite,10,3)) { kick # $nick Dont flood, fool! }
alias flood {
  if ($prop == repeat) {
    var %ctr = $+(repeat.,$cid,.,$1,$2),%f
    hadd $+(-mu,$3) %ctr $ticks $5-
    var %i = $hget(%ctr,0).item
    while (%i) {
      if ($hget(%ctr,$hget(%ctr,%i).item) == $5-) { inc %f }
      ; comment out next line to count non-consecutive repeats
      elseif ($hget(%ctr).item) { hfree %ctr }
      dec %i
    }
    if (%f >= $4) { 
      hfree %ctr
      return $true
    }
  }
  else {
    var %ctr = $+($1,$2,.,$cid),%f
    hadd $+(-mu,$3) %ctr $ticks
    var %i = $hget(%ctr,0).item
    while (%i) {
      inc %f $hget(%ctr,$hget(%ctr,%i).item)
      dec %i
    }
    if (%f >= $4) { 
      hfree %ctr
      return $true
    }
  }
}
menu channel {
  $iif($acid == $true,• utilities)
  .clone scan:cscan
}
