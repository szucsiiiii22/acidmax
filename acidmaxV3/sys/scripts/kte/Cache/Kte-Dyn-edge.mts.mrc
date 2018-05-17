; Kte dynamic script file
; Do not edit or unload this file while using Kte!
; Kte-Dyn 1.5 FF4BFBB0 D863F290
alias theme.text {
  if (!$var(%:echo)) { return $false }
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
  if ($isalias(kte:: $+ $1)) { kte:: $+ $1 | return $true }
  elseif (* iswm $hget(Kte_Theme, $1)) {
    var %ln
    set -n %ln $hget(Kte_Theme, $1)
    if ($gettok(%ln, 1, 32) == !Script) { set -n %ln $deltok(%ln, 1, 32) }
    else { set -n %ln % $+ :echo $dll($scriptdir $+ kte.dll, MTSPrecompile, %ln) $!+  % $+ :comments }
    .timerkte_theme 1 0 %ln | .timerkte_theme -e | return $true
  }
  return $false
}
alias kte_void
 
alias -l _entered {
  var %def = $readini($mircini, events, default), %set
  if (!%def) { %def = 0,0,0,0,0,0,0,0 }
  %set = $readini($mircini, events, $1)
  if (!%set) { %set = 0,0,0,0,0,0,0,0 }
  while ($findtok(%set, 0, 1, 44)) { %set = $puttok(%set, $calc($gettok(%def, $ifmatch, 44) + 1), $ifmatch, 44) }
  hadd Kte_Events $1 %set
}
alias -l _left {
  set -u0 %kte_chan $1
  var %i = $scon(0)
  while (%i) { if ($scon(%i) != $cid) && ($scon(%i).kte_haschan) { return } | dec %i }
  hdel Kte_Events $1
}
alias -l kte_haschan return $chan(%kte_chan)
 
alias -l _isactive if ($cid == $activecid) { return 1 } | return 0
alias -l _active if ($cid == $activecid) { return a } | return s
alias -l _ischat {
  var %n = $mid($1, 2)
  if (=* !iswm $1) { return 1 }
  if (=* iswm $1) && (($chat(%n)) || ($fserv(%n))) { return 1 }
  return 0
}
 
; events
on ^&*:JOIN:#:{
  if ($chan !ischan) { return }
  if ($nick == $me) { _entered $chan }
  var %tgt = $gettok($hget(Kte_Events, $chan), 1, 44)
  if (%tgt = 3) && ($nick != $me) { haltdef | return }
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
  if (%tgt = 2) { set -u1 %:echo echo $color(join) -sti2 }
  else { set -u1 %:echo echo $color(join) -ti2 $chan }
if ($nick == $me) { e.join | haltdef }
else { %:echo 02:02 %::nick 02(11 $+ $replace(%::address,@, $+ 02@ $+ %::c2) $+ 02) $+ 11 has joined02 %::chan | haltdef }
unset %:echo %::nick %::address %::target %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick
}
on ^&*:PART:#:{
  if ($chan !ischan) { return }
  var %tgt = $gettok($hget(Kte_Events, $chan), 2, 44)
  if ($nick != $me) || (%tgt = 2) {
    if (%tgt = 3) { goto skip }
    if (%tgt = 2) { set -u1 %:echo echo $color(part) -sti2 }
    else { set -u1 %:echo echo $color(part) -ti2 $chan }
    set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02:02 %::nick 02(11 $+ $replace(%::address,@, $+ 02@ $+ %::c2) $+ 02) $+ 11 has left02 %::chan %::parentext | haltdef
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
  }
  :skip
  if ($nick == $me) { _left $chan }
}
 
on ^&*:QUIT:{
  var %i = $comchan($nick, 0), %tgt, %st = 0
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  while (%i) {
    %::chan = $comchan($nick, %i)
    %tgt = $gettok($hget(Kte_Events, %::chan), 3, 44)
    if (%tgt = 4) { dec %i | continue }
    if (%tgt = 3) || (%tgt = 2) { %st = 1 }
if (!%tgt) || (%tgt = 3) || (%tgt = 1) { %:echo = echo $color(quit) -ti2 %::chan | %:echo 02:02 %::nick 02(11 $+ $replace(%::address,@, $+ 02@ $+ %::c2) $+ 02) $+ 11 has quit IRC %::parentext }
    dec %i
  }
  unset %::chan
if ($query($nick)) { %:echo = echo $color(quit) -ti2 $nick | %:echo 02:02 %::nick 02(11 $+ $replace(%::address,@, $+ 02@ $+ %::c2) $+ 02) $+ 11 has quit IRC %::parentext }
if (%st) { %:echo = echo $color(quit) -sti2 | %:echo 02:02 %::nick 02(11 $+ $replace(%::address,@, $+ 02@ $+ %::c2) $+ 02) $+ 11 has quit IRC %::parentext }
  haltdef
unset %:echo %::nick %::address %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
on ^&*:NICK:{
  var %i = $comchan($newnick, 0), %tgt
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
  set -u1 %::newnick $newnick
if ($nick == $me) { %:echo = echo $color(nick) -sti2 | %:echo 02:02 You11 are now known as 02 $+ %::newnick $+  %:comments }
  while (%i) {
    set -u1 %::chan $comchan($newnick, %i)
    %tgt = $gettok($hget(Kte_Events, %::chan), 7, 44)
if (%tgt != 2) || ($nick == $me) { %:echo = echo $color(nick) -ti2 %::chan | %:echo 02: 02 $+ %::nick $+ 11 is now known as 02 $+ %::newnick $+  %:comments }
    dec %i
  }
if ($query($newnick)) { unset %::chan | %:echo = echo $color(nick) -ti2 $newnick | %:echo 02: 02 $+ %::nick $+ 11 is now known as 02 $+ %::newnick $+  %:comments }
  haltdef
unset %:echo %::nick %::address %::chan %::newnick %::me %::server %::port %::pre %::c?
}
 
on ^&*:USERMODE:{
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
  set -nu1 %::modes $1-
  set -u1 %:echo echo $color(mode) -sti2
%:echo 02: 11Usermode changed to02: %::modes $+  %:comments | haltdef
  unset %::modes
unset %:echo %::nick %::address %::me %::server %::port %::pre %::c?
}
on ^&*:RAWMODE:#:{
  if ($chan !ischan) { return }
  var %tgt = $gettok($hget(Kte_Events, $chan), 4, 44)
  if (%tgt = 3) { haltdef | return }
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
  if (%tgt = 2) { set -u1 %:echo echo $color(mode) -sti2 }
  else { set -u1 %:echo echo $color(mode) -ti2 $chan }
  set -nu1 %::modes $1-
%:echo 02: 02 $+ %::nick $+ 11 sets mode02: %::modes $+  %:comments | haltdef
  unset %::modes
unset %:echo %::nick %::address %::target %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick
}
 
