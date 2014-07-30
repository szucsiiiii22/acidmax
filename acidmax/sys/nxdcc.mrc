;Acidmax XDCC Server
;by KnightFal 2004
;www.team-nexgen.org
;knightfal@tnexgen.com

menu menubar,channel {
  .xdcc server:xdcc1
}
alias xr {
  if ($exists(data\xdcc.ini) == $false) { mkdir data | write -c data\xdcc.ini }
  return $readini data\xdcc.ini $$1 $$2 
}
alias -l xw {
  if ($exists(data\xdcc.ini) == $false) { mkdir data | write -c data\xdcc.ini }
  writeini data\xdcc.ini $$1 $$2 $$3-
}
alias -l xrem {
  if ($exists(data\xdcc.ini) == $false) { mkdir data | write -c data\xdcc.ini }
  remini data\xdcc.ini $$1- 
}
alias xdcc1 {
  if ($dialog(xdcc) == $null) { dialog -m xdcc xdcc }
} 
alias xdcc.stats {
  if ($xr(info,inforeq) == $null) { xw info inforeq 0 }
  echo -a  $c2 $+ $chr(91) $+ $c1 $+ xdcc server stats $+ $c2 $+ $chr(93) 
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Status : $+ $c1 $xr(info,switch)
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Packs: $+ $c1 $xr(packs,total) ( $+ $size.c($xr(info,totsizec)) $+ )
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Requested list: $+ $c1 $xr(info,access)
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Requested info: $+ $c1 $xr(info,inforeq)
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Files transfered: $c1 $+ ( $+ $xr(info,sent) files  $+ $c2 » $+ $c1 $size.c($xr(info,sizesent)) $+ )
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Current in Queue: $+ $c1 $chr(91) $+ $xr(info,oqueue) $+ / $+ $xr(info,queue) $+ $chr(93)
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Current Slots status: $+ $c1 $slots
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Current cps rec: $cps.rec
  echo -a $c1 $+ » $+ $c2 $+ » $+ $c2 Bandwidth usage: $tot.cps  Record: $xr(info,bwrecord)
  echo -a $logo 
}
alias -l tot.cps {
  var %p = 1
  :loop
  if (%p <= $send(0)) { var %tot = $calc(%tot + $send(%p).cps) | inc %p | goto loop }
  else { 
    if (%tot == $null) { return 0kb/s }
    else { return $size.c(%tot) $+ /s }
  }
}
alias -l xdcc_chkcps {
  if ($xr(info,switch) == on) {    
    .timer 1 2 forc.qcheck  
    var %xc = 1
    while (%xc <= $send(0)) {
      if ($send(%xc).cps < $xr(info,mincps)) {
        .notice $send(%xc) $logo1 Your DCC Transfer has dropped below the minimum of   $+ $xr(info,mincps) $+ cps and has been terminated.
        .notice $send(%xc) $logo1 You will not have access to the XDCC Server for the next 5 minutes.
        ignore -tu300 $send(%xc)    
        if ($xr(info,oqueue) => 1) { dcc send -c $read(data\xdccq.txt,1) $xr(pack $+ $read(data\xdccpk.txt,0),file) | xw info oslots $calc($xr(info,oslots) + 1) |  xw info oqueue $calc($xr(info,oqueue) - 1) }
        close -s $send(%xc)       
        .timer 1 1 xw info oslots $send(0).active
      }
      inc %xc
    }
    if ($send(0) = 0) { .timer50 off }   
  }
  else { .timer50 off }
} 
alias -l xdcc_add { 
  if ($xr(packs,total) != $null) { var %xp = $calc($xr(packs,total) + 1) }
  else { var %xp = 1 }
  if ($xr(setup,path) == $null) { xw pack $+ %xp file $$hfile="which file to add?" }
  else { xw pack $+ %xp file $$hfile="which file to add?" $xr(setup,path) }
  xw setup path $nofile($xr(pack $+ %xp,file))
  xw pack  $+ %xp short $shortfn($xr(pack $+ %xp,file))
  xw packs total  $calc($xr(packs,total) + 1)
  xw pack $+ %xp dl 0 
  did -a xdcc 2 $nopath($xr(pack $+ %xp,file))
  did -r xdcc 4,37
  did -o xdcc 25 1 0 
  did -b xdcc 6,78
  did -z xdcc 2
  did -o xdcc 19 1 $chr(91) $+ $xr(packs,total) $+ $chr(93) packs total.
  xw info date $asctime(mmmdd)
}
alias -l xdcc_edt {
  var %xp = $did(xdcc,2).sel 
  if ($xr(setup,path) == $null) { xw pack $+ %xp file $$hfile="which file to add?" }
  else { xw pack $+ %xp file $$hfile="which file to add?" $xr(setup,path) }
  %xdcc.z = pack $+ %xdcc.x 
  did -o xdcc 2 %xp $nopath($xr(pack $+ %xp,file))                      
  did -r xdcc 4,7
  did -o xdcc 2 1 0
  xw info date $asctime(mmmdd)
  did -b xdcc 6,78
}
alias -l  xdcc_del {
  xw info date $asctime(mmmdd)
  var %xp = 1
  while (%xp <= $xr(packs,total)) {
    xrem pack $+ %xp
    inc %xp 
  }
  did -r xdcc 2
  xw packs total 0
  did -b xdcc 6,78
}
alias -l xdcalc {
  var %xt = 1
  xw info totsize 0
  while (%xt <= $xr(packs,total)) { var %d = $calc($file($xr(pack $+ %xt,file)).size * $xr(pack $+ %xt,dl)) | xw info totsize $calc($xr(info,totsize) + %d) | inc %xt }
}
alias -l xdcalct {
  var %xc = 1
  var %d = 0  
  xw info totsizec 0
  while (%xc <= $xr(packs,total)) { var %d = $calc($file($xr(pack $+ %xc,file)).size + %d) | xw info totsizec $calc($xr(info,totsizec) + %d) | inc %xc }
}
alias -l reset {
  xw info switch off
  xw info bwrecord 0kb/s
  xw info sent 0
  xw info record 0
  xw info recorduser n/a
  xw info color1 14
  xw info color2 4
  xw randomcolor1 off
  xw randomcolor2 off
  write -c data\xdccchan.txt
  xw packs total 0
  xw info access 0
  xw info slots 0
  xw info oslots 0
  xw info sizesent 0
  xw info totsize 0
  xw info totsizec 0
  xw info inforeq 0
  xw info muqueue 2
}
alias -l restr {
  if  ($xr(info,sendvoiced) == on) && ($xr(info,sendops) != on) { return serving: $+ $c1 $+ (voiced users) }
  elseif  ($xr(info,sendvoiced) != on) && ($xr(info,sendops) == on) { return serving: $+ $c1 $+ (oped users) }
  elseif  ($xr(info,sendvoiced) == on) && ($xr(info,sendops) == on) { return serving: $+ $c1 $+ (oped/voiced users) }
}
alias -l tpost {
  if ($xr(info,delaypost) == $null) { xw info delaypost 350 }
  else { return 0 $xr(info,delaypost) } 
}
alias -l tpacks {
  if ($xr(info,delaypacks) == $null) { xw info delaypacks 6 }
  else { return $xr(info,delaypacks) } 
}
alias -l preview {
  window  @xdcc_preview
  clear @xdcc_preview  
  if ($xr(info,header) != $null) && ($xr(info,head) == on) { aline @xdcc_preview < $+ $me $+ > $c1 $+ » $+ $c2 $+ » $xr(info,header) }
  aline @xdcc_preview < $+ $me $+ > $c2 $+ xdcc server is $c1 $+ ( $+ $xr(info,switch) $+ )  $c2 $+ last updated: $+ $c1 $+ ( $+ $asctime(mmmdd) $+ ) $+ $c2 $+ $restr $c2 $+ pack(s): $+ $c1 $+ ( 5 $c2 $+ » $+ $c1 45.4mb $+ ) $c2 $+ slots: $+ $c1 $+ ( $+ $send(0) $+ / $+ $xr(info,slots) $+ ) $c2 $+ queue(s): $+ $c1 $+ ( $+ $xr(info,oqueue) $+ / $+ $xr(info,queue) $+ ) $c2 $+ min-cps: $+ $c1 $+ ( $+ $xr(info,mincps) $+ ) 
  aline @xdcc_preview < $+ $me $+ > $c1 $+ » $+ $c2 $+ » trigger commands: $c1 /msg $me xdcc help 
  aline @xdcc_preview < $+ $me $+ > $c1 $+ #1 $c2 $+ ( $+ $c1 $+ 7.78mb $+ $c2 $+ ) $c1 $+ $chr(91) $+ $c2 $+ util $+ $c1 $+ $chr(93) $c1 $+ » $+ $c2 $+ » file.zip $c1 $+ - $c2 $+  ( $+ $c1 $+ 421 $+ x $+ $c2 $+ )
  aline @xdcc_preview < $+ $me $+ > $c1 $+ #2 $c2 $+ ( $+ $c1 $+ 74.56kb $+ $c2 $+ ) $c1 $+ $chr(91) $+ $c2 $+ app $+ $c1 $+ $chr(93) $c1 $+ » $+ $c2 $+ » another file.zip $c1 $+ - $c2 $+  ( $+ $c1 $+ 62 $+ x $+ $c2 $+ )
  aline @xdcc_preview < $+ $me $+ > $cps.rec $c2 $+ files transfered: $+ $c1 $+ ( $+ $xr(info,sent) files $c2 $+ » $+ $c1 $size.c($xr(info,sizesent)) $+ ) $c2 $+ bandwidth usage: $+ $c1 $+ ( $+ $tot.cps $+ ) $c2 $+ record: $+ $c1 $+ $xr(info,bwrecord) $logo
  aline @xdcc_preview < $+ $me $+ > $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send   
  if ($xr(info,footer) != $null) && ($xr(info,foot) == on) { aline @xdcc_preview < $+ $me $+ > $c1 $+ » $+ $c2 $+ » $xr(info,footer) }

}
alias -l xdate {
  if ($xr(info,date) == $null) { xw info date $asctime(mmmdd) }
  return $c2 $+ last updated: $+ $c1 $+ ( $+  $xr(info,date) $+ )
}
alias -l chani {
  if ($xr(info,allchan) == on) { return $chan(0) }
  else { return $lines(data\xdccchan.txt) }
}
alias -l chano {
  if ($xr(info,allchan) == on) { return $chan(%td1) }
  else { return $read(data\xdccchan.txt,$1) }
}
alias xdcc_ad { 
  if ($xr(info,showpacklist) == on) { 
    if ($xr(info,randomcolor1) == on) { xw info color1 $rand(2,15) }  
    if ($xr(info,randomcolor2) == on) { xw info color2 $rand(2,15) | if ($xr(info,color1) == $xr(info,color2)) { xw info color2 $rand(2,15) } }
    q.check 
    xdcalc | xdcalct 
    if (%td1 == $null) { %td1 = 1 } 
    if (%td1 > $chani) { unset %td1 | .timerxdis off | .timerxddc2 off | .timerxdcc $tpost xdcc_ad | haltdef } 
    if (%td1 <= $chani) { 
      if ($me ison $chano(%td1)) {
        if ($xr(info,header) != $null) && ($xr(info,head) == on) { msg $chano(%td1) $c1 $+ » $+ $c2 $+ » $xr(info,header) }
        msg $chano(%td1) $c2 $+ xdcc server is $c1 $+ ( $+ $xr(info,switch) $+ ) $xdate $+ $c2 $+ $restr $c2 $+ pack(s): $+ $c1 $+ ( $+ $xr(packs,total)  $c2 $+ » $+ $c1 $size.c($xr(info,totsizec)) $+ ) $c2 $+ slots: $+ $c1 $+ ( $+ $send(0) $+ / $+ $xr(info,slots) $+ ) $c2 $+ queue(s): $+ $c1 $+ ( $+ $xr(info,oqueue) $+ / $+ $xr(info,queue) $+ ) $c2 $+ min-cps: $+ $c1 $+ ( $+ $xr(info,mincps) $+ ) 
        msg $chano(%td1) $c1 $+ » $+ $c2 $+ » trigger commands: $c1 /msg $me xdcc help 
        .timerxdis 1 4 x.display | haltdef
      } 
      else { inc %td1 |  if (%td1 <= $chani) { .timerxddc2 1 20 xdcc_ad } | else { unset %xdcc.chan | unset %td1 | .timerxdis off | .timerxdcc2 off } }
    } 
    else { unset %xdcc.chan | unset %td1 | .timerxdis off | .timerxdcc2 off }
  }
}
alias -l x.display { 
  if (%v1 == $null) { %v1 = 1 }
  if (%v1 <= $xr(packs,total)) && (%td1 != $null) { if (%td1 == $null) { %td1 = 1 }  | msg $chano(%td1) $c1 $+ $chr(35) $+ %v1 $c2 $+ ( $+ $c1 $+ $size.c($file($xr(pack $+ %v1,file)).size) $+ $c2 $+ ) $cat(%v1) $c1 $+ » $+ $c2 $+ » $nopath($xr(pack $+ %v1,file)) $c1 $+ - $c2 $+  ( $+ $c1 $+ $xr(pack $+ %v1,dl) $+ x $+ $c2 $+ ) | swe | haltdef }
  else {    
    msg $chano(%td1) $cps.rec $c2 $+ files transfered: $+ $c1 $+ ( $+ $xr(info,sent) files $c2 $+ » $+ $c1 $size.c($xr(info,sizesent)) $+ ) $c2 $+ bandwidth usage: $+ $c1 $+ ( $+ $tot.cps $+ ) $c2 $+ record: $+ $c1 $+ $xr(info,bwrecord) $logo
    .timer 1 1 msg $chano(%td1) $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send   
    if ($xr(info,footer) != $null) && ($xr(info,foot) == on) { .timer 1 1 msg $chano(%td1) $c1 $+ » $+ $c2 $+ » $xr(info,footer) }
    unset %v1 
    inc %td1  
    if (%td1 <= $chani) { .timerxddc2 1 $tpacks xdcc_ad }
  }
}
alias -l swe {
  inc %v1
  .timerxdis 1 5 x.display
} 
alias -l c1 {
  if ($xr(info,color1) == 0) { return 00 }
  elseif ($xr(info,color1) == 1) { return 01 }
  elseif ($xr(info,color1) == 2) { return 02 }
  elseif ($xr(info,color1) == 3) { return 03 }
  elseif ($xr(info,color1) == 4) { return 04 }
  elseif ($xr(info,color1) == 5) { return 05 }
  elseif ($xr(info,color1) == 6) { return 06 }
  elseif ($xr(info,color1) == 7) { return 07 }
  elseif ($xr(info,color1) == 8) { return 08 }
  elseif ($xr(info,color1) == 9) { return 09 }
  elseif ($xr(info,color1) == 10) { return 10 }
  elseif ($xr(info,color1) == 11) { return 11 }
  elseif ($xr(info,color1) == 12) { return 12 }
  elseif ($xr(info,color1) == 13) { return 13 }
  elseif ($xr(info,color1) == 14) { return 14 }
  elseif ($xr(info,color1) == 15) { return 15 }
  else { return 14 } 
}
alias -l c2 {
  if ($xr(info,color2) == 0) { return 00 }
  elseif ($xr(info,color2) == 1) { return 01 }
  elseif ($xr(info,color2) == 2) { return 02 }
  elseif ($xr(info,color2) == 3) { return 03 }
  elseif ($xr(info,color2) == 4) { return 04 }
  elseif ($xr(info,color2) == 5) { return 05 }
  elseif ($xr(info,color2) == 6) { return 06 }
  elseif ($xr(info,color2) == 7) { return 07 }
  elseif ($xr(info,color2) == 8) { return 08 }
  elseif ($xr(info,color2) == 9) { return 09 }
  elseif ($xr(info,color2) == 10) { return 10 }
  elseif ($xr(info,color2) == 11) { return 11 }
  elseif ($xr(info,color2) == 12) { return 12 }
  elseif ($xr(info,color2) == 13) { return 13 }
  elseif ($xr(info,color2) == 14) { return 14 }
  elseif ($xr(info,color2) == 15) { return 15 }
  else { return 04 } 
}
alias -l size.c {
  if (!$1) { return 0 $+ bytes }
  elseif ($1 < 1024) { return $1 $+ bytes }
  elseif ($1 < 1048576) { return $round($calc($1 / 1024),2) $+ kb }
  elseif ($1 < 1073741824) { return $round($calc(($1 / 1024) / 1024),2) $+ mb }
  else { return $round($calc((($1 / 1024) / 1024) / 1024),2) $+ gigs }
}
on *:load:{
} 
dialog xdcc {
  title "xdcc server - team nexgen v1.01"
  size -1 -1 390 364
  option pixels
  tab "settings", 1, 3 5 382 333
  box "restrictions", 11, 8 36 142 116, tab 1
  edit "", 12, 12 54 35 21, tab 1 center
  text "max slots", 13, 51 58 50 16, tab 1
  edit "", 14, 12 77 35 21, tab 1 center
  text "min cps", 15, 50 81 50 16, tab 1
  text "max queue", 17, 49 104 61 16, tab 1
  edit "", 16, 12 101 35 21, tab 1 center
  text "channel(s):", 23, 241 52 50 16, tab 1
  list 22, 239 69 136 90, tab 1 size hsbar vsbar
  edit "", 29, 282 161 93 21, tab 1 autohs
  button "add", 30, 241 163 40 17, tab 1
  button "remove", 31, 318 51 55 17, disable tab 1
  edit "", 44, 8 172 141 21, tab 1 autohs
  text "header", 45, 9 156 50 16, tab 1
  text "footer", 46, 8 197 50 16, tab 1
  edit "", 47, 7 213 141 21, tab 1 autohs
  combo 49, 203 245 44 88, tab 1 size drop
  combo 50, 252 245 44 89, tab 1 size drop
  check "random 2", 51, 305 262 69 20, tab 1
  check "random 1", 52, 305 243 68 20, tab 1
  check "no color", 48, 203 220 63 20, tab 1
  check "enable", 54, 89 152 57 20, tab 1
  check "enable", 55, 89 193 56 20, tab 1
  box "color theme", 56, 198 206 181 81, tab 1
  button "preview", 7, 297 218 75 20, tab 1
  check "notice users queue", 62, 10 275 113 20, tab 1
  box "do not show", 63, 6 241 120 80, tab 1
  check "ops", 64, 159 48 46 20, tab 1
  check "voiced", 65, 158 66 56 20, tab 1
  box "serve only", 66, 153 36 79 57, tab 1
  box "display delay", 69, 153 95 79 111, tab 1
  check "bandwidth", 70, -170 434 76 20, tab 1
  check "reserved", 71, 10 293 105 20, disable tab 1
  edit "", 72, 157 110 31 21, tab 1 autohs center
  edit "", 73, 157 134 31 21, tab 1 autohs center
  text "post", 74, 191 113 25 16, tab 1
  text "packs", 75, 190 137 33 16, tab 1
  button "apply", 76, 170 181 44 17, tab 1
  check "pack list", 67, 10 257 66 20, tab 1
  check "!list trigger", 77, 305 310 76 20, tab 1
  check "ctcp", 20, 140 257 46 20, tab 1
  box "request by", 79, 129 241 66 79, tab 1
  check "msg", 80, 140 276 43 20, tab 1
  check "both", 81, 140 295 48 20, tab 1
  text "max queue per user", 83, 49 127 99 16, tab 1
  edit "", 82, 12 125 35 21, tab 1 center
  check "advertise on join", 85, 201 310 102 20, tab 1
  check "serve all channels", 86, 241 183 116 20, tab 1
  check "serve users only in channel", 87, 201 290 157 20, tab 1
  box "serving channel(s)", 88, 234 36 145 170, tab 1
  text "delay in secs", 89, 157 159 72 16, tab 1 center
  tab "packs", 3
  list 2, 21 77 260 186, tab 3 size hsbar
  button "change pack", 6, 297 80 70 20, disable tab 3
  button "add pack", 8, 297 105 70 20, tab 3
  button "clear all", 5, 297 155 70 20, tab 3
  text "catagory", 9, 20 281 50 16, tab 3
  box "", 18, 22 37 259 35, tab 3
  text "[000] packs total.", 19, 28 50 99 16, tab 3
  box "gets", 24, 322 279 43 37, tab 3
  text "0", 25, 325 294 35 16, tab 3 center
  box "pack", 26, 14 266 359 59, tab 3
  edit "", 37, 123 298 192 21, tab 3 autohs autovs
  text "brief discription", 38, 125 280 79 16, tab 3
  button "save list", 41, 297 217 67 19, tab 3
  button "load list", 42, 297 241 67 19, tab 3
  text "[000] packs sent.", 61, 129 50 96 16, tab 3
  combo 4, 19 299 98 234, tab 3 size edit drop
  button "remove pack", 78, 297 130 70 20, disable tab 3
  tab "slots/queues", 21
  list 32, 16 49 354 117, tab 21 size hsbar vsbar
  text "slots", 33, 16 31 50 16, tab 21
  list 34, 17 188 356 117, tab 21 size hsbar vsbar
  text "queue", 35, 16 170 50 16, tab 21
  button "refresh", 39, 18 309 75 20, tab 21
  text "[00/00]", 36, 332 31 44 16, tab 21
  text "[00/00]", 40, 332 170 47 16, tab 21
  button "add", 53, 156 309 65 20, tab 21
  button "remove", 43, 226 309 65 20, disable tab 21
  button "clear", 27, 309 309 65 20, tab 21
  tab "credits", 57
  text "#warezoasis on undernet", 58, 19 55 124 16, tab 57
  text "#hq-dvds on undernet", 59, 19 71 127 16, tab 57
  box "main testing channels", 60, 14 39 140 56, tab 57
  icon 84, 18 132 353 174,  graphics\default\acidmax.jpg, 0, tab 57
  radio "online", 10, 10 339 75 20, push
  button "advertise", 28, 306 340 75 20
  text "secure query [off]", 68, 92 341 139 16
}

