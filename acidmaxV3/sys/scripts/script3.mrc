on *:load: {
  if ($version < 6.03) { 
    echo -a This addon requires at least mIRC 6.03 to use. Unloading...
    .unload -rs ctbar.mrc 
  }
  else {
    echo -a Custom Toolbar Addon loaded. Type /tbarsetup to open toolbar setup.
  }
}

on *:start: {
  if ($rconf(Toolbar) = on) { 
    dialog -m tb tb
    $iif($rconf(Rambar) = on,.timerram 0 $iif($rconf(ramcheck),$ifmatch,10) did -ra tb 6 $round($remove($gettok($dll($moo,meminfo,_),3,32),$chr(40),$chr(41),$chr(37)),0))
  }
}

on *:connect: {
  update.tb
  .timerlag 0 $iif($rconf(Lagcheck),$ifmatch,10) tlag
}

on *:disconnect: {
  update.tb
  .timerlag off
}

on *:active:*: {
  update.tb
}

on *:close:*: {
  update.tb
}

on ^*:PONG:{ 
  set %lag $calc(($ticks - %ticks) / 1000) 
  if ($dialog(tb) && $rconf(Lagbar) = on) {
    did -ra tb 3 $round(%lag,0) 0 20
  }
  unset %ticks 
  haltdef 
}

;Aliases

alias mdx { dll $shortfn(sys\dlls\mdx.dll) $$1- }
alias rebar { dll $shortfn(sys\dlls\rebar.dll) $$1- }
alias popups { dll $shortfn(sys\dlls\popups.dll) $$1- }
alias bars { return $shortfn(sys\dlls\bars.mdx) }
alias moo { return $shortfn(sys\dlls\moo.dll) }
alias ctl { return $shortfn(sys\dlls\ctl_gen.mdx) } 
alias views { return $shortfn(sys\dlls\views.mdx) }
alias conf { writeini $shortfn($mircdirToolbar\Toolbar.ini) Settings $1 $2- }
alias rconf { return $readini($shortfn($mircdirToolbar\Toolbar.ini),Settings,$1) }
alias tbarsetup { $iif(!$dialog(tbarsetup),dialog -m tbarsetup tbarsetup,dialog -v tbarsetup) }

alias pop1 { 
  tokenize 32 $dll($shortfn(sys\dlls\popups.dll),Popup,$1-) 
  if ($isid) return $1- 
  $iif($4- != did not select a menu item,$4-)
}

alias tlag { 
  if ($server) {
    set %ticks $ticks
    .raw ping $scid($activecid).server
  }
}

alias tbar.pop {
  popups New server 16 16
  popups SetMetrics server iconpad 10 0 contentpad 0 0 spacing 1 0
  popups AddItem server end + Servers
  popups AddItem server end +
  var %l = 1 
  while (%l <= $lines($shortfn($mircdirToolbar\Servers.dat))) { 
    var %port = $gettok($read($shortfn($mircdirToolbar\Servers.dat),%l),2,42)
    popups AddItem server end + $gettok($read($shortfn($mircdirToolbar\Servers.dat),%l),1,42) $cr server $gettok($read($shortfn($mircdirToolbar\Servers.dat),%l),1,42) %port
    inc %l 
  } 
  popups AddItem server end +
  popups AddItem server end +> New connection $cr newcon
  popups New newcon 16 16
  popups SetMetrics newcon iconpad 10 0 contentpad 0 0 spacing 1 0
  var %l = 1 
  while (%l <= $lines($shortfn($mircdirToolbar\Servers.dat))) { 
    var %port = $gettok($read($shortfn($mircdirToolbar\Servers.dat),%l),2,42)
    popups AddItem newcon end + $gettok($read($shortfn($mircdirToolbar\Servers.dat),%l),1,42) $cr server -m $gettok($read($shortfn($mircdirToolbar\Servers.dat),%l),1,42) %port 
    inc %l 
  }
  pop1 server $mouse.dx $mouse.dy
}

