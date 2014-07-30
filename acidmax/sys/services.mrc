on :load: {
  load -rs " $+ $findfile($mircdir,services2.mrc,1) $+ "
  echo -a Type /df to open dialog
}
menu channel,status {
  $iif($network == $net, $lower($network) services):df
}
alias -l net {
  if ($network == dalnet) { return dalnet }
  elseif ($network == Freedom-net) { return Freedom-net }
  elseif ($network == BeyondIRC) { return BeyondIRC }
  elseif ($network == dynastynet) { return dynastynet }
  elseif ($network == chatnet) { return chatnet }
  elseif ($network == newnet) { return newnet }
  elseif ($network == Telstra) { return Telstra }
  elseif ($network == nexnet) { return nexnet }
  elseif ($network == webnet) { return webnet }
  elseif ($network == ChatUniverse) { return ChatUniverse }
  elseif ($network == Aniverse) { return Aniverse }
  elseif ($network == Templar-Rock-IRC) { return Templar-Rock-IRC }
  elseif ($network == grnet) { return grnet }
  elseif ($network == Chatfreaks) { return Chatfreaks }
  elseif ($network == SexNet) { return sexnet }
  elseif ($network == gamesnet) { return gamesnet }
  elseif ($network == irc.scifihaven.org) { return irc.scifihaven.org }
  elseif ($network == FuctNet) { return FuctNet }
  elseif ($network == FireWirez) { return FireWirez }
}
dialog ds {
  title " services"
  size -1 -1 146 120
  option dbu
  box "", 4, 3 2 140 105
  check "Register", 5, 8 14 31 10
  check "Identify", 6, 8 25 29 10
  check "Drop", 7, 8 37 25 10
  check "Info", 8, 8 49 24 10
  check "Access", 9, 8 60 31 10
  check "Akick add", 10, 8 71 37 10
  check "Akick del", 11, 8 82 37 10
  check "Akick list", 12, 8 93 36 10
  check "Aop add", 13, 55 14 35 10
  check "Aop del", 14, 55 25 30 10
  check "Aop wipe", 15, 55 37 37 10
  check "Aop list", 16, 55 49 32 10
  check "Sop add", 17, 55 60 35 10
  check "Sop del", 18, 55 71 31 10
  check "Sop wipe", 19, 55 82 35 10
  check "Sop list", 20, 55 93 32 10
  check "Op", 21, 101 14 23 10
  check "Deop", 22, 101 25 28 10
  check "Mdeop", 23, 101 37 30 10
  check "Mkick", 24, 101 49 27 10
  check "Unban", 25, 101 60 33 10
  check "Invite", 26, 101 71 31 10
  check "Send pass", 27, 101 82 38 10
  button "Button", 43, 117 116 0 0, ok
  check "Desc", 49, 8 14 38 10
  check "Ident", 50, 8 25 29 10
  check "Mlock", 51, 8 37 25 10
  check "Passwd", 52, 8 49 29 10
  check "Topic lock", 53, 8 60 37 10
  check "Founder", 54, 54 14 35 10
  check "Leave ops", 55, 54 25 36 10
  check "Mail block", 56, 54 37 37 10
  check "Private", 57, 54 49 32 10
  check "Verbose", 58, 54 60 35 10
  check "Keep topic", 59, 101 14 35 10
  check "Op guard", 60, 101 25 32 10
  check "Memo", 61, 101 37 30 10
  check "Restrict", 62, 101 49 31 10
  check "Access add", 63, 8 25 40 10
  check "Access del", 64, 8 37 40 10
  check "Access wipe", 65, 8 49 42 10
  check "Access list", 66, 8 60 37 10
  check "Register", 67, 56 14 35 10
  check "Identify", 68, 56 25 36 10
  check "Ghost", 69, 56 37 37 10
  check "Drop ", 70, 56 49 32 10
  check "Recover", 71, 56 60 35 10
  check "Release", 72, 101 14 35 10
  check "Send pass", 73, 101 25 36 10
  check "Info", 74, 101 37 30 10
  check "Acc", 75, 8 14 24 10
  check "Enforce", 76, 8 25 40 10
  check "Noop", 77, 8 37 40 10
  check "Show mail", 78, 56 14 35 10
  check "Passwd", 79, 56 25 36 10
  check "Url", 80, 56 37 37 10
  check "Mail block", 81, 101 14 35 10
  check "No memo", 82, 101 25 36 10
  check "E-mail", 83, 8 14 26 10
  check "Read", 84, 8 25 40 10
  check "Undel", 85, 8 37 40 10
  check "List", 86, 56 14 35 10
  check "Forward", 87, 56 25 36 10
  check "News", 88, 56 37 37 10
  check "Delete", 89, 101 14 35 10
  check "Purge", 90, 101 25 36 10
  check "Send", 91, 8 14 26 10
  check "Send sop", 92, 101 37 34 10
  text "Script name: Services", 93, 10 19 74 8
  text "Version: 1.1", 94, 10 29 32 8
  text "Author: RAIN ©2002 for Nexgen Acidmax", 95, 10 38 130 8
  text "Description:", 96, 10 53 30 8
  text "Script covers all commands and set options for Chanserv,Nickserv and Memoserv.It has dialog interface,for easy navigation through commands.", 97, 10 63 127 22
  menu "Chanserv", 1
  item "Commands", 44, 1
  item "Set options", 45, 1
  menu "Nickserv", 2
  item "Commands", 46, 2
  item "Set options", 47, 2
  menu "Memoserv", 3
  item "Commands", 48, 3
  menu "About", 28
  item "About", 29, 28
}
alias df {
  dialog -m ds ds
}
on *:dialog:ds:init:*: {
  shnc
  ;  hide
}
alias -l about {
  did -o ds 4 1 About
  did -h ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
  did -h ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75
  did -h ds 76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92
  did -v ds 93,94,95,96,97
}

