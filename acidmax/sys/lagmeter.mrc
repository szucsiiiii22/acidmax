;LagMeter v1.64
;Team Nexgen 2002 by BlackWidow & KnightFal
;team-nexgen.com

on *:load:{ echo -a 4TEAM NEXGEN'S LAGMETER v1.64 | echo -a 4Please type: /lag.open to begin. }

on *:APPACTIVE: {
  if ($_vr(lagmeter,set.lag.open) == on) { lag.open } 
  if ($_vr(lagmeter,set.lag.top) == yes) && ($_vr(lagmeter,set.lag.open) == on) {
    if ($appactive == $false) { window -hn +L @Lag | halt }
    elseif ($appactive == $true) && ($server != $null) { window -doapf +L @Lag | .timerlmbr -o 2 1 lm.ch }
  }
}
alias -l lm.ch  if ($appactive == $true) && ($server != $null) { window -doapf +L @Lag | .timerlmbr off }

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
alias -l mouse { 
  if ($mouse.key == 1) { 
    if (%mouse.x == $null) || (%mouse.y == $null) { halt }
    %^mouse.x = $calc( [ $window($$1).x ] + [ $calc( [ $mouse.x ] - [ %mouse.x ] ) ] )
    %^mouse.y = $calc( [ $window($$1).y ] + [ $calc( [ $mouse.y ] - [ %mouse.y ] ) ] )
    %lag.x =  %^mouse.x | %lag.y =  %^mouse.y
    window -r $$1 %^mouse.x %^mouse.y
  }
}
alias -l lag.send { if ($server != $null) { .raw privmsg $me :T $ticks  } }
menu menubar,status,query,channel {
  $iif($acid == $true,• utilities)
  .lag meter:lag.setup
  $iif($acid != $true,lag meter):lag.setup
}
menu @Lag {
  dclick :{
    if ($window(@Lag).dh == 24) _vw lagmeter lag.size large
    if ($window(@Lag).dh == 135) _vw lagmeter lag.size small
    lag.open reset 
  }
  sclick :{
    if ( $inrect($mouse.x,$mouse.y,148,0,12,12) == $true ) {
      .timerlag off | window -c @Lag
      unset %mouse.x | unset %mouse.y
      _vw lagmeter set.lag.open off 
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
  mouse: { 
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
  if ($_vr(lagmeter,set.lag.open) == $null) { _vw lagmeter set.lag.open on }  
  if ($_vr(lagmeter,set.lag.open) == on) {
    %lag.num = 0 
    if ($_vr(lagmeter,set.lag.open) == on) { lag.open } 
    if ($timer(Lag) == $null) { lag.send | .timerLag 0 $_vr(lagmeter,set.lag.delay) lag.send }
  }
}
ctcp *:t:*: {
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
  else { window -c @Lag | .timerlag off | _vw lagmeter set.lag.open off  }
}
;[read write data/setting.ini]
alias _vr {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  return $readini data\setting.ini $1 $2 
}
alias _vw {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  writeini data\setting.ini $$1 $$2 $$3-
}
alias lag.setup { if ($dialog(lagsetup) == $null) { dialog -m lagsetup lagsetup } }
dialog lagsetup {
  title "lag meter setup v1.64"
  size -1 -1 89 87
  option dbu
  tab "setup", 5, 3 1 83 83
  check "on top", 4, 19 53 26 10, tab 5
  check "start on connect", 3, 19 44 50 10, tab 5
  text "delay time", 2, 19 33 25 8, tab 5
  edit "", 1, 48 32 18 10, tab 5
  check "", 6, 47 18 34 10, tab 5 push
  check "mini", 7, 19 62 26 10, tab 5
  check "enable", 8, 10 18 26 10, tab 5
  tab "about", 9
  text "version: 1.64", 10, 8 36 33 8, tab 9
  text "author: BlkWidow, KnightFal", 11, 8 44 73 8, tab 9
  link "team-nexgen.com", 12, 16 59 62 8, tab 9
  button "ok", 13, 33 74 21 8, ok
}
on *:dialog:lagsetup:init:*:{
  if ($_vr(lagmeter,lag.size) == $null) { _vw lagmeter lag.size large }
  if ($_vr(lagmeter,lag.size) == small) { did -c lagsetup 7 }
  if ($_vr(lagmeter,set.lag.open) == on) { did -c lagsetup 8 }
  if ($timer(Lag) == $null) { did -c lagsetup 2 | did -o lagsetup 6 1 unpaused }
  else { did -u lagsetup 2 | did -o lagsetup 6 1 paused }
  if ($_vr(lagmeter,set.lag.delay) != $null) { did -o lagsetup 1 1 $_vr(lagmeter,set.lag.delay) }
  else { _vw lagmeter set.lag.delay 5 }
  if ($_vr(lagmeter,set.lag.open) == on) { did -c lagsetup 3 }
  if ($_vr(lagmeter,set.lag.top) == yes) { did -c lagsetup 4 }
}
on *:dialog:lagsetup:edit:*:{
  if ($did == 1) {  
    if ($did(lagsetup,1).text isnum) {
      if ($did(lagsetup,1).text != $null) { _vw lagmeter set.lag.delay $did(lagsetup,1).text }
    }
    else { did -r lagsetup 1 } 
  }
} 
on *:dialog:lagsetup:sclick:*:{
  if ($did == 4) { 
    if ($_vr(lagmeter,set.lag.top) == yes) { _vw lagmeter set.lag.top no }
    else { _vw lagmeter set.lag.top yes }
    lag.open reopen   
  }
  if ($did == 6) { 
    if ($timer(Lag) != $null) { .timerlag off | did -o lagsetup 6 1 paused }
    else { lag.send | .timerLag 0 $_vr(lagmeter,set.lag.delay) lag.send | did -o lagsetup 6 1 unpaused }
  }
  if ($did == 7) { 
    if ($_vr(lagmeter,lag.size) == small) { _vw lagmeter lag.size large }
    else { _vw lagmeter lag.size small }
    lag.open reset
  }
  if ($did == 8) { 
    if ($_vr(lagmeter,set.lag.open) == on) { _vw lagmeter set.lag.open off | .timerlag off | window -c @Lag }
    else { _vw lagmeter set.lag.open on | lag.open }
  }
  if ($did == 3) { 
    if ($_vr(lagmeter,set.lag.open) == on) { _vw lagmeter set.lag.open off }
    else { _vw lagmeter set.lag.open on }
  }
}
