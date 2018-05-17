alias mdx { return sys\dlls\mdx.dll }
dialog st {
  title "New Project"
  size -1 -1 160 24
  option dbu
  button "Button", 1, 3 3 78 13
}
alias st {
  $iif(!$dialog(st),dialog -m st st)
}

on *:dialog:st:init:*: {
  dll $mdx SetMircVersion $version
  dll $mdx MarkDialog $dname
  dll $mdx SetControlMDX $dname 1 window > sys\dlls\dialog.mdx
  window -hp @lag 3 3 78 13
  did -a st 1 grab $window(@lag).hwnd @lag
  lag.open
}
alias lag.open {
  if ($_vr(lagmeter,lag.size) == $null) { _vw lagmeter lag.size small }
  if ($_vr(lagmeter,set.lag.open) == $null) { _vw lagmeter set.lag.open on }
  if ($_vr(lagmeter,set.lag.open) == on) { 
    if ($window(@Lag).x == $null) || ($1 == reset) || ($1 == reopen) { 
      if ($window(@Lag).x != $null) { %lag.x = $window(@Lag).x  | %lag.y = $window(@Lag).y }
      if ($1 == reopen) { window -c @Lag }
      if (%lag.x == $null) { set %lag.x 566 } | if (%lag.y == $null) { set %lag.y 0 }
      if ($1 != reset) { set %lag.tot 0 | set %lag.num 0 | window $iif($_vr(lagmeter,set.lag.top) == yes,-doapfh,-apfh) +fL @Lag %lag.x %lag.y 160 135 @Lag }
      if ($_vr(lagmeter,lag.size) != small) { drawpic -n @Lag 0 0 0 0 160 24 " $+ $findfile($mircdir,lagmeter1.bmp,1) $+ " }
      if ($1 == reset) {
        if ($_vr(lagmeter,lag.size) == small) { 
          set %^lag.h 138
          :start1
          dec %^lag.h 3
          window $iif($_vr(lagmeter,set.lag.top) == true,-doapf,-apf) +f @Lag %lag.x %lag.y 160 %^lag.h
          if (%^lag.h !=< 24) goto start1
        }
        else {
          set %^lag.h 21
          :start2
          inc %^lag.h 3
          window $iif($_vr(lagmeter,set.lag.top) == true,-doapf,-apf) +f @Lag %lag.x %lag.y 160 %^lag.h
          if (%^lag.h !=> 135) goto start2
        }
      }
      if (%lag.tot == 0) { drawpic -n @Lag 0 0 0 0 160 135 " $+ $findfile($mircdir,lagmeter1.bmp,1) $+ " | set %lag.back $getdot(@Lag,80,70) }
      if ($_vr(lagmeter,lag.size) == small) { 
        window $iif($_vr(lagmeter,set.lag.top) == true,-doapf,-apf) +f @Lag %lag.x %lag.y 160 24 
        drawpic @Lag 0 0 0 0 160 24 " $+ $findfile($mircdir,lagmeter2.jpg,1) $+ "
        set %lag.small.back $getdot(@Lag,95,12)
      }
      drawdot @Lag
    } 
    else { 
      if ($timer(Lag) != $null) { .timerLag off |  return }
    }
    if ($_vr(lagmeter,set.lag.delay) !isnum) { _vw lagmeter set.lag.delay 5 }
    if ($timer(Lag) == $null) && ($1 != reset) && ($1 != reopen) { lag.send | .timerLag 0 $_vr(lagmeter,set.lag.delay) lag.send }
    titlebar @Lag $server
  }
}
alias -l lag.menu.1 {
  if ($window(@Lag).x == $null) return &open
  elseif ($timer(Lag) == $null) return &unpause
  else return &pause
}
alias -l lag.menu.2a {
  if ($window(@Lag).x != $null) return &close
}
alias -l lag.menu.2b {
  if ($window(@Lag).x != $null) window -c @Lag
}


