;nexMAIL v1.01 beta
;Team Nexgen 2002 by KnightFal
;www.team-nexgen.org

on *:load:{ echo -a  4TEAM NEXGEN'S NEXMAIL v1.0 beta | echo -a  4Please type: /nexmail to send e-mail. Type: /nexmail-set to configure. }

menu menubar,status,channel {
  $iif($acid == $true,• utilities)
  .nexMail
  ..send:nexmail
  ..setup:nexmail-set
  $iif($acid != $true,nexMail)
  .nexMail
  ..send:nexmail
  ..setup:nexmail-set
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
alias nexmail { if ($dialog(nexmail) == $null) { dialog -m nexmail nexmail } }
dialog nexMail {
  title "v1.01 nexmail"
  size -1 -1 344 323
  button "", 112, 10 410 1 1, default ok
  icon 11, 18 10 35 35
  icon 20, 68 10 35 35
  icon 25, 294 9 35 35
  text "outbox", 26, 291 44 34 14
  text "setup", 21, 69 41 30 12
  text "send", 18, 19 41 30 14
  box "", 13, 6 1 103 55
  box "status", 14, 2 260 340 40
  text "sender:", 1, 37 65 42 16
  text "to:", 4, 37 85 20 13
  text "subject:", 6, 37 105 40 14
  edit "", 7, 87 105 215 20
  edit "", 9, 4 130 335 130, multi return vsbar
  text "", 10, 10 277 326 20
  text "", 16, 105 304 215 16
  text "POP3 (Mail) Server:", 17, 5 304 95 12
  box "", 30, 2 295 340 25
  combo 3, 88 85 213 100, sort size edit drop
  combo 5, 88 63 213 100, sort size edit drop
  box "", 8, 16 52 311 77
}
on *:DIALOG:nexmail:edit:*: {
  if ($did == 5) { _vw nexmail from $did(nexMAIL,5) }
  if ($did == 3) { set %nexmail_to $did(nexMAIL,3)  }
  if ($did == 7) { set %nexmail_sub $did(nexMAIL,7) }
}
on *:dialog:nexMAIL:init:*:{
  if ($exists($shortfn($findfile($mircdir,nexmail4.ico,1))) != $false) did -g nexmail 11 $shortfn($findfile($mircdir,nexmail4.ico,1))
  if ($exists($shortfn($findfile($mircdir,nexmail3.ico,1))) != $false) did -g nexmail 20 $shortfn($findfile($mircdir,nexmail3.ico,1))
  if ($exists($shortfn($findfile($mircdir,nexmail2.ico,1))) != $false) did -g nexmail 25 $shortfn($findfile($mircdir,nexmail2.ico,1))
  set %mail.i 0
  did -a nexMAIL 5 $_vr(nexmail,from)
  did -a nexMAIL 16 $_vr(nexmail,server)
  if (%defserv != $null) { did -a nexMAIL 5 %defname }
  if (%setdef == $null) { set %setdef off }
  if (%setdef == off) { unset %defname | unset %defmail }
  if (%setdef == on) { did -c nexMAIL 3 | did -b nexMAIL 5 }
}
on *:dialog:nexMAIL:sclick:*:{
  if ($did == 11) { sockopen mail $_vr(nexmail,server) 25 | sclick }
  if ($did == 20) { nexmail-set | sclick }
}

on *:sockopen:mail:{
  if ( $sockerr > 0 ) { did -o nexMAIL 10 1 Error while sending. | sockclose mail | beep | halt }
  set %mail.i 0
}
on *:sockread:mail:{
  sockread %mail
  MailRead %mail
}
alias MailRead {
  inc %mail.i
  set %raw $left($1,3)
  if (%mail.i == 1) && (%raw != 220) { did -o nexMAIL 10 1 Error while sending. | sockclose mail | beep | halt }
  if ($left(%raw,1) == 3) { did -o nexMAIL 10 1 Error while sending: $1- | sockclose mail | beep | halt }
  if (%raw == 220) && (%mail.i == 1) {
    did -o nexMAIL 10 1 Connected...
    sockwrite -n mail HELO $host
  }
  if (%mail.i == 5) sockwrite -n mail MAIL FROM: $_vr(nexmail,from)
  if (%mail.i == 3) sockwrite -n mail RCPT TO: %nexmail_to
  if (%mail.i == 4) {
    sockwrite -n mail DATA
    sockwrite -n mail  X-Mailer: nexMAIL e-mail script dialog www.team-nexgen.org
    sockwrite -n mail FROM: $_vr(nexmail,from)    
    sockwrite -n mail TO: %nexmail_to   
    sockwrite -n mail Subject: %nexmail_sub
    :loop
    inc -u %nexMAIL.temp
    if (%nexMAIL.temp > 100) { goto end }
    sockwrite -n mail $iif($did(nexMAIL,9,%nexMAIL.temp) != $null,$did(nexMAIL,9,%nexMAIL.temp),$crlf)
    goto loop
    :end
    sockwrite -n mail .
    .timer 1 1 sockclose mail
    did -o nexMAIL 10 1 Mail successfully sent!
    did -r nexMAIL 7
    did -r nexMAIL 9
    did -r nexMAIL 3
    sops
  }
  if (%mail.i == 3) sockwrite -n mail QUIT
}
alias nexmail-set if ($dialog(nexmail-set) == $null) { dialog -md nexmail-set nexmail-set }
alias email-check if ($dialog(email-check) == $null) { dialog -mdo email-check email-check }
dialog nexmail-set {
  title "nexMAIL Setup"
  size -1 -1 320 220
  button "OK",1,10 185 42 20, OK
  box "Account Info",2,5 5 310 120

  text "E-mail:",18,10 30 60 20
  edit "",19,110 30 150 20,autohs
  icon 30, 270 20 35 35
  text "SETUP",38,269 55 60 20
  text "Username:",5,10 50 60 20
  edit "",6,110 50 150 20,autohs
  text "POP3 (Mail) Server:",7, 10 70 110 20
  edit "",8,110 70 150 20
  text "Password:",9, 10 90 110 20
  edit "",10,110 90 150 20,autohs pass
  ;check "Check E-mail every",15, 15 170 125 20
  ;edit "",16,145 170 30 20,autohs
  ;text "min(s)",17,177 175 50 20
  check "'New E-mail' Sound",22,15 128 115 20
  edit "",23,15 150 225 20, autohs read
  button "Select",24,245 150 70 18
}

on *:DIALOG:nexmail-set:init:*: {
  if ($exists($shortfn($findfile($mircdir,nexmail3.ico,1))) != $false) { did -g nexmail-set 30 $shortfn($findfile($mircdir,nexmail3.ico,1)) }
  did -a nexMAIL-set 8 $_vr(nexmail,server)
  did -a nexMAIL-set 6 $_vr(nexmail,user)
  did -a nexMAIL-set 10 $_vr(nexmail,pass)
  did -a nexMAIL-set 19 $_vr(nexmail,from)
  if (%nexmail-set-autocheck-state == 1) { did -c nexmail-set 15 }
  if (%nexmail-set-autocheck-duration != $null) { did -a nexmail-set 16 %nexmail-set-autocheck-duration }
  if (%nexmail-set-new-sound == 1) { did -c nexmail-set 22  }
  if (%nexmail-set-new-sound-filename != $null) { did -a nexmail-set 23 %nexmail-set-new-sound-filename }
}
on *:DIALOG:nexmail-set:edit:*: {
  if ($did == 16) {  set %nexmail-set-autocheck-duration $did(16).text }
  if ($did == 8) { _vw nexmail server $did(nexMAIL-set,8).text }
  if ($did == 6) { _vw nexmail user $did(nexMAIL-set,6).text }
  if ($did == 10) { _vw nexmail pass $did(nexMAIL-set,10).text }
  if ($did == 19) { _vw nexmail from $did(nexMAIL-set,19).text }
}
alias nexmail-set-sound {
  unset %nexmail-set-new-sound-temp
  set %nexmail-set-new-sound-temp $dir="Select Wav File", $wavedir*.wav
  if (%nexmail-set-new-sound-temp != $null) {   set %nexmail-set-new-sound-filename %nexmail-set-new-sound-temp | did -r nexmail-set 23 | did -a nexmail-set 23 %nexmail-set-new-sound-filename }
  if (%nexmail-set-new-sound-temp == $null) { echo 4 -s *** E-mail Checker: No new sound selected, thus no change has been made }
}
on *:DIALOG:nexmail-set:sclick:*: {
  if ($did == 1)  {  dialog -x nexmail-set |   .timer -m 1 1 nexmail | halt }
  if ($did == 15) { set %nexmail-set-autocheck-state $did(15).state }
  if ($did == 22) { set %nexmail-set-new-sound $did(22).state }
  if ($did == 24) { .timer -m 1 1 nexmail-set-sound  }
}