on ^&*:TOPIC:#:{
  if ($chan !ischan) { return }
  var %tgt = $gettok($hget(Kte_Events, $chan), 5, 44)
  if (%tgt = 3) { haltdef | return }
  if (%tgt = 2) { set -u1 %:echo echo $color(topic) -sti2 }
  else { set -u1 %:echo echo $color(topic) -ti2 $chan }
  set -nu1 %::text $1-
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02:02 %::nick $+ 11 changes topic to02: 11'02 $+ %::text $+ 11' %:comments | haltdef
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
}
on ^&*:KICK:#:{
  if ($chan !ischan) { return }
  var %tgt = $gettok($hget(Kte_Events, $chan), 8, 44)
  if (%tgt = 3) && ($knick != $me) { haltdef | return }
  if (%tgt = 2) { set -u1 %:echo echo $color(kick) -sti2 }
  else { set -u1 %:echo echo $color(kick) -ti2 $chan }
  set -u1 %::knick $knick
  set -u1 %::kaddress $gettok($address($knick, 5), 2, 33)
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  if ($knick == $me) {
%:echo 02:02 You11 were kicked by 02 $+ %::nick $+ ,11 from 02 $+ %::chan %::parentext $+  %:comments
    if (%tgt == 2) { set -u1 %:echo echo $color(kick) -ti2 $chan }
    else { set -u1 %:echo echo $color(kick) -seti2 }
%:echo 02:02 You11 were kicked by 02 $+ %::nick $+ ,11 from 02 $+ %::chan %::parentext $+  %:comments
    _left $chan
  }
else { %:echo 02:02 %::knick $+ 11's ass was kicked by 02 $+ %::nick %::parentext $+  %:comments }
  haltdef
unset %:echo %::nick %::address %::target %::parentext %::knick %::kaddress %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
}
 
on ^&*:INVITE:#:{
  var %e = echo $color(invite) -ti2
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::chan $chan
set -nu1 %::target $target
  if ($_isactive) && (@* !iswm $active) && ($hget(Kte_Events, Active.Invites)) { set -u1 %:echo %e $+ a }
  else { set -u1 %:echo %e $+ s }
%:echo 02:02 %::nick $+ 11 has invited you to join 02 $+ %::chan $+  %:comments | haltdef
unset %:echo %::nick %::address %::chan %::target %::me %::server %::port %::pre %::c?
}
 
