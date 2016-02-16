;Background Console v1.67
;Team Nexgen 2001 by KnightFal
;team-nexgen.com

on *:load:{
  if ($version < 6.01) echo -a  $+ $colour(info2) $+ *** You need mirc 6.01 or greator in order to use this addon. | beep 
  echo -a 4TEAM NEXGEN'S BACKGROUND CONSOLE v1.67 | echo -a 4Please type: /backg to begin console mode.
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
alias backg {
  if ($version < 5.91) { echo -s 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($dialog(background) == $null) { dialog -m background background }
}
dialog background {
  title "background console v1.67"
  size 165 137 288 202
  option dbu
  icon 100, 10 87 172 82
  edit "", 101, 5 182 132 10, read autohs
  text "current path", 102, 5 175 35 7
  button "select path", 103, 140 182 40 10
  button "apply", 50, 209 183 25 10
  button "close", 51, 239 183 25 10, default ok
  list 52, 5 2 175 63, sort size hsbar vsbar
  combo 32, 207 12 58 56, drop
  radio "center", 34, 206 26 32 10, disable
  radio "fill", 35, 206 36 16 10, disable
  radio "normal", 36, 206 46 32 10, disable
  radio "stretch", 37, 238 26 32 10, disable
  radio "tile", 38, 238 36 16 10, disable
  radio "photo", 39, 238 46 24 10, disable
  radio "none", 41, 223 57 24 10, disable
  box "background", 1, 201 1 70 70
  box "background preview", 13, 5 79 178 94
  button "delete", 15, 152 68 29 8, disable
  edit "", 16, 4 67 114 10, disable autohs
  button "rename", 17, 121 68 29 8, disable
  tab "nicklist", 18, 191 71 91 103
  box "nicklist", 14, 196 87 82 84, tab 18
  combo 7, 235 105 37 50, tab 18 drop
  check "enable color nicklist", 2, 201 94 62 10, tab 18
  check "ops", 3, 201 104 22 10, tab 18
  check "voice", 4, 201 114 27 10, tab 18
  check "regular", 5, 201 135 27 10, tab 18
  check "own nick", 6, 201 145 33 10, tab 18
  text "background", 33, 201 156 32 9, tab 18
  combo 8, 235 115 37 50, tab 18 drop
  combo 9, 235 135 37 50, tab 18 drop
  combo 10, 235 145 37 50, tab 18 drop
  combo 11, 235 155 37 50, tab 18 drop
  combo 12, 235 125 37 50, tab 18 drop
  check "half-ops", 30, 201 125 29 10, tab 18
  tab "nick flash", 19
  check "enable", 24, 198 90 27 10, tab 19
  text "flash color", 54, 195 106 37 6, tab 19
  combo 20, 195 114 37 55, disable tab 19 drop
  button "P", 22, 213 145 7 11, disable tab 19
  combo 21, 243 114 37 55, disable tab 19 drop
  text "fade color", 55, 244 106 29 6, tab 19
  check "alert sound", 53, 199 133 37 10, disable tab 19
  button "select sound", 23, 224 146 40 10, disable tab 19
  box "sound", 25, 196 126 82 34, tab 19
  tab "about", 26
  link "team-nexgen.com", 27, 210 134 65 8, tab 26
  text "author: KnightFal", 28, 213 110 45 8, tab 26
  text "version: 1.67", 29, 213 121 35 8, tab 26
  box "", 31, 205 99 66 50, tab 26
}
on *:dialog:background:dclick:*:{
  run $shortfn($did(52,$did(52).sel)) 
}
on *:dialog:background:edit:*:{
  if ($did == 16) { set %back.name $did(16,$did(16).text) }
}
on *:dialog:background:sclick:*:{
  if ($did == 17) { 
    var %back.rename =  $did(52,$did(52).sel)
    var %back.rename2 =  $nofile($did(52,$did(52).sel)) $+ %back.name
    rename %back.rename %back.rename2    
    back.l
  }
  if ($did == 2) { 
    var %xt = 3
    :loop
    did - $+ $iif($did(2).state,e,b) background %xt
    if (%xt < 6) { inc %xt | goto loop }
    _vw  nicklist switch 0 
  }
  if ($did == 7) { _vw nicklist ops $calc($did(background,7).sel - 1) }
  if ($did == 8) { _vw nicklist voice $calc($did(background,8).sel - 1) }
  if ($did == 12) { _vw nicklist hops $calc($did(background,12).sel - 1) }
  if ($did == 9) { _vw nicklist reg $calc($did(background,9).sel - 1) }
  if ($did == 10) { _vw nicklist me $calc($did(background,10).sel - 1) }
  if ($did == 24) { 
    if ($_vr(nickflash,switch) == on) { _vw nickflash switch off | did -b background 20,21,53  }
    else { _vw nickflash switch on | did -c background 24 | did -e background 20,21,53 }
  }  
  if ($did == 30) { 
    if ($_vr(nicklist,s.hops) == 1) { _vw nicklist s.hops 0  }
    else { _vw nicklist s.hops 1 }
  }  
  if ($did == 3) { 
    if ($_vr(nicklist,s.ops) == 1) { _vw nicklist s.ops 0  }
    else { _vw nicklist s.ops 1 }
  }  
  if ($did == 4) { 
    if ($_vr(nicklist,s.voice) == 1) { _vw nicklist s.voice 0  }
    else { _vw nicklist s.voice 1 }
  }  
  if ($did == 5) { 
    if ($_vr(nicklist,s.reg) == 1) { _vw nicklist s.reg 0  }
    else { _vw nicklist s.reg 1 }
  }  
  if ($did == 6) { 
    if ($_vr(nicklist,s.me) == 1) { _vw nicklist s.me 0  }
    else { _vw nicklist s.me 1 }
  }  
  if ($did == 20) { 
    _vw nickflash color $calc($did(background,20).sel -1)   
  }
  if ($did == 21) { 
    _vw nickflash back $calc($did(background,21).sel -1)   
  }
  if ($did == 27) { run http://team-nexgen.com | beep } 
  if ($did == 50) { 
    if ($did(52,$did(52).sel) != $null) && $_vr(background,type) != $null) && $_vr(background,window) != $null) { 
    background $_vr(background,window) $+ $_vr(background,type) $shortfn($did(52,$did(52).sel)) } 
    cl.apply 
  }
  if ($did == 32) { 
    if  ($did(background,$did,1).sel == 1) { _vrem background window | halt }   
    elseif ($did(background,$did,1).sel == 2) { _vw background window -m | _vrem background default }
    elseif ($did(background,$did,1).sel == 3) { _vw background window -s | _vrem background default }
    elseif ($did(background,$did,1).sel == 4) { _vw background window -g | _vrem background default }
    elseif ($did(background,$did,1).sel == 5) { _vw background window -l | _vrem background default }
    elseif ($did(background,$did,1).sel == 6) { _vw background window -u | _vrem background default }
    elseif ($did(background,$did,1).sel == 7) { _vw background window -h | _vrem background default }
    elseif ($did(background,$did,1).sel == 8) { _vw background channel on | _vrem background default }
  }
  if ($did == 15) { set %backdel $shortfn($did(52,$did(52).sel)) | back.del }
  if ($did == 52) { did -g background 100  $shortfn($did(52,$did(52).sel)) | did -o background 16 1 $nopath($did(52,$did(52).sel)) | did -e background 15,16,17,34,35,36,37,38,39,41 }
  if ($did == 34) { _vw background type -c | if ($did(background,$did,1).sel == 8) { _vw background channeltype -c } }
  if ($did == 35) { _vw background type -f | if ($did(background,$did,1).sel == 8) { _vw background channeltype -f } }
  if ($did == 36) { _vw background type -n | if ($did(background,$did,1).sel == 8) { _vw background channeltype -n } }
  if ($did == 37) { _vw background type -r | if ($did(background,$did,1).sel == 8) { _vw background channeltype -r } }
  if ($did == 38) { _vw background type -t | if ($did(background,$did,1).sel == 8) { _vw background channeltype -t } }
  if ($did == 39) { _vw background type -p | if ($did(background,$did,1).sel == 8) { _vw background channeltype -p } }
  if ($did == 41) { _vw background type -x | if ($did(background,$did,1).sel == 8) { _vw background channeltype -x } }  
  if ($did == 103) { .timer -m 1 5 bmp.path }
  if ($did == 23) { setnfs }
  if ($did == 22) { .splay $_vr(nickflash,sound) }
  if ($did == 53) { if ($_vr(nickflash,soundswitch) != on) { _vw nickflash soundswitch on | did -e background 22,23 }
    else {  _vw nickflash soundswitch off | did -b background 22,23 }
  }
}

on *:dialog:background:init:*:{
  did -z background 52 
  back.l 
  .timer -m 1 1 nl.back 
  if ($_vr(nickflash,switch) == on) { did -c background 24 | did -e background 20,21,53,22,23 }
  if ($_vr(nickflash,soundswitch) == on) { did -c background 53 | did -e background 22,23  }
  else did -b background 22,23
  nfcolor 20 
  nfcolor 21
  if ($_vr(nickflash,color) != $null) did -c background 20 $calc($_vr(nickflash,color) +1)
  if ($_vr(nickflash,back) != $null) did -c background 21 $calc($_vr(nickflash,back) +1)
  if ($_vr(nickflash,switch) == on) did -c background 24
  _vrem background window | _vrem background type | _vrem background default 
  if ($_vr(background,bmp.path) == $null) { _vw background bmp.path " $+ $mircdir $+ " }
  did -a background 32 select window | did -a background 32 main | did -a background 32 status | did -a background 32 finger | did -a background 32 toolbar | did -a background 32 toolbar buttons | did -a background 32 switchbar  
  did -c background 32 1 
  did -o background 101 1 $_vr(background,bmp.path)
  did - $+ $iif($_vr(nicklist,switch),c,u) background 2 
  nfcolor 7 | nfcolor 8 | nfcolor 9 | nfcolor 10 | nfcolor 11 | nfcolor 12
  did -c background 7 $calc($_vr(nicklist,ops) + 1)
  did -c background 8 $calc($_vr(nicklist,voice) + 1)
  did -c background 12 $calc($_vr(nicklist,hops) + 1)
  did -c background 9 $calc($_vr(nicklist,reg) + 1)
  did -c background 10 $calc($_vr(nicklist,me) + 1)
  if ($_vr(nicklist,s.hops) == 1) { did -c background 30 }
  if ($_vr(nicklist,s.ops) == 1) { did -c background 3 }
  if ($_vr(nicklist,s.voice) == 1) { did -c background 4 }
  if ($_vr(nicklist,s.reg) == 1) { did -c background 5 }
  if ($_vr(nicklist,s.me) == 1) { did -c background 6 }
}
alias -l bmp.path { _vw background bmp.path $$sdir="Select a directory" $_vr(background,bmp.path) | back.l }
alias -l back.del { set -q %del $iif($$?!="delete this graphic?" == $true,yes,no) | backdel }
alias -l backdel {
  if (%del == yes) { remove %backdel  | unset %del | .timer -m 1 1 back.l } 
  else { unset %del }
}
alias -l nl.back {
  if ($_vr(background,nicklist) == $null) { _vw background nicklist black }
  if ($colour(listbox) == $null) { _vw background nicklist black | did -c background 11 2 }  
  elseif ($colour(listbox) == 0) { did -c background 11 1 }
  elseif ($colour(listbox) == 1) { did -c background 11 2 }
  elseif ($colour(listbox) == 2) { did -c background 11 3 }
  elseif ($colour(listbox) == 3) { did -c background 11 4 }
  elseif ($colour(listbox) == 4) { did -c background 11 5 }
  elseif ($colour(listbox) == 5) { did -c background 11 6 }
  elseif ($colour(listbox) == 6) { did -c background 11 7 }
  elseif ($colour(listbox) == 7) { did -c background 11 8 }
  elseif ($colour(listbox) == 8) { did -c background 11 9 }
  elseif ($colour(listbox) == 9) { did -c background 11 10 }
  elseif ($colour(listbox) == 10) { did -c background 11 11 }
  elseif ($colour(listbox) == 11) { did -c background 11 12 }
  elseif ($colour(listbox) == 12) { did -c background 11 13 }
  elseif ($colour(listbox) == 13) { did -c background 11 14 }
  elseif ($colour(listbox) == 14) { did -c background 11 15 }
  elseif ($colour(listbox) == 15) { did -c background 11 16 }
}
alias -l chan.l {
  var %channum = 0
  :findchan
  inc %channum 1
  var %chan = $chan(%channum)
  if (%chan == $null) { goto end }
  if ($dialog(background) != $null) { did -i background 43 1 %chan }
  goto findchan
  :end
}
alias -l back.l {
  if ($dialog(background) != $null) { did -r background 16,52 | did -b background 15,16,17,34,35,36,37,38,39 }
  var %filenum = 0
  :findfile
  inc %filenum 1
  if ($_vr(background,bmp.path) != $null) { var %findfile = $findfile($_vr(background,bmp.path),*.bmp,%filenum) }
  if (%findfile == $null) goto end  
  if ($dialog(background) != $null) { did -i background 52 1 %findfile }
  goto findfile
  :end
  if ($dialog(background) != $null) { did -z background 52 }
  checkb.jpg
}
alias -l checkb.jpg {
  var %filenum = 0
  :findfile
  inc %filenum 1
  if ($_vr(background,bmp.path) != $null) { var %findfile = $findfile($_vr(background,bmp.path),*.jpg,%filenum) }
  if (%findfile == $null) goto end  
  if ($dialog(background) != $null) { did -i background 52 1 %findfile }
  goto findfile
  :end
  if ($dialog(background) != $null) { did -z background 52 }
}
menu menubar,status,nicklist {
  $iif($acid == $true,• utilities)
  .background + nicklist:backg
  $iif($acid != $true,background):backg
}
menu channel {
  $iif($acid == $true,• utilities)
  .background + nicklist
  ..console:backg
  ..channel
  ...select: backpic2 | background -a $+ %pictype %backpic | unset %pictype | unset %backpic
  ...none:background -x #
  $iif($acid != $true,background)
  ..console:backg
  ..channel
  ...select: backpic2 | background -a $+ %pictype %backpic | unset %pictype | unset %backpic
  ...none:background -x #
}
alias -l backpic2 {
  set %backpic $$dir="select background" $mircdirgraphics\default\*.* 
  set %pictype $$?="Type: center, fill, normal, stretch, tile, photo"
  if (%pictype == center) { set %pictype -c }
  if (%pictype == fill) { set %pictype -f }
  if (%pictype == normal) { set %pictype -n }
  if (%pictype == stretch) { set %pictype -s }
  if (%pictype == tile) { set %pictype -t }
  if (%pictype == photo) { set %pictype -p }
  if (%pictype == p) { set %pictype -p }
  if (%pictype == c) { set %pictype -c }
  if (%pictype == f) { set %pictype -f }
  if (%pictype == n) { set %pictype -n }
  if (%pictype == s) { set %pictype -s }
  if (%pictype == t) { set %pictype -t }
}
alias cl.apply {
  _vw nicklist switch $did(background,2).state
  var %xt = 3
  :start
  if (%xt < 6) { inc %xt | goto start }
  var %xt = 7
  :loop
  if (%xt < 10) { inc %xt | goto loop }
  if ($_vr(nicklist,switch) == 0) { colour listbox 0 }
  else colour listbox $calc($did(background,11).sel - 1)
  clchans
}

on *:join:#:{ 
  if ($_vr(nicklist,switch) == $null) { _vw nicklist switch 1 }
  if ($_vr(nicklist,s.ops) == $null) { _vw nicklist s.ops 1 }
  if ($_vr(nicklist,s.reg) == $null) { _vw nicklist s.reg 1 }
  if ($_vr(nicklist,s.voice) == $null) { _vw nicklist s.voice 1 }
  if ($_vr(nicklist,s.me) == $null) {  _vw nicklist s.me 1 }
  if ($_vr(nicklist,ops) == $null) { _vw nicklist ops 12 }
  if ($_vr(nicklist,voice) == $null) { _vw nicklist voice 8 }
  if ($_vr(nicklist,s.hops) == $null) { _vw nicklist s.hops 1 }
  if ($_vr(nicklist,reg) == $null) { _vw nicklist reg 3 }
  if ($_vr(nicklist,hops) == $null) { _vw nicklist hops 10 }
  if ($_vr(nicklist,me) == $null) { _vw nicklist me 4 }
  cl.nick $chan $nick
  if ($nick == $me) && ($_vr(background,channel) == on) { 
    if ($exists($_vr(background,channelback)) == $true) { .background - $+ $_vr(background,channeltype) $chan $_vr(background,channelback)" }
    elseif ($exists($_vr(background,channelback)) == $false) _vrem background channelback
  }
}
on *:part:#:{ 
  if ($nick == $me) { background -x $chan }
}
on *:help:#:cl.nick $chan $hnick
on *:dehelp:#:cl.nick $chan $hnick
on *:deop:#:cl.nick $chan $opnick
on *:devoice:#:cl.nick $chan $vnick
on *:op:#:cl.nick $chan $opnick
on *:serverdeop:#:cl.nick $chan $opnick
on *:serverop:#:cl.nick $chan $opnick
on *:voice:#:cl.nick $chan $vnick
raw 366:*:if ($me ison $2) { cl.loop $2 }
alias -l cl.loop {
  var %t = $nick($1,0)
  var %t2 = 1
  while (%t2 <= %t) { cl.nick $1 $nick($1,%t2) | inc %t2 1 }
}
alias -l clchans {
  if ($_vr(nicklist,switch) == 1) {
    var %c = $chan(0)
    var %c1 = 1
    while (%c1 <= %c) { cl.loop $chan(%c1) | inc %c1 1 }
  }
}
alias -l cl.nick {
  if ($2) {
    if ($_vr(nicklist,switch) == 1) {
      if ($2 == $me) && ($_vr(nicklist,s.me) == 1) { cline $_vr(nicklist,me) $1 $nick($1,$2) }
      elseif ($2 ishop $1) && ($_vr(nicklist,s.hops) == 1) { cline $_vr(nicklist,hops) $1 $nick($1,$2) }
      elseif ($2 isop $1) && ($_vr(nicklist,s.ops) == 1) { cline $_vr(nicklist,ops) $1 $nick($1,$2) }
      elseif ($2 isvoice $1) && ($_vr(nicklist,s.voice) == 1) { cline $_vr(nicklist,voice) $1 $nick($1,$2) }
      elseif ($2 isreg $1) && ($_vr(nicklist,s.reg)) { cline $_vr(nicklist,reg) $1 $nick($1,$2) }
      else { cline $colour(nick) $1 $nick($1,$2) }
    }
  }
}

