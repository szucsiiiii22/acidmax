menu menubar,query,channel {
  • utilities
  .nick completor:nc.setup
}
;$nc.char = nick completor char
alias -l nc.char { return $_vr(nick-completor,char) }
on *:start: {
  ; if (%nick.com1.1 == $null) || (%nick.com1.2 == $null) { %nick.com1.1 = 12• | %nick.com1.2 = 12• }
  if ($_vr(nick-completor,char) == $null) { _vw nick-completor char $chr(92) | $ae $chr(149) acidmax has set your nick completor on and to default, your nick completor character is: "\" Please type: /nc.setup to change settings. Type: /nc-help to show you how to execute nick completor. }  
  if ($_vr(nick-completor,switch) == $null) { _vw nick-completor switch on }
  if ($_vr(nick-completor,side) == $null) { _vw nick-completor side left }
}
alias charside {
  if ($_vr(nick-completor,side) == right) { return $right($1,1) }
  else { return $left($1,1) }  
}
on *:input:*: {
  if ($_vr(nick-completor,switch) == $null) { _vw nick-completor switch on }
  if (@* iswm $active) return 
  if ($_vr(nick-completor,switch) == on) { 
    if ($charside($1) == $nc.char) {
      if ($query($active) == $active) {
        var %l = $len($remove($1,$nc.char)) 
        if ($mid($active,1,%l) == $remove($1,$nc.char)) { .privmsg $active %nick.com1.1 $+ $active $+ %nick.com1.2 $2- | echo $active $ntimestamp %meext.1 $+ $me $+ %meext.2 %nick.com1.1 $+ $active $+ %nick.com1.2 $2- | halt }
        else { .privmsg $active $1- | echo $active $ntimestamp %meext.1 $+ $me $+ %meext.2 $1- | halt }
      }
      elseif ($len($1) > 1 ) { var %chantotal = $nick($active,0) | var %search.nick = 0 | %nic.nick = $2- 
        if ($_vr(nick-completor,side) == left) { var %find.nick = $right($1,$calc($len($1) - 1)) } 
        elseif ($_vr(nick-completor,side) = right) { var %find.nick = $left($1,$calc($len($1) - 1)) }
        var %lengthnic = $len(%find.nick) | unset %nic.nickp | :start | inc %search.nick 1
        if (%find.nick == $mid($nick($active,%search.nick),1,%lengthnic) ) { %nic.nickp = %nic.nickp $+ $nick($active,%search.nick) $+ ,  } | if ( %search.nick >= %chantotal ) { goto next } | if ( %search.nick < %chantotal ) { goto start } | :next
        if ($count(%nic.nickp,$chr(44)) > 1 ) { nc | halt }    
        if (%nic.nickp == $null ) { $ae $er no matches were found for " $+ %find.nick $+ " | beep | unset %nic.* | halt }
        if ($_vr(color,menick_switch) == on) && ($_vr(color,color_switch) == on) { 
          .privmsg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | echo $active $ntimestamp %meext.1 $+ $modechar($me) $+ %meext.2 %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | halt 
        } 
      else msg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | halt }
    }
  }
}

alias nc-help {
  $ae NEXGEN'S DEFAULT NICK COMPLETOR:
  $ae Command: \<partial nick> <msg>
  $ae Example: \kn hello there!
  $ae Result: ::4KnightFal:: hello there!
  $ae Note: You can also choose differnt styles or design your own by typing: /nc.setup
}
alias -l nc { if ($dialog(nc) == $null) { dialog -m nc nc } }
alias -l nca {
  var %count.nick = $count(%nic.nickp,$chr(44))      
  var %aline.nick = 0 
  var %count.nick = $count(%nic.nickp,$chr(44)) 
  var  %aline.nick = 0 
  :wins 
  inc %aline.nick 1 
  did -i nc 4 1 $gettok(%nic.nickp,%aline.nick,44) 
  if ( %aline.nick >= %count.nick ) { goto end }
  if ( %aline.nick < %count.nick ) { goto wins } 
  :end
  unset %nic.nickp 
  halt 
}
dialog nc {
  title "multiple matches found"
  size -1 -1 200 108
  box "select a nick", 36, 2 3 117 100
  box "", 57, 125 18 70 70
  list 4, 10 22 100 68, sort size
  button "send", 1, 135 31 50 20, disable default ok
  button "cancel", 3, 135 59 50 20, default cancel
}
on *:dialog:nc:init:*:{
  nca
  did -m nc 6 
  if ($chan == $null) { did -b nc 1 | did -b nc 4 | did -r nc 2 | did -r nc 8 | did -o nc 6 1 Not on channel | did -b nc 1 }
}
on *:dialog:nc:sclick:*:{
  if ($did == 4) { did -e nc 1 }
  if ($did == 1) { 
    var %nic.nickp = $did(4,$did(4).sel)
    if ($_vr(color,color_switch) == on) && (%cr == on) { msg  $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick |  dialog -x nc | haltdef } 
    if ($_vr(color,color_switch) != on) {  msg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | dialog -x nc |  halt } 
    if ($_vr(color,color_switch) == on) { .privmsg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick |  echo $active $ntimestamp %meext.1 $+ $modechar($me) $+ %meext.2 %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | dialog -x nc | haltdef } 
  }
}
on *:dialog:nc:dclick:*: {
  if ($did == 4) { 
    if ($did(4,$did(4).sel) == $null) { did -o nc 6 1 You did not select a nick | $se 0,4 You did not select a nick  | halt } 
    else {
      set %nic.nickp $did(4,$did(4).sel)
      if ($_vr(color,color_switch) == on) && (%cr == on) { msg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | unset %nic.* | dialog -x nc | halt } 
      if ($_vr(color,color_switch) != on) {  msg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | unset %nic.*  | dialog -x nc | halt } 
      if ($_vr(color,color_switch) == on) { .privmsg $active %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick |  echo $active $ntimestamp %meext.1 $+ $modechar($me) $+ %meext.2 %nick.com1.1 $+ $remove(%nic.nickp,$chr(44)) $+ %nick.com1.2 %nic.nick | unset %nic.*  | dialog -x nc | halt } 
    }
  }
}
alias nc.setup { if ($dialog(nc.setup) == $null) { dialog -m nc.setup nc.setup } 
  else return
}
dialog nc.setup {
  title "nick completor config"
  size -1 -1 377 223
  option pixels
  edit "", 1, 25 54 68 20, autohs right
  edit "", 2, 155 54 68 20, autohs
  button "close", 3, 162 276 58 24, ok
  text "left", 4, 27 38 14 16
  text "right", 5, 203 38 20 16
  combo 6, 41 133 40 81, size drop
  button "apply", 7, 61 80 58 16, disable
  box "appearance", 8, 19 20 212 84
  check "enable", 10, 12 0 68 20
  button "view", 11, 135 80 58 16
  combo 12, 118 133 120 84, size drop
  text "preset styles", 13, 120 115 66 16
  text "nick", 14, 113 56 28 16
  edit "", 16, 256 50 100 20
  list 17, 256 74 100 68, sort size vsbar
  button "save", 19, 298 168 58 16, disable
  button "delete", 20, 298 188 58 16, disable
  text "name", 21, 260 34 26 16
  button "load", 22, 298 149 58 16, disable
  box "custom style", 23, 248 20 116 192
  radio "left", 15, 19 161 38 20
  radio "right", 18, 61 161 40 20
  box "command char", 24, 16 112 90 73
  edit "", 9, 13 192 225 21, read
  text "syntax", 25, 206 176 31 16
  check "nick styler", 26, 117 157 74 20
}
on *:dialog:nc.setup:init:*:{
  if ($_vr(nick-completor,side) == left) { did -c nc.setup 15 }
  else { did -c nc.setup 18 }  
  did -a nc.setup 6 $chr(92) | did -a nc.setup 6 + | did -a nc.setup 6 - | did -a nc.setup 6 : | did -a nc.setup 6 ~ | did -a nc.setup 6 ` | did -a nc.setup 6 @ | did -a nc.setup 6 % | did -a nc.setup 6 ^ | did -a nc.setup 6 & | did -a nc.setup 6 * | did -a nc.setup 6 ; | did -a nc.setup 6 ' 
  did -a nc.setup 12 select... | did -a nc.setup 12 . ..nick.. . | did -a nc.setup 12 ·nick· | did -a nc.setup 12 [nick] | did -a nc.setup 12 (nick) | did -a nc.setup 12 . ..:nick:.. . | did -a nc.setup 12 none  
  did -c nc.setup 12 1 
  if ($_vr(nick-completor,char) == $null) { _vw nick-completor char $chr(92) | did -c nc-setup 1 }  
  did -o nc.setup 1 1 %nick.com1.1 
  did -o nc.setup 2 1 %nick.com1.2 
  if ($_vr(color,nickstyler) == on) { did -c nc.setup 26 }
  if ($_vr(nick-completor,switch) == on) { did -c nc.setup 10 }
  if ($_vr(nick-completor,char) == $chr(92)) { did -c nc.setup 6 1 }
  elseif ($_vr(nick-completor,char) == $chr(43)) { did -c nc.setup 6 2 }
  elseif ($_vr(nick-completor,char) == $chr(45)) { did -c nc.setup 6 3 }
  elseif ($_vr(nick-completor,char) == $chr(58)) { did -c nc.setup 6 4 }
  elseif ($_vr(nick-completor,char) == $chr(126)) { did -c nc.setup 6 5 }
  elseif ($_vr(nick-completor,char) == $chr(96)) { did -c nc.setup 6 6 }
  elseif ($_vr(nick-completor,char) == $chr(64)) { did -c nc.setup 6 7 }
  elseif ($_vr(nick-completor,char) == $chr(37)) { did -c nc.setup 6 8 }
  elseif ($_vr(nick-completor,char) == $chr(94)) { did -c nc.setup 6 9 }
  elseif ($_vr(nick-completor,char) == $chr(38)) { did -c nc.setup 6 10 }
  elseif ($_vr(nick-completor,char) == $chr(42)) { did -c nc.setup 6 11 }
  elseif ($_vr(nick-completor,char) == $chr(59)) { did -c nc.setup 6 12 }
  elseif ($_vr(nick-completor,char) == $chr(39)) { did -c nc.setup 6 13 }
  list
  synt
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 26 $rgb(119,154,247) $rgb(255,255,255) 1 Nick Styler:This decorates peoples nicks in text, and not a nick completor. Users nick must be complete in order for this feature to take effect.
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 6 $rgb(119,154,247) $rgb(255,255,255) 1 Command character:Select a command character that will activate nick completor.
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 7 $rgb(119,154,247) $rgb(255,255,255) 1 Apply:Save current style.
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 15 $rgb(119,154,247) $rgb(255,255,255) 1 Left:Command character to activate nick completor will be placed to the left of the nick to complete.
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 18 $rgb(119,154,247) $rgb(255,255,255) 1 Right:Command character to activate nick completor will be placed to the right of the nick to complete.
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 16 $rgb(119,154,247) $rgb(255,255,255) 1 Style name:Name your current completor style to file, the name will be used as the file name. 
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 17 $rgb(119,154,247) $rgb(255,255,255) 1 Styles:Current nick completor styles available to load.
;  dll $adll tooltip_add $dialog(nc.setup).hwnd 11 $rgb(119,154,247) $rgb(255,255,255) 1 View style:View your current style what it would look like being used.
}
on *:dialog:nc.setup:edit:*:{
  if ($did == 1) || ($did == 2) { did -e nc.setup 7 }
  if ($did == 16) { 
    if ($did(16,$did(16).text) != $null) { did -e nc.setup 19 | did -b nc.setup 22,20 }
    else { did -b nc.setup 19 }
  }
}
on *:dialog:nc.setup:sclick:*:{
  if ($did == 6) { _vw nick-completor char $did(6,$did(6).sel) | synt }
  if ($did == 7) { %nick.com1.1 = $did(nc.setup,1).text | %nick.com1.2 = $did(nc.setup,2).text }
  if ($did == 10) {
    if ($_vr(nick-completor,switch) == on) { _vw nick-completor switch off }
    else { _vw nick-completor switch on | did -c nc.setup 10  }
  }
  if ($did == 26) {
    if ($_vr(color,nickstyler) != on) { _vw color nickstyler on }
    else { _vw color nickstyler off }
  }
  if ($did == 11) { nc.style }
  if ($did == 12) { 
    if ($did(nc.setup,$did,1).sel == 1) { select... | haltdef }
    elseif ($did(nc.setup,$did,1).sel == 2) { %nick.com1.1 = 4. .. | %nick.com1.2 = 4.. . | ty }
    elseif ($did(nc.setup,$did,1).sel == 3) { %nick.com1.1 = 12• | %nick.com1.2 = 12• | ty }
    elseif ($did(nc.setup,$did,1).sel == 4) { %nick.com1.1 = 4[ | %nick.com1.2 = 4] | ty }
    elseif ($did(nc.setup,$did,1).sel == 5) { %nick.com1.1 = 4( | %nick.com1.2 = 4) | ty }
    elseif ($did(nc.setup,$did,1).sel == 6) { %nick.com1.1 = 4. ..: | %nick.com1.2 = 4:.. . | ty }
    elseif ($did(nc.setup,$did,1).sel == 7) { %nick.com1.1 =  | %nick.com1.2 = : | ty }
  }
  if ($did == 15) || ($did == 18) {
    if ($_vr(nick-completor,side) == left) { _vw nick-completor side right | did -c nc.setup 18 }
    else { _vw nick-completor side left | did -c nc.setup 15 }
    synt 
  }
  if ($did == 17) { did -e nc.setup 22,20 | did -b nc.setup 19 | did -r nc.setup 16 | did -o nc.setup 16 1 $did(17,$did(17).sel) } 
  if ($did == 19) { mkdir data\nc\ | write data\nc\ $+ $did(16,$did(16).text) $did(1,$did(1).text) | write data\nc\ $+ $did(16,$did(16).text) $did(2,$did(2).text) | did -r nc.setup 16 | list }
  if ($did == 20) { .remove data\nc\ $+ $did(17,$did(17).sel) | did -b nc.setup 22,20 | list }
  if ($did == 22) { %nick.com1.1 = $read(data\nc\ $+ $did(17,$did(17).sel), 1) | %nick.com1.2 = $read(data\nc\ $+ $did(17,$did(17).sel), 2) | ty }
  sclick
}

alias -l synt {
  if ($_vr(nick-completor,side) == left) { did -o nc.setup 9 1 type: $_vr(nick-completor,char) $+ nick <message> }
  elseif ($_vr(nick-completor,side) == right) { did -o nc.setup 9 1 type: nick $+ $_vr(nick-completor,char) <message> }
}
alias -l list {
  did -r nc.setup 17 
  var %f = 0
  :loop 
  inc %f 
  var %fs =  $nopath($findfile(data/nc,*.*, %f ,1))
  if (%fs != $null) { did -a nc.setup 17  %fs | goto loop }
  else return
}
alias -l ty {
  did -o nc.setup 1 1 %nick.com1.1 | did -o nc.setup 2 1 %nick.com1.2
}
alias -l nc.style {
  if ($window(@nick completor style) != $null) || (%nick.com1.1 != $null) || (%nick.com1.2 != $null) { window -c @nick completor style } 
  .timernc 0 1 win.check34
  window -rak0 @nick completor style 500 475 450 60 
  aline @nick completor style %nick.com1.1 $+ $me $+ %nick.com1.2 This is a sample of your nick completor
}
alias -l win.check34 { if ($dialog(nc.setup) == $null) || ($window(@nick completor style) == $null) { window -c @nick completor style | .timernc off } }