alias -l hide {
  did -o ds 4 1 About
  did -h ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
  did -h ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75
  did -h ds 76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92
}
alias -l shc {
  did -o ds 4 1 Chanserv Commands
  did -h ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75
  did -h ds 76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97
  did -v ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27

}
alias -l shso {
  did -o ds 4 1 Chanserv Set 
  did -h ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
  did -h ds 63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92
  did -h ds 93,94,95,96,97
  did -v ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62
}
alias -l shnc {
  did -o ds 4 1 Nickserv Commands
  did -h ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
  did -h ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92
  did -h ds 93,94,95,96,97
  did -v ds 63,64,65,66,67,68,69,70,71,72,73,74,75

}
alias -l  shno {
  did -o ds 4 1 Nickserv Set 
  did -h ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
  did -h ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62,
  did -h ds 63,64,65,66,67,68,69,70,71,72,73,74,75,84,85,86,87,88,89,90,91,92
  did -h ds 93,94,95,96,97
  did -v ds 76,77,78,79,80,81,82,83
}
alias -l shmsrv {
  did -o ds 4 1 Memoserv Commands
  did -h ds 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
  did -h ds 49,50,51,52,53,54,55,56,57,58,59,60,61,62,
  did -h ds 63,64,65,66,67,68,69,70,71,72,73,74,75
  did -h ds 76,77,78,79,80,81,82,83,93,94,95,96,97
  did -v ds 84,85,86,87,88,89,90,91,92
}
on *:dialog:ds:menu:*: {
  if ($did == 29) { about }
  if ($did == 44) { shc }
  if ($did == 45) { shso }
  if ($did == 46) { shnc }
  if ($did == 47) { shno }
  if ($did == 48) { shmsrv }
}
on *:dialog:ds:sclick:*: {
  if ($did == 5) && ($did(5).state == 1) { cr }
  if ($did == 6) && ($did(6).state == 1) { cr1 }
  if ($did == 7) && ($did(7).state == 1) { cr2 }
  if ($did == 8) && ($did(8).state == 1) { cr3 }
  if ($did == 9) && ($did(9).state == 1) { cr4 }
  if ($did == 10) && ($did(10).state == 1) { cr5 }
  if ($did == 11) && ($did(11).state == 1) { cr6 }
  if ($did == 12) && ($did(12).state == 1) { cr7 }
  if ($did == 13) && ($did(13).state == 1) { cr8 }
  if ($did == 14) && ($did(14).state == 1) { cr9 }
  if ($did == 15) && ($did(15).state == 1) { cr10 }
  if ($did == 16) && ($did(16).state == 1) { cr11 }
  if ($did == 17) && ($did(17).state == 1) { cr12 }
  if ($did == 18) && ($did(18).state == 1) { cr13 }
  if ($did == 19) && ($did(19).state == 1) { cr14 }
  if ($did == 20) && ($did(20).state == 1) { cr15 }
  if ($did == 21) && ($did(21).state == 1) { cr16 }
  if ($did == 22) && ($did(22).state == 1) { cr17 }
  if ($did == 23) && ($did(23).state == 1) { cr18 }
  if ($did == 24) && ($did(24).state == 1) { cr19 }
  if ($did == 25) && ($did(25).state == 1) { cr20 }
  if ($did == 26) && ($did(26).state == 1) { cr21 }
  if ($did == 27) && ($did(27).state == 1) { cr22 }
  if ($did == 49) && ($did(49).state == 1) { cr23 }
  if ($did == 50) && ($did(50).state == 1) { cr24 }
  if ($did == 51) && ($did(51).state == 1) { cr25 }
  if ($did == 52) && ($did(52).state == 1) { cr26 }
  if ($did == 53) && ($did(53).state == 1) { cr27 }
  if ($did == 54) && ($did(54).state == 1) { cr28 }
  if ($did == 55) && ($did(55).state == 1) { cr29 }
  if ($did == 56) && ($did(56).state == 1) { cr30 }
  if ($did == 57) && ($did(57).state == 1) { cr31 }
  if ($did == 58) && ($did(58).state == 1) { cr32 }
  if ($did == 59) && ($did(59).state == 1) { cr33 }
  if ($did == 60) && ($did(60).state == 1) { cr34 }
  if ($did == 61) && ($did(61).state == 1) { cr35 }
  if ($did == 62) && ($did(62).state == 1) { cr36 }
  if ($did == 75) && ($did(75).state == 1) { nr }
  if ($did == 63) && ($did(63).state == 1) { nr1 }
  if ($did == 64) && ($did(64).state == 1) { nr2 }
  if ($did == 65) && ($did(65).state == 1) { nr3 }
  if ($did == 66) && ($did(66).state == 1) { nr4 }
  if ($did == 67) && ($did(67).state == 1) { nr5 }
  if ($did == 68) && ($did(68).state == 1) { nr6 }
  if ($did == 69) && ($did(69).state == 1) { nr7 }
  if ($did == 70) && ($did(70).state == 1) { nr8 }
  if ($did == 71) && ($did(71).state == 1) { nr9 }
  if ($did == 72) && ($did(72).state == 1) { nr10 }
  if ($did == 73) && ($did(73).state == 1) { nr11 }
  if ($did == 74) && ($did(74).state == 1) { nr12 }
  if ($did == 83) && ($did(83).state == 1) { nr13 }
  if ($did == 76) && ($did(76).state == 1) { nr14 }
  if ($did == 77) && ($did(77).state == 1) { nr15 }
  if ($did == 78) && ($did(78).state == 1) { nr16 }
  if ($did == 79) && ($did(79).state == 1) { nr17 }
  if ($did == 80) && ($did(80).state == 1) { nr18 }
  if ($did == 81) && ($did(81).state == 1) { nr19 }
  if ($did == 82) && ($did(82).state == 1) { nr20 }
  if ($did == 91) && ($did(91).state == 1) { mr }
  if ($did == 84) && ($did(84).state == 1) { mr2 }
  if ($did == 85) && ($did(85).state == 1) { mr3 }
  if ($did == 86) && ($did(86).state == 1) { mr4 }
  if ($did == 87) && ($did(87).state == 1) { mr5 }
  if ($did == 88) && ($did(88).state == 1) { mr6 }
  if ($did == 89) && ($did(89).state == 1) { mr7 }
  if ($did == 90) && ($did(90).state == 1) { mr8 }
  if ($did == 92) && ($did(92).state == 1) { mr9 }
}
;--------------------------------------------------------------------------------------------
dialog cr {
  title " services"
  size -1 -1 129 62
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Channel Register", 2, 3 3 123 45
  edit "", 3, 48 13 75 10, autohs
  text "Channel Pass:", 4, 8 24 35 8
  edit "", 5, 48 23 75 10, pass autohs
  text "Description:", 6, 8 33 29 8
  edit "", 7, 48 33 75 10, autohs
  button "Ok", 8, 71 50 25 10,ok
  button "Cancel", 9, 97 50 25 10, cancel
}
alias -l cr {
  dialog -m cr cr 
}
on *:dialog:cr:edit:*: {
  if ($did == 3) { set %channelname $did(3) }
  if ($did == 5) { set %channelpass $did(5) }
  if ($did == 7) { set %description $did(7) }
}
on *:dialog:cr:sclick:*: {
  if ($did == 8) { reg }
  if ($did == 9) { unset %channel* | unset %description | did -u ds 5 }
}
alias -l reg {
  if (%channelname == $null) && (%channelpass == $null) { echo -a Please enter info in all fields | halt }
  elseif (%channelname != $null) && (%channelpass != $null) {
    $dalchan register %channelname %channelpass %description 
    unset %channel*
    unset %description
    did -u ds 5

  }
}
;-------------------------------------------------------------------------------------------
dialog cr1 {
  title " services"
  size -1 -1 129 52
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Channel Identify", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  text "Channel Pass:", 4, 8 24 35 8
  edit "", 5, 48 23 75 10, pass autohs
  button "Ok", 8, 72 40 25 10, ok
  button "Cancel", 9, 98 40 25 10, cancel
}
alias -l cr1 {
  dialog -m cr1 cr1
}
on *:dialog:cr1:edit:*: {
  if ($did == 3) { set %channelname1 $did(3) }
  if ($did == 5) { set %channelpass1 $did(5) }

}
on *:dialog:cr1:sclick:*: {
  if ($did == 8) { reg1 }
  if ($did == 9) { did -u ds 6  | unset %channel* }
}
alias -l reg1 {
  if (%channelname1 == $null) && (%channelpass1 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%channelname1 != $null) && (%channelpass1 != $null) {
    $dalchan identify %channelname1 %channelpass1  
    unset %channel*
    did -u ds 6

  }
}
alias -l dalchan {
  if ($network == dalnet) { return msg ChanServ@services.dal.net }
  else { return msg chanserv }
}

