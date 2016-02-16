;Script Manager v1.51
;Team Nexgen 2001 by KnightFal
;team-nexgen.com

on *:load:{ 
  if ($version < 5.91) echo -a  $+ $colour(info2) $+ *** You need mirc 5.91 or greator in order to use this addon. | beep 
  echo -a  4TEAM NEXGEN'S SCRIPT MANAGER v1.51 | echo -a  4Please type: /scriptman to begin.
}
menu menubar,status,query,channel {
  $iif($acid == $true,• $l(26,utilities))
  .script manager:scriptman
  $iif($acid != $true,script manager):scriptman
}
alias scriptman.version { return v1.51 }
alias rsloaded {
  did -r scriptman 10
  var %i = 0
  did -a scriptman 10 $readini mirc.ini rfiles [ n $+ [ %i ] ] 
  :loop
  inc %i 1
  did -a scriptman 10 $readini mirc.ini rfiles [ n $+ [ %i ] ]
  var %i2 = $readini mirc.ini rfiles [ n $+ [ %i ] ]
  if (%i2 == $null) { goto end } 
  else goto loop
  :end
}
alias rscheck {
  did -r scriptman 12
  if ($_vr(script.path,dir1) == $null) _vw script.path dir1 $scriptdir
  var %script.path = $_vr(script.path,dir1)
  set %filenum 1
  set %findfile $findfile(%script.path, %_ext ,%filenum) 
  if (%findfile == $null) { dec %filenum | goto end }
  else {
    if ($dialog(scriptman) != $null) { did -a scriptman 12 %findfile }  
    :findfile
    inc %filenum 1
    set %findfile $findfile(%script.path, %_ext ,%filenum)
    if (%findfile == $null) { goto end }
    else {
      if ($dialog(scriptman) !=  $null) { did -a scriptman 12 %findfile }
      goto findfile
    }  
    :end  
  }
  var %loop = 0
  :loop
  inc %loop 1
  var %list = $readini data\setting.ini script.path [ dir $+ [ %loop ] ]
  if (%list != $null) {
    if ($left(%list, $len(%script.path)) == %script.path) goto loop
    if ((%sub == on) && ($left(%script.path, $len(%list)) == %list)) goto loop
    if (%sub == on) { var %temp = $findfile(%list, *.mp3, 0,  did -a scriptman 12 $1- ) }
    else { var %temp = $findfile(%list, %_ext , 0, 1, did -a scriptman 12 $1- ) }
    goto loop
  }
}
alias scriptman {
  if ($dialog(scriptman) == $null) { dialog -m scriptman scriptman }
}
dialog scriptman {
  title "Script Manager v1.51"
  size 565 308 304 272
  button "ok", 2, 120 244 50 20, ok
  tab "loaded scripts", 7, 5 8 295 267
  list 10, 14 35 276 152, tab 7 sort hsbar vsbar
  button "unload", 11, 15 192 50 20, tab 7
  button "view", 15, 73 192 50 20, tab 7
  tab "scripts", 8
  list 12, 14 35 276 152, tab 8 sort hsbar vsbar
  button "set path", 13, 143 216 50 20, tab 8
  button "view", 16, 73 192 50 20, tab 8
  combo 22, 204 215 86 100, tab 8 drop
  text "file type", 23, 205 195 50 15, tab 8
  button "load", 14, 15 192 50 20, tab 8
  button "delete", 17, 142 192 50 20, tab 8
}
on *:dialog:scriptman:init:*:{
  did -a scriptman 22 *.mrc |  did -a scriptman 22 *.ini | did -a scriptman 22 *.txt | did -a scriptman 22 *.doc | did -a scriptman 22 *.* 
  did -c scriptman 22 1 | set %_ext *.mrc
  rsloaded
  rscheck
}
on *:dialog:scriptman:sclick:*:{
  if ($did == 11) { 
    if (scriptman.mrc !isin $did(10,$did(10).sel)) && ($did(10,$did(10).sel) != $null) { 
      .unload -rs $did(10,$did(10).sel)
      .timer -m 1 1 rsloaded
    }
  }
  if ($did == 14) { 
    .load -rs $shortfn($nofile($did(12,$did(12).sel))) $+ $nopath($did(12,$did(12).sel))
    rsloaded 
  }
  if ($did == 13) { .timer -m 1 1 _ty }
  if ($did == 15) && ($did(10,$did(10).sel)  != $null) { run notepad $did(10,$did(10).sel) }
  if ($did == 16) { run notepad $did(12,$did(12).sel) }
  if ($did == 17) { set %t.1 $did(12,$did(12).sel) | rsaskdel }
  if ($did == 22) { set %_ext $did(22,$did(22).sel) | rscheck }
}
on *:dialog:scriptman:dclick:*:{
  if ($did == 10) && ($did(10,$did(10).sel)  != $null) { 
    .unload -rs $did(10,$did(10).sel)
    rsloaded
  }
  if ($did == 12) { 
    .load -rs $did(12,$did(12).sel)
    rsloaded
  }
}
on *:dialog:scriptman:edit:*:{ 

}
alias _ty {
  var %rs.path = $$sdir="Select Script directory"  c:\*.* 
  var %dirnum = 1
  _vw script.path dir1 %rs.path 
  :another
  var %another = $?!="Another Script dir?"
  if (%another == $true) {
    inc %dirnum 1
    var %rs.path2 = [ dir $+ [ %dirnum ] ]  $sdir="Location of next Script dir?" 
    _vw script.path %rs.path2
    goto another
  }
  if ($dialog(scriptman) != $null)  { if ($_vr(script.path,dir1) == $null) { _ty | halt } | rscheck }
}
alias rsaskdel {
  if ($dialog(rsaskdel) == $null) {  dialog -m rsaskdel rsaskdel   }
}
dialog rsaskdel {
  title "Delete Confirmation"
  size -1 -1 250 75
  icon 99, 30 20 35 35, mirc.exe , 15
  button "No",1,130 40 50 20, cancel
  button "Yes", 2, 70 40 50 20
  text "Are you sure you want to delete?", 98, 50 20 200 15  
}
on *:dialog:rsaskdel:sclick:*:{
  if ($did == 2) { 
    if ($dialog(scriptman) != $null) { remove %t.1 | rscheck | unset %t.1 | dialog -x rsaskdel }
  } 
}
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
alias loadscript {
  if ($exists($mircdirdownload\ $+ $1) == $true) || ($exists($mircdirdownload\misc\ $+ $1) == $true) {
    else  echo -a •• cannot find $1 script
    if ($exists($mircdirsys\ $+ $1) == $true) { .remove $mircdirsys\ $+ $1 }
    if ($exists($mircdirdownload\ $+ $1) == $true) { .copy $findfile($mircdirdownload,$1,1) $mircdirsys }
    elseif ($exists($mircdirdownload\misc\ $+ $1) == $true) { .copy $findfile($mircdirdownload\misc,$1,1) $mircdirsys }
    .load -rs $mircdirsys\ $+ $1 | echo -a  $+ $colour(info) $+ •• moved and loaded $1 script to $mircdirsys
  }
}
alias unloadscript {
  if ($script($1) != $null) { .unload -rs $1 | echo -a  $+ $colour(info) $+ •• unloaded $1 script }
  else echo -a  $+ $colour(info) $+ •• $1 script is not loaded
}