alias update.tb {
  if (!$dialog(tb)) { halt }
  else {
    scid $activecid
    if ( $scid($activecid).status = connecting || $scid($activecid).status = connected ) { 
      did -o tb 1 2 +v 2 $chr(9) $+ Disconnect 
      mdx MoveControl tb 1 $iif($rconf(Lagbar) = on,100,$iif($rconf(Rambar) = on,100,4)) 4 3500 2 
      $iif($rconf(Lagbar) = on,mdx MoveControl tb 5 4 3 17 12)
      $iif($rconf(Rambar) = on,mdx MoveControl tb 4 4 16 17 12)
      $iif($rconf(Lagbar) = on,mdx MoveControl tb 3 20 7 60 7)
      $iif($rconf(Rambar) = on,mdx MoveControl tb 6 20 20 60 7)   
    }
    else {
      did -o tb 1 2 +v 1 $chr(9) $+ Connect 
      mdx MoveControl tb 1 $iif($rconf(Lagbar) = on,100,$iif($rconf(Rambar) = on,100,4)) 4 3500 2 
      $iif($rconf(Lagbar) = on,mdx MoveControl tb 5 4 3 17 12)
      $iif($rconf(Rambar) = on,mdx MoveControl tb 4 4 16 17 12)
      $iif($rconf(Lagbar) = on,mdx MoveControl tb 3 20 7 60 7)
      $iif($rconf(Rambar) = on,mdx MoveControl tb 6 20 20 60 7)
    }
  }
}

alias -l load_tb.data {
  var %tb = 1
  var %seps = 0
  while (%tb <= $lines($shortfn($mircdirToolbar\Data.dat))) {
    if ($read($shortfn($mircdirToolbar\Data.dat),%tb) != -) {
      did -i $dname 2 1 seticon normal $gettok($read($shortfn($mircdirToolbar\Data.dat),%tb),1,42)
      inc %tb
    } 
    else { inc %tb | inc %seps }
  }
  var %tb = 1
  var %seps = 0
  while (%tb <= $lines($shortfn($mircdirToolbar\Data.dat))) {
    if ($read($shortfn($mircdirToolbar\Data.dat),%tb) != - ) {
      did -i $dname 2 1 seticon normal $gettok($read($_dat(tb),%tb),1,42)
      did -a $dname 2 +br $calc(%tb - %seps) $calc(%tb - %seps)  $chr(9) $gettok($read($shortfn($mircdirToolbar\Data.dat),%tb),2,42) $chr(9) $gettok($read($shortfn($mircdirToolbar\Data.dat),%tb),3,42) 
      inc %tb
    }
    else {
      did -a $dname 2 - $chr(9) $+ Separator $chr(9) $+ -
      inc %tb
      inc %seps
    }
  }
}

alias -l load_servers {
  var %i = 1 
  while (%i <= $lines($shortfn($mircdirToolbar\Servers.dat))) {
    did -a $dname 26 $gettok($read($shortfn($mircdirToolbar\Servers.dat),%i),1,42) $chr(9) $gettok($read($shortfn($mircdirToolbar\Servers.dat),%i),2,42)
    inc %i
  }
}

;Dialog tables

dialog tb {
  title "bleh"
  size 0 0 514 3
  option dbu
  list 1, 2 2 2978 20, size
  box "", 2, -4 -3 3000 19
  text "", 6, 191 43 41 4
  text "L:", 5, 173 43 10 4, disable
  text "", 3, 191 48 41 4
  text "R:", 4, 173 48 10 4, disable
}

