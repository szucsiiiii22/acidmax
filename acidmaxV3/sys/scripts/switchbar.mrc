on *:LOAD: { 
  dll sys\dll\UltraDock.dll ShowSwitchbar 0 | .enable #afswitchbar | set %afswitchbar on | set %afswitchbaricons 0,1,2,3,4,5,6,7,8,9,10,11 | set %afswitchbarresize on | set %afswitchbarcolour original | set %afswitchbarcolorbkg 255,255,255 | set %afswitchbarcolortext 0,0,0 | set %afswitchbarborder clientedge
}
alias -l load.sb {
  dialog -m switchbar switchbar
  load.switchbar
}
on *:START:{
  if (%afswitchbar != off) {
    dll sys\dlls\UltraDock.dll ShowSwitchbar 0
    if (%afswitchbaricons == $null) { %afswitchbaricons = 0,1,2,3,4,5,6,7,8,9,10,11 }
    if (%afswitchbar == $null) { %afswitchbar = on | dll sys\dlls\UltraDock.dll ShowSwitchbar 0 | .enable #afswitchbar }   
    .timer 1 1 load.sb    
  }
  elseif (%afswitchbar == off) { .disable #afswitchbar }
}

on *:exit: { dll -u sys\dlls\ultradock.dll | unset %high.t | unset %high.q }


alias mdx { return sys\dlls\mdx.dll }
alias views { return sys\dlls\views.mdx }
alias ud { return sys\dlls\UltraDock.dll }
alias dmdx { return sys\dlls\\dialog.mdx }

dialog switchbar {
  title "switchbar"
  size -1 0 70 289
  option dbu
  list 1, 1 0 86 288, size
  button "positioner", 2, 47 316 27 12, hide
}


on *:dialog:switchbar:init:0: {
  dll $mdx MarkDialog $dname
  dll $mdx SetMircVersion $version 
  dll $mdx SetControlMDX $dname 1 TreeView haslines hasbuttons showsel insertdroptarget > $views 
  dll $mdx SetControlMDX $dname 2 positioner minbox > $dmdx
  if (%afswitchbarresize == on) { dll $mdx SetControlMDX $dname 2 positioner size > $dmdx }
  if ($color($color(background).dd) >= 6500000) {
    did -i $dname 1 1 setcolor text $rgb(0,0,0)
    did -i $dname 1 1 setcolor line $rgb(0,0,0)
  }

  else {
    did -i $dname 1 1 setcolor text $rgb(255,255,255)
    did -i $dname 1 1 setcolor line $rgb(255,255,255)
  }
  did -i $dname 1 1 setcolor bkg $color($color(background).dd)

  switchbarborderstyle
  dll $ud Dock -1 $dialog(switchbar).hwnd left switchbar


}

on *:dialog:switchbar:sclick:*:{
  if ($did == 1) {
    tokenize 32 $did(1,1,1)
    if (($4) && ($calc($4 - 1) <= $scid(0))) {
      scon $calc($4 - 1)
      if (!$5) { window -a "status window" | .timer -m 1 1 editbox -f }
      elseif ($5 == 2) && ($6) { 
        if ($mouse.key & 2) { part $chan($calc($6 - 1)) } 
        else { 
          window -a $chan($calc($6 - 1)) 
          .timer -m 1 1 editbox -f $chan($calc($6 - 1)) 
          if ($chan($calc($6 - 1)) isin %high.t) {
            set %high.t $remtok(%high.t,$chan($calc($6 - 1)),1,32)
          }
        } 
      }
      elseif ($5 == 3) && ($6) {
        if ($mouse.key & 2) { close -m $query($calc($6 - 1)) } 
        else { 
          window -a $query($calc($6 - 1)) 
          .timer -m 1 1 editbox -f $query($calc($6 - 1)) 
          if ($query($calc($6 - 1)) isin %high.q) {
            set %high.q $remtok(%high.q,$query($calc($6 - 1)),1,32)
          } 
        }
      }
    }
    elseif ($4 == $calc($scid(0) + 2)) {
      if (!$5) {
      }
      elseif ($5 == 2) && ($6) { window -a "Get $get($calc($6 - 1)) $get($calc($6 - 1)).file $+ " }
      elseif ($5 == 3) && ($6) { window -a "Send $send($calc($6 - 1)) $send($calc($6 - 1)).file $+ " }
      elseif ($5 == 4) && ($6) { window -a = $+ $chat($calc($6 - 1)) | .timer -m 1 1 editbox -f = $+ $chat($calc($6 - 1)) }
    }
    elseif ($4 == $calc($scid(0) + 3)) && ($5) { window -a $window($calc($5 -1)) }
  }
  if ($did == 2) {
    tokenize 32 $did(switchbar,2,1) 
    dll $mdx SetDialog $dname coords * * * $window(-3).h
    if ($1 == size) {
      var %w = $dialog(switchbar).cw,%h = $dialog(switchbar).ch 
      dll $mdx MoveControl switchbar 1 4 5 $calc(%w -8) $calc(%h -10) 
    } 
    if ($1 == sizing) {
      set %afswitchbarposition $9
      did -a $dname 2 setSize c $iif($9 < 373,$9,373) $iif($10 < 495,$10,495)
    }
  } 
}


alias switchbar.navchan { did -i switchbar 1 1 cb root $calc($switchbar($1).getcon + 1) 2 }
alias switchbar.navquery { did -i switchbar 1 1 cb root $calc($switchbar($1).getcon + 1) 3 }
alias switchbarborderstyle { dll $mdx SetBorderStyle switchbar 1 %afswitchbarborder }
alias switchbar.replace { did -i switchbar 1 1 replaceitem $1- }
alias afswitchbarclearicons { did -i switchbar 1 1 clearicons normal }
alias switchbar {
  if ($isid) {
    if ($prop == getcon) { var %i = 1 | while (%i <= $scon(0)) { if ($scon(%i) == $1) { return %i } | inc %i } }
    if ($prop == ischan) { var %i = 2 | while (%i <= $did(switchbar,1).lines) { if ($1 == $gettok($did(switchbar,1,%i),7,32)) { return %i } | inc %i } }
    if ($prop == isquery) { var %i = 2 | while (%i <= $did(switchbar,1).lines) { if ($1 == $gettok($did(switchbar,1,%i),7,32)) { return %i } | inc %i } }
  }
}

alias load.switchbar {
  if ($dialog(switchbar) != $null) {
    did -r switchbar 1
    did -i switchbar 1 1 iconsize normal small
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,1,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,2,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,3,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,6,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,5,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,4,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,7,44) $+ , $+ sys\img\icons\switchbar.icl
    did -i switchbar 1 1 seticon normal $gettok(%afswitchbaricons,11,44) $+ , $+ sys\img\icons\switchbar.icl
    var %a = 1
    while (%a <= $scon(0)) {
      scon %a
      did -i switchbar 1 1 cb root
      did -a switchbar 1 +eb 1 1 0 $iif($scon(%a).network == $null,$iif($scon(%a).server == $null,Not Connected,$scon(%a).server),$scon(%a).network)
      did -i switchbar 1 1 cb last
      did -a switchbar 1 +eb 2 2 0 Channels: $chan(0)
      did -i switchbar 1 1 cb last
      var %x = 1
      while (%x <= $chan(0)) {
        if ($chan(%x) isin %high.t) {
          did -a switchbar 1 +c 2 2 0 $iif($len($chan(%x)) >= 20,$wrap($left($chan(%x),20),arial,12,85,0,1) $+ ...,$chan(%x))
        }
        else {
          did -a switchbar 1 +e 2 2 0 $iif($len($chan(%x)) >= 20,$wrap($left($chan(%x),20),arial,12,85,0,1) $+ ...,$chan(%x))
        }
        inc %x
      }
      did -i switchbar 1 1 cb up
      did -a switchbar 1 +eb 3 3 0 Queries: $query(0)
      did -i switchbar 1 1 cb last
      var %x = 1
      while (%x <= $query(0)) {
        if ($query(%x) isin %high.q) {
          did -a switchbar 1 +c 3 3 0 $query(%x)
        }
        else {
          did -a switchbar 1 +e 3 3 0 $query(%x)
        }
        inc %x
      }
      inc %a
    }

    did -i switchbar 1 1 cb up
    did -i switchbar 1 1 cb up
    did -a switchbar 1 +eb 7 7 0 DCCs: $calc($get(0) + $send(0) + $chat(0))
    did -i switchbar 1 1 cb last
    did -a switchbar 1 +eb 4 4 0 Gets: $get(0)
    did -i switchbar 1 1 cb last
    var %x = 1
    while (%x <= $get(0)) {
      did -a switchbar 1 +e 4 4 0 $iif($len($get(%x) ( $+ $get(%x).file $+ ) ) >= 20,$wrap($left($get(%x) $chr(40) $+ $get(%x).file,20),arial,12,105,0,1),$get(%x) ( $+ $get(%x).file)) $+ )
      inc %x
    }
    did -i switchbar 1 1 cb up
    did -a switchbar 1 +eb 5 5 0 Sends: $send(0)
    did -i switchbar 1 1 cb last
    var %x = 1
    while (%x <= $send(0)) {
      did -a switchbar 1 +e 4 4 0 $iif($len($send(%x) ( $+ $send(%x).file $+ ) ) >= 20,$wrap($left($send(%x) $chr(40) $+ $send(%x).file,20),arial,12,105,0,1),$send(%x) ( $+ $send(%x).file)) $+ )
      inc %x
    }
    did -i switchbar 1 1 cb up
    did -a switchbar 1 +eb 6 6 0 Chats: $chat(0)
    did -i switchbar 1 1 cb last
    var %x = 1
    while (%x <= $chat(0)) {
      did -a switchbar 1 +e 6 6 0 $iif($chat(%x).status == inactive,$chat(%x) ( $+ disc. $+ ),$chat(%x))
      inc %x
    }
    did -i switchbar 1 1 cb up
    did -i switchbar 1 1 cb up
    did -a switchbar 1 +eb 8 8 0 Windows: $window(0)
    did -i switchbar 1 1 cb last
    var %x = 1
    while (%x <= $window(0)) {
      did -a switchbar 1 +e 8 8 0 $window(%x)
      inc %x
    }
  }
}
#afswitchbar on
alias _comchan { var %cs = 1 | while ($comchan($1,%cs)) { var %c = $ifmatch | if ($prop == pnick) var %c = $remove($nick(%c,$1).pnick,$1) $+ %c | var %cll = $addtok(%cll,%c,44) | inc %cs } | if (%cll) return $sorttok(%cll,44) | else return no common channels }
alias close { close $1- | .timer -m 1 1 load.switchbar }
alias debug { 
  if $isid { return }  
  var %a = $wildtok($1-,@*,1,32),%b = $debug(%a)  
  !debug $1-  
  if %a && !%b { .signal windowopen %a }
}
alias query { !query $1$2- | .timer -m 1 1 load.switchbar }
alias -l window window $1- 
}
ctcp *:dcc send *:?:{ .timer -m 1 1 load.switchbar | set %waiting $true | .timer 0 1 accepted }
on me:*:join:#:{ .timer -m 1 1 load.switchbar }
on me:*:part:#:{ .timer -m 1 1 load.switchbar }
on *:action:*:#: { if ($chan != $active) { switchbar.navchan $cid | switchbar.replace $switchbar($chan).ischan +c 2 2 0 $chan | set %high.t $addtok(%high.t,$chan,32) } }
on *:action:*:?: { if ($nick != $active) { switchbar.navquery $cid | switchbar.replace $switchbar($nick).isquery +c 3 3 0 $nick | set %high.q $addtok(%high.q,$nick,32) } }
on *:close:@:{ .timer -m 1 1 load.switchbar }
on *:close:=:{ .timer -m 1 1 load.switchbar }
on *:close:?:{ .timer -m 1 1 load.switchbar }
on *:close:*:{ if ($target == status window) set %m_status closed }
on *:connect:{ .timer -m 1 1 load.switchbar }
on *:disconnect:{ .timer -m 1 1 load.switchbar }
on *:filercvd:*:{ .timer -m 1 1 load.switchbar | echo -a $nopath($filename) successfully received from $nick ( $+ $_comchan($nick) $+ ) }
on *:filesent:*:{ .timer -m 1 1 load.switchbar | echo -a $nopath($filename) successfully sent to $nick ( $+ $_comchan($nick) $+ ) }
on *:getfail:*:{ .timer -m 1 1 load.switchbar | echo -a Failed to receive $nopath($filename) from $nick ( $+ $_comchan($nick) $+ ) }
on *:kick:#: { if ($knick == $me) { .timer -m 1 5 load.switchbar } }
on *:open:?:{ load.switchbar }
on *:open:=:{ .timer -m 1 1 load.switchbar }
on *:sendfail:*:{ .timer -m 1 1 load.switchbar | echo -a Failed to send $nopath($filename) to $nick ( $+ $_comchan($nick) $+ ) }
on *:text:*:#: { if ($chan != $active) { switchbar.navchan $cid | switchbar.replace $switchbar($chan).ischan +c 2 2 0 $chan | set %high.t $addtok(%high.t,$chan,32) } }
on *:text:*:?: { if ($nick != $active) { switchbar.navquery $cid | switchbar.replace $switchbar($nick).isquery +c 3 3 0 $nick | set %high.q $addtok(%high.q,$nick,32) } }
alias accepted {
  if (!%waiting) { halt }
  if ($get($get(0)).rcvd > 1) {
    .timer -m 1 1 load.switchbar
    unset %waiting
  }
  if ($send($send(0)).sent > 1) {
    .timer -m 1 1 load.switchbar
    unset %waiting
  }
}

