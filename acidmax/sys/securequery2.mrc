;Secure Query v2.2
;Team Nexgen 2002 by KnightFal
;team-nexgen.com

alias secure.version { return v2.2a }
on *:load:{ 
  if ($version < 5.91) echo -a  $+ $colour(info2) $+ *** This addon will not work properly with mIRC $version $+ , you need latest mirc in order to use this addon. | beep 
  echo -a  4Team Nexgen's Secure Query $secure.version | echo -a  4Please type: /secure.query in channel to begin dialog.
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
menu nicklist,query {
  Secure Query
  .Configuration:secure.query
  .$iif((!$ulist($address($$1,3),SecureQuery)),Add Access): {
    .auser -a SecureQuery $address($$1,3)
    .msg $1 [Automated Message] I'm now running a Secure Query script, that stops all unauthorized PM's.  You are free to PM me at any time.
    echo -a .12. User Added » (12 $address($1,3) )
    if ($dialog(querycon) != $null) { 
      did -r querycon 45
      s.levels
    }
  }
  .$iif(($ulist($address($$1,3),SecureQuery)),Remove Access): {
    var %address = $address($$1,3)
    .ruser $address($$1,3)
    if ($dialog(querycon) != $null) s.levels
    echo -a .12. User Removed » (12 %address ) 
  } 
  .On $sqo: _vw querycon switch on 
  .Off $sqf: _vw querycon switch off
}
menu channel,status,menubar {
  Secure Query
  .Configuration:secure.query
  .On $sqo: _vw querycon switch on 
  .Off $sqf: _vw querycon switch off
}
alias -l sqo { 
  if ($_vr(querycon,switch) == on) { return [x] }
  else { return  }
}
alias -l sqf { 
  if ($_vr(querycon,switch) == off) { return [x] }
  else { return }
}
alias secure.query {
  if ($version < 5.91) { echo -a 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  if ($dialog(querycon) == $null) { dialog -m querycon querycon } 
}
alias secure.query.nick {
  if ($version < 5.91) { echo -a 4This addon will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  dialog -m $_vr(querycon,query.nick) querycon1
  _vrem querycon lastmsg
}
dialog querycon1 {
  title "Secure Query"
  size -1 -1 160 81
  option dbu
  box "", 33, 7 14 146 42
  button "Accept", 28, 9 62 25 10, disable default ok
  button "Ignore", 26, 36 62 25 10, disable
  button "Decline", 27, 63 62 25 10, disable cancel
  edit "", 1, 32 21 119 10, read autohs
  edit "", 30, 32 31 119 10, read autohs
  edit "", 29, 32 41 119 10, read autohs
  check "Enable Secure Query", 31, 10 6 70 7
  button "Setup", 2, 92 62 21 10
  button "Add Access", 3, 114 62 37 10, disable
  box "", 4, 7 57 146 18
  text "Nick", 5, 9 22 10 8
  text "Address", 6, 9 32 19 8
  text "Message", 7, 9 42 21 8
  text "", 8, 130 5 27 8, right
  text "", 9, 76 5 53 8, right
}
dialog querycon {
  title $+(Secure Query ,$secure.version,$chr(32),- GeSpot Edition)
  size -1 -1 243 149
  option dbu
  button "&OK", 12, 109 135 25 10, default ok
  tab "Config", 2, 4 3 234 127
  check "Enable", 15, 132 70 32 10, tab 2
  button "Select Sound", 16, 166 70 37 10, disable tab 2
  box " Sound on Query Request ", 17, 129 62 80 22, tab 2
  edit "", 208, 22 80 17 9, tab 2
  button "-", 206, 14 82 6 6, tab 2
  text "Seconds", 210, 50 81 21 7, tab 2
  box " Auto-Close Dialog ", 209, 10 62 75 31, tab 2
  button "+", 207, 41 82 6 6, tab 2
  check "Enable Secure Query", 33, 14 26 61 10, tab 2
  check "Notify User Has Access", 49, 14 36 66 10, tab 2
  check "Enable Auto-Close", 50, 14 69 58 10, tab 2
  box " General Options ", 51, 10 20 222 38, tab 2
  check "Log All Query Requests", 43, 14 46 67 10, tab 2
  check "Echo Query Requests to Status Window", 10, 108 26 108 10, tab 2
  check "Echo Message With Query Notification", 18, 108 36 102 10, tab 2
  check "Automatically Un-Ignore on Query Decline", 6, 108 46 119 10, tab 2
  tab "Log", 11
  list 34, 9 22 77 70, tab 11 sort size hsbar
  button "Remove", 35, 9 95 33 8, tab 11
  button "Copy", 39, 199 95 29 8, tab 11
  edit "", 52, 58 116 94 10, tab 11 autohs
  button "Add Access", 53, 154 117 37 8, tab 11
  edit "", 64, 94 22 134 70, tab 11 read multi vsbar
  button "Remove All", 65, 9 105 33 8, tab 11
  tab "Messages", 32
  text "Standby Message", 13, 11 25 44 8, tab 32
  edit "", 3, 11 34 220 10, tab 32 autohs
  text "Decline Message", 14, 11 47 44 8, tab 32
  edit "", 4, 11 56 220 10, tab 32 autohs
  text "Query Timeout Message", 1, 11 69 60 8, tab 32
  edit "", 5, 11 78 220 10, tab 32 autohs
  tab "Protection", 40
  box " Query Flood Ignore Type ", 213, 58 64 132 34, tab 40
  radio "Universal Mask  (*!*@*)", 211, 62 72 69 12, tab 40
  radio "Host Mask Ignore  (*!ident@*domain.com)", 212, 62 84 114 9, tab 40
  edit "", 214, 60 44 10 10, tab 40 limit 2
  box " Query Flood Protection ", 216, 58 24 132 34, tab 40
  edit "", 217, 111 44 15 10, tab 40 limit 2
  text "Seconds", 218, 127 45 22 7, tab 40
  text "Queries Within", 215, 72 46 36 7, tab 40
  check "Enable Flood Protection", 219, 62 32 67 10, tab 40
  tab "Access", 54
  text "Address", 47, 8 22 19 8, tab 54
  edit "", 45, 28 21 139 10, tab 54 autohs
  list 41, 36 44 166 71, tab 54 sort size hsbar
  button "Remove", 42, 36 117 37 8, disable tab 54
  button "&Add Access", 46, 170 22 48 8, disable tab 54
  text "User Access", 44, 37 36 29 8, tab 54
  tab "About", 7
  box "", 55, 45 30 151 80, tab 7
  text "Original Author:", 56, 78 38 40 8, tab 7 right
  text "KnightFal", 60, 125 38 22 8, tab 7
  text "Version:", 58, 97 60 21 8, tab 7 right
  text $secure.version, 61, 125 60 14 8, tab 7
  text "It is important to keep your Team Nexgen addon's updated. You will find them at the Team Nexgen web site.", 63, 62 73 116 20, tab 7
  link "team-nexgen.com", 59, 91 96 59 8, tab 7
  text "Customized by:", 8, 79 49 39 8, tab 7 right
  link "GeSpot", 9, 125 49 19 8, tab 7
}
on *:dialog:*:init:*:{ 
  if ($dialog(querycon) == $dname) {
    if ($_vr(querycon,switch) == on) { did -c querycon 33 } 
    elseif ($_vr(querycon,switch) == $null) { _vw querycon switch on | did -c querycon 33 }
    if ($_vr(querycon,ignore.host) == $null) { _vw querycon ignore.host on | _vw querycon ignore.uni off }
    if ($_vr(querycon,standby) == $null) { _vw querycon standby I am using a secure query event. Please standby for acknowledgement. You will be notified if accepted. Until then, your msgs will be ignored. }
    if ($_vr(querycon,decline) == $null) { _vw querycon decline Sorry, I have declined your query, please try a more convient time. }
    if ($_vr(querycon,timeout) == $null) { _vw querycon timeout Sorry, I do not appear to be available to respond to your query.  Please try another time. }
    if ($_vr(querycon,ignore.uni) == on) && ($_vr(querycon,ignore.host) == off) { did -c querycon 211 1 }
    else  did -c querycon 212 1
    did -o querycon 3 1 $_vr(querycon,standby)
    did -o querycon 4 1 $_vr(querycon,decline)
    did -o querycon 5 1 $_vr(querycon,timeout)
    if ($_vr(querycon,soundswitch) == on) { did -c querycon 15 | did -e querycon 16 }
    if ($_vr(querycon,timer) == $null) { _vw querycon timer 240 }
    did -o querycon 208 1 $_vr(querycon,timer) 
    if ($_vr(querycon,max.query) == $null) { _vw querycon max.query 5 | did -o querycon 214 1 $_vr(querycon,max.query) }
    else  did -o querycon 214 1 $_vr(querycon,max.query) 
    if ($_vr(querycon,max.query.sec) == $null) {  _vw querycon max.query.sec 20 | did -o querycon 217 1 $_vr(querycon,max.query.sec) }
    else did -o querycon 217 1 $_vr(querycon,max.query.sec) 
    if ($_vr(querycon,netflood) == on) did -c querycon 219
    else did -b querycon 211,217,212,214
    if ($_vr(querycon,log) == on) { did -c querycon 43 }
    elseif ($_vr(querycon,log) == $null) { _vw querycon log on | did -c querycon 43 }
    if ($_vr(querycon,autounignore) == on) { did -c querycon 6 }
    elseif ($_vr(querycon,autounignore) == $null) { _vw querycon autounignore on | did -c querycon 6 }
    if ($_vr(querycon,echostatus) == on) { did -c querycon 10 }
    elseif ($_vr(querycon,echostatus) == $null) { _vw querycon echostatus on | did -c querycon 10 }
    if ($_vr(querycon,echomessage) == on) { did -c querycon 18 }
    elseif ($_vr(querycon,echomessage) == $null) { _vw querycon echomessage on | did -c querycon 18 }
    if ($_vr(querycon,notifyaccess) == on) { did -c querycon 49 }
    elseif ($_vr(querycon,notifyaccess) == $null) { _vw querycon notifyaccess on | did -c querycon 49 }
    if ($_vr(querycon,auto-close) == on) { did -c querycon 50 }
    did -b querycon 46,42 
    nick.list 
    s.levels
    did -z querycon 34
  }
  if ($dialog($dname) == $_vr(querycon,query.nick)) { 
    if ($_vr(querycon,auto-close) == on) { %qs.nick = $_vr(querycon,query.nick) | .timer 1 $sq_t close.qw }
  }
}
on *:dialog:querycon:edit:*:{ 
  if ($did == 3) { 
    if ($did(querycon,3).text != $null) {    
      _vw querycon standby $did(querycon,3).text 
    }
  }
  if ($did == 4) { 
    if ($did(querycon,4).text != $null) {    
      _vw querycon decline $did(querycon,4).text 
    }
  }
  if ($did == 5) { 
    if ($did(querycon,5).text != $null) {    
      _vw querycon timeout $did(querycon,5).text 
    }
  }
  if ($did == 45) { 
    if ($did(querycon,45).text != $null) { did -e querycon 46 }
    elseif ($did(querycon,45).text == $null) { did -b querycon 46 }
  }
  if ($did == 208) { 
    if ($did(querycon,208).text != $null) {    
      _vw querycon timer $did(querycon,208).text 
    }
  }
  if ($did == 214) { 
    if ($did(querycon,214).text != $null) {  
      _vw querycon max.query $did(querycon,214).text 
    }  
  }
  if ($did == 217) { 
    if ($did(querycon,217).text != $null) {  
      _vw querycon max.query.sec $did(querycon,217).text 
    }
  }
}

on *:dialog:*:sclick:*:{ 
  if (Query request $dname == $dialog($dname).title) { 
    if ($did == 2) { secure.query }   
    if ($did == 3) {
      .ignore -r $address($did($dname,1),2) | query $did($dname,1) | .timer -m 1 1 echo -t $did($dname,1) < $+ $did($dname,1) $+ > $did(29,$did(29)) |  _vrem querycon lastmsg 
      auser -a SecureQuery $address($did($dname,1),3) $did($dname,1) | did -b $did($dname,1) 3 
      if ($_vr(querycon,notifyaccess) == on) { if ($server != $null) { .msg $did($dname,1) [Automated Message] Query request accepted.  You now have free access to message me. } }
      dialog -x $did($dname,1)
    }
    if ($did == 27) {
      if ($_vr(querycon,autounignore) != on) { .ignore -pu180 $did($dname,30) }
      else { .ignore -r $address($did($dname,1),2) }
      .msg $did($dname,1) [Automated Message] $_vr(querycon,decline)
      dialog -x $did($dname,1)
    }
    if ($did == 28) {  
      .ignore -r $address($did($dname,1),2) | query $did($dname,1) | .timer -m 1 1 echo -t $did($dname,1) < $+ $did($dname,1) $+ > $did(29,$did(29)) |  _vrem querycon lastmsg 
      if ($server != $null) { .msg $did($dname,1) [Automated Message] Query request accepted. }
      dialog -x $did($dname,1)
    }
    if ($did == 26) { .ignore -p $did($dname,1).text | dialog -x $did($dname,1) }
    if ($did == 31) {
      if ($_vr(querycon,switch) != on) { _vw querycon switch on }
      else { _vw querycon switch off  }
    }
  }
  if ($dialog(querycon) ==  $dname) { 
    if ($did == 15) { 
      if ($_vr(querycon,soundswitch) != on) {  _vw querycon soundswitch on | did -c querycon 15 | did -e querycon 16 }
      else { _vw querycon soundswitch off | did -u querycon 15 | did -b querycon 16 }
    }
    if ($did == 16) { setquerysound }
    if ($did == 206) { if (%timer > 0) { dec %timer 1 | did -o querycon 208 1 %timer | _vw querycon timer %timer } }
    if ($did == 207) { inc %timer 1 | did -o querycon 208 1 %timer | _vw querycon timer %timer }

    if ($did == 39) { clipboard < $+ $did(34,$did(34).sel) $+ > $sr($did(34,$did(34).sel),msg) }
    if ($did == 34) { did -r querycon 64 | did -a querycon 64 $chr(91) $+ $sr($did(34,$did(34).sel),date) $+ $chr(93) | did -a querycon 64 $crlf $sr($did(34,$did(34).sel),msg) | did -o querycon 52 1 $_vr(securequery,$did(34,$did(34).sel)) }
    if ($did == 33) {
      if ($_vr(querycon,switch) != on) { _vw querycon switch on }
      else { _vw querycon switch off }
    }
    if ($did == 35) { write -ds $+ $did(34,$did(34).sel) securequery\names.txt | _vrem securequery $did(34,$did(34).sel) | .timer -m 1 1 nick.list }
    if ($did == 41) { did -e querycon 42,46 | did -o querycon 45 1 $did(41,$did(41).sel) }
    if ($did == 42) { var %address = $did(41,$did(41).sel) | .ruser $did(41,$did(41).sel) | s.levels | echo -a .12. User Removed » (12 %address ) }
    if ($did == 43) { 
      if ($_vr(querycon,log) != on) { _vw querycon log on | did -c querycon 43 }
      else { _vw querycon log off }
    }  
    if ($did == 50) { 
      if ($_vr(querycon,auto-close) != on) { _vw querycon auto-close on | did -c querycon 50 }
      else { _vw querycon auto-close off }
    }
    if ($did == 53) { 
      if ($did(querycon,52).text != $null) {    
        .auser -a  SecureQuery $did(querycon,52).text | did -r querycon 52 
      }
    }
    if ($did == 6) {
      if ($_vr(querycon,autounignore) != on) { _vw querycon autounignore on | did -c querycon 6 }
      else { _vw querycon autounignore off }
    }
    if ($did == 10) {
      if ($_vr(querycon,echostatus) != on) { _vw querycon echostatus on | did -c querycon 10 }
      else { _vw querycon echostatus off }
    }
    if ($did == 18) {
      if ($_vr(querycon,echomessage) != on) { _vw querycon echomessage on | did -c querycon 18 }
      else { _vw querycon echomessage off }
    }
    if ($did == 49) {
      if ($_vr(querycon,notifyaccess) != on) { _vw querycon notifyaccess on | did -c querycon 49 }
      else { _vw querycon notifyaccess off }
    }
    if ($did == 46) {
      if ($did(querycon,45).text != $null) {    
        .auser -a  SecureQuery $did(querycon,45).text | did -r querycon 45 | s.levels
      }
    }
    if ($did == 65) { .remove securequery\names.txt | .remove securequery\logs.ini | did -r querycon 64,34,52 }    
    if ($did == 211) {
      if ($_vr(querycon,ignore.uni) == off) { _vw querycon ignore.uni on | _vw querycon ignore.host off | did -c querycon 211 | did -u querycon 212 }
      else { _vw querycon ignore.uni off | _vw querycon ignore.host on | did -u querycon 211 | did -c querycon 212 }
    }
    if ($did == 212) {
      if ($_vr(querycon,ignore.host) == off) { _vw querycon ignore.host on | _vw querycon ignore.uni off | did -c querycon 212 | did -u querycon 211 }
      else { _vw querycon ignore.host off | _vw querycon ignore.uni on | did -u querycon 212 | did -c querycon 211 }
    }
    if ($did == 219) {
      if ($_vr(querycon,netflood) == off) { _vw querycon netflood on | did -c querycon 219 | did -e querycon 211,217,212,214 }
      else { _vw querycon netflood off | did -u querycon 219 | did -b querycon 211,217,212,214 }
    }
    if ($did == 9) { run mailto:gespot@laggyservers.com?Subject=Secure Query $secure.version - GeSpot Edition }
    if ($did == 59) { run http://team-nexgen.com }
  }
}
alias -l sr {
  if ($exists(securequery\logs.ini) == $false) { mkdir securequery | write -c securequery\logs.ini }
  return $readini securequery\logs.ini $$1 $$2 
}
alias -l sw {
  if ($exists(securequery\logs.ini) == $false) { mkdir securequery | write -c securequery\logs.ini }
  writeini securequery\logs.ini $$1 $$2 $$3-
}
alias -l srem {
  if ($exists(securequery\logs.ini) == $false) { mkdir securequery | write -c  securequery\logs.ini }
  remini securequery\logs.ini $$1 $$2 
}
on ^*:open:?: {
  if ($_vr(querycon,switch) == $null) { _vw querycon switch on }
  if ($finddir($mircdir\,securequery*,1) == $null) { mkdir securequery }
  if ($_vr(general,querypop) == on) {  
    if ($appstate == minimized) { msgpop | drawrect -r @msgpop $rgb(222,198,164) 0 14 41 127 18 | drawtext -ro @msgpop $rgb(78,113,160) Tahoma 11 16 43 $nick }
    if ($appactive == $false) { msgpop | drawrect -r @msgpop $rgb(222,198,164) 0 14 41 127 18 | drawtext -ro @msgpop $rgb(78,113,160) Tahoma 11 16 43 $nick }
  } 
  if ($_vr(querycon,netflood) != on) {
    inc %upflood15 1  
    if (%upflood15 > $_vr(querycon,max.query)) { 
      if ($_vr(querycon,ignore.uni) == on) { .ignore -pu $+ $_vr(querycon,max.query.sec) *!*@* }
      else { .ignore -pu $+ $_vr(querycon,max.query.sec) $wildsite }
      echo -a 4[ ALERT ] $nick is Query Flooding. User ( $+ $wildsite $+ ) now ignored for $_vr(querycon,max.query.sec) secs.
    } 
    .timer 1 60 unset %upflood15     
  }
  if ($_vr(querycon,standby) == $null) { _vw querycon standby I am using a secure query event. Please standby for acknowledgement. You will be notified if accepted. Until then, your msgs will be ignored. }
  if ($level($address($nick,3)) == securequery) { goto end }
  if ($network == WonderNet) && ($nick == Global) { goto end } 
  if ($network == WonderNet) && ($nick == Nickserv) { goto end } 
  if ($network == WonderNet) && ($nick == Chanserv) { goto end } 
  if ($network == WonderNet) && ($nick == Memoserv) { goto end } 
  if (($nick == ChanServ) || ($nick == AuthServ) || ($nick == HelpServ)) goto end
  if ($_vr(querycon,switch) == on) {
    if ($_vr(querycon,soundswitch) == on) { if ($_vr(querycon,sound) != $null) { splay $_vr(querycon,sound) } }
    echo $colour(notice) -at Query with $nick on $network
    echo $colour(notice) -at Waiting for acknowledgement...
    if ($_vr(querycon,echomessage) == on) echo $colour(notice) -at Message: $1-
    if ($_vr(querycon,echostatus) == on) {
      echo $colour(notice) -st Query with $nick on $network
      echo $colour(notice) -st Waiting for acknowledgement...
      if ($_vr(querycon,echomessage) == on) echo $colour(notice) -st Message: $1-
    }
    if ($_vr(querycon,log) == on) { 
      if ($read(securequery\names.txt, w, $nick) == $nick) { write -ds $+ $nick securequery\names.txt }
      ;      sw $nick date $asctime(mm-dd-yyyy h:nn:sstt) | sw $nick msg $strip($1-,burc) | write securequery/names.txt $nick | nick.list
      sw $nick date $asctime(mmmm ddoo $+ $chr(44) yyyy h:nn:sstt) | sw $nick msg $strip($1-,burc) | write securequery/names.txt $nick | nick.list
    }
    .msg $nick [Automated Message] $_vr(querycon,standby)
    _vw  querycon query.nick $nick
    if ($dialog($nick) == $null) { secure.query.nick }
    dialog -t $_vr(querycon,query.nick) Query request $nick
    did -o $nick 1 1 $_vr(querycon,query.nick)
    .ignore -pu120 $wildsite    
    whosqial $nick  
    did -o $nick 9 1 ( $+ $network $+ )  
    did -o $nick 30 1 updating... 
    did -o $nick 29 1 $strip($1-,burc)
    did -o $nick 8 1 $asctime(hh:nntt)

    if ($_vr(querycon,switch) == on) { did -c $nick 31 }
    haltdef
    :end 
  }  
}
#sqialud off
raw 352:*: {
  if ($dialog($6) != $null) { did -o $6 30 1 *!* $+ $3 $+ @ $+ $4  | did -e $6 26,28,3,27 | .timer 1 5 .disable #sqialud | haltdef }
  else { if ($dialog($6) != $null) { did -e $6 26,28,3,27 | .timer 1 5 .disable #sqialud | halt } }
  halt
}
raw 315:*: {
  halt
} 
#sqialud end
alias -l whosqial { .enable #sqialud | raw -q who $$1 } 
alias -l secure.dir {
  mkdir  " $+ $mircdirsecurequery $+ \ $+ " 
  return securequery $+ \ 
}
alias -l sq_t { 
  return $_vr(querycon,timer) 
}

alias -l nick.list {
  if ($dialog(querycon) != $null) { 
    did -r querycon 64,34,52 
    var %fst = $lines(securequery\names.txt)   
    var %f = 1
    while (%f <= %fst) { did -a querycon 34 $read(securequery\names.txt,%f) | inc %f 1 }
  }
}
alias -l s.levels {
  did -r querycon 41
  var %s.l = $ulist(*,securequery,0)
  if (%s.l == 0) { did -b querycon 42 | return }
  else  did -e querycon 42
  var %s.w = 0
  :loop
  inc %s.w
  if (%s.w <= %s.l) { did -a querycon 41  $ulist(*,SecureQuery,%s.w) | goto loop }
  else return
}
alias -l close.qw {
  if ($dialog(%qs.nick)) {
    .msg %qs.nick [Automated Message] $_vr(querycon,timeout)
    .ignore -r $address(%qs.nick,2)
    dialog -x %qs.nick
  }
}
alias -l setquerysound {
  _vw querycon sound $$dir="Choose a wav:" $mircdir*.wav;*mp3;*.mid 
}
