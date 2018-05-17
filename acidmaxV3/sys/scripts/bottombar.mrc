on *:start: { bottombar }
alias bottombar {
  if (!$dialog(bottombar)) { dialog -m bottombar bottombar }
}
alias udock { 
  if ($isid) return $dll(sys/dlls/ultradock.dll,$1,$2-)
  else dll sys/dlls/ultradock.dll $1 $2-
}
alias wetbar {
  set %wetbar.forecastDetailsPlacement 0
  set %wetbar.forecastReceive 0
  set %wetbar.locationAmount 0
  set %wetbar.receive 1
  if (%wetbarloc == $null) { %wetbarloc = 97103 } 
  if ($exists($shortfn($scriptdir $+ wetbar.txt))) { write -c $shortfn($scriptdir $+ wetbar.txt) }
  sockclose wetbar*
  sockopen wetbar printer.wunderground.com 80
  sockopen wetbar.forecast wunderground.com 80
}

dialog bottombar {
  title "bottombar"
  size -1 -1 504 35
  option dbu
  icon 33, 62 7 18 16
  text "", 34, 81 8 53 7, center
  text "", 36, 80 15 54 7, center
  box "weather", 14, 59 0 77 26
  text "", 2, 59 26 72 8, center
  icon 3, 6 10 47 15,  sys\img\acidmax.bmp, 0
  box "", 4, 2 0 56 7
  icon 5, 139 7 20 16,  sys\img\icons\ram.ico, 0
  box "memory stats", 6, 137 0 69 34
  text "memory used:", 7, 160 6 36 8
  text "", 8, 140 25 63 8, center
  text "", 9, 161 16 42 6
  text "", 10, 5 26 49 8, center
  edit "", 11, 208 1 76 10, read
  edit "", 12, 208 12 76 10, read
  edit "", 13, 208 23 76 10, read
  button "Button", 1, 289 13 78 13
  box "lag", 15, 287 0 82 34
  text "current", 16, 290 6 25 8
  text "average", 17, 290 25 25 8
  button "Button", 18, 374 8 60 11
  box "audio player", 19, 371 0 127 34
  list 20, 374 21 73 10, size
  edit "", 21, 436 9 59 9, read
}

alias audio_sel { 
  if (!$isfile(sys\dlls\fmod\bin\fmod.dll)) { echo -s ERROR | halt } 
  var %file = $+(",$sfile(C:\,Choose a mp3 $+ $chr(44) $+ ogg $+ $chr(44) $+ wav(sound file) to stream,Play It),")

  $fmod(SOUND_Sample_Load,2 " $+ %file $+ " 2 $file(%file).size)

  $fmod(SOUND_PlaySound,2 1)

  $fmod(Plugin_Load,1 " $+ sys\dlls\fmod\bin\plugins\fmm_util_spectrum.dll $+ ")
  ;send
  $fmod(Plugin_Send,1 Spectrum 1 1 @fmod_ogg_spect 25)
  $fmod(Plugin_Send,1 Spectrum 1)
  .timerfschoose -m 0 35 writespec2


}

alias writespec2 { 
  clear -n @fmod_ogg_spect
  ; var %x = 1 , %i = 0 , %color = $rgb(210,210,210)
  var %x = 1 , %i = 0 , %color = $rgb(223,223,223)
  while (%i < 128) { 
    ; var %result =                                         $fmod(Plugin_Send,1 Spectrum_addR %i $calc(%i +4))
    ; var %result = $calc(%result * -6)
    var %result = $fmod(Plugin_Send,1 Spectrum_add %i $calc(%i +4))
    var %result = $round($calc(%result * -6))
    drawrect -fnr @fmod_ogg_spect %color 1 %x 23 3 %result 
    inc %i 5 
    inc %x 4 
  }
  drawdot @fmod_ogg_spect
}

