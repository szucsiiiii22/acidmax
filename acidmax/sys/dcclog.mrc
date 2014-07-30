menu menubar,status,query,channel {
  download list:downloadlist
}
alias downloadlist {
  if ($dialog(downloadlist) == $null) { $downloadlist.dialog }
}
dialog downloadlist {
  title "download list v1.32"
  size -1 -1 320 409
  option pixels
  list 1, 10 24 300 256, size hsbar vsbar
  edit "", 2, 134 360 108 21, read
  button "delete", 3, 251 354 60 17, disable
  button "run", 4, 251 310 60 17, disable
  button "go location", 6, 251 332 60 17, disable
  edit "", 7, 10 285 300 21, read
  text "creation date", 8, 136 345 52 14
  edit "", 11, 5 359 125 21, read
  text "file size", 12, 7 344 35 14
  edit "", 13, 135 321 108 21, read
  text "last modifcation date", 14, 137 306 98 14
  button "erase list", 15, 247 386 67 17
  check "enable", 16, 14 1 68 20
  check "open dialog at dcc completion", 17, 10 381 164 20
  box "quick view", 20, 328 20 364 388
  icon 21, 338 37 344 360
  edit "", 5, 7 321 124 21, read
  text "sender", 9, 9 306 39 14
  check "always on top", 10, 223 1 93 20
  button "Button", 18, 55 470 75 25, ok
}

