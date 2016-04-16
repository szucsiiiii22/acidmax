menu menubar,status,query,channel {
  $iif($acid == $true,• utilities)
  .nexgen sounds:soundcon
  $iif($acid != $true,nexgen sounds):soundcon
}
alias soundcon {
  if ($dialog(soundcon) == $null) {  dialog -m soundcon soundcon }
}
dialog soundcon {
  title "Sound Console v1.1"
  size -1 -1 170 255
  option dbu
  check "enable nexgen sounds", 2, 10 4 70 14
  check "Join", 3, 38 30 30 14, disable
  button "...", 4, 28 33 7 7
  button "P", 50, 18 33 7 7
  check "Kick", 5, 38 40 30 14, disable
  button "...", 6, 28 43 7 7
  button "P", 51, 18 43 7 7
  check "Ban", 7, 38 50 30 14, disable
  button "...", 8, 28 53 7 7
  button "P", 52, 18 53 7 7
  check "Op", 9, 38 60 22 14, disable
  button "...", 10, 28 63 7 7
  button "P", 53, 18 63 7 7
  check "Deop", 11, 38 70 30 14, disable
  button "...", 12, 28 73 7 7
  button "P", 54, 18 73 7 7
  check "DCC Get Fail", 13, 38 80 46 14, disable
  button "...", 14, 28 83 7 7
  button "P", 55, 18 83 7 7
  check "DCC Send Fail", 15, 38 90 54 14, disable
  button "...", 16, 28 93 7 7
  button "P", 56, 18 93 7 7
  check "File Received", 17, 38 100 46 14, disable
  button "...", 18, 28 103 7 7
  button "P", 57, 18 103 7 7
  check "Connect", 19, 38 120 30 14, disable
  button "...", 20, 28 123 7 7
  button "P", 58, 18 123 7 7
  check "Disconnect", 21, 38 130 38 14, disable
  button "...", 22, 28 133 7 7
  button "P", 59, 18 133 7 7
  check "User Online", 23, 115 90 38 14, disable
  button "...", 24, 104 93 7 7
  button "P", 60, 94 93 7 7
  check "Page", 25, 115 120 22 14, disable
  button "...", 26, 104 123 7 7
  button "P", 61, 94 123 7 7
  check "Paging", 90, 115 130 30 14, disable
  button "...", 91, 104 133 7 7
  button "P", 92, 94 133 7 7
  check "Nexgen", 27, 115 100 30 14, disable
  button "...", 28, 104 103 7 7
  button "P", 62, 94 103 7 7
  check "Ping", 29, 115 110 22 14, disable
  button "...", 30, 104 113 7 7
  button "P", 63, 94 113 7 7
  check "Invite", 31, 115 60 30 14, disable
  button "...", 32, 104 63 7 7
  button "P", 64, 94 63 7 7
  check "File Sent", 33, 38 110 30 14, disable
  button "...", 34, 28 113 7 7
  button "P", 65, 18 113 7 7
  check "Voice", 35, 115 70 30 14, disable
  button "...", 36, 104 73 7 7
  button "P", 66, 94 73 7 7
  check "Devoice", 37, 115 80 38 14, disable
  button "...", 38, 104 83 7 7
  button "P", 67, 94 83 7 7
  check "Query", 69, 38 22 30 10, disable
  button "...", 70, 28 23 7 7
  button "P", 71, 18 23 7 7
  check "Click", 72, 115 50 30 14, disable
  button "...", 73, 104 53 7 7
  button "P", 74, 94 53 7 7
  check "Alarm", 75, 115 22 30 10, disable
  button "...", 76, 104 23 7 7
  button "P", 77, 94 23 7 7
  check "Ignore", 78, 115 30 30 14, disable
  button "...", 79, 104 33 7 7
  button "P", 80, 94 33 7 7
  check "Error", 81, 115 40 22 14, disable
  button "...", 82, 104 43 7 7
  button "P", 83, 94 43 7 7
  list 84, 13 168 112 52, sort size hsbar vsbar
  button "...", 85, 4 168 7 7
  button "P", 86, 4 178 7 7
  edit "", 87, 13 222 112 10, read autohs
  text "sound browser", 88, 16 161 42 7
  button "default", 89, 135 175 24 10
  check "Part", 95, 38 142 30 10, disable
  button "...", 96, 28 143 7 7
  button "P", 97, 18 143 7 7
  button "close", 1, 70 235 30 13, ok
  button "save", 98, 135 190 24 10
  button "load", 99, 135 204 24 10
  box "theme", 39, 130 166 34 54
  box "", 40, 12 17 146 138
  button "R", 41, 4 188 7 7
}
alias soundcon.allon {
  _vw soundcon join 1
  _vw soundcon kick 1
  _vw soundcon ban 1
  _vw soundcon op 1
  _vw soundcon deop 1
  _vw soundcon dccgetfail 1
  _vw soundcon dccsendfail 1
  _vw soundcon dccrec 1
  _vw soundcon connect 1
  _vw soundcon disconnect 1
  _vw soundcon useronline 1
  _vw soundcon page 1
  _vw soundcon version 1
  _vw soundcon ping 1
  _vw soundcon invite 1
  _vw soundcon filesent 1
  _vw soundcon voice 1
  _vw soundcon devoice 1
  _vw soundcon query 1
  _vw soundcon click 1
  _vw soundcon alarm 1
  _vw soundcon ignore 1
  _vw soundcon error 1
  _vw soundcon paging 1
  _vw soundcon part 1
}
on *:dialog:soundcon:init:*:{
  if ($_vr(setup,sound) == $null) { _vw setup sound on | soundcon.allon | def.sound | _vw soundcon sound.path $shortfn($mircdirnexsnd\default\) } 
  if ($_vr(setup,sound) == on) { did -c soundcon 2 | did -e soundcon 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,69,72,75,78,81,90,95 }
  if ($_vr(soundcon,join) == 1)  did -c soundcon 3 
  if ($_vr(soundcon,kick) == 1)  did -c soundcon 5
  if ($_vr(soundcon,ban) == 1)  did -c soundcon 7
  if ($_vr(soundcon,op) == 1)  did -c soundcon 9 
  if ($_vr(soundcon,deop) == 1) did -c soundcon 11 
  if ($_vr(soundcon,dccgetfail) == 1) did -c soundcon 13 
  if ($_vr(soundcon,dccsendfail) == 1) did -c soundcon 15 
  if ($_vr(soundcon,dccrec) == 1)  did -c soundcon 17 
  if ($_vr(soundcon,connect) == 1)  did -c soundcon 19 
  if ($_vr(soundcon,disconnect) == 1) did -c soundcon 21 
  if ($_vr(soundcon,useronline) == 1) did -c soundcon 23 
  if ($_vr(soundcon,page) == 1) did -c soundcon 25 
  if ($_vr(soundcon,version) == 1) did -c soundcon 27 
  if ($_vr(soundcon,ping) == 1) did -c soundcon 29 
  if ($_vr(soundcon,invite) == 1) did -c soundcon 31 
  if ($_vr(soundcon,filesent) == 1) did -c soundcon 33 
  if ($_vr(soundcon,voice) == 1) did -c soundcon 35 
  if ($_vr(soundcon,devoice) == 1) did -c soundcon 37 
  if ( $_vr(soundcon,query) == 1) { did -c soundcon 69 |  _vw querycon soundswitch on }
  if ($_vr(soundcon,click) == 1) did -c soundcon 72 
  if ($_vr(soundcon,alarm) == 1) did -c soundcon 75
  if ($_vr(soundcon,ignore) == 1) did -c soundcon 78
  if ($_vr(soundcon,error) == 1) did -c soundcon 81
  if ($_vr(soundcon,paging) == 1) did -c soundcon 90
  if ($_vr(soundcon,part) == 1) did -c soundcon 95
  sound.list
  did -o soundcon 87 1 $longfn($_vr(soundcon,sound.path))
}
on *:dialog:soundcon:dclick:*:{
  if ($did == 84) { var %sc = $_vr(soundcon,sound.path) $+ $did(84,$did(84).sel) | .splay $shortfn(%sc) } 
}
on *:dialog:soundcon:sclick:*:{
  if ($did == 2) {
    if ($_vr(setup,sound) == off) {  _vw setup sound on | did -e soundcon 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,69,72,76,75,78,81,90,95 }
    elseif ($_vr(setup,sound) == on) { _vw setup sound off | did -b soundcon 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,69,72,76,75,78,81,90,95 }
  } 
  if ($did == 3) { _vw soundcon join $did($did).state } 
  if ($did == 4) { set %tf 4 | .timer -m 1 1 soundcon.sound } 
  if ($did == 50) && ($_vr(soundcon,4) != $null) { splay $shortfn($_vr(soundcon,4)) } 
  if ($did == 5) { _vw soundcon kick $did($did).state } 
  if ($did == 6) { set %tf 6 | .timer -m 1 1 soundcon.sound } 
  if ($did == 51) && ($_vr(soundcon,6) != $null) { splay $shortfn($_vr(soundcon,6)) } 
  if ($did == 7) { _vw soundcon ban $did($did).state } 
  if ($did == 8) { set %tf 8 | .timer -m 1 1 soundcon.sound } 
  if ($did == 52) && ($_vr(soundcon,8) != $null) { splay $shortfn($_vr(soundcon,8)) } 
  if ($did == 9) { _vw soundcon op $did($did).state } 
  if ($did == 10) { set %tf 10 | .timer -m 1 1 soundcon.sound } 
  if ($did == 53) && ($_vr(soundcon,10) != $null) { splay $shortfn($_vr(soundcon,10)) } 
  if ($did == 11) { _vw soundcon deop $did($did).state } 
  if ($did == 12) { set %tf 12 | .timer -m 1 1 soundcon.sound } 
  if ($did == 54) && ($_vr(soundcon,12) != $null) { splay $shortfn($_vr(soundcon,12)) } 
  if ($did == 13) { _vw soundcon dccgetfail $did($did).state } 
  if ($did == 14) { set %tf 14 | .timer -m 1 1 soundcon.sound } 
  if ($did == 55) && ($_vr(soundcon,14) != $null) { splay $shortfn($_vr(soundcon,14)) } 
  if ($did == 15) { _vw soundcon dccsendfail $did($did).state } 
  if ($did == 16) { set %tf 16 | .timer -m 1 1 soundcon.sound } 
  if ($did == 56) && ($_vr(soundcon,16) != $null) { splay $shortfn($_vr(soundcon,16)) } 
  if ($did == 17) { _vw soundcon dccrec $did($did).state } 
  if ($did == 18) { set %tf 18 | .timer -m 1 1 soundcon.sound } 
  if ($did == 57) && ($_vr(soundcon,18) != $null) { splay $shortfn($_vr(soundcon,18)) } 
  if ($did == 19) { _vw soundcon connect $did($did).state } 
  if ($did == 20) { set %tf 20 | .timer -m 1 1 soundcon.sound } 
  if ($did == 58) && ($_vr(soundcon,20) != $null) { splay $shortfn($_vr(soundcon,20)) } 
  if ($did == 21) { _vw soundcon disconnect $did($did).state } 
  if ($did == 22) { set %tf 22 | .timer -m 1 1 soundcon.sound } 
  if ($did == 59) && ($_vr(soundcon,22) != $null) { splay $shortfn($_vr(soundcon,22)) } 
  if ($did == 23) { _vw soundcon useronline $did($did).state } 
  if ($did == 24) { set %tf 24 | .timer -m 1 1 soundcon.sound } 
  if ($did == 60) && ($_vr(soundcon,24) != $null) { splay $shortfn($_vr(soundcon,24)) } 
  if ($did == 25) { _vw soundcon page $did($did).state } 
  if ($did == 26) { set %tf 26 | .timer -m 1 1 soundcon.sound } 
  if ($did == 61) && ($_vr(soundcon,26) != $null) { splay $shortfn($_vr(soundcon,26)) } 
  if ($did == 27) { _vw soundcon version $did($did).state } 
  if ($did == 28) { set %tf 28 | .timer -m 1 1 soundcon.sound } 
  if ($did == 62) && ($_vr(soundcon,28) != $null) { splay $shortfn($_vr(soundcon,28)) } 
  if ($did == 29) { _vw soundcon ping $did($did).state } 
  if ($did == 30) { set %tf 30 | .timer -m 1 1 soundcon.sound } 
  if ($did == 63) && ($_vr(soundcon,30) != $null) { splay $shortfn($_vr(soundcon,30)) } 
  if ($did == 31) { _vw soundcon invite $did($did).state } 
  if ($did == 32) { set %tf 32 | .timer -m 1 1 soundcon.sound } 
  if ($did == 64) && ($_vr(soundcon,32) != $null) { splay $shortfn($_vr(soundcon,32)) } 
  if ($did == 33) { _vw soundcon filesent $did($did).state } 
  if ($did == 34) { set %tf 34 | .timer -m 1 1 soundcon.sound } 
  if ($did == 65) && ($_vr(soundcon,34) != $null) { splay $shortfn($_vr(soundcon,34)) } 
  if ($did == 35) { _vw soundcon voice $did($did).state } 
  if ($did == 36) { set %tf 36 | .timer -m 1 1 soundcon.sound } 
  if ($did == 66) && ($_vr(soundcon,36) != $null) { splay $shortfn($_vr(soundcon,36)) } 
  if ($did == 37) { _vw soundcon devoice $did($did).state } 
  if ($did == 38) { set %tf 38 | .timer -m 1 1 soundcon.sound } 
  if ($did == 67) && ($_vr(soundcon,38) != $null) { splay $shortfn($_vr(soundcon,38)) } 
  if ($did == 69) { 
    _vw soundcon query $did($did).state
    if ($_vr(soundcon,query) == 1) { _vw querycon soundswitch on }
    elseif ($_vr(soundcon,query) == 0) { _vw querycon soundswitch off }   
  } 
  if ($did == 70) { set %tf 70 | .timer -m 1 1 soundcon.sound | _vw querycon sound $_vr(soundcon,70) } 
  if ($did == 71) && ($_vr(soundcon,70) != $null) { splay $shortfn($_vr(soundcon,70)) } 
  if ($did == 90) { _vw soundcon paging $did($did).state } 
  if ($did == 91) { set %tf 91 | .timer -m 1 1 soundcon.sound } 
  if ($did == 92) && ($_vr(soundcon,91) != $null) { splay $shortfn($_vr(soundcon,91)) } 
  if ($did == 95) { _vw soundcon part $did($did).state } 
  if ($did == 96) { set %tf 96 | .timer -m 1 1 soundcon.sound } 
  if ($did == 97) && ($_vr(soundcon,96) != $null) { splay $shortfn($_vr(soundcon,96)) } 
  if ($did == 41) { sound.list }
  if ($did == 72) { _vw soundcon click $did($did).state } 
  if ($did == 73) { set %tf 73 | .timer -m 1 1 soundcon.sound } 
  if ($did == 74) && ($_vr(soundcon,73) != $null) { splay $shortfn($_vr(soundcon,73)) } 
  if ($did == 75) { _vw soundcon alarm $did($did).state } 
  if ($did == 76) { set %tf 76 | .timer -m 1 1 soundcon.sound } 
  if ($did == 77) && ($_vr(soundcon,76) != $null) { splay $shortfn($_vr(soundcon,76)) } 
  if ($did == 78) { _vw soundcon ignore $did($did).state } 
  if ($did == 79) { set %tf 79 | .timer -m 1 1 soundcon.sound } 
  if ($did == 80) && ($_vr(soundcon,79) != $null) { splay $shortfn($_vr(soundcon,79)) } 
  if ($did == 81) { _vw soundcon error $did($did).state } 
  if ($did == 82) { set %tf 82 | .timer -m 1 1 soundcon.sound } 
  if ($did == 83) && ($_vr(soundcon,82) != $null) { splay $shortfn($_vr(soundcon,82)) } 
  if ($did == 85) { .timer -m 1 1 sound.folder }
  if ($did == 86) { var %sc = $_vr(soundcon,sound.path) $+ $did(84,$did(84).sel) | .splay $shortfn(%sc)  }
  if ($did == 89) { sclick | def.sound }
  if ($did == 99) { sclick | .timer -m 1 1 soundcon.theme }
  if ($did == 98) { 
    sclick 
    .timer -m 1 1 sdcon.theme.name 
    mkdir  nexsnd\themecfg\  
    wsnt $_vr(soundcon,theme.name) soundcon 96 $_vr(soundcon,96)
    wsnt $_vr(soundcon,theme.name) soundcon 4 $_vr(soundcon,4)
    wsnt $_vr(soundcon,theme.name) soundcon 73 $_vr(soundcon,73)
    wsnt $_vr(soundcon,theme.name) soundcon 70 $_vr(soundcon,70)
    wsnt $_vr(soundcon,theme.name) soundcon 22 $_vr(soundcon,22)
    wsnt $_vr(soundcon,theme.name) soundcon 76 $_vr(soundcon,76)
    wsnt $_vr(soundcon,theme.name) soundcon 10 $_vr(soundcon,10)
    wsnt $_vr(soundcon,theme.name) soundcon 8 $_vr(soundcon,8)
    wsnt $_vr(soundcon,theme.name) soundcon 20 $_vr(soundcon,20)
    wsnt $_vr(soundcon,theme.name) soundcon 6 $_vr(soundcon,6)
    wsnt $_vr(soundcon,theme.name) soundcon 18 $_vr(soundcon,18)
    wsnt $_vr(soundcon,theme.name) soundcon 79 $_vr(soundcon,79)
    wsnt $_vr(soundcon,theme.name) soundcon 12 $_vr(soundcon,12)
    wsnt $_vr(soundcon,theme.name) soundcon 28 $_vr(soundcon,28)
    wsnt $_vr(soundcon,theme.name) soundcon 14 $_vr(soundcon,14)
    wsnt $_vr(soundcon,theme.name) soundcon 16 $_vr(soundcon,16)
    wsnt $_vr(soundcon,theme.name) soundcon 24 $_vr(soundcon,24)
    wsnt $_vr(soundcon,theme.name) soundcon 82 $_vr(soundcon,82)
    wsnt $_vr(soundcon,theme.name) soundcon 26 $_vr(soundcon,26)
    wsnt $_vr(soundcon,theme.name) soundcon 30 $_vr(soundcon,30)
    wsnt $_vr(soundcon,theme.name) soundcon 32 $_vr(soundcon,32)
    wsnt $_vr(soundcon,theme.name) soundcon 34 $_vr(soundcon,34)
    wsnt $_vr(soundcon,theme.name) soundcon 36 $_vr(soundcon,36)
    wsnt $_vr(soundcon,theme.name) soundcon 38 $_vr(soundcon,38)  
    wsnt $_vr(soundcon,theme.name) soundcon 91 $_vr(soundcon,91)
    wsnt $_vr(soundcon,theme.name) soundcon 88 $_vr(soundcon,88)
  }
} 
alias -l sntr {
  return $readini $_vr(soundcon,theme) $$1 $$2  $$3
}
alias -l sndc.load {
  _vw soundcon 96 $sntr(soundcon,96)
  _vw  soundcon 4 $sntr(soundcon,4)
  _vw  soundcon 73 $sntr(soundcon,73)
  _vw  soundcon 70 $sntr(soundcon,70)
  _vw  soundcon 22 $sntr(soundcon,22)
  _vw  soundcon 76 $sntr(soundcon,76)
  _vw  soundcon 10 $sntr(soundcon,10)
  _vw  soundcon 8 $sntr(soundcon,8)
  _vw  soundcon 20 $sntr(soundcon,20)
  _vw  soundcon 6 $sntr(soundcon,6)
  _vw  soundcon 18 $sntr(soundcon,18)
  _vw  soundcon 79 $sntr(soundcon,79)
  _vw  soundcon 12 $sntr(soundcon,12)
  _vw  soundcon 28 $sntr(soundcon,28)
  _vw  soundcon 14 $sntr(soundcon,14)
  _vw  soundcon 16 $sntr(soundcon,16)
  _vw  soundcon 24 $sntr(soundcon,24)
  _vw  soundcon 82 $sntr(soundcon,82)
  _vw  soundcon 26 $sntr(soundcon,26)
  _vw  soundcon 30 $sntr(soundcon,30)
  _vw  soundcon 32 $sntr(soundcon,32)
  _vw  soundcon 34 $sntr(soundcon,34)
  _vw  soundcon 36 $sntr(soundcon,36)
  _vw  soundcon 38 $sntr(soundcon,38)  
  _vw  soundcon 91 $sntr(soundcon,91)
  _vw  soundcon 88 $sntr(soundcon,88)

}
alias soundcon.theme _vw soundcon theme $$dir="Select a theme" nexsnd\themecfg\*.thm | sndc.load
alias -l wsnt  writeini nexsnd\themecfg\ $+ $1 $$2 $$3 $$4-
alias -l sdcon.theme.name set %tsd  $$?="Name your sound theme" | _vw soundcon theme.name %tsd $++ .thm