alias -l lag.send { if ($server != $null) { .raw privmsg $me :T $ticks  } }
menu Status,menubar {
  lag meter:lag.setup
}
menu @Lag {
  dclick {
    if ($window(@Lag).dh == 24) _vw lagmeter lag.size large
    if ($window(@Lag).dh == 135) _vw lagmeter lag.size small
    lag.open reset 
  }
  sclick {
    if ( $inrect($mouse.x,$mouse.y,148,0,12,12) == $true ) {
      .timerlag off | window -c @Lag
      unset %mouse.x | unset %mouse.y
      halt
    }
    if ($window(@Lag).dh == 24) {
      if ( $inrect($mouse.x,$mouse.y,148,12,12,12) == $true ) {
        _vw lagmeter lag.size large
        lag.open reset 
        unset %mouse.x | unset %mouse.y
        halt
      }
    }
    else { 
      if ( $inrect($mouse.x,$mouse.y,123,1,23,22) == $true ) {
        lag.setup
        unset %mouse.x | unset %mouse.y
        halt
      }
      if ( $inrect($mouse.x,$mouse.y,148,12,12,12) == $true ) {
        _vw lagmeter lag.size small
        lag.open reset
        unset %mouse.x | unset %mouse.y
        halt
      }
    } 
    %mouse.x = $mouse.x | %mouse.y = $mouse.y
  }
  mouse { 
    mouse @Lag 
  }
  $lag.menu.1 $+ : lag.open
  $lag.menu.2a $+ : $lag.menu.2b
  $iif($window(@Lag).dh == 24,&bigger,s&maller): {
    if ($window(@Lag).dh == 24) _vw lagmeter lag.size large
    if ($window(@Lag).dh == 135) _vw lagmeter lag.size small
    lag.open reset 
  }
  -
  &setup: lag.setup
}
raw 301:*: { if ($2 == $me) && ($timer(Lag) != $null) halt }
on *:connect: {
  %lag.num = 0 
  st
}
ctcp *:t: {
  if ($_vr(lagmeter,set.lag.open) == on) { 
    if ($window(@Lag).x == $null) { .timerlag off | halt }
    if ($timer(Lag) == $null) { halt }
    if ($nick != $me) return
    if ($ticks <= $2) return
    set %^lag $left($round($calc(($ticks - $2) / 1000),3),5)
    inc %lag.num
    set %lag.tot $calc(%lag.tot + %^lag)
    set %^lag.avg $left($round($calc(%lag.tot / %lag.num),3),5)
    set %^lag.n %^lag *  127.5
    set %^lag.avg.n %^lag.avg *  127.5
    if ( %^lag.n > 255) {
      set %^lag.r  255
      set %^lag.g 510 - %^lag.n
    }
    else {
      set %^lag.g 255
      set %^lag.r %^lag.n
    }
    if ( %^lag.avg.n > 255) {
      set %^lag.avg.r 255
      set %^lag.avg.g 510 - %^lag.avg.n
    }
    else {
      set %^lag.avg.g 255
      set %^lag.avg.r %^lag.avg.n
    }
    if (%^lag.g < 0) set %^lag.g 0
    if (%^lag.r < 0) set %^lag.r 0
    set %^lag.color $rgb( %^lag.r , %^lag.g ,0)
    if (%^lag.avg.g < 0) set %^lag.avg.g 0
    if (%^lag.avg.r < 0) set %^lag.avg.r 0
    set %^lag.avg.color $rgb( %^lag.avg.r , %^lag.avg.g ,0)
    set %^lag.len $round($calc(105 - (%^lag * 20)),0)
    if (%^lag.len < 26) set %^lag.len 26
    drawscroll -n @Lag -3 0 11 25 138 82
    drawpic -nc @Lag 146 25 146 25 3 82 " $+ $findfile($mircdir,lagmeter1.bmp,1) $+ "
    ;drawline -rn @Lag %lag.back 3 147 26 147 105
    drawline -rn @Lag %^lag.color 3 147 %^lag.len 147 105
    drawpic -nc @Lag 23 123 23 123 113 10 " $+ $findfile($mircdir,lagmeter1.bmp,1) $+ "
    drawtext -ron @Lag %^lag.color Arial 11 23 120 %^lag
    drawtext -ron @Lag %^lag.avg.color Arial 11 105 120 %^lag.avg
    drawline -rn @Lag 16777215 1 11 85 149 85
    drawline -rn @Lag 16777215 1 11 65 149 65
    drawline -rn @Lag 16777215 1 11 45 149 45
    if ($window(@Lag).dh == 24) {
      set %^lag.len2 $round($calc(145 - (%^lag * 20)),0)    
      if (%^lag.len2 < 46) set %^lag.len2 46
      drawscroll -n @Lag 0 -3 45 3 100 18
      drawline -rn @Lag %lag.small.back 3 143 19 46 19
      drawline -rn @Lag %^lag.color 3 143 19 %^lag.len2 19
      drawline -rn @Lag 16777215 1 125 3 125 21
      drawline -rn @Lag 16777215 1 105 3 105 21
      drawline -rn @Lag 16777215 1 85 3 85 21
      drawline -rn @Lag 16777215 1 65 3 65 21
      drawpic -nc @Lag 11 1 11 1 31 22 " $+ $findfile($mircdir,lagmeter2.jpg,1) $+ "
      drawtext -ron @Lag %^lag.color Arial 11 11 -2 %^lag
      drawtext -ron @Lag %^lag.avg.color Arial 11 11 10 %^lag.avg
    }
    drawline @Lag
    halt
  }
  else { window -c @Lag | .timerlag off }
}
