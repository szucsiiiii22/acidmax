alias fkey { if ($dialog(fkey) == $null) { dialog -m fkey fkey } }
dialog fkey {
  title "function keys"
  size -1 -1 188 375
  button "close", 2, 67 341 60 20, ok
  tab "fn", 1, 8 2 172 371
  button "F1", 4, 18 35 30 20, tab 1
  button "F2", 5, 18 60 30 20, tab 1
  button "F3", 6, 18 85 30 20, tab 1
  button "F4", 11, 18 110 30 20, tab 1
  edit "", 12, 69 111 100 20, tab 1 autohs
  edit "", 13, 69 86 100 20, tab 1 autohs
  edit "", 14, 69 61 100 20, tab 1 autohs
  edit "", 15, 69 36 100 20, tab 1 autohs
  button "F5", 29, 18 135 30 20, tab 1
  button "F6", 30, 18 160 30 20, tab 1
  button "F7", 31, 18 185 30 20, tab 1
  button "F8", 32, 18 210 30 20, tab 1
  edit "", 33, 69 211 100 20, tab 1 autohs
  edit "", 34, 69 186 100 20, tab 1 autohs
  edit "", 35, 69 161 100 20, tab 1 autohs
  edit "", 36, 69 136 100 20, tab 1 autohs
  button "F12", 38, 19 311 30 20, tab 1
  button "F11", 39, 19 286 30 20, tab 1
  button "F10", 40, 19 261 30 20, tab 1
  button "F9", 41, 19 236 30 20, tab 1
  edit "", 42, 70 237 100 20, tab 1 autohs
  edit "", 43, 70 262 100 20, tab 1 autohs
  edit "", 44, 70 287 100 20, tab 1 autohs
  edit "", 45, 70 312 100 20, tab 1 autohs
  tab "shift + fn", 3
  button "SF1", 20, 18 35 30 20, tab 3
  button "SF2", 21, 18 60 30 20, tab 3
  button "SF3", 22, 18 85 30 20, tab 3
  button "SF4", 23, 18 110 30 20, tab 3
  edit "", 10, 69 111 100 20, tab 3 autohs
  edit "", 9, 69 86 100 20, tab 3 autohs
  edit "", 8, 69 61 100 20, tab 3 autohs
  edit "", 7, 69 36 100 20, tab 3 autohs
  button "SF5", 46, 18 135 30 20, tab 3
  button "SF6", 47, 18 160 30 20, tab 3
  button "SF7", 48, 18 185 30 20, tab 3
  button "SF8", 49, 18 210 30 20, tab 3
  button "SF9", 50, 19 236 30 20, tab 3
  button "SF10", 51, 19 261 30 20, tab 3
  button "SF11", 52, 19 286 30 20, tab 3
  button "SF12", 53, 19 311 30 20, tab 3
  edit "", 54, 70 312 100 20, tab 3 autohs
  edit "", 55, 70 287 100 20, tab 3 autohs
  edit "", 56, 70 262 100 20, tab 3 autohs
  edit "", 57, 70 237 100 20, tab 3 autohs
  edit "", 58, 69 211 100 20, tab 3 autohs
  edit "", 59, 69 186 100 20, tab 3 autohs
  edit "", 60, 69 161 100 20, tab 3 autohs
  edit "", 61, 69 136 100 20, tab 3 autohs
  tab "ctrl + fn", 16
  button "CF1", 17, 18 35 30 20, tab 16
  button "CF2", 18, 18 60 30 20, tab 16
  button "CF3", 19, 18 85 30 20, tab 16
  button "CF4", 24, 18 110 30 20, tab 16
  edit "", 25, 69 111 100 20, tab 16 autohs
  edit "", 26, 69 86 100 20, tab 16 autohs
  edit "", 27, 69 61 100 20, tab 16 autohs
  edit "", 28, 69 36 100 20, tab 16 autohs
  button "CF5", 62, 18 136 30 20, tab 16
  button "CF6", 63, 18 161 30 20, tab 16
  button "CF7", 64, 18 186 30 20, tab 16
  button "CF8", 65, 18 211 30 20, tab 16
  button "CF9", 66, 19 237 30 20, tab 16
  button "CF10", 67, 19 262 30 20, tab 16
  button "CF11", 68, 19 287 30 20, tab 16
  button "CF12", 69, 19 312 30 20, tab 16
  edit "", 70, 70 313 100 20, tab 16 autohs
  edit "", 71, 70 288 100 20, tab 16 autohs
  edit "", 72, 70 263 100 20, tab 16 autohs
  edit "", 73, 70 238 100 20, tab 16 autohs
  edit "", 74, 69 212 100 20, tab 16 autohs
  edit "", 75, 69 187 100 20, tab 16 autohs
  edit "", 76, 69 162 100 20, tab 16 autohs
  edit "", 77, 69 137 100 20, tab 16 autohs
}
on *:dialog:fkey:init:*:{
  if ($_vr(fkey,commandcf4) == $null) { _vw fkey commandcf4 cwindow } 
  if ($_vr(fkey,commandf1) == $null) { _vw fkey commandf1 setup } 
  if ($_vr(fkey,commandf3) == $null) { _vw fkey commandf3 splay stop } 
  if ($_vr(fkey,commandf6) == $null) { _vw fkey commandf6 awaybox } 
  if ($_vr(fkey,commandf12) == $null) { _vw fkey commandf12 ignoreall } 
  if ($_vr(fkey,commandf1) != $null) { did -a fkey 15 $_vr(fkey,commandf1) } 
  if ($_vr(fkey,commandf2) != $null) { did -a fkey 14 $_vr(fkey,commandf2) } 
  if ($_vr(fkey,commandf3) != $null) { did -a fkey 13 $_vr(fkey,commandf3) } 
  if ($_vr(fkey,commandf4) != $null) { did -a fkey 12 $_vr(fkey,commandf4) } 
  if ($_vr(fkey,commandf5) != $null) { did -a fkey 36 $_vr(fkey,commandf5) } 
  if ($_vr(fkey,commandf6) != $null) { did -a fkey 35 $_vr(fkey,commandf6) } 
  if ($_vr(fkey,commandf7) != $null) { did -a fkey 34 $_vr(fkey,commandf7) } 
  if ($_vr(fkey,commandf8) != $null) { did -a fkey 33 $_vr(fkey,commandf8) } 
  if ($_vr(fkey,commandf9) != $null) { did -a fkey 42 $_vr(fkey,commandf9) } 
  if ($_vr(fkey,commandf10) != $null) { did -a fkey 43 $_vr(fkey,commandf10) } 
  if ($_vr(fkey,commandf11) != $null) { did -a fkey 44 $_vr(fkey,commandf11) } 
  if ($_vr(fkey,commandf12) != $null) { did -a fkey 45 $_vr(fkey,commandf12) } 
  if ($_vr(fkey,commandsf1) != $null) { did -a fkey 7 $_vr(fkey,commandsf1) } 
  if ($_vr(fkey,commandsf2) != $null) { did -a fkey 8 $_vr(fkey,commandsf2) } 
  if ($_vr(fkey,commandsf3) != $null) { did -a fkey 9 $_vr(fkey,commandsf3) } 
  if ($_vr(fkey,commandsf4) != $null) { did -a fkey 10 $_vr(fkey,commandsf4) } 
  if ($_vr(fkey,commandsf5) != $null) { did -a fkey 61 $_vr(fkey,commandsf5) } 
  if ($_vr(fkey,commandsf6) != $null) { did -a fkey 60 $_vr(fkey,commandsf6) } 
  if ($_vr(fkey,commandsf7) != $null) { did -a fkey 59 $_vr(fkey,commandsf7) } 
  if ($_vr(fkey,commandsf8) != $null) { did -a fkey 58 $_vr(fkey,commandsf8) } 
  if ($_vr(fkey,commandsf9) != $null) { did -a fkey 57 $_vr(fkey,commandsf9) } 
  if ($_vr(fkey,commandsf10) != $null) { did -a fkey 56 $_vr(fkey,commandsf10) } 
  if ($_vr(fkey,commandsf11) != $null) { did -a fkey 55 $_vr(fkey,commandsf11) } 
  if ($_vr(fkey,commandsf12) != $null) { did -a fkey 54 $_vr(fkey,commandsf12) } 
  if ($_vr(fkey,commandcf1) != $null) { did -a fkey 28 $_vr(fkey,commandcf1) } 
  if ($_vr(fkey,commandcf2) != $null) { did -a fkey 27 $_vr(fkey,commandcf2) } 
  if ($_vr(fkey,commandcf3) != $null) { did -a fkey 26 $_vr(fkey,commandcf3) } 
  if ($_vr(fkey,commandcf4) != $null) { did -a fkey 25 $_vr(fkey,commandcf4) } 
  if ($_vr(fkey,commandcf5) != $null) { did -a fkey 77 $_vr(fkey,commandcf5) } 
  if ($_vr(fkey,commandcf6) != $null) { did -a fkey 76 $_vr(fkey,commandcf6) } 
  if ($_vr(fkey,commandcf7) != $null) { did -a fkey 75 $_vr(fkey,commandcf7) } 
  if ($_vr(fkey,commandcf8) != $null) { did -a fkey 74 $_vr(fkey,commandcf8) } 
  if ($_vr(fkey,commandcf9) != $null) { did -a fkey 73 $_vr(fkey,commandcf9) } 
  if ($_vr(fkey,commandcf10) != $null) { did -a fkey 72 $_vr(fkey,commandcf10) } 
  if ($_vr(fkey,commandcf11) != $null) { did -a fkey 71 $_vr(fkey,commandcf11) } 
  if ($_vr(fkey,commandcf12) != $null) { did -a fkey 70 $_vr(fkey,commandcf12) } 
}
on *:dialog:fkey:sclick:*:{
  if ($did == 4) { if ($did(fkey,15).text != $null) { $did(fkey,15).text } }
  if ($did == 5) { if ($did(fkey,14).text != $null) { $did(fkey,14).text } }
  if ($did == 6) { if ($did(fkey,13).text != $null) { $did(fkey,13).text } }
  if ($did == 11) { if ($did(fkey,12).text != $null) { $did(fkey,12).text } }
  if ($did == 29) { if ($did(fkey,36).text != $null) { $did(fkey,36).text } }
  if ($did == 30) { if ($did(fkey,35).text != $null) { $did(fkey,35).text } }
  if ($did == 31) { if ($did(fkey,34).text != $null) { $did(fkey,34).text } }
  if ($did == 32) { if ($did(fkey,33).text != $null) { $did(fkey,33).text } }
  if ($did == 41) { if ($did(fkey,42).text != $null) { $did(fkey,42).text } }
  if ($did == 40) { if ($did(fkey,43).text != $null) { $did(fkey,43).text } }
  if ($did == 39) { if ($did(fkey,44).text != $null) { $did(fkey,44).text } }
  if ($did == 38) { if ($did(fkey,45).text != $null) { $did(fkey,45).text } }

  if ($did == 20) { if ($did(fkey,7).text != $null) { $did(fkey,7).text } }
  if ($did == 21) { if ($did(fkey,8).text != $null) { $did(fkey,8).text } }
  if ($did == 22) { if ($did(fkey,9).text != $null) { $did(fkey,9).text } }
  if ($did == 23) { if ($did(fkey,10).text != $null) { $did(fkey,10).text } }
  if ($did == 46) { if ($did(fkey,61).text != $null) { $did(fkey,61).text } }
  if ($did == 47) { if ($did(fkey,59).text != $null) { $did(fkey,59).text } }
  if ($did == 48) { if ($did(fkey,59).text != $null) { $did(fkey,59).text } }
  if ($did == 49) { if ($did(fkey,58).text != $null) { $did(fkey,58).text } }
  if ($did == 50) { if ($did(fkey,57).text != $null) { $did(fkey,57).text } }
  if ($did == 51) { if ($did(fkey,56).text != $null) { $did(fkey,56).text } }
  if ($did == 52) { if ($did(fkey,55).text != $null) { $did(fkey,55).text } }
  if ($did == 53) { if ($did(fkey,54).text != $null) { $did(fkey,54).text } }
  if ($did == 17) { if ($did(fkey,28).text != $null) { $did(fkey,7).text } }
  if ($did == 18) { if ($did(fkey,27).text != $null) { $did(fkey,8).text } }
  if ($did == 19) { if ($did(fkey,26).text != $null) { $did(fkey,9).text } }
  if ($did == 24) { if ($did(fkey,25).text != $null) { $did(fkey,10).text } }
  if ($did == 62) { if ($did(fkey,77).text != $null) { $did(fkey,77).text } }
  if ($did == 63) { if ($did(fkey,76).text != $null) { $did(fkey,76).text } }
  if ($did == 64) { if ($did(fkey,75).text != $null) { $did(fkey,75).text } }
  if ($did == 65) { if ($did(fkey,74).text != $null) { $did(fkey,74).text } }
  if ($did == 66) { if ($did(fkey,73).text != $null) { $did(fkey,73).text } }
  if ($did == 67) { if ($did(fkey,72).text != $null) { $did(fkey,72).text } }
  if ($did == 68) { if ($did(fkey,71).text != $null) { $did(fkey,71).text } }
  if ($did == 69) { if ($did(fkey,70).text != $null) { $did(fkey,70).text } }
  sclick
}
on *:dialog:fkey:edit:*:{
  if ($did == 15) { if ($did(fkey,15).text != $null) { _vw fkey commandf1 $did(fkey,15).text } | else _vrem fkey commandf1 }
  if ($did == 14) { if ($did(fkey,14).text != $null) { _vw fkey commandf2 $did(fkey,14).text } | else _vrem fkey commandf2 }
  if ($did == 13) { if ($did(fkey,13).text != $null) { _vw fkey commandf3 $did(fkey,13).text } | else _vrem fkey commandf3 }
  if ($did == 12) { if ($did(fkey,12).text != $null) { _vw fkey commandf4 $did(fkey,12).text } | else _vrem fkey commandf4 }
  if ($did == 36) { if ($did(fkey,36).text != $null) { _vw fkey commandf5 $did(fkey,36).text } | else _vrem fkey commandf5 }
  if ($did == 35) { if ($did(fkey,35).text != $null) { _vw fkey commandf6 $did(fkey,35).text } | else _vrem fkey commandf6 }
  if ($did == 34) { if ($did(fkey,34).text != $null) { _vw fkey commandf7 $did(fkey,34).text } | else _vrem fkey commandf7 }
  if ($did == 33) { if ($did(fkey,33).text != $null) { _vw fkey commandf8 $did(fkey,33).text } | else _vrem fkey commandf8 }
  if ($did == 42) { if ($did(fkey,42).text != $null) { _vw fkey commandf9 $did(fkey,42).text } | else _vrem fkey commandf9 }
  if ($did == 43) { if ($did(fkey,43).text != $null) { _vw fkey commandf10 $did(fkey,43).text } | else _vrem fkey commandf10 }
  if ($did == 44) { if ($did(fkey,44).text != $null) { _vw fkey commandf11 $did(fkey,44).text } | else _vrem fkey commandf11 }
  if ($did == 45) { if ($did(fkey,45).text != $null) { _vw fkey commandf12 $did(fkey,45).text } | else _vrem fkey commandf12 }

  if ($did == 7) { if ($did(fkey,7).text != $null) { _vw fkey commandsf1 $did(fkey,7).text } | else _vrem fkey commandsf1 }
  if ($did == 8) { if ($did(fkey,8).text != $null) { _vw fkey commandsf2 $did(fkey,8).text } | else _vrem fkey commandsf2 }
  if ($did == 9) { if ($did(fkey,9).text != $null) { _vw fkey commandsf3 $did(fkey,9).text } | else _vrem fkey commandsf3 }
  if ($did == 10) { if ($did(fkey,10).text != $null) { _vw fkey commandsf4 $did(fkey,10).text } | else _vrem fkey commandsf4 }
  if ($did == 61) { if ($did(fkey,61).text != $null) { _vw fkey commandsf5 $did(fkey,61).text } | else _vrem fkey commandsf5 }
  if ($did == 60) { if ($did(fkey,60).text != $null) { _vw fkey commandsf6 $did(fkey,60).text } | else _vrem fkey commandsf6 }
  if ($did == 59) { if ($did(fkey,59).text != $null) { _vw fkey commandsf7 $did(fkey,59).text } | else _vrem fkey commandsf7 }
  if ($did == 58) { if ($did(fkey,58).text != $null) { _vw fkey commandsf8 $did(fkey,58).text } | else _vrem fkey commandsf8 }
  if ($did == 57) { if ($did(fkey,57).text != $null) { _vw fkey commandsf9 $did(fkey,57).text } | else _vrem fkey commandsf9 }
  if ($did == 56) { if ($did(fkey,56).text != $null) { _vw fkey commandsf10 $did(fkey,56).text } | else _vrem fkey commandsf10 }
  if ($did == 55) { if ($did(fkey,55).text != $null) { _vw fkey commandsf11 $did(fkey,55).text } | else _vrem fkey commandsf11 }
  if ($did == 54) { if ($did(fkey,54).text != $null) { _vw fkey commandsf12 $did(fkey,54).text } | else _vrem fkey commandsf12 }
  if ($did == 28) { if ($did(fkey,28).text != $null) { _vw fkey commandcf1 $did(fkey,28).text } | else _vrem fkey commandcf1 }
  if ($did == 27) { if ($did(fkey,27).text != $null) { _vw fkey commandcf2 $did(fkey,27).text } | else _vrem fkey commandcf2 }
  if ($did == 26) { if ($did(fkey,26).text != $null) { _vw fkey commandcf3 $did(fkey,26).text } | else _vrem fkey commandcf3 }
  if ($did == 25) { if ($did(fkey,25).text != $null) { _vw fkey commandcf4 $did(fkey,25).text } | else _vrem fkey commandcf4 }
  if ($did == 77) { if ($did(fkey,77).text != $null) { _vw fkey commandcf5 $did(fkey,77).text } | else _vrem fkey commandcf5 }
  if ($did == 76) { if ($did(fkey,76).text != $null) { _vw fkey commandcf6 $did(fkey,76).text } | else _vrem fkey commandcf6 }
  if ($did == 75) { if ($did(fkey,75).text != $null) { _vw fkey commandcf7 $did(fkey,75).text } | else _vrem fkey commandcf7 }
  if ($did == 74) { if ($did(fkey,74).text != $null) { _vw fkey commandcf8 $did(fkey,74).text } | else _vrem fkey commandcf8 }
  if ($did == 73) { if ($did(fkey,73).text != $null) { _vw fkey commandcf9 $did(fkey,73).text } | else _vrem fkey commandcf9 }
  if ($did == 72) { if ($did(fkey,72).text != $null) { _vw fkey commandcf10 $did(fkey,72).text } | else _vrem fkey commandcf10 }
  if ($did == 71) { if ($did(fkey,71).text != $null) { _vw fkey commandcf11 $did(fkey,71).text } | else _vrem fkey commandcf11 }
  if ($did == 70) { if ($did(fkey,70).text != $null) { _vw fkey commandcf12 $did(fkey,70).text } | else _vrem fkey commandcf12 }
}
alias F1 {
  if ($_vr(fkey,commandf1) == $null) { _vw fkey commandf1 setup | $_vr(fkey,commandf1) } 
  else { $_vr(fkey,commandf1) } 
}
alias F2 {
  if ($_vr(fkey,commandf2) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf2) } 
}
alias F3 {
  if ($_vr(fkey,commandf3) == $null) { _vw fkey commandf3 splay stop | $_vr(fkey,commandf3) } 
  else { $_vr(fkey,commandf3) } 
}
alias F4 {
  if ($_vr(fkey,commandf4) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf4) } 
}
alias F5 {
  if ($_vr(fkey,commandf5) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf5) } 
}
alias F6 {
  if ($_vr(fkey,commandf6) == $null) { _vw fkey commandf6 awaybox | $_vr(fkey,commandf6) } 
  else { $_vr(fkey,commandf6) } 
}
alias F7 {
  if ($_vr(fkey,commandf7) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf7) } 
}
alias F8 {
  if ($_vr(fkey,commandf8) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf8) } 
}
alias F9 {
  if ($_vr(fkey,commandf9) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf9) } 
}
alias F10 {
  if ($_vr(fkey,commandf10) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf10) } 
}
alias F11 {
  if ($_vr(fkey,commandf11) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandf11) } 
}
alias F12 {
  if ($_vr(fkey,commandf12) == $null) { _vw fkey commandf12 ignoreall | $_vr(fkey,commandf12) } 
  else { $_vr(fkey,commandf12) } 
}
alias SF1 {
  if ($_vr(fkey,commandsf1) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf1) } 
}
alias SF2 {
  if ($_vr(fkey,commandsf2) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf2) } 
}
alias SF3 {
  if ($_vr(fkey,commandsf3) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf3) } 
}
alias SF4 {
  if ($_vr(fkey,commandsf4) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf4) } 
}
alias SF5 {
  if ($_vr(fkey,commandsf5) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf5) } 
}
alias SF6 {
  if ($_vr(fkey,commandsf6) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf6) } 
}
alias SF7 {
  if ($_vr(fkey,commandsf7) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf7) } 
}
alias SF8 {
  if ($_vr(fkey,commandsf8) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf8) } 
}
alias SF9 {
  if ($_vr(fkey,commandsf9) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf9) } 
}
alias SF10 {
  if ($_vr(fkey,commandsf10) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf10) } 
}
alias SF11 {
  if ($_vr(fkey,commandsf11) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf11) } 
}
alias SF12 {
  if ($_vr(fkey,commandsf12) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandsf12) } 
}
alias CF1 {
  if ($_vr(fkey,commandcf1) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf1) } 
}
alias CF2 {
  if ($_vr(fkey,commandcf2) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf2) } 
}
alias CF3 {
  if ($_vr(fkey,commandcf3) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf3) } 
}
alias -l cwindow {
  if ($chan($active) = $active) { part $chan }
  elseif (Status Window = $active) { return } 
  else window -c $active 
}
alias CF4 {
  if ($_vr(fkey,commandcf4) == $null) { _vw fkey commandcf4 cwindow | $_vr(fkey,commandcf4) } 
  else { $_vr(fkey,commandcf4) } 
}
alias CF5 {
  if ($_vr(fkey,commandcf5) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf5) } 
}
alias CF6 {
  if ($_vr(fkey,commandcf6) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf6) } 
}
alias CF7 {
  if ($_vr(fkey,commandcf7) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf7) } 
}
alias CF8 {
  if ($_vr(fkey,commandcf8) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf8) } 
}
alias CF9 {
  if ($_vr(fkey,commandcf9) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf9) } 
}
alias CF10 {
  if ($_vr(fkey,commandcf10) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf10) } 
}
alias CF11 {
  if ($_vr(fkey,commandcf11) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf11) } 
}
alias CF12 {
  if ($_vr(fkey,commandcf12) == $null) { $ae 4 There is no preset function key configured. | fkey } 
  else { $_vr(fkey,commandcf12) } 
}