alias -l bars { return sys\dlls\bars.mdx }
on *:dialog:bottombar:init:0:{
  wetbar
  mdx MarkDialog $dname $dialog($dname).hwnd

  ;mdx SetDialog $dname style
  mdx SetBorderStyle $dname 20
  mdx SetControlMDX 20 toolbar flat nodivider arrows > sys\dlls\bars.mdx

  mdx SetControlMDX 9 ProgressBar smooth > sys\dlls\ctl_gen.mdx
  mdx SetControlMDX 9 Text right > sys\dlls\ctl_gen.mdx
  mdx SetControlMDX $dname 1,18 window > sys\dlls\dialog.mdx
  window -hp @lag 0 0 78 13

  window -apdoCh @fmod_ogg_spect 0 0 115 53  
  did -a $dname 1 grab $window(@lag).hwnd @lag
  did -a $dname 18 grab $window(@fmod_ogg_spect).hwnd @fmod_ogg_spect

  ; did -a $dname 9 bgcolor $color($color(back))
  dll sys\dlls\UltraDock.dll Dock -1 $dialog(bottombar).hwnd bottom bottombar 
  .timeruptime 0 1 uptime2
  statsbar 
  .timerstats 0 20 statsbar
  .timerwetbar 0 3600 wetbar
  if (!$window(@fmod_ogg_spect)) { window -apdoC @fmod_ogg_spect 0 0 115 53 }
  mdx SetColor $dname 9, background $rgb(0,0,0) 

  did -r $dname 20
  did -i $dname 20 1 bmpsize 16 16
  did -i $dname 20 1 setimage icon small 0, $+ $shortfn(sys\img\icons\mp3.icl)
  did -i $dname 20 1 setimage icon small 2, $+ $shortfn(sys\img\icons\mp3.icl)
  did -i $dname 20 1 setimage icon small 1, $+ $shortfn(sys\img\icons\mp3.icl)
  did -i $dname 20 1 setimage icon small 3, $+ $shortfn(sys\img\icons\mp3.icl)
  did -i $dname 20 1 setimage icon small 4, $+ $shortfn(sys\img\icons\mp3.icl)
  did -i $dname 20 1 setimage icon small 5, $+ $shortfn(sys\img\icons\mp3.icl)

  did -a $dname 20 1 $chr(9) $+ stop 
  did -a $dname 20 2 $chr(9) $+ play
  did -a $dname 20 3 $chr(9) $+ pause
  did -a $dname 20 4 $chr(9) $+ prev
  did -a $dname 20 5 $chr(9) $+ skip
  did -a $dname 20 6 $chr(9) $+ info 

}

alias -l uptime2 {
  did -o bottombar 11 1 online: $uptime(server,1)
  did -o bottombar 12 1 uptime: $uptime(system,2)
  did -o bottombar 13 1 idle: $duration($idle)
}

alias -l statsbar {
  did -a bottombar 9 $round($dll(sys\dlls\moo.dll,rambar,_),0) 0 100
  did -o bottombar 8 1 $mem
  did -o bottombar 10 1 $strip($nver $+ $build)
}

on *:dialog:bottombar:sclick:*:{
  if ($did == 20) {
    var %x $did($dname,20).sel
    if (%x == 2) {
      $fmod(SOUND_StopSound,2)
      $fmod(SOUND_Sample_Free,2)
      $fmod(Plugin_Send,1 Spectrum off)
      $fmod(Plugin_Send,1 Set_CShift 0)
      $fmod(Plugin_UnLoad,1)
      $fmodm_stype
    }
    if (%x == 3) { audio_sel }
  }

}

alias wetbarloc { if (!$dialog(wetbarloc)) { dialog -m wetbarloc wetbarloc } }

dialog wetbarloc {
  title "weather location"
  size -1 -1 110 43
  option dbu
  edit "", 1, 9 15 91 10, return
  text "enter zipcode or city, state or city, country:", 2, 2 4 114 8
  button "enter", 3, 36 27 37 12, ok
}
on *:dialog:wetbarloc:sclick:*:{
  if ($did == 3) && ($did(wetbarloc,1).text != $null) { %wetbarloc = $replace($did(wetbarloc,1).text,$chr(32),+) | .timer -m 1 1 wetbar } 
  elseif ($did == 3) && ($did(wetbarloc,1).text == $null) { halt }
}
on *:SOCKOPEN:wetbar.forecast:{ 
  if (%wetbar.specifyLocation != 1) {
    sockwrite -n $sockname GET /cgi-bin/findweather/getForecast?query= $+ %wetbarloc HTTP/1.0
  }
  else {
    sockwrite -n $sockname GET %wetbarloc HTTP/1.0
    unset %wetbar.specifyLocation
  }
  sockwrite -n $sockname Host: www.wunderground.com
  sockwrite -n $sockname Connection: close
  sockwrite -n $sockname $crlf
} 