on *:dialog:xdcc:init:*: { 
  ; the format is: dll $adll tooltip_add <dialog handle> <control id> <back color> <text color> <icon> <title>:<tip>
;  dll $adll tooltip_add $dialog(xdcc).hwnd 12 $rgb(119,154,247) $rgb(255,255,255) 1 Maximum slots:maximum amount of downloads at one time.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 14 $rgb(119,154,247) $rgb(255,255,255) 1 Minimum cps:minimum character per second rate transfer.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 16 $rgb(119,154,247) $rgb(255,255,255) 1 Maximum queue:maximum amount of users allowed to wait for next available open slot. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 82 $rgb(119,154,247) $rgb(255,255,255) 1 Maximum queue per user:maximum amount a user is allowed to wait for next available open slot. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 54 $rgb(119,154,247) $rgb(255,255,255) 1 Header switch:check if you want a header text to show public. The text appears before any line of the public advertisement. Perfect for advertising. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 44 $rgb(119,154,247) $rgb(255,255,255) 1 Header text:input your text here for header. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 55 $rgb(119,154,247) $rgb(255,255,255) 1 Footer switch:check if you want a footer text to show public. The text will appear at the end of the public advertisement of your packets.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 47 $rgb(119,154,247) $rgb(255,255,255) 1 Footer text:input your text here for footer. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 67 $rgb(119,154,247) $rgb(255,255,255) 1 Do not show pack list:do not allow list of available files to show public. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 62 $rgb(119,154,247) $rgb(255,255,255) 1 Do not show users queue:do not notice users what position in queue they are in.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 64 $rgb(119,154,247) $rgb(255,255,255) 1 Serve only ops:only allow ops in channel you are serving to recieve files. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 65 $rgb(119,154,247) $rgb(255,255,255) 1 Serve only voiced users:only allow voiced users in channel you are serving to recieve files.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 72 $rgb(119,154,247) $rgb(255,255,255) 1 Delay post:timer delay in seconds to display your list of packs in channel.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 73 $rgb(119,154,247) $rgb(255,255,255) 1 Delay packs:timer delay in seconds to display between pack number in channel. $crlf $+ $crlf Suggested minimum of 5 secs to prevent flooding.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 20 $rgb(119,154,247) $rgb(255,255,255) 1 Request via ctcp:users must use ctcp request to recieve pack(s) or information from you.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 80 $rgb(119,154,247) $rgb(255,255,255) 1 Request via msg:users must use msg request to recieve pack(s) or information from you.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 81 $rgb(119,154,247) $rgb(255,255,255) 1 Request via msg or ctcp:users can use msg or ctcp request to recieve pack(s) or information from you.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 31 $rgb(119,154,247) $rgb(255,255,255) 1 Remove serving channel:select a channel from the list below to remove from serving.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 22 $rgb(119,154,247) $rgb(255,255,255) 1 Serving channel(s):This is a list of channel(s) you are serving your pack(s).
;  dll $adll tooltip_add $dialog(xdcc).hwnd 30 $rgb(119,154,247) $rgb(255,255,255) 1 Add channel:add channel to serving list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 29 $rgb(119,154,247) $rgb(255,255,255) 1 Input channel:input name of channel to add to serving list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 86 $rgb(119,154,247) $rgb(255,255,255) 1 Serve all channels:serve all channel(s) you occupy.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 48 $rgb(119,154,247) $rgb(255,255,255) 1 No color theme:Do not display public text in color.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 7 $rgb(119,154,247) $rgb(255,255,255) 1 Preview theme:show what text theme would appear like in public dispaly.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 49 $rgb(119,154,247) $rgb(255,255,255) 1 Color set 1:select color for set 1of text.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 50 $rgb(119,154,247) $rgb(255,255,255) 1 Color set 2:select color for set 2 of text.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 52 $rgb(119,154,247) $rgb(255,255,255) 1 Random color set 1:random color for set 1of text.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 51 $rgb(119,154,247) $rgb(255,255,255) 1 Random color set 2:random color for set 2 of text.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 87 $rgb(119,154,247) $rgb(255,255,255) 1 Serve users only in channel:only users in your serving channel can be served.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 85 $rgb(119,154,247) $rgb(255,255,255) 1 Advertise on join:as soon as you enter a serving channel you will auto begin displaying your pack list to public.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 77 $rgb(119,154,247) $rgb(255,255,255) 1 !list trigger:msg or notice users your pack list info. 
;  dll $adll tooltip_add $dialog(xdcc).hwnd 10 $rgb(119,154,247) $rgb(255,255,255) 1 Online/offline:turn your xdcc server online or offline.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 68 $rgb(119,154,247) $rgb(255,255,255) 1 Secure query status:this is a notification of the status of nexgen's secure query feature. secure query must be turned off when serving which nexgen's xdcc server will automatically disable when running.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 28 $rgb(119,154,247) $rgb(255,255,255) 1 Advertise:this displays your pack list to your serving channels if you wish not to wait on the display delay.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 19 $rgb(119,154,247) $rgb(255,255,255) 1 Packs total:total packs serving with current pack list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 61 $rgb(119,154,247) $rgb(255,255,255) 1 Packs sent:total history of packs sent.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 2 $rgb(119,154,247) $rgb(255,255,255) 1 Pack list:current pack list serving.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 6 $rgb(119,154,247) $rgb(255,255,255) 1 Change pack:replace a pack with a new pack.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 8 $rgb(119,154,247) $rgb(255,255,255) 1 Add pack:add new pack to pack list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 78 $rgb(119,154,247) $rgb(255,255,255) 1 Remove pack:remove a pack from pack list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 5 $rgb(119,154,247) $rgb(255,255,255) 1 Clear list:delete pack list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 41 $rgb(119,154,247) $rgb(255,255,255) 1 Save list:save your current pack list to file.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 42 $rgb(119,154,247) $rgb(255,255,255) 1 Load list:load pack list previously saved.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 4 $rgb(119,154,247) $rgb(255,255,255) 1 Catagory:Type of pack(file) being served.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 37 $rgb(119,154,247) $rgb(255,255,255) 1 Brief discription:description of pack. This information will be shown when a users request info of pack.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 25 $rgb(119,154,247) $rgb(255,255,255) 1 Gets:how many downloads this pack has recieved.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 32 $rgb(119,154,247) $rgb(255,255,255) 1 Slot list:Users currently using slots.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 34 $rgb(119,154,247) $rgb(255,255,255) 1 Queue list:Users currently in queue.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 39 $rgb(119,154,247) $rgb(255,255,255) 1 Refresh:refresh slot and queue list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 53 $rgb(119,154,247) $rgb(255,255,255) 1 Add user:Add user to slot or queue list, whichever is open.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 43 $rgb(119,154,247) $rgb(255,255,255) 1 Remove user:remove user from queue or slot list.
;  dll $adll tooltip_add $dialog(xdcc).hwnd 27 $rgb(119,154,247) $rgb(255,255,255) 1 Clear users:remove all users from queue and slot list.
 if ($xr(info,switch) == $null) { reset }
 if ($xr(info,list) == $null) { xw info list on }   
  if ($xr(info,showpacklist) == $null) { xw info showpacklist on } 
  didtok -a xdcc 49,50 44 0 $+ ,1 $+ ,2 $+ ,3 $+ ,4 $+ ,5 $+ ,6 $+ ,7 $+ ,8 $+ ,9 $+ ,10 $+ ,11 $+ ,12 $+ ,13 $+ ,14 $+ ,15 
  u.list  
  xlist
  xchans  
  did -z xdcc 2
  $cat.drop 
  if ($acid == $true) { did -o xdcc 68 1 secure query $chr(91) $+ $_vr(querycon,switch) $+ $chr(93) }
  else { did -h xdcc 68 }   
  if ($xr(info,adjoin) == on) { did -c xdcc 85 }  
  if ($xr(info,servestrict) == on) { did -c xdcc 87 } 
  if ($xr(info,head) == on) { did -c xdcc 54 }  
  if ($xr(info,queuenotice) == off) { did -c xdcc 62 }  
  if ($xr(info,list) == on) { did -c xdcc 77 }  
  if ($xr(info,foot) == on) { did -c xdcc 55 }  
  if ($xr(info,allchan) == on) { did -c xdcc 86 | did -b xdcc 22 }  
  if ($xr(info,ctcp) == on) { did -c xdcc 20 } 
  if ($xr(info,msg) == on) { did -c xdcc 80 } 
  if ($xr(info,showpacklist) == off) { did -c xdcc 67 } 
  if ($xr(info,both) == on) || ($xr(info,both) == $null) { did -c xdcc 81,80,20 | did -b xdcc 80,20 | xw info both on | xw info ctcp on | xw info msg on } 
  if ($xr(info,color1) == 0) { did -c xdcc 49 1 }  
  elseif ($xr(info,color1) == 1) { did -c xdcc 49 2 }    
  elseif ($xr(info,color1) == 2) { did -c xdcc 49 3 }    
  elseif ($xr(info,color1) == 3) { did -c xdcc 49 4 }    
  elseif ($xr(info,color1) == 4) { did -c xdcc 49 5 }    
  elseif ($xr(info,color1) == 5) { did -c xdcc 49 6 }    
  elseif ($xr(info,color1) == 6) { did -c xdcc 49 7 }    
  elseif ($xr(info,color1) == 7) { did -c xdcc 49 8 }    
  elseif ($xr(info,color1) == 8) { did -c xdcc 49 9 }    
  elseif ($xr(info,color1) == 9) { did -c xdcc 49 10 }    
  elseif ($xr(info,color1) == 10) { did -c xdcc 49 11 }    
  elseif ($xr(info,color1) == 11) { did -c xdcc 49 12 }    
  elseif ($xr(info,color1) == 12) { did -c xdcc 49 13 }    
  elseif ($xr(info,color1) == 13) { did -c xdcc 49 14 }    
  elseif ($xr(info,color1) == 14) { did -c xdcc 49 15 }  
  elseif ($xr(info,color1) == 15) { did -c xdcc 49 16 }  
  else { xw info color1 14 | did -c xdcc 49 15 }
  if ($xr(info,color2) == 0) { did -c xdcc 50 1 }  
  elseif ($xr(info,color2) == 1) { did -c xdcc 50 2 }    
  elseif ($xr(info,color2) == 2) { did -c xdcc 50 3 }    
  elseif ($xr(info,color2) == 3) { did -c xdcc 50 4 }    
  elseif ($xr(info,color2) == 4) { did -c xdcc 50 5 }    
  elseif ($xr(info,color2) == 5) { did -c xdcc 50 6 }    
  elseif ($xr(info,color2) == 6) { did -c xdcc 50 7 }    
  elseif ($xr(info,color2) == 7) { did -c xdcc 50 8 }    
  elseif ($xr(info,color2) == 8) { did -c xdcc 50 9 }    
  elseif ($xr(info,color2) == 9) { did -c xdcc 50 10 }    
  elseif ($xr(info,color2) == 10) { did -c xdcc 50 11 }    
  elseif ($xr(info,color2) == 11) { did -c xdcc 50 12 }    
  elseif ($xr(info,color2) == 12) { did -c xdcc 50 13 }    
  elseif ($xr(info,color2) == 13) { did -c xdcc 50 14 }    
  elseif ($xr(info,color2) == 14) { did -c xdcc 50 15 }  
  elseif ($xr(info,color2) == 15) { did -c xdcc 50 16 }  
  else { xw info color2 4 | did -c xdcc 50 5 } 
  if ($xr(info,delaypost)  != $null) { did -o xdcc 72 1 $xr(info,delaypost) }
  else { xw info delaypost 400 | did -o xdcc 72 1 $xr(info,delaypost) }   
  if ($xr(info,delaypacks)  != $null) { did -o xdcc 73 1 $xr(info,delaypacks) }
  else { xw info delaypacks 6 | did -o xdcc 73 1 $xr(info,delaypacks) }   
  if ($xr(info,header) != $null) { did -o xdcc 44 1 $xr(info,header) }
  if ($xr(info,footer) != $null) { did -o xdcc 47 1 $xr(info,footer) }
  if ($xr(packs,total) != $null) { did -o xdcc 19 1 $chr(91) $+ $xr(packs,total) $+ $chr(93) packs total. }
  else { did -o xdcc 19 1 [0] packs total. }
  if ($xr(info,slots) != $null) { did -o xdcc 12 1 $xr(info,slots) }
  else {  did -o xdcc 12  1 1 | xw info slots 1 }
  if ($xr(info,queue) != $null) { did -o xdcc 16 1 $xr(info,queue) }
  else {  did -o xdcc 16  1 3 | xw info queue 3 }
  if ($xr(info,muqueue) != $null) { did -o xdcc 82 1 $xr(info,muqueue) }
  else {  did -o xdcc 82 1 2 | xw info muqueue 2 }
  if ($xr(info,color) == on) { did -c xdcc 48 | xw info color1 0 | did -b xdcc 49,50,51,52 }
  if ($xr(info,mincps) != $null) { did -o xdcc 14 1 $xr(info,mincps) }
  else {  did -o xdcc 14  1 0 | xw info mincps 0 }
  if ($xr(info,randomcolor2) == on) { did -c xdcc 51 | did -b xdcc 48,50 }
  if ($xr(info,randomcolor1) == on) { did -c xdcc 52 | did -b xdcc 48,49 }
  if ($xr(info,switch) == on) { did -c xdcc 10 | did -o xdcc 10 1 online }
  elseif ($xr(info,switch) != on) { did -u xdcc 10 | did -o xdcc 10 1 offline }
  did -o xdcc 61 1 $chr(91) $+ $xr(info,sent) $+ $chr(93) packs sent.
  if ($xr(info,sendops) == on) { did -c xdcc 64 }
  if ($xr(info,sendvoiced) == on) { did -c xdcc 65 }
}
on *:dialog:xdcc:dclick:*: { 
  if ($did = 22) { j $did(xdcc,22).seltext }
  if ($did = 2) { run $xr(pack $+ $did(xdcc,2).sel,file) }
}
on *:dialog:xdcc:sclick:*: { 
  if ($did = 2) { 
    did -e xdcc 6,78    
    did -r xdcc 4,37   
    did -o xdcc 26 1 pack $chr(35) $+ $did(xdcc,2).sel
    did -o xdcc 25 1 $xr(pack $+ $did(xdcc,2).sel,dl)
    if ($xr(pack $+ $did(xdcc,2).sel,cat) != $null) {
      did -o xdcc 4 1 $xr(pack $+ $did(xdcc,2).sel,cat) 
      did -c xdcc 4 1 
      .timer 1 2 $cat.drop 
    } 
    else { did -r xdcc 4 }
    if ($xr(pack $+ $did(xdcc,2).sel,info) != $null) {
      did -o xdcc 37 1 $xr(pack $+ $did(xdcc,2).sel,info)
    } 
    else { 
      did -r xdcc 37 
      .timer 1 1 $cat.drop
    }
  }
  if ($did = 4) { 
    if ($did(xdcc,4).text != $null) { xw pack $+ $did(xdcc,2).sel cat $did(xdcc,4).seltext }
    else {  xw pack $+ $did(xdcc,2).sel cat n/a }
  }
  if ($did = 7) { preview }
  if ($did = 20) { 
    if ($xr(info,ctcp) != on) {
      if ($xr(info,msg) == on) { did -u xdcc 80 | xw info msg off }
      xw info ctcp on 
    }
    else { xw info ctcp off } 
  } 
  if ($did = 32) && ($did(xdcc,32).seltext != $null) { did -e xdcc 43 }
  if ($did = 34) && ($did(xdcc,34).seltext != $null) { did -e xdcc 43 }
  if ($did = 67) { 
    if ($xr(info,showpacklist) == on) { xw info showpacklist  off } 
    else { xw info showpacklist on }
  }
  if ($did = 80) { 
    if ($xr(info,msg) != on) {
      if ($xr(info,ctcp) == on) { did -u xdcc 20 | xw info ctcp off }
      xw info msg on
    }
    else { xw info msg off } 
  } 
  if ($did = 81) { 
    if ($xr(info,both) != on) { xw info both on | did -c xdcc 80,20 | did -b xdcc 80,20 | xw info both on | xw info ctcp on | xw info msg on }
    else { did -u xdcc 80,20 | did -e xdcc 80,20 | xw info both off | xw info ctcp off | xw info msg off } 
  }   
  if ($did = 5) { did -o xdcc 19 1 [0] packs total. | xdcc_del }
  if ($did = 6) { xdcc_edt }
  if ($did = 8) { .timer -m 1 1 xdcc_add }
  if ($did = 10) { 
    if ($xr(info,switch) != on) { 
      if ($_vr(querycon,switch) == on) && ($acid == $true) { xw info securequery on | _vw querycon switch off | did -o xdcc 68 1 secure query [off] }
      elseif ($acid == $true) { did -h xdcc 68 }   
      else { xw info securequery off }
      unset %td1 | did -c xdcc 10 | did -o xdcc 10 1 online | xw info switch on | .timerxdcc $tpost xdcc_ad 
    }
    else { 
      if ($xr(info,securequery) == on) { _vw querycon switch on | did -o xdcc 68 1 secure query [on] }
      unset %td1 | did -u xdcc 10 | did -o xdcc 10 1 offline | xw info switch off | .timerxdcc off | .timerxdis off 
    } 
  } 
  if ($did = 51) { 
    if ($xr(info,randomcolor2) != on) { did -c xdcc 51 | did -b xdcc 48,50 | xw info randomcolor2 on }
    else { did -u xdcc 51 | did -e xdcc 48,50 | xw info randomcolor2 off } 
  } 
  if ($did = 52) { 
    if ($xr(info,randomcolor1) != on) { did -c xdcc 52 | did -b xdcc 48,49 | xw info randomcolor1 on }
    else { did -u xdcc 52 | did -e xdcc 48,49 | xw info randomcolor1 off } 
  } 
  if ($did = 64) { 
    if ($xr(info,sendops) != on) { xw info sendops on }
    else { xw info sendops off } 
  } 
  if ($did = 65) { 
    if ($xr(info,sendvoiced) != on) { xw info sendvoiced on }
    else { xw info sendvoiced off } 
  }   
  if ($did = 77) { 
    if ($xr(info,list) != on) { xw info list on }
    else { xw info list off } 
  }   
  if ($did = 76) { 
    if ($did(xdcc,72).text  != $null) && ($did(xdcc,72).text isnum) { xw info delaypost $did(xdcc,72).text }
    else { xw info delaypost 350 | did -o xdcc 72 1 $xr(info,delaypost) }   
    if ($did(xdcc,73).text  != $null) && ($did(xdcc,73).text isnum) { xw info delaypacks $did(xdcc,73).text }
    else { xw info delaypacks 6 | did -o xdcc 73 1 $xr(info,delaypacks) }   
  }
  if ($did = 78) { xdcc_rem }
  if ($did = 85) { 
    if ($xr(info,adjoin) != on) { xw info adjoin on }
    else { xw info adjoin off } 
  } 
  if ($did = 87) { 
    if ($xr(info,servestrict) != on) { xw info servestrict on }
    else { xw info servestrict off } 
  } 
  if ($did = 86) { 
    if ($xr(info,allchan) != on) { xw info allchan on | did -b xdcc 22 }
    else { xw info allchan off | did -e xdcc 22 } 
  } 
  if ($did = 62) { 
    if ($xr(info,queuenotice) != off) { xw info queuenotice off }
    else { xw info queuenotice on  } 
  } 
  if ($did = 22) { did -e xdcc 31 } 
  if ($did = 27) { write -c data\xdccpk.txt | xw info oqueue 0 |  write -c data\xdccq.txt | slist | qlist | iosocks | forc.qcheck  }
  if ($did = 28) { unset %td1 | xdcc_ad }
  if ($did = 30) && ($did(xdcc,29).text != $null) { write data\xdccchan.txt $did(xdcc,29).text | .timer -m 1 1 xchans | did -r xdcc 29 }
  if ($did = 31) { write -dw * $+ $did(xdcc,22).seltext $+ * data\xdccchan.txt | .timer -m 1 1 xchans | did -b xdcc 31 } 
  if ($did = 39) { qlist | slist | iosocks }
  if ($did = 41) { save.xdcc }
  if ($did = 42) { load.xdcc }
  if ($did = 43) {
    if ($did(xdcc,32).sel != $null) { close -s $+ $did(xdcc,32).sel | forc.qcheck | .timer 1 1 u.list }
    elseif ($did(xdcc,34).sel != $null) { write -dl $+ $did(xdcc,34).sel data\xdccq.txt | write -dl $+ $did(xdcc,34).sel data\xdccpk.txt | forc.qcheck | .timer 1 1 u.list }
  }
  if ($did = 48) { 
    if ($xr(info,color) != on) { did -c xdcc 48 | xw info color1 0 | xw info color on | did -b xdcc 49,50,51,52 }
    else { did -u xdcc 48 | xw info color2 0 | xw info color off | did -e xdcc 49,50,51,52 } 
  } 
  if ($did = 49) { xw info color1 $did(xdcc,49).seltext }
  if ($did = 50) { xw info color2 $did(xdcc,50).seltext }
  if ($did = 53) { 
    var %sdg = $?="Nick of user:"
    var %sdh = $?="Pack Number:" 
    $xdccwin SEND REQUEST(local): %sdg $+ : $1- : $nopath($xr(pack $+ $remove(%sdh,$chr(35)),file)) 
    if ($xr(info,oslots) < $xr(info,slots)) {
      .timercpstrack 0 5 cps.track
      q.check
      xw info oslots $send(0).active 
      if ($xr(info,oqueue) == $null) { xw info oqueue 0 }
      if ($mqueue(%sdg) > $xr(info,muqueue)) { $xdccwin 4DENIED: %sdg : $xr(info,muqueue) maximum queue/slot per user | .notice %sdg $logo1 Maximum of $xr(info,muqueue) slots/queues allowed per user, please try when your sends are complete. | close -mc %sdg | halt }   
      if ($xr(info,oslots) < $xr(info,slots)) { xw info oslots $calc($xr(info,oslots) + 1) | $xdccwin 14SLOTS UPDATED:  $send(0).active $+ / $+ $xr(info,slots) }
      dcc send -c %sdg $xr(pack $+ $remove(%sdh,$chr(35)),file)
      .timer50 0 300 xdcc_chkcps
      u.list
    }
    else {
      if ($mqueue(%sdg) >= $xr(info,muqueue)) { $xdccwin 4DENIED: %sdg : $xr(info,muqueue) maximum queue/slot per user | .notice $nick $logo1 Maximum of $xr(info,muqueue) slots/queues allowed per user, please try when your sends are complete. | close -mc %sdg | halt }   
      xw info oqueue $calc($xr(info,oqueue) + 1) 
      .notice %sdg $logo1 All slots are full, You have been added to queue in position $c2 $+  $xr(info,oqueue)  $+ $c1 $+ of $+ $c1 $xr(info,queue) $+  $+ $c1 $+ . To remove yourself from queue type "/msg $me xdcc remove".  | write data\xdccq.txt %sdg | write data\xdccpk.txt $remove(%sdh,$chr(35)) | $xdccwin 14QUEUED: %sdg : $xr(info,oqueue) $+ / $+ $xr(info,oqueue) : $nopath($xr(pack $+ $remove(%sdh,$chr(35)),file))   
      u.list
    }
  }
  if ($did = 54) { 
    if ($xr(info,head) != on) { did -c xdcc 54 | xw info head on }
    else { did -u xdcc 54 | xw info head off } 
  } 
  if ($did = 55) { 
    if ($xr(info,foot) != on) { did -c xdcc 55 | xw info foot on }
    else { did -u xdcc 55 | xw info foot off } 
  } 
}
on *:dialog:xdcc:edit:*: { 
  if ($did = 4) { 
    if ($did(xdcc,4).text != $null) { xw pack $+ $did(xdcc,2).sel cat $did(xdcc,4).text }
    else {  xw pack $+ $did(xdcc,2).sel cat n/a }
  }  
  if ($did = 12) { 
    if ($did(xdcc,12).text != $null) { xw info slots $did(xdcc,12).text }
    else {  xw info slots 1 }
  }
  if ($did = 14) { 
    if ($did(xdcc,14).text != $null) { xw info mincps $did(xdcc,14).text }
    else {  xw info mincps 0 }
  }
  if ($did = 16) { 
    if ($did(xdcc,16).text != $null) { xw info queue $did(xdcc,16).text }
    else {  xw info queue 3 }
  }
  if ($did = 37) { 
    if ($did(xdcc,37).text != $null) { xw pack $+ $did(xdcc,2).sel info $did(xdcc,37).text }
    else {  xw pack $+ $did(xdcc,2).sel info n/a }
  }  
  if ($did = 44) { xw info header $did(xdcc,44).text }
  if ($did = 47) { xw info footer $did(xdcc,47).text }
  if ($did = 82) {
    if ($did(xdcc,82).text != $null) { xw info muqueue $did(xdcc,82).text }
    else { xw info muqueue 2 }
  }
} 
alias -l iosocks {
  if ($dialog(xdcc) != $null) { 
    did -o xdcc 36 1 $chr(91) $+ $send(0) $+ $chr(124) $+ $xr(info,slots) $+ $chr(93)
    did -o xdcc 40 1 $chr(91) $+ $xr(info,oqueue) $+ $chr(124) $+ $xr(info,queue) $+ $chr(93)
  }
}
alias -l cat.drop {
  return   didtok -a xdcc 4 44 mp3 $+ , $+ mp3 album $+ , $+ app $+ , $+ util $+ , $+ game $+ , $+ doc $+ , $+ tutorial $+ , $+ plugin $+ , $+ addon $+ , $+ divx $+ , $+ vcd $+ , $+ video $+ , $+ porn $+ , $+ image $+ , $+ mirc script $+ , $+ mirc addon
}
alias -l xchans {
  did -r xdcc 22  
  var %ccd = 1
  while (%ccd <= $chani) { did -a xdcc 22 $read(data\xdccchan.txt,%ccd) | inc %ccd }
}
alias -l xlist {
  $cat.drop
  var %x = 1 
  while (%x <= $xr(packs,total)) { did -a xdcc 2 $nopath($xr(pack $+ %x,file)) | did -o xdcc 19 1 $chr(91) $+ %x $+ $chr(93) packs total. | inc %x } 
} 
alias -l u.list {
  if ($dialog(xdcc) != $null) { slist | qlist | iosocks | did -b xdcc 43 | forc.qcheck }
}
alias -l qlist {
  did -r xdcc 34
  var %w = 1
  var %h = 0 
  while (%w <= $lines(data\xdccq.txt)) { did -a xdcc 34 < $+ $read(data\xdccq.txt,%w) $+ > $chr(35) $+ $read(data\xdccpk.txt,%h) : $nopath($xr(pack $+ $read(data\xdccpk.txt,%h),file)) | inc %w | inc %h }
}
alias -l slist {
  did -r xdcc 32     
  var %a = 1
  while (%a <= $send(0)) { did -a xdcc 32 < $+ $send(%a) $+ > $send(%a).file | inc %a }
}
alias -l df {
  if ($xr(packs,total) == $null) { did -o xdcc 19 1 $chr(91) $+ 0 $+ $chr(93) packs total. }  
  elseif ($xr(packs,total) == 0) { did -o xdcc 19 1 $chr(91) $+ 0 $+ $chr(93) packs total. } 
}
alias -l xdcc_rem {
  write -c data\xdcc.tmp  
  xw info remove $did(xdcc,2).sel
  if ($did(xdcc,2).sel == $xr(packs,total)) {  xrem pack $+ $did(xdcc,2).sel | xw packs total $calc($xr(packs,total) - 1) | did -r xdcc 2,4,37 | .timer -m 1 1 xlist | .timer 1 1 df  | halt } 
  var %wl = $xr(info,remove)
  var %wu = $calc($xr(info,remove) - 1)
  write -c data\xdcc.tmp    
  inc %wl    
  inc %wu    
  :loop  
  if (%wl <= $xr(packs,total)) { 
    if ($xr(pack $+ %wl,cat) == $null) { xw pack $+ %wl cat n/a }    
    if ($xr(pack $+ %wl,dl) == $null) { xw pack $+ %wl dl 0 }    
    if ($xr(pack $+ %wl,info) == $null) { xw pack $+ %wl info none provided }    
    writeini data\xdcc.tmp pack $+ %wu file $xr(pack $+ %wl,file) 
    writeini data\xdcc.tmp pack $+ %wu dl $xr(pack $+ %wl,dl) 
    writeini data\xdcc.tmp pack $+ %wu info $xr(pack $+ %wl,info) 
    writeini data\xdcc.tmp pack $+ %wu cat $xr(pack $+ %wl,cat)
    xw info date $asctime(mmmdd)
    inc %wl
    inc %wu    
    goto loop
  }  
  if (%wl > $xr(packs,total)) { xdcc_rem2 } 
} 
alias -l xdcc_rem2 {
  var %kk = $xr(info,remove)
  :loop
  if (%kk < $xr(packs,total)) { 
    xw pack $+ %kk file $readini(data\xdcc.tmp,pack $+ %kk,file) 
    xw pack $+ %kk info $readini(data\xdcc.tmp,pack $+ %kk,info) 
    xw pack $+ %kk dl $readini(data\xdcc.tmp,pack $+ %kk,dl) 
    xw pack $+ %kk cat $readini(data\xdcc.tmp,pack $+ %kk,cat) 
    inc %kk | goto loop 
  } 
  elseif (%kk >= $xr(packs,total)) { 
    xw packs total $calc($xr(packs,total) - 1)
    ;  xrem pack %kk  
  did -r xdcc 2,4,37 | .timer -m 1 1 xlist  }
  xw info date $asctime(mmmdd)
}
alias -l load.xdcc {
  ; if ($send(0) > 0) { halt }  
  did -r xdcc 2
  if ($xr(info,listpath) != $null) { %xdcc.file = $$hfile="load file" $xr(info,listpath) }
  else { %xdcc.file = $$hfile="load file" }
  xw info listpath $nofile(%xdcc.file)
  xw packs total $readini(%xdcc.file,packs,total)
  uo
  .timer 1 1 xlist
}
alias -l uo {
  var %i = 1
  while (%i <= $readini(%xdcc.file,packs,total)) { xw pack $+ %i file $readini(%xdcc.file,pack $+ %i,file) | if ($readini(%xdcc.file,pack $+ %i,info) != $null) { xw pack $+ %i info $readini(%xdcc.file,pack $+ %i,info) } | if ($readini(%xdcc.file,pack $+ %i,cat) != $null) { xw pack $+ %i cat $readini(%xdcc.file,pack $+ %i,cat) } | if ($readini(%xdcc.file,pack $+ %i,dl) != $null) { xw pack $+ %i dl $readini(%xdcc.file,pack $+ %i,dl) } | inc %i }
}
alias -l save.xdcc {
  if ($xr(info,listpath) != $null) { %xdcc.file = $$hfile="save file as" $xr(info,listpath) }
  else { %xdcc.file = $$hfile="save file as" }
  xw info listpath $nofile(%xdcc.file)
  writeini %xdcc.file packs total $xr(packs,total)
  ui
}
alias -l ui {
  var %i = 1
  while (%i <= $xr(packs,total)) { writeini %xdcc.file pack $+ %i file $xr(pack $+ %i,file) | if ($xr(pack $+ %i,info) != $null) { writeini %xdcc.file pack $+ %i info $xr(pack $+ %i,info) } | if ($xr(pack $+ %i,cat) != $null) { writeini %xdcc.file pack $+ %i cat $xr(pack $+ %i,cat) } | if ($xr(pack $+ %i,dl) != $null) { writeini %xdcc.file pack $+ %i dl $xr(pack $+ %i,dl) } | inc %i }
}
on *:quit:{
  if ($me == $nick) { .timerxdcc off }
}
on *:join:#:{
  if ($xr(info,switch) == on) && ($me == $nick) {
    if ($xr(info,adjoin) == on) { xdcc_ad }
    var %t1 = 1
    :loop 
    if (%t1 <= $chani) && ($me ison $read(data\xdccchan.txt,%t1))  { .timerxdcc $tpost xdcc_ad | haltdef } 
    elseif (%t1 > $chani) { haltdef } 
    else { inc %t1 | goto loop } 
  }
}
on *:text:xdcc help:?: {
  $xdccwin HELP: $nick 
  .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send 
  .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » detail info on file: $c1 $+ $req.info 
  .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » list all packs: $c1 $+ $req.list 
  .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » your queue status: $c1 $+ $req.queue 
  close -mc $nick
}
on *:text:xdcc remove*:?: {
  if ($xr(info,msg) == on) {  
    $xdccwin $nick $+ : $1- 
    if ($read(data\xdccq.txt, w, * $+ $nick $+ *) != $null) { write -dw * $+ $nick $+ * data\xdccq.txt | write -dl1 data\xdccpk.txt | xw info oqueue $calc($xr(info,oqueue) - 1) | .notice $nick $logo1 You have been removed from my xdcc queue. Thankyou. $logo | u.list }
    else { .notice $nick $logo1 Sorry $nick $+ , but you are not in my xdcc queue. $logo }
    close -mc $nick
  }
  else { .notice $nick $logo1 msg request is disabled. $logo | $xdccwin 4MSG DISABLED: $nick : $1- }
}
on *:text:xdcc queue:?: {
  var %s = 1  
  :loop
  if ($read(data\xdccq.txt,%s) != $nick) { inc %s | goto loop }
  elseif ($read(data\xdccq.txt,%s) == $nick) { $xdccwin QUEUE REQUEST:  $nick : $read(data\xdccq.txt,%s) : %s out of $xr(info,oqueue) in queue | .msg $nick $read(data\xdccq.txt,%s) $logo1 You are $chr( 35) $+ %s out of $xr(info,oqueue) in queue to receive " $+ $nopath($xr(pack $+ $read(data\xdccpk.txt,$calc(%s - 1)),file)) $+ ". Thankyou for your patience. $logo | goto end }
  else { msg $nick $logo1 Sorry $nick $+ , but you are not in my xdcc queue. $logo | goto end }  
  :end
}
on *:text:xdcc list:?: { 
  $xdccwin XDCC LIST REQUEST: $nick
  xw info access $calc($xr(info,access) + 1)
  if ($xr(info,msg) == on) {  
    .msg $nick $c2 $+ xdcc server is $c1 $+ ( $+ $xr(info,switch) $+ ) $xdate $+ $c2 $+ Pack(s): $+ $c1 $+ ( $+ $xr(packs,total) $+ ) $c2 $+ Slots: $+ $c1 $+ ( $+ $send(0) $+ / $+ $xr(info,slots) $+ ) $c2 $+ Queues: $+ $c1 $+ ( $+ $xr(info,oqueue) $+ / $+ $xr(info,queue) $+ ) $c2 $+ MinCPS: $+ $c1 $+ ( $+ $xr(info,mincps) $+ ) 
    .msg $nick $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send 
    .msg $nick $c1 $+ » $+ $c2 $+ » detail info on file: $c1 $+ $req.info 
    %xdcc.ns = $nick
    close -mc $nick
    .timer 1 4 x.displaym
  }
  else { .notice $nick $logo1 msg request is disabled. $logo | $xdccwin 4MSG DISABLED: $nick : $1- }
}
on *:text:help:?: { 
  if ($xr(info,switch) == on) { 
    .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » correct syntax: $c1 $+ /msg $me xdcc help 
  }
} 
on *:text:list:?: { 
  if ($xr(info,switch) == on) { 
    .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » correct syntax: $c1 $+ /msg $me xdcc list 
    .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » other commands: $c1 $+ /msg $me xdcc help 
  }
} 
on *:text:xdcc info *:?: { 
  if ($3 != $null) {
    if ($xr(info,inforeq) == $null) { xw info inforeq 0 }
    xw info inforeq $calc($xr(info,inforeq) + 1)  
    if ($xr(info,msg) == on) {  
      .msg $nick $logo1 Pack $3 $+ : $nopath($xr(pack $+ $remove($3,$chr(35)),file))
      .timer 1 2 .msg $nick $logo1 Size: $size.c($file($xr(pack $+ $remove($3,$chr(35)),file)).size)
      .timer 1 2 .msg $nick $logo1 Downloads: $xr(pack $+ $remove($3,$chr(35)),dl)
      if ($xr(pack $+ $remove($3,$chr(35)),info) != $null) { .timer 1 2 .msg $nick $logo1 Detail: $xr(pack $+ $remove($3,$chr(35)),info) }
      else { .timer 1 2 .msg $nick $logo1 Detail: none provided }
      .timer 1 2 .msg $nick $logo1 receive this file type: $c2 $+ /msg $me xdcc send $3 $+    
      close -mc $nick
      $xdccwin INFO REQUEST: $nick : $3 : $nopath($xr(pack $+ $remove($3,$chr(35)),file))
    } 
    else { .notice $nick $logo1 msg request is disabled. $logo | $xdccwin 4MSG DISABLED: $nick : $1- }
  }
  elseif ($3 == $null) { msg $nick $logo1 $nick you did not indicate which packet. | msg $nick $logo1 Correct syntax: /msg $me xdcc info #<pack number> }
}
alias -l x.displaym { 
  q.check 
  if (%s1 == $null) {  %s1 = 1 }
  if (%s1 <= $xr(packs,total)) { .msg %xdcc.ns $c1 $+ $chr(35) $+ %s1 $c2 $+ ( $+ $c1 $+ $size.c($file($xr(pack $+ %s1,file)).size) $+ $c2 $+ ) $cat(%s1) $c1 $+ » $+ $c2 $+ » $nopath($xr(pack $+ %s1,file)) $c1 $+ - $c2 $+  ( $+ $c1 $+ $xr(pack $+ %s1,dl) $+ x $+ $c2 $+ ) | se | haltdef }
  else {  
    .msg %xdcc.ns $cps.rec $c2 $+ files transfered: $+ $c1 $+ ( $+ $xr(info,sent) files $c2 $+ » $+ $c1 $size.c($xr(info,sizesent)) $+ ) $c2 $+ bandwidth usage: $+ $c1 $+ ( $+ $tot.cps $+ ) $c2 $+ record: $+ $c1 $+ $xr(info,bwrecord) $logo
    if ($xr(info,footer) != $null) && ($xr(info,foot) == on) { msg $read(data\xdccchan.txt,%td1) $c1 $+ » $+ $c2 $+ » $xr(info,footer) }
    unset %s1 
  }
}
alias -l se {
  inc %s1
  .timer 1 $tpacks x.displaym
} 
alias -l cps.track {
  if ($xr(info,record) == $null) { xw info record 0 | $xdccwin INFO RECORD UPDATED: $xr(info,record) } 
  if ($tot.cps > $xr(info,bwrecord)) { xw info bwrecord $tot.cps }
  if ($send(0) == 0) { .timercpstrack off }  
  var %xc = 1
  :loop  
  if (%xc <= $send(0)) && ($send(%xc).cps > $xr(info,record)) { xw info record $send(%xc).cps | xw info recorduser $send(%xc) | $xdccwin INFO RECORD UPDATED: $xr(info,record) }
  else { goto end }
  inc %xc
  :end
}
alias -l cp.s {
  if ($xr(info,record) <= 1024) { return $xr(info,record) bytes }
  elseif ($xr(info,record) < 1048576) {  return $round($calc($xr(info,record) / 1024),2) kb }
  elseif ($xr(info,record) < 1073741824) { return $round($calc(($xr(info,record) / 1024) / 1024),2) mb }
}
alias -l cps.rec {
  return $c2 $+ cps record: $+ $c1 $+ ( $+ $cp.s $+ ) $c2 $+ cps record user: $+ $c1 $+ ( $+ $xr(info,recorduser) $+ )
}
alias -l xdccwin {
  if ($window(@xdcc) == $null) { window @xdcc }
  return aline @xdcc 14»03»  
}
alias -l xchanop {
  var %sk = 1
  :loop 
  if (%sk <= $chani) { 
    if ($me ison $read(data\xdccchan.txt,%sk)) && ($1 isop $read(data\xdccchan.txt,%sk)) { return $true }
    else { inc %sk | goto loop }
  }
  else { return $false }
}
alias -l xchanvoice {
  var %kk = 1
  :loop 
  if (%kk <= $chani) { 
    if ($me ison $read(data\xdccchan.txt,%kk)) && ($1 isvoice $read(data\xdccchan.txt,%kk)) { return $true }
    else { inc %kk | goto loop }
  }
  else { return $false }
}
alias -l xchanin {
  if ($xr(info,servestrict) != on) { return $true } 
  var %dk = 1
  :loop 
  if (%dk <= $chani) { 
    if ($1 ison $chanp(%dk)) { return $true }
    else { inc %dk | goto loop }
  }
  else { return $false }
}
alias -l chanp {
  if ($xr(info,allchan) == on) { return $chan($1) }
  else { return $read(data\xdccchan.txt,$1) }
}
on *:text:!list:#: {
  if ($xr(info,list) == on) {
    .notice $nick $c2 $+ xdcc server is $c1 $+ ( $+ $xr(info,switch) $+ ) $xdate $+ $c2 $+ Pack(s): $+ $c1 $+ ( $+ $xr(packs,total) $+ ) $c2 $+ Slots: $+ $c1 $+ ( $+ $send(0) $+ / $+ $xr(info,slots) $+ ) $c2 $+ Queues: $+ $c1 $+ ( $+ $xr(info,oqueue) $+ / $+ $xr(info,queue) $+ ) $c2 $+ MinCPS: $+ $c1 $+ ( $+ $xr(info,mincps) $+ ) $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send $c1 $+ » $+ $c2 $+ » trigger commands: $c1 /msg $me help  | $xdccwin 14PUBLIC !LIST TRIGGERED: $nick
  }
}
on *:text:xdcc send *:?: {
  close -mc $nick 
  if ($xr(info,switch) == on) { 
    if ($xr(info,msg) == on) {
      if ($xchanin($nick) != $true) { $xdccwin 4SEND REQUEST DENIED: $nick : not on serving channel | .msg $nick $logo1 Sorry $nick $+ , but this xdcc server is only available in channel(s) I am serving. | halt }
      if ($xr(info,sendops) == on) { 
        if ($xchanop($nick) != $true) { $xdccwin SEND REQUEST DENIED: $nick : not a op in serving channel. | .msg $nick $logo1 Sorry $nick $+ , but this xdcc server is only available for oped users. | halt }
      } 
      elseif ($xr(info,sendvoiced) == on) { 
        if ($xchanvoice($nick) != $true) { $xdccwin SEND REQUEST DENIED: $nick : not voiced in serving channel.  | .msg $nick $logo1 Sorry $nick $+ , but this xdcc server is only available for voiced users. | halt }
      } 
      if ($remove($3,$chr(35)) > $xr(packs,total)) { .notice $nick $logo1 You have entered a invalid pack. There are only $xr(packs,total) packs on this current xdcc server. Type: /msg $me xdcc list to get a current list. |  $xdccwin SEND REQUEST ERROR: $nick :  $1- | halt } 
      if ($nopath($xr(pack $+ $remove($3,$chr(35)),file)) == $null) { .notice $nick $logo1 You have entered a invalid pack. There are only $xr(packs,total) packs on this current xdcc server. Type: /msg $me xdcc list to get a current list. |  $xdccwin SEND REQUEST ERROR: $nick :  $1- | halt } 
      $xdccwin SEND REQUEST: $nick : $1- : $nopath($xr(pack $+ $remove($3,$chr(35)),file)) 
      .timercpstrack 0 5 cps.track   
      q.check
      if ($remove($3,$chr(35)) !isnum) { .notice $nick $logo1 You have entered a invalid pack, please check for typos and proper command to send. $c2 $+ syntax: $c1 $+ $req.send  | close -mc $nick | halt }
      xw info oslots $send(0).active
      if ($xr(info,oqueue) == $null) { xw info oqueue 0 }
      if ($mqueue($nick) > $xr(info,muqueue)) { $xdccwin 4DENIED: $nick : $xr(info,muqueue) maximum queue/slot per user | .notice $nick $logo1 Maximum of $xr(info,muqueue) slots/queues allowed per user, please try when your sends are complete. | close -mc $nick | halt }   
      if ($xr(info,oslots) >= $xr(info,slots)) && ($xr(info,oqueue) < $xr(info,queue)) { 
        xw info oqueue $calc($xr(info,oqueue) + 1) | .notice $nick $logo1 All slots are full, You have been added to queue in position $c2 $+  $xr(info,oqueue)  $+ $c1 $+ of $+ $c1 $xr(info,queue) $+  $+ $c1 $+ . To remove yourself from queue type "/msg $me xdcc remove".  | write data\xdccq.txt $nick | write data\xdccpk.txt $remove($3,$chr(35)) | $xdccwin 14QUEUED: $nick : $xr(info,oqueue) $+ / $+ $xr(info,oqueue) : $nopath($xr(pack $+ $remove($3,$chr(35)),file)) | u.list | close -mc $nick | halt 
      }
      elseif ($xr(info,oslots) >= $xr(info,slots)) && ($xr(info,oqueue) >= $xr(info,queue)) { $xdccwin 4DENIED: $nick : $xr(info,oslots) $+ / $+ $xr(info,slots) : slots/queue full | .notice $nick $logo1 All $xr(info,slots) slots and $xr(info,queue) queues are full, please try at another time. | close -mc $nick | halt } 
      if ($xr(info,oslots) < $xr(info,slots)) { xw info oslots $calc($xr(info,oslots) + 1) | $xdccwin 14SLOTS UPDATED:  $send(0).active $+ / $+ $xr(info,slots) }
      dcc send -c $nick $xr(pack $+ $remove($3,$chr(35)),file)
      .timer50 0 300 xdcc_chkcps
      .timer 1 5 u.list
    }
    else { .notice $nick $logo1 msg request is disabled. $logo | $xdccwin 4MSG DISABLED: $nick : $1- }
  }
  else { .msg $nick $logo1 I am sorry, but my xdcc server is $c2 $+ offline $+ $c1 $+ . $logo | $xdccwin 4OFFLINE: $nick : $1- }
}
alias -l mqueue {
  var %lk = 1
  var %ccc = 1
  :loop
  if (%lk <= $send(0)) {
    if ($send(%lk) == $1) { inc %ccc }
    inc %lk | goto loop 
  }
  elseif (%lk > $send(0)) { 
    var %lo = 1 
    :loop2
    if (%lo <= $lines(data\xdccq.txt)) {
      if ($read(data\xdccq.txt,%lo) == $1) { inc %ccc }
      inc %lo | goto loop2
    }
  }
  return %ccc 
}
on *:sendfail:*:{
  if ($xr(info,switch) == on) {
    $xdccwin 4SEND FAILED: $nick : $nopath($filename)
    .notice $nick $logo1 Your send of $nopath($filename) has failed to transfer due to timeout or was interrupted.
    q.check
    if ($send(0) < 1) { .timercpstrack off }
    .timer 1 2 forc.qcheck 
    .timer 1 2 q.remind
    .timer 1 3 u.list
    xw info oslots $send(0).active
    .timer 1 1 $xdccwin 14SLOTS UPDATED:  $send(0).active $+ / $+ $xr(info,slots)
  }
}
alias -l xdccsend {
  if ($send(0) < $xr(info,slots)) { dcc send -c $read(data\xdccq.txt,1) $xr(pack $+ $read(data\xdccpk.txt,0),file) | xw info oslots $calc($xr(info,oslots) + 1) | if ($xr(info,oqueue) != 0) { xw info oqueue $calc($xr(info,oqueue) - 1) } | write -dl1 data\xdccpk.txt | write -dl1 data\xdccq.txt | .timer 1 2 q.remind | $xdccwin 14QUEUE: queue: $xr(info,oqueue) }
}
alias -l forc.qcheck {
  q.check
  if ($send(0) < $xr(info,slots)) {
    if ($comchan($read(data\xdccq.txt,1),0) > 0) && ($read(data\xdccpk.txt,0)  != $null) {
      dcc send -c $read(data\xdccq.txt,1) $xr(pack $+ $read(data\xdccpk.txt,0),file) | xw info oslots $calc($xr(info,oslots) + 1) | if ($xr(info,oqueue) != 0) { xw info oqueue $calc($xr(info,oqueue) - 1) } | write -dl1 data\xdccpk.txt | write -dl1 data\xdccq.txt | .timer 1 2 q.remind
      $xdccwin 14QUEUE: $xr(info,oqueue) $+ / $+ $xr(info,queue)  
    } 
    elseif ($read(data\xdccpk.txt,0)  != $null) && ($comchan($read(data\xdccq.txt,1),0) == 0)  { $xdccwin 14QUEUE CHECK: $read(data\xdccq.txt,1) gone : queue updated : you do not share the same channel as user | if ($xr(info,oqueue) != 0) { xw info oqueue $calc($xr(info,oqueue) - 1) | .timer 1 3 forc.qcheck } | write -dl1 data\xdccpk.txt | write -dl1 data\xdccq.txt | q.check  | u.list }
    else {   }
  }
}
alias  -l q.remind { 
  if ($xr(info,queuenotice) != off) {
    if (%l1 = $null) { %l1 = 1 }
    if ($read(data\xdccq.txt,%l1) != $null) {
      if (%l1 <= $lines(data\xdccq.txt)) && ($nopath($xr(pack $+ $read(data\xdccpk.txt,%l1),file))) != $null) { notice $read(data\xdccq.txt,%l1) $logo1 You are $chr( 35) $+ %l1 out of $xr(info,oqueue) in queue to receive " $+ $nopath($xr(pack $+ $read(data\xdccpk.txt,%l1,file)) $+ ". Thankyou for your patience. $logo | $xdccwin SENT QUEUE REMIND $+ : $read(data\xdccq.txt,%l1) | jis | haltdef }
      else { unset %l1 }
    }
    else { unset %l1 | haltdef }
  }
}
alias -l jis {
  inc %l1
  .timer 1 3 q.remind
} 
alias q.check {
  if ($xr(info,oqueue) <= -1) { $xdccwin RESET QUEUE: $xr(info,oqueue) $+ / $+ $xr(info,queue) | xw info oqueue 0 }
  if ($read(data\xdccq.txt,1) == $null) { xw info oqueue 0 | write -c data\xdccpk.txt }
  if ($read(data\xdccpk.txt,0) == $null) { xw info oqueue 0 | write -c data\xdccq.txt }
  .timerxdcccheck off
  ;u.list
}
on *:filesent:*:{
  if ($xr(info,switch) == on) {
    if ($xr(info,sent) == $null) { xw info sent 0 } 
    if ($xr(info,sizesent) == $null) { xw info sizesent 0 }   
    q.check 
    xw info sent $calc($xr(info,sent) + 1) | xw info sizesent $calc($xr(info,sizesent) + $file($filename).size )
    $xdccwin 3SEND COMPLETE $+ : $nick  : $nopath($filename) | .timer 1 2 forc.qcheck | .timer 1 2 u.list
    .notice $nick $logo1 Your send of $nopath($filename) was successfully completed. $logo
    if ($send(0) == 1) { xw info oslots $calc($send(0) - 1) }
    else { xw info oslots $send(0).active }  
    .timer 1 3 $xdccwin 14SLOTS UPDATED:  $send(0).active $+ / $+ $xr(info,slots)
    %xsent = $filename 
    xsent 
    if ($xr(info,oslots) < $xr(info,slots)) && ($read(data\xdccq.txt,1) != $null) { dcc send -c $read(data\xdccq.txt,1) $xr(pack $+ $read(data\xdccpk.txt,0),file) | xw info oslots $calc($xr(info,oslots) + 1) | xw info oqueue $calc($xr(info,oqueue) - 1) | write -dl1 data\xdccpk.txt | write -dl1 data\xdccq.txt | .timer 1 2 q.remind }
    .timerxdcccheck 3 5 forc.qcheck 
    .timer 1 6 u.list
    if ($send(0) < 1) { .timercpstrack off }
  }
}
alias -l xsent {
  var %xp = 1
  :loop
  if (%xsent == $xr(pack $+ %xp,file)) && ($xr(packs,total) <= %xp) { 
    xw pack $+ %xp dl $calc($xr(pack $+ %xp,dl) + 1) 
    goto end 
  }
  else {
  if ($xr(packs,total) <= %xp) { inc %xp | goto loop } }
  else { goto end }  
  :end
  unset %xsent
} 
alias -l cat {
  if ($xr(pack $+ $1,cat) != $null) { return $c1 $+ $chr(91) $+ $c2 $+ ,99 $+ $xr(pack $+ $1,cat) $+ $c1 $+ $chr(93) }
  else { return }
}
alias -l slots {
  xw info oslots $send(0).active
  return $c1 $+ $chr(91) $+ $xr(info,oslots) $+ $chr(47) $+ $c2 $+ ,99 $+ $xr(info,slots) $+ $c1 $+ $chr(93)
}
alias -l logo1 return $c2 $+ xdcc service $c2 $+ » $+ $c1 $+ »
alias -l logo return $c1 $+ » $+ $c2 $+ » $+ $c1 $+ acidmax $+ $c2 $+ « $+ $c1 $+ « 
ctcp *:xdcc: { 
  if ($1 == xdcc) {    
    if ($xr(info,switch) == on) { 
      if ($xr(info,ctcp) == on) { 
        if ($2 == list) {
          $xdccwin XDCC LIST REQUEST: $nick
          xw info access $calc($xr(info,access) + 1)
          .msg $nick $c2 $+ xdcc server is $c1 $+ ( $+ $xr(info,switch) $+ ) $xdate $+ $c2 $+ Pack(s): $+ $c1 $+ ( $+ $xr(packs,total) $+ ) $c2 $+ Slots: $+ $c1 $+ ( $+ $send(0) $+ / $+ $xr(info,slots) $+ ) $c2 $+ Queues: $+ $c1 $+ ( $+ $xr(info,oqueue) $+ / $+ $xr(info,queue) $+ ) $c2 $+ MinCPS: $+ $c1 $+ ( $+ $xr(info,mincps) $+ ) 
          .msg $nick $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send 
          .msg $nick $c1 $+ » $+ $c2 $+ » detail info on file: $c1 $+ $req.info 
          %xdcc.ns = $nick
          .timer 1 4 x.displaym
        }
        if ($2 == help) {
          $xdccwin HELP: $nick 
          .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » receive file: $c1 $+ $req.send 
          .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » detail info on file: $c1 $+ $req.info 
          .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » list all packs: $c1 $+ $req.list 
          .msg $nick $logo1 $c1 $+ » $+ $c2 $+ » your queue status: $c1 $+ $req.queue 
        }    
        if ($2 == info) && ($3 != $null) {
          if ($xr(info,inforeq) == $null) { xw info inforeq 0 }
          xw info inforeq $calc($xr(info,inforeq) + 1)  
          .msg $nick $logo1 Pack $3 $+ : $nopath($xr(pack $+ $remove($3,$chr(35)),file))
          .timer 1 2 .msg $nick $logo1 Size: $size.c($file($xr(pack $+ $remove($3,$chr(35)),file)).size)
          .timer 1 2 .msg $nick $logo1 Downloads: $xr(pack $+ $remove($3,$chr(35)),dl)
          if ($xr(pack $+ $remove($3,$chr(35)),info) != $null) { .timer 1 2 .msg $nick $logo1 Detail: $xr(pack $+ $remove($3,$chr(35)),info) }
          else { .timer 1 2 .msg $nick $logo1 Detail: none provided }
          .timer 1 2 .msg $nick $logo1 receive this file type: $c2 $+ /msg $me xdcc send $3 $+    
          $xdccwin INFO REQUEST: $nick : $3 : $nopath($xr(pack $+ $remove($3,$chr(35)),file))
        }
        elseif ($3 == $null) { msg $nick $logo1 $nick you did not indicate which packet. | msg $nick $logo1 Correct syntax: $req.info }
        if ($2 == send) {
          if ($xchanin($nick) != $true) { $xdccwin SEND REQUEST DENIED: $nick : not on serving channel | .notice $nick $logo1 Sorry $nick $+ , but this xdcc server is only available in channel(s) I am serving. | halt }
          if ($xr(info,sendops) == on) { 
            if ($xchanop($nick) != $true) { $xdccwin SEND REQUEST DENIED: $nick : not a op in serving channel. | .notice $nick $logo1 Sorry $nick $+ , but this xdcc server is only available for oped users. | halt }
          } 
          elseif ($xr(info,sendvoiced) == on) { 
            if ($xchanvoice($nick) != $true) { $xdccwin SEND REQUEST DENIED: $nick : not voiced in serving channel.  | .notice $nick $logo1 Sorry $nick $+ , but this xdcc server is only available for voiced users. | halt }
          } 
          if ($remove($3,$chr(35)) > $xr(packs,total)) { .notice $nick $logo1 You have entered a invalid pack. There are only $xr(packs,total) packs on this current xdcc server. Type: /msg $me xdcc list to get a current list. |  $xdccwin SEND REQUEST ERROR: $nick :  $1- | halt } 
          if ($nopath($xr(pack $+ $remove($3,$chr(35)),file)) == $null) { .notice $nick $logo1 You have entered a invalid pack. There are only $xr(packs,total) packs on this current xdcc server. Type: /msg $me xdcc list to get a current list. |  $xdccwin SEND REQUEST ERROR: $nick :  $1- | halt } 
          $xdccwin SEND REQUEST: $nick : $1- : $nopath($xr(pack $+ $remove($3,$chr(35)),file)) 
          .timercpstrack 0 5 cps.track   
          q.check
          if ($remove($3,$chr(35)) !isnum) { .notice $nick $logo1 You have entered a invalid pack, please check for typos and proper command to send. $c2 $+ syntax: $c1 $+ $req.send  | halt }
          xw info oslots $send(0).active 
          if ($xr(info,oqueue) == $null) { xw info oqueue 0 }
          if ($xr(info,oslots) >= $xr(info,slots)) && ($xr(info,oqueue) < $xr(info,queue)) { 
            xw info oqueue $calc($xr(info,oqueue) + 1) | .notice $nick $logo1 All slots are full, You have been added to queue in position $+ $c2 $+  $xr(info,oqueue)  $+ $c1 $+ of $+ $c1 $xr(info,queue) $+  $+ $c1 $+ . To remove yourself from queue type "/msg $me xdcc remove". | write data\xdccq.txt $nick | write data\xdccpk.txt $remove($3,$chr(35)) | $xdccwin 14QUEUED: $nick : $xr(info,oqueue) $+ / $+ $xr(info,oqueue) : $nopath($xr(pack $+ $remove($3,$chr(35)),file)) | u.list | halt 
          }
          elseif ($xr(info,oslots) >= $xr(info,slots)) && ($xr(info,oqueue) >= $xr(info,queue)) { $xdccwin 4DENIED: $nick : $xr(info,oslots) $+ / $+ $xr(info,slots) : slots/queue full | .notice $nick $logo1 All $xr(info,slots) slots and $xr(info,queue) queues are full, please try at another time. | halt } 
          if ($mqueue($nick) > $xr(info,muqueue)) { $xdccwin 4DENIED: $nick : $xr(info,muqueue) maximum queue/slot per user | .notice $nick $logo1 Maximum of $xr(info,muqueue) slots/queues allowed per user, please try when your sends are complete. | close -mc $nick | halt }   
          if ($xr(info,oslots) < $xr(info,slots)) { xw info oslots $calc($xr(info,oslots) + 1) | $xdccwin 14SLOTS UPDATED:  $send(0).active $+ / $+ $xr(info,slots) }
          dcc send -c $nick $xr(pack $+ $remove($3,$chr(35)),file) 
          .timer50 0 300 xdcc_chkcps
          .timer 1 5 u.list
        }
        if ($2 == queue) {
          var %s = 1  
          :loop
          if ($read(data\xdccq.txt,%s) != $nick) { inc %s | goto loop }
          elseif ($read(data\xdccq.txt,%s) == $nick) { $xdccwin QUEUE REQUEST:  $nick : $read(data\xdccq.txt,%s) : %s out of $xr(info,oqueue) in queue | .notice $nick $read(data\xdccq.txt,%s) $logo1 You are $chr( 35) $+ %s out of $xr(info,oqueue) in queue to receive " $+ $nopath($xr(pack $+ $read(data\xdccpk.txt,$calc(%s - 1)),file)) $+ ". Thankyou for your patience. $logo | goto end }
          else { notice $nick $logo1 Sorry $nick $+ , but you are not in my xdcc queue. $logo | goto end }  
          :end
        }      
        if ($2 == remove) {
          $xdccwin $nick $+ : $1- 
          if ($read(data\xdccq.txt, w, * $+ $nick $+ *) != $null) { write -dw * $+ $nick $+ * data\xdccq.txt | write -dl1 data\xdccpk.txt | xw info oqueue $calc($xr(info,oqueue) - 1) | .notice $nick $logo1 You have been removed from my xdcc queue. Thankyou. $logo | u.list }
          else { .notice $nick $logo1 Sorry $nick $+ , but you are not in my xdcc queue. $logo }
        }   
      }   
      else { .notice $nick $logo1 ctcp request is disabled. $logo | $xdccwin 4CTCP DISABLED: $nick : $1- }
    }
    else { .notice $nick $logo1 I am sorry, but my xdcc server is $c2 $+ offline $+ $c1 $+ . $logo | $xdccwin 4OFFLINE: $nick : $1- }
  }
}
alias -l req.send {
  if ($xr(info,both) == on) { return $chr(47) $+ msg $me xdcc send #<pack number> or $chr(47) $+ ctcp $me xdcc send #<pack number> }
  elseif ($xr(info,ctcp) == on) { return $chr(47) $+ ctcp $me xdcc send #<pack number> }
  elseif ($xr(info,msg) == on) { return $chr(47) $+ msg $me xdcc send #<pack number> }
}
alias -l req.info {
  if ($xr(info,both) == on) { return $chr(47) $+ msg $me xdcc info #<pack number> or $chr(47) $+ ctcp $me xdcc info #<pack number> }
  elseif ($xr(info,ctcp) == on) { return $chr(47) $+ ctcp $me xdcc info #<pack number> }
  elseif ($xr(info,msg) == on) { return $chr(47) $+ msg $me xdcc info #<pack number> }
}
alias -l req.list {
  if ($xr(info,both) == on) { return $chr(47) $+ msg $me xdcc list or $chr(47) $+ ctcp $me xdcc list }
  elseif ($xr(info,ctcp) == on) { return $chr(47) $+ ctcp $me xdcc list }
  elseif ($xr(info,msg) == on) { return $chr(47) $+ msg $me xdcc list }
}
alias -l req.queue {
  if ($xr(info,both) == on) { return $chr(47) $+ msg $me xdcc queue or $chr(47) $+ ctcp $me xdcc queue }
  elseif ($xr(info,ctcp) == on) { return $chr(47) $+ ctcp $me xdcc queue }
  elseif ($xr(info,msg) == on) { return $chr(47) $+ msg $me xdcc queue }
}