;---------------------------------------------------------------------------------------------
dialog cr2 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Drop Channel", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 72 30 25 10 , ok
  button "Cancel", 9, 98 30 25 10, cancel
}
alias -l cr2 {
  dialog -m cr2 cr2
}
on *:dialog:cr2:edit:*: {
  if ($did == 3) { set %channelname2 $did(3) }
}
on *:dialog:cr2:sclick:*: {
  if ($did == 8) { reg2 }
  if ($did == 9) { unset %channel* | did -u ds 7 }
}
alias -l reg2 {
  if (%channelname2 != $null) { $dalchan drop %channelname2 | unset %channel* | did -u ds 7 }
  elseif (%channelname2 == $null) { echo -a Please enter Channel name to drop | halt }
}
;--------------------------------------------------------------------------------------------
dialog cr3 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Channel Info", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 72 30 25 10 , ok
  button "Cancel", 9, 98 30 25 10, cancel
}
alias -l cr3 {
  dialog -m cr3 cr3
}
on *:dialog:cr3:edit:*: {
  if ($did == 3) { set %channelname3 $did(3) }
}
on *:dialog:cr3:sclick:*: {
  if ($did == 8) { reg3 }
  if ($did == 9) { unset %channel* | did -u ds 8 }
}
alias -l reg3 {
  if (%channelname3 != $null) { $dalchan info %channelname3 | unset %channel* | did -u ds 8 }
  elseif (%channelname3 == $null) { echo -a Please enter channel name to get info | halt }
}
;--------------------------------------------------------------------------------------------
dialog cr4 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Channel Access", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 72 30 25 10,ok
  button "Cancel", 9, 98 30 25 10, cancel
}
alias -l cr4 {
  dialog -m cr4 cr4
}
on *:dialog:cr4:edit:*: {
  if ($did == 3) { set %channelname4 $did(3) }
}
on *:dialog:cr4:sclick:*: {
  if ($did == 8) { reg4 }
  if ($did == 9) { unset %channel* | did -u ds 9 }
}
alias -l reg4 {
  if (%channelname4 != $null) { $dalchan access %channelname4 | unset %channel* | did -u ds 9 }
  elseif (%channelname4 == $null) { echo -a Please enter channel name to get access info | halt }
}
;-------------------------------------------------------------------------------------------
dialog cr5 {
  title " services"
  size -1 -1 129 51
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Akick add", 2, 3 3 123 34
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 39 25 10,ok
  button "Cancel", 9, 99 39 25 10, cancel
  text "Nick or Host:", 10, 8 24 33 8
  edit "", 11, 48 23 75 10, autohs
}
alias -l cr5 {
  dialog -m cr5 cr5
}
on *:dialog:cr5:edit:*: {
  if ($did == 3) { set %channelname5 $did(3) }
  if ($did == 11) { set %channelnick5 $did(10) }
}
on *:dialog:cr5:sclick:*: {
  if ($did == 8) { reg5 }
  if ($did == 9) { unset %channel* | did -u ds 10 }
}
alias -l reg5 {
  if (%channelname5 == $null) && (%channelnick5 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname5 != $null) && (%channelnick5 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname5 != $null) && (%channelnick5 != $null) {
    $dalchan akick %channelname5 add %channelnick5
    unset %channel*
    did -u ds 10
  }
}
;--------------------------------------------------------------------------------------------
dialog cr6 {
  title " services"
  size -1 -1 129 51
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Akick del", 2, 3 3 123 34
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 39 25 10,ok
  button "Cancel", 9, 99 39 25 10, cancel
  text "Nick or Host:", 10, 8 24 33 8
  edit "", 11, 48 23 75 10, autohs
}
alias -l cr6 {
  dialog -m cr6 cr6
}
on *:dialog:cr6:edit:*: {
  if ($did == 3) { set %channelname6 $did(3) }
  if ($did == 11) { set %channelnick6 $did(10) }
}
on *:dialog:cr6:sclick:*: {
  if ($did == 8) { reg6 }
  if ($did == 9) { unset %channel* | did -u ds 11 }
}
alias -l reg6 {
  if (%channelname6 == $null) && (%channelnick6 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname6 != $null) && (%channelnick6 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname6 != $null) && (%channelnick6 != $null) {
    $dalchan akick %channelname6 del %channelnick6
    unset %channel*
    did -u ds 11
  }
}
;--------------------------------------------------------------------------------------------
dialog cr7 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Akick list", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10,ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr7 {
  dialog -m cr7 cr7
}
on *:dialog:cr7:edit:*: {
  if ($did == 3) { set %channelname7 $did(3) }

}
on *:dialog:cr7:sclick:*: {
  if ($did == 8) { reg7 }
  if ($did == 9) { unset %channel* | did -u ds 12 }
}
alias -l reg7 {
  if (%channelname7 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname7 != $null) {
    $dalchan akick %channelname7 list 
    unset %channel*
    did -u ds 12
  }
}
;--------------------------------------------------------------------------------------------
dialog cr8 {
  title " services"
  size -1 -1 129 51
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Aop add", 2, 3 3 123 34
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 39 25 10, ok
  button "Cancel", 9, 99 39 25 10, cancel
  text "Nick or Host:", 10, 8 24 33 8
  edit "", 11, 48 23 75 10, autohs
}
alias -l cr8 {
  dialog -m cr8 cr8
}
on *:dialog:cr8:edit:*: {
  if ($did == 3) { set %channelname8 $did(3) }
  if ($did == 11) { set %channelnick8 $did(10) }
}
on *:dialog:cr8:sclick:*: {
  if ($did == 8) { reg8 }
  if ($did == 9) { unset %channel* | did -u ds 13 }
}
alias -l reg8 {
  if (%channelname8 == $null) && (%channelnick8 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname8 != $null) && (%channelnick8 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname8 != $null) && (%channelnick8 != $null) {
    $dalchan aop %channelname8 add %channelnick8
    unset %channel*
    did -u ds 13
  }
}
;--------------------------------------------------------------------------------------------
dialog cr9 {
  title " services"
  size -1 -1 129 51
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Aop del", 2, 3 3 123 34
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 39 25 10, ok
  button "Cancel", 9, 99 39 25 10, cancel
  text "Nick or Host:", 10, 8 24 33 8
  edit "", 11, 48 23 75 10, autohs
}
alias -l cr9 {
  dialog -m cr9 cr9
}
on *:dialog:cr9:edit:*: {
  if ($did == 3) { set %channelname9 $did(3) }
  if ($did == 11) { set %channelnick9 $did(10) }
}
on *:dialog:cr9:sclick:*: {
  if ($did == 8) { reg8 }
  if ($did == 9) { unset %channel* | did -u ds 14 }
}
alias -l reg9 {
  if (%channelname9 == $null) && (%channelnick9 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname9 != $null) && (%channelnick9 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname9 != $null) && (%channelnick9 != $null) {
    $dalchan aop %channelname9 del %channelnick9
    unset %channel*
    did -u ds 14
  }
}
;-------------------------------------------------------------------------------------------
dialog cr10 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Aop wipe", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10, ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr10 {
  dialog -m cr10 cr10
}
on *:dialog:cr10:edit:*: {
  if ($did == 3) { set %channelname10 $did(3) }

}
on *:dialog:cr10:sclick:*: {
  if ($did == 8) { reg10 }
  if ($did == 9) { unset %channel* | did -u ds 15 }
}
alias -l reg10 {
  if (%channelname10 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname10 != $null) {
    $dalchan aop %channelname10 wipe
    unset %channel*
    did -u ds 15
  }
}
;--------------------------------------------------------------------------------------------
dialog cr11 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Aop list", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10, ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr11 {
  dialog -m cr11 cr11
}
on *:dialog:cr11:edit:*: {
  if ($did == 3) { set %channelname11 $did(3) }

}
on *:dialog:cr11:sclick:*: {
  if ($did == 8) { reg11 }
  if ($did == 9) { unset %channel* | did -u ds 16 }
}
alias -l reg11 {
  if (%channelname11 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname11 != $null) {
    $dalchan aop %channelname11 list
    unset %channel*
    did -u ds 16
  }
}
;--------------------------------------------------------------------------------------------
dialog cr12 {
  title " services"
  size -1 -1 129 51
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Sop add", 2, 3 3 123 34
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 39 25 10, ok
  button "Cancel", 9, 99 39 25 10, cancel
  text "Nick or Host:", 10, 8 24 33 8
  edit "", 11, 48 23 75 10, autohs
}
alias -l cr12 {
  dialog -m cr12 cr12
}
on *:dialog:cr12:edit:*: {
  if ($did == 3) { set %channelname12 $did(3) }
  if ($did == 11) { set %channelnick12 $did(11) }
}
on *:dialog:cr12:sclick:*: {
  if ($did == 8) { reg12 }
  if ($did == 9) { unset %channel* | did -u ds 17 }
}
alias -l reg12 {
  if (%channelname12 == $null) && (%channelnick12 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname12 != $null) && (%channelnick12 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname12 != $null) && (%channelnick12 != $null) {
    $dalchan sop %channelname12 add %channelnick12
    unset %channel*
    did -u ds 17
  }
}
;--------------------------------------------------------------------------------------------
dialog cr13 {
  title " services"
  size -1 -1 129 51
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Sop del", 2, 3 3 123 34
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 39 25 10, ok
  button "Cancel", 9, 99 39 25 10, cancel
  text "Nick or Host:", 10, 8 24 33 8
  edit "", 11, 48 23 75 10, autohs
}
alias -l cr13 {
  dialog -m cr13 cr13
}
on *:dialog:cr13:edit:*: {
  if ($did == 3) { set %channelname13 $did(3) }
  if ($did == 11) { set %channelnick13 $did(10) }
}
on *:dialog:cr13:sclick:*: {
  if ($did == 8) { reg13 }
  if ($did == 9) { unset %channel* | did -u ds 18 }
}
alias -l reg13 {
  if (%channelname13 == $null) && (%channelnick13 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname13 != $null) && (%channelnick13 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname13 != $null) && (%channelnick13 != $null) {
    $dalchan sop %channelname13 del %channelnick13
    unset %channel*
    did -u ds 18
  }
}
;--------------------------------------------------------------------------------------------
dialog cr14 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Sop wipe", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10 , ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr14 {
  dialog -m cr14 cr14
}
on *:dialog:cr14:edit:*: {
  if ($did == 3) { set %channelname14 $did(3) }

}
on *:dialog:cr14:sclick:*: {
  if ($did == 8) { reg14 }
  if ($did == 9) { unset %channel* | did -u ds 19 }
}
alias -l reg14 {
  if (%channelname14 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname14 != $null) {
    $dalchan sop %channelname14 wipe
    unset %channel*
    did -u ds 19
  }
}
;--------------------------------------------------------------------------------------------
dialog cr15 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Sop list", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10, ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr15 {
  dialog -m cr15 cr15
}
on *:dialog:cr15:edit:*: {
  if ($did == 3) { set %channelname15 $did(3) }

}
on *:dialog:cr15:sclick:*: {
  if ($did == 8) { reg15 }
  if ($did == 9) { unset %channel* | did -u ds 20 }
}
alias -l reg15 {
  if (%channelname15 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname15 != $null) {
    $dalchan sop %channelname15 list
    unset %channel*
    did -u ds 20
  }
}
;--------------------------------------------------------------------------------------------
dialog cr16 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv op", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Nickname:", 11, 8 24 27 8
  edit "", 12, 48 23 75 10
}
alias -l cr16 {
  dialog -m cr16 cr16
}
on *:dialog:cr16:edit:*: {
  if ($did == 3) { set %channelname16 $did(3) }
  if ($did == 12) { set %channelnick16 $did(12) }
}
on *:dialog:cr16:sclick:*: {
  if ($did == 8) { reg16 }
  if ($did == 9) { unset %channel* | did -u ds 21 }
}
alias -l reg16 {
  if (%channelname16 == $null) && (%channelnick16 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname16 != $null) && (%channelnick16 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname16 != $null) && (%channelnick16 != $null) {
    $dalchan op %channelname16 %channelnick16
    unset %channel*
    did -u ds 21
  }
}
;--------------------------------------------------------------------------------------------
dialog cr17 {
  title " Services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv deop", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Nickname:", 11, 8 24 27 8
  edit "", 12, 48 23 75 10
}
alias -l cr17 {
  dialog -m cr17 cr17
}
on *:dialog:cr17:edit:*: {
  if ($did == 3) { set %channelname17 $did(3) }
  if ($did == 12) { set %channelnick17 $did(12) }
}
on *:dialog:cr17:sclick:*: {
  if ($did == 8) { reg17 }
  if ($did == 9) { unset %channel* | did -u ds 22 }
}
alias -l reg17 {
  if (%channelname17 == $null) && (%channelnick17 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname17 != $null) && (%channelnick17 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname17 != $null) && (%channelnick17 != $null) {
    $dalchan deop %channelname17 %channelnick17
    unset %channel*
    did -u ds 22
  }
}
;--------------------------------------------------------------------------------------------
dialog cr18 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv mdeop", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10, ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr18 {
  dialog -m cr18 cr18
}
on *:dialog:cr18:edit:*: {
  if ($did == 3) { set %channelname18 $did(3) }

}
on *:dialog:cr18:sclick:*: {
  if ($did == 8) { reg18 }
  if ($did == 9) { unset %channel* | did -u ds 23 }
}
alias -l reg18 {
  if (%channelname18 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname18 != $null) {
    $dalchan mdeop %channelname18 
    unset %channel*
    did -u ds 23
  }
}
;-------------------------------------------------------------------------------------------
dialog cr19 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv mkick", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10, ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr19 {
  dialog -m cr19 cr19
}
on *:dialog:cr19:edit:*: {
  if ($did == 3) { set %channelname19 $did(3) }

}
on *:dialog:cr19:sclick:*: {
  if ($did == 8) { reg19 }
  if ($did == 9) { unset %channel* | did -u ds 24 }
}
alias -l reg19 {
  if (%channelname19 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname19 != $null) {
    $dalchan mkick %channelname19 
    unset %channel*
    did -u ds 24
  }
}
;-------------------------------------------------------------------------------------------
dialog cr20 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv unban", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Nickname:", 11, 8 24 27 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr20 {
  dialog -m cr20 cr20
}
on *:dialog:cr20:edit:*: {
  if ($did == 3) { set %channelname20 $did(3) }
  if ($did == 12) { set %channelnick20 $did(12) }
}
on *:dialog:cr20:sclick:*: {
  if ($did == 8) { reg20 }
  if ($did == 9) { unset %channel* | did -u ds 25 }
}
alias -l reg20 {
  if (%channelname20 == $null) && (%channelnick20 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname20 != $null) && (%channelnick20 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname20 != $null) && (%channelnick20 != $null) {
    $dalchan unban %channelname20 %channelnick20
    unset %channel*
    did -u ds 25
  }
}
;-------------------------------------------------------------------------------------------
dialog cr21 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv invite", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Nickname:", 11, 8 24 27 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr21 {
  dialog -m cr21 cr21
}
on *:dialog:cr21:edit:*: {
  if ($did == 3) { set %channelname21 $did(3) }
  if ($did == 12) { set %channelnick21 $did(12) }
}
on *:dialog:cr21:sclick:*: {
  if ($did == 8) { reg21 }
  if ($did == 9) { unset %channel* | did -u ds 26 }
}
alias -l reg21 {
  if (%channelname21 == $null) && (%channelnick21 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname21 != $null) && (%channelnick21 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname21 != $null) && (%channelnick21 != $null) {
    $dalchan invite %channelname21 %channelnick21
    unset %channel*
    did -u ds 26
  }
}
;-------------------------------------------------------------------------------------------
dialog cr22 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv sendpass", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "E-mail:", 11, 8 24 27 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr22 {
  dialog -m cr22 cr22
}
on *:dialog:cr22:edit:*: {
  if ($did == 3) { set %channelname22 $did(3) }
  if ($did == 12) { set %channelemail22 $did(12) }
}
on *:dialog:cr22:sclick:*: {
  if ($did == 8) { reg22 }
  if ($did == 9) { unset %channel* | did -u ds 27 }
}
alias -l reg22 {
  if (%channelname22 == $null) && (%channelemail22 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname22 != $null) && (%channelemail22 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname22 != $null) && (%channelemail22 != $null) {
    $dalchan sendpass %channelname22 %channelemail22
    unset %channel*
    did -u ds 27

  }
}
;--------------------------------------------------------------------------------------------
dialog cr23 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Set new description", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "New desc.:", 11, 8 24 27 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr23 {
  dialog -m cr23 cr23
}
on *:dialog:cr23:edit:*: {
  if ($did == 3) { set %channelname23 $did(3) }
  if ($did == 12) { set %channeldescription22 $did(12) }
}
on *:dialog:cr23:sclick:*: {
  if ($did == 8) { reg23 }
  if ($did == 9) { unset %channel* | did -u ds 49 }
}
alias -l reg23 {
  if (%channelname23 == $null) && (%channeldescription22 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname23 != $null) && (%channeldescription22 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname23 != $null) && (%channeldescription22 != $null) {
    $dalchan set %channelname23 desc %channeldescription22
    unset %channel*
    did -u ds 49

  }
}
;--------------------------------------------------------------------------------------------
dialog cr24 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Set ident", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr24 {
  dialog -m cr24 cr24
}
on *:dialog:cr24:edit:*: {
  if ($did == 3) { set %channelname24 $did(3) }
  if ($did == 12) { set %channelonoff22 $did(12) }
}
on *:dialog:cr24:sclick:*: {
  if ($did == 8) { reg24 }
  if ($did == 9) { unset %channel* | did -u ds 50 }
}
alias -l reg24 {
  if (%channelname24 == $null) && (%channelonoff22 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname24 != $null) && (%channelonoff22 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname24 != $null) && (%channelonoff22 != $null) {
    $dalchan set %channelname24 ident %channelonoff22
    unset %channel*
    did -u ds 50

  }
}
;--------------------------------------------------------------------------------------------
dialog cr25 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Set ident", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr25 {
  dialog -m cr25 cr25
}
on *:dialog:cr25:edit:*: {
  if ($did == 3) { set %channelname25 $did(3) }
  if ($did == 12) { set %channelonoff25 $did(12) }
}
on *:dialog:cr25:sclick:*: {
  if ($did == 8) { reg25 }
  if ($did == 9) { unset %channel* | did -u ds 51 }
}
alias -l reg25 {
  if (%channelname25 == $null) && (%channelonoff25 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname25 != $null) && (%channelonoff25 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname25 != $null) && (%channelonoff25 != $null) {
    $dalchan set %channelname25 mlock %channelonoff25
    unset %channel*
    did -u ds 51

  }
}
;--------------------------------------------------------------------------------------------
dialog cr26 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Set new channel pass", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "New pass:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, pass autohs
}
alias -l cr26 {
  dialog -m cr26 cr26
}
on *:dialog:cr26:edit:*: {
  if ($did == 3) { set %channelname26 $did(3) }
  if ($did == 12) { set %channelpass25 $did(12) }
}
on *:dialog:cr26:sclick:*: {
  if ($did == 8) { reg26 }
  if ($did == 9) { unset %channel* | did -u ds 52 }
}
alias -l reg26 {
  if (%channelname26 == $null) && (%channelpass25 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname26 != $null) && (%channelpass25 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname26 != $null) && (%channelpass25 != $null) {
    $dalchan set %channelname26 passwd %channelonoff25
    unset %channel*
    did -u ds 52

  }
}
;--------------------------------------------------------------------------------------------
dialog cr27 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Set topiclock", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Founder/sop/off:", 11, 8 24 39 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr27 {
  dialog -m cr27 cr27
}
on *:dialog:cr27:edit:*: {
  if ($did == 3) { set %channelname27 $did(3) }
  if ($did == 12) { set %channelfso25 $did(12) }
}
on *:dialog:cr27:sclick:*: {
  if ($did == 8) { reg27 }
  if ($did == 9) { unset %channel* | did -u ds 53 }
}
alias -l reg27 {
  if (%channelname27 == $null) && (%channelfso25 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname27 != $null) && (%channelfso25 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname27 != $null) && (%channelfso25 != $null) {
    $dalchan set %channelname27 topiclock %channelfso25
    unset %channel*
    did -u ds 53

  }
}
;--------------------------------------------------------------------------------------------
dialog cr28 {
  title " services"
  size -1 -1 129 42
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Chanserv founder", 2, 3 3 123 25
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 30 25 10, ok
  button "Cancel", 9, 99 30 25 10, cancel
}
alias -l cr28 {
  dialog -m cr28 cr28
}
on *:dialog:cr28:edit:*: {
  if ($did == 3) { set %channelname28 $did(3) }

}
on *:dialog:cr28:sclick:*: {
  if ($did == 8) { reg28 }
  if ($did == 9) { unset %channel* | did -u ds 54 }
}
alias -l reg28 {
  if (%channelname28 == $null) { echo -a Please enter channel name | halt }
  elseif (%channelname28 != $null) {
    $dalchan set %channelname28 founder
    unset %channel*
    did -u ds 54
  }
}
;--------------------------------------------------------------------------------------------
dialog cr29 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Leaveops", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr29 {
  dialog -m cr29 cr29
}
on *:dialog:cr29:edit:*: {
  if ($did == 3) { set %channelname29 $did(3) }
  if ($did == 12) { set %channelonoff29 $did(12) }
}
on *:dialog:cr29:sclick:*: {
  if ($did == 8) { reg29 }
  if ($did == 9) { unset %channel* | did -u ds 55 }
}
alias -l reg29 {
  if (%channelname29 == $null) && (%channelonoff29 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname29 != $null) && (%channelonoff29 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname29 != $null) && (%channelonoff29 != $null) {
    $dalchan set %channelname29 leaveops %channelonoff29
    unset %channel*
    did -u ds 55

  }
}
;--------------------------------------------------------------------------------------------
dialog cr30 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Mailblock", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr30 {
  dialog -m cr30 cr30
}
on *:dialog:cr30:edit:*: {
  if ($did == 3) { set %channelname30 $did(3) }
  if ($did == 12) { set %channelonoff30 $did(12) }
}
on *:dialog:cr30:sclick:*: {
  if ($did == 8) { reg30 }
  if ($did == 9) { unset %channel* | did -u ds 56 }
}
alias -l reg30 {
  if (%channelname30 == $null) && (%channelonoff30 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname30 != $null) && (%channelonoff30 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname30 != $null) && (%channelonoff30 != $null) {
    $dalchan set %channelname30 mailblock %channelonoff30
    unset %channel*
    did -u ds 56

  }
}
;--------------------------------------------------------------------------------------------
dialog cr31 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Private", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr31 {
  dialog -m cr31 cr31
}
on *:dialog:cr31:edit:*: {
  if ($did == 3) { set %channelname31 $did(3) }
  if ($did == 12) { set %channelonoff31 $did(12) }
}
on *:dialog:cr31:sclick:*: {
  if ($did == 8) { reg31 }
  if ($did == 9) { unset %channel* | did -u ds 57 }
}
alias -l reg31 {
  if (%channelname31 == $null) && (%channelonoff31 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname31 != $null) && (%channelonoff31 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname31 != $null) && (%channelonoff31 != $null) {
    $dalchan set %channelname31 private %channelonoff31
    unset %channel*
    did -u ds 57

  }
}
;-------------------------------------------------------------------------------------------
dialog cr32 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Verbose", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr32 {
  dialog -m cr32 cr32
}
on *:dialog:cr32:edit:*: {
  if ($did == 3) { set %channelname32 $did(3) }
  if ($did == 12) { set %channelonoff32 $did(12) }
}
on *:dialog:cr32:sclick:*: {
  if ($did == 8) { reg32 }
  if ($did == 9) { unset %channel* | did -u ds 58 }
}
alias -l reg32 {
  if (%channelname32 == $null) && (%channelonoff32 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname32 != $null) && (%channelonoff32 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname32 != $null) && (%channelonoff32 != $null) {
    $dalchan set %channelname32 verbose %channelonoff32
    unset %channel*
    did -u ds 58

  }
}
;--------------------------------------------------------------------------------------------
dialog cr33 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Keeptopic", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr33 {
  dialog -m cr33 cr33
}
on *:dialog:cr33:edit:*: {
  if ($did == 3) { set %channelname33 $did(3) }
  if ($did == 12) { set %channelonoff33 $did(12) }
}
on *:dialog:cr33:sclick:*: {
  if ($did == 8) { reg33 }
  if ($did == 9) { unset %channel* | did -u ds 59 }
}
alias -l reg33 {
  if (%channelname33 == $null) && (%channelonoff33 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname33 != $null) && (%channelonoff33 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname33 != $null) && (%channelonoff33 != $null) {
    $dalchan set %channelname33 keeptopic %channelonoff33
    unset %channel*
    did -u ds 59

  }
}
;--------------------------------------------------------------------------------------------
dialog cr34 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Opguard", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr34 {
  dialog -m cr34 cr34
}
on *:dialog:cr34:edit:*: {
  if ($did == 3) { set %channelname34 $did(3) }
  if ($did == 12) { set %channelonoff34 $did(12) }
}
on *:dialog:cr34:sclick:*: {
  if ($did == 8) { reg34 }
  if ($did == 9) { unset %channel* | did -u ds 60 }
}
alias -l reg34 {
  if (%channelname34 == $null) && (%channelonoff34 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname34 != $null) && (%channelonoff34 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname34 != $null) && (%channelonoff34 != $null) {
    $dalchan set %channelname34 opguard %channelonoff34
    unset %channel*
    did -u ds 60

  }
}
;-------------------------------------------------------------------------------------------
dialog cr35 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Memo", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "None/aop/sop:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10, autohs
}
alias -l cr35 {
  dialog -m cr35 cr35
}
on *:dialog:cr35:edit:*: {
  if ($did == 3) { set %channelname35 $did(3) }
  if ($did == 12) { set %channelonoff35 $did(12) }
}
on *:dialog:cr35:sclick:*: {
  if ($did == 8) { reg35 }
  if ($did == 9) { unset %channel* | did -u ds 61 }
}
alias -l reg35 {
  if (%channelname35 == $null) && (%channelonoff35 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname35 != $null) && (%channelonoff35 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname35 != $null) && (%channelonoff35 != $null) {
    $dalchan set %channelname35 memo %channelonoff35
    unset %channel*
    did -u ds 61

  }
}
;-------------------------------------------------------------------------------------------
dialog cr36 {
  title " services"
  size -1 -1 129 53
  option dbu
  text "Channel Name:", 1, 8 14 39 8
  box "Restrict", 2, 3 3 123 35
  edit "", 3, 48 13 75 10, autohs
  button "Ok", 8, 73 41 25 10, ok
  button "Cancel", 9, 99 41 25 10, cancel
  text "Enter on/off:", 11, 8 24 37 8
  edit "", 12, 48 23 75 10,  autohs
}
alias -l cr36 {
  dialog -m cr36 cr36
}
on *:dialog:cr36:edit:*: {
  if ($did == 3) { set %channelname36 $did(3) }
  if ($did == 12) { set %channelonoff36 $did(12) }
}
on *:dialog:cr36:sclick:*: {
  if ($did == 8) { reg36 }
  if ($did == 9) { unset %channel* | did -u ds 62 }
}
alias -l reg36 {
  if (%channelname36 == $null) && (%channelonoff36 == $null) { echo -a Enter info in all fields | halt }
  if (%channelname36 != $null) && (%channelonoff36 == $null) { echo -a Enter info in all fields |  halt }
  elseif (%channelname36 != $null) && (%channelonoff36 != $null) {
    $dalchan set %channelname36 restrict %channelonoff36
    unset %channel*
    did -u ds 62

  }
}
on @!*:ban:#: {
  if ($network == $net) {
    if ($banmask iswm $address($me,5)) {
      $dalchan unban #
      mode # -o $nick
      kick # $nick Don't ban me!
    }
  }
}
;--------------------------------------------------------------------------------------------