alias switchbar.lactive { if ($query($1)) { hadd -m switchbar lactive query $+ $chr(164) $+ $1 $+ $chr(164) $+ $2 } | elseif ($chan($1)) { hadd -m switchbar lactive chan $+ $chr(164) $+ $1 $+ $chr(164) $+ $2 } }

on *:active:#: {
  if ($dialog(switchbar) != $null) {
    did -i switchbar 1 1 setcolor bkg $color($color(background).dd) 
    scon -a dll $adll SetChannelWnd $chan($chan).hwnd  
    switchbar.navchan $cid
    var %a = $switchbar(name).lactive
    switchbar.navchan $switchbar(id).lactive
    var %b = $switchbar(%a).ischan
    switchbar.navquery $switchbar(id).lactive
    var %c = $switchbar(%a).isquery
    switchbar.navchan $cid
    var %d = $switchbar($chan).ischan
    if ($switchbar(type).lactive == chan) {
      switchbar.navchan $switchbar(id).lactive 
      switchbar.replace %b + 2 2 0 %a
    }
    elseif ($switchbar(type).lactive == query) { 
      switchbar.navquery $switchbar(id).lactive
      switchbar.replace %c + 2 2 0 %a
    } 
    switchbar.navchan $cid
    switchbar.replace %d + 2 2 0 $chan
    switchbar.lactive $chan $cid
  }
}
on *:active:?: {
  switchbar.navquery $cid
  var %a = $switchbar(name).lactive
  switchbar.navchan $switchbar(id).lactive
  var %b = $switchbar(%a).ischan
  switchbar.navquery $switchbar(id).lactive
  var %c = $switchbar(%a).isquery
  switchbar.navquery $cid
  var %d = $switchbar($target).isquery
  if ($switchbar(type).lactive == chan) { 
    switchbar.navchan $switchbar(id).lactive
    switchbar.replace %b + 3 3 0 %a
  }
  elseif ($switchbar(type).lactive == query) { 
    switchbar.navquery $switchbar(id).lactive
    switchbar.replace %c + 3 3 0 %a
  } 
  switchbar.navquery $cid
  switchbar.replace %d + 3 3 0 $target
  switchbar.lactive $target $cid
}