on *:sockread:wetbar.forecast:{
  if ($sockerr) {
    echo -a Error.
    halt
  }
  else {
    var %temptext
    sockread %temptext
    ;    if (*Location* iswm %temptext) { if (*Location:* iswm $nohtml(%temptext)) { did -e bottombar 46 | set %wetbar.receivePWeather 1 | write $shortfn($scriptdir $+ PWeather.txt) $nohtml(%temptext) } }
    if (*<nobr><b>* iswm %temptext) || (*<td align="center" bgcolor="#ffffff"><div class="smalltext">* iswm %temptext) && (%wetbar.receivePWeather == 1) { set %wetbar.PWeatherTemp %wetbar.PWeatherTemp $nohtml(%temptext) }
    if (*<tr bgcolor="#d3d3d3">* iswm %temptext) && (%wetbar.receivePWeather == 1) { write $shortfn($scriptdir $+ PWeather.txt) %wetbar.PWeatherTemp | unset %wetbar.PWeatherTemp | set %wetbar.receivePWeather 0 }
    if (%wetbar.specifyLocation == 1) && (*<td><a href="/* iswm %temptext) {
      inc %wetbar.locationAmount
      set %wetbar.locationHref. [ $+ [ %wetbar.locationAmount ] ] $gettok(%temptext,2,34)
      set %wetbar.locationName. [ $+ [ %wetbar.locationAmount ] ] $nohtml(%temptext)
    }
    if (*Search results for: * iswm %temptext) { set %wetbar.specifyLocation 1 }
    if (*City Not Found* iswm %temptext) { set %wetbar.unknown 1 }
    if (*</a></font></th>* iswm %temptext) && (*weekday* iswm %temptext) { 
      inc %wetbar.forecastDetailsPlacement
      set %wetbar.forecastDetails. [ $+ [ %wetbar.forecastDetailsPlacement ] ] www.wunderground.com $+ $gettok(%temptext,2,34)
    }
    if (*5-Day Forecast for ZIP Code* iswm %temptext) { set %wetbar.forecastReceive 1 }
    if (*Click <b>Detail</b>* iswm %temptext) && (%wetbar.forecastReceive == 1) { set %wetbar.receive 0 }
    if (*border=1 width=44 height=44>* iswm %temptext) { did -g bottombar 33 $findfile(sys\img\,$replace($gettok($gettok(%temptext,2,34),-1,47),.gif,.bmp),1) }
    if (*<td valign=top align=center ><img src="http://icons.wunderground.com/graphics/conds/* iswm %temptext) && (%wetbar.forecastReceive == 1) { 
      inc %wetbar.forecastHiLoPlacement 2
      ;      did -g bottombar %wetbar.forecastPicPlacement $findfile(sys\img\),$replace($gettok($gettok(%temptext,2,34),-1,47),.gif,.bmp),1)
      ;      did -a bottombar %wetbar.forecastHiLoPlacement $replace($nohtml(%temptext),&deg;,°F)
      inc %wetbar.forecastPicPlacement 2
    }
    if (*<td valign=top align=center class=smalltable >* iswm %temptext) {
      inc %wetbar.forecastInfoPlacement
      ;      did -a bottombar %wetbar.forecastInfoPlacement $nohtml(%temptext) 
    }
    if (*<th valign=middle class=smalltable width="20%" bgcolor=#DDDDDD>* iswm %temptext) && (%wetbar.forecastReceive == 1) {
      inc %wetbar.forecastDayPlacement
      ;      did -a bottombar %wetbar.forecastDayPlacement $nohtml(%temptext)
    }
  }
}
ON *:SOCKOPEN:wetbar:{ 
  if (%wetbar.specifyLocation != 1) {
    sockwrite -n $sockname GET /cgi-bin/findweather/getForecast?query= $+ %wetbarloc HTTP/1.0
  }
  else {
    sockwrite -n $sockname GET %wetbarloc HTTP/1.0
  }
  sockwrite -n $sockname Host: printer.wunderground.com
  sockwrite -n $sockname Connection: close
  sockwrite -n $sockname $crlf
} 
on *:sockread:wetbar:{
  if ($sockerr) {
    echo -a Error.
    halt
  }
  else {
    var %temptext
    sockread %temptext

    if (%wetbar.getTemp == 1) && (*<b>*</b>&nbsp;&#176;F* iswm %temptext) {
      set %wetbar.tempCache $remove($replace($nohtml(%temptext),&#176;F,°F),&nbsp;)
    }
    if (%wetbar.getTemp == 1) && (*<b>*</b>&nbsp;&#176;C* iswm %temptext) {
      did -a bottombar 34 %wetbar.tempCache $chr(47) $remove($replace($nohtml(%temptext),&#176;C,°C),&nbsp;)
      unset %wetbar.tempCache
      unset %wetbar.getTemp
    }
    if (%wetbar.getCond == 1) && (*<td><b>*</b></td></tr>* iswm %temptext) {
      did -a bottombar 36 $nohtml(%temptext)
      unset %wetbar.getcond
    }
    if (%wetbar.getVis == 1) && (*<b>*</b>&nbsp;miles* iswm %temptext) {
      set %wetbar.visCache $remove($nohtml(%temptext),&nbsp;)
    }
    if (%wetbar.getVis == 1) && (*<b>*</b>&nbsp;kilometers* iswm %temptext) {
      unset %wetbar.getVis
      unset %wetbar.visCache
    }
    if (*<td>Temperature</td>* iswm %temptext) { set %wetbar.getTemp 1 }

    if (*<td>Conditions</td>* iswm %temptext) { set %wetbar.getCond 1 }
    if (*<title>* iswm %temptext) { 
      did -o bottombar 2 1 $remove($nohtml(%temptext),Printer Friendly WUI -,Forecast)  
    }
    if (*<th colspan=4>Temperature</th>* iswm %temptext) { set %wetbar.receive 0 }
  }
}
on *:sockclose:wetbar*:{
  if (%wetbar.unknown == 1) { 
    dialog -o bottombar 2 1 Unknown Location
    unset %wetbar.unknown 
    halt 
  }
  if ($len($did(bottombar,33)) == 2) { did -g bottombar 33 sys\img\ $+ unknown.bmp }
  if ($did(bottombar,34) == $null) { did -a bottombar 34 N/A }
  if ($did(bottombar,36) == $null) { did -a bottombar 36 N/A }
}

alias -l nohtml {
  var %tmp, %ignore = $regsub($1-,/(<[^>]+>)/g,$chr(32),%tmp)
  return $replace(%tmp,&nbsp;,$null)
}
alias -l mem {
  return $dll($adll, sys_info, memuse) 
}


alias lag.open {
  if ($_vr(lagmeter,lag.size) == $null) { _vw lagmeter lag.size small }
  if ($_vr(lagmeter,set.lag.open) == $null) { _vw lagmeter set.lag.open on }
  drawpic -n @Lag 11 1 11 1 31 22 " $+ $findfile($mircdir,lagmeter2.jpg,1) $+ "
  if ($_vr(lagmeter,set.lag.open) == on) { 
    if ($window(@Lag).x == $null) || ($1 == reset) || ($1 == reopen) { 
      if ($window(@Lag).x != $null) { %lag.x = $window(@Lag).x  | %lag.y = $window(@Lag).y }
      if (%lag.x == $null) { set %lag.x 566 } | if (%lag.y == $null) { set %lag.y 0 }
      if ($1 != reset) { set %lag.tot 0 | set %lag.num 0 | window -ahr +d @Lag %lag.x %lag.y 160 22 @Lag }
      if ($1 == reset) {

        ; window -doapf +f @Lag %lag.x %lag.y 160 22
        window -ahr +d @Lag %lag.x %lag.y 160 22
      }
      if (%lag.tot == 0) { set %lag.back $getdot(@Lag,80,70) }

      window -ahr +d @Lag %lag.x %lag.y 160 24 
      set %lag.small.back $getdot(@Lag,95,12)

      drawdot @Lag
    } 

    if ($_vr(lagmeter,set.lag.delay) !isnum) { _vw lagmeter set.lag.delay 5 }
    lag.send | .timerLag 0 $_vr(lagmeter,set.lag.delay) lag.send 

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

  $lag.menu.1 $+ : lag.open
  -
  &setup: lag.setup
}
raw 301:*: { if ($2 == $me) && ($timer(Lag) != $null) halt }
on *:connect: {
  %lag.num = 0 
  .timer 1 5 lag.open
}
on *:APPACTIVE: {
  lag.open  
  if ($appactive == $true) && ($server != $null) { window -ahr +d @Lag | .timerlmbr -o 2 1 lm.ch }
}

alias -l lm.ch  if ($appactive == $true) && ($server != $null) { window -ahr +d @Lag | .timerlmbr off }

ctcp *:t: {
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
  drawpic -nc @Lag 11 1 11 1 31 22 " $+ $findfile($mircdir,lagmeter2.jpg,1) $+ "
  ;drawline -rn @Lag %lag.back 3 147 26 147 105
  drawline -rn @Lag %^lag.color 3 147 %^lag.len 147 105
  drawpic -nc @Lag 11 1 11 1 31 22 " $+ $findfile($mircdir,lagmeter2.jpg,1) $+ "
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
