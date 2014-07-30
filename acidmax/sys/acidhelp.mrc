menu menubar {
  acidmax help: achlp
}
dialog achlp {
  title "Acidmax help"
  size -1 -1 395 226
  option pixels
  icon help.ico, 0
  button "< Back", 4, 202 203 60 20
  button "Close", 5, 330 203 60 20, cancel
  text "www.team-nexgen.org", 6, 6 206 123 16, disable
  icon 1, -1 0 396 196,  help\status1.jpg, 0, hide
  icon 10, -1 0 396 196,  help\status2.jpg, 0, hide
  list 14, 3 3 115 196, hide size
  edit "", 15, 122 3 270 196, hide read multi return
  list 16, 3 3 115 196, hide size
  edit "", 17, 122 3 270 196, hide read multi return
  button "Next >", 18, 264 203 60 20
  edit "", 23, 3 3 389 196, hide read multi return vsbar
  menu "Contents", 2
  item "Introduction", 3, 2
  item "Commands", 7, 2
  item "Other", 8, 2
  item "Miscellaneous", 9, 2
  menu "Version", 12
  item "History", 13, 12
  item break, 19, 12
  item "Bug report", 20, 12
  menu "Nexgen", 21
  item "Team stuff", 22, 21
  item "Scripts", 11, 21
}
alias achlp {
  $iif(!$dialog(achlp),dialog -m achlp achlp)
}
on *:dialog:achlp:init:*: {
  did -v achlp 1
  did -b achlp 4
}
on *:dialog:achlp:menu:*: {
  if ($did == 3) { bback | set %aol 1 | did -e achlp 18 }
  if ($did == 7) { bback1 | set %aol 2 }
  if ($did == 8) { bback2 | set %aol 3 | did -e achlp 18 }
  if ($did == 11) { www http://www.team-nexgen.org/scripts.php }
  if ($did == 13) { www http://www.team-nexgen.org/forum/viewforum.php?f=1 }
  if ($did == 22) { www http://www.team-nexgen.org/members.php }
  if ($did == 20) { www http://www.team-nexgen.org/forum/viewforum.php?f=1 }
  if ($did == 9) { bback3 | set %aol 4 | did -b achlp 18 | did -e achlp 4 }
}
on *:dialog:achlp:sclick:4: {
  if (%aol == 1) { bbacko | did -b achlp 4 | set %aol 0 | did -e achlp 18 }
  if (%aol == 2) { bback | set %aol 1 }
  if (%aol == 3) { bback1 | set %aol 2 }
  if (%aol == 4) { bback2 | set %aol 3 | did -e achlp 18 }
}
on *:dialog:achlp:sclick:5: {
  unset %aol
}
on *:dialog:achlp:sclick:18: {
  set %aol $calc(%aol + 1)
  if (%aol == 1) { bback }
  if (%aol == 2) { bback1 }
  if (%aol == 3) { bback2 }
  if (%aol == 4) { bback3 | did -b achlp 18 }
}
on *:dialog:achlp:sclick:14: {
  did -ra achlp 15 $read(help\helptext.txt,$did(achlp,14).sel)
}
on *:dialog:achlp:sclick:16: {
  did -ra achlp 17 $read(help\othertext.txt,$did(achlp,16).sel)
}
alias bbacko {
  did -h achlp 10,14,15,16,17,23 | did -v achlp 1 | dialog -t achlp Acidmax help
}
alias bback {
  did -h achlp 1,14,15,16,17,23 | did -v achlp 10 | did -e achlp 4 | dialog -t achlp Acidmax help - Introduction
}
alias bback1 {
  did -h achlp 1,10,16,17,23 | did -v achlp 14,15 | did -e achlp 4 | loadbuf -ro achlp 14 help\help.txt | dialog -t achlp Acidmax help - Commands
}
alias bback2 {
  did -h achlp 1,10,14,15,23 | did -e achlp 4 | did -v achlp 16,17 | loadbuf -ro achlp 16 help\other.txt | dialog -t achlp Acidmax help - Other 
}
alias bback3 {
  did -h achlp 1,10,14,15,16,17 | did -v achlp 23 | loadbuf -ro achlp 23 help\misc.txt
}