on *:dialog:tb:init:0: {
  if ($rconf(Lagbar) = off) { did -h $dname 5,3 }
  if ($rconf(Rambar) = off) { did -h $dname 4,6 }
  set %seps 0
  mdx MarkDialog $dname
  mdx SetControlMDX $dname 1 Toolbar flat arrows nodivider wrap > $bars
  mdx SetControlMDX $dname 3,6 Progressbar smooth > $ctl
  mdx SetFont $dname 4,5 -10 700 Tahoma
  mdx SetDialog $dname style 
  mdx SetBorderStyle $dname 1
  if ($rconf(XPbkg) = on) {
    mdx SetDialog $dname bgcolor $rgb(222,220,213) 
    mdx SetColor $dname 1,4,5 background $rgb(222,220,213) 
    mdx SetColor $dname 4,5 textbg $rgb(222,220,213)
  }
  if ($rconf(XPscheme) = on) {
    did -i $dname 1 1 setscheme $rgb(163,163,163) $rgb(163,163,163)
  }
  did -i $dname 1 1 bmpsize 16 16
  did -i $dname 1 1 setimage icon small $shortfn($mircdirToolbar\Connect.ico)
  did -i $dname 1 1 setimage icon small $shortfn($mircdirToolbar\Disconnect.ico)
  var %t = 1
  while (%t <= $lines($shortfn($mircdirToolbar\Data.dat))) {
    if ($read($shortfn($mircdirToolbar\Data.dat),%t) = -) { inc %t }
    var %icon = $gettok($read($shortfn($mircdirToolbar\Data.dat),%t),1,42)
    did -i $dname 1 1 setimage icon small %icon
    inc %t
  }
  did -a $dname 1 +v 1 $chr(9) $+ Connect
  did -a $dname 1 -
  var %r = 1
  while (%r <= $lines($shortfn($mircdirToolbar\Data.dat))) {
    if ($read($shortfn($mircdirToolbar\Data.dat),%r) != -) {
      did -a $dname 1 $gettok($read($shortfn($mircdirToolbar\Data.dat),%r),4,42) $calc(%r + 2 - %seps) $chr(9) $+ $gettok($read($shortfn($mircdirToolbar\Data.dat),%r),2,42)
      inc %r
    } 
    else { did -a $dname 1 - | inc %r | inc %seps }
  }
  update.tb
  rebar HideToolbar .
  rebar Dock $dialog(tb).hwnd > top
}

on *:dialog:tb:sclick:1: {
  if ($did($dname,1).sel = 2) {
    if ($scid($activecid).status = connecting || $scid($activecid).status = connected ) { scid $activecid disconnect }
    else {
      scid $activecid server
    }
    update.tb
    did -f $dname 2
    scid $activecid window -a "status window"
  }
  else {
    var %sel $calc($did($dname,1).sel - 3)
    .timercmd -m 1 1 $gettok($read($shortfn($mircdirToolbar\Data.dat),%sel),3,42)
  }
}

on *:dialog:tb:dclick:1: {
  if ($did($dname,1).sel = 2) {
    tbar.pop
  }
  else {
    var %sel $calc($did($dname,1).sel - 3)
    .timercmd -m 1 1 $gettok($read($shortfn($mircdirToolbar\Data.dat),%sel),5,42)
  }
}

dialog icon {
  title "Select Icon..."
  size -1 -1 168 110
  option dbu
  icon $icl, 12
  list 1, 1 3 166 94, size
  edit "", 2, 0 99 151 10, read autohs
  button "!", 3, 153 99 14 10
}

on *:dialog:icon:init:0: {
  mdx MarkDialog $dname
  mdx SetControlMDX $dname 1 Listview large icon single showsel > $views
  mdx SetDialog $dname icon
  mdx SetFont $dname 1,2,3 -11 400 Tahoma
  var %p = %icl_,%i = 0,%x = $dll($shortfn(sys\dlls\ktools.dll),CountIcons,%icl_)
  .did -ra icon 2 Total Icons: $remove(%x,$chr(32),$true) - File: $nopath(%p)
  if (%x == 0) { .did -ra icon 2 Invalid Icon File: $nopath(%p) | return }
  .did -r icon 1 | .did -i icon 1 1 clearicons normal
  %~32 = $+(%x,$chr(171),$nopath(%p))
  while (%i <= %x) {
    .did -i icon 1 1 seticon normal 0 $+(%i,$chr(44),%p)
    if (%i != 0) { .did -a icon 1 0 + %i 0 0 $calc(%i -1) }
    inc %i
  }
}

on *:dialog:icon:sclick:1: { set %icl_sel $calc($did($dname,1).sel -2) }

on *:dialog:icon:sclick:3: {
  set %icl_icon %icl_sel $+ , $+ %icl_
  did -ra tbarsetup 4 %icl_icon 
  unset %icl_icon
  unset %icl_sel
  unset %icl_
  dialog -x $dname
}

