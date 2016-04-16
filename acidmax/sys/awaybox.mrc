;User Away Box v1.3
;Team Nexgen 2003 by KnightFal
;Updates by RAIN
;team-nexgen.com

on *:load:{
  if ($version < 5.61) echo -a  $+ $colour(info2) $+ *** You need mirc 5.91 or greator in order to use this addon. | beep 
  echo -a  4TEAM NEXGEN'S AWAY BOX v1.3 | echo -a  4Please type: /awaybox to begin. 
}
alias time.away { set %time.away1 $?="Away interval in minute(s):"  | set %time.away2 .timer22 0 $calc(%time.away1 * 60) | echo -a 14Away Intervals will be displayed in channel(s) for %time.away1 minunte(s) }
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
menu channel,menubar,status {
  away:awaybox
}
alias awaybox { if ($dialog(awaybox) == $null) {  dialog -m awaybox awaybox } }
dialog awaybox {
  title "away box v1.3"
  size -1 -1 277 212
  edit "not here", 1, 11 28 252 21, autohs 
  text "away message", 2, 13 10 71 16
  edit "", 3, 31 70 100 21
  check "", 4, 11 70 20 20
  text "away nick", 5, 11 53 49 16
  button "set away", 6, 187 65 59 53
  button "close", 7, 112 312 51 21, ok
  check "reset to away on reconnect", 8, 11 96 156 20
  check "display time away", 9, 11 117 108 20
  check "idle away", 10, 11 138 76 20
  edit "", 11, 173 136 44 21, hide
  text "idle secs", 12, 220 140 42 16, hide
  text "auto away on", 13, 106 140 65 16, hide
  box "time away", 14, 8 217 124 36
  text "", 15, 17 231 106 16, center
  box "idle", 16, 143 217 124 36
  text "", 17, 152 231 106 16, center
  check "mute audio on away", 18, 11 160 116 20
  check "show public", 19, 11 182 92 20
  text "", 20, 161 160 74 16, center
}
on *:dialog:awaybox:init:*:{
  if ($_vr(awaybox,message) != $null) { did -o awaybox 1 1 $_vr(awaybox,message) }
  if ($_vr(awaybox,awaynick) != $null) { did -o awaybox 3 1 $_vr(awaybox,awaynick) }
  if ($_vr(awaybox,awnick) == on) { did -c awaybox 4 }
  if ($_vr(awaybox,reconnect) == on) { did -c awaybox 8 }
  if ($_vr(awaybox,dur) == on) { did -c awaybox 9 }
  if ($_vr(awaybox,mute) == on) { did -c awaybox 18 }
  if ($away = $true) { big.size | did -o awaybox 6 1 set back }
  if ($_vr(awaybox,show) == on) { did -c awaybox 19 }
  if ($_vr(awaybox,idle) == on) { did -c awaybox 10 | did -v awaybox 11,12,13,20 | did -o awaybox 11 1 $_vr(awaybox,idletime) | did -o awaybox 20 1 $round($calc($did(awaybox,11).text / 60),2) $+ min(s) }
}
on *:dialog:awaybox:edit:*:{
  if ($did == 1) { _vw awaybox message $did(awaybox,1).text }
  if ($did == 3) { _vw awaybox awaynick $did(awaybox,3).text }
  if ($did == 11) && ($did(awaybox,11).text isnum) { _vw awaybox idletime $did(awaybox,11).text | did -o awaybox 20 1 $round($calc($did(awaybox,11).text / 60),2) $+ min(s) }
  elseif ($did == 11) && ($did(awaybox,11).text !isnum) { did -r awaybox 11 | did -o awaybox 11 1 $_vr(awaybox,idletime) | did -o awaybox 20 1 $round($calc($did(awaybox,11).text / 60),2) $+ min(s) }
}
alias -l dur {
  if ($dialog(awaybox) != $null) { did -o awaybox 15 1 $duration($calc($ctime - $_vr(awaybox,timeaway))) }
}
alias -l idle {
  if ($dialog(awaybox) != $null) { did -o awaybox 17 1 $duration($idle) }
}
alias dur.dis {
  if ($_vr(awaybox,dur) == on) { return $chr(91) $+ duration: $duration($calc($ctime - $_vr(awaybox,timeaway))) $+ $chr(93) }
}
on *:dialog:awaybox:sclick:*:{
  if ($did == 6) { 
    if ($away == $false) { if ($_vr(awaybox,show) == on) { if ($server != $null) { scon -a ame is away: $did(awaybox,1).text } } | scid -at1 away $did(awaybox,1).text | did -o awaybox 6 1 set back | _vw awaybox timeaway $ctime | did -b awaybox 4 | did -m awaybox 1,3 | %awy = $true | big.size | .timerdur 0 1 dur | .timeridle -i 0 1 idle | mute.away | awnick }
    elseif ($away == $true) { 
      if ($_vr(awaybox,show) == on) { scon -a ame is back from $did(awaybox,1).text $dur.dis } 
      did -e awaybox 4 
      did -n awaybox 1,3 
      %awy = $false 
      scid -at1 away 
      reg.size 
      .timerdur off 
      .timeridle off 
      did -o awaybox 6 1 set away 
      mute.away 
      awnick 
    }
  }
  if ($did == 4) { 
    if ($_vr(awaybox,awnick) == on) { _vw awaybox awnick off }
    else { _vw awaybox awnick on }
  }
  if ($did == 8) { 
    if ($_vr(awaybox,reconnect) == on) { _vw awaybox reconnect off }
    else { _vw awaybox reconnect on }
  }
  if ($did == 9) { 
    if ($_vr(awaybox,dur) == on) { _vw awaybox dur off }
    else { _vw awaybox dur on }
  }
  if ($did == 10) { 
    if ($away == $true) && ($_vr(awaybox,idle) == on) { scon -a ame is back from $did(awaybox,1).text $dur.dis | did -e awaybox 4 | did -n awaybox 1,3 | %awy = $false | scid -at1 away | reg.size | .timerdur off | .timeridle off | did -o awaybox 6 1 set away | mute.away | awnick  }
    if ($_vr(awaybox,idle) == on) { _vw awaybox idle off | did -h awaybox 11,12,13,20 }
    else { _vw awaybox idle on | did -v awaybox 11,12,13,20 | did -o awaybox 11 1 $_vr(awaybox,idletime) | .timeridleaway -i 0 1 awayidle }
  }
  if ($did == 18) { 
    if ($_vr(awaybox,mute) == on) { _vw awaybox mute off | if ($away == $true) { vol -vu2 } }
    else { _vw awaybox mute on | if ($away == $true) { vol -vu1 } }
  }
  if ($did == 19) { 
    if ($_vr(awaybox,show) == on) { _vw awaybox show off }
    else { _vw awaybox show on }
  }
}
alias -l mute.away {
  if ($_vr(awaybox,mute) == on) && ($away == $true) { vol -vu1 }
  elseif ($_vr(awaybox,mute) == on) && ($away == $false) { vol -vu2 }
}
alias awnick {
  if ($_vr(awaybox,awnick) == on) {
    .timer 1 2 aw12
  }  
}
alias aw12 {
  if ($_vr(awaybox,awnick) == on) {
    if ($away == $true) { spnicks |  scid -at1 nick $_vr(awaybox,awaynick) | return }
    elseif ($_vr(awaybox,awnick) == on) && ($away != $true)  { spnicksback | return }
  }  
}
alias -l awayidle {
  if ($_vr(awaybox,idletime) == $null) { _vw awaybox idletime 900 }
  if ($_vr(awaybox,idle) == on) && ($idle >= $_vr(awaybox,idletime)) && ($away == $false) { setaway }
  elseif ($_vr(awaybox,idle) == on) && ($idle < $_vr(awaybox,idletime)) && ($away == $true) { setback }
}
alias setaway {
  .timeridleaway off 
  _vw awaybox timeaway $ctime
  if ($_vr(awaybox,show) == on) { scon -a ame is away: [auto away] } | scid -at1 away [auto away] | if ($dialog(awaybox) != $null) { did -o awaybox 6 1 set back | did -b awaybox 4 | did -m awaybox 1,3 | big.size } | %awy = $true | .timerdur 0 1 dur | .timeridle -i 0 1 idle | mute.away | if ($_vr(awaybox,awnick) == on) { awnick }
}
alias -l setback { if ($away == $true) { if ($_vr(awaybox,show) == on) { scon -a ame is back from idling $dur.dis } | %awy = $false | scid -at1 away | if ($dialog(awaybox) != $null) { did -o awaybox 6 1 set away } | mute.away | awnick } }
on *:input:*: {
  if ($_vr(awaybox,idle) == on) {
    setback | _vw awaybox idle off   
    .timeridleaway off | reg.size | .timerdur off | if ($dialog(awaybox) != $null) { did -u awaybox 10 | did -h awaybox 11,12,13,20 | dialog -x awaybox }
  }
  if ($1 == /away) && ($2 != $null) { 
    scon -a ame is away: $2-  | scid -at1 away $2- | _vw awaybox message $2- | _vw awaybox timeaway $ctime | if ($_vr(awaybox,awnick) == on) { awnick }
  }
  elseif ($1 == /away) && ($2 == $null) { scon -a ame is back from $_vr(awaybox,message) $dur.dis | awnick }
}
alias back { if ($away == $true) { if ($_vr(awaybox,show) == on) { scon -a ame is back from $_vr(awaybox,message) $dur.dis } | %awy = $false | scid -at1 away | if ($dialog(awaybox) != $null) { did -o awaybox 6 1 set away } | mute.away | if ($_vr(awaybox,awnick) == on) { awnick } } }
alias -l big.size {
  if ($dialog(awaybox) != $null) { dialog -s awaybox -1 -1 277 266
    sclick
  }
}
alias -l reg.size {
  if ($dialog(awaybox) != $null) { dialog -s awaybox -1 -1 277 212 }
}
on *:connect: {
  if (%awy = $true) && ($_vr(awaybox,reconnect) == on) { 
    scid -at1 away $_vr(awaybox,message) 
    mute.away
    if ($_vr(awaybox,idle) == on) { .timeridleaway -i 0 1 awayidle } 
    if ($_vr(awaybox,awnick) == on) { .timer 1 5 awnick } 
  }
}
alias showconnects { var %o = 1 | while ($scon(%o)) { echo Info for $ord(%o) connection: | echo nick: $scon(%o).me | echo network: $scon(%o).network | echo server: $scon(%o).server | echo usermodes: $scon(%o).usermode | echo ------------ | inc %o } }
alias spnicks { if ($away == $true) { write -c data\anicks.txt | var %o = 1 | while ($scon(%o)) { write data\anicks.txt $scon(%o).me | inc %o } } }
alias spnicksback { if ($away != $true) { var %spnicks = 1 | while ($scon(%spnicks)) { scon $scon(%spnicks) nick $read(data\anicks.txt, $+ %spnicks $+ ) | inc %spnicks } } }
