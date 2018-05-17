on *:start: { 
  if (%toolbar != 0) { tools.on }
}
;toolbar
dialog toolbar {
  title "toolbar"
  size 100 100 642 2
  option dbu
  ;icon sys\img\4.ico, 0
  list 2, 1 2 225 11, size
  box "", 1, -82 -3 9010 4
  text "", 3, 281 1 50 6

  text "", 4, 281 7 50 6
}

alias tools.on {
  if (!$dialog(toolbar)) {
    dialog -m toolbar toolbar
    if (%tbicons == $null) { %tbicons = 1 } 
    set %toolbar 1
  }
}

alias tools.off {
  if ($dialog(toolbar)) {
    dialog -c toolbar
    set %toolbar 0
  }
}

alias movetoolbar {
  mdx MoveControl toolbar 3 $calc($1 - 101) 4 100 10
  mdx MoveControl toolbar 4 $calc($1 - 101) 16 100 10
  mdx MoveControl toolbar 8 $calc($1 - 157) 3 50 11
  mdx MoveControl toolbar 9 $calc($1 - 157) 14 50 17
  mdx MoveControl toolbar 6 $calc($1 - 220) 3 50 11
  mdx MoveControl toolbar 7 $calc($1 - 220) 14 50 17
}

alias sendkey {
  if ($1 && $2) {
    dll sys\dlls\sendkey.dll $1-
  }
}

on *:DIALOG:toolbar:*:*:{
  if ($devent == INIT) {
    mdx SetMircVersion $version
    mdx MarkDialog $dname $dialog($dname).hwnd
    mdx SetDialog $dname style
    mdx SetBorderStyle 2,10
    mdx SetControlMDX 2 ToolBar flat nodivider arrows > sys\dlls\bars.mdx
    ;mdx SetControlMDX 3,4 ProgressBar smooth > sys\dlls\ctl_gen.mdx
    ;    mdx SetControlMDX 8,9,7,6 Text right > sys\dlls\ctl_gen.mdx
    ;   mdx SetFont 6,7,8,9 12 400 Tahoma

    ;did -a $dname 3,4 bgcolor $color($color(back))
    ;did -a $dname 3 barcolor $color($color(normal))

    dll sys\dlls\UltraDock.dll Dock -1 $dialog(toolbar).hwnd top toolbar 
    ; dll sys\dlls\mdock61.dll DockToolbar $dialog(toolbar).hwnd




    connectmenu
    helpmenu
    toolbar.ref

    movetoolbar $eval($calc($window(-2).w - 8),2)
  }
  if ($devent == SCLICK) {
    if ($did == 2) {
      var %x = $did($dname,2).sel
      if (%x == 3) {
        if ($status == connected || $status == connecting) { disconnect | .timer -m 1 10 did -o $dname 2 3 +Wvc 40 3 $chr(9) Connect }
        else { server | .timer -m 1 10 did -o $dname 2 3 +Wxvc 40 3 $chr(9) Disconnect }
        toolbar.ref
      }
      elseif (%x == 5) { sendkey ALT o }
      elseif (%x == 6) { setup }
      elseif (%x == 7) { bl }
      elseif (%x == 10) { 
        if (%win.loc == $null) { %win.loc = 1 }
        if (%win.loc <= 1) { %win.loc = 2 | dll sys\dlls\dmu.dll Tile vertical }
        elseif (%win.loc == 2) { %win.loc = 3 | dll sys\dlls\dmu.dll Tile horizontal }       
        elseif (%win.loc => 3) { %win.loc = 1 | dll sys\dlls\dmu.dll Cascade . }       
      }
      elseif (%x == 17) { sendkey ALT i }
      elseif (%x == 19) { help }
      elseif (%x == 20) { about }
      elseif ($read(sys\data\toolbar.txt,$calc(%x - 8))) { $eval($gettok($ifmatch,3,9),2) }
    }

    ;  if ($did == 6 || $did == 8) {
    ;    tlag
    ;    mdx SetColor $dname 6,8 text 200
    ;    .timer -imo 1 400 mdx SetColor $dname 6,8 text reset
    ;  }
    ;  if ($did == 7 || $did == 9) {
    ;    did -ra $dname 9 $gettok($dll(sys\dlls\moo.dll,meminfo,_),2,32)
    ;    did -a $dname 4 $round($dll(sys\dlls\moo.dll,rambar,_),0) 0 100
    ;    mdx SetColor $dname 7,9 text 200
    ;    .timer -imo 1 400 mdx SetColor $dname 7,9 text reset
    ;  }
  }

  if ($devent == DCLICK) {
    if ($did == 2) {
      set %current $gettok($did($dname,2).seltext,2-,9)
      if (Connect isin %current || Disconnect isin %current) { do-popup connect $calc($tbpos + $calc(4.5 * $dbuw)) $calc($dialog(toolbar).y + $calc(13 * $dbuw)) }
      if (mIRC Help isin %current) { helpmenu | do-popup help $calc($tbpos + $calc(174.5 * $dbuw)) $calc($dialog(toolbar).y + $calc(13 * $dbuw)) }
    }
  }
  if ($devent == close) { .timertoolbar off }
}