on *:PART:#: if ($nick == $me) && ($_vr(setup,sound) == on) && ($_vr(soundcon,part) == 1) && ($_vr(soundcon,96) != $null) blast $_vr(soundcon,96)
on *:JOIN:#: if ($nick == $me) && ($_vr(setup,sound) == on) && ($_vr(soundcon,join) == 1) && ($_vr(soundcon,4) != $null) blast $_vr(soundcon,4)
on *:CONNECT: if ($_vr(setup,sound) == on) && ($_vr(soundcon,connect) == 1) && ($_vr(soundcon,20) != $null) blast.q $_vr(soundcon,20)
on *:disconnect: if ($_vr(setup,sound) == on) && ($_vr(soundcon,disconnect) == 1) && ($_vr(soundcon,22) != $null) blast $_vr(soundcon,22)
on *:ERROR:*: if ($_vr(setup,sound) == on) && ($_vr(soundcon,error) == 1) && ($_vr(soundcon,82) != $null) blast $_vr(soundcon,82)
ctcp *:*:PAGE: if ($_vr(setup,sound) == on) && ($_vr(soundcon,page) == 1) && ($_vr(soundcon,26) != $null) blast $_vr(soundcon,26)
ctcp *:*:PING: if ($_vr(setup,sound) == on) && ($_vr(soundcon,ping) == 1) && ($_vr(soundcon,30) != $null) blast $_vr(soundcon,30)
on *:DEOP:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,deop) == 1) && ($_vr(soundcon,12) != $null) blast $_vr(soundcon,12)
on *:OP:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,op) == 1) && ($_vr(soundcon,10) != $null) blast $_vr(soundcon,10)
on *:VOICE:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,voice) == 1) && ($_vr(soundcon,36) != $null) blast $_vr(soundcon,36)
on *:DEVOICE:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,devoice) == 1) && ($_vr(soundcon,38) != $null) blast $_vr(soundcon,38)
on *:SENDFAIL:*.*: if ($_vr(setup,sound) == on) && ($_vr(soundcon,dccsendfail) == 1) && ($_vr(soundcon,16) != $null) blast $_vr(soundcon,16)
on *:GETFAIL:*.*: if ($_vr(setup,sound) == on) && ($_vr(soundcon,dccgetfail) == 1) && ($_vr(soundcon,14) != $null) blast $_vr(soundcon,14)
on *:FILERCVD:*.*: if ($_vr(setup,sound) == on) && ($_vr(soundcon,dccrec) == 1) && ($_vr(soundcon,18) != $null) blast $_vr(soundcon,18)
on *:FILESENT:*.*: if ($_vr(setup,sound) == on) && ($_vr(soundcon,dccsent) == 1) && ($_vr(soundcon,34) != $null) blast $_vr(soundcon,34)
on *:NOTIFY: if ($_vr(setup,sound) == on) && ($_vr(soundcon,useronline) == 1) && ($_vr(soundcon,24) != $null) blast.q $_vr(soundcon,24)
on *:KICK:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,kick) == 1) && ($_vr(soundcon,6) != $null) blast $_vr(soundcon,6)
on *:BAN:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,ban) == 1) && ($_vr(soundcon,7) != $null) blast $_vr(soundcon,8)
on *:INVITE:#: if ($_vr(setup,sound) == on) && ($_vr(soundcon,invite) == 1) && ($_vr(soundcon,32) != $null) blast $_vr(soundcon,32)
on *:OPEN:?: { if ($_vr(setup,sound) == on) && ($_vr(soundcon,query) == 1) && ($_vr(soundcon,70) != $null) { _vw querycon sound $_vr(soundcon,70) | blast $_vr(soundcon,70) } }