dialog tbarsetup {
  title "Toolbar Setup [/tbarsetup]"
  size -1 -1 161 184
  option dbu
  tab "General", 1, 1 3 158 163
  list 2, 4 22 153 75, tab 1 size
  text "Icon:", 3, 4 99 18 8, tab 1
  edit "", 4, 32 98 109 10, tab 1
  button "!", 5, 143 98 14 10, tab 1
  text "Caption:", 6, 4 110 25 8, tab 1
  button "Add", 10, 80 152 37 12, tab 1
  text "Command:", 8, 4 121 27 8, tab 1
  edit "", 7, 32 109 109 10, tab 1
  edit "", 9, 32 120 109 10, tab 1
  button "Delete", 11, 120 152 37 12, tab 1
  text "Flags:", 29, 4 132 25 8, tab 1
  edit "", 30, 32 131 27 10, tab 1 autohs
  text "Command:", 31, 72 132 29 8, tab 1
  edit "", 32, 104 131 37 10, tab 1 autohs
  button "Seperator", 33, 4 152 37 12, tab 1
  tab "Options", 14
  check "Enable XP style background", 15, 5 34 82 10, tab 14
  check "Enable XP style scheme", 16, 5 43 76 10, tab 14
  check "Use lag bar", 17, 5 57 42 10, tab 14
  text "Calculate every", 18, 76 58 40 8, tab 14
  edit "", 19, 117 57 12 10, tab 14 autohs
  text "seconds", 20, 131 58 25 8, tab 14
  check "Use RAM bar", 21, 5 66 45 10, tab 14
  text "Calculate every", 22, 76 67 40 8, tab 14
  edit "", 23, 117 66 12 10, tab 14 autohs
  text "seconds", 24, 131 67 25 8, tab 14
  list 26, 4 87 153 62, tab 14 size
  box "", 25, 6 79 148 4, tab 14
  button "Add", 27, 80 152 37 12, tab 14
  button "Delete", 28, 120 152 37 12, tab 14
  check "Enable toolbar", 12, 5 25 50 10, tab 14
  button "&Done", 13, 123 170 37 12, ok
}

on *:dialog:tbarsetup:init:0: {
  mdx MarkDialog $dname
  mdx SetControlMDX $dname 2,26 Listview report rowselect single > $views
  mdx SetDialog $dname icon
  mdx SetFont $dname 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,33 -11 400 Tahoma
  did -i $dname 2 1 headerdims 50 140 150
  did -i $dname 2 1 headertext Icon $chr(9) Caption $chr(9) Command
  did -i $dname 26 1 headerdims 230 71
  did -i $dname 26 1 headertext Server address $chr(9) Port

  $iif($rconf(Toolbar) = on,did -c $dname 12)
  $iif($rconf(XPbkg) = on,did -c $dname 15)
  $iif($rconf(XPscheme) = on,did -c $dname 16)
  $iif($rconf(Lagbar) = on,did -c $dname 17)
  $iif($rconf(Rambar) = on,did -c $dname 21)
  $iif($rconf(Lagcheck),did -ra $dname 19 $ifmatch)
  $iif($rconf(Ramcheck),did -ra $dname 23 $ifmatch)
  did -c $dname 4,7,9,19,23,30,32 1
  load_tb.data
  load_servers
}

on *:dialog:tbarsetup:sclick:2: {
  if ($did($dname,2).sel) {
    var %sel = $calc($did($dname,2).sel - 1)
    did -ra $dname 4 $gettok($read($shortfn(sys\dlls\Data.dat),%sel),1,42)
    did -ra $dname 7 $gettok($read($shortfn(sys\dlls\Data.dat),%sel),2,42)
    did -ra $dname 9 $gettok($read($shortfn(sys\dlls\Data.dat),%sel),3,42)
    did -ra $dname 30 $gettok($read($shortfn(sys\dlls\Data.dat),%sel),4,42)
    did -ra $dname 32 $gettok($read($shortfn(sys\dlls\Data.dat),%sel),5,42)
    did -c $dname 4,7,9,19,23,30,32
  }
  else { did -r $dname 4,7,9,30,32 }
}

on *:dialog:tbarsetup:sclick:5: {
  var %i = $sfile(C:,Select an icon to use,Select)
  if (%i) {
    if (.icl isin %i || .dll isin %i || .exe isin %i) { set %icl_ %i | dialog -m icon icon }
    else { did -ra $dname 4 %i }
  }
}

