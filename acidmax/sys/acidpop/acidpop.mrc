; main aliases
alias ppop {
  if ($1 == -q) {
    tokenize 32 [ [ $var(%ppop.queue.*.*:*,1) ] ]
    var %ct = $gettok($var(%ppop.queue.*.*:*,1),4,46)
    unset $var(%ppop.queue.*.*:*,1)
  }
  else { var %ct = $asctime(H:nn:ss) }
  tokenize 1 $strip($1-)
  var %h = $wrap($2,Tahoma,11,$calc(%ppop.width -14),0),%w = $calc(%h *14+55),%t = $width($1,Tahoma,11,1),%s = $1,%u = $2,%x,%y,%gh
  if ($1 != -q) && ($window(@ppop)) {
    set $+(%,ppop.queue.,$ticks,$rand(10000,99999),.,$asctime(H:nn:ss)) $+(%s,,%u)
    drawtext -rbp @ppop %ppop.color.bg %ppop.color.border "Small Fonts" 8 1 0 mIRC $version notification $iif($var(%ppop.queue.*.*,0),$nbr($v1 in queue)) 
  }
  else {
    if (t? iswm %ppop.pos) { %y = 0 }
    else { %y = $calc($window(-1).h - %w) }
    if (?l iswm %ppop.pos) { %x = 0 }
    else { %x = $calc($window(-1).w - %ppop.width) }
    if (%ppop.offset) {
      %x = $calc(%x + %ppop.xoffset)
      %y = $calc(%y + %ppop.yoffset)
    }
    if (!$window(@ppop)) { %gh = 1 }
    window -hnBdfiopk0 +dL @ppop %x %y %ppop.width %w
    if (%ppop.fade) { if (%gh) || ($timer(ppop.fade)) { ppop.fade in } }
    if (%ppop.transp.en) { if (!%ppop.fadecur.in) && (!%ppop.fadecur.out) { setlayer %ppop.transp @ppop } }
    elseif (!%ppop.fade) || ((!%ppop.fadecur.in) && (!%ppop.fadecur.out)) { setlayer 255 @ppop }
    drawrect -nrf @ppop %ppop.color.bg 1 0 0 %ppop.width %w
    drawrect -nrf @ppop %ppop.color.border 1 0 0 %ppop.width 10
    drawtext -nr @ppop %ppop.color.bg "Small Fonts" 8 $calc(%ppop.width - $width(%ct,Small Fonts,8) -2) 0 %ct
    drawtext -nrbp @ppop %ppop.color.bg %ppop.color.border "Small Fonts" 8 1 0 mIRC $version notification $iif($var(%ppop.queue.*.*,0),$nbr($v1 in queue)) 
    drawrect -nr @ppop %ppop.color.border 1 0 0 %ppop.width %w
    drawpic -cntros @ppop 16711935 6 16 18 18 4 $+(",$mircexe,")
    drawtext -nro @ppop %ppop.color.text Tahoma 11 29 18 $iif(%t > $calc(%ppop.width -40),$mid($wrap( $+ %s,Tahoma,11,$calc(%ppop.width -40),0,1),2) $+ ...,%s)
    drawline -nr @ppop %ppop.color.border 1 0 40 30 40
    drawrect -nrf @ppop %ppop.color.border 1 30 38 5 5
    while (%h) {
      drawtext -nr @ppop %ppop.color.text Tahoma 11 9 $calc(%h *14+33) $wrap(%u,Tahoma,11,$calc(%ppop.width -14),%h)
      dec %h
    }
    drawdot @ppop
    window -o @ppop
    if (%ppop.delay) {
      if (%ppop.fade) { .timerppop.close -io 1 %ppop.delay ppop.fade out }
      else { .timerppop.close -io 1 %ppop.delay ppop.doclose }
    }
    if (%ppop.beep) { beep }
  }
}
alias -l ppop.chkhl { if ($highlight) && ($highlight($1-)) && ($1- !isnum) { return $true } }
alias -l ppop.trig { if (%ppop.enabled) && ((!%ppop.nactive) || (!$appactive)) && ((!%ppop.naw) || (!$away)) && ($1 isin %ppop.events) { return $true } }
alias ppop.fade {
  var %b = $iif(%ppop.transp.en,%ppop.transp,255)
  if ($1 == in) {
    if (!%ppop.fadecur.in) && (!%ppop.fadecur.out) { setlayer 0 @ppop }
    if (!%ppop.fadecur.in) {
      set %ppop.fadecur.in $iif(%ppop.fadecur.out,$calc(%ppop.fadecur.out +((%b - %ppop.fadecur.out) % 20)),$iif(%ppop.transp.en,$calc(%ppop.transp % 20),15))
      .timerppop.fade -imo 0 15 setlayer % $+ ppop.fadecur.in @ppop $chr(124) inc % $+ ppop.fadecur.in 20 $chr(124) if (%ppop.fadecur.in > %b $+ ) $chr(123) .timerppop.fade off $chr(124) unset % $+ ppop.fadecur.in $chr(125)
      unset %ppop.fadecur.out
    }
  }
  else {
    set %ppop.fadecur.out $iif(%ppop.transp.en && $calc(%ppop.transp -(%ppop.transp % 20)) > 0,$v1,240)
    .timerppop.fade -imo 0 15 setlayer % $+ ppop.fadecur.out @ppop $chr(124) dec % $+ ppop.fadecur.out 20 $chr(124) if (%ppop.fadecur.out < 0) $chr(123) ppop.doclose $chr(125)
  }
}
alias ppop.doclose {
  .timerppop.close off
  .timerppop.fade off
  unset %ppop.fadecur.*
  close -@ @ppop
  if ($var(%ppop.queue.*.*:*,0)) {
    if ($1 != -s) { ppop -q }
    else { unset %ppop.queue.* }
  }
}
; events
on *:connect:{ if ($ppop.trig(n)) { ppop Connected to server!You are now connected to $server $iif($network,$nbr($v1)) $+ ! } }
on *:disconnect:{ if ($ppop.trig(i)) { ppop Disconnected from server!You have been disconnected from $server $iif($network,$nbr($v1)) $+ ! } }
on *:filercvd:*:{ if ($ppop.trig(d)) { ppop DCC get completed!DCC get $+(",$get(-1).file,") from $get(-1) finished. Downloaded $bytes($get(-1).size,3).suf $iif($get(-1).resumed,after resuming from $bytes($v1,3).suf) in $duration($get(-1).secs) at an average of $bytes($get(-1).cps,3).suf $+ /s. } }
on *:filesent:*:{ if ($ppop.trig(d)) { ppop DCC send completed!DCC send of $+(",$send(-1).file,") to $send(-1) finished. Uploaded $bytes($send(-1).size,3).suf $iif($send(-1).resumed,after resuming from $bytes($v1,3).suf) in $duration($send(-1).secs) at an average of $bytes($send(-1).cps,3).suf $+ /s. } }
on *:getfail:*:{ if ($ppop.trig(d)) { ppop DCC get failed!DCC get $+(",$get(-1).file,") from $get(-1) failed! Downloaded $+($bytes($get(-1).rcvd,3),/,$bytes($get(-1).size,3).suf) ( $+ $get(-1).pc $+ %) $iif($get(-1).resumed,after resuming from $bytes($v1,3).suf) in $duration($get(-1).secs) at an average of $bytes($get(-1).cps,3).suf $+ /s. } }
on *:sendfail:*:{ if ($ppop.trig(d)) { ppop DCC send failed!DCC send $+(",$send(-1).file,") to $send(-1) failed! Uploaded $+($bytes($send(-1).sent,3),/,$bytes($send(-1).size,3).suf) ( $+ $send(-1).pc $+ %) $iif($send(-1).resumed,after resuming from $bytes($v1,3).suf) in $duration($send(-1).secs) at an average of $bytes($send(-1).cps,3).suf $+ /s. } }
ctcp !*:*:*:{
  if ($1 == dcc) {
    if ($ppop.trig(d)) {
      if ($2 == send) { ppop Incoming DCC send! $+ $nick wants to send you $+(",$3,") ( $+ $bytes($6,3).suf $+ )! }
      elseif ($2 == chat) { ppop Incoming DCC chat! $+ $nick wants to chat with you! }
    }
  }
  elseif ($ppop.trig(t)) { ppop Incoming $+(CTCP!?,$nick,$iif($chan,: $+ $v1),?) $1- }
}
on !*:ctcpreply:*:{ if ($balloon.trig(t)) { ppop Incoming CTCP $+(reply!!,$nick,$iif($chan,: $+ $chan),!) $1- } }
on *:text:*:*:{
  var %o = $strip($1-)
  if ($ppop.trig(a)) && (((u isin %ppop.events) && (%ppop.ctrig) && ($regex(%o,%ppop.ctrig))) || (($ppop.chkhl(%o)) && (h isin %ppop.events))) {
    if ($chan) { ppop $chan $+(message!<,$iif($nick !isreg $chan,$left($nick($chan,$nick).pnick,1)),$nick,>) $1- }
    else { ppop Query $+(message!<,$nick,>) $1- }
  }
}
on *:action:*:*:{
  var %o = $strip($1-)
  if ($ppop.trig(a)) && (((u isin %ppop.events) && (%ppop.ctrig) && ($regex(%o,%ppop.ctrig))) || (($ppop.chkhl(%o)) && (h isin %ppop.events))) {
    if ($chan) { ppop $chan $+(message!<,$iif($nick !isreg $chan,$left($nick($chan,$nick).pnick,1)),$nick,>) $1- }
    else { ppop Query $+(message!<,$nick,>) $1- }
  }
}
on !*:invite:*:{ if ($ppop.trig(v)) { ppop Invitation! $+ $nick invites you to join $chan } }
on !*:ban:*:{ if ($banmask iswm $address($me,5)) && ($ppop.trig(k)) { ppop You were banned! $+ $nick banned you in $chan $+ ! ( $+ $banmask $+ ) } }
on !*:kick:*:{ if ($knick == $me) && ($ppop.trig(k)) { ppop You've been kicked!You were kicked out of $chan by $nick $+ ! $iif($1- != $knick,Reason: $1-) } }
on !*:notice:*:*:{
  if ($ppop.trig(e)) {
    if ($chan) { ppop Incoming channel $+(notice!-,$nick,:,$chan,-) $1- }
    else { ppop Incoming $+(notice!-,$nick,-) $1- }
  }
}
on *:unotify:{ if ($ppop.trig(f)) { ppop UnNotify! $+ $nick has left IRC! } }
on *:notify:{ if ($ppop.trig(f)) { ppop Notify! $+ $nick is now on IRC! } }
on *:open:?:{ if ($ppop.trig(q)) { ppop Incoming $+(query!<,$nick,>) $1- } }
on *:load:{
  set %ppop.version 1.0
  set %ppop.enabled 0
  set %ppop.transp.en 1
  set %ppop.transp 229
  set %ppop.naw 0
  set %ppop.delay 8
  set %ppop.fade 1
  set %ppop.width 250
  set %ppop.color.bg 14679551
  set %ppop.color.text 0
  set %ppop.color.border 0
  set %ppop.nactive 0
  set %ppop.beep 0
  set %ppop.pos br
  set %ppop.events antdihvkefq
  echo -ati2c info * Acid addon by Bueal loaded. Type /Acid.setup to configure.
}
on *:unload:{ unset %ppop.* }
on *:exit:{ unset %ppop.queue.* %ppop.fadecur.* }
menu @ppop {
  uclick { ppop.doclose $iif($mouse.key & 4,-s) }
  rclick { showmirc $iif($appstate == minimized,-r,-s) }
  $ppop.doclose
}
; setup dialog
alias Acid.setup { dialog $iif($dialog(ppop.setup),-v,-m ppop.setup) Acid.setup }
dialog -l Acid.setup {
  title Acid popups %ppop.version by Bueal [Acid.setup]
  size -1 -1 174 133
  option dbu
  tab "General", 1, 2 -1 170 116
  box "General settings", 2, 6 14 162 97, tab 1
  check "&Enable Acid popups", 3, 12 22 65 9, tab 1
  text "Display time (0 for infinite):", 4, 22 33 69 8, tab 1
  edit %ppop.delay, 5, 93 31 38 11, tab 1 limit 3 center
  text "seconds", 6, 134 33 24 8, tab 1
  text "Width:", 7, 22 44 23 8, tab 1
  edit %ppop.width, 8, 93 42 38 11, tab 1 limit 4 center
  check "Enable &transparency:", 9, 12 54 61 9, tab 1
  edit "", 10, 93 53 38 11, tab 1 limit 3 center
  text "%", 11, 134 55 9 8, tab 1
  check "&Fade popups", 12, 12 63 43 9, tab 1
  check "Only show if &mIRC is not the active window", 13, 12 76 117 9, tab 1
  check "Only show if &you are not away", 14, 12 85 86 9, tab 1
  check "Beep &whenever a popup appears", 15, 12 98 92 9, tab 1
  text "pixels", 16, 134 44 18 8, tab 1
  tab "Position", 17
  text "Show popups at:", 18, 22 23 49 7, tab 17
  radio "&top left corner", 19, 40 32 47 9, tab 17 left
  radio "top &right corner", 20, 91 32 54 9, tab 17
  radio "bottom ri&ght corner", 21, 91 41 63 9, tab 17
  radio "&bottom left corner", 22, 31 41 56 9, tab 17 left
  check "A&dd a custom offset (negative values are possible):", 23, 12 53 143 9, tab 17
  text "X:", 24, 30 65 6 8, tab 17
  edit %ppop.xoffset, 25, 39 63 26 11, tab 17 limit 5 center
  text "Y:", 26, 30 76 6 8, tab 17
  edit %ppop.yoffset, 27, 39 74 26 11, tab 17 limit 5 center
  box "Position", 28, 6 14 162 76, tab 17
  tab "Colors", 29
  box "Colors", 30, 6 14 162 86, tab 29
  text "Background:", 31, 12 23 35 8, tab 29
  text "Border:", 33, 12 48 23 8, tab 29
  text "Text:", 35, 12 73 19 8, tab 29
  icon 37, 80 31 48 12, $mircexe, 0, tab 29
  icon 38, 80 56 48 12, $mircexe, 0, tab 29
  icon 39, 80 81 48 12, $mircexe, 0, tab 29
  edit $rgb(%ppop.color.bg), 32, 14 31 60 12, tab 29 center
  edit $rgb(%ppop.color.border), 34, 14 56 60 12, tab 29 center
  edit $rgb(%ppop.color.text), 36, 14 81 60 12, tab 29 center
  tab "Events", 40
  box "Show popups on...", 41, 6 14 162 97, tab 40
  check "Co&nnecting to a server", 42, 12 22 69 9, tab 40
  check "C&TCP requests/replies", 43, 12 31 67 9, tab 40
  check "&DCC sends/gets/chats", 44, 12 40 68 9, tab 40
  check "D&isconnecting from a server", 45, 12 49 81 9, tab 40
  check "&Highlights", 46, 12 58 36 9, tab 40
  check "In&vites", 47, 12 67 30 9, tab 40
  check "&Kicks/bans", 48, 12 76 38 9, tab 40
  check "Notic&es", 49, 100 22 30 9, tab 40
  check "Noti&fies", 50, 100 31 31 9, tab 40
  check "&Queries", 51, 100 40 31 9, tab 40
  check "C&ustom text triggers (space separated list):", 52, 12 85 118 9, tab 40
  edit $ppop.mkre(%ppop.ctrig).re, 53, 21 95 143 11, tab 40
  tab "About", 54
  box "About", 55, 6 14 162 88, tab 54
  text "Script name:", 56, 12 23 35 8, tab 54
  text "Acid popups", 57, 52 23 110 8, tab 54 right
  link "http://tnexgen.com", 58, 105 53 57 8, tab 54
  text ".", 59, 52 63 110 34, tab 54 right
  text "Description:", 60, 12 63 35 8, tab 54
  text "Homepage:", 61, 12 53 35 8, tab 54
  text "Author:", 62, 12 43 35 8, tab 54
  text "Version:", 63, 12 33 35 8, tab 54
  text %Acid  addon, 64, 52 33 110 8, tab 54 right
  text "Bueal", 65, 52 43 110 8, tab 54 right
  button "&Ok", 66, 48 119 40 12, ok
  button "&Preview", 67, 2 119 40 12
  button "&Cancel", 68, 90 119 40 12
  button "&Apply", 69, 132 119 40 12
}
on *:dialog:ppop.setup:*:*:{
  if ($devent == init) {
    if (%ppop.enabled) { did -c $dname 3 }
    else { did -b $dname 4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52,53 }
    if (%ppop.transp.en) { did -c $dname 9 }
    if (%ppop.transp !isnum 0-255) { set %ppop.transp 255 }
    did -ra $dname 10 $int($calc(100- %ppop.transp /2.55))
    if (%ppop.fade) { did -c $dname 12 }
    if (%ppop.nactive) { did -c $dname 13 }
    if (%ppop.naw) { did -c $dname 14 }
    if (%ppop.beep) { did -c $dname 15 }
    if (%ppop.offset) { did -c $dname 23 }
    else { did -b $dname 24,25,26,27 }
    if (%ppop.pos == tl) { did -c $dname 19 }
    elseif (%ppop.pos == tr) { did -c $dname 20 }
    elseif (%ppop.pos == br) { did -c $dname 21 }
    elseif (%ppop.pos == bl) { did -c $dname 22 }
    ppop.colprev.all
    if (n isin %ppop.events) { did -c $dname 42 }
    if (t isin %ppop.events) { did -c $dname 43 }
    if (d isin %ppop.events) { did -c $dname 44 }
    if (i isin %ppop.events) { did -c $dname 45 }
    if (h isin %ppop.events) { did -c $dname 46 }
    if (v isin %ppop.events) { did -c $dname 47 }
    if (k isin %ppop.events) { did -c $dname 48 }
    if (e isin %ppop.events) { did -c $dname 49 }
    if (f isin %ppop.events) { did -c $dname 50 }
    if (q isin %ppop.events) { did -c $dname 51 }
    if (u isin %ppop.events) { did -c $dname 52 }
    else { did -b $dname 53 }
  }
  elseif ($devent == sclick) {
    if ($did == 3) {
      if ($did($did).state) {
        did -e $dname 4,5,6,7,8,9,12,13,14,15,16,18,19,20,21,22,23,28,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52
        if ($did(9).state) { did -e $dname 10,11 }
        if ($did(23).state) { did -e $dname 24,25,26,27 }
        if ($did(52).state) { did -e $dname 53 }
      }
      else { did -b $dname 4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52,53 }
    }
    elseif ($did == 9) { did $iif($did($did).state,-e,-b) $dname 10,11 }
    elseif ($did == 23) { did $iif($did($did).state,-e,-b) $dname 24,25,26,27 }
    elseif ($did == 52) { did $iif($did($did).state,-e,-b) $dname 53 }
    elseif ($did == 58) { url -an http://tnexgen.com }
    elseif ($did == 66) || ($did == 69) { ppop.setup.apply }
    elseif ($did == 67) {
      ppop.doclose -s
      ppop Preview popupThis is just some preview text... blah blah, you know.
    }
    elseif ($did == 68) { if ($input(Discard all changes and cancel?,wydu,Discard changes?)) { dialog -x $dname } }
  }
  elseif ($devent == edit) {
    if ($did == 32) { ppop.colprev 37 $did($did) }
    elseif ($did == 34) { ppop.colprev 38 $did($did) }
    elseif ($did == 36) { ppop.colprev 39 $did($did) }
  }
}
alias -l ppop.setup.apply {
  if ($did(5) !isnum 0-) { did -ra $dname 5 8 }
  did -ra $dname 5 $int($did(5))
  set %ppop.delay $did(5)
  set %ppop.enabled $did(3).state
  if ($did(8) !isnum 50-9999) { did -ra $dname 8 $iif($did(8) isnum,$iif($did(8) < 50,50),250) }
  did -ra $dname 8 $int($did(8))
  set %ppop.width $did(8)
  set %ppop.transp.en $did(9).state
  if ($did(10) !isnum 0-100) { did -ra $dname 10 10 }
  did -ra $dname 10 $int($did(10))
  set %ppop.transp $calc((100- $did(10)) *2.55)
  if ($did(19).state) { set %ppop.pos tl }
  elseif ($did(20).state) { set %ppop.pos tr }
  elseif ($did(21).state) { set %ppop.pos br }
  elseif ($did(22).state) { set %ppop.pos bl }
  set %ppop.offset $did(23).state
  if ($did(25) !isnum) { did -ra $dname 25 0 }
  did -ra $dname 25 $int($did(25))
  set %ppop.xoffset $did(25)
  if ($did(27) !isnum) { did -ra $dname 27 0 }
  did -ra $dname 27 $int($did(27))
  set %ppop.yoffset $did(27)
  set %ppop.fade $did(12).state
  set %ppop.nactive $did(13).state
  set %ppop.naw $did(14).state
  set %ppop.beep $did(15).state
  var %e = a
  if ($did(42).state) { %e = %e $+ n }
  if ($did(43).state) { %e = %e $+ t }
  if ($did(44).state) { %e = %e $+ d }
  if ($did(45).state) { %e = %e $+ i }
  if ($did(46).state) { %e = %e $+ h }
  if ($did(47).state) { %e = %e $+ v }
  if ($did(48).state) { %e = %e $+ k }
  if ($did(49).state) { %e = %e $+ e }
  if ($did(50).state) { %e = %e $+ f }
  if ($did(51).state) { %e = %e $+ q }
  if ($did(52).state) { %e = %e $+ u }
  set %ppop.events %e
  if (!$regex($did(32),/^\d+\x2C\d+\x2C\d+$/)) || ($rgb( [ $did(32) ] ) == $null) {
    did -ra $dname 32 255,253,223
    ppop.colprev 37 255,253,223
  }
  if (!$regex($did(34),/^\d+\x2C\d+\x2C\d+$/)) || ($rgb( [ $did(34) ] ) == $null) {
    did -ra $dname 34 0,0,0
    ppop.colprev 38 0,0,0
  }
  if (!$regex($did(36),/^\d+\x2C\d+\x2C\d+$/)) || ($rgb( [ $did(36) ] ) == $null) {
    did -ra $dname 36 0,0,0
    ppop.colprev 39 0,0,0
  }
  set %ppop.color.bg $rgb( [ $did(32) ] )
  set %ppop.color.border $rgb( [ $did(34) ] )
  set %ppop.color.text $rgb( [ $did(36) ] )
  set %ppop.ctrig $ppop.mkre($did(53))
}
alias -l ppop.colprev.all {
  ppop.colprev 37 $rgb(%ppop.color.bg)
  ppop.colprev 38 $rgb(%ppop.color.border)
  ppop.colprev 39 $rgb(%ppop.color.text)
}
alias -l ppop.colprev {
  var %f = $+(",$scriptdir,ppop.colprev.bmp")
  window -hpf @ppop.colprev 0 0 400 100
  if (!$regex($2,/^\d+\x2C\d+\x2C\d+$/)) { did -h $dname $1 }
  else {
    if ($rgb( [ $2 ] ) != $null) {
      did -v $dname $1
      drawrect -nrf @ppop.colprev $v1 1 0 0 400 100
    }
    else { did -h $dname $1 }
  }
  drawsave @ppop.colprev %f
  did -g $dname $1 %f
  .remove %f
  close -@ @ppop.colprev
}
alias -l ppop.mkre {
  if ($1 != $null) {
    if ($prop == re) { return $replacex($mid($1,5,-5),\^,^,\.,.,\|,|,|,$chr(44),\$,$,\\,\,\?,?,\+,+,\[,[,\],],.*,*,.,?,\ $+ $chr(123),$chr(123),\ $+ $chr(125),$chr(125),\ $+ $chr(40),$chr(40),\ $+ $chr(41),$chr(41)) }
    else { return /\b( $+ $replacex($1,\,\\,$,\$,^,\^,|,\|,$chr(44),|,+,\+,.,\.,[,\[,],\],*,.*,?,.,$chr(123),\ $+ $chr(123),$chr(125),\ $+ $chr(125),$chr(40),\ $+ $chr(40),$chr(41),\ $+ $chr(41)) $+ )\b/i }
  }
}
;-––––––––––––––––––––––––––––––––––––––––-;
; End of file                              ;
;-––––––––––––––––––––––––––––––––––––––––-;