alias tbpos { return $calc($window(-2).x + $calc(2 * $dbuw)) }

alias connectmenu {
  dll sys\dlls\popups.dll New connect 1 1
  dll sys\dlls\popups.dll AddItem connect end 1 Connect <?> $cr customserv 1
  dll sys\dlls\popups.dll AddItem connect end 1 New Connection $cr customserv 2
  dll sys\dlls\popups.dll AddItem connect end 1 New Connection <?> $cr customserv 3
  dll sys\dlls\popups.dll AddItem connect end
  dll sys\dlls\popups.dll AddItem connect end 2 Connect to last Server $cr server
  dll sys\dlls\popups.dll AddItem connect end 3 Disconnect $cr disconnect

  dll sys\dlls\popups.dll SetStyle connect bordertext bordericon
}

alias helpmenu {
  dll sys\dlls\popups.dll New help 1 1
  var %x 1
  dll sys\dlls\popups.dll AddItem help end 1 mirc.hlp $cr help
  dll sys\dlls\popups.dll AddItem help end
  while (%x <= $findfile($mircdirhelp\,*.hlp,0)) {
    dll sys\dlls\popups.dll AddItem help end 1 $nopath($findfile($mircdirhelp\,*.hlp,%x)) $cr run -p $findfile($mircdirhelp\,*.hlp,%x)
    inc %x
  }
  dll sys\dlls\popups.dll SetStyle help bordertext bordericon
}

alias customserv {
  if ($1 == 1) { var %x $irequest(Enter server address:) | if (%x) { server %x } }
  if ($1 == 2) { server -m }
  if ($1 == 3) { var %x $irequest(Enter server address:) | if (%x) { server -m %x } }
}

alias menu {
  var %result
  set %result $dll(sys\dlls\popups.dll,$1,$2-)
  if ($gettok(%result,1,32) == OK) return $gettok(%result,2-,32)
}
alias do-popup {
  var %click = $menu(Popup,$1-)
  if (%click != $null) $gettok(%click,3-,32)
  return
}
alias -l tbico {
  if (%tbicons == 1) { return sys\img\icons\Blue.icl }
  if (%tbicons == 2) { return sys\img\icons\Classic.icl }
  if (%tbicons == 3) { return sys\img\icons\Gnome.icl }
  if (%tbicons == 4) { return sys\img\icons\Jaffa.icl }
  if (%tbicons == 5) { return sys\img\icons\Metrox.icl }
  if (%tbicons == 6) { return sys\img\icons\Moonshine.icl }
  if (%tbicons == 7) { return sys\img\icons\MP.icl }
  if (%tbicons == 8) { return sys\img\icons\phoenity.icl }
  if (%tbicons == 9) { return sys\img\icons\WinXP.icl }
}

alias toolbar.ref {
  if ($dialog(toolbar)) {
    did -r toolbar 2
    did -i toolbar 2 1 bmpsize 16 16
    set %current 1
    while (%current <= 25) {
      did -i toolbar 2 1 setimage +nhd 0 icon small $+($calc(%current -1),$chr(44),$tbico)
      inc %current 1
    }
    did -a toolbar 2 -
    if ($status == Connected || $status == connecting) { did -a toolbar 2 +Wxvc 40 3 $chr(9) $+ Disconnect }
    else { did -a toolbar 2 +Wvc 40 3 $chr(9) $+ Connect }
    did -a toolbar 2 -
    did -a toolbar 2 +W 26 23 $chr(9) $+ mIRC Setup
    did -a toolbar 2 +W 26 25 $chr(9) $+ impulZ Setup
    did -a toolbar 2 +W 26 8 $chr(9) $+ Blacklist
    did -a toolbar 2 -

    var %x = 1
    while (%x <= $lines(sys\data\toolbar.txt)) {
      var %y = $read(sys\data\toolbar.txt,%x)
      if (%y == seperator) { did -a toolbar 2 - }
      else { did -a toolbar 2 +W 26 $gettok(%y,1,9) $chr(9) $+ $gettok(%y,2,9) }
      inc %x 1
    }

    did -a toolbar 2 -
    did -a toolbar 2 +W 26 11 $chr(9) $+ Arrange Windows (press again for alternative layout)
    did -a toolbar 2 +W 26 4 $chr(9) $+ Online timer
    did -a toolbar 2 -
    did -a toolbar 2 +vW 40 2 $chr(9) $+ mIRC Help
    did -a toolbar 2 +W 26 16 $chr(9) $+ About
    did -a toolbar 2 -
  }
}