on *:active:*: {
  if (%m_status == closed) .timer -m 1 1 load.switchbar 
  unset %m_status
}

on *:nick: { 
  switchbar.navquery $cid
  if ($switchbar($nick).isquery) { 
    switchbar.navquery $cid 
    switchbar.replace $switchbar($nick).isquery + 3 3 0 $newnick 
  } 
}
#afswitchbar end

alias switchbaredit { dialog -m switchbaredit switchbaredit }
dialog switchbaredit {
  title "Switchbar Editor"
  size -1 -1 77 132
  option dbu
  button "", 17, -50 -50 5 5, ok
  button "Close", 1, 8 119 28 10
  button "About", 2, 41 119 28 10
  box " Icons: ", 3, 3 26 71 23
  combo 4, 7 34 63 25, drop
  box " Switchbar: ", 5, 3 2 71 22
  radio "ON", 6, 7 10 29 10, push
  radio "OFF", 7, 41 10 29 10, push
  box " Border: ", 8, 3 93 71 23
  combo 9, 7 101 63 25, drop
  box " Colors: ", 10, 3 70 71 21
  button "Background", 11, 8 78 36 10
  button "Text", 12, 47 78 22 10
  box "", 13, 3 51 71 17
  text "Resizeable:", 14, 7 57 34 8
  radio "YES", 15, 36 57 18 8
  radio "NO", 16, 56 57 16 8
}

