alias -l dal {
  if ($network == dalnet) { return msg NickServ@services.dal.net }
  if ($network == gamesnet) { return msg AuthServ } 
  else { return msg nickserv }
}
alias -l dalmem {
  if ($network == dalnet) { return msg MemoServ@services.dal.net }
  else { return msg memoserv }
}
dialog nr {
  title "services"
  size -1 -1 160 81
  option dbu
  box "Nickserv Acc", 1, 3 3 116 27
  text "Nickname:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr {
  dialog -m nr nr 
}
on *:dialog:nr:edit:*: {
  if ($did == 3) { set %nacc $did(3) }
}
on *:dialog:nr:sclick:*: {
  if ($did == 4) { nacc }
  if ($did == 5) { unset %nacc | did -u ds 75 }
}
alias nacc {
  if (%nacc == $null) { echo -a Please enter Nickname in editbox | halt }
  elseif (%nacc != $null) { $dal acc %nacc | unset %nacc | did -u ds 75 }
}
;------------------------------------------------------------------------------------------
dialog nr1 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv Acc add", 1, 3 3 116 27
  text "User mask:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr1 {
  dialog -m nr1 nr1 
}
on *:dialog:nr1:edit:*: {
  if ($did == 3) { set %nacc1 $did(3) }
}
on *:dialog:nr1:sclick:*: {
  if ($did == 4) { nacc1 }
  if ($did == 5) { unset %nacc1 | did -u ds 63 }
}
alias nacc1 {
  if (%nacc1 == $null) { echo -a Please enter User host mask in editbox | halt }
  elseif (%nacc1 != $null) { $dal access add %nacc1 | unset %nacc1 | did -u ds 63 }
}
;--------------------------------------------------------------------------------------------
dialog nr2 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv Acc del", 1, 3 3 116 27
  text "User mask:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr2 {
  dialog -m nr2 nr2 
}
on *:dialog:nr2:edit:*: {
  if ($did == 3) { set %nacc2 $did(3) }
}
on *:dialog:nr2:sclick:*: {
  if ($did == 4) { nacc2 }
  if ($did == 5) { unset %nacc2 | did -u ds 64 }
}
alias nacc2 {
  if (%nacc2 == $null) { echo -a Please enter User hostmask in editbox | halt }
  elseif (%nacc2 != $null) { $dal access del %nacc2 | unset %nacc2 | did -u ds 64 }
}
;------------------------------------------------------------------------------------------
alias nr3 {
  did -u ds 65
  $dal access wipe

}
alias nr4 {
  did -u ds 66
  $dal access list

}
;------------------------------------------------------------------------------------------
dialog nr5 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Nickserv Register", 1, 3 3 116 36
  text "Password", 2, 8 15 26 8
  edit "", 3, 38 14 75 10, autohs pass
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "E-mail:", 6, 8 26 18 8
  edit "", 7, 38 24 75 10, autohs
}
alias nr5 {
  dialog -m nr5 nr5 
}
on *:dialog:nr5:edit:*: {
  if ($did == 3) { set %nacc3 $did(3) }
  if ($did == 7) { set %nac3 $did(7) }
}
on *:dialog:nr5:sclick:*: {
  if ($did == 4) { nacc3 }
  if ($did == 5) { unset %nacc3 | unset %nac3 | did -u ds 67 }
}
alias nacc3 { 
  if (%nacc3 == $null) && (%nac3 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%nacc3 != $null) && (%nac3 != $null) { $dal register %nacc3 %nac3 | unset %nacc3 | unset %nac3 | did -u ds 67 } 
}
;------------------------------------------------------------------------------------------
dialog nr6 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv identify", 1, 3 3 116 27
  text "Password:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs pass
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr6 {
  dialog -m nr6 nr6 
}
on *:dialog:nr6:edit:*: {
  if ($did == 3) { set %nacc6 $did(3) }
}
on *:dialog:nr6:sclick:*: {
  if ($did == 4) { nacc6 }
  if ($did == 5) { unset %nacc6 | did -u ds 68 }
}
alias nacc6 {
  if (%nacc6 == $null) { echo -a Please enter Your password in editbox | halt }
  elseif (%nacc6 != $null) { $dal identify %nacc6 | unset %nacc6 | did -u ds 68 }
}
;-------------------------------------------------------------------------------------------
dialog nr7 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Nickserv Ghost", 1, 3 3 116 36
  text "Nickname:", 2, 8 15 26 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "Password:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, pass autohs
}
alias nr7 {
  dialog -m nr7 nr7 
}
on *:dialog:nr7:edit:*: {
  if ($did == 3) { set %nacc7 $did(3) }
  if ($did == 7) { set %nac7 $did(7) }
}
on *:dialog:nr7:sclick:*: {
  if ($did == 4) { nacc7 }
  if ($did == 5) { unset %nacc7 | unset %nac7 | did -u ds 69 }
}
alias nacc7 { 
  if (%nacc7 == $null) && (%nac7 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%nacc7 != $null) && (%nac7 != $null) { $dal ghost %nacc7 %nac7 | unset %nacc3 | unset %nac3 | did -u ds 69 } 
}
;-------------------------------------------------------------------------------------------
dialog nr8 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv drop", 1, 3 3 116 27
  text "Nickname:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr8 {
  dialog -m nr8 nr8 
}
on *:dialog:nr8:edit:*: {
  if ($did == 3) { set %nacc8 $did(3) }
}
on *:dialog:nr8:sclick:*: {
  if ($did == 4) { nacc8 }
  if ($did == 5) { unset %nacc8 | did -u ds 70 }
}
alias nacc8 {
  if (%nacc8 == $null) { echo -a Please enter Your nickname in editbox | halt }
  elseif (%nacc8 != $null) { $dal drop %nacc8 | unset %nacc8 | did -u ds 70 }
}
;------------------------------------------------------------------------------------------
dialog nr9 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Nickserv Recover", 1, 3 3 116 36
  text "Nickname:", 2, 8 15 26 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "Password:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, pass autohs
}
alias nr9 {
  dialog -m nr9 nr9 
}
on *:dialog:nr9:edit:*: {
  if ($did == 3) { set %nacc9 $did(3) }
  if ($did == 7) { set %nac9 $did(7) }
}
on *:dialog:nr9:sclick:*: {
  if ($did == 4) { nacc9 }
  if ($did == 5) { unset %nacc9 | unset %nac9 | did -u ds 71 }
}
alias nacc9 { 
  if (%nacc9 == $null) && (%nac9 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%nacc9 != $null) && (%nac9 != $null) { $dal recover %nacc9 %nac9 | unset %nacc9 | unset %nac9 | did -u ds 71 } 
}
;--------------------------------------------------------------------------------------------
dialog nr10 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Nickserv Release", 1, 3 3 116 36
  text "Nickname:", 2, 8 15 26 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "Password:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, pass autohs
}
alias nr10 {
  dialog -m nr10 nr10 
}
on *:dialog:nr10:edit:*: {
  if ($did == 3) { set %nacc10 $did(3) }
  if ($did == 7) { set %nac10 $did(7) }
}
on *:dialog:nr10:sclick:*: {
  if ($did == 4) { nacc10 }
  if ($did == 5) { unset %nacc10 | unset %nac10 | did -u ds 72 }
}
alias nacc10 { 
  if (%nacc10 == $null) && (%nac10 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%nacc10 != $null) && (%nac10 != $null) { $dal release %nacc10 %nac10 | unset %nacc10 | unset %nac10 | did -u ds 72 } 
}
;--------------------------------------------------------------------------------------------
dialog nr11 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Nickserv Release", 1, 3 3 116 36
  text "Nickname:", 2, 8 15 26 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "E-mail:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, autohs
}
alias nr11 {
  dialog -m nr11 nr11 
}
on *:dialog:nr11:edit:*: {
  if ($did == 3) { set %nacc11 $did(3) }
  if ($did == 7) { set %nac11 $did(7) }
}
on *:dialog:nr11:sclick:*: {
  if ($did == 4) { nacc11 }
  if ($did == 5) { unset %nacc11 | unset %nac11 | did -u ds 73 }
}
alias nacc11 { 
  if (%nacc11 == $null) && (%nac11 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%nacc11 != $null) && (%nac11 != $null) { $dal sendpass %nacc11 %nac11 | unset %nacc11 | unset %nac11 | did -u ds 73 } 
}
;------------------------------------------------------------------------------------------
dialog nr12 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv info", 1, 3 3 116 27
  text "Nickname:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr12 {
  dialog -m nr12 nr12 
}
on *:dialog:nr12:edit:*: {
  if ($did == 3) { set %nacc12 $did(3) }
}
on *:dialog:nr12:sclick:*: {
  if ($did == 4) { nacc12 }
  if ($did == 5) { unset %nacc12 | did -u ds 74 }
}
alias nacc12 {
  if (%nacc12 == $null) { echo -a Please enter Nickname in editbox | halt }
  elseif (%nacc12 != $null) { $dal info %nacc12 | unset %nacc12 | did -u ds 74 }
}
;------------------------------------------------------------------------------------------
dialog nr13 {
  title "services"
  size -1 -1 122 54
  option dbu
  box "Nickserv set email", 1, 3 3 116 37
  text "Password:", 2, 8 15 29 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 63 42 25 10, ok
  button "Cancel", 5, 89 42 25 10, cancel
  text "New e-mail", 6, 8 26 29 8
  edit "", 7, 38 25 75 10, autohs
}
alias nr13 {
  dialog -m nr13 nr13 
}
on *:dialog:nr13:edit:*: {
  if ($did == 3) { set %nacc13 $did(3) }
  if ($did == 7) { set %naccmail13 $did(7) }
}
on *:dialog:nr13:sclick:*: {
  if ($did == 4) { nacc13 }
  if ($did == 5) { unset %nacc13 | did -u ds 83 }
}
alias nacc13 {
  if (%nacc13 == $null) { echo -a Please enter email in editbox | halt }
  elseif (%nacc13 != $null) { $dal set email %nacc13 %naccmail13 | unset %nacc13 | unset %naccmail13 | did -u ds 83 }
}
;--------------------------------------------------------------------------------------------
dialog nr14 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv set enforce", 1, 3 3 116 27
  text "Enter on/off:", 2, 8 15 35 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr14 {
  dialog -m nr14 nr14 
}
on *:dialog:nr14:edit:*: {
  if ($did == 3) { set %nacc14 $did(3) }
}
on *:dialog:nr14:sclick:*: {
  if ($did == 4) { nacc14 }
  if ($did == 5) { unset %nacc14 | did -u ds 76 }
}
alias nacc14 {
  if (%nacc14 == $null) { echo -a Please enter on or off in editbox | halt }
  elseif (%nacc14 != $null) { $dal set enforce %nacc14 | unset %nacc14 | did -u ds 76 }
}
;-------------------------------------------------------------------------------------------
dialog nr15 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv set noop", 1, 3 3 116 27
  text "Enter on/off:", 2, 8 15 35 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr15 {
  dialog -m nr15 nr15 
}
on *:dialog:nr15:edit:*: {
  if ($did == 3) { set %nacc15 $did(3) }
}
on *:dialog:nr15:sclick:*: {
  if ($did == 4) { nacc15 }
  if ($did == 5) { unset %nacc15 | did -u ds 77 }
}
alias nacc15 {
  if (%nacc15 == $null) { echo -a Please enter on or off in editbox | halt }
  elseif (%nacc15 != $null) { $dal set noop %nacc15 | unset %nacc15 | did -u ds 77 }
}
;--------------------------------------------------------------------------------------------
dialog nr16 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv set showmail", 1, 3 3 116 27
  text "Enter on/off:", 2, 8 15 35 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr16 {
  dialog -m nr16 nr16 
}
on *:dialog:nr16:edit:*: {
  if ($did == 3) { set %nacc16 $did(3) }
}
on *:dialog:nr16:sclick:*: {
  if ($did == 4) { nacc16 }
  if ($did == 5) { unset %nacc16 | did -u ds 78 }
}
alias nacc16 {
  if (%nacc16 == $null) { echo -a Please enter on or off in editbox | halt }
  elseif (%nacc16 != $null) { $dal set showmail %nacc16 | unset %nacc16 | did -u ds 78 }
}
;----------------------------------------------------------------------------------------------
dialog nr17 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Change password", 1, 3 3 116 36
  text "Current pass:", 2, 8 15 36 8
  edit "", 3, 38 14 75 10, autohs pass
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "New pass:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, pass autohs
}
alias nr17 {
  dialog -m nr17 nr17 
}
on *:dialog:nr17:edit:*: {
  if ($did == 3) { set %nacc17 $did(3) }
  if ($did == 7) { set %nac17 $did(7) }
}
on *:dialog:nr17:sclick:*: {
  if ($did == 4) { nacc17 }
  if ($did == 5) { unset %nacc17 | unset %nac17 | did -u ds 79 }
}
alias nacc17 { 
  if (%nacc17 == $null) && (%nac17 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%nacc17 != $null) && (%nac17 != $null) { $dal set passwd %nacc17 %nac17 | unset %nacc17 | unset %nac17 | did -u ds 79 } 
}
;--------------------------------------------------------------------------------------------
dialog nr18 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv set url", 1, 3 3 116 27
  text "Enter url:", 2, 8 15 35 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr18 {
  dialog -m nr18 nr18 
}
on *:dialog:nr18:edit:*: {
  if ($did == 3) { set %nacc18 $did(3) }
}
on *:dialog:nr18:sclick:*: {
  if ($did == 4) { nacc18 }
  if ($did == 5) { unset %nacc18 | did -u ds 80 }
}
alias nacc18 {
  if (%nacc18 == $null) { echo -a Please enter url in editbox | halt }
  elseif (%nacc18 != $null) { $dal set url %nacc18 | unset %nacc18 | did -u ds 80 }
}
;----------------------------------------------------------------------------------------------
dialog nr19 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv set mailblock", 1, 3 3 116 27
  text "Enter on/off:", 2, 8 15 35 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr19 {
  dialog -m nr19 nr19 
}
on *:dialog:nr19:edit:*: {
  if ($did == 3) { set %nacc19 $did(3) }
}
on *:dialog:nr19:sclick:*: {
  if ($did == 4) { nacc19 }
  if ($did == 5) { unset %nacc19 | did -u ds 81 }
}
alias nacc19 {
  if (%nacc19 == $null) { echo -a Please enter on or off in editbox | halt }
  elseif (%nacc19 != $null) { $dal set mailblock %nacc19 | unset %nacc19 | did -u ds 81  }
}
;---------------------------------------------------------------------------------------------
dialog nr20 {
  title "services"
  size -1 -1 122 44
  option dbu
  box "Nickserv set nomemo", 1, 3 3 116 27
  text "Enter on/off:", 2, 8 15 35 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 65 32 25 10, ok
  button "Cancel", 5, 91 32 25 10, cancel
}
alias nr20 {
  dialog -m nr20 nr20 
}
on *:dialog:nr20:edit:*: {
  if ($did == 3) { set %nacc20 $did(3) }
}
on *:dialog:nr20:sclick:*: {
  if ($did == 4) { nacc20 }
  if ($did == 5) { unset %nacc20 | did -u ds 82 }
}
alias nacc20 {
  if (%nacc20 == $null) { echo -a Please enter on or off in editbox | halt }
  elseif (%nacc20 != $null) { $dal set nomemo %nacc20 | unset %nacc20 | did -u ds 82 }
}
;-----------------------------------------------------------------------------------------------
dialog mr {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Send memo", 1, 3 3 116 36
  text "Nick/Chan:", 2, 8 15 30 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "Message:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, autohs
}
alias  mr {
  dialog -m mr mr 
}
on *:dialog:mr:edit:*: {
  if ($did == 3) { set %mr $did(3) }
  if ($did == 7) { set %mr1 $did(7) }
}
on *:dialog:mr:sclick:*: {
  if ($did == 4) { mr1 }
  if ($did == 5) { unset %mr | unset %mr1 | did -u ds 91 }
}
alias mr1 { 
  if (%mr == $null) && (%mr1 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%mr != $null) && (%mr1 != $null) { $dalmem send %mr %mr1 | unset %mr | unset %mr1 | did -u ds 91 } 
}
;--------------------------------------------------------------------------------------------
dialog mr2 {
  title "services"
  size -1 -1 132 42
  option dbu
  box "Memoserv read", 1, 3 3 126 25
  text "Number of msg:", 2, 8 13 39 8
  edit "", 3, 48 12 75 10, autohs
  button "Ok", 4, 74 30 25 10, ok
  button "Cancel", 5, 100 30 25 10, cancel
}
alias mr2 {
  dialog -m mr2 mr2
}
on *:dialog:mr2:edit:*: {
  if ($did == 3) { set %mrs $did(3) }
}
on *:dialog:mr2:sclick:*: {
  if ($did == 4) { mrs1 }
  if ($did == 5) { unset %mrs | did -u ds 84 }
}
alias mrs1 {
  if (%mrs == $null) { echo -a Enter number of memo you wish to read | halt }
  elseif (%mrs != $null) { $dalmem read %mrs | unset %mrs | did -u ds 84 }
}
;------------------------------------------------------------------------------------------
dialog mr3 {
  title "services"
  size -1 -1 132 42
  option dbu
  box "Memoserv undel", 1, 3 3 126 25
  text "Number of msg:", 2, 8 13 39 8
  edit "", 3, 48 12 75 10, autohs
  button "Ok", 4, 74 30 25 10, ok
  button "Cancel", 5, 100 30 25 10, cancel
}
alias mr3 {
  dialog -m mr3 mr3
}
on *:dialog:mr3:edit:*: {
  if ($did == 3) { set %mrs3 $did(3) }
}
on *:dialog:mr3:sclick:*: {
  if ($did == 4) { mrs3 }
  if ($did == 5) { unset %mrs3 | did -u ds 85 }
}
alias mrs3 {
  if (%mrs3 == $null) { echo -a Enter number of memo you don`t want to delete | halt }
  elseif (%mrs3 != $null) { $dalmem undel %mrs3 | unset %mrs3 | did -u ds 85 }
}
;--------------------------------------------------------------------------------------
alias mr4 {
  $dalmem list
  did -u ds 86
}
;---------------------------------------------------------------------------------------
dialog mr5 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "forward memo", 1, 3 3 116 36
  text "Nickname:", 2, 8 15 30 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "Password:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, pass autohs
}
alias mr5 {
  dialog -m mr5 mr5 
}
on *:dialog:mr5:edit:*: {
  if ($did == 3) { set %mr5 $did(3) }
  if ($did == 7) { set %mr15 $did(7) }
}
on *:dialog:mr5:sclick:*: {
  if ($did == 4) { mr15 }
  if ($did == 5) { unset %mr5 | unset %mr15 | did -u ds 87 }
}
alias mr15 { 
  if (%mr5 == $null) && (%mr15 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%mr5 != $null) && (%mr15 != $null) { $dalmem forward %mr5 %mr15 | unset %mr5 | unset %mr15 | did -u ds 87 } 
}
;-----------------------------------------------------------------------------------------
alias mr6 {
  $dalmem news
  did -u ds 88
}
;-----------------------------------------------------------------------------------------
dialog mr7 {
  title "services"
  size -1 -1 132 42
  option dbu
  box "Delete memo", 1, 3 3 126 25
  text "Memo number:", 2, 8 13 42 8
  edit "", 3, 48 12 75 10, autohs
  button "Ok", 4, 74 30 25 10, ok
  button "Cancel", 5, 100 30 25 10, cancel
}
alias mr7 {
  dialog -m mr7 mr7
}
on *:dialog:mr7:edit:*: {
  if ($did == 3) { set %mrs7 $did(3) }
}
on *:dialog:mr7:sclick:*: {
  if ($did == 4) { mrs7 }
  if ($did == 5) { unset %mrs7 | did -u ds 89 }
}
alias mrs7 {
  if (%mrs7 == $null) { echo -a Enter number of memo you want to delete | halt }
  elseif (%mrs7 != $null) { $dalmem del %mrs7 | unset %mrs7 | did -u ds 89 }
}
;-----------------------------------------------------------------------------------------
alias mr8 {
  $dalmem purge
  did -u ds 90
}
;------------------------------------------------------------------------------------------
dialog mr9 {
  title "services"
  size -1 -1 122 53
  option dbu
  box "Sendsop", 1, 3 3 116 36
  text "Channel name:", 2, 8 15 30 8
  edit "", 3, 38 14 75 10, autohs
  button "Ok", 4, 64 41 25 10, ok
  button "Cancel", 5, 90 41 25 10, cancel
  text "Message:", 6, 8 26 28 8
  edit "", 7, 38 24 75 10, autohs
}
alias mr9 {
  dialog -m mr9 mr9 
}
on *:dialog:mr9:edit:*: {
  if ($did == 3) { set %mr9 $did(3) }
  if ($did == 7) { set %mr19 $did(7) }
}
on *:dialog:mr9:sclick:*: {
  if ($did == 4) { mr19 }
  if ($did == 5) { unset %mr9 | unset %mr19 | did -u ds 92 }
}
alias mr19 { 
  if (%mr9 == $null) && (%mr19 == $null) { echo -a Please enter info in all fields | halt }
  elseif (%mr9 != $null) && (%mr19 != $null) { $dalmem sendsop %mr9 %mr19 | unset %mr9 | unset %mr19 | did -u ds 92 } 
}
on *:connect: {
  if ($network == undernet) {
    if ($_vr(undernet,show) == $null) { _vw undernet show on }
    if ($_vr(undernet,show) == on) { undernet }
    if ($_vr(undernet,switch) == on) { 
      if ($_vr(undernet,connect) == on) { 
        if ($_vr(undernet,username) != $null) && ($_vr(undernet,password) != $null) {
          .msg x@channels.undernet.org login $_vr(undernet,username) $_vr(undernet,password) 
          if ($_vr(undernet,hide) == on) { .timer 1 2 mode $me +x }
        }
      }
    }
  }
}
menu channel,status {
  $iif($network == undernet, $lower($network) login):undernet
}
alias undernet {
  if ($dialog(undernet) == $null) { dialog -m undernet undernet }
}
dialog undernet {
  title "undernet"
  size -1 -1 59 100
  option dbu
  button "Button", 1, 88 179 37 12, ok
  edit "", 2, 4 9 50 10
  text "username", 4, 4 1 25 8
  edit "", 5, 4 27 50 10, pass
  text "password", 6, 4 20 25 7
  check "enable", 7, 4 38 27 10
  check "host hiding", 8, 4 47 38 11
  button "login", 9, 14 79 30 9
  check "login on connect", 10, 4 57 50 11
  check "show on connect", 11, 4 67 50 10
  link "create account", 3, 11 90 38 8
}
on *:dialog:undernet:init:*:{
  if ($_vr(undernet,switch) == on) { did -c undernet 7 }
  if ($_vr(undernet,hide) == on) { did -c undernet 8 }
  if ($_vr(undernet,connect) == on) { did -c undernet 10 }
  if ($_vr(undernet,show) == on) { did -c undernet 11 }
  did -o undernet 2 1 $_vr(undernet,username)
  did -o undernet 5 1 $_vr(undernet,password)
  if ($_vr(undernet,username) == $null) || ($_vr(undernet,password) == $null) { did -b undernet 10,9,8 }
}
alias -l dis {
  if ($_vr(undernet,username) == $null) || ($_vr(undernet,password) == $null) { did -b undernet 10,9,8 }
  elseif ($_vr(undernet,username) != $null) || ($_vr(undernet,password) != $null) { did -e undernet 10,9,8 }
}
on *:dialog:undernet:edit:*:{
  if ($did == 2) { 
    if ($did(2).text == $null) { _vrem undernet username | dis }
    _vw undernet username $did(2).text 
    dis 
  }
  if ($did == 5) { 
    if ($did(5).text == $null) { _vrem undernet password | dis }
    _vw undernet password $did(5).text 
  }
}
on *:dialog:undernet:sclick:*:{
  if ($did == 3) { run http://cservice.undernet.org/live/newuser.php }
  if ($did == 7) {
    if ($_vr(undernet,switch) == on) { _vw undernet switch off }
    else { _vw undernet switch on }
  }
  if ($did == 8) {
    if ($_vr(undernet,hide) == on) {  _vw undernet hide off }
    else { _vw undernet hide on }
  }
  if ($did == 9) { 
    .msg x@channels.undernet.org login $_vr(undernet,username) $_vr(undernet,password)
    if ($_vr(undernet,hide) == on) { .timer 1 2 mode $me +x }
  }
  if ($did == 10) {
    if ($_vr(undernet,connect) == on) { _vw undernet connect off }
    else { _vw undernet connect on }
  }
  if ($did == 11) {
    if ($_vr(undernet,show) == on) { _vw undernet show off }
    else { _vw undernet show on }
  }
}
