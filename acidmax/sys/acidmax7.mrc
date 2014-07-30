menu channel {
  join limit:chan.limit
}
alias chan.limit if ($dialog(limit.chan) == $null) { dialog -m limit.chan limit.chan }
dialog limit.chan {
  title "channel join limit"
  size -1 -1 240 171
  option pixels
  list 2, 7 67 150 96, sort size
  edit "", 1, 7 42 150 20
  button "add", 3, 162 42 75 20
  button "remove", 4, 162 67 75 20
  check "active in all channels", 6, 112 5 118 20
  check "enable", 7, 9 5 65 20
  edit "", 8, 185 112 30 21, center
  text "channel:", 9, 7 25 50 16
  text "user limit", 10, 181 94 47 16
  button "update", 11, 162 139 75 20
}
alias -l cm {
  if ($_vr(chanlimit,switch) == on) {  
    if ($_vr(limit.chan,all) == on) { return $true }   
    var %ch = $lines(data/chanlimit.txt) 
    if (%ch == 0) || (%ch == $null) { return $false | goto end } 
    :loop 
    if ($1- == $read -l [ $+ [ %ch ] ] data/chanlimit.txt) { return $true | goto end } 
    dec %ch 
    if (%ch =< 0) { return $false | goto end } 
    goto loop 
    :end
  }
} 
alias -l chanrem set -u0 %chan $lines(data/chanlimit.txt) | if (%chan == 0) || (%chan == $null) { goto end } | :loop | if ($1- == $read -l [ $+ [ %chan ] ] data/chanlimit.txt) { write -dl [ $+ [ %chan ] ] data/chanlimit.txt | goto end } | dec %chan | if (%chan =< 0) { goto end } | goto loop | :end
alias -l chlimit {
  if ($1 != $null) {
    if ($me isop %limit.users. [ $+ [ $1 ] ]) {
      mode %limit.users. [ $+ [ $1 ] ] +l $calc($nick(%limit.users. [ $+ [ $1 ] ],0) + $_vr(chanlimit,limit))
      unset %limit.users. [ $+ [ $1 ] ]
      halt
    }
  }
}
on *:dialog:limit.chan:sclick:*: {
  if ($did == 3) && ($len($did(limit.chan,1).text) > 0) && ($cm($did(limit.chan,1).text) == $false) { did -a limit.chan 2 $did(limit.chan,1).text | write data/chanlimit.txt $did(1).text | did -r limit.chan 1 | write data/chanlimit.txt $did(limit.chan,1).text }
  if ($did == 4) && ($did(limit.chan,2).sel > 0) { chanrem $did(limit.chan,2).seltext | did -d limit.chan 2 $did(limit.chan,2).sel }
  if ($did == 6) {
    if ($_vr(limit.chan,all) == on) { _vw limit.chan all off  }
    else { _vw limit.chan all on  }
  }
  if ($did == 7) {
    if ($_vr(chanlimit,switch) == on) { _vw chanlimit switch off  }
    else { _vw chanlimit switch on  }
  }
  if ($did == 11) && ($did(limit.chan,8).text != $null)  { _vw chanlimit limit $did(limit.chan,8).text }
}
on *:dialog:limit.chan:edit:*: {
  if ($did == 8) && ($did(limit.chan,8).text == $null) && ($did(limit.chan,8).text !isnum) { did -b limit.chan 11 }
  elseif ($did == 8) && ($did(limit.chan,8).text != $null) && ($did(limit.chan,8).text isnum) { did -e limit.chan 11 }
}
on *:dialog:limit.chan:init:*: {
  if ($_vr(chanlimit,limit) == $null) { _vw chanlimit limit 3 }  
  if ($_vr(chanlimit,switch) == on) { did -c limit.chan 7 } 
  if ($_vr(limit.chan,all) == on) { did -c limit.chan 6 }
  did -a limit.chan 8 $_vr(chanlimit,limit) 
  var %c =  $lines(data/chanlimit.txt) | var %c1 = 1
  while (%c1 <= %c) { did -a limit.chan 2 $read -l [ $+ [ %c1 ] ] data/chanlimit.txt | inc %c1 }
}
on !*:part:#:{
  if ($cm($chan) == $true) { 
    set %limit.users. [ $+ [ # ] ] #
    .timer 1 3 chlimit %limit.users. [ $+ [ # ] ]
    halt
  }
}
on *:kick:#:{
  if ($cm($chan) == $true) {   
    if ($knick == $me) {
      halt
    }
    if ($knick != $me) {
      set %limit.users. [ $+ [ # ] ] #
      .timer 1 3 chlimit %limit.users. [ $+ [ # ] ]
      halt
    }
  }
}
on *:quit:{
  %var.inc = 0
  :loop
  inc %var.inc
  if ($comchan($nick,%var.inc) == $null) {
    unset %var.inc
    halt
  }
  if ($comchan($nick,%var.inc) != $null) && ($cm($comchan($nick,%var.inc)) == $true) {   
    set %limit.users. [ $+ [ $comchan($nick,%var.inc) ] ] $comchan($nick,%var.inc)
    .timer 1 3 chlimit %limit.users. [ $+ [ $comchan($nick,%var.inc) ] ]
    goto loop
  }
}
on !*:join:#:{
  if ($cm($chan) == $true) { 
    set %limit.users. [ $+ [ # ] ] #
    .timer 1 3 chlimit %limit.users. [ $+ [ # ] ]
    halt
  }
}
on ^*:join:#:{
  if ($cm($chan) == $true) {  
    if ($nick == $me) {
      set %limit.users. [ $+ [ # ] ] #
      .timer 1 3 chlimit %limit.users. [ $+ [ # ] ]
    }
  }
}
alias -l cs {  if ($_vr(media,color) == off) { return $strip($$1-,bc) } | else return $$1- }
alias -l mmsg { 
  if ($chan($$1) != $null) { return scid -at1 msg $$1 }
  else return
} 
alias  acidmax.media.info {
  if ($_vr(media,echo) == on) {  
    ;Tokenize the input (returns $1 - $7)
    ;$1 = filetype
    ;$2 = filename
    ;$3 = filesize
    ;$4 = resolution (only valid for videos)
    ;$5 = bitrate
    ;$6 = time
    ;$7 = d/l code
    ;Empty tokens are replaced by $chr(4)
    ;*/
    tokenize 1 $1-
    if ($_vr(media,all) == on)  { scon -a amsg $cs(4.:14 $+ $lower($1) $+ 4:. $iif($2 != $chr(4), $2)  $iif($4 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $4 $+ 4 $+ $chr(187)) $iif($5 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $round($calc($5 / 1024), 0) Kb/s $+ 4 $+ $chr(187)) $iif($6 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $6 $+ 4 $+ $chr(187)) 5•4•14acidmax media player4•5•) | if ($_vr(media,offer) == on) && ($7 != 0) { scon -a amsg To get this $iif($3 != $chr(4), $round($calc($3 / 1024^2), 2) MB) file, type: ! $+ $me $7 } | haltdef  }
    if ($_vr(media,all) != on) {  
      var %s = $lines(data\mediaact.txt)
      var %s1 = 1 
      while (%s1 <= %s) { $mmsg($read(data\mediaact.txt,%s1)) $cs(4.:14 $+ $lower($1) $+ 4:. $iif($2 != $chr(4), $2)  $iif($4 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $4 $+ 4 $+ $chr(187)) $iif($5 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $round($calc($5 / 1024), 0) Kb/s $+ 4 $+ $chr(187)) $iif($6 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $6 $+ 4 $+ $chr(187)) 5•4•14acidmax media player4•5•) | if ($_vr(media,offer) == on) && ($7 != 0) { $mmsg($read(data\mediaact.txt,%s1)) To get this $iif($3 != $chr(4), $round($calc($3 / 1024^2), 2) MB) file, type: ! $+ $me $7 } | inc %s1 1 }
      else return
      ; 4.:14 $+ $lower($1) $+ 4:. $&
        ;    $iif($2 != $chr(4), $2) $&
        ;   $iif($4 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $4 $+ 4 $+ $chr(187)) $&
        ;   $iif($5 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $round($calc($5 / 1024), 0) Kb/s $+ 4 $+ $chr(187)) $&
        ;  $iif($6 != $chr(4), 4 $+ $chr(171) $+ 99 $+ $6 $+ 4 $+ $chr(187)) $&
        ;  5•4•14acidmax media player4•5• $&
        ;  if ($_vr(media,offer) == on) { msg #nexgen To get this $iif($3 != $chr(4), $round($calc($3 / 1024^2), 2) MB) file, type: ! $+ $me $7 }
    }
  }
}

alias media if ($dialog(media) == $null) { dialog -m media media }
dialog media {
  title "acidmax media player"
  size -1 -1 183 88
  option dbu
  check "enable ad", 1, 6 4 38 10
  check "show in switchbar", 2, 6 48 56 10
  check "auto-play", 3, 6 59 39 10
  check "random play", 4, 6 70 44 10
  check "color ad", 5, 6 15 33 10
  check "media offer", 6, 6 37 42 10
  list 7, 73 19 50 50, size
  list 8, 125 19 50 50, size
  button "remove", 10, 136 71 29 9, disable
  button "add", 11, 84 71 29 9, disable
  check "display ad to all", 12, 6 26 50 10
  text "available chans", 13, 74 11 42 8
  text "active ad chans", 14, 126 11 46 8
  box "display ad in:", 15, 69 3 111 81
}
on *:dialog:media:init:*: {
  if ($_vr(media,color) == $null) { _vw media color on }  
  if ($_vr(media,echo) == on) { did -c media 1 } 
  if ($_vr(media,color) == on) { did -c media 5 } 
  if ($_vr(media,offer) == on) { did -c media 6 } 
  if ($_vr(media,switchbar) == on) { did -c media 2 } 
  if ($_vr(media,autoplay) == on) { did -c media 3 } 
  if ($_vr(media,random) == on) { did -c media 4 } 
  if ($_vr(media,all) == on) { did -c media 12 } 
  media.act
  media.a
}
on *:dialog:media:sclick:*: {
  if ($did == 1) {
    if ($_vr(media,echo) == on) { _vw media echo off  }
    else { _vw media echo on  }
  }
  if ($did == 5) {
    if ($_vr(media,color) == on) { _vw media color off  }
    else { _vw media color on  }
  }
  if ($did == 6) {
    if ($_vr(media,offer) == on) { _vw media offer off  }
    else { _vw media offer on  }
  } 
  if ($did == 12) {
    if ($_vr(media,all) == on) { _vw media all off  }
    else { _vw media all on  }
  } 
  if ($did == 7) { did -e media 11 }
  if ($did == 8) { did -e media 10 }
  if ($did == 2) {
    if ($_vr(media,switchbar) == on) { _vw media switchbar off  }
    else { _vw media switchbar on  }
  }
  if ($did == 3) {
    if ($_vr(media,autoplay) == on) { _vw media autoplay off  }
    else { _vw media autoplay on  }
  }
  if ($did == 4) {
    if ($_vr(media,random) == on) { _vw media random off  }
    else { _vw media random on  }
  }
  if ($did == 11) && ($did(media,7).seltext != $null) {
    did -a media 8 $did(media,7).seltext | write data\mediaact.txt $did(media,7).seltext
  } 
  if ($did == 10) && ($did(media,8).sel != $null) { actrem $did(media,8).seltext | did -d media 8 $did(media,8).sel | did -b media 10 }
}
alias -l media.act {
  if ($dialog(media) != $null) {
    did -r media 7 
    var %channum = 1
    var %chan = $chan(0)
    while (%channum <= %chan) { did -i media 7 1  $chan(%channum)  | inc %channum }
  }
}
alias -l actrem set -u0 %act $lines(data\mediaact.txt) | if (%act == 0) || (%act == $null) { goto end } | :loop | if ($1- == $read -l [ $+ [ %act ] ] data\mediaact.txt) { write -dl [ $+ [ %act ] ] data\mediaact.txt | goto end } | dec %act | if (%act =< 0) { goto end } | goto loop | :end
alias -l media.a {
  var %w = $lines(data\mediaact.txt)
  var %w1 = 1 
  while (%w1 <= %w) { did -i media 8 1 $read(data\mediaact.txt,%w1) | inc %w1 1 }
}
alias c0 return 00 $+
alias c1 return 01 $+
alias c2 return 02 $+
alias c3 return 03 $+
alias c4 return 04 $+
alias c5 return 05 $+
alias c6 return 06 $+
alias c7 return 07 $+
alias c8 return 08 $+
alias c9 return 09 $+
alias c10 return 10 $+
alias c11 return 11 $+
alias c12 return 12 $+
alias c13 return 13 $+
alias c14 return 14 $+
alias c15 return 15 $+

;=================nicklist icons
on *:join:#:{
  if ($_vr(general,nlicons) == $null) { _vw general nlicons on }
  if ($_vr(general,nlicons) == on) {
;    scon -a dll $adll nicklist 1 
;    scon -a  dll $adll SetChannelWnd $chan($chan).hwnd
  }
;  else { scon -a  dll $adll nicklist 0 }
}
alias nl.icon {
  if ($dialog(nl.icon) == $null) { dialog -m nl.icon nl.icon }
}
dialog nl.icon {
  title "nicklist configuration"
  size -1 -1 188 74
  option dbu
  button "background ", 1, 7 22 37 12
  box "nicklist icon config", 2, 131 13 54 55
  button "text color", 3, 47 22 37 12
  button "op", 4, 87 22 37 12
  button "voice ", 5, 7 37 37 12
  button "half-op", 6, 47 37 37 12
  check "enable", 7, 6 2 35 10
  box "nicklist color config", 8, 4 13 124 42
  button "op", 9, 139 22 37 12
  button "voice", 10, 139 36 37 12
  button "half-op", 11, 139 50 37 12
  button "self", 12, 87 37 37 12
  button "refresh", 13, 7 57 37 12, disable
  button "default", 14, 47 57 37 12
}
on *:dialog:nl.icon:init:*: {
  if ($_vr(general,nlicons) == on) { did -c nl.icon 7 | did -e nl.icon 13 }
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 7 $rgb(119,154,247) $rgb(255,255,255) 1 On/ off:Enable /disable nicklist icons.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 1 $rgb(119,154,247) $rgb(255,255,255) 1 Background:Background color of nicklist.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 5 $rgb(119,154,247) $rgb(255,255,255) 1 Voice:Color of voiced users.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 3 $rgb(119,154,247) $rgb(255,255,255) 1 Text color:Color of regular users and highlight.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 6 $rgb(119,154,247) $rgb(255,255,255) 1 Half-op:Color of half-op users.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 4 $rgb(119,154,247) $rgb(255,255,255) 1 Voice:Color of op users.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 12 $rgb(119,154,247) $rgb(255,255,255) 1 Voice:Color of self.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 13 $rgb(119,154,247) $rgb(255,255,255) 1 Refresh:Refresh nicklist.
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 14 $rgb(119,154,247) $rgb(255,255,255) 1 Default:Use acidmax default colors and icons. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 9 $rgb(119,154,247) $rgb(255,255,255) 1 Op Icon:Change op icon. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 10 $rgb(119,154,247) $rgb(255,255,255) 1 Voice Icon:Change voice icon. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
;  dll $adll tooltip_add $dialog(nl.icon).hwnd 11 $rgb(119,154,247) $rgb(255,255,255) 1 Half-Op Icon:Change half-op icon. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
}
on *:dialog:nl.icon:sclick:*: {
;  if ($did == 1) { dll $adll set_back_color }
;  if ($did == 3) { dll $adll set_text_color }
;  if ($did == 4) { dll $adll set_op_color }
;  if ($did == 5) { dll $adll set_voice_color }
;  if ($did == 6) { dll $adll set_halfop_color }
;  if ($did == 9) { dll $adll set_op_icon }
;  if ($did == 10) { dll $adll set_voice_icon }
;  if ($did == 11) { dll $adll set_halfop_icon }
;  if ($did == 12) { dll $adll set_self_color }
;  if ($did == 13) { scon -a dll $adll nicklist 1 }
;  if ($did == 14) { dll $adll refresh_nicklist | dll $adll nicklist 1 }
;  if ($did == 7) { 
;    if ($_vr(general,nlicons) == on) { _vw general nlicons off  | did -b nl.icon 13 | scon -a dll $adll nicklist 0  }
;    else { _vw general nlicons on | did -e nl.icon 13 | scon -a dll $adll nicklist 1 }
  }
}
menu menubar,status,channel {
  $iif($acid == $true,• utilities)
  .nick retriever:nickret 
}

;[read write data/setting.ini]
on *:connect:{
  _vrem nickretrieve nick | if $dialog(nickret) != $null) { did -e nickret 100 1 | did -r nickret 100 1 | did -e nickret 18 | did -b nickret 19 | dialog -t nickret Nick Retriever v1.1 }
}
alias nickret { if $dialog(nickret) == $null) { dialog -m nickret nickret } }
dialog nickret {
  title "nick retriever"
  size -1 -1 179 184
  option pixels
  text "nickname to retrieve:", 6, 10 24 108 20
  text "", 7, 10 79 150 87
  button "apply", 18, 118 24 50 20
  button "cancel", 19, 118 46 50 20, disable
  box "note", 140, 5 64 170 112
  edit "", 100, 10 44 100 20, autohs
  check "always active", 1, 10 2 94 20
}
on *:dialog:nickret:init:*:{
  if ($_vr(nickretrieve,active) == on) { did -c nickret 1 }
  did -o nickret 100 1 $_vr(nickretrieve,nick)
  did -o nickret 7 1 nick retriever allows you to change a nick that has been taken by another user.  When the user changes or leaves IRC, nick retriever will auto change to that nick. 
  if ($_vr(nickretrieve,nick) != $null) { did -b nickret 18 | did -b nickret 100 1 | dialog -t nickret retrieving  " $+ $_vr(nickretrieve,nick) $+ " }
}
on *:dialog:nickret:sclick:*: {
  if ($did = 1) { 
    if ($_vr(nickretrieve,active) != on) { _vw nickretrieve active on }
    else { _vw nickretrieve active off } 
  } 
  if ($did == 18) {
    _vw nickretrieve nick $did(nickret,100).text | notify -h on | notify $did(nickret,100).text nick retrieve  | dialog -t nickret retrieving " $+ $did(nickret,100).text $+ " | did -b nickret 100 1 | did -b nickret 18 | did -e nickret 19 
    if ($notify($_vr(nickretrieve,nick).ison) != $true) { nick $_vr(nickretrieve,nick) }
  }  
  if ($did == 19) { if ($_vr(nickretrieve,nick) != $null) { notify -r $_vr(nickretrieve,nick) | did -r nickret 100 |  _vrem nickretrieve nick | dialog -t nickret nick retriever | did -e nickret 18 | did -e nickret 100 1 | did -b nickret 19 } }
}
on *:unotify:{
  if ($nick == $_vr(nickretrieve,nick)) {
    nick $_vr(nickretrieve,nick) 
    if ($_vr(nickretrieve,active) != on) { notify -r $_vr(nickretrieve,nick) | did -r nickret 100 |  _vrem nickretrieve nick | dialog -t nickret nick retriever | did -e nickret 18 | did -e nickret 100 1 | did -b nickret 19 } 
  }
}
alias edittheme colortheme
alias colortheme {
  if ($dialog(theme) == $null) { dialog -m theme theme }
}
dialog theme {
  title "color theme editor"
  size -1 -1 235 151
  option dbu
  check "enable", 98, 8 15 36 10
  edit "", 99, 37 117 50 10, disable autohs right
  edit "", 100, 92 117 50 10, disable autohs
  button "preview", 101, 71 130 37 9, disable
  button "nicklist edit", 102, 190 19 37 10
  box "custom", 103, 34 109 111 34, disable
  box "other", 104, 186 10 45 60
  button "nick completor", 105, 190 31 37 10
  button "graphics", 106, 190 43 37 10
  box "theme", 107, 186 70 45 37
  button "save", 108, 190 79 37 10
  button "load", 109, 190 91 37 10
  button "sounds", 110, 190 55 37 10
  tab "1", 115, 2 0 178 147
  box "de-half-op mode", 62, 64 65 55 40, tab 115
  box "de-op mode", 54, 8 65 55 40, tab 115
  check "custom", 55, 13 92 30 10, tab 115
  check "acidmax", 56, 13 83 37 10, tab 115
  check "mIRC default", 57, 13 74 47 10, tab 115
  check "custom", 16, 13 52 30 10, tab 115
  check "acidmax", 17, 13 43 37 10, tab 115
  check "mIRC default", 18, 13 34 47 10, tab 115
  box "op mode", 15, 8 25 55 40, tab 115
  check "mIRC default", 65, 69 74 47 10, tab 115
  check "acidmax", 64, 69 83 37 10, tab 115
  check "custom", 63, 69 92 30 10, tab 115
  check "custom", 23, 69 52 30 10, tab 115
  check "acidmax", 24, 69 43 37 10, tab 115
  check "mIRC default", 25, 69 34 47 10, tab 115
  box "half-op mode", 22, 64 25 55 40, tab 115
  box "voice mode", 26, 120 25 55 40, tab 115
  check "mIRC default", 29, 125 34 47 10, tab 115
  check "acidmax", 28, 125 43 37 10, tab 115
  check "custom", 27, 125 52 30 10, tab 115
  box "de-voice mode", 58, 120 65 55 40, tab 115
  check "mIRC default", 61, 125 74 47 10, tab 115
  check "acidmax", 60, 125 83 37 10, tab 115
  check "custom", 59, 125 92 30 10, tab 115
  button "edit", 127, 47 54 14 9, tab 115
  button "edit", 128, 47 94 14 9, tab 115
  button "edit", 129, 103 54 14 9, tab 115
  button "edit", 130, 103 94 14 9, tab 115
  button "edit", 131, 159 94 14 9, tab 115
  button "edit", 132, 159 54 14 9, tab 115
  tab "2", 116
  box "join", 34, 8 25 55 40, tab 116
  check "mIRC default", 37, 13 34 47 10, tab 116
  check "acidmax", 36, 13 43 37 10, tab 116
  check "custom", 35, 13 52 30 10, tab 116
  check "mIRC default", 41, 69 34 47 10, tab 116
  check "acidmax", 40, 69 43 37 10, tab 116
  check "custom", 39, 69 52 30 10, tab 116
  box "part", 38, 64 25 55 40, tab 116
  box "quit", 42, 8 65 55 40, tab 116
  check "mIRC default", 45, 13 74 47 10, tab 116
  check "custom", 43, 13 92 30 10, tab 116
  check "acidmax", 44, 13 83 37 10, tab 116
  box "action", 94, 64 65 55 40, tab 116
  check "mIRC default", 97, 69 74 47 10, tab 116
  check "acidmax", 96, 69 83 37 10, tab 116
  check "custom", 95, 69 92 30 10, tab 116
  box "channel nick other", 11, 120 65 55 40, tab 116
  check "mIRC default", 14, 125 74 47 10, tab 116
  check "acidmax", 13, 125 83 37 10, tab 116
  check "custom", 12, 125 92 30 10, tab 116
  box "channel nick self", 10, 120 25 55 40, tab 116
  check "mIRC default", 1, 125 34 47 10, tab 116
  check "acidmax", 2, 125 43 37 10, tab 116
  check "custom", 3, 125 52 30 10, tab 116
  button "edit", 121, 47 54 14 9, tab 116
  button "edit", 122, 47 94 14 9, tab 116
  button "edit", 123, 103 54 14 9, tab 116
  button "edit", 124, 103 94 14 9, tab 116
  button "edit", 125, 159 94 14 9, tab 116
  button "edit", 126, 159 54 14 9, tab 116
  tab "3", 117
  box "kick", 46, 8 25 55 40, tab 117
  check "mIRC default", 49, 13 34 47 10, tab 117
  check "acidmax", 48, 13 43 37 10, tab 117
  check "custom", 47, 13 52 30 10, tab 117
  box "topic change", 111, 120 25 55 40, tab 117
  check "mIRC default", 114, 125 34 47 10, tab 117
  check "acidmax", 113, 125 43 37 10, tab 117
  check "custom", 112, 125 52 30 10, tab 117
  box "mode change", 30, 64 65 55 40, tab 117
  check "mIRC default", 33, 69 74 47 10, tab 117
  check "acidmax", 32, 69 83 37 10, tab 117
  check "custom", 31, 69 92 30 10, tab 117
  box "unban mode", 70, 64 25 55 40, tab 117
  check "mIRC default", 73, 69 34 47 10, tab 117
  check "acidmax", 72, 69 43 37 10, tab 117
  check "custom", 71, 69 52 30 10, tab 117
  box "nick change", 66, 120 65 55 40, tab 117
  check "mIRC default", 69, 125 74 47 10, tab 117
  check "acidmax", 68, 125 83 37 10, tab 117
  check "custom", 67, 125 92 30 10, tab 117
  box "ban mode", 50, 8 65 55 40, tab 117
  check "mIRC default", 53, 13 74 47 10, tab 117
  check "acidmax", 52, 13 83 37 10, tab 117
  check "custom", 51, 13 92 30 10, tab 117
  button "edit", 9, 47 54 14 9, tab 117
  button "edit", 19, 47 94 14 9, tab 117
  button "edit", 20, 103 54 14 9, tab 117
  button "edit", 21, 103 94 14 9, tab 117
  button "edit", 119, 159 54 14 9, tab 117
  button "edit", 120, 159 94 14 9, tab 117
  tab "4", 118
  box "notice", 74, 8 25 55 40, tab 118
  check "mIRC default", 77, 13 34 47 10, tab 118
  check "custom", 75, 13 52 30 10, tab 118
  box "voice character", 90, 64 65 55 40, tab 118
  check "mIRC default", 93, 69 74 47 10, tab 118
  check "acidmax", 92, 69 83 37 10, tab 118
  check "custom", 91, 69 92 30 10, tab 118
  check "mIRC default", 89, 13 74 47 10, tab 118
  box "half-op character", 86, 8 65 55 40, tab 118
  check "acidmax", 88, 13 83 37 10, tab 118
  check "custom", 87, 13 92 30 10, tab 118
  box "op character", 82, 64 25 55 40, tab 118
  check "mIRC default", 85, 69 34 47 10, tab 118
  check "acidmax", 84, 69 43 37 10, tab 118
  check "custom", 83, 69 52 30 10, tab 118
  check "acidmax", 76, 13 43 37 10, tab 118
  button "edit", 4, 47 54 14 9, tab 118
  button "edit", 5, 103 54 14 9, tab 118
  button "edit", 6, 103 94 14 9, tab 118
  button "edit", 8, 47 92 14 9, tab 118
  button "apply", 133, 149 125 26 9, disable
}
on *:dialog:theme:init:*: {
  if ($group(#colortheme) == on) { did -c theme 98 | _vw color color_switch on }
  r.fr
;  dll $adll tooltip_add $dialog(theme).hwnd 102 $rgb(119,154,247) $rgb(255,255,255) 1 Nicklist edit:Customize nicklist colors and icons.
;  dll $adll tooltip_add $dialog(theme).hwnd 105 $rgb(119,154,247) $rgb(255,255,255) 1 Nick completor:Customize nick completor.
;  dll $adll tooltip_add $dialog(theme).hwnd 106 $rgb(119,154,247) $rgb(255,255,255) 1 Graphics:Customize graphics.
;  dll $adll tooltip_add $dialog(theme).hwnd 110 $rgb(119,154,247) $rgb(255,255,255) 1 Sounds:Customize sounds.
;  dll $adll tooltip_add $dialog(theme).hwnd 108 $rgb(119,154,247) $rgb(255,255,255) 1 Save theme:Save current theme.
;  dll $adll tooltip_add $dialog(theme).hwnd 109 $rgb(119,154,247) $rgb(255,255,255) 1 Load theme:Load a prevously saved theme.
}
on *:dialog:theme:sclick:*: {
  if ($did == 108) { sav.list }
  if ($did == 109) { load.list }
  if ($did == 98) { 
    if ($group(#colortheme) == on) { _vw color color_switch off | .disable #colortheme }
    else { _vw color color_switch off | .enable #colortheme }
  }
  if ($did == 127) { 
    did -c theme 16 | refres | _vw color op_switch on | .timer -m 1 1 did -u theme 18,17
    did -r theme 99,100 | did -o theme 99 1 %exop | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exop 
  }
  if ($did == 129) { 
    did -c theme 23 | refres | _vw color halfop_switch on | .timer -m 1 1 did -u theme 24,25
    did -r theme 99,100 | did -o theme 99 1 %exhalfop | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exdehalfop
  }
  if ($did == 132) { 
    did -c theme 27 | refres | _vw color voice_switch on | .timer -m 1 1 did -u theme 29,28
    did -r theme 99,100 | did -o theme 99 1 %exvoice | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exvoice 
  }
  if ($did == 128) { 
    did -c theme 55 | refres | _vw color deop_switch on | .timer -m 1 1 did -u theme 56,57
    did -r theme 99,100 | did -o theme 99 1 %exdeop | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exdeop
  }
  if ($did == 130) { 
    did -c theme 63 | refres | _vw color halfdeop_switch on | .timer -m 1 1 did -u theme 65,64
    did -r theme 99,100 | did -o theme 99 1 %exdehalfop | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exdehalfop 
  }
  if ($did == 131) { 
    did -c theme 59 | refres | _vw color devoice_switch on |  did -o theme 99 1 %exdevoice | .timer -m 1 1 did -u theme 60,61
    did -r theme 99,100 | did -o theme 99 1 %exdevoice | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exdevoice
  }
  if ($did == 121) { 
    did -c theme 35 | refres | _vw color join_switch on | .timer -m 1 1 did -u theme 36,37
    did -r theme 99,100 | did -o theme 99 1 %exjoin | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exjoin
  }
  if ($did == 122) { 
    did -c theme 43 | refres | _vw color quit_switch on | .timer -m 1 1 did -u theme 44,45 
    did -r theme 99,100 | did -o theme 99 1 %exquit | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exquit 
  }
  if ($did == 123) { 
    did -c theme 39 | refres | _vw color part_switch on | .timer -m 1 1 did -u theme 40,41
    did -r theme 99,100 | did -o theme 99 1 %expart | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit expart 
  }
  if ($did == 124) { 
    did -c theme 95 | refres | _vw color action_switch on | .timer -m 1 1 did -u theme 97,96
    did -r theme 99,100 | did -o theme 99 1 %exaction | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exaction
  }
  if ($did == 126) { 
    did -c theme 3 | refres | _vw color menick_switch on | .timer -m 1 1 did -u theme 1,2 | did -e theme 100
    did -r theme 99,100 | did -o theme 99 1 %meext.1 | did -o theme 100 1 %meext.2 | did -e theme 100,99,103,101,133 | _vw theme edit meext.1 | _vw theme edit2 meext.2
  }
  if ($did == 125) { 
    did -c theme 12 | refres | _vw color channick_switch on | .timer -m 1 1 did -u theme 14,13 | did -e theme 100
    did -r theme 99,100 | did -o theme 99 1 %exnick1 | did -o theme 100 1 %exnick2 | did -e theme 100,99,103,101,133 | _vw theme edit exnick1 | _vw theme edit2 exnick2 
  }
  if ($did == 9) { 
    did -c theme 47 | refres | _vw color kick_switch on |  .timer -m 1 1 did -u theme 48,49
    did -r theme 99,100 | did -o theme 99 1 %exkick | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exkick
  }
  if ($did == 19) { 
    did -c theme 51 | refres | _vw color ban_switch on | .timer -m 1 1 did -u theme 53,52 
    did -r theme 99,100 | did -o theme 99 1 %exban | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exban 
  }
  if ($did == 20) { 
    did -c theme 71 | refres | _vw color unban_switch on | .timer -m 1 1 did -u theme 73,72
    did -r theme 99,100 | did -o theme 99 1 %exunban | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exunban 
  }
  if ($did == 21) { 
    did -c theme 31 | refres | _vw color mode_switch on | .timer -m 1 1 did -u theme 33,32
    did -r theme 99,100 | did -o theme 99 1 %exmode | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exmode
  }
  if ($did == 119) { 
    did -c theme 112 | refres | _vw color topic_switch on | .timer -m 1 1 did -u theme 114,113
    did -r theme 99,100 | did -o theme 99 1 %extopic | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit extopic
  }
  if ($did == 120) { 
    did -c theme 67 | refres | _vw color newnick_switch on | .timer -m 1 1 did -u theme 68,69 
    did -r theme 99,100 | did -o theme 99 1 %exnewnick | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exnew
  }
  if ($did == 4) { 
    did -c theme 75 | refres | _vw color notice_switch on | .timer -m 1 1 did -u theme 76,77
    did -r theme 99,100 | did -o theme 99 1 %exnotice | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exnotice 
  }
  if ($did == 7) { did -r theme 99,100 | did -o theme 99 1 %exmode | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exmode }
  if ($did == 5) { 
    did -c theme 83 | refres | _vw color opchar_switch on | .timer -m 1 1 did -u theme 85,84
    did -r theme 99,100 | did -o theme 99 1 %exopchar | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exopchar 
  }
  if ($did == 8) { 
    did -c theme 87 | refres | _vw color halfopchar_switch on | .timer -m 1 1 did -u theme 89,88
    did -r theme 99,100 | did -o theme 99 1 %exhalfopchar | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exhalfopchar
  }
  if ($did == 6) { 
    did -c theme 91 | refres | _vw color voicechar_switch on | .timer -m 1 1 did -u theme 93,92
    did -r theme 99,100 | did -o theme 99 1 %exvoicechar | did -b theme 100 | did -e theme 99,103,101,133 | _vw theme edit exvoicechar 
  }
  if ($did == 18) { did -c theme 18 | refres | _vw color op_switch off | .timer -m 1 1 did -u theme 17,16 | did -b theme 99,103,101,133 } 
  if ($did == 17) { did -c theme 17 | refres | _vw color op_switch on | %exop = $c(mode) $+ (..op..) | .timer -m 1 1 did -u theme 18,16 | did -b theme 99,103,101,133 } 
  if ($did == 16) { did -c theme 16 | refres | _vw color op_switch on | did -o theme 99 1 %exop | .timer -m 1 1 did -u theme 18,17 }

  if ($did == 57) { did -c theme 57 | refres | _vw color deop_switch off | .timer -m 1 1 did -u theme 55,56 | did -b theme 99,103,101,133 } 
  if ($did == 56) { did -c theme 56 | refres | _vw color deop_switch on | %exdeop = $c(mode) $+ (..deop..) | .timer -m 1 1 did -u theme 55,57 | did -b theme 99,103,101,133 } 
  if ($did == 55) { did -c theme 55 | refres | _vw color deop_switch on | did -o theme 99 1 %exdeop | .timer -m 1 1 did -u theme 56,57 }

  if ($did == 25) { did -c theme 25 | refres | _vw color halfop_switch off | .timer -m 1 1 did -u theme 24,23 | did -b theme 99,103,101,133 } 
  if ($did == 24) { did -c theme 24 | refres | _vw color halfop_switch on | %exhalfop = $c(mode) $+ (..halfop..) | .timer -m 1 1 did -u theme 25,23 | did -b theme 99,103,101,133 } 
  if ($did == 23) { did -c theme 23 | refres | _vw color halfop_switch on | did -o theme 99 1 %exhalfop | .timer -m 1 1 did -u theme 24,25 }

  if ($did == 65) { did -c theme 65 | refres | _vw color halfdeop_switch off | .timer -m 1 1 did -u theme 64,63 | did -b theme 99,103,101,133 } 
  if ($did == 64) { did -c theme 64 | refres | _vw color halfdeop_switch on | %exdehalfop = $c(mode) $+ (..dehalf-op..) | .timer -m 1 1 did -u theme 65,63 | did -b theme 99,103,101,133 } 
  if ($did == 63) { did -c theme 63 | refres | _vw color halfdeop_switch on | did -o theme 99 1 %exdehalfop | .timer -m 1 1 did -u theme 65,64 }

  if ($did == 29) { did -c theme 29 | refres | _vw color voice_switch off | .timer -m 1 1 did -u theme 28,27 | did -b theme 99,103,101,133 } 
  if ($did == 28) { did -c theme 28 | refres | _vw color voice_switch on |  %exvoice = $c(mode) $+ (..voice..) | .timer -m 1 1 did -u theme 27,29 | did -b theme 99,103,101,133 } 
  if ($did == 27) { did -c theme 27 | refres | _vw color voice_switch on |  did -o theme 99 1 %exvoice | .timer -m 1 1 did -u theme 29,28 }

  if ($did == 61) { did -c theme 61 | refres | _vw color devoice_switch off | .timer -m 1 1 did -u theme 60,59 | did -b theme 99,103,101,133 } 
  if ($did == 60) { did -c theme 60 | refres | _vw color devoice_switch on |  %exdevoice = $c(mode) $+ (..devoice..) | .timer -m 1 1 did -u theme 61,59 | did -b theme 99,103,101,133 } 
  if ($did == 59) { did -c theme 59 | refres | _vw color devoice_switch on |  did -o theme 99 1 %exdevoice | .timer -m 1 1 did -u theme 60,61 }

  if ($did == 41) { did -c theme 41 | refres | _vw color part_switch off | .timer -m 1 1 did -u theme 40,39 | did -b theme 99,103,101,133 } 
  if ($did == 40) { did -c theme 40 | refres | _vw color part_switch on | %expart = $c(part) $+ (..part..) | .timer -m 1 1 did -u theme 41,39 | did -b theme 99,103,101,133 } 
  if ($did == 39) { did -c theme 39 | refres | _vw color part_switch on |  did -o theme 99 1 %expart | .timer -m 1 1 did -u theme 40,41 }

  if ($did == 97) { did -c theme 97 | refres | _vw color action_switch off | .timer -m 1 1 did -u theme 96,95 | did -b theme 99,103,101,133 } 
  if ($did == 96) { did -c theme 96 | refres | _vw color action_switch on | %exaction = $c(action) $+ • | .timer -m 1 1 did -u theme 97,95 | did -b theme 99,103,101,133 } 
  if ($did == 95) { did -c theme 95 | refres | _vw color action_switch on | did -o theme 99 1 %exaction | .timer -m 1 1 did -u theme 97,96 }

  if ($did == 1) { did -c theme 1 | refres | _vw color menick_switch off | .timer -m 1 1 did -u theme 2,3 | did -b theme 99,103,101,133 } 
  if ($did == 2) { did -c theme 2 | refres | _vw color menick_switch on | %meext.1 = 4• | %meext.2 = 4• | .timer -m 1 1 did -u theme 1,3 | did -b theme 99,103,101,133 } 
  if ($did == 3) { did -c theme 3 | refres | _vw color menick_switch on | did -o theme 99 1 %meext.1 | did -o theme 100 1 %meext.2 | .timer -m 1 1 did -u theme 1,2 | did -e theme 100 }

  if ($did == 14) { did -c theme 14 | refres | _vw color channick_switch off | .timer -m 1 1 did -u theme 13,12 | did -b theme 99,103,101,133 } 
  if ($did == 13) { did -c theme 13 | refres | _vw color channick_switch on | %exnick1 = 4· | %exnick2 = 4· | .timer -m 1 1 did -u theme 14,12 | did -b theme 99,103,101,133 } 
  if ($did == 12) { did -c theme 12 | refres | _vw color channick_switch on | did -o theme 99 1 %exnick1 | did -o theme 100 1 %exnick2 | .timer -m 1 1 did -u theme 14,13 | did -e theme 100 }

  if ($did == 49) { did -c theme 49 | refres | _vw color kick_switch off | .timer -m 1 1 did -u theme 48,47 | did -b theme 99,103,101,133 } 
  if ($did == 48) { did -c theme 48 | refres | _vw color kick_switch on | %exkick = $c(kick) $+ (..kick..) | .timer -m 1 1 did -u theme 49,47 | did -b theme 99,103,101,133 } 
  if ($did == 47) { did -c theme 47 | refres | _vw color kick_switch on |  did -o theme 99 1 %exkick | .timer -m 1 1 did -u theme 48,49 }

  if ($did == 53) { did -c theme 53 | refres | _vw color ban_switch off | .timer -m 1 1 did -u theme 52,51 | did -b theme 99,103,101,133 } 
  if ($did == 52) { did -c theme 52 | refres | _vw color ban_switch on | %exban = $c(mode) $+ (..ban..) | .timer -m 1 1 did -u theme 53,51 | did -b theme 99,103,101,133 } 
  if ($did == 51) { did -c theme 51 | refres | _vw color ban_switch on |  did -o theme 99 1 %exban | .timer -m 1 1 did -u theme 53,52 }

  if ($did == 33) { did -c theme 33 | refres | _vw color mode_switch off | .timer -m 1 1 did -u theme 32,31 | did -b theme 99,103,101,133 } 
  if ($did == 32) { did -c theme 32 | refres | _vw color mode_switch on | %exmode = $c(mode) $+ (..mode..) | .timer -m 1 1 did -u theme 33,31 | did -b theme 99,103,101,133 } 
  if ($did == 31) { did -c theme 31 | refres | _vw color mode_switch on |  did -o theme 99 1 %exmode | .timer -m 1 1 did -u theme 33,32 }

  if ($did == 73) { did -c theme 73 | refres | _vw color unban_switch off | .timer -m 1 1 did -u theme 72,71 | did -b theme 99,103,101,133 } 
  if ($did == 72) { did -c theme 72 | refres | _vw color unban_switch on | %exunban = $c(mode) $+ (..unban..) | .timer -m 1 1 did -u theme 73,71 | did -b theme 99,103,101,133 } 
  if ($did == 71) { did -c theme 71 | refres | _vw color unban_switch on |  did -o theme 99 1 %exunban | .timer -m 1 1 did -u theme 73,72 }

  if ($did == 77) { did -c theme 77 | refres | _vw color notice_switch off | .timer -m 1 1 did -u theme 76,75 | did -b theme 99,103,101,133 } 
  if ($did == 76) { did -c theme 76 | refres | _vw color notice_switch on | %exnotice = $c(notice) $+ (..notice..) | .timer -m 1 1 did -u theme 77,75 | did -b theme 99,103,101,133 } 
  if ($did == 75) { did -c theme 75 | refres | _vw color notice_switch on |  did -o theme 99 1 %exnotice | .timer -m 1 1 did -u theme 76,77 }

  if ($did == 69) { did -c theme 69 | refres | _vw color newnick_switch off | .timer -m 1 1 did -u theme 68,67 | did -b theme 99,103,101,133 } 
  if ($did == 68) { did -c theme 68 | refres | _vw color newnick_switch on | %exnewnick = $c(nick) $+ (..nick change..) | .timer -m 1 1 did -u theme 69,67 | did -b theme 99,103,101,133 } 
  if ($did == 67) { did -c theme 67 | refres | _vw color newnick_switch on |  did -o theme 99 1 %exnewnick | .timer -m 1 1 did -u theme 68,69 }

  if ($did == 93) { did -c theme 93 | refres | _vw color voicechar_switch off | .timer -m 1 1 did -u theme 92,91 | did -b theme 99,103,101,133 } 
  if ($did == 92) { did -c theme 92 | refres | _vw color voicechar_switch on | %exvoicechar = 14+ | .timer -m 1 1 did -u theme 93,91 | did -b theme 99,103,101,133 } 
  if ($did == 91) { did -c theme 91 | refres | _vw color voicechar_switch on |  did -o theme 99 1 %exvoicechar | .timer -m 1 1 did -u theme 93,92 }

  if ($did == 85) { did -c theme 85 | refres | _vw color opchar_switch off | .timer -m 1 1 did -u theme 84,83 | did -b theme 99,103,101,133 } 
  if ($did == 84) { did -c theme 84 | refres | _vw color opchar_switch on | %exopchar = 14@ | .timer -m 1 1 did -u theme 85,83 | did -b theme 99,103,101,133 } 
  if ($did == 83) { did -c theme 83 | refres | _vw color opchar_switch on |  did -o theme 99 1 %exopchar | .timer -m 1 1 did -u theme 85,84 }

  if ($did == 89) { did -c theme 89 | refres | _vw color halfopchar_switch off | .timer -m 1 1 did -u theme 88,87 | did -b theme 99,103,101,133 } 
  if ($did == 88) { did -c theme 88 | refres | _vw color halfopchar_switch on | %exhalfopchar = 14% | .timer -m 1 1 did -u theme 87,89 | did -b theme 99,103,101,133 } 
  if ($did == 87) { did -c theme 87 | refres | _vw color halfopchar_switch on |  did -o theme 99 1 %exhalfopchar | .timer -m 1 1 did -u theme 89,88 }

  if ($did == 114) { did -c theme 114 | refres | _vw color topic_switch off | .timer -m 1 1 did -u theme 113,112 | did -b theme 99,103,101,133 } 
  if ($did == 113) { did -c theme 113 | refres | _vw color topic_switch on | %extopic = $c(topic) $+ (..topic..) | .timer -m 1 1 did -u theme 112,114 | did -b theme 99,103,101,133 } 
  if ($did == 112) { did -c theme 112 | refres | _vw color topic_switch on |  did -o theme 99 1 %extopic | .timer -m 1 1 did -u theme 114,113 }

  if ($did == 35) { did -c theme 35 | refres | _vw color join_switch on | did -o theme 99 1 %exjoin | .timer -m 1 1 did -u theme 36,37 }
  if ($did == 36) { did -c theme 36 | refres | _vw color join_switch on | %exjoin = $c(join) $+ (..join..) | .timer -m 1 1 did -u theme 35,37 | did -b theme 99,103,101,133 } 
  if ($did == 37) { did -c theme 37 | refres | _vw color join_switch off | .timer -m 1 1 did -u theme 35,36 | did -b theme 99,103,101,133 } 
  if ($did == 43) { did -c theme 43 | refres | _vw color quit_switch on | did -o theme 99 1 %exquit | .timer -m 1 1 did -u theme 44,45 }
  if ($did == 44) { did -c theme 44 | refres | _vw color quit_switch on | %exquit = $c(quit) $+ (..quit..) | .timer -m 1 1 did -u theme 45,43 | did -b theme 99,103,101,133 } 
  if ($did == 45) { did -c theme 45 | refres | _vw color quit_switch off | .timer -m 1 1 did -u theme 44,43 | did -b theme 99,103,101,133 } 
  if ($did == 102) { nl.icon }
  if ($did == 105) { nc.setup }
  if ($did == 106) { backg } 
  if ($did == 110) { soundcon } 
  if ($did == 133) {
    set $tedit $did(theme,99).text
    set $tedit2 $did(theme,100).text
    _vrem theme edit | _vrem theme edit2 
    did -r theme 99,100  
    did -b theme 100,99,101,133
  } 
}
alias -l tedit {
  return $chr(37) $+ $_vr(theme,edit)
}
alias -l tedit2 {
  return $chr(37) $+ $_vr(theme,edit2)
}
alias -l refres {
  did -b theme 100,99 
  did -r theme 99,100
  did -e theme 99,103,101,133
}
alias -l r.fr {
  if ($_vr(color,notice_switch) == on) { 
    if (%exnotice == $c(notice) $+ (..notice..)) { did -c theme 76 }
    else { did -c theme 75 }
  }
  else { did -c theme 77 }
  if ($_vr(color,channick_switch) == on) {
    if (%exnick1 == 4·) && (%exnick2 == 4·) { did -c theme 13  }
    else { did -c theme 12 }
  }
  else { did -c theme 14 }
  if ($_vr(color,menick_switch) == on) { 
    if (%meext.1 == 4•) && (%meext.2 == 4•) { did -c theme 2 }
    else { did -c theme 3 }
  }
  else { did -c theme 1 }
  if ($_vr(color,ban_switch) == on) { 
    if (%exban == $c(mode) $+ (..ban..)) { did -c theme 52 }
    else { did -c theme 51 }
  }
  else { did -c theme 53 }
  if ($_vr(color,unban_switch) == on) {
    if (%exunban == $c(mode) $+ (..unban..)) { did -c theme 72 }
    else { did -c theme 71 }
  } 
  else { did -c theme 73 }
  if ($_vr(color,deop_switch) == on) {
    if (%exdeop == $c(mode) $+ (..deop..)) { did -c theme 56 }
    else { did -c theme 55 }
  }
  else { did -c theme 57 }
  if ($_vr(color,op_switch) == on) { 
    if (%exop == $c(mode) $+ (..op..)) { did -c theme 17 }
    else { did -c theme 16 }
  }
  else { did -c theme 18 }
  if ($_vr(color,halfop_switch) == on) {
    if (%exhalfop == $c(mode) $+ (..halfop..)) { did -c theme 24 }
    else { did -c theme 23 }
  }
  else { did -c theme 25 }
  if ($_vr(color,dehalfop_switch) == on) {
    if (%exdehalfop == $c(mode) $+ (..dehalf-op..)) { did -c theme 64 }
    else { did -c theme 63 }
  }
  else { did -c theme 65 }
  if ($_vr(color,devoice_switch) == on) {
    if (%exdevoice == $c(mode) $+ (..devoice..)) { did -c theme 60 }
    else { did -c theme 59 }
  }
  else { did -c theme 61 }
  if ($_vr(color,voice_switch) == on) {
    if (%exvoice == $c(mode) $+ (..voice..)) { did -c theme 28 }
    else { did -c theme 27 }
  }
  else { did -c theme 29 }
  if ($_vr(color,join_switch) == on) {
    if (%exjoin == $c(join) $+ (..join..)) { did -c theme 36 }
    else { did -c theme 35 }
  }
  else { did -c theme 37 }
  if ($_vr(color,part_switch) == on) { 
    if (%expart == $c(part) $+ (..part..)) { did -c theme 40 }
    else { did -c theme 39 }
  }
  else { did -c theme 41 }
  if ($_vr(color,kick_switch) == on) {
    if (%exkick == $c(kick) $+ (..kick..)) { did -c theme 48 }
    else { did -c theme 47 }
  }
  else { did -c theme 49 }
  if ($_vr(color,quit_switch) == on) {
    if (%exquit == $c(quit) $+ (..quit..)) { did -c theme 44 }
    else { did -c theme 43 }
  }
  else { did -c theme 45 }
  if ($_vr(color,topic_switch) == on) { 
    if (%extopic == $c(topic) $+ (..topic..)) { did -c theme 113 }
    else { did -c theme 112 }
  }
  else { did -c theme 114 }
  if ($_vr(color,mode_switch) == on) {
    if (%exmode == $c(mode) $+ (..mode..)) { did -c theme 32 }
    else { did -c theme 31 }
  }
  else { did -c theme 33 }
  if ($_vr(color,newnick_switch) == on) {
    if (%exnewnick == $c(nick) $+ (..nick change..)) { did -c theme 68 }
    else { did -c theme 67 }
  }
  else { did -c theme 69 }
  if ($_vr(color,action_switch) == on) {
    if (%exaction == $c(action) $+ •) { did -c theme 96 }
    else { did -c theme 95 }
  }
  if ($_vr(color,opchar_switch) == on) {
    if (%exopchar == 14@) { did -c theme 84 }
    else { did -c theme 83 }
  }
  else { did -c theme 85 }
  if ($_vr(color,halfopchar_switch) == on) {
    if (%exhalfopchar == 14%) { did -c theme 88 }
    else { did -c theme 87 }
  }
  else { did -c theme 89 }
  if ($_vr(color,voicechar_switch) == on) {
    if (%exvoicechar == 14+) { did -c theme 92 }
    else { did -c theme 91 }
  }
  else { did -c theme 93 }
}
alias -l sav.list {
  if ($_vr(theme,listpath) != $null) { %theme.file = $$file="save file as" $_vr(theme,listpath) }
  else { %theme.file = $$file="save file as" }
  _vw theme listpath $nofile(%theme.file)
  write -c %theme.file 
  write %theme.file %exop 
  write %theme.file %exdeop 
  write %theme.file %exhalfop
  write %theme.file %exdehalfop 
  write %theme.file %exvoice 
  write %theme.file %exdevoice 
  write %theme.file %exjoin 
  write %theme.file %exquit 
  write %theme.file %expart 
  write %theme.file %exaction 
  write %theme.file %exnick1 
  write %theme.file %exnick2 
  write %theme.file %meext.1 
  write %theme.file %meext.2 
  write %theme.file %exkick 
  write %theme.file %exban 
  write %theme.file %exunban 
  write %theme.file %extopic 
  write %theme.file %exnewnick 
  write %theme.file %exnotice 
  write %theme.file %exhalfopchar 
  write %theme.file %exvoicechar 
  write %theme.file %exopchar 
  if ($_vr(color,notice_switch) == on) { writeini %theme.file color notice_switch on }
  if ($_vr(color,menick_switch) == on) { writeini %theme.file color menick_switch on }
  if ($_vr(color,kick_switch) == on) { writeini %theme.file color kick_switch on }
  if ($_vr(color,opchar_switch) == on) { writeini %theme.file color opchar_switch on }
  if ($_vr(color,halfopchar_switch) == on) { writeini %theme.file color halfopchar_switch on }
  if ($_vr(color,voicechar_switch) == on) { writeini %theme.file color voicechar_switch on }
  if ($_vr(color,halfop_switch) == on) { writeini %theme.file color halfop_switch on }
  if ($_vr(color,join_switch) == on) { writeini %theme.file color join_switch on }
  if ($_vr(color,quit_switch) == on) { writeini %theme.file color quit_switch on }
  if ($_vr(color,mode_switch) == on) { writeini %theme.file color mode_switch on }
  if ($_vr(color,dehalfop_switch) == on) { writeini %theme.file color dehalfop_switch on }
  if ($_vr(color,op_switch) == on) { writeini %theme.file color op_switch on }
  if ($_vr(color,channick_switch) == on) { writeini %theme.file color channick_switch on }
  if ($_vr(color,voice_switch) == on) { writeini %theme.file color voice_switch on }
  if ($_vr(color,action_switch) == on) { writeini %theme.file color action_switch on }
  if ($_vr(color,topic_switch) == on) { writeini %theme.file color topic_switch on }
  if ($_vr(color,part_switch) == on) { writeini %theme.file color part_switch on }
  if ($_vr(color,devoice_switch) == on) { writeini %theme.file color devoice_switch on }
  if ($_vr(color,deop_switch) == on) { writeini %theme.file color deop_switch on }
  if ($_vr(color,ban_switch) == on) { writeini %theme.file color ban_switch on }
  if ($_vr(color,unban_switch) == on) { writeini %theme.file color unban_switch on }
  if ($_vr(color,halfdeop_switch) == on) { writeini %theme.file color halfdeop_switch on }
  if ($_vr(color,newnick_switch) == on) { writeini %theme.file color newnick_switch on }
}
alias -l load.list {
  if ($_vr(theme,listpath) != $null) { %theme.file = $$hfile="load file" $_vr(theme,listpath) }
  else { %theme.file = $$hfile="load file" }
  did -u theme 16,17,18,55,56,57,23,24,25,63,64,65,27,28,29,59,60,61,35,36,37,43,44,45,39,40,41.95,96,97,1,2,3,12,13,14,47,48,49,51,52,53,71,72,73,31,32,33,112,113,114,67,68,69,75,76,77,87,88,89,83,84,85,91,92,93  
  %exop = $read(%theme.file,1) 
  %exdeop = $read(%theme.file,2) 
  %exhalfop = $read(%theme.file,3)
  %exdehalfop = $read(%theme.file,4) 
  %exvoice = $read(%theme.file,5) 
  %exdevoice = $read(%theme.file,6) 
  %exjoin = $read(%theme.file,7)
  %exquit = $read(%theme.file,8) 
  %expart = $read(%theme.file,9) 
  %exaction = $read(%theme.file,10) 
  %exnick1 = $read(%theme.file,11) 
  %exnick2 = $read(%theme.file,12) 
  %meext.1 = $read(%theme.file,13) 
  %meext.2 = $read(%theme.file,14) 
  %exkick = $read(%theme.file,15) 
  %exban = $read(%theme.file,16) 
  %exunban = $read(%theme.file,17) 
  %extopic = $read(%theme.file,18) 
  %exnewnick = $read(%theme.file,19) 
  %exnotice = $read(%theme.file,10) 
  %exhalfopchar = $read(%theme.file,11) 
  %exvoicechar = $read(%theme.file,12) 
  %exopchar = $read(%theme.file,13) 
  if ($readini(%theme.file,color,notice_switch) == on) { _vw color notice_switch on }
  if ($readini(%theme.file,color,menick_switch) == on) { _vw color menick_switch on }
  if ($readini(%theme.file,color,kick_switch) == on) { _vw color kick_switch on }
  if ($readini(%theme.file,color,opchar_switch) == on) { _vw color opchar_switch on }
  if ($readini(%theme.file,color,halfopchar_switch) == on) { _vw color halfopchar_switch on }
  if ($readini(%theme.file,color,voicechar_switch) == on) { _vw color voicechar_switch on }
  if ($readini(%theme.file,color,halfop_switch) == on) { _vw color halfop_switch on }
  if ($readini(%theme.file,color,join_switch) == on) { _vw color join_switch on }
  if ($readini(%theme.file,color,quit_switch) == on) { _vw color quit_switch on }
  if ($readini(%theme.file,color,mode_switch) == on) { _vw color mode_switch on }
  if ($readini(%theme.file,color,dehalfop_switch) == on) { _vw color dehalfop_switch on }
  if ($readini(%theme.file,color,op_switch) == on) { _vw color op_switch on }
  if ($readini(%theme.file,color,channick_switch) == on) { _vw color channick_switch on }
  if ($readini(%theme.file,color,voice_switch) == on) { _vw color voice_switch on }
  if ($readini(%theme.file,color,action_switch) == on) { _vw color action_switch on }
  if ($readini(%theme.file,color,topic_switch) == on) { _vw color topic_switch on }
  if ($readini(%theme.file,color,part_switch) == on) { _vw color part_switch on }
  if ($readini(%theme.file,color,devoice_switch) == on) { _vw color devoice_switch on }
  if ($readini(%theme.file,color,deop_switch) == on) { _vw color deop_switch on }
  if ($readini(%theme.file,color,ban_switch) == on) { _vw color ban_switch on }
  if ($readini(%theme.file,color,unban_switch) == on) { _vw color unban_switch on }
  if ($readini(%theme.file,color,halfdeop_switch) == on) { _vw color halfdeop_switch on }
  if ($readini(%theme.file,color,newnick_switch) == on) { _vw color newnick_switch on }
  .timer -m 1 1 r.fr
}