on *:dialog:switchbaredit:*:*:{
  if ($devent == init) {
    if (%afswitchbar == on) { did -c $dname 6 } | elseif (%afswitchbar == off) { did -c $dname 7 }
    didtok $dname 4 44 Original,CornFlower Blue,Lime Green,Red,Silver,Aqua Green,Violet Red,Light Orange,Dark Blue,Grey White
    did -c $dname 4 $iif(original isin %afswitchbarcolour,1,$iif(cfblew isin %afswitchbarcolour,2,$iif(limegr33n isin %afswitchbarcolour,3,$iif(r3d isin %afswitchbarcolour,4,$iif(silver isin %afswitchbarcolour,5,$iif(aquagreen isin %afswitchbarcolour,6,$iif(violetred isin %afswitchbarcolour,7,$iif(lightorange isin %afswitchbarcolour,8,$iif(darkblue isin %afswitchbarcolour,9,$iif(greywhite isin %afswitchbarcolour,10))))))))))
    didtok $dname 9 44 Border,Double Border,Sunken Edge,3D Border Style,Raised Edge
    did -c $dname 9 $iif(border isin %afswitchbarborder,1,$iif(dlgmodal isin %afswitchbarborder,2,$iif(clientedge isin %afswitchbarborder,3,$iif(staticedge isin %afswitchbarborder,4,5))))
    if (%afswitchbarresize == on) { did -c $dname 15 } | elseif (%afswitchbarresize == off) { did -c $dname 16 }
  }
  if ($devent == sclick) {
    if ($did == 1) { dialog -x $dname }
    if ($did == 2) { dialog -m afswitchbarabout afswitchbarabout }
    if ($did == 4) && (%afswitchbar == on) {
      if ($did($dname,4).sel == 1) { set %afswitchbarcolour original | set %afswitchbaricons 0,1,2,3,4,5,6,7,8,9,10,11 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 2) { set %afswitchbarcolour cfblew | set %afswitchbaricons 12,13,14,15,16,17,18,19,20,21,22,23 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 3) { set %afswitchbarcolour limegr33n | set %afswitchbaricons 24,25,26,27,28,29,30,31,32,33,34,35 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 4) { set %afswitchbarcolour r3d | set %afswitchbaricons 36,37,38,39,40,41,42,43,44,45,46,47 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 5) { set %afswitchbarcolour silver | set %afswitchbaricons 48,49,50,51,52,53,54,55,56,57,58,59 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 6) { set %afswitchbarcolour aquagreen | set %afswitchbaricons 60,61,62,63,64,65,66,67,68,69,70,71 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 7) { set %afswitchbarcolour violetred | set %afswitchbaricons 72,73,74,75,76,77,78,79,80,81,82,83 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 8) { set %afswitchbarcolour lightorange | set %afswitchbaricons 84,85,86,87,88,89,90,91,92,93,94,95 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 9) { set %afswitchbarcolour darkblue | set %afswitchbaricons 96,97,98,99,100,101,102,103,104,105,106,107 | afswitchbarclearicons | load.switchbar }
      if ($did($dname,4).sel == 10) { set %afswitchbarcolour greywhite | set %afswitchbaricons 108,109,110,111,112,113,114,115,116,117,118,119 | afswitchbarclearicons | load.switchbar }
    }
    if ($did == 6) {
      if (%afswitchbar == off) { set %afswitchbar on | dll sys\dlls\UltraDock.dll ShowSwitchbar 0 | dialog -m switchbar switchbar | .enable #afswitchbar | load.switchbar }
    }
    if ($did == 7) {
      if (%afswitchbar == on) { set %afswitchbar off | echo -a 4Treeview switchbar will be removed next time you start mIRC. | dll sys\dlls\UltraDock.dll ShowSwitchbar 1 | dll sys\dlls\UltraDock.dll UnDock $dll(sys\dlls\UltraDock.dll,DockPos,switchbar) | dialog -x switchbar }
    }
    if ($did == 9) {
      if ($did($dname,9).sel == 1) { set %afswitchbarborder border | switchbarborderstyle }
      if ($did($dname,9).sel == 2) { set %afswitchbarborder dlgmodal | switchbarborderstyle }
      if ($did($dname,9).sel == 3) { set %afswitchbarborder clientedge | switchbarborderstyle }
      if ($did($dname,9).sel == 4) { set %afswitchbarborder staticedge | switchbarborderstyle }
      if ($did($dname,9).sel == 5) { set %afswitchbarborder windowedge | switchbarborderstyle }
    }
    if ($did == 11) && (%afswitchbar == on) { afswitchbarrgb1 }
    if ($did == 12) && (%afswitchbar == on) { afswitchbarrgb2 }
    if ($did == 15) && (%afswitchbarresize == off) { set %afswitchbarresize on | dialog -x switchbar | dialog -m switchbar switchbar | load.switchbar }
    if ($did == 16) && (%afswitchbarresize == on) { set %afswitchbarresize off | dialog -x switchbar | dialog -m switchbar switchbar | load.switchbar }
  }
}


menu status,menubar {
  Treeview Switchbar:switchbaredit
}