alias tb_edit dialog -m tb_edit tb_edit

dialog tb_edit {
  title "Toolbar editor"
  size -1 -1 122 62
  option dbu
  icon skillfabrik\mIRC.ico, 0
  combo 1, 31 22 90 50, size
  text "Icon:", 2, 2 23 28 8
  text "Command:", 3, 2 13 28 8
  text "Tooltip:", 4, 2 3 28 8
  edit "", 5, 31 2 90 10, autohs
  edit "", 6, 31 12 90 10, autohs
  box "", 7, -29 44 182 119
  button "Save", 8, 44 49 37 12, ok
  button "Cancel", 9, 84 49 37 12, cancel
  check "Seperator", 11, 86 36 35 10
}

on *:Dialog:tb_edit:*:*:{
  if ($devent == INIT) {
    mdx SetMircVersion $version
    mdx MarkDialog $dname
    mdx SetControlMDX $dname 1 ComboBoxEx drop > sys\dlls\views.mdx

    did -i $dname 1 1 iconsize small
    var %x = 1
    while (%x <= 25) {
      did -i $dname 1 1 seticon 0 $+($calc(%x -1),$chr(44),$tbico)
      did -a $dname 1 %x $nopath($tbico)
      inc %x 1
    }
    did -c $dname 1 2

    if (%tb_add == 1) { did -ba $dname 8 Save }
    if (%tb_add == 2) {
      did -a $dname 8 Edit
      if ($read(sys\data\toolbar.txt,$calc($did(setup,64).sel - 1)) == seperator) {
        did -c $dname 11
        did -b $dname 5,6,1
      }
      else {
        did -a $dname 5 $gettok($read(sys\data\toolbar.txt,$calc($did(setup,64).sel - 1)),2,9)
        did -a $dname 6 $gettok($read(sys\data\toolbar.txt,$calc($did(setup,64).sel - 1)),3,9)
        did -c $dname 1 $calc($gettok($read(sys\data\toolbar.txt,$calc($did(setup,64).sel - 1)),1,9) + 1)
      }
    }
  }
  if ($devent == EDIT) {
    if (($did($dname,5) && $did($dname,6)) || $did($dname,11).state == 1) { did -e $dname 8 }
    else { did -b $dname 8 }
  }
  if ($devent == SCLICK) {
    if ($did == 11) {
      if ($did($dname,11).state == 1) { did -b $dname 5,6,1 | did -e $dname 8 }
      else {
        did -e $dname 5,6,1
        if ($did($dname,5) && $did($dname,6)) { did -e $dname 8 }
      }
    }
    if ($did == 8) {
      if ($did($dname,11).state == 1) {
        if (%tb_add == 1) { write sys\data\toolbar.txt seperator }
        elseif (%tb_add == 2) { write -l $+ $calc($did(setup,64).sel - 1) sys\data\toolbar.txt seperator }
      }
      else {
        if (%tb_add == 1) { write sys\data\toolbar.txt $+($calc($did($dname,1).sel - 1),$chr(9),$did($dname,5),$chr(9),$did($dname,6)) }
        elseif (%tb_add == 2) { write -l $+ $calc($did(setup,64).sel - 1) sys\data\toolbar.txt $+($calc($did($dname,1).sel - 1),$chr(9),$did($dname,5),$chr(9),$did($dname,6)) }
      }
      if ($dialog(setup)) { toolbar_setup_ref }
    }
  }
}

alias -l toolbar_setup_ref {
  did -r setup 64

  did -i setup 64 1 bmpsize 16 16

  var %x = 1
  while (%x <= 25) {
    did -i setup 64 1 seticon normal $+($calc(%x -1),$chr(44),$tbico)
    inc %x 1
  }

  var %x = 1
  while (%x <= $lines(sys\data\toolbar.txt)) {
    var %y = $read(sys\data\toolbar.txt,%x)
    if ($gettok(%y,1,9) == seperator) { did -a setup 64 0 + 0 0 - $chr(9) - }
    else { did -a setup 64 0 + $gettok(%y,1,9) 0 $gettok(%y,2-,9) }
    inc %x 1
  }
  toolbar.ref
}