on *:dialog:downloadlist:init:*:{
  if ($_vr(downloadlist,switch) == $null) { _vw downloadlist switch on | _vw downloadlist open on }
  if ($_vr(downloadlist,switch) == on) { did -c downloadlist 16 }
  if ($_vr(downloadlist,open) == on) { did -c downloadlist 17 }
  if ($_vr(downloadlist,ontop) == on) { did -c downloadlist 10 } 
  rdown
  did -z downloadlist 1
}
alias -l big {
  dialog -s downloadlist -1 -1 700 413
  did -g downloadlist 21 $shortfn($did(downloadlist,1).seltext)
  sclick
}
alias -l small {
  dialog -s downloadlist -1 -1 320 413
}
on *:dialog:downloadlist:dclick:*:{
  if ($did == 1) { 
    if ($fx == mrc) || ($fx == ini) { load -rs $findfile($shortfn($nofile($did(1,$did(1).sel))),$nopath($did(1,$did(1).sel)),1) }
    elseif ($fx == mp3) || ($fx == wav) || ($fx == mid) { splay $shortfn($did(1,$did(1).sel)) }
    else { run $shortfn($did(1,$did(1).sel)) }
  }
}
alias -l fx { return $right($nopath($did(1,$did(1).sel)),3) }
on *:dialog:downloadlist:sclick:*:{
  if ($did == 1) { 
    did -e downloadlist 3,4,6  
    did -o downloadlist 7 1 $nopath($did(1,$did(1).sel)) 
    did -o downloadlist 2 1 $asctime($file($did(1,$did(1).sel)).ctime,hh:nntt m-dd-yy) 
    did -o downloadlist 13 1 $asctime($file($did(1,$did(1).sel)).mtime,hh:nntt m-dd-yy) 
    did -o downloadlist 5 1 $readini(data\downlog.ini,$shortfn($did(downloadlist,1).seltext),sender) 
    did -o downloadlist 11 1 $file($did(1,$did(1).sel)).size $+ kb( $+ $round($calc($file($did(1,$did(1).sel)).size / 1048576),2) mb)
    if ($fx == mrc) || ($fx == ini) { did -o downloadlist 4 1 load script } 
    elseif ($fx == txt) || ($fx == nfo) || ($fx == doc) || ($fx == gif) || ($fx == jpg) || ($fx == png) { did -o downloadlist 4 1 view } 
    elseif ($fx == wav) || ($fx == mp3) || ($fx == mid) { did -o downloadlist 4 1 play }     
    else { did -o downloadlist 4 1 run } 
    if ($fx == bmp) || ($fx == jpg) || ($fx == png) { big }  
    else  { small }   
  }
  if ($did == 3) { downloadlist.del } 
  if ($did == 4) { 
    if ($fx == mrc) || ($fx == ini) { load -rs $findfile($shortfn($nofile($did(1,$did(1).sel))),$nopath($did(1,$did(1).sel)),1) }
    elseif ($fx == mp3) || ($fx == wav) || ($fx == mid) { splay " $+ $did(downloadlist,1).seltext $+ " }
    else { run " $+ $did(downloadlist,1).seltext $+ " }
  } 
  if ($did == 6) { run $nofile($did(1,$did(1).sel)) }
  if ($did == 10) { 
    if ($_vr(downloadlist,ontop) == on) { _vw downloadlist ontop off | dialog -x downloadlist downloadlist | .timer -m 1 1 downloadlist }
    else { _vw downloadlist ontop on | dialog -x downloadlist downloadlist | .timer -m 1 1 downloadlist }  
  }
  if ($did == 15) { write -c $shortfn(data\downlog.txt) | write -c $shortfn(data\downlog.ini) | did -r downloadlist 1 }
  if ($did == 16) {
    if ($_vr(downloadlist,switch) == on) { _vw downloadlist switch off }
    else { _vw downloadlist switch on }  
  }
  if ($did == 17) {
    if ($_vr(downloadlist,open) == on) { _vw downloadlist open off }
    else { _vw downloadlist open on }  
  }
}
on *:filercvd:*: {
  if ($_vr(downloadlist,switch) == $null) { _vw downloadlist switch on | _vw downloadlist open on }
  if ($_vr(downloadlist,switch) == on) { 
    $ae  » $+ $colour(info) $+ » Received $filename [ $+ $file($filename).size bytes( $+ $round($calc($file($filename).size / 1048576),2) megs)] from $nick $fulladdress via DCC.  
    if ($exists(data\downlog.txt) == $false) || ($exists(data\downlog.ini) == $false) { write -c data\downlog.ini | write -c data\downlog.txt }
    if ($read(data\downlog.txt, w, * $+ $shortfn($filename) $+ *) != $null) { write -ds $+ $shortfn($filename) data\downlog.txt | write -il data\downlog.txt $shortfn($filename) | writeini data\downlog.ini $shortfn($filename) sender $nick }
    else { write -i1 data\downlog.txt $shortfn($filename) | writeini data\downlog.ini $shortfn($filename) sender $nick }
    if ($dialog(downloadlist) != $null) { rdown } 
    if ($_vr(downloadlist,open) == on) { .timer 1 1 downloadlist }
  }
}
alias -l rdown {
  did -r downloadlist 1 
  did -b downloadlist 3,4,6 
  did -o downloadlist 4 1 run 
  var %y = $lines(data\downlog.txt)
  var %y1 = 1
  while (%y1 <= %y) { 
    if ($exists($shortfn($read($shortfn(data\downlog.txt),%y1))) == $true) { did -a downloadlist 1 $longfn($read($shortfn(data\downlog.txt),%y1)) }
    elseif ($exists($shortfn($read($shortfn(data\downlog.txt),%y1))) == $false) { write -dl $+ %y1 $shortfn(data\downlog.txt) }
    inc %y1 
  }
}
alias -l downloadlist.del { set -q %del $iif($$?!="delete this file?" == $true,yes,no) | downloadlistdel }
alias -l downloadlistdel {
  if (%del == yes) { remove $shortfn($did(1,$did(1).sel))  | unset %del | .timer 1 1 rdown } 
  else { unset %del }
  .timer 1 1 rdown
}
alias -l downloadlist.dialog {
  if ($_vr(downloadlist,ontop) == on) { return dialog -m downloadlist downloadlist }
  else return dialog -md downloadlist downloadlist
}
