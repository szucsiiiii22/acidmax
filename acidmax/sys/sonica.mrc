;Sonica v1.64
;Team Nexgen 2002 by KnightFal
;www.team-nexgen.org
on *:load:{ 
  if ($version < 6.0) echo -a  $+ $colour(info2) $+ *** You need mirc 6.0 or greator in order to use this addon. | beep 
  echo -a  4TEAM NEXGEN'S SONICA v1.64 | echo -a  4Please type: /sonica to begin dialog /sonica -help for listing of manual commands.
  if ($script(sonica2.mrc) != $null) { .unload -rs sonica2.mrc } 
  _vw sonica version $_son.ver 
}
alias -l big {
  dialog -sh sonica -1 -1 440 411
  if ($nexgen == $true) { sclick }
}
alias -l small {
  dialog -sh sonica -1 -1 440 175
}
alias -l _son.ver return v1.64 
;[read write data/setting.ini]
alias _vr {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  return $readini data\setting.ini $$1 $$2 
}
alias _vw {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  writeini data\setting.ini $$1 $$2 $$3-
}
alias _vrem {
  if ($exists(data\setting.ini) == $false) { mkdir data | write -c data\setting.ini }
  remini data\setting.ini $$1 $$2 
}
menu menubar,status,channel,query {
  $iif($acid == $true,• $l(28,media))
  .sonica mp3 player:sonica
  $iif($acid != $true,sonica mp3):sonica
}
alias sonica { 
  if ($version < 6.0) { echo -s 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($dialog(sonica) == $null) { 
    if ($exists(data\sonica.mpl) == $false) { write -c data\sonica.mpl }   
    %sonica.active = $active 
    if (%sonica.active == @nexbar) { %sonica.active = Status Window }  
    if ((!$chan(%sonica.active)) && (!$query(%sonica.active))) { 
      if ($chan(1)) { %sonica.active = $chan(1) } 
      elseif ($query(1)) { %sonica.active = $query(1) } 
      else { %sonica.active = Status Window }    
    }     
    if ($1 == -s) { if ($inmp3 == $true) { splay -p stop |  if ($dialog(sonica) != $null) { $d(-b) 110,111 | dialog -th sonica $longfn($sondir) } } | .timer7879 off   }
    elseif ($1 == -r) { sonica.shuffle }
    elseif ($1 == -public) { 
      if ($2 == off) { _vw sonica public off }
      else { _vw sonica public on } 
    }  
    elseif ($1 == -m) { if ($vol(mp3).mute == $true) { vol -pu2 | if ($dialog(sonica) != $null) { $d(-o) 317 1 } | halt } | else { vol -pu1 | if ($dialog(sonica) != $null) { $d(-o) 317 1 mute } | halt } }
    elseif ($1 == -v10) { vol -p 65535 } 
    elseif ($1 == -v9) { vol -p 60000 } 
    elseif ($1 == -v8) { vol -p 55000 } 
    elseif ($1 == -v7) { vol -p 50000 } 
    elseif ($1 == -v6) { vol -p 45000 } 
    elseif ($1 == -v5) { vol -p 40000 } 
    elseif ($1 == -v4) { vol -p 35000 }
    elseif ($1 == -v3) { vol -p 30000 }
    elseif ($1 == -v2) { vol -p 25000 }
    elseif ($1 == -v1) { vol -p 20000 }
    elseif ($1 == -v0) { vol -p 0 }
    elseif ($1 == $null) { $sonica.dialog }
    elseif ($1 == -h) || ($1 == -help) { 
      $ae $space(3) 4/sonica 10[executes dialog] 
      $ae $space(3) 4/sonica -s 10[stop play] 
      $ae $space(3) 4/sonica -r 10[random play] 
      $ae $space(3) 4/sonica -m 10[mute] 
      $ae $space(3) 4/sonica -v# 10[volume. ie: /sonica -v9] 
      $ae $space(3) 4/sonica -public on/off 10[public display on/off] 
    }
  } 
  elseif ($dialog(sonica) != $null) { dialog -x sonica sonica }
}
alias -l sonica.resize { 
  if ($_vr(sonica,sizer) == big) { small }
  else { big }
}
alias -l d return did $1 sonica
dialog sonica {
  title "sonica $_son.ver"
  size -1 -1 440 410
  option pixels
  tab "main", 1, 7 192 425 217
  text "remaining", 142, 379 278 45 15, tab 1
  text "files", 16, 391 240 25 15, tab 1
  text "size", 17, 17 247 40 15, tab 1
  edit "", 11, 192 229 108 18, tab 1 autohs
  text "artist", 132, 146 229 40 15, tab 1
  edit "", 125, 192 247 108 18, tab 1 autohs
  text "title", 131, 146 247 40 15, tab 1
  edit "", 12, 192 265 108 18, tab 1 autohs
  text "album", 130, 146 265 40 15, tab 1
  edit "", 13, 192 283 108 18, tab 1 autohs
  text "comment", 129, 146 283 45 15, tab 1
  edit "", 14, 192 301 108 18, tab 1 autohs
  text "year", 128, 146 301 40 15, tab 1
  text "genre", 127, 146 319 40 15, tab 1
  text "bitrate", 18, 17 282 40 15, tab 1
  text "mode", 20, 77 282 40 15, tab 1
  text "sample rate", 27, 77 317 60 15, tab 1
  text "length", 29, 17 317 40 15, tab 1
  edit "", 9, 17 229 120 18, tab 1 read autohs center
  edit "", 141, 377 258 50 18, tab 1 read autohs center
  edit "", 19, 77 264 60 18, tab 1 read autohs center
  edit "", 26, 77 299 60 18, tab 1 read autohs center
  edit "", 28, 17 299 55 18, tab 1 read autohs center
  edit "", 15, 17 264 55 18, tab 1 read autohs center
  edit "", 8, 377 221 50 18, tab 1 read autohs center
  scroll "", 79, 316 246 17 88, tab 1 range 10 top
  box "volume", 80, 306 217 68 124, tab 1
  text "00", 81, 318 346 13 12, tab 1 center
  box "", 82, 306 338 68 24, tab 1
  scroll "", 83, 346 246 17 88, tab 1 range 10 top
  text "00", 84, 348 346 13 12, tab 1 center
  text "mp3", 85, 314 230 21 16, tab 1
  text "master", 86, 339 230 32 16, tab 1
  button "update id3", 40, 213 343 63 15, tab 1
  box "id3", 41, 141 217 164 145, tab 1
  edit "", 42, 192 321 108 18, tab 1 read autohs
  edit "", 43, 377 298 50 18, tab 1 read autohs center
  text "complete", 44, 380 318 46 16, tab 1
  tab "preferences", 2
  check "show public", 21, 21 235 75 15, tab 2
  check "ctcp mp3", 25, 21 255 75 15, tab 2
  check "loop play", 31, 21 275 75 15, tab 2
  check "random loop", 32, 21 295 75 15, tab 2
  check "show length", 310, 126 235 75 15, tab 2
  check "show mode", 311, 126 255 75 15, tab 2
  check "show bitrate", 312, 126 275 75 15, tab 2
  check "show size", 313, 126 295 75 15, tab 2
  check "show logo", 314, 226 235 75 15, tab 2
  check "always on top", 316, 226 255 85 15, tab 2
  combo 219, 332 255 90 100, tab 2 drop
  text "color theme", 220, 332 241 70 12, tab 2
  combo 221, 332 297 90 100, tab 2 drop
  text "style theme", 222, 332 283 70 12, tab 2
  check "stop playing when closed", 50, 21 312 148 20, tab 2
  box "theme", 52, 327 229 100 100, tab 2
  check "!trigger send", 315, 226 275 78 15, tab 2
  check "play on ctcp", 404, 226 295 78 15, tab 2
  tab "setup", 3
  list 119, 14 233 276 72, hide tab 3 size hsbar vsbar
  radio "player setup (optional)", 120, 300 230 122 15, tab 3
  button "add mp3 folder", 121, 317 255 90 15, tab 3
  check "show all folders", 333, 300 293 90 15, tab 3
  check "internal player", 109, 300 329 90 15, tab 3
  check "sub-folders (recurse)", 409, 300 311 120 15, tab 3
  edit "", 101, 17 247 275 20, tab 3 read autohs
  combo 102, 20 272 40 200, tab 3 drop
  button "search", 104, 182 272 50 20, tab 3
  button "save", 105, 62 272 50 20, disable tab 3
  button "next", 106, 122 272 50 20, tab 3
  button "manual", 107, 242 272 50 20, tab 3
  box "player search", 108, 12 227 285 75, tab 3
  button "add", 122, 22 312 50 20, hide tab 3
  button "remove", 410, 82 312 50 20, hide tab 3
  text "mp3 path(s)", 55, 15 215 56 16, hide tab 3
  button "clear all", 60, 140 312 50 20, hide tab 3
  tab "play to", 98
  list 57, 172 240 100 72, tab 98 size hsbar
  list 58, 276 240 100 72, disable tab 98 size hsbar
  button "add", 61, 200 315 51 17, disable tab 98
  button "remove", 62, 300 315 51 17, disable tab 98
  text "play to:", 63, 279 224 35 16, disable tab 98
  text "available", 64, 174 224 43 16, tab 98
  box "", 65, 164 216 220 120, tab 98
  radio "active only", 67, 36 252 76 20, tab 98
  radio "play to all", 68, 36 269 68 20, tab 98
  radio "play to selected", 69, 36 287 100 20, tab 98
  box "", 70, 27 242 124 72, tab 98
  button "R", 72, 168 317 14 14, tab 98
  tab "play list", 400
  list 401, 20 235 330 98, tab 400 size hsbar vsbar
  button "add", 402, 367 237 50 15, disable tab 400
  button "remove", 403, 367 254 50 15, disable tab 400
  button "skip", 406, 367 271 50 15, disable tab 400
  button "clear list", 407, 367 289 50 15, tab 400
  button "play", 405, 367 307 50 15, disable tab 400
  text "playlist", 54, 23 219 40 16, tab 400
  check "enable playlist", 87, 20 335 92 20, tab 400
  tab "misc", 600
  text "total played", 602, 17 224 61 14, tab 600
  edit "", 601, 17 244 60 18, tab 600 read autohs center
  edit "", 48, 223 251 188 21, disable tab 600 autohs
  box "rename mp3", 49, 216 236 204 61, tab 600
  button "rename", 47, 351 276 60 15, disable tab 600
  button "delete", 218, 351 220 60 15, disable tab 600
  button "post info", 56, 17 268 59 17, disable tab 600
  button "make list", 24, 117 254 59 17, tab 600
  button "view list", 36, 117 275 59 17, tab 600
  check "offer list to public", 37, 94 232 107 20, tab 600
  box "mp3 list", 38, 88 216 120 82, tab 600
  edit "", 45, 24 314 111 21, tab 600
  button "search", 46, 197 315 59 17, tab 600
  box "mp3 search", 66, 16 299 251 44, tab 600
  combo 88, 140 314 47 100, tab 600 size drop
  tab "about", 71
  link "www.team-nexgen.org", 51, 159 271 122 16, tab 71
  text "author: KnightFal", 73, 100 244 90 16, tab 71
  text "version:", 74, 100 258 38 16, tab 71
  text "Text Label", 75, 140 258 51 16, tab 71
  text "home page:", 76, 100 270 57 16, tab 71
  text "note: be sure to check the web site for new updates as well as new addons available from Team Nexgen", 77, 100 290 247 43, tab 71
  box "about sonica", 78, 83 229 283 105, tab 71
  button "play", 5, 313 157 50 15, disable
  button "random", 23, 258 157 50 15
  button "", 110, 203 157 50 15, hide disable
  button "stop", 111, 148 157 50 15, hide disable
  text "", 317, 105 157 40 15
  button "r", 6, 42 157 25 15
  button "x", 500, 800 155 25 15, default ok
  button ">", 7, 400 157 25 15, disable
  list 4, 10 5 420 128, sort size hsbar vsbar
  button "-", 10, 10 157 25 15
  button "m", 140, 75 157 25 15, hide
  icon 99, 25 368 110 27
  icon 100, 386 360 35 35
  text "", 22, 143 374 210 15
  text "browse", 30, 378 172 35 16
  text "mute", 33, 76 173 24 16, hide
  text "refresh", 34, 37 173 34 16
  text "min", 35, 14 173 17 16
  box "", 53, 18 359 356 40
  button "<", 59, 369 157 25 15, disable
  scroll "", 39, 11 140 418 13, range 100 horizontal
}
alias -l son.le $mp3($inmp3.fname).length
on *:dialog:sonica:init:*:{
  sonica.resize
  di.list  
  if ($_vr(sonica,showmode) == all) did -c sonica 333
  $d(-o) 22 1 Sonica $_son.ver $+ , ©2002, Team Nexgen 
  $d(-o) 75 1 $_son.ver  
  if ($_vr(sonica,playstop) == on) { $d(-c) 50 } 
  if ($_vr(sonica,ctcpplay) == $null) { _vw sonica ctcpplay on }
  if ($_vr(sonica,intplayer) == $null) { _vw sonica intplayer on }
  if ($_vr(sonica,intplayer) != off) { $d(-b) 120 | $d(-v) 110,111,140,33 }
  if ($_vr(sonica,ontop) == on) { $d(-c) 316 } 
  if (%sonic.cur == $null) { %sonic.cur = 1 }
  if ($_vr(sonica,intplayer) == on) { did -g  sonica 100 mirc.exe  } 
  elseif ($exists($_vr(sonica,player)) == $true) { did -g sonica 100 $shortfn($_vr(sonica,player)) }
  elseif ($exists($findfile($mircdir,nexgen.ico,1)) == $true) did -g sonica 100 $shortfn($findfile($mircdir,nexgen.ico,1))
  if ($shortfn($findfile($mircdir,sonica.jpg,1)) != $null) did -g sonica 99 $shortfn($findfile($mircdir,sonica.jpg,1))
  $d(-o) 110 1 pause 
  sonica.browse
  actchan
  vol.check
  vol.check.master  
  if ($_vr(sonica,playlist) == on) { $d(-e) 405 | $d(-c) 87 } 
  if ($_vr(sonica,d-logo) == $null) { _vw sonica d-logo on }  
  if ($_vr(sonica,ctcpplay) == on) { $d(-c) 404 }
  if ($_vr(sonica,ctcp) == on) { $d(-c) 25 }
  if ($_vr(sonica,public) == $null) { _vw sonica public on }
  if ($_vr(sonica,public) == on) { $d(-c) 21 } 
  if ($_vr(sonica,mp3list) == on) { $d(-c) 37 } 
  if ($_vr(sonica,mp3list) == on) && ($exists(@ $+ $me $+ .txt) == $true) { $d(-c) 37 | $d(-e) 37 }  
  else { $d(-b) 36,37 | _vw sonica mp3list off | $d(-u) 37 }  
  if ($_vr(sonica,loop) == on) { $d(-c) 31 } 
  if ($_vr(sonica,shuffle) == on) { $d(-c) 32 } 
  if ($_vr(sonica,intplayer) == on) { $d(-c) 109 } 
  if ($_vr(sonica,d-length) == on) { $d(-c) 310 }
  if ($_vr(sonica,d-mode) == on) { $d(-c) 311 }
  if ($_vr(sonica,d-bitrate) == on) { $d(-c) 312 }
  if ($_vr(sonica,d-size) == on) { $d(-c) 313 }
  if ($_vr(sonica,d-logo) == on) { $d(-c) 314 }
  if ($_vr(sonica,triggersend) == on) { $d(-c) 315 }
  $d(-a) 219 none | $d(-a) 219 blue | $d(-a) 219 red | $d(-a) 219 green | $d(-a) 219 purple | $d(-a) 219 yellow | $d(-a) 219 aqua | $d(-a) 219 silver | $d(-a) 219 random 
  $d(-a) 221 none | $d(-a) 221 [bracket] | $d(-a) 221 large dot | $d(-a) 221 small dot | $d(-a) 221 dots | $d(-a) 221 .:style:. | $d(-a) 221 style2 
  if ($_vr(sonica,theme) == $null) { _vw sonica theme red | $d(-c) 219 3 }  
  elseif ($_vr(sonica,theme) == none) { $d(-c) 219 1 }
  elseif ($_vr(sonica,theme) == blue) { $d(-c) 219 2 }
  elseif ($_vr(sonica,theme) == red) { $d(-c) 219 3 }
  elseif ($_vr(sonica,theme) == green) { $d(-c) 219 4 }
  elseif ($_vr(sonica,theme) == purple) { $d(-c) 219 5 }
  elseif ($_vr(sonica,theme) == yellow) { $d(-c) 219 6 }
  elseif ($_vr(sonica,theme) == aqua) { $d(-c) 219 7 }
  elseif ($_vr(sonica,theme) == silver) { $d(-c) 219 8 }
  elseif ($_vr(sonica,theme) == random) { $d(-c) 219 9 }
  if ($_vr(sonica,styletheme) == $null) { _vw sonica styletheme .:style:. | $d(-c) 221 6 }  
  elseif ($_vr(sonica,styletheme) == none) { $d(-c) 221 1 }
  elseif ($_vr(sonica,styletheme) == bracket) { $d(-c) 221 2 }
  elseif ($_vr(sonica,styletheme) == large dot) { $d(-c) 221 3 }
  elseif ($_vr(sonica,styletheme) == small dot) { $d(-c) 221 4 }
  elseif ($_vr(sonica,styletheme) == dots) { $d(-c) 221 5 }
  elseif ($_vr(sonica,styletheme) == .:style:.) { $d(-c) 221 6 }
  elseif ($_vr(sonica,styletheme) == style2) { $d(-c) 221 7 }
  sonica.act 
  .timer -m 1 1 sonica.dir1
  if ($inmp3 == $true) && ($_vr(sonica,intplayer) == on) { $d(-e) 5,110,111 | .timerscroll -m 0 1 scroll }
  if ($inmp3 == $true) { sonica.info }  
  if ($inmp3 == $true) { .timer9898 0 1 sonica.trs }
  if ($_vr(sonica,active) == all) { $d(-c) 68 } 
  elseif ($_vr(sonica,active) == selected) { $d(-c) 69 | $d(-e) 58,61,62,63 }  
  elseif ($_vr(sonica,active) == active) { $d(-c) 67 }  
  else { $d(-c) 67 | _vw sonica active active }  
  $d(-b) 106 
  $d(-c) 120
  if ($_vr(sonica,intplayer) == on) { $d(-b) 120 } 
  if ($_vr(sonica,subfolders) == on) { $d(-c) 409  }
  if (%ask.con1 == $null) { set %ask.con1 50 }
  if ($disk(c:) == $true) { $d(-i) 102 1 C: }
  if ($disk(d:) == $true) || ($disk(d:).type == cdrom) { $d(-i) 102 2 D: }
  if ($disk(e:) == $true) || ($disk(e:).type == cdrom) { $d(-i) 102 3 E: }
  if ($disk(f:) == $true) || ($disk(f:).type == cdrom) { $d(-i) 102 4 F: }
  if ($disk(g:) == $true) || ($disk(g:).type == cdrom) { $d(-i) 102 5 G: }
  if ($disk(h:) == $true) || ($disk(h:).type == cdrom) { $d(-i) 102 6 H: }
  if ($disk(i:) == $true) || ($disk(i:).type == cdrom) { $d(-i) 102 7 I: }
  if ($disk(j:) == $true) || ($disk(j:).type == cdrom) { $d(-i) 102 8 J: }
  if ($disk(k:) == $true) || ($disk(k:).type == cdrom) { $d(-i) 102 9 K: }
  $d(-c) 102 1
  if ($vol(mp3).mute == $true) { $d(-o) 317 1 mute  }
  if ($lines(data\sonica.mpl) == 0) { $d(-b) 405,407 } 
  if ($_vr(sonica,songs.played) == $null) { _vw sonica songs.played 0 }
  $d(-o) 601 1 $_vr(sonica,songs.played) 
  if ($exists($shortfn($findfile($mircdir,sonica.mp3,1))) == $true) && ($_vr(sonica,them) == $null) { .splay $shortfn($findfile($mircdir,sonica.mp3,1)) } 
  if ($_vr(sonica,them) == $null) { _vw sonica them 1 }
  did -z sonica 4,119,401
} 
alias -l sonica.dir return $ini(data\setting.ini,sonicadir,%sonic.cur) 
alias -l sonica.dir1 {
  if ($dialog(sonica) !=  $null) { $d(-r) 119 1 }
  var %f = 0
  :loop
  inc %f 1
  var %dir = $ini(data\setting.ini,sonicadir,%f)
  if (%dir) { $d(-a) 119 $longfn(%dir) | set %sonic.cur %f | goto loop } 
  did -z sonica 119 
  sonica.browse 
  sonica.list
}
alias -l sonica.dialog {
  if ($_vr(sonica,ontop) == on) { return dialog -mh sonica sonica }
  else return dialog -mdh sonica sonica
}
alias smp3 { sonica.shuffle }
alias -l sonica.list {
  if ($dialog(sonica)) {
    dialog -t sonica sonica $_son.ver 
    if ($exists(data\setting.ini) == $false) { write -c data\setting.ini }
    $d(-r) 4 1
    var %f = 0
    if ($_vr(sonica,subfolders) == on) var %do.sub = $true
    if ($_vr(sonica,ShowMode) == all) {
      var %soni.num = 0
      :loop 
      inc %f 1
      var %soni.dir = $ini(data\setting.ini,sonicadir,%f)
      if (%soni.dir) {
        if (%do.sub) { inc %soni.num $findfile(%soni.dir,*.mp3,0, did -a sonica 4 $nopath($1-) ) }
        else { inc %soni.num $findfile(%soni.dir,*.mp3,0,1, did -a sonica 4 $nopath($1-) ) }
        did -z sonica 4     
        goto loop
      }
      dialog -t sonica all folders
    }
    else {
      var %soni.num = 0
      if ($sonica.dir) {
        if (%do.sub) { set %soni.num $findfile($sonica.dir,*.mp3,0, did -a sonica 4 $nopath($1-) ) }
        else { set %soni.num $findfile($sonica.dir,*.mp3,0,1, did -a sonica 4 $nopath($1-) ) }
      }
      dialog -t sonica $longfn($sondir)  
    }
    $d(-o) 8 1 %soni.num
    $d(-b) 56
    if (%son.num != $null) && ($inmp3 == $true) { $d(-e) 110,111,406 | $d(-b) 402,403,407,405 | dialog -t sonica (play list) $nopath($longfn(%sonica.song)) }  
    elseif ($inmp3 == $true) { dialog -t sonica (playing) $nopath($longfn($inmp3.fname)) | .timer9898 0 1 sonica.trs }
  }
}
alias -l sonica.shuffle {
  .timerscroll -m 0 1 scroll 
  if ($dialog(sonica).title != search results) && ($dialog(sonica) !=  $null) dialog -t sonica sonica $_son.ver
  if ($dialog(sonica) != $null) { $d(-e) 110,111 } 
  .timer7879 off | .timer7878 off  
  set %sonica.song $rsondir
  _vw sonica playtype shuffle 
  if ($_vr(sonica,intplayer) == on) && ($shortfn(%sonica.song) != $null) { .splay -p $shortfn(%sonica.song) }
  elseif ($_vr(sonica,intplayer) == on) && ($shortfn(%sonica.song) == $null) { beep | echo -s •4• error » bad path or mp3. | haltdef }   
  else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
  if ($dialog(sonica) != $null) { $d(-r) 9,11,12,13,14,15,19,26,28 }
  if ($dialog(sonica) != $null) { 
    if ($file(%sonica.song).size != $null) { $d(-o) 9 1 $file(%sonica.song).size $+ kb ( $+ $sizesonic(%sonica.song) $+ mb $+ ) }
    else $d(-o) 9 1 n/a
    .timerscroll -m 0 1 scroll    
    .timer9898 0 1 sonica.trs
    sonica.info
    if ($dialog(sonica).title != search results) && ($_vr(sonica,intplayer) == on) { dialog -t sonica (playing) $nopath(%sonica.song) }
    elseif ($dialog(sonica).title != search results) && ($_vr(sonica,intplayer) != on) { dialog -t sonica $nopath(%sonica.song) }  
  } 
  son.shuffle
  if ($_vr(sonica,public) == on) {
    unset %r.c  
    ; if (%sonica.active == Status Window) || ($server == $null) { $se  $+ $colour(info) [mp3] $did(sonica,4).seltext }
    ;else { smsg }
    smsg  
  }
}
alias -l playtype {
  if ($_vr(sonica,playtype) == shuffle) { return random play99 }
  if ($_vr(sonica,playtype) == reg) { return mp399 }
}
alias -l strigger { 
  if ($_vr(sonica,triggersend) == on) { return ! $+ $me }
  else return 
} 
alias -l rsondir {
  var %dir.num = $ini(data\setting.ini,sonicadir,0)
  if (%dir.num) {
    var %dir.get = $ini(data\setting.ini,sonicadir,$rand(1,%dir.num))
    if ($_vr(sonica,subfolders) == on) return $findfile(%dir.get,*.mp3,$rand(1,$findfile(%dir.get,*.mp3,0)))
    else return $findfile(%dir.get,*.mp3,$rand(1,$findfile(%dir.get,*.mp3,0,1)),1)
  }
  else return
}
alias -l son.vol { 
  $d(-c) 79 %son.vol | $d(-o) 81 1 $calc($calc(%son.vol * -1) + 10)
}
alias -l son.vol.master { 
  $d(-c) 83 %son.vol.master | $d(-o) 84 1 $calc($calc(%son.vol.master * -1) + 10)
}
alias -l vol.check { 
  if ($vol(mp3) >= 55001) && ($vol(mp3) <= 65535) { %son.vol = 0 }
  elseif ($vol(mp3) >= 50001) && ($vol(mp3) <= 55000) { %son.vol = 1 }
  elseif ($vol(mp3) >= 45001) && ($vol(mp3) <= 50000) { %son.vol = 2 }
  elseif ($vol(mp3) >= 40001) && ($vol(mp3) <= 45000) { %son.vol = 3 }
  elseif ($vol(mp3) >= 35001) && ($vol(mp3) <= 40000) { %son.vol = 4 }
  elseif ($vol(mp3) >= 25001) && ($vol(mp3) <= 35000) { %son.vol = 5 }
  elseif ($vol(mp3) >= 25001) && ($vol(mp3) <= 35000) { %son.vol = 6 }
  elseif ($vol(mp3) >= 20001) && ($vol(mp3) <= 25000) { %son.vol = 7 }
  elseif ($vol(mp3) >= 15001) && ($vol(mp3) <= 20000) { %son.vol = 8 }
  elseif ($vol(mp3) >= 1) && ($vol(mp3) <= 15000) { %son.vol = 9 }
  elseif ($vol(mp3) <= 0) { %son.vol = 10 }
  $d(-c) 79 %son.vol | $d(-o) 81 1 $calc($calc(%son.vol * -1) + 10)

}
alias -l vol.check.master { 
  if ($vol(master) >= 55001) && ($vol(master) <= 65535) { %son.vol.master = 0 }
  elseif ($vol(master) >= 50001) && ($vol(master) <= 55000) { %son.vol.master = 1 }
  elseif ($vol(master) >= 45001) && ($vol(master) <= 50000) { %son.vol.master = 2 }
  elseif ($vol(master) >= 40001) && ($vol(master) <= 45000) { %son.vol.master = 3 }
  elseif ($vol(master) >= 35001) && ($vol(master) <= 40000) { %son.vol.master = 4 }
  elseif ($vol(master) >= 25001) && ($vol(master) <= 35000) { %son.vol.master = 5 }
  elseif ($vol(master) >= 25001) && ($vol(master) <= 35000) { %son.vol.master = 6 }
  elseif ($vol(master) >= 20001) && ($vol(master) <= 25000) { %son.vol.master = 7 }
  elseif ($vol(master) >= 15001) && ($vol(master) <= 20000) { %son.vol.master = 8 }
  elseif ($vol(master) >= 1) && ($vol(master) <= 15000) { %son.vol.master = 9 }
  elseif ($vol(master) <= 0) { %son.vol.master = 10 }
  $d(-c) 83 %son.vol.master | $d(-o) 84 1 $calc($calc(%son.vol.master * -1) + 10)
}
alias scroll2 {
  .timerscroll -m 0 1 scroll
}
alias -l scroll {
  if ($dialog(sonica) != $null) && ($inmp3 == $true) { $d(-c) 39 $round($calc($calc($insong.pos / $insong.length) * 100),0)
    if ($dialog(sonica).title != search results) { dialog -t sonica (playing) $nopath($longfn($inmp3.fname)) $chr(91) $+ $did(sonica,39).sel $+ % $+ $chr(93) }
    $d(-o) 43 1 $did(sonica,39).sel $+ %  
  }
  elseif ($dialog(sonica) != $null) && ($inmp3 == $true) { .timerscroll off }
  if ($inmp3 != $true) { .timerscroll off | if ($dialog(sonica) != $null) { dialog -t sonica sonica $_son.ver | $d(-c) 39 0 } }
}
on *:dialog:sonica:scroll:*:{
  if ($did == 39) { 
    if ($inmp3 == $true) {   
      var %perc = $round($calc($did(sonica,39).sel / 22000 * $inmp3.length),0)
      splay seek  $calc((%perc + $did(sonica,39).sel) * 200)
      .timer 1 2 scroll2 
    }
    if ($inmp3 != $true) { $d(-c) 39 0 }
  }  
  if ($did == 79) {
    if ($did(79).sel == 0) { vol -p 65535  } 
    elseif ($did(79).sel == 1) { vol -p 60000 } 
    elseif ($did(79).sel == 2) { vol -p 55000 } 
    elseif ($did(79).sel == 3) { vol -p 50000 } 
    elseif ($did(79).sel == 4) { vol -p 45000 } 
    elseif ($did(79).sel == 5) { vol -p 40000 } 
    elseif ($did(79).sel == 6) { vol -p 35000 }
    elseif ($did(79).sel == 7) { vol -p 25000 }
    elseif ($did(79).sel == 8) { vol -p 20000 }
    elseif ($did(79).sel == 9) { vol -p 15000 }
    elseif ($did(79).sel == 10) { vol -p 0 }
    %son.vol = $did(79).sel   
  }
  if ($did == 83) {
    if ($did(83).sel == 0) { vol -v 65535  } 
    elseif ($did(83).sel == 1) { vol -v 60000 } 
    elseif ($did(83).sel == 2) { vol -v 55000 } 
    elseif ($did(83).sel == 3) { vol -v 50000 } 
    elseif ($did(83).sel == 4) { vol -v 45000 } 
    elseif ($did(83).sel == 5) { vol -v 40000 } 
    elseif ($did(83).sel == 6) { vol -v 35000 }
    elseif ($did(83).sel == 7) { vol -v 25000 }
    elseif ($did(83).sel == 8) { vol -v 20000 }
    elseif ($did(83).sel == 9) { vol -v 15000 }
    elseif ($did(83).sel == 10) { vol -v 0 }
    %son.vol.master = $did(83).sel   
  }
  son.vol  
  son.vol.master
}
on *:dialog:sonica:edit:*:{
  if ($did == 48) { var %sgdhs = " $+ $did(sonica,48).text $+ " |  _vw sonica rename %sgdhs }
}
on *:dialog:sonica:sclick:*:{
  if ($did == 99) { if ($server != $null) { msg %sonica.active $sot(1) $+ sonica $+  $sot(2) Sonica $_son.ver $+ , ©2002, Team Nexgen - $sot(3) $+ www.team-nexgen.org - mp3 trading & audio playback addon } | if ($exists($shortfn($findfile($mircdir,sonica.mp3,1))) == $true) { .splay $shortfn($findfile($mircdir,sonica.mp3,1)) } }
  if ($did == 4) { 
    if ($dialog(sonica).title == search results) { %sonica.song = $did(sonica,4).seltext }  
    $d(-r) 9,11,12,13,14,15,19,26,28    
    if ($dialog(sonica).title != search results) { %sonica.song = $sonica.findsong($did(sonica,4).seltext) }
    $d(-e) 5,110,111,218,402,47,48,56
    sonica.info
    $d(-o) 28 1 $sonica.dur(%sonica.song) 
    $d(-o) 48 1  $did(sonica,4).seltext
  }  
  if ($did == 40) { 
    $id3w($shortfn(%sonica.song),artist,$did(sonica,11).text) $id3w($shortfn(%sonica.song),title,$did(sonica,125).text) $id3w($shortfn(%sonica.song),album,$did(sonica,12).text) $id3w($shortfn(%sonica.song),comment,$did(sonica,13).text) $id3w($shortfn(%sonica.song),year,$did(sonica,14).text) 
    ;$id3w($shortfn(%sonica.song),genre,$did(sonica,42).seltext)
  }
  if ($did == 6) { sonica.list  }
  if ($did == 5) && ($did(sonica,4).seltext != $null) { 
    _vw sonica loopsong $shortfn(%sonica.song)  
    if ($dialog(sonica).title != search results) { %sonica.song = $sonica.findsong($did(sonica,4).seltext) }
    if ($dialog(sonica).title != search results) { %sonica.song = $findfile($nofile(%sonica.song),$nopath(%sonica.song),1) } 
    if ($dialog(sonica).title != search results) && ($_vr(sonica,intplayer) == on) { dialog -t sonica (playing) $nopath(%sonica.song) }
    elseif ($dialog(sonica).title != search results) && ($_vr(sonica,intplayer) != on) { dialog -t sonica $nopath(%sonica.song) }  
    if ($_vr(sonica,intplayer) == on) { .splay -p $shortfn(%sonica.song) | .timerscroll -m 0 1 scroll }
    else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
    $d(-e) 110,111
    $d(-b) 218,47,48  
    .timer9898 off
    sonica.play  
  }
  if ($did == 7) { 
    $d(-r) 9,11,12,13,14,15,19,26,28
    if (%sonic.cur == $null) { set %sonic.cur 1 | dialog -t sonica  $longfn($sondir) }
    inc %sonic.cur 1
    if (%sonic.cur > $sonica.dir.count) set %sonic.cur 1
    if ($_vr(sonica,ShowMode) == all) {
      dialog -t sonica all folders
    }
    else {
      dialog -t sonica  $longfn($sondir) 
      sonica.list 
    }
    $d(-b) 5 
  }
  if ($did == 46) { $d(-r) 4 | find }
  if ($did == 59) { 
    $d(-r) 9,11,12,13,14,15,19,26,28
    if (%sonic.cur == $null) { set %sonic.cur 1 }
    dec %sonic.cur 1
    if (%sonic.cur == 0) { set %sonic.cur $sonica.dir.count |  dialog -t sonica  $longfn($sondir) | haltdef }
    if ($_vr(sonica,ShowMode) == all) {
      dialog -t sonica all folders
    }
    else {
      dialog -t sonica  $longfn($sondir) 
      sonica.list 
    }
    $d(-b) 5 
  }
  if ($did == 10) {
    if ($_vr(sonica,sizer) == big) { _vw sonica sizer small } 
    else _vw sonica sizer big
    sonica.resize
  }
  if ($did == 21) {
    if ($_vr(sonica,public) == on) { _vw sonica public off | $d(-b) 25 | if ($_vr(sonica,ctcp) == on) { _vw sonica ctcp off | $d(-u) 25 } }
    else { _vw sonica public on | $d(-c) 21 | $d(-e) 25 }
  }
  if ($did == 23) {
    if ($inmp3 == $true) { splay -p stop } | sonica.shuffle
  }
  if ($did == 24) { mp3.list | $d(-e) 36,37 } 
  if ($did == 25) {
    if ($_vr(sonica,ctcp) == on) { _vw sonica ctcp off  }
    else { _vw sonica ctcp on | $d(-c) 25  }
  }
  if ($did == 31) {
    if ($_vr(sonica,loop) == on) { _vw sonica loop off | .timer7878 off }
    else { _vw sonica loop on | $d(-c) 31 | if ($_vr(sonica,shuffle) == on) { _vw sonica shuffle off | $d(-u) 32 | .timer7879 off } }
  }
  if ($did == 32) {
    if ($_vr(sonica,shuffle) == on) { _vw sonica shuffle off | .timer7879 off }
    else { _vw sonica shuffle on | $d(-c) 32  | if ($_vr(sonica,loop) == on) { _vw sonica loop off | $d(-u) 31 } }
  }
  if ($did == 36) { run @ $+ $me $+ .txt }  
  if ($did == 37) { 
    if ($_vr(sonica,mp3list) == on) { _vw sonica mp3list off }
    else {
      if ($exists(@ $+ $me $+ .txt) == $true) { _vw sonica mp3list on }
      else { $d(-u) 37 }  
    }
  } 
  if ($did == 50) {
    if ($_vr(sonica,playstop) == on) { _vw sonica playstop off  }
    else { _vw sonica playstop on | $d(-c) 50  }
  }
  if ($did == 316) {
    if ($_vr(sonica,ontop) == on) { _vw sonica ontop off  | dialog -x sonica sonica | .timer -m 1 1 sonica }
    else { _vw sonica ontop on | $d(-c) 316 | dialog -x sonica sonica | .timer -m 1 1 sonica }
  }
  if ($did == 51) {
    www http://www.team-nexgen.org
  }
  if ($did == 56) {
    $mp3.pub.info(%sonica.song)
  }
  if ($did == 61) && ($did(sonica,57).seltext != $null) {
    $d(-a) 58 $did(sonica,57).seltext | write data\sonicaact.txt $did(sonica,57).seltext
  }
  if ($did == 62) && ($did(sonica,58).sel != $null) { actrem $did(sonica,58).seltext | $d(-d) 58 $did(58,1).sel }
  if ($did == 72) { sonica.act }
  if ($did == 87) { 
    if ($_vr(sonica,playlist) == on) { _vw sonica playlist off | $d(-b) 405 }
    else { _vw sonica playlist on | $d(-e) 405 }
  }
  if ($did == 109) {
    if ($_vr(sonica,intplayer) == on) { _vw sonica intplayer off | $d(-e) 120 | $d(-h) 110,111,140,33  | if ($exists($_vr(sonica,player)) == $true) { did -g sonica 100 $shortfn($_vr(sonica,player)) } }
    else { _vw sonica intplayer on | .timer9898 off | $d(-c) 109 | $d(-b) 120 | $d(-v) 110,111,140,33  | did -g  sonica 100 mirc.exe }
  }
  if ($did == 409) {
    if ($_vr(sonica,subfolders) == on) { _vw sonica subfolders off  }
    else { _vw sonica subfolders on | $d(-c) 409  }
  }
  if ($did == 110) { 
    if ($_vr(sonica,pause) == on) { _vw sonica pause off | .timer9898 0 1 sonica.tr | splay -p resume | $d(-e) 5 | $d(-o) 110 1 pause | if ($dialog(sonica).title != search results) { dialog -t sonica (playing) $nopath($longfn($inmp3.fname)) } }
    else { _vw sonica pause on | .splay -p pause | $d(-b) 5 | $d(-o) 110 1 resume | if ($dialog(sonica).title != search results) { dialog -t sonica (paused) $nopath($longfn($inmp3.fname)) } }
  }
  if ($did == 310) { 
    if ($_vr(sonica,d-length) == on) { _vw sonica d-length off }
    else { _vw sonica d-length on }
  }
  if ($did == 404) { 
    if ($_vr(sonica,ctcpplay) == on) { _vw sonica ctcpplay off }
    else { _vw sonica ctcpplay on }
  }  
  if ($did == 311) { 
    if ($_vr(sonica,d-mode) == on) { _vw sonica d-mode off }
    else { _vw sonica d-mode on }
  }
  if ($did == 312) { 
    if ($_vr(sonica,d-bitrate) == on) { _vw sonica d-bitrate off }
    else { _vw sonica d-bitrate on }
  }
  if ($did == 313) { 
    if ($_vr(sonica,d-size) == on) { _vw sonica d-size off }
    else { _vw sonica d-size on }
  }
  if ($did == 314) { 
    if ($_vr(sonica,d-logo) == on) { _vw sonica d-logo off }
    else { _vw sonica d-logo on }
  }
  if ($did == 315) { 
    if ($_vr(sonica,triggersend) == on) { _vw sonica triggersend off }
    else { _vw sonica triggersend on }
  }
  if ($did == 218) { %sonicad = $sondir $+ $nopath($shortfn($did(sonica,4).seltext))  | .timer -m 1 1 sonica.del }
  if ($did == 47) { 
    var %songren =  " $+ $sondir $+ $did(sonica,4).seltext $+ "
    var %songren2 =  " $+ $sondir $+ $_vr(sonica,rename) $+ "
    .rename %songren %songren2    
    sonica.list
    $d(-b) 47,48
    $d(-r) 48 
  }
  if ($did == 219) { 
    if ($did(sonica,$did,1).sel == 1) { $svwst1 none | svrt }
    if ($did(sonica,$did,1).sel == 2) { $svwst1 blue | svrt }
    if ($did(sonica,$did,1).sel == 3) { $svwst1 red | svrt }
    if ($did(sonica,$did,1).sel == 4) { $svwst1 green | svrt }
    if ($did(sonica,$did,1).sel == 5) { $svwst1 purple | svrt }
    if ($did(sonica,$did,1).sel == 6) { $svwst1 yellow | svrt }
    if ($did(sonica,$did,1).sel == 7) { $svwst1 aqua | svrt }
    if ($did(sonica,$did,1).sel == 8) { $svwst1 silver | svrt }
    if ($did(sonica,$did,1).sel == 9) { $svwst1 random }
  }
  if ($did == 221) { 
    if ($did(sonica,$did,1).sel == 1) { $svwst none }
    if ($did(sonica,$did,1).sel == 2) { $svwst bracket }
    if ($did(sonica,$did,1).sel == 3) { $svwst large dot }
    if ($did(sonica,$did,1).sel == 4) { $svwst small dot }
    if ($did(sonica,$did,1).sel == 5) { $svwst dots }
    if ($did(sonica,$did,1).sel == 6) { $svwst .:style:. }
    if ($did(sonica,$did,1).sel == 7) { $svwst style2 }
  }
  if ($did == 223) { 
    if ($did(sonica,$did,1).sel == 1) { set %sonica.active $active }
    if ($did(sonica,$did,1).sel == 2) { _vw sonica playall on }
    if ($did(sonica,$did,1).sel == 3) { set %sonica.active Status Window |  _vw sonica playall off }
    if ($did(sonica,$did,1).sel >= 4) { 
      set %sonica.active $did(223,$did(223).sel) 
    }
  }
  if ($did == 119) { set %oi $shortfn($did(119,$did(119).sel)) }
  if ($did == 111) { if ($inmp3 == $true) { splay -p stop | $d(-b) 110,111 | $d(-e) 403,405,4,402,407 } | unset %son.num | .timer7879 off | if ($dialog(sonica).title != search results) { dialog -t sonica $longfn($sondir) } }
  if ($did == 140) { 
    if ($vol(mp3).mute == $true) { vol -pu2 | $d(-o) 317 1 }
    else { vol -pu1 | $d(-o) 317 1 mute }
  }
  if ($did == 3) { $d(-v) 101,102,104,105,106,107,108 |  $d(-h) 60,119,122,410,55 | $d(-c) 120 }

  if ($did == 120) { 
    if ($did(sonica,120).state == 1) { $d(-v) 101,102,104,105,106,107,108 |  $d(-h) 60,119,122,410,55 } 
  } 
  if ($did == 121) {
    ;  if ($did(sonica,121).state == 1) { $d(-h) 101,102,104,105,106,107,108 | $d(-v) 60,119,122,410,55 | $d(-u) 120 | .timer -m 1 1 sonica.dir1 }
    $d(-h) 101,102,104,105,106,107,108 | $d(-v) 60,119,122,410,55 | .timer -m 1 1 sonica.dir1
  } 
  if ($did == 60) { sonica.dir.del | $d(-r) 119  }
  if ($did == 67) { 
    if ($did(sonica,67).state == 1) { $d(-u) 69,68 | $d(-b) 58,61,62,63 | _vw sonica active active } 
  } 
  if ($did == 68) {
    if ($did(sonica,68).state == 1) { $d(-u) 69,67 | $d(-b) 58,61,62,63 | _vw sonica active all }
  } 
  if ($did == 69) {
    if ($did(sonica,69).state == 1) { $d(-u) 68,67 | $d(-e) 58,61,62,63 | _vw sonica active selected }
  } 
  if ($did == 333) {
    if ($did(sonica,333).state == 1) { _vw sonica showmode all }
    else { _vw sonica showmode current }
    sonica.browse | sonica.list
  }
  if ($did == 400) { mpl.list }
  if ($did == 401) { $d(-e) 403 | set %mpl.song $did(401,$did(401).sel) } 
  if ($did == 402) && (.mp3 isin $did(sonica,4).seltext) { 
    $d(-e) 405,407 
    var %sh = $shortfn($sonica.findsong($did(sonica,4).seltext)) | write -i1 data\sonica.mpl $shortfn(%sh) | $d(-a) 401 $longfn(%sh) 
  } 
  if ($did == 405) { %son.num = 1 | $d(-b) 403,405,402,407 | $d(-u) 31,32 | _vw sonica shuffle off | _vw sonica loop off | $d(-e) 111,110,406 | son.playlist }
  if ($did == 406) { inc %son.num 1 | son.playlist }
  if ($did == 407) { write -c data\sonica.mpl | $d(-r) 401 | $d(-b) 405,407 }
  if ($did == 403) { var %ghs = $shortfn(%mpl.song) |  write -ds $+ %ghs data\sonica.mpl | mpl.list } 
  if ($did == 122) { .timer -m 1 1 sonica.dir.add }
  if ($did == 410) { .remini data\settings.ini sonicadir $shortfn($did(sonica,119).seltext) $+ $chr(92) | .timer -m 1 1 sonica.dir1 }
  ; if ($did == 225) { set %mp.seldir $sondir | set %mp.sel $sondir $+ $did(sonica,4).seltext  | .timer -m 1 1 mp3.rename }
  if ($did == 102) { set %drive $did(102,$did(102).sel) } 
  if ($did == 104) { if ($did(102,$did(102).sel) == $null) { $d(-o) 101 1 You did not select  a drive to search. | halt | else $d(-b) 104  | set %pf 1 | set %drive $did(102,$did(102).sel) } | sonica.ps }
  if ($did == 106) { set %drive $did(102,$did(102).sel)  | $d(-r) 101 1 | $d(-o) 101 1 Searching... | inc %pf 1 | sonica.ps } 
  if ($did == 107) { .timer -m 1 1 sonica.man }
  if ($did == 105) { _vw sonica player $shortfn($did(sonica,101,1).text) | $se  $+ $colour(info2) $+ *** MP3 Player set to $did(sonica,101,1).text | set %pf 1 | unset %drive | unset %mp3.exe | $d(-b) 106,105 | $d(-e) 104 | if ($dialog(sonica) != $null) { did -g sonica 100 $_vr(sonica,player) } 
    _vw sonica playername $remove($nopath($_vr(sonica,player)),.exe) 
    unset %pf 
  }
}
alias -l di.list {
  $d(-r) 88
  if ($disk(c:) == $true) { $d(-a) 88 c:\ }
  if ($disk(d:) == $true) { $d(-a) 88 d:\ }
  if ($disk(e:) == $true) { $d(-a) 88 e:\ }
  if ($disk(f:) == $true) { $d(-a) 88 f:\ }
  if ($disk(g:) == $true) { $d(-a) 88 g:\ }
  if ($disk(h:) == $true) { $d(-a) 88 h:\ }
  if ($disk(i:) == $true) { $d(-a) 88 i:\ }
  if ($disk(j:) == $true) { $d(-a) 88 j:\ }

  $d(-c) 88 1
}
alias -l i return did $1 sonica
alias -l o return did -o sonica
alias -l c return did -c sonica 
alias -l svwst return _vw sonica styletheme
alias -l svwst1 return _vw sonica theme
alias -l svrt _vrem sonica theme2
alias -l actrem set -u0 %act $lines(data\sonicaact.txt) | if (%act == 0) || (%act == $null) { goto end } | :loop | if ($1- == $read -l [ $+ [ %act ] ] data\sonicaact.txt) { write -dl [ $+ [ %act ] ] data\sonicaact.txt | goto end } | dec %act | if (%act =< 0) { goto end } | goto loop | :end
alias sonica.play {
  .timerscroll -m 0 1 scroll 
  .timer9898 0 1 sonica.tr 
  unset %r.c  
  if ($dialog(sonica) != $null) { $d(-e) 406,111,110 } 
  if ($_vr(sonica,intplayer) != on) && ($_vr(sonica,loop) == on) { .timer7878 0 $calc($file($shortfn(%sonica.song)).size / 15876.24752+10) son.loop.play1 }
  elseif ($_vr(sonica,intplayer) != on) && ($_vr(sonica,loop) != on) { .timer7878 off }
  if ($_vr(sonica,public) == on) {
    _vw sonica playtype reg  
    .timer7879 off | .timer7878 off  
    ; if (%sonica.active == Status Window) || ($server == $null) || ($left(%sonica.active,1) == $chr(64)) { $son.looper $se  $+ $colour(info) [mp3] $did(sonica,4).seltext }
    ;else { smsg } 
    smsg 
  }
}
alias -l play.all {
  if ($dialog(sonica) != $null) {
    var %channum = 0
    :findchan
    inc %channum 1
    var %chan = $chan(%channum)
    if (%chan != $null) { msg %chan $sot(3) $+ $sst(3) $+ $playtype $+ $sot(3) $+ $sst(4) $+  $strigger $nopath(%sonica.song) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo | if ($_vr(sonica,ctcp) == on) { ctcp %chan mp3 $nopath(%sonica.song) } | goto findchan }
    else goto query 
    :query
    var %querynum = 0
    :findquery
    inc %querynum 1
    var %query = $query(%querynum)
    if (%query != $null) { msg %query $sot(3) $+ $sst(3) $+ $playtype $+ $sot(3) $+ $sst(4) $+  $strigger $nopath(%sonica.song) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo | if ($_vr(sonica,ctcp) == on) { ctcp %query mp3 $nopath(%sonica.song) } | goto findquery }
    else return 
  }
}
alias -l smsg {
  if ($_vr(sonica,active) == active) {
    if ($query($active) == $active) || ($chan($active) == $active) && ($server != $null) { msg %sonica.active $sot(3) $+ $sst(3) $+ $playtype $+ $sot(3) $+ $sst(4) $+  $strigger $nopath(%sonica.song) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo | if ($_vr(sonica,ctcp) == on) { ctcp %sonica.active mp3 $nopath(%sonica.song) } }
    else { $se  $+ $colour(info) [mp3] $did(sonica,4).seltext } 
  }
  elseif ($_vr(sonica,active) == all) { play.all }
  elseif ($_vr(sonica,active) == selected) {
    var %s = $lines(data\sonicaact.txt)
    var %s1 = 1 
    while (%s1 <= %s) { msg $read(data\sonicaact.txt,%s1) $sot(3) $+ $sst(3) $+ $playtype $+ $sot(3) $+ $sst(4) $+  $strigger $nopath(%sonica.song) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo | if ($_vr(sonica,ctcp) == on) { ctcp $read(data\sonicaact.txt,%s1) mp3 $nopath(%sonica.song) } | inc %s1 1 }
    else return
  }
}
alias -l sonica.dir.remove { remini data\setting.ini sonicadir $shortfn(%oi) . | unset %oi | .timer -m 1 1 sonica.dir1 }
alias -l sonica.info {
  if ($_vr(sonica,subfolders) == on) { %sonica.song = $nopath(%sonica.song) | %sonica.song = $sonica.findsong(%sonica.song) }
  $d(-o) 9 1 $file(%sonica.song).size $+ kb ( $+ $sizesonic(%sonica.song) $+ mb $+ ) 
  if ($mp3(%sonica.song).artist != $null) { $d(-o) 11 1 $mp3(%sonica.song).artist } | else $d(-o) 11 1 n/a
  if ($mp3(%sonica.song).title != $null) { $d(-o) 125 1 $mp3(%sonica.song).title } | else $d(-o) 125 1 n/a
  if ($mp3(%sonica.song).genre != $null) { $d(-o) 42 1 $mp3(%sonica.song).genre } | else $d(-o) 42 1 n/a
  if ($mp3(%sonica.song).album != $null) { $d(-o) 12 1 $mp3(%sonica.song).album } | else $d(-o) 12 1 n/a
  if ($mp3(%sonica.song).comment != $null) { $d(-o) 13 1 $mp3(%sonica.song).comment } | else $d(-o) 13 1 n/a
  if ($mp3(%sonica.song).year != $null) { $d(-o) 14 1 $mp3(%sonica.song).year } | else $d(-o) 14 1 n/a
  if ($mp3(%sonica.song).bitrate != $null) { $d(-o) 15 1 $mp3(%sonica.song).bitrate $+ kbps } | else $d(-o) 15 1 n/a
  if ($mp3(%sonica.song).mode != $null) { $d(-o) 19 1 $lower($mp3(%sonica.song).mode) } | else $d(-o) 19 1 n/a
  if ($mp3(%sonica.song).sample != $null) { $d(-o) 26 1 $mp3(%sonica.song).sample $+ khz } | else $d(-o) 26 1 n/a
  $d(-o) 42 1 Blues | $d(-o) 42 2 Classic Rock | $d(-o) 42 3 Country | $d(-o) 42 4 Dance | $d(-o) 42 5 Disco | $d(-o) 42 6 Funk | $d(-o) 42 7 Grunge | $d(-o) 42 8 Hip-Hop | $d(-o) 42 9 Jazz | $d(-o) 42 10 Metal | $d(-o) 42 11 New Age | $d(-o) 42 12 oldies | $d(-o) 42 13 Other | $d(-o) 42 14 Pop | $d(-o) 42 15 R&B | $d(-o) 42 16 Rap | $d(-o) 42 17 Reggae | $d(-o) 42 18 Rock | $d(-o) 42 19 Techno | $d(-o) 42 20 Industrial | $d(-o) 42 21 Alternative | $d(-o) 42 22 Ska | $d(-o) 42 23 Death Metal | $d(-o) 42 24 Pranks | $d(-o) 42 25 Soundtrack | $d(-o) 42 26 Euro-Techno | $d(-o) 42 27 Ambient | $d(-o) 42 28 Trip-Hop | $d(-o) 42 29 Vocal | $d(-o) 42 30 Jazz+Funk | $d(-o) 42 31 Fusion | $d(-o) 42 32 Trance | $d(-o) 42 33 Classical | $d(-o) 42 34 Instrumental | $d(-o) 42 35 Acid | $d(-o) 42 36 House | $d(-o) 42 37 Game | $d(-o) 42 38 Sound Clip | $d(-o) 42 39 Gospel | $d(-o) 42 40 Noise | $d(-o) 42 41 AlternRock | $d(-o) 42 42 Bass 
  $d(-o) 42 43 Soul | $d(-o) 42 44 Punk | $d(-o) 42 45 Space | $d(-o) 42 46 Meditative | $d(-o) 42 47 Instrumental Pop | $d(-o) 42 48 Instrumental Rock | $d(-o) 42 49 Ethnic | $d(-o) 42 49 Gothic | $d(-o) 42 50 Darkwave | $d(-o) 42 51 Techno-Industrial | $d(-o) 42 52 Electronic | $d(-o) 42 53 Pop-Folk | $d(-o) 42 54 Eurodance | $d(-o) 42 55 Dream | $d(-o) 42 56 Southern Rock | $d(-o) 42 57 Comedy | $d(-o) 42 58 Cult| $d(-o) 42 59 Gangsta | $d(-o) 42 59 Top 40 | $d(-o) 42 60 Christian Rap | $d(-o) 42 61 Pop/Funk | $d(-o) 42 61 Jungle | $d(-o) 42 62 Native American | $d(-o) 42 63 Cabaret | $d(-o) 42 64 New Wave | $d(-o) 42 65 Psychadelic | $d(-o) 42 65 Rave | $d(-o) 42 66 Showtunes | $d(-o) 42 67 Trailer | $d(-o) 42 68 Lo-Fi | $d(-o) 42 69 Tribal | $d(-o) 42 70 Acid Punk | $d(-o) 42 71 Acid Jazz | $d(-o) 42 72 Polka | $d(-o) 42 73 Retro | $d(-o) 42 74 Musical | $d(-o) 42 75 Rock & Roll | $d(-o) 42 76 Hard Rock
  $d(-o) 42 77 Folk | $d(-o) 42 78 Folk Rock | $d(-o) 42 79 Swing | $d(-o) 42 80 Fast Fusion | $d(-o) 42 81 Bebob | $d(-o) 42 82 Latin | $d(-o) 42 83 Revival | $d(-o) 42 84 Celtic | $d(-o) 42 85 Bluegrass | $d(-o) 42 86 Avantgarde | $d(-o) 42 87 Gothic Rock | $d(-o) 42 88 Progressive Rock | $d(-o) 42 89 Psychedelic Rock | $d(-o) 42 90 Symphonic Rock | $d(-o) 42 91 Slow Rock | $d(-o) 42 92 Big Bang | $d(-o) 42 93 Chorus | $d(-o) 42 94 Easy Listening | $d(-o) 42 95 Acoustic | $d(-o) 42 96 Humour | $d(-o) 42 97 Speech | $d(-o) 42 98 Chanson | $d(-o) 42 99 Opera | $d(-o) 42 100 Chamber Music | $d(-o) 42 101 Sonata | $d(-o) 42 102 Symphony | $d(-o) 42 103 Booty Brass | $d(-o) 42 104 Primus | $d(-o) 42 105 Porn Groove | $d(-o) 42 106 Satire | $d(-o) 42 107 Slow Jam | $d(-o) 42 108 Club | $d(-o) 42 109 Tango | $d(-o) 42 110 Samba | $d(-o) 42 111 Floklore | $d(-o) 42 112 Ballad | $d(-o) 42 113 Poweer Ballad | $d(-o) 42 114 Rhytmic Soul 
  $d(-o) 42 115 Rhytmic Soul | $d(-o) 42 116 Freestyle | $d(-o) 42 117 Duet | $d(-o) 42 118 Punk Rock | $d(-o) 42 119 Drum Solo | $d(-o) 42 120 A Capela | $d(-o) 42 121 Euro-House | $d(-o) 42 122 Dance Hall

  ;if ($mp3(%sonica.song).genre != $null) { $d(-o) 42 1 $mp3(%sonica.song).genre } | else $d(-o) 42 1 n/a
  $d(-o) 42 1 $mp3(%sonica.song).genre 
  $d(-c) 42 1
}
alias find {
  dialog -t sonica searching... 
  $d(-r) 4 
  var %t = $findfile($did(sonica,88).text, * $+ $did(sonica,45).text $+ * $+ .mp3,0)
  var %t1 = 1
  while (%t1 <= %t) { $d(-a) 4 $findfile($did(sonica,88).text, * $+ $did(sonica,45).text $+ * $+ .mp3,%t1) | inc %t1 1 |  if (%t1 == %t) { dialog -t sonica search results | did -z sonica 4 } }
}
alias -l mp3.pub.info {
  msg %sonica.active $sot(1) $+ mp3 info $+ $sot(2) $did(sonica,4).seltext 
  msg %sonica.active $s.size($1) $s.artist($1) $s.title($1) $s.genre($1) $s.album($1) $s.current($1) $s.year($1) $s.bitrate($1) $s.mode($1) $s.sample($1)
}
alias -l s.artist {
  if ($mp3($1).artist != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ artist $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).artist } | else return $sot(3) $+ $sst(1) $+ 99 $+ artist $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.size {
  return $sot(3) $+ $sst(1) $+ 99 $+ size $+ $sot(3) $+ $sst(2) $+ 99 $file($1).size $+ kb ( $+ $sizesonic($1) $+ mb $+ ) 
}
alias -l s.title {
  if ($mp3($1).title != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ title $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).title } | else return $sot(3) $+ $sst(1) $+ 99 $+ title $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.genre {
  if ($mp3($1).genre != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ genre $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).genre } | else return $sot(3) $+ $sst(1) $+ 99 $+ genre $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.album {
  if ($mp3($1).album != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ album $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).album } | else return $sot(3) $+ $sst(1) $+ 99 $+ album $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.comment {
  if ($mp3($1).comment != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ comment $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).comment } | else return $sot(3) $+ $sst(1) $+ 99 $+ comment $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.year {
  if ($mp3($1).year != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ year $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).year } | else return $sot(3) $+ $sst(1) $+ 99 $+ year $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.bitrate {
  if ($mp3($1).bitrate != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ bitrate $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).bitrate $+ kbps } | else return $sot(3) $+ $sst(1) $+ 99 $+ bitrate $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.mode {
  if ($mp3($1).mode != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ mode $+ $sot(3) $+ $sst(2) $+ 99 $lower($mp3($1).mode) } | else return $sot(3) $+ $sst(1) $+ 99 $+ mode $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l s.sample {
  if ($mp3($1).sample != $null) { return $sot(3) $+ $sst(1) $+ 99 $+ sample rate $+ $sot(3) $+ $sst(2) $+ 99 $mp3($1).sample $+ khz } | else return $sot(3) $+ $sst(1) $+ 99 $+ sample rate $+ $sot(3) $+ $sst(2) $+ 99 n/a
}
alias -l sonica.browse {
  if ($sonica.dir.count <= 1) || ($_vr(sonica,showmode) == all) { $d(-b) 7,59 }
  else $d(-e) 7,59
}
alias -l sonica.dir.count return $ini(data\setting.ini,sonicadir,0)
alias -l sonica.dir.del { .remini data\setting.ini sonicadir | sonica.browse }
;shuffle duration
alias -l sonica.trs {
  if ($dialog(sonica) != $null) { 
    if ($inmp3.fname != $shortfn(%sonica.song)) || ($inmp3 == $false) && ($inmp3.fname != $shortfn(%sonica.song)) { .timer9898 off  | $d(-r) 141 1 |  halt }
    $d(-o) 141 1 $remove($duration($calc(($mp3($shortfn(%sonica.song)).length - $inmp3.pos) / 1000)),rs,ins,ecs) 
  }
}
alias -l son.shuffle { if ($_vr(sonica,shuffle) == on) { _vw sonica playtype shuffle | .timer7879 0 $calc($file($shortfn(%sonica.song)).size / 15876.24752+10) sonica.shuffle  } }
alias -l slength { 
  if ($_vr(sonica,d-length) == on) { return $sot(3) $+ $sst(1) $+ 99 $+ $sonica.dur($1) $+ $sot(3) $+ $sst(2) $+ 99 }
  else return 
} 
alias -l smode { 
  if ($_vr(sonica,d-mode) == on) { return $sot(3) $+ $sst(1) $+ 99 $+  $lower($mp3($1).mode) $+ $sot(3) $+ $sst(2) $+ 99  }
  else return 
} 
alias -l sbitrate { 
  if ($_vr(sonica,d-bitrate) == on) { return $sot(3) $+ $sst(1) $+ 99 $+ $mp3($1).bitrate $+ kbps $+ $sot(3) $+ $sst(2) $+ 99  }
  else return 
} 
alias -l ssize { 
  if ($_vr(sonica,d-size) == on) { return $sot(3) $+ $sst(1) $+ 99 $+ $sizesonic($1) $+ mb $+ $sot(3) $+ $sst(2) $+ 99  }
  else return 
} 
alias -l slogo { 
  if ($_vr(sonica,d-logo) == on) { return $sot(1) $+ sonica $+ $sot(2)  }
  else return 
} 
alias -l son.playlist {
  if ($_vr(sonica,playlist) == on) && ($lines(data\sonica.mpl) != $null) {
    %mp3.lines = $lines(data\sonica.mpl) 
    if ($exists(data\sonica.mpl) == $true) { set %sonica.song $read -l %son.num data\sonica.mpl }
    else { write data\sonica.mpl }  
    %sonica.song = $findfile($nofile($longfn(%sonica.song)),$nopath($longfn(%sonica.song)),1)    
    %sonica.song = $longfn(%sonica.song)
    if (%son.num > %mp3.lines) { if ($dialog(sonica) != $null) { $d(-b) 406 | $d(-e) 403,405,4,402,5,23 | dialog -t sonica $longfn($sondir) } | goto end } 
    if ($_vr(sonica,intplayer) == on) { .splay -p $shortfn(%sonica.song) }
    else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
    if ($dialog(sonica) != $null) { 
      dialog -t sonica (play list) $nopath($longfn(%sonica.song)) 
      $d(-o) 11 1 $mp3(%sonica.song).artist 
      $d(-o) 125 1 $mp3(%sonica.song).title
      $d(-o) 42 1 $mp3(%sonica.song).genre
      $d(-o) 12 1 $mp3(%sonica.song).album 
      $d(-o) 13 1 $mp3(%sonica.song).comment 
      $d(-o) 14 1 $mp3(%sonica.song).year
      $d(-o) 15 1 $mp3(%sonica.song).bitrate $+ kbps
      $d(-o) 19 1 $lower($mp3(%sonica.song).mode)
      $d(-o) 26 1 $mp3(%sonica.song).sample $+ khz
      $d(-o) 28 1 $sonica.dur(%sonica.song) 
      $d(-e) 111  
    }
    sonica.play
    goto end2
    :end
    unset %son.num | .splay -p stop
    :end2
  }
}
alias -l _son12 if ($exists(data\sonica.mpl) == $true) { return $read -l %vto data\sonica.mpl  }
alias -l mpl.list {
  if ($findfile($mircdir,sonica.mpl,1) == $null) { write data\sonica.mpl }
  $d(-r) 401    
  set %vto 0
  :loop 
  inc %vto 1 
  if ($_son12 != $null) { var %hj = $_son12 | $d(-a) 401 $longfn(%hj) | goto loop } 
  else goto end 
  :end 
  unset %vto
  did -z sonica 401
} 

on *:dialog:sonica:dclick:*:{
  if ($did == 4) { 
    if ($dialog(sonica).title != search results) { 
      set %sonica.song $sondir $+ $did(sonica,4).seltext
      set %sonica.song $findfile($nofile(%sonica.song),$nopath(%sonica.song),1)
      if ($_vr(sonica,intplayer) == on) { dialog -t sonica (playing) $nopath(%sonica.song) }
      else { dialog -t sonica $nopath(%sonica.song) }  
    }  
    if ($_vr(sonica,intplayer) == on) { .splay -p $shortfn(%sonica.song) }
    else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
    sonica.play
  }
}
alias -l sondir return $ini(data\setting.ini,sonicadir,%sonic.cur)
alias -l sonica.del { set -q %del $iif($$?!="delete this mp3?" == $true,yes,no) | sondel }
alias -l sondel {
  if (%del == yes) { 
  remove $shortfn(%sonicad) | unset %del | .timer -m 1 1 sonica.list } 
  else { unset %del }
}
alias -l sonica.dir.add { _vw sonicadir $shortfn($$sdir="mp3 folder") . | sonica.dir1 }
alias -l son.loop.play {
  unset %r.c  
  if ($_vr(sonica,public) == on) { msg %sonica.active $sot(3) $+ $sst(3) $+ mp3 loop $+ $sot(3) $+ $sst(4) $+  $strigger $nopath($longfn($_vr(sonica,loopsong))) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo }
  if ($_vr(sonica,intplayer) == on) { .splay -p $shortfn($_vr(sonica,loopsong)) }
  else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
  if ($_vr(sonica,ctcp) == on) { ctcp %sonica.active mp3 $nopath(%sonica.song) } 
  .timer9898 0 1 sonica.tr 
}
alias -l sizesonic return $round($calc($file($shortfn($1-).size) / 1048576),2) 
alias -l pf.player { if (%pf > 14) return end | if (%pf == 1) return winamp.exe | elseif (%pf == 2) return nexencode.exe | elseif (%pf == 3) return sonique.exe | elseif (%pf == 4) return kjofol.exe | elseif (%pf == 5) return XingMP3.exe | elseif (%pf == 6) return unreal.exe | elseif (%pf == 7) return mplayer2.exe | elseif (%pf == 8) return CTPlay.exe | elseif (%pf == 9) return pulse.exe | elseif (%pf == 10) return nad.exe | elseif (%pf == 11) return digideck.exe | elseif (%pf == 12) return soritong.exe | elseif (%pf == 13) return eclipse.exe | elseif (%pf == 14) return studio.exe } 
alias -l sonica.ps {
  :start
  if ($pf.player == end) { $d(-o) 101 1 no other players found on $did(102,$did(102).sel) | $d(-b) 106,105 | unset %pf | $d(-e) 104 |  goto end }
  var %mp3.exe = $shortfn($findfile(%drive,$pf.player,1))
  :start2
  if (%mp3.exe == $null) { $d(-r) 101 1 | $d(-o) 101 1 Searching... | inc %pf 1 | goto start }
  if ($dialog(sonica) != $null) { did -g sonica 100 %mp3.exe } 
  $d(-o) 101 1 $longfn(%mp3.exe) | beep 
  $d(-e) 106,105 | $d(-b) 104  
  set -q %player? $d(-o) 101 1 $longfn(%mp3.exe) | goto end 
  if (%player? == $true) { $d(-o) 101 1 MP3 Player Set to $_vr(sonica,playername)  | unset %pf | unset %drive | unset %player? }
  :end
}   
alias -l sonica.man {
  var %mp3.exe = $$dir="Path to the mp3 player(.exe name):"  c:\*.exe  
  _vw sonica player $shortfn(%mp3.exe) 
  if ($dialog(mp3con) != $null) { did -g mp3con 100 $longfn($_vr(sonica,player))  }
  $ae  $+ $colour(info2) $+ *** MP3 Player set to $longfn(%mp3.exe) | beep
}        
alias -l son.length { 
  var %t = $round($calc($1 - (( [ $int($calc($1 / 60 )) ] ) *  60 )),0) 
  if ($len(%t) == 1) set %t 0 $+ %t
  return $int($calc($1 / 60 )) $+ : $+ %t
}
alias -l son.dur { 
  set %minute 0
  unset %sec
  unset %total
  set %length $round($calc($mp3($1-).length / 1000), 0)
  while (%length >= 60) { 
    inc %minute 1
    dec %length 60
  } 
  %sec = %length
  if ($len(%length) == 1) %sec = 0 $+ %sec
  %total = %minute $+ m $+ %sec $+ s
  return %total
}
alias -l son.loop { return $calc($file($1-).size / 15876.24752+10) }
on *:mp3end: {
  if ($_vr(sonica,loop) != on) { _vw sonica loop off | .timer7878 off }
  if (%son.num != null) { inc %son.num 1 | son.playlist |  if ($dialog(sonica) != $null) { $d(-b) 406 } }  
  if ($dialog(sonica).title != search results) && ($dialog(sonica) != $null) { if ($_vr(sonica,intplayer) == on) { dialog -t sonica $longfn($sondir) } }
  if ($dialog(sonica) != $null) { $d(-b) 110,111 }
  if ($_vr(sonica,loop) == on) { .timer 1 5 son.loop.play } 
  %gys = $_vr(sonica,songs.played) | inc %gys 1 |  _vw sonica songs.played %gys | if ($dialog(sonica) != $null) { $d(-o) 601 1 $_vr(sonica,songs.played) }
}

;time remaining
alias sonica.tr {
  if ($dialog(sonica) == $null) && ($_vr(sonica,playstop) == on) { .timer9898 off | splay -p stop }
  if ($dialog(sonica) != $null) { 
    if ($inmp3.fname != $shortfn(%sonica.song)) || ($inmp3 == $false) && ($inmp3.fname != $shortfn(%sonica.song)) { .timer9898 off | $d(-r) 141 1 |  halt }
    else $d(-o) 141 1 $remove($duration($calc(($mp3($shortfn(%sonica.song)).length - $inmp3.pos) / 1000)),rs,ins,ecs) 
  }
}
alias -l sonica.act {
  if ($dialog(sonica) != $null) {
    $d(-r) 57 
    var %channum = 0
    :findchan
    inc %channum 1
    var %chan = $chan(%channum)
    if (%chan == $null) { goto query }
    $d(-i) 57 1 %chan
    goto findchan
    :query
    var %querynum = 0
    :findquery
    inc %querynum 1
    var %query = $query(%querynum)
    if (%query == $null) { goto end }
    $d(-i) 57 1 %query
    goto findquery
    :end
  }
}
on *:input:?: { .timer -m 1 1 sonica.act }
on *:join:#: if ($nick == $me) { .timer -m 1 1 sonica.act } 
on *:part:#: if ($nick == $me) { .timer -m 1 1 sonica.act | actrem $chan | .timer -m 1 1 actchan }    
on *:kick:#: if ($knick == $me) { .timer -m 1 1 sonica.act | actrem $chan | .timer -m 1 1 actchan }
on *:open:?: { .timer -m 1 1 sonica.act }
on *:close:?: { .timer -m 1 1 sonica.act | actrem $nick | .timer -m 1 1 actchan }
alias -l son.loop.play1 {
  unset %r.c  
  if ($_vr(sonica,public) == on) { msg %sonica.active $sot(3) $+ [mp3 loop $+ $sot(3) $+ ] $strigger $nopath(%sonica.song) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo }
  if ($_vr(sonica,intplayer) == on) { .splay -p $shortfn($_vr(sonica,loopsong)) }
  else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
  if ($_vr(sonica,ctcp) == on) { ctcp %sonica.active mp3 $nopath(%sonica.song) } 
}
alias show.s echo -a $sot(3) $+ $sst(3) $+ $playtype $+ $sot(3) $+ $sst(4) $+  $nopath(%sonica.song) $slength(%sonica.song) $+ $smode(%sonica.song) $+ $sbitrate(%sonica.song) $+ $ssize(%sonica.song) $slogo
alias -l sonica.dur return $remove($duration($calc(($mp3($shortfn($1)).length - ) / 1000)),ins,ecs,in,ec)
alias -l sst {
  if ($_vr(sonica,styletheme) == none) { 
    if ($1 == 1) { return }
    if ($1 == 2) { return }
    if ($1 == 3) { return }
    if ($1 == 4) { return }
  }
  elseif ($_vr(sonica,styletheme) == bracket) { 
    if ($1 == 1) { return [ }
    if ($1 == 2) { return ] }
    if ($1 == 3) { return [ }
    if ($1 == 4) { return ] }
  }
  elseif ($_vr(sonica,styletheme) == large dot) { 
    if ($1 == 1) { return • }
    if ($1 == 2) { return • }
    if ($1 == 3) { return • }
    if ($1 == 4) { return • }
  }
  elseif ($_vr(sonica,styletheme) == small dot) { 
    if ($1 == 1) { return · }
    if ($1 == 2) { return · }
    if ($1 == 3) { return · }
    if ($1 == 4) { return · }
  }
  elseif ($_vr(sonica,styletheme) == dots) { 
    if ($1 == 1) { return · }
    if ($1 == 2) { return · }
    if ($1 == 3) { return • }
    if ($1 == 4) { return • }
  }
  elseif ($_vr(sonica,styletheme) == .:style:.) { 
    if ($1 == 1) { return : }
    if ($1 == 2) { return : }
    if ($1 == 3) { return .: }
    if ($1 == 4) { return :. }
  }
  elseif ($_vr(sonica,styletheme) == style2) { 
    if ($1 == 1) { return « }
    if ($1 == 2) { return » }
    if ($1 == 3) { return « }
    if ($1 == 4) { return » }
  }
}
alias -l sot {
  if ($_vr(sonica,theme) == random) { 
    if (%r.c == $null) { set %r.c $rand(1,8) }
    if (%r.c == 1) { _vw sonica theme2 1 }
    elseif (%r.c == 2) { _vw sonica theme2 2 }
    elseif (%r.c == 3) { _vw sonica theme2 3 }
    elseif (%r.c == 4) { _vw sonica theme2 4 }
    elseif (%r.c == 5) { _vw sonica theme2 5 }
    elseif (%r.c == 6) { _vw sonica theme2 6 }
    elseif (%r.c == 7) { _vw sonica theme2 7 }
    elseif (%r.c == 8) { _vw sonica theme2 8 }
  } 
  if ($_vr(sonica,theme2) == 1) || ($_vr(sonica,theme) == none) { 
    if ($1 == 1) { return ·• }
    if ($1 == 2) { return •· }
    if ($1 == 3) { return $chr(160) }
  }
  elseif ($_vr(sonica,theme2) == 2) || ($_vr(sonica,theme) == red) { 
    if ($1 == 1) { return 5•4• }
    if ($1 == 2) { return 4•5• }
    if ($1 == 3) { return 4 }
  }
  elseif ($_vr(sonica,theme2) == 3) || ($_vr(sonica,theme) == yellow) { 
    if ($1 == 1) { return 7•8• }
    if ($1 == 2) { return 8•7• }
    if ($1 == 3) { return 8 }
  }

  elseif ($_vr(sonica,theme2) == 4) || ($_vr(sonica,theme) == blue) { 
    if ($1 == 1) { return 2•12• }
    if ($1 == 2) { return 12•2• }
    if ($1 == 3) { return 12 }
  }
  elseif ($_vr(sonica,theme2) == 5) || ($_vr(sonica,theme) == green) { 
    if ($1 == 1) { return 3•9• }
    if ($1 == 2) { return 9•3• }
    if ($1 == 3) { return 9 }
  }
  elseif ($_vr(sonica,theme2) == 6) || ($_vr(sonica,theme) == purple) { 
    if ($1 == 1) { return 6•13• }
    if ($1 == 2) { return 13•6• }
    if ($1 == 3) { return 13 }
  }
  elseif ($_vr(sonica,theme2) == 7) || ($_vr(sonica,theme) == aqua) { 
    if ($1 == 1) { return 10•11• }
    if ($1 == 2) { return 11•10• }
    if ($1 == 3) { return 11 }
  }
  elseif ($_vr(sonica,theme2) == 8) || ($_vr(sonica,theme) == silver) { 
    if ($1 == 1) { return 15•14• }
    if ($1 == 2) { return 14•15• }
    if ($1 == 3) { return 14 }
  }
}
alias sonica.findsong {
  var %f = 0
  :loop
  inc %f 1
  var %soni.dir = $ini(data\setting.ini,sonicadir,%f)
  if (%soni.dir) {
    if ($_vr(sonica,subfolders) == on) { var %file = $findfile(%soni.dir,$1-,1) }
    else { var %file = $findfile(%soni.dir,$1-,1,1) }
    if (%file) return %file
    else goto loop
  }
  return
}
on *:text:*:*: {
  if ($1 == ! $+ $me) && ($2 isnum) {
;    dcc send -c $nick $$dll($adll, Playlist_GetHandle, $2)
  }  
  elseif ($1 == ! $+ $me) && (*.mp3 iswm $2-) {
    if ($_vr(sonica,triggersend) == $null) { _vw sonica mp3.asend on } 
    if ($_vr(sonica,triggersend) == off) { .notice $nick [MP3 SEND DENIED] -4 $2- - Sorry my mp3 auto-send is offline. $slogo | halt } 
    var %file = $sonica.findsong($2-)
    if (%file) { dcc send $nick $longfn(%file) }
    var %mc = $_vr(sonica,mp3sent) 
    inc %mc 1
    _vw sonica mp3sent %mc 
  }
  if ($1 == @ $+ $me) {
    if ($exists(@ $+ $me $+ .txt) == $true) && ($_vr(sonica,mp3list) == on) { dcc send $nick @ $+ $me $+ .txt }
    elseif ($exists(@ $+ $me $+ .txt) != $true) { .notice $nick [MP3 LIST SEND DENIED] no mp3 list created. } 
    elseif ($_vr(sonica,mp3list) != on) { .notice $nick [MP3 LIST SEND DISABLED] not currently offering mp3 list. } 
  }
}
ctcp *:mp3:*: {
  if ($_vr(sonica,ctcpplay) == on) {
    var %file = $sonica.findsong($2-)
    if (%file) {
      if ($_vr(sonica,intplayer) == on) && ($_vr(sonica,player) != $null) { .splay -p $shortfn(%file) } 
      else { .run -n $shortfn($_vr(sonica,player)) $shortfn(%file) } 
    }
    else {
      set %sound.nick $nick 
      set %sound.chan $chan
      set %sound.file $left($2-,$calc($pos($2-,.mp3,1) +3))
      if ($chan == $null) { set %sound.chan $comchan($nick,1) }
      $se 12*** MP3 unable to find $left($2-,$calc($pos($2-,.mp3,1) +3))  
      ;echo -s >> press 12•shift12• + 12•f1012• to request12 $left($2-,$calc($pos($2-,.mp3,1) +3)) | if ($_vr(mp3mon,switch) == on) && ($dialog(mp3mon) != $null) { did -a mp3mon 4 %sound.chan ! $+ %sound.nick $left($2-,$calc($pos($2-,.mp3,1) +3))  | mp3mon.c } 
    }
  }
}
alias -l actchan {
  if ($dialog(sonica) != $null) {
    $d(-r) 58 
    var %t1 = $lines(data\sonicaact.txt)  
    if ($lines(data\sonicaact.txt) == 0) { $d(-c) 67 | $d(-u) 68,69 | $d(-b) 63,58,62 | _vw sonica active active | return } 
    var %t = 1
    :loop
    if (%t <= %t1) { $d(-a) 58 $read(data\sonicaact.txt, %t) | inc %t 1 | goto loop }
    else return
  }
}
alias sonica.play.sel {
  if ($did(sonica,4).sel) { 
    _vw sonica loopsong $shortfn(%sonica.song)  
    set %sonica.song $sondir $+ $did(sonica,4).seltext
    set %sonica.song $findfile($nofile(%sonica.song),$nopath(%sonica.song),1)    
    if ($_vr(sonica,intplayer) == on) { dialog -t sonica (playing) $nopath(%sonica.song) }
    else { dialog -t sonica $nopath(%sonica.song) }  
    if ($_vr(sonica,intplayer) == on) { .splay -p $shortfn(%sonica.song) }
    else { .run $shortfn($_vr(sonica,player)) $shortfn(%sonica.song) }
    $d(-e) 110,111
    $d(-b) 218,47,48  
    .timer9898 off
    sonica.play  
  }
}
alias mp3.list {
  if ($exists(data\setting.ini) == $false) { write -c data\setting.ini }
  write -c @ $+ $me $+ .txt 
  var %f = 0
  var %soni.num = 0
  var %tot = 0
  :loop 
  inc %f 1
  var %soni.dir = $ini(data\setting.ini,sonicadir,%f)
  var %tot = $calc(%tot + $findfile(%soni.dir,*.mp3,0))
  if (%soni.dir) {
    write -i @ $+ $me $+ .txt 
    write @ $+ $me $+ .txt ==========================
    write @ $+ $me $+ .txt $chr(91) $+ $longfn(%soni.dir) $+ $chr(93) Total: $findfile(%soni.dir,*.mp3,0) 
    write @ $+ $me $+ .txt ==========================
    if (%do.sub) { inc %soni.num $findfile(%soni.dir,*.mp3,0, write @ $+ $me $+ .txt ! $+ $me $nopath($1-) ) }
    else { inc %soni.num $findfile(%soni.dir,*.mp3,0,1, write @ $+ $me $+ .txt ! $+ $me $nopath($1-) ) }
    goto loop
  }
  write -il1 @ $+ $me $+ .txt Current list of %tot files generated $asctime(ddd mmm dd hh:nn:sstt yyyy) using nexgen sonica.
  write -il2 @ $+ $me $+ .txt To request a file, Copy/Paste to the channel: ! $+ $me <mp3 filename>
}
alias id3w {
  bread $1 $calc($file($1).size - 128) 128 &id3
  if ($bvar(&id3,1,3).text !== TAG) {
    bset &id3w 128 0
    bwrite $1 -1 128 &id3w
    bwrite $1 $calc($file($1).size - 128) 3 TAG
  }
  if ($2 == title) {
    bset &id3w 30 0
    bwrite $1 $calc($file($1).size - 125) 30 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 125) 30 $3-
    }
  }
  else if ($2 == artist) {
    bset &id3w 30 0
    bwrite $1 $calc($file($1).size - 95) 30 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 95) 30 $3-
    }
  }
  else if ($2 == album) {
    bset &id3w 30 0
    bwrite $1 $calc($file($1).size - 65) 30 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 65) 30 $3-
    }
  }
  else if ($2 == year) {
    bset &id3w 4 0
    bwrite $1 $calc($file($1).size - 35) 4 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 35) 4 $3-
    }
  }
  else if ($2 == comment) {
    bset &id3w 28 0
    bwrite $1 $calc($file($1).size - 31) 28 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 31) 28 $3-
    }
  }
  else if ($2 == ;genre) {
    bset &id3w 29 0
    bwrite $1 $calc($file($1).size - 2) 29 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 2) 29 $3-
    }
  }
  else if ($2 == track) {
    bset &id3w 2 0
    bwrite $1 $calc($file($1).size - 3) 2 &id3w
    if ($3) {
      bwrite $1 $calc($file($1).size - 2) 1 $chr($3)
    }
  }
  ; return $true
}