on ^&*:ERROR:*:{
  set -u1 %:echo echo $color(other) -sti2 | set -nu1 %::text $2-
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02:11 %::text $+  %:comments | haltdef
unset %:echo %::nick %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
on ^&*:NOTIFY:{
  set -u1 %:echo echo $color(notify) -ti2 $+ $iif(($_isactive) && (@* !iswm $active), a, s)
  set -nu1 %::text $notify($nick).note
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02: %::nick is on IRC %::parentext $+  %:comments | haltdef
unset %:echo %::nick %::address %::parentext %::me %::server %::port %::pre %::c? %::text
}
on ^&*:UNOTIFY:{
  set -u1 %:echo echo $color(notify) -ti2 $+ $iif(($_isactive) && (@* !iswm $active), a, s)
  set -nu1 %::text $notify($nick).note
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02: %::nick is offline %:comments | haltdef
unset %:echo %::nick %::address %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
on ^&*:WALLOPS:*:{
  set -u1 %:echo echo $color(wallops) -ti2 $+ $iif(($_isactive) && (@* !iswm $active), a, s)
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
on &*:DNS:{
  set -u1 %:echo echo $color(info) -ti2 $+ $iif(($_isactive) && (@* !iswm $active), a, s)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
  if ($dns(0)) {
    var %i = 1, %t = $dns(0)
    while (%i <= %t) {
      set -nu1 %::nick $dns(%i).nick
      set -nu1 %::address $dns(%i)
      set -nu1 %::iaddress $dns(%i).ip
      set -nu1 %::naddress $dns(%i).addr
      set -nu1 %::raddress $remtok($dns(%i).ip $dns(%i).addr, $dns(%i), 1, 32)
%:echo 02: 11Resolved 02 $+ %::address $+ 11 to 02 $+ %::raddress $+  %:comments | haltdef
      inc %i
    }
  }
  else {
    set -nu1 %::nick $nick
    set -nu1 %::address $address
%:echo 02: 11Unable to resolve 02 $+ %::address $+  %:comments | haltdef
  }
unset %:echo %::nick %::address %::iaddress %::raddress %::naddress %::me %::server %::port %::pre %::c?
}
 
on ^&*:SNOTICE:*:{
  set -u1 %:echo echo $color(notice) -sti2
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo -> - $+ %::nick $+ - %::text $+  %:comments | haltdef
unset %:echo %::nick %::target %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
on &*:INPUT:*:{
  if ($0) && ((/* !iswm $1) || ($ctrlenter)) && (($active ischan) || ($query($active)) || (=* iswm $active)) && ($window($active, 0) = 1) {
    say $1- | halt
  }
}
 
alias say {
  if ($isid) { return }
  if ($status == disconnected) || (!$0) || (($active !ischan) && (!$query($active))) && (=* !iswm $active) {
    .timer.kte 1 0 !say $1- | .timer.kte -e | halt
  }
  .!msg $active $1-
  set -u1 %:echo echo $color(own) -ati2
  set -nu1 %::text $1- | set -u1 %::target $active | set -u1 %::nick $me
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  if ($active ischan) {
    set -u1 %::chan $active
    if ($nick($active, $me).pnick != $me) { set -u1 %::cmode $left($ifmatch, 1) }
    set -u1 %::cnick $nick($active, $me).color
%:echo 02(02 $+ %::cmode $+ 11 $+ %::me $+ 02)11 %::text $+  %:comments
  }
  else {
    set -u1 %::cnick $cnick($me).color
%:echo 02(11 $+ %::me $+ 02)11 %::text $+  %:comments
  }
unset %:echo %::parentext %::target %::nick %::address %::chan %::cnick %::cmode %::me %::server %::port %::pre %::c? %::text
}
alias query {
  if ($isid) { return }
  if (!$0) { .timer.kte 1 0 !query | .timer.kte -e | halt }
  !query $1
  if ($0 > 1) {
    if (!$server) { .timer.kte 1 0 !query $1- | .timer.kte -e | halt }
    msg $1-
  }
}
alias msg {
  if ($isid) { return }
  if ($0 < 2) || ((=* !iswm $1) && ($status == disconnected)) || (!$_ischat($1)) {
    .timer.kte 1 0 !msg $1- | .timer.kte -e | halt
  }
  .!msg $1-
  if (!$show) { return }
  set -nu1 %::text $2- | set -u1 %::target $1 | set -u1 %::nick $me
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  ; %::nick = $me. This is a matter of logic.
  ; Use <target> in your script, not <nick>, to refer to the recipient of the message.
  if ($1 ischan) || ($query($1)) || (=* iswm $1) {
    set -u1 %:echo echo $color(own) -ti2 $1
    if ($1 ischan) {
      if ($nick($1, $me).pnick != $me) { set -u1 %::cmode $left($ifmatch, 1) }
      set -u1 %::cnick $nick($1, $me).color
%:echo 02(02 $+ %::cmode $+ 11 $+ %::me $+ 02)11 %::text $+  %:comments
    }
else { %:echo 02(11 $+ %::me $+ 02)11 %::text $+  %:comments }
  }
  else {
    set -u1 %:echo echo $color(own) -ti2 $+ $_active
%:echo 02: 02Msg (11 $+ %::target $+ 02)11 - %::text $+  %:comments | haltdef
  }
unset %:echo %::parentext %::target %::nick %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
}
alias amsg {
  if ($isid) { return }
  if ($status == disconnected) || (!$0) || (!$chan(0)) { .timer.kte 1 0 !amsg $1- | .timer.kte -e | halt }
  !.amsg $1-
  if (!$show) { return }
  set -nu1 %::text $1- | set -u1 %::nick $me
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  var %i = $chan(0)
  while (%i) {
    set -u1 %::chan $chan(%i)
    set -u1 %::target %::chan
    set -u1 %:echo echo $color(own) -ti2 %::chan
    if ($nick($chan(%i), $me).pnick != $me) { set -u1 %::cmode $left($ifmatch, 1) }
    set -u1 %::cnick $nick(%::chan, $me).color
%:echo 02(02 $+ %::cmode $+ 11 $+ %::me $+ 02)11 %::text $+  %:comments
    dec %i
  }
unset %:echo %::parentext %::nick %::cnick %::cmode %::chan %::target %::me %::server %::port %::pre %::c? %::text
}
 
 
alias me {
  if ($isid) { return }
  if (!$server) || (!$0) || (($active !ischan) && (!$query($active))) && (=* !iswm $active) {
    .timer.kte 1 0 !me $1- | .timer.kte -e | halt
  }
  .!describe $active $1-
  if (!$show) { return }
  set -u1 %:echo echo $color(action) -ati2
  set -nu1 %::text $1- | set -u1 %::target $active | set -u1 %::nick $me
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  if ($active ischan) {
    set -u1 %::chan $active
    if ($nick($active, $me).pnick != $me) { set -u1 %::cmode $left($ifmatch, 1) }
    set -u1 %::cnick $nick($active, $me).color
  }
%:echo 02! 02 $+ %::cmode $+ 11 $+ %::me %::text $+  %:comments
unset %:echo %::parentext %::target %::nick %::chan %::cnick %::cmode %::me %::server %::port %::pre %::c? %::text
}
alias action {
  if ($isid) { return }
  if (!$server) || (!$0) || (($active !ischan) && (!$query($active))) && (=* !iswm $active) {
    .timer.kte 1 0 !action $1- | .timer.kte -e | halt
  }
  me $1-
}
alias describe {
  if ($isid) { return }
  if (!$server) || ($0 < 2) || (!$_ischat($1)) {
    .timer.kte 1 0 !describe $1- | .timer.kte -e | halt
  }
  .!describe $1-
  if (!$show) { return }
  set -nu1 %::text $2- | set -u1 %::target $1 | set -u1 %::nick $1
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  if ($1 ischan) || ($query($1)) || (=* iswm $1) {
    set -u1 %:echo echo $color(action) -ti2 $1
    if ($1 ischan) {
      set -u1 %::chan $1
      if ($nick($1, $me).pnick != $me) { set -u1 %::cmode $left($ifmatch, 1) }
      set -u1 %::cnick $nick($1, $me).color
%:echo 02! 02 $+ %::cmode $+ 11 $+ %::me %::text $+  %:comments
    }
else { %:echo 02! 11 $+ %::me %::text $+  %:comments }
  }
else { set -u1 %:echo echo $color(action) -ti2 $+ $_active | %:echo -> * $+ %::target $+ * %::text $+  %:comments }
unset %:echo %::parentext %::target %::chan %::cmode %::cnick %::nick %::me %::server %::port %::pre %::c? %::text
}
alias ame {
  if ($isid) { return }
  if (!$server) || (!$0) || (!$chan(0)) { .timer.kte 1 0 !ame $1- | .timer.kte -e | halt }
  !.ame $1-
  if (!$show) { return }
  set -nu1 %::text $1- | set -u1 %::nick $me
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  var %i = $chan(0)
  while (%i) {
    set -u1 %::chan $chan(%i)
    set -u1 %::target %::chan
    set -u1 %:echo echo $color(action) -ti2 %::chan
    if ($nick(%::chan, $me).pnick != $me) { set -u1 %::cmode $left($ifmatch, 1) }
    set -u1 %::cnick $nick(%::chan, $me).color
%:echo 02! 02 $+ %::cmode $+ 11 $+ %::me %::text $+  %:comments
    dec %i
  }
unset %:echo %::parentext %::target %::chan %::cnick %::cmode %::nick %::me %::server %::port %::pre %::c? %::text
}
 
alias notice {
  if ($isid) { return }
  if (!$server) || ($0 < 2) { .timer.kte 1 0 !notice $1- | .timer.kte -e | halt }
  .!notice $1-
  if (!$show) { return }
  set -nu1 %::text $2- | set -u1 %::target $1 | set -u1 %::nick $1
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  set -u1 %:echo echo $color(notice) -ti2 $+ $_active
if ($1 ischan) { set -u1 %::chan $1 }
else { %:echo 02:02 Notice 11(02 $+ %::nick $+ 11) - %::text $+  %:comments }
unset %:echo %::parentext %::target %::nick %::chan %::me %::server %::port %::pre %::c? %::text
}
 
on &^*:TEXT:*:#:{
  if ($chan !ischan) { return }
  set -u1 %:echo echo $color(normal) -mlbfti2 $chan
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02(02 $+ %::cmode $+ 12 $+ %::nick $+ 02)12 %::text $+  %:comments | haltdef
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
}
on &^*:ACTION:*:#:{
  if ($chan !ischan) { return }
  set -u1 %:echo echo $color(action) -mlbfti2 $chan
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02! 02 $+ %::cmode $+ 12 $+ %::nick %::text $+  %:comments | haltdef
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
}
on &^*:NOTICE:*:#:{
  if ($chan !ischan) { return }
  set -u1 %:echo echo $color(notice) -mti2 $chan
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo - $+ %::nick $+ : $+ %::target $+ - %::text $+  %:comments | haltdef
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
}
 
on &^*:CHAT:*:{
  if ($window(=$nick, 0) > 1) { return }
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
  if (ACTION * iswm $1-) {
    set -u1 %:echo echo $color(action) -mti2lbf =$nick
    set -nu1 %::text $strip($mid($1-, 8, -1), o)
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02! 12 $+ %::nick %::text $+  %:comments | haltdef
  }
  else {
    set -u1 %:echo echo $color(normal) -mti2lbf =$nick
    set -nu1 %::text $strip($1-, o)
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02(12 $+ %::nick $+ 02)12 %::text $+  %:comments | haltdef
  }
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
on &^*:TEXT:*:?:{
  var %e = echo $color(normal) -mti2
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  if ($query($nick)) {
    set -u1 %:echo %e $nick
%:echo 02(12 $+ %::nick $+ 02)12 %::text $+  %:comments | haltdef
  }
  else {
    if ($window(Message Window)) { set -u1 %:echo %e $+ d }
    elseif ($_isactive) && (@* !iswm $active) && ($hget(Kte_Events, Active.Queries)) { set -u1 %:echo %e $+ a }
    else { set -u1 %:echo %e $+ s }
%:echo 02[11 $+ %::nick $+ 02]11 - %::text $+  %:comments | haltdef
  }
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::text
}
on &^*:ACTION:*:?:{
  var %e = echo $color(action) -mti2
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
if ($query($nick)) { set -u1 %:echo %e $nick | %:echo 02! 12 $+ %::nick %::text $+  %:comments | haltdef }
  else {
    if ($window(Message Window)) { set -u1 %:echo %e $+ d }
    elseif ($_isactive) && (@* !iswm $active) && ($hget(Kte_Events, Active.Queries)) { set -u1 %:echo %e $+ a }
    else { set -u1 %:echo %e $+ s }
%:echo * %::nick %::text $+  %:comments | haltdef
  }
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::text
}
on &^*:NOTICE:*:?:{
  var %e = echo $color(notice) -mti2
  if ($_isactive) && (@* !iswm $active) && ($hget(Kte_Events, Active.Notices)) { set -u1 %:echo %e $+ a }
  else { set -u1 %:echo %e $+ s }
  set -nu1 %::text $strip($1-, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02 $+ %::nick $+ 11 - %::text $+  %:comments | haltdef
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::text
}
 
ctcp ^&*:*:?:kte_onctcp $1-
ctcp ^&*:*:#:kte_onctcp $1-
alias -l kte_onctcp {
  if ($1 == VERSION) || (($target == $me) && ($1 == DCC)) { return }
  var %ch = 0, %txt, %rpl
  if ($target != $me) { %ch = 1 }
  if ($target ischan) {
    var %tgt = $gettok($hget(Kte_Events, $chan), 6, 44)
    if (%tgt = 2) { set -u1 %:echo echo $color(ctcp) -sti2 }
    else { set -u1 %:echo echo $color(ctcp) -ti2 $target }
  }
  else {
    set -u1 %:echo echo $color(ctcp) -ti2 $+ $iif((@* !iswm $active) && ($_isactive) && ($hget(Kte_Events, Active.CTCPs)), a, s)
  }
  set -u1 %::ctcp $1
  set -n %txt $2-
  if ($1 == PING) { %txt = | set -n %rpl $1- }
  elseif ($1- == TIME) { set -n %rpl $1 $fulldate }
  elseif ($1- == FINGER) { set -n %rpl $1 $($fullname, 2) (-) Idle $idle second $+ $iif(($idle != 1), s) }
  set -nu1 %::text $strip(%txt, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
if ($nick($chan, $nick).pnick != $nick) { set -nu1 %::cmode $left($ifmatch, 1) } | set -nu1 %::cnick $nick($chan, $nick).color
set -nu1 %::chan $chan
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
if (%ch) { %:echo 02: 12 $+ %::nick $+ 11/12 $+ %::chan 11- CTCP %::text $+  %:comments }
else { %:echo 02: 12 $+ %::nick (11 $+ %::address $+ 12)11 - CTCP %::text $+  %:comments }
  if (%rpl) { !.ctcpreply $nick %rpl }
unset %:echo %::nick %::address %::target %::parentext %::me %::server %::port %::pre %::c? %::chan %::cmode %::cnick %::text
  haltdef
}
 
alias ctcp {
  if ($isid) { return }
  if ($0 < 2) || (!$server) || ($2 == DCC) { .timer.kte 1 0 !ctcp $1- | .timer.kte -e | return }
  .!ctcp $1-
  if (!$show) { return }
  set -u1 %::target $1
  set -u1 %::ctcp $upper($2)
  set -nu1 %::text $3-
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
  set -u1 %:echo echo $color(ctcp) -ti2 $+ $_active
if ($1 ischan) { set -u1 %::chan $1 | %:echo 02:12 Ctcp (11 $+ %::target $+ 12)11 - %::text $+  %:comments }
else { set -u1 %::nick $1 | %:echo 02:12 Ctcp (11 $+ %::target $+ 12)11 - %::text $+  %:comments }
unset %:echo %::parentext %::nick %::chan %::ctcp %::target %::me %::server %::port %::pre %::c? %::text
}
 
on &*:CTCPREPLY:*:{
  var %rpl | set -n %rpl $2-
  if ($1 == PING) && ($2- isnum 1- $+ $ctime) { %rpl = $duration($calc($ctime - $2)) }
  set -u1 %:echo echo $color(ctcp) -ti2 $+ $_active
  set -u1 %::ctcp $upper($1)
  set -nu1 %::text $strip(%rpl, o)
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::nick $nick
set -nu1 %::address $address
set -nu1 %::target $target
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02: 12 $+ %::nick (11 $+ %::address $+ 12)11 - CTCP REPLY %::text $+  %:comments | haltdef
unset %:echo %::nick %::address %::target %::parentext %::ctcp %::me %::server %::port %::pre %::c? %::text
}
 
alias ctcpreply {
  if ($isid) { return }
  if ($0 < 2) || (!$server) { .timer.kte 1 0 !ctcpreply $1- | .timer.kte -e | return }
  .!ctcpreply $1-
  if (!$show) { return }
  set -u1 %:echo echo $color(ctcp) -ti2 $+ $_active
  set -u1 %::target $1
  set -u1 %::ctcp $upper($2)
  set -nu1 %::text $3-
  set -u1 %::nick $1
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02: 12Ctcp (11 $+ %::target $+ 12)11 - REPLY %::text $+  %:comments
unset %:echo %::parentext %::ctcp %::target %::nick %::me %::server %::port %::pre %::c? %::text
}
 
alias dns {
  if ($isid) { return }
  if (!$0) || (($1 == -h) && ($0 = 1)) || ((. !isin $1) && ($1 != -h) && (!$server)) {
    .timer.kte 1 0 !dns $1- | .timer.kte -e | return
  }
  .!dns $1-
  if (!$show) { return }
  var %h = $1, %f
  if ($istok(-h -c, $1, 32)) { %f = $1 | %h = $2 }
  if (%f != -h) && (. !isin %h) && ($address(%h, 5)) { %h = $gettok($ifmatch, 2, 64) }
  set -u1 %:echo echo $color(info) -ti2 $+ $iif((@* iswm $active) && ($_isactive), s, a)
  set -u1 %::address %h
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
%:echo 02: 11Looking up 02 $+ %::address $+ 11... %:comments
unset %:echo %::address %::me %::server %::port %::pre %::c?
}
 
; ----------------------------------------------------------------------
; Numeric (raw) events  ------------------------------------------------
; ----------------------------------------------------------------------
 
raw 002:*:set -u1 %::value $ [ $+ [ $0 ] ] | _doraw $1-
raw 003:*:if ($2-5 == this server was created) { set -u1 %::value $6- } | _doraw $1-
raw 221:*:set -u1 %::nick $me | set -u1 %::modes $2 | _doraw $1-
raw 250:*:set -u1 %::value $5 | _doraw $1-
raw 251:*:set -u1 %::users $4 | set -u1 %::text $7 | set -u1 %::value $10 | _doraw $1-
raw 255:*:set -u1 %::users $4 | set -u1 %::value $7 | _doraw $1-
raw 265:*:set -u1 %::users $5 | set -u1 %::value $7 | _doraw $1-
raw 266:*:set -u1 %::users $5 | set -u1 %::value $7 | _doraw $1-
raw 301:*:{
  if ($halted) { return }
  if ($hget(Kte_Whois)) { hadd Kte_Whois Away $3- | haltdef }
  else { set -u1 %::nick $2 | set -nu1 %::away $3- | set -nu1 %::text $3- | _doraw $1- }
}
raw 302:*:{
  if ($halted) || (!$isalias(kte::Raw.302)) { return }
  var %i = 2, %t = $0, %p, %addr, %pos
  while (%i <= %t) {
    %p = $ [ $+ [ %i ] ]
    %addr = $gettok(%p, 2, 61)
    %pos = $pos(%addr, $left($remove(%addr, +, -), 1), 1)
    set -u1 %::nick $gettok(%p, 1, 61)
    set -u1 %::address $mid(%addr, %pos)
    set -u1 %::value $left(%addr, $calc(%pos - 1))
    if ($right(%::nick, 1) == *) { %::nick = $left(%::nick, -1) | %::value = %::value $+ * }
    ._doraw $1-
    inc %i
  }
}
 
; /list
raw 321:*:if (!$halted) && ($isalias(kte::Raw.321)) { _doraw $1- }
raw 322:*:if (!$halted) && ($isalias(kte::Raw.322)) { _doraw $1- }
raw 323:*:if (!$halted) && ($isalias(kte::Raw.323)) { _doraw $1- }
; /links
raw 364:*:if (!$halted) && ($isalias(kte::Raw.364)) { _doraw $1- }
raw 365:*:if (!$halted) && ($isalias(kte::Raw.365)) { _doraw $1- }
 
raw 324:*:set -u1 %::chan $2 | set -u1 %::value $3- | set -u1 %::modes $3- | set -u1 %::text $3- | _doraw $1-
raw 329:*:set -u1 %::chan $2 | set -u1 %::value $asctime($3) | set -u1 %::text $3- | _doraw $1-
raw 333:*:set -u1 %::chan $2 | set -u1 %::nick $3 | set -u1 %::value $asctime($4) | set -u1 %::text %::value | _doraw $1-
raw 341:*:set -u1 %::nick $2 | set -u1 %::chan $3 | _doraw $1-
raw 352:*:{
  if ($2 != *) { set -u1 %::chan $2 }
  set -u1 %::address $+($3, @, $4)
  set -u1 %::wserver $5
  set -u1 %::nick $6
  set -u1 %::away $iif((h isin $7), H, G)
  set -u1 %::isoper is $iif((* !isin $7), not)
  set -u1 %::cmode $remove($7, *, H, G)
  set -u1 %::value $8
  set -u1 %::realname $9-
  _doraw $1-
}
raw 353:*:set -u1 %::chan $2 | set -u1 %::text $3- | _doraw $1-
raw 372:*:set -nu1 %::text $3- | _doraw $1-
raw 391:*:set -u1 %::text $3- | _doraw $1-
 
; whois
raw 311:*:{
  var %h = Kte_Whois
  if ($halted) { return }
  if ($hget(%h)) { showwhois Whois }
  if (* iswm $hget(Kte_Theme, Whois)) {
    if (!$hget(%h)) { hmake %h 4 }
    hadd %h Nick $2 | hadd %h Address $+($3, @, $4)
    hadd %h RealName $6-
    haltdef
  }
  if ($isalias(kte::Raw.311)) {
    set -u1 %::nick $2
    set -u1 %::address $+($3, @, $4)
    set -nu1 %::realname $6-
    ._doraw $1-
  }
}
raw 314:*:{
  var %h = Kte_Whois
  if ($halted) { return }
  if ($hget(%h)) { showwhois Whowas }
  elseif (* iswm $hget(Kte_Theme, Whowas)) {
    if (!$hget(%h)) { hmake %h 4 } | hadd %h Nick $2 | hadd %h Address $+($3, @, $4)
    hadd %h RealName $6- | haltdef
  }
  if ($isalias(kte::Raw.314)) {
    set -u1 %::nick $2 | set -u1 %::address $+($3, @, $4) | set -nu1 %::realname $6- | ._doraw $1-
  }
}
raw 319:*:{
  if ($halted) { return }
  if ($hget(Kte_Whois)) { hadd Kte_Whois Chan $hget(Kte_Whois, Chan) $3- | haltdef }
  if ($isalias(kte::Raw.319)) { set -u1 %::nick $2 | set -nu1 %::chan $3- | ._doraw $1- }
}
raw 312:*:{
  if ($halted) { return }
  if ($hget(Kte_Whois)) { hadd Kte_Whois WServer $3 | hadd Kte_Whois ServerInfo $4- | haltdef }
  if ($isalias(kte::Raw.312)) { set -u1 %::nick $2 | set -u1 %::wserver $3 | set -nu1 %::serverinfo $4- | ._doraw $1- }
}
raw 307:*:{
  if ($halted) { return }
  if ($hget(Kte_Whois)) { hadd Kte_Whois IsRegd is | haltdef }
  if ($isalias(kte::Raw.307)) { set -u1 %::nick $2 | set -u1 %::isregd is | ._doraw $1- }
}
raw 313:*:{
  if ($halted) { return }
  if ($hget(Kte_Whois)) { hadd Kte_Whois IsOper is | hadd Kte_Whois OperLine $3- | haltdef }
  if ($isalias(kte::Raw.313)) { set -u1 %::nick $2 | set -u1 %::isoper is | set -nu1 %::operline $3- | ._doraw $1- }
}
raw 317:*:{
  if ($halted) { return }
  if ($hget(Kte_Whois)) { hadd Kte_Whois IdleTime $3 | hadd Kte_Whois SignonTime $4 | haltdef }
  if ($isalias(kte::Raw.317)) {
    set -u1 %::nick $2
    set -u1 %::idletime $3
    set -u1 %::signontime $asctime($4)
    ._doraw $1-
  }
}
raw 318:*:{
  if ($halted) { return }
  if ($hget(Kte_Data, ..NoNick)) { hdel Kte_Data ..NoNick | halt }
  if ($hget(Kte_Whois)) { showwhois Whois | hfree Kte_Whois | haltdef }
  if ($isalias(kte::Raw.318)) { set -nu1 %::nick $2 | ._doraw $1- }
}
raw 369:*:{
  if ($halted) { return }
  if (* iswm $hget(Kte_Data, ..NoNick)) { hdel Kte_Data ..NoNick | halt }
  if ($hget(Kte_Whois)) { showwhois Whowas | hfree Kte_Whois | haltdef }
  if ($isalias(kte::Raw.369)) { set -nu1 %::nick $2 | ._doraw $1- }
}
 
raw *:*:{
  if (6* iswm $numeric) || ($halted) { return }
  if ($numeric = 303) && (!$2-) { Kte_error - $+ $_active The specified nicks are not online | haltdef }
  set -u1 %::nick $2 | set -u1 %::chan $2 | set -u1 %::value $2
  _doraw $1-
}
; /_doraw str <params>
alias -l _doraw {
  var %cl = info2, %f, %n = $right(00 $+ $numeric, 3)
  if ($istok(401 404, $numeric, 32)) { hadd Kte_Data ..NoNick $2 }
  elseif (* iswm $hget(Kte_Data, ..NoNick)) { hdel Kte_Data ..NoNick }
  if ($halted) && ($show) { goto end }
  if ($istok(331 332 333, $numeric, 32)) { %cl = topic }
  elseif ($numeric = 372) { %cl = normal }
  set -u1 %::numeric $numeric
  set -u1 %::fromserver $nick
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
set -nu1 %::target $target
  if ($istok(324 328 329 331 332 333 352 353 366 367 368 404 482, $numeric, 32)) {
    var %ch = $2 | if ($numeric = 353) { %ch = $3 }
    set -u1 %::chan %ch
    if (%ch ischan) { %f = -ti2 %ch }
    set -u1 %::value $3
    if (!$var(%::text)) { set -nu1 %::text $3- }
  }
  if (!$isalias(kte::Raw. $+ %n)) {
    if (!%f) { %f = -ti2 $+ $iif(($_isactive) && ($status != connecting) && (@* !iswm $active), a, s) }
    set -u1 %:echo echo $color(%cl) %f
    if (!$var(%::text)) { set -nu1 %::text $2- }
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
%:echo 02:11 %::text $+  %:comments
  }
  else {
    if ($istok(403 405 437 442 467 468 471 473 474 475 477 478, $numeric, 32)) {
      set -u1 %::chan $2
      if ($numeric = 478) { set -u1 %::value $3 | set -nu1 %::text $4- }
      elseif (!$var(%::text)) { set -nu1 %::text $3- }
    }
    elseif ($istok(432 433 436 438, $numeric, 32)) { set -nu1 %::text $3- }
    elseif ($numeric = 301) {
      if (!$hget(Kte_Events, Active.Away)) { %f = -ti2s }
      elseif ($query($2)) { %f = -ti2 $2 }
    }
    if (!%f) { %f = -ti2 $+ $iif(($_isactive) && ($status != connecting) && (@* !iswm $active), a, s) }
    if (!$var(%::text)) {
      if ($var(%::nick)) || ($var(%::chan)) || ($var(%::value)) { set -nu1 %::text $3- }
      else { set -nu1 %::text $2- }
    }
    set -u1 %:echo echo $color(%cl) %f
if (* iswm %::text) { set -nu1 %::parentext 02(11 $+ %::text $+ 02) }
    $+(kte::Raw., %n)
  }
  haltdef
  :end
unset %:echo %::nick %::address %::chan %::modes %::wserver %::target %::parentext %::fromserver %::value %::numeric %::away %::isoper %::cmode %::realname %::me %::server %::port %::pre %::c? %::text
}
 
alias -l showwhois {
  var %h = Kte_Whois
  if (!$hget(%h, IsOper)) { hadd %h IsOper is not }
  if (!$hget(%h, IsRegd)) { hadd %h IsRegd is not }
set -nu1 %::me $me | set -nu1 %::server $server | set -nu1 %::port $port
set -nu1 %::pre 02:
set -nu1 %::c1 02 | set -nu1 %::c2 11 | set -nu1 %::c3 12 | set -nu1 %::c4 02
  set -u1 %::nick $hget(%h, Nick) | set -u1 %::address $hget(%h, Address) | set -nu1 %::realname $hget(%h, RealName)
  set -nu1 %::chan $hget(%h, Chan) | set -u1 %::wserver $hget(%h, WServer) | set -nu1 %::serverinfo $hget(%h, ServerInfo)
  set -nu1 %::text $hget(%h, Text) | set -u1 %::isregd $hget(%h, IsRegd) | set -u1 %::isoper $hget(%h, IsOper)
  set -nu1 %::operline $hget(%h, OperLine) | set -u1 %::idletime $hget(%h, IdleTime)
  set -u1 %::signontime $asctime($hget(%h, SignonTime)) | set -nu1 %::away $hget(%h, Away)
  set -u1 %:echo echo $color(whois) -ti2 $+ $iif(($_isactive) && (@* !iswm $active) && ($hget(Kte_Events, Active.Whois)), a, s)
if ($1 == Whois) { }
else { }
  hdel -w Kte_Whois *
unset %:echo %::nick %::address %::realname %::chan %::wserver %::serverinfo %::text %::isregd %::isoper %::operline %::idletime %::signontime %::away %::me %::server %::port %::pre %::c?
}
 
 
alias -l kte::Echo %:echo 02:11 %::text $+  %:comments
alias -l kte::EchoTarget %:echo 02: 02[11 $+ %::target $+ 02]11 %::text $+  %:comments
alias -l kte::Error %:echo 02:11 %::text $+  %:comments
alias -l kte::RAW.311 e.whois
alias -l kte::Raw.303 %:echo 02: %::text are online %:comments
alias -l kte::RAW.375 %:echo 02:11 Message of the day02: %:comments
alias -l kte::RAW.319 e.chans
alias -l kte::RAW.255 %:echo 02:11 There are02 %::users $+ 11 clients on 02 $+ %::value $+ 11 server(s) $+  %:comments
alias -l kte::RAW.471 %:echo 02:11 Can't join 02 $+ %::chan $+ 11, because it's full (02mode +l11) $+  %:comments
alias -l kte::RAW.391 %:echo 02:11 Date02: $asctime($ctime(%::text)) %:comments
alias -l kte::Raw.332 e.topic
alias -l kte::RAW.372 %:echo 11 $+ %::text $+  %:comments
alias -l kte::RAW.252 %:echo 02:02 %::value $+ 11 operator(s) online %:comments
alias -l kte::RAW.333 e.settopic
alias -l kte::RAW.317 e.idle
alias -l kte::RAW.329 %:echo 02:11 Created on02: $asctime(%::text) %:comments
alias -l kte::RAW.265 %:echo 02:11 Local users02: %::users 11Max02: %::value $+  %:comments
alias -l kte::RAW.253 %:echo 02:11 Unknown connection(s)02: %::value $+  %:comments
alias -l kte::RAW.001 %:echo 02:11 %::text $+  %:comments
alias -l kte::RAW.482 %:echo 02:11 You're not operator on 02 $+ %::chan $+  %:comments
alias -l kte::RAW.401 %:echo 02:11 No such nickname02: %::nick $+  %:comments
alias -l kte::RAW.266 e.lusers.end
alias -l kte::RAW.250 %:echo 02:11 Total connection(s)02: %::value $+  %:comments
alias -l kte::RAW.002 %:echo 02:11 Host server02: %::server 11running version 02 $+ %::value $+  %:comments
alias -l kte::RAW.474 %:echo 02:11 Can't join 02 $+ %::chan $+ 11, because you're banned! (02mode +b11) $+  %:comments
alias -l kte::RAW.315 %:echo 02:11 End of 02/who11 list for02 %::chan $+  %:comments
alias -l kte::RAW.307 %:echo 02:02 Status11: %::isregd registered nickname %:comments
alias -l kte::RAW.003 %:echo 02:11 Server created on02: %::value $+  %:comments
alias -l kte::Raw.251 e.lusers
alias -l kte::RAW.475 %:echo 02:11 Can't join 02 $+ %::chan $+ 11, because it's requires key. Use 02/join %::chan >key< 11(02mode +k11) $+  %:comments
alias -l kte::RAW.324 %:echo 02:11 Current channel modes02: %::modes $+  %:comments
alias -l kte::RAW.312 %:echo 02:02 Server11: %::wserver 02(11 $+ %::serverinfo $+ 02) $+  %:comments
alias -l kte::RAW.403 %:echo 02:11 No such channel02: %::chan $+  %:comments
alias -l kte::RAW.376 %:echo 02:11 End of 02/motd11 command. %:comments
alias -l kte::RAW.352 %:echo 02:02 %::cmode $+ 12 $+ %::nick (11 $+ %::address $+ 12)11 %::realname $+  %:comments
alias -l kte::RAW.313 %:echo 02:02 IRCop11: %::isoper $+ 02/11 $+ %::operline $+  %:comments
alias -l kte::Raw.301 %:echo 02:02 Away11: %::text $+  %:comments
alias -l kte::RAW.404 %:echo 02:11 Unable to send message to 02 $+ %::chan $+  %:comments
alias -l kte::RAW.353 %:echo 02:11 %::chan $+ 02: %::text $+  %:comments
alias -l kte::RAW.341 %:echo 02:02 %::nick $+ 11 has been invited to join 02 $+ %::chan $+  %:comments
alias -l kte::RAW.005 %:echo 02:11 Protocols supported by this server02: %::text $+  %:comments
alias -l kte::RAW.473 %:echo 02:11 Can't join 02 $+ %::chan $+ 11, because it's invite only! (02mode +i11) $+  %:comments
alias -l kte::Raw.302 %:echo 02:11 Host02: %::nick $+ ! $+ %::address $+  %:comments
alias -l kte::RAW.433 %:echo 02:02 %::nick $+ 11 is already in use. Try 02[ $+ %::nick $+ ]] $+  %:comments
alias -l kte::RAW.421 %:echo 02:11 Invalid command02: %::value $+  %:comments
alias -l kte::RAW.366 %:echo 02:11 End of 02/names11 list for02 %::chan $+  %:comments
alias -l kte::RAW.318 e.whois.end
alias -l kte::RAW.254 %:echo 02:02 %::value 11 channels formed %:comments
