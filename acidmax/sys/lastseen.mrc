;Last !Seen v1.15
;Team Nexgen 2002-04 by KnightFal
;www.team-nexgen.org

on *:load:{ 
  echo -a 4TEAM NEXGEN'S LAST !SEEN v1.15 | echo -a  4Please type: /lastseen to launch dialog.
  if ($exists(data\seen.txt) == $false) { mkdir data | write -c data\seen.txt }
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

menu menubar,channel {
  $iif($acid == $true,• utilities)
  .last !seen:lastseen
  $iif($acid != $true,last !seen):lastseen
}
alias -l chec.sw {
  if ($_vr(lastseen,switch) == $null) { _vw lastseen switch 1 } 
  if ($_vr(lastseen,logquits) == $null) { _vw lastseen logquits 1 } 
  if ($_vr(lastseen,logparts) == $null) { _vw lastseen logparts 1 } 
  if ($_vr(lastseen,lognick) == $null) { _vw lastseen lognick 1 }
  if ($_vr(lastseen,logkicks) == $null) { _vw lastseen logkicks 1 }
  if ($_vr(lastseen,send) == $null) { _vw lastseen send notice }
}
alias -l sendls {
  if ($_vr(lastseen,send) == notice) { return .notice $1 }  
  elseif ($_vr(lastseen,send) == query) { return .msg $1 }  
  elseif ($_vr(lastseen,send) == channel) { return msg %lasts.chan }  
}
alias -l priv {
  if ($_vr(lastseen,priv) != on) { 
    if (p !isin $chan($1).mode) || (s !isin $chan($1).mode) { return private/secret channel }
    else { return $chan } 
  }
  else { return $chan } 
}
on *:TEXT:!seen*:#: {
  chec.sw
  %lasts.chan = $chan  
  if ($_vr(lastseen,flood) == $null)  { _vw lastseen flood on }
  if ($_vr(lastseen,switch) == $null) { _vw lastseen switch 1 } 
  if ($_vr(lastseen,logquits) == $null) { _vw lastseen logquits 1 } 
  if ($_vr(lastseen,logparts) == $null) { _vw lastseen logparts 1 } 
  if ($_vr(lastseen,lognick) == $null) { _vw lastseen lognick 1 }
  if ($_vr(lastseen,logkicks) == $null) { _vw lastseen logkicks 1 }
  if ($_vr(lastseen,switch) == 1) {
    if ($_vr(lastseen,flood) == on) {
      if (%ty => 3) { 
        if ($me ison $chan) { .ignore -cu60 $nick | echo -a  0,4( ALERT ) $nick is Trigger Flooding. Ignore will be removed in 60 seconds. | .notice $nick You are ignored for Trigger Flooding. }
        if ($me isop $chan) { ban -u60 $chan $nick 3 | kick $chan $nick AUTO-KICK Trigger Flood  | notice $nick You have been banned for Trigger Flooding. The ban and Ignore will be revoked in 60 seconds.  }
        halt
      } 
      inc %ty
      .timer 1 20 unset %ty    
      :end
    }  
    var %find  = $read(data\seen.txt, w, * $+ $2 $+ * ) 
    if ($2 == $null) { $sendls($nick) You did not enter a nick to search. }
    if ($2 == $nick) { $sendls($nick) Looking for yourself, eh $nick $+ ? | halt }
    if ($2 == $me) { $sendls($nick) $nick $+ , I'm right here! | halt }
    if ($2 ison $chan) { $sendls($nick) $2 is here in $chan | halt }
    if (%find == $null) { $sendls($nick) $2 has not been seen by me. | halt }
    else { var %yu = $read(data\seen.txt, s, $2 ) | var %yu1 = $duration($calc($ctime - $gettok(%yu,4,32))) | $sendls($nick) [LAST SEEN] " $+ $2 $+ " $replace(%yu,$gettok(%yu,4,32),%yu1 ago) 
    }
  }
}
on *:QUIT: {
  if ($_vr(lastseen,logquits) == 1) { 
    if ($chr(13) !isin $1-) { write -ds $+ $nick data\seen.txt | write data\seen.txt $nick - $address Quit $ctime Last Note: $priv($chan) Quit: ( $+ $network $+ ) $remove($1-,/) }
  }
} 
on *:PART:#: {
  if ($_vr(lastseen,logparts) == 1) { 
    write -ds $+ $nick data\seen.txt | write data\seen.txt $nick - $address Left $ctime Last Note: Left $priv($chan) ( $+ $network $+ )
  }
}
on *:KICK:#: {
  if ($_vr(lastseen,logkicks) == 1) { write -ds $+ $nick data\seen.txt | write data\seen.txt $knick - $address Kicked $ctime Last Note: Kicked from $priv($chan) ( $+ $network $+ ) $1- }
}
on *:NICK: {
  if ($_vr(lastseen,lognick) == 1) { write -ds $+ $nick data\seen.txt | write data\seen.txt $nick - $address Nick-Changed $ctime Last Note: *** $nick is now known as $newnick $+  ( $+ $network $+ ) } 
}
alias lastseen { 
  if ($dialog(lastseen) == $null) { dialog -m lastseen lastseen }
}
dialog lastseen {
  title "last !seen v1.2"
  size -1 -1 181 330
  option pixels
  edit "", 4, 10 62 161 20, autohs
  button "clear log", 11, 93 237 80 20
  button "search", 17, 63 87 50 20, default ok
  button "close", 12, 68 305 50 20, cancel
  text "search nick:", 13, 10 47 66 15
  check "enable public !seen", 15, 10 5 120 20
  text "", 18, 96 270 80 15
  box "", 19, 91 260 85 28
  check "log quits", 20, 15 117 80 20
  check "log parts", 21, 15 137 80 20
  check "log nick changes", 22, 15 157 110 20
  check "log kicks", 23, 15 177 80 20
  box "", 24, 5 107 171 115
  box "send via:", 1, 5 221 81 76
  radio "notice", 2, 13 236 57 20
  radio "channel", 3, 13 254 62 20
  radio "query", 5, 13 272 59 20
  check "flood protection", 6, 10 24 100 20
  check "log private chan(s) +s/+p", 7, 15 197 150 20
}
on *:dialog:lastseen:init:*:{ 
  chec.sw 
  if ($isalias(help-lastseen) == $true) did -v lastseen 16
  did -o lastseen 18 1 $file(data\seen.txt).size bytes
  if ($_vr(lastseen,flood) == $null) { _vw lastseen flood on }
  if ($_vr(lastseen,flood) == on) { did -c lastseen 6 }
  if ($_vr(lastseen,priv) == on) { did -c lastseen 7 }
  if ($_vr(lastseen,switch) == 1) { did -c lastseen 15 }
  if ($_vr(lastseen,logquits) == 1) { did -c lastseen 20 }
  if ($_vr(lastseen,logparts) == 1) { did -c lastseen 21 }
  if ($_vr(lastseen,lognick) == 1) { did -c lastseen 22 }
  if ($_vr(lastseen,logkicks) == 1) { did -c lastseen 23 }
  if ($_vr(lastseen,send) == channel) { did -c lastseen 3 }
  elseif ($_vr(lastseen,send) == query) { did -c lastseen 5 }
  elseif ($_vr(lastseen,send) == notice) { did -c lastseen 2 }
}
on *:dialog:lastseen:edit:*:{ 
}
on *:dialog:lastseen:sclick:*:{ 
  if ($did == 2) { _vw lastseen send notice }
  if ($did == 3) { _vw lastseen send channel }
  if ($did == 5) { _vw lastseen send query }
  if ($did == 11) { write -c data\seen.txt | did -o lastseen 18 1 $file(data\seen.txt).size bytes | beep }
  if ($did == 17) { 
    if ($did(lastseen,4).text == $null) halt  
    var %find = $read -s $+ $did(lastseen,4).text data\seen.txt 
    if ($did(lastseen,4).text == $me) { echo -a [LAST SEEN] $me $+ , umm look in the mirror | halt }
    if (%find == $null) { echo -a [LAST SEEN] $did(lastseen,4).text has not been seen by me. | halt }
    else { var %yu = $read -s $+ $did(lastseen,4).text data\seen.txt | var %yu1 = $duration($calc($ctime - $gettok(%yu,4,32))) | echo -a [LAST SEEN] $did(lastseen,4).text $remove($replace(%yu,$gettok(%yu,4,32),%yu1 ago),/,$chr(33)) }
  }
  if ($did == 6) { 
    if ($_vr(lastseen,flood) != off) { _vw lastseen flood off  }
    else { _vw lastseen flood on }
  }
  if ($did == 7) { 
    if ($_vr(lastseen,priv) != off) { _vw lastseen priv off  }
    else { _vw lastseen priv on }
  }
  if ($did == 15)  _vw lastseen switch $did($did).state 
  if ($did == 16) help-lastseen
  if ($did == 20)  _vw lastseen logquits $did($did).state 
  if ($did == 21)  _vw lastseen logparts $did($did).state 
  if ($did == 22)  _vw lastseen lognick $did($did).state 
  if ($did == 23)  _vw lastseen logkicks $did($did).state 
}
