menu Status,menubar {
  quickbar
  .load:bar | click
  .switch  $lop
  ..$lop2 :  if ($_vr(nexbar,switch) == on) { _vw nexbar switch off | baroff | window -c @nexbar } | else {  _vw nexbar switch on | bar } | click
  .keep on top $chr(91) $+ $_vr(nexbar,ontop) $+ $chr(93)
  ..enable: _vw nexbar ontop on | bar
  ..disable: _vw nexbar ontop off | bar
  .movable $chr(91) $+ $_vr(nexbar,move) $+ $chr(93)
  ..enable: _vw nexbar move on | bar
  ..disable: _vw nexbar move off | bar
}
alias -l move@nexbar {
  if ($window(@nexbar)) {
    window @nexbar $calc($mouse.dx -$1) $calc($mouse.dy -$2)
    if ($mouse.key & 1) {
      %nexbar.x = $calc($mouse.dx -$1) | %nexbar.y = $calc($mouse.dy -$2)
      .timer@nexbar -o 1 0 move@nexbar $1-
    }
  }
}
alias -l lop {
  if ($_vr(nexbar,switch) == off) { return $chr(91) $+ off $+ $chr(93) }
  else { return $chr(91) $+ on $+ $chr(93) } 
}
on *:appactive: {
  if ($_vr(nexbar,ontop) == on) {
    if ($appactive == $false) { window -hnp +L @nexbar | halt }
    else { ac.ch }
  }
}
alias -l ac.ch  {
  if ($appactive == $true) { 
    if ($_vr(nexbar,ontop) == on) {
      window -c @nexbar 

      if (%nexbar.hide != off)  { window -doapfh +bnL @nexbar %nexbar.x %nexbar.y 566 33 @nexbar }
      else { window -darp +lbn @nexbar %nexbar.x %nexbar.y 560 30 @nexbar }
    }
    set %bar_T $window(@nexbar).w / 2 | %bar_T = %bar_T - 48 | if ( %bar_T < 385 ) { set %bar_T 385 }
    drawpic @nexbar 0 0 $skin.path2($bar2)
    window -a @nexbar
    if ($skin.path2(bar3.jpg) != $null) { set %bar_J $window(@nexbar).w | %bar_J = %bar_J - 156 | drawpic @nexbar %bar_J 0 $skin.path2(bar3.jpg) }
    elseif ($skin.path2(bar3.png) != $null) { set %bar_J $window(@nexbar).w | %bar_J = %bar_J - 156 | drawpic @nexbar %bar_J 0 $skin.path2(bar3.png) }
    elseif ($skin.path2(bar3.bmp) != $null) { set %bar_J $window(@nexbar).w | %bar_J = %bar_J - 156 | drawpic @nexbar %bar_J 0 $skin.path2(bar3.bmp) }
    bodef 284 %bar.p1 | bodef 318 %bar.p2 | bodef 350 %bar.p3
    window -a @nexbar
  }
}
alias -l bar1 {
  if ($findfile($skin.path,bar1.jpg,1) != $null) { return " $+ $skin.path $+ bar1.jpg $+ " }
  elseif ($findfile($skin.path,bar1.png,1) != $null) { return " $+ $skin.path $+ bar1.png $+ " }
  elseif ($findfile($skin.path,bar1.bmp,1) != $null) { return " $+ $skin.path $+ bar1.bmp $+ " }
  else return " $+ $findfile($mircdir,bar1.jpg,1) $+ " 
} 
alias -l bar2 {
  if ($findfile($skin.path,bar2.jpg,1) != $null) { return " $+ $skin.path $+ bar2.jpg $+ " }
  elseif ($findfile($skin.path,bar2.png,1) != $null) { return " $+ $skin.path $+ bar2.png $+ " }
  elseif ($findfile($skin.path,bar2.bmp,1) != $null) { return " $+ $skin.path $+ bar2.bmp $+ " }
  else return " $+ $findfile($mircdir,bar2.jpg,1) $+ "

} 
alias -l bar3 {
  if ($findfile($skin.path,bar3.jpg,1) != $null) { return $skin.path $+ bar3.jpg }
  elseif ($findfile($skin.path,bar3.png,1) != $null) { return " $+ $skin.path $+ bar3.png $+ " }
  elseif ($findfile($skin.path,bar3.bmp,1) != $null) { return " $+ $skin.path $+ bar3.bmp $+ " }
  else return " $+ $findfile($mircdir,bar3.jpg,1) $+ "
} 
alias -l skin.path2 {
  ;  if ($exists($skin.path $+ $1) == $false) { return $shortfn($findfile($mircdir,$1,1)) }
  return $1
} 
alias -l lop2 {
  if ($_vr(nexbar,switch) == off) { return $chr(91) $+ on $+ $chr(93) }
  else { return $chr(91) $+ off $+ $chr(93) } 
}
alias bar {
  if ($_vr(nexbar,move) == $null) { _vw nexbar move off }  
  if (%nexbar.x == $null) || (%nexbar.y == $null) { %nexbar.x = 0 | %nexbar.y = 101 }
  if ($_vr(nexbar,ontop) == $null) { _vw nexbar ontop off }  
  if ($_vr(nexbar,switch) != off) { 
    if ($_vr(nexbar,ontop) == off) { sclick }
    if (%nexbar.x == $null) || (%nexbar.y == $null) { %nexbar.x = 0 | %nexbar.y = 0 }   
    window -c @nexbar
    if ($_vr(nexbar,ontop) != on) {
      if (%nexbar.hide != off) { window -ahrph +bnL @nexbar 0 0 566 33 @nexbar }
      else { window -arp +lbn @nexbar 0 0 560 30 @nexbar }
    }
    elseif ($_vr(nexbar,ontop) == on) {
      if (%nexbar.hide != off)  { window -doapfh +bnL @nexbar %nexbar.x %nexbar.y 566 33 @nexbar }
      else { window -darp +lbn @nexbar %nexbar.x %nexbar.y 560 30 @nexbar }
    }
    ;drawpic -s @nexbar 0 0 1024 30 $skin.path2(bar1.jpg)
    set %bar_T $window(@nexbar).w / 2 | %bar_T = %bar_T - 48 | if ( %bar_T < 385 ) { set %bar_T 385 }
    drawpic @nexbar 0 0 $skin.path2($bar2) 
    window -a @nexbar
    set %bar_J $window(@nexbar).w | %bar_J = %bar_J - 156 
    drawpic @nexbar %bar_J 0 $skin.path2($bar3) 
    bodef 284 %bar.p1 | bodef 318 %bar.p2 | bodef 350 %bar.p3
    window -a @nexbar
  }
}
alias baroff {
  click
  window -c @nexbar
  if (%nexbar.hide == on) {  window -hrp +bn @nexbar 0 0 34 30 @nexbar }
  else {  window -rp +bn @nexbar 0 0 34 30 @nexbar }
  drawpic -s @nexbar 0 0 $skin.path2($bar2) 
  _vw nexbar switch off
  window -a @nexbar
}
menu @nexbar {
  sclick: {
    if ($_vr(nexbar,move) == on) { move@nexbar $calc($mouse.dx -$window(@nexbar).x) $calc($mouse.dy -$window(@nexbar).y) }
    ;[location find]    
    ;if ($mouse.key & 1) { echo -s x: $mouse.x y: $mouse.x  }  
    ;[end]
    if ($inrect($mouse.x,$mouse.y,1,1,25,25)) {  if ($_vr(nexbar,switch) == off ) {  _vw nexbar switch on | bar | bartit  }
    else baroff  }
    if ($inrect($mouse.x,$mouse.y,55,1,25,25)) { click | cp }
    if ($inrect($mouse.x,$mouse.y,87,1,25,25)) { click | soundcon }
    if ($inrect($mouse.x,$mouse.y,121,1,25,25)) { click | aj }
    if ($inrect($mouse.x,$mouse.y,153,1,25,25)) { scriptman | click }
    if ($inrect($mouse.x,$mouse.y,178,1,25,25)) { click | sonica }
    if ($inrect($mouse.x,$mouse.y,203,1,25,25)) { click | du }
    if ($inrect($mouse.x,$mouse.y,231,1,25,25)) { click | backg }
    if ($inrect($mouse.x,$mouse.y,266,1,25,25)) { click | colortheme }
    if ($inrect($mouse.x,$mouse.y,296,1,25,25)) { click | downloadlist }
    if ($inrect($mouse.x,$mouse.y,333,1,25,25)) { 
      if ($script(nexcam.mrc) != $null) { click | frmNexCam.Load } 
      else { echo -s 4error: nexcam is not loaded }
    }    
    if ($inrect($mouse.x,$mouse.y,366,1,25,25)) { click | about }
    ;if ($inrect($mouse.x,$mouse.y,411,1,150,25)) { about }
    if ($inrect($mouse.x,$mouse.y,360,1,25,25)) {
      click
      if (%nexbar.hide == on) { set %nexbar.hide [off]  | _vw nexbar switch on | bar }
      else { set %nexbar.hide on | bar }
    }
    if ($inrect($mouse.x,$mouse.y,378,1,25,25)) { click |  echo [not defined] }
  }
  acidmax quickbar 
  .[buttons]:halt 
  .-
  .(1) Minimize:halt
  .(2) Control Panel:cp
  .(3) Audio Settings:soundcon
  .(4) Auto-join:aj
  .(5) Script Manager:scriptman
  .(6) Sonica:sonica
  .(7) Direct Update Check:du
  .(8) Background:backg
  .(9) Event Theme:colortheme
  .(10) DCC Log:dcclog
  .(11) About Acidmax:about
  .-
  .[switches]:/halt 
  .-
  .keep on top $chr(91) $+ $_vr(nexbar,ontop) $+ $chr(93)
  ..enable: _vw nexbar ontop on | bar
  ..disable: _vw nexbar ontop off | bar
  .movable $chr(91) $+ $_vr(nexbar,move) $+ $chr(93)
  ..enable: _vw nexbar move on | bar
  ..disable: _vw nexbar move off | bar
  .close: window -c @nexbar | click
  .disable toolbar: baroff | window -c @nexbar | click
}
alias bartit {
  if ( $window(@nexbar).state == normal ) {
    drawpic -s @nexbar %bar_J 0 $skin.path2($bar3) 
    if $len(%uson) < 1 return
    drawtext -c @nexbar 1 Arial 14 $calc(%bar_J + 18) -1 140 20 $nopath(%uson)
  }  
}
alias bodef {
  set %bar21 $width($gettok($$2-,1,231),arial,12,1,0) | if %bar21 > 28 { drawtext -c @nexbar 5 Arial 12 $$1 18 28 20 $gettok($$2-,1,231) | unset %bar21 | return }
  set %bar21 $calc($$1 + 16 - $calc(%bar21 / 2) ) | drawtext -c @nexbar 5 Arial 12 %bar21 18 28 20 $gettok($$2-,1,231) | unset %bar21
}
on *:start: { 
  if ($_vr(nexbar,switch) == $null) { _vw nexbar switch on  } 
  bar
}
on *:connect: if ($_vr(nexbar,switch) == on) { bar }