alias -l soundcon.sound {
  var %sc = $$dir="Please select a sound file for this sound event:" $mircdirnexsnd\*.wav;*.mp3;*.mid 
  _vw soundcon %tf $shortfn(%sc) 
  ; unset %tf
}        
alias sclick { if ($_vr(soundcon,click) == 1) { blast $_vr(soundcon,73) } }
alias snexgen { if ($_vr(soundcon,version) == 1) { blast  $_vr(soundcon,28) } }
alias skick { if ($_vr(setup,sound) == on) && ($_vr(soundcon,kick) == 1) && ($_vr(soundcon,6) != $null) blast $_vr(soundcon,6) }
alias sops { if ($_vr(setup,sound) == on) && ($_vr(soundcon,op) == 1) && ($_vr(soundcon,10) != $null) blast $_vr(soundcon,10) }
alias salert { if ($_vr(setup,sound) == on) && ($_vr(soundcon,alarm) == 1) && ($_vr(soundcon,76) != $null) blast $_vr(soundcon,76) }
alias sinvite1 { if ($_vr(setup,sound) == on) && ($_vr(soundcon,invite) == 1) && ($_vr(soundcon,32) != $null) blast $_vr(soundcon,32) }
alias salarm { if ($_vr(setup,sound) == on) && ($_vr(soundcon,alarm) == 1) && ($_vr(soundcon,76) != $null) blast $_vr(soundcon,76) }
alias signore { if ($_vr(setup,sound) == on) && ($_vr(soundcon,ignore) == 1) && ($_vr(soundcon,79) != $null) blast $_vr(soundcon,79) }
alias saway { if ($_vr(soundcon,away) == 1) { blast " $+ $_vr(soundcon,soundtheme) $+ away.wav $+ "  } }
alias spaging { if ($_vr(setup,sound) == on) && ($_vr(soundcon,paging) == 1) && ($_vr(soundcon,91) != $null) blast $_vr(soundcon,91) }
alias spage { if ($_vr(soundcon,blast.spage) == on) { blast.q " $+ $_vr(soundcon,soundtheme) $+ page.wav $+ "  } }
alias sstealth { if ($_vr(soundcon,blast.sstealth) == on) { blast.q " $+ $_vr(soundcon,soundtheme) $+ STLTHON.wav $+ "  } }
alias sstlthon { if ($_vr(soundcon,blast.sstealth) == on) { blast.q " $+ $_vr(soundcon,soundtheme) $+ STLTHON.wav $+ "  } }
alias salert { if ($_vr(soundcon,blast.salert) == on) { blast.q " $+ $_vr(soundcon,soundtheme) $+ alert.wav $+ "  } }
alias sinvite2 { if ($_vr(setup,sound) == on) { blast " $+ $_vr(soundcon,soundtheme) $+ invite2.wav $+ "  } }
alias sexit { if ($_vr(setup,sound) == on) && ($_vr(soundcon,click) == 1) && ($_vr(soundcon,73) != $null) blast $_vr(soundcon,73) }
alias serror { if ($_vr(setup,sound) == on) && ($_vr(soundcon,error) == 1) && ($_vr(soundcon,82) != $null) blast $_vr(soundcon,82) }
alias signoreon { if ($_vr(setup,sound) == on) && ($_vr(soundcon,ignore) == 1) && ($_vr(soundcon,79) != $null) blast $_vr(soundcon,79) }
alias soff { if ($_vr(setup,sound) == on) && ($_vr(soundcon,click) == 1) && ($_vr(soundcon,73) != $null) blast $_vr(soundcon,73) }
alias son { if ($_vr(setup,sound) == on) && ($_vr(soundcon,click) == 1) && ($_vr(soundcon,73) != $null) blast $_vr(soundcon,73) }
alias son3 { if ($_vr(setup,sound) == on) && ($_vr(soundcon,click) == 1) && ($_vr(soundcon,73) != $null) blast $_vr(soundcon,73) }
alias son2 { if ($_vr(setup,sound) == on) && ($_vr(soundcon,click) == 1) && ($_vr(soundcon,73) != $null) blast $_vr(soundcon,73) }
alias sban { if ($_vr(setup,sound) == on) && ($_vr(soundcon,ban) == 1) && ($_vr(soundcon,8) != $null) blast $_vr(soundcon,8) }
alias soundcon.l { if ($_vr(setup,sound) == $null) { soundcon.allon | def.sound | _vw setup sound on | _vw soundcon sound.path $shortfn($mircdirnexsnd\default\) } }
alias sound.list {
  if ($dialog(soundcon) != $null) { did -r soundcon 84 }
  var %filenum = 1
  var %am = $findfile($_vr(soundcon,sound.path),*.wav,0) 
  :find 
  if (%filenum <= %am) { var %findfile = $findfile($_vr(soundcon,sound.path),*.wav,%filenum) | inc %filenum 1 |  if ($dialog(soundcon) != $null) { did -i soundcon 84 1 $nopath(%findfile) } | goto find }
  else { a }
}
alias -l a {
  var %filenum = 1
  var %am = $findfile($_vr(soundcon,sound.path),*.mp3,0) 
  :find
  if (%filenum <= %am) { var %findfile = $findfile($_vr(soundcon,sound.path),*.mp3,%filenum) | inc %filenum 1 | if ($dialog(soundcon) != $null) { did -i soundcon 84 1 $nopath($longfn(%findfile)) } | goto find }
  else { b } 
}
alias -l b {
  var %filenum = 1
  var %am = $findfile($_vr(soundcon,sound.path),*.mid,0) 
  while (%filenum <= %am) { var %findfile = $findfile($_vr(soundcon,sound.path),*.mid,%filenum) | inc %filenum 1 | did -i soundcon 84 1 $nopath(%findfile) }
}
alias -l sound.folder { if ($_vr(soundcon,sound.path) == $null) { _vw soundcon sound.path $mircdirnexsnd\default\ } | _vrem soundcon sound.path | _vw soundcon sound.path $shortfn($$sdir="Select a directory") $longfn($_vr(soundcon,sound.path)) | did -o soundcon 87 1 $longfn($_vr(soundcon,sound.path)) | sound.list }
alias -l t if ($exists($shortfn($findfile(nexsnd\default,$2,1))) == $true) { return _vw soundcon $1 $shortfn($findfile(nexsnd\default,$2,1)) }
alias  def.sound {
  _vw soundcon sound.path $shortfn($mircdirnexsnd\default\)
  if ($dialog(soundcon) != $null) { did -o soundcon 87 1 $longfn($_vr(soundcon,sound.path)) }
  $t(4,join.wav)
  $t(6,kick.wav)
  $t(8,ban.wav)
  $t(10,op.wav)
  $t(12,deop.wav)
  $t(14,failed.wav)
  $t(16,failed.wav)
  $t(18,complete.wav)
  $t(20,startup.wav)
  $t(22,disconnect.wav)
  $t(24,notify.wav)
  $t(26,page.wav)
  $t(28,acidmax.mp3)
  $t(30,default.wav)
  $t(32,invite1.wav)
  $t(34,complete.wav)
  $t(36,voice.wav)
  $t(38,devoice.wav)
  $t(70,message.wav)
  $t(73,click.wav)
  $t(79,ignoreon.wav)
  $t(82,error.wav)
  $t(91,paging.wav)
  $t(96,part.wav)
  $t(76,alarm.wav)
  sound.list
}
alias blast  {
  if ($_vr(setup,sound) != off) {
    if ($1 == $null) { def.sound }
    elseif ($exists($shortfn($$1)) == $true) { splay $shortfn($$1) }
    else return 
  }
}
alias -l blast.q  {
  if ($_vr(setup,sound) != off) {
    if ($1 == $null) { def.sound }
    elseif ($exists($shortfn($$1)) == $true) { splay -q $shortfn($$1) }
    else return 
  }
}
