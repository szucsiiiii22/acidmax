on *:join:#: {
  if  ($_vr(voiceman,switch) == on) && ($me isop $chan) && ($nick isreg $chan) && ($nick != $null) && ($read(data\voiceman.txt, w, $chan) == $chan) { vuser $nick $chan }
  elseif  ($_vr(voiceman,switch) == on) && ($me ishop $chan) && ($nick isreg $chan) && ($nick != $null) && ($read(data\voiceman.txt, w, $chan) == $chan) { vuser $nick $chan }
}
on *:op:#: {
  if  ($_vr(voiceman,switch) == on) && ($me isop $chan) && ($read(data\voiceman.txt, w, $chan) == $chan) || ($me ishop $chan) { 
    if ($opnick isvoice $chan) && ($_vr(voiceman,dvnick) == on) { mode $chan -v $opnick }
    elseif ($_vr(voiceman,vallop) == on) && ($nick($chan,0,r) >= 1) && ($read(data\voiceman.txt, w, $chan) == $chan) { mvoice } 
  }
}
on *:deop:#: {
  if  ($_vr(voiceman,switch) == on) && ($me isop $chan) || ($me ishop $chan) && ($read(data\voiceman.txt, w, $chan) == $chan) { 
    if ($opnick isvoice $chan) && ($_vr(voiceman,dvnick) == on) { mode $chan +v $opnick }
    elseif ($_vr(voiceman,vallop) == on) && ($nick($chan,0,r) >= 1)  { mvoice } 
  }
}
alias voiceman {
  if ($version < 5.91) { echo -s 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($dialog(voiceman) == $null) { dialog -m voiceman voiceman }
}
dialog voiceman {
  title "auto-voice manager"
  size -1 -1 151 175
  option dbu
  check "voice only in moderated channel", 17, 17 138 90 10
  button "ok", 15, 59 159 29 10, ok cancel
  box "options", 12, 9 89 130 66
  check "no voiceing on moderated channel", 16, 17 128 98 10
  check "devoice user when user is oped", 2, 17 108 90 10
  check "voice regular users onced oped", 3, 17 118 90 10
  check "enable", 1, 17 98 30 10
  list 4, 11 14 50 70, sort size hsbar
  button "-", 7, 70 50 9 8
  button ">", 6, 70 35 9 8
  box "channel(s)", 5, 7 6 58 82
  box "active", 8, 85 6 58 82
  list 9, 89 14 50 70, sort size hsbar
}
on *:dialog:voiceman:init:*:{
  if ($_vr(voiceman,switch) == on) { did -c voiceman 1 }
  if ($_vr(voiceman,vallop) == on) { did -c voiceman 3 }
  if ($_vr(voiceman,dvnick) == on) { did -c voiceman 2 } 
  chan.list
  chanlist
}
on *:dialog:voiceman:sclick:*:{
  if ($did == 1) {
    if ($_vr(voiceman,switch) == on) { _vw voiceman switch off | did -b voiceman 8,9 }
    else { _vw voiceman switch on | did -e voiceman 8,9 }
  }
  if ($did == 2) {
    if ($_vr(voiceman,dvnick) == on) { _vw voiceman dvnick off }
    else { _vw voiceman dvnick on }
  }
  if ($did == 3) {
    if ($_vr(voiceman,vallop) == on) { _vw voiceman vallop off }
    else { _vw voiceman vallop on }
  }
  if ($did == 6) { did -a voiceman 9 $did(4,$did(4).sel) | write data/voiceman.txt $did(4,$did(4).sel) }
  if ($did == 7) { chanrem $did(9,$did(9).sel) | did -d voiceman 9 $did(7,$did(7).sel) 1 }
}
alias -l chanrem {
  %c = $lines(data/voiceman.txt) 
  if (%c == 0) || (%c == $null) { unset %c | return } 
  :loop 
  if ($1 == $read -l [ $+ [ %c ] ] data/voiceman.txt) { write -dl [ $+ [ %c ] ] data/voiceman.txt | unset %c | return } 
  dec %c 
  if (%c <= 0) { unset %c | return } 
  goto loop 

}
alias -l chanlist {
  %chan = $lines(data/voiceman.txt)
  if (%chan == 0) || (%chan == $null) { return }
  :loop
  did -a voiceman 9 $read -l [ $+ [ %chan ] ] data\voiceman.txt
  dec %chan
  if (%chan <= 0) { return }
  goto loop
}
menu channel {
  $iif($script(voiceman.mrc) != $null,• utilities)
  .voice mode manager:voiceman
}
alias mvoice {
  var %w = $nick($chan,0,r)
  :loop
  if (%w >= 4 ) { set %action +vvvv | %nickr1 = $nick($chan,%w,r) | dec %w 1 | %nickr2 = $nick($chan,%w,r) | dec %w 1 | %nickr3 = $nick($chan,%w,r) | dec %w 1 | %nickr4 = $nick($chan,%w,r) | dec %w 1 | mode # %action %nickr1 %nickr2 %nickr3 %nickr4 | goto loop }
  if (%w >= 3 ) { set %action +vvv | %nickr1 = $nick($chan,%w,r) | dec %w 1 | %nickr2 = $nick($chan,%w,r) | dec %w 1 | %nickr3 = $nick($chan,%w,r) | dec %w 1 | mode # %action %nickr1 %nickr2 %nickr3 | goto loop }
  if (%w >= 2 ) { set %action +vv | %nickr1 = $nick($chan,%w,r) | dec %w 1 | %nickr2 = $nick($chan,%w,r) | dec %w 1 | mode # %action %nickr1 %nickr2 | goto loop }
  if (%w >= 1 ) { set %action +v | %nickr1 = $nick($chan,%w,r) | mode # %action %nickr1 }
}
alias -l chan.list {
  var %jk = $chan(0)
  var %c = 0
  :loop
  inc %c
  if (%c <= %jk) { did -a voiceman 4  $chan(%c) | goto loop }
  else return
}
alias -l vuser {
  ;    if ($1 isop $2) && ($_vr(wordmon,ops) == 0) { halt }
  ;  if ($1 isvo $2) && ($_vr(wordmon,voice) == 0) { halt }
  ;  if ($1 isreg $2) && ($_vr(wordmon,regular) == 0) { halt }
  ;  if ($_vr(channel,all) == 0) && ($_chanin($2) == $false) { halt }
  if ($fchan($2) > 0) && ($_vr(voiceman,switch) == on) {
    mode $2 +v $1 
  }
}
alias -l fchan {
  if ($exists(data/voiceman.txt) == $true) { 
    %w = $lines(data/voiceman.txt) | %wn = 0 | :loop | %wt = $read -l [ $+ [ %w ] ] data/voiceman.txt | inc %wn $wildtok($1-, %wt, 0, 32) | dec %w | if (%w == 0) { return %wn } | if (%w > 0) { goto loop } 
  }
  else write data/voiceman.txt
}