on *:dialog:tbarsetup:sclick:10: {
  if ($did($dname,4).text && $did($dname,7).text && $did($dname,9).text) {
    var %icon = $did($dname,4).text
    var %cap = $did($dname,7).text  
    var %cmd = $did($dname,9).text
    write $shortfn(sys\dlls\Data.dat) %icon $+ * $+ %cap $+ * $+ %cmd $+ * $+ $iif($did($dname,30).text,$did($dname,30).text,+) $+ * $+ $iif($did($dname,32).text,$did($dname,32).text,None)
    did -r $dname 2,4,7,9,30,32
    did -i $dname 2 1 clearicons normal
    load_tb.data
  }
}

on *:dialog:tbarsetup:sclick:11: {
  if ($did($dname,2).sel) {
    var %sel = $calc($did($dname,2).sel - 1)
    write -dl $+ %sel $shortfn(sys\dlls\Data.dat)
    did -r $dname 2,4,7,9,30,32
    did -i $dname 2 1 clearicons normal
    load_tb.data
  }
}

on *:dialog:tbarsetup:sclick:13: {
  $iif($did($dname,12).state = 1,conf Toolbar on,conf Toolbar off)
  $iif($did($dname,15).state = 1,conf XPbkg on,conf XPbkg off)
  $iif($did($dname,16).state = 1,conf XPscheme on,conf XPscheme off)
  $iif($did($dname,17).state = 1,conf Lagbar on,conf Lagbar off)
  $iif($did($dname,19).text,conf Lagcheck $did($dname,19).text)
  $iif($did($dname,23).text,conf Ramcheck $did($dname,23).text)
  $iif($did($dname,21).state = 1,conf Rambar on,conf Rambar off)

  if ($did($dname,12).state = 1 && !$dialog(tb)) {
    dialog -m tb tb
  }
  elseif ($did($dname,12).state = 0 && $dialog(tb)) {
    dialog -x tb
    rebar UnDock top
    rebar ShowToolbar
  }
  elseif ($did($dname,12).state = 1 && $dialog(tb)) {
    dialog -x tb
    dialog -m tb tb
  } 
  $iif($did($dname,17).state  = 1,.timerlag 0 $iif($rconf(Lagcheck),$ifmatch,10) tlag)
  $iif($did($dname,21).state = 1,.timerram 0 $iif($rconf(ramcheck),$ifmatch,10) $iif($dialog(tb),did -ra tb 6 $round($remove($gettok($dll($moo,meminfo,_),3,32),$chr(40),$chr(41),$chr(37)),0)))
  $iif($did($dname,17).state = 0,$iif($timer(lag),.timerlag off))
  $iif($did($dname,21).state = 0,$iif($timer(ram),.timerram off))
}

on *:dialog:tbarsetup:sclick:27: {
  var %server = $$?="Enter server address:"
  var %port = $$?="Enter port number:"
  if (%server && %port) {
    write $shortfn(sys\dlls\Servers.dat) %server $+ * $+ %port
    did -r $dname 26
    load_servers
  }
}

on *:dialog:tbarsetup:sclick:28: {
  if ($did($dname,26).sel) {
    var %sel = $calc($did($dname,26).sel - 1)
    write -dl $+ %sel $shortfn(sys\dlls\Servers.dat)
    did -r $dname 26
    load_servers
  }
}

on *:dialog:tbarsetup:sclick:33: {
  write $shortfn(sys\dlls\Data.dat) -
  did -r $dname 2 
  did -i $dname 2 1 clearicons normal
  load_tb.data
}

;Menubar popup

menu menubar {
  Toolbar
  .Status
  ..$iif($rconf(Toolbar) = on,$style(1)) $+ On:toolbar on
  ..$iif($rconf(Toolbar) = off,$style(1)) $+ Off:toolbar off
  ..-
  ..Refresh:toolbar refresh
  .Setup:tbarsetup
  .Readme:run $shortfn(sys\dlls\readme.txt)
}

alias toolbar { 
  if ($1 = on && !$dialog(tb)) {
    dialog -m tb tb
    conf Toolbar on
  }
  elseif ($1 = off && $dialog(tb)) {
    dialog -x tb
    rebar UnDock top
    rebar ShowToolbar
    conf Toolbar off
  }
  elseif ($1 = refresh && $dialog(tb)) {
    dialog -x tb
    dialog -m tb tb
  }
}