alias -l vcl.nick {
  var %a = $nick($active,0)  
  var %a1 = 1
  while (%a1 <= %a) { 
    if ($nick($active,%a1) isop $active) { cline 3 $1 %a1 } 
    elseif ($nick($active,%a1) isvoice $active) { cline 8 $1 %a1 } 
    elseif ($nick($active,%a1) isreg $active) { cline 7 $1 %a1 } 
    elseif ($nick($active,%a1) ishop $active) { cline 12 $1 %a1 } 
    cline 4 $1 $nick($active,$me)  
    inc %a1 1 
  }
}
on *:TEXT:*:#: {
  if ($_vr(nickflash,switch) == $null) { _vw nickflash switch on } 
  if ($_vr(nickflash,switch) == on) { 
    if ($_vr(nickflash,soundswitch) == $null) && ($nexgen == $true) { _vw nickflash soundswitch on } 
    if ($_vr(nickflash,color) == $null) { _vw nickflash color 9 } 
    if ($_vr(nickflash,back) == $null) { _vw nickflash back 1 } 
    if ($_vr(nickflash,sound) == $null) && ($nexgen == $true) { _vw nickflash sound $shortfn($findfile($mircdirnexsnd\default\,paging.wav,1)) }
    if ($exists($_vr(nickflash,sound)) == $false) && ($nexgen == $true) { _vw nickflash sound $shortfn($findfile($mircdirnexsnd\default\,paging.wav,1)) | halt }
    if ($me isin $1-) {
      if (! isin $1) { goto end }
      if (%upflood9 => 10) { 
        if ($me ison $chan) { .ignore -cpku60 $nick }
        halt
      } 
      inc %upflood9 1
      .timer 1 15 unset %upflood9     
      goto end2       
      :end2      
      .timer 1 30 flash.off
      %flash.nick = $nick
      %flash.chan = $comchan(%flash.nick,1)
      .timer91 0 1 .cline $_vr(nickflash,back) %flash.chan $nick(%flash.chan,%flash.nick)
      .timer92 0 2 .cline $_vr(nickflash,color) %flash.chan $nick(%flash.chan,%flash.nick) 
      if ($_vr(nickflash,soundswitch) == on) .splay $_vr(nickflash,sound)
      unset flash.*
    }
    :end
  }
}
on *:ACTION:*:#: {
  if ($_vr(nickflash,switch) == $null) { _vw nickflash switch on } 
  if ($_vr(nickflash,switch) == on) { 
    if ($_vr(nickflash,color) == $null) { _vw nickflash color 9 } 
    if ($_vr(nickflash,back) == $null) { _vw nickflash back 1 } 
    if ($_vr(nickflash,sound) == $null) { _vw nickflash sound $findfile($mircdir,paging.wav,1) }
    if ($me isin $1-) {
      if (! isin $1) { goto end }
      if (%upflood9 => 10) { 
        if ($me ison $chan) { .ignore -cpku60 $nick }
        halt
      } 
      inc %upflood9 1
      .timer 1 15 unset %upflood9     
      goto end2       
      :end2      
      .timer 1 30 flash.off
      %flash.nick = $nick
      %flash.chan = $comchan(%flash.nick,1)
      .timer91 0 1 .cline $_vr(nickflash,back) %flash.chan $nick(%flash.chan,%flash.nick)
      .timer92 0 2 .cline $_vr(nickflash,color) %flash.chan $nick(%flash.chan,%flash.nick) 
      if ($_vr(nickflash,soundswitch) == on) .splay $_vr(nickflash,sound)
      unset flash.*
    }
    :end
  }
}
alias flash.off { 
  .timer91 off
  .timer92 off
  clchans
}
on *:INPUT:*: {
  .timer91 off
  .timer92 off
  ;clchans
}
alias -l setnfs _vw nickflash sound $$dir="select a nick flash sound alert:" $mircdir\*.wav
alias -l nfcolor {
  did -r background $1
  did -a background $1 white
  did -a background $1 black
  did -a background $1 blue
  did -a background $1 green
  did -a background $1 lightred
  did -a background $1 brown
  did -a background $1 purple
  did -a background $1 orange
  did -a background $1 yellow
  did -a background $1 lightgreen
  did -a background $1 cyan
  did -a background $1 lightcyan
  did -a background $1 lightblue
  did -a background $1 pink
  did -a background $1 grey
  did -a background $1 lightgrey
}
