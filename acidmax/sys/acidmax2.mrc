alias dns { %s.dns = $ctime | %dns = $1 | .dns $1- }
on *:dns: {
  if ($raddress != $null) { $ae •12• dns » ( %dns ) 12ip address: $iaddress 12named address: $naddress 12resolved address: $raddress 12resolved in: $duration($calc($ctime - %s.dns)) | unset %dns | sclick | haltdef }
  else { $ae •12• dns » ( %dns ) 12can not resolve | unset %dns | sclick | haltdef } 
}
ctcp *:*:version: {
  var %c =  $+ $colour(info2)
  echo • $+ %c $+ • version request » ( %c $+ $nick ) sending version reply to $nick ( $+ $address $+ ) | .quote notice $nick : $+ $chr(1) VERSION $a.logo2 (team-nexgen.com) $+ $chr(1)
} 
on *:text:!version:*: {
  if ($_vr(trigger,version) == $null) { _vw trigger version on }
  if ($_vr(trigger,version) == on) {  
    %ft = 1   
    if (%ft >= 3) { 
      .ignore -cu60 $nick | $ae 4[ ALERT ] $nick is trigger flooding. Ignore will be removed in  60 seconds. | .notice $nick You are ignored for trigger flooding. 
      if ($me isop $chan) { ban -u60 $chan $nick 3 | kick $chan $nick (AUTO-KICK) trigger flood | notice $nick You have been banned for trigger flooding. The ban and ignore will be revoked in 60 seconds. }
      haltdef 
    }   
    else { inc %f 1 | .timer 1 20 unset %ft | .notice $nick $a.logo | haltdef } 
  }
}
on *:text:!time:*: {
  if ($_vr(trigger,time) == $null) { _vw trigger time on }
  if ($_vr(trigger,time) == on) {  
    %ft = 1   
    if (%ft >= 3) { 
      .ignore -cu60 $nick | $ae 4[ ALERT ] $nick is trigger flooding. Ignore will be removed in  60 seconds. | .notice $nick You are ignored for trigger flooding. 
      if ($me isop $chan) { ban -u60 $chan $nick 3 | kick $chan $nick (AUTO-KICK) trigger flood | notice $nick You have been banned for trigger flooding. The ban and ignore will be revoked in 60 seconds. }
      haltdef 
    }   
    else { inc %f 1 | .timer 1 20 unset %ft | .notice $nick $timestamp $_vr(info,city) $_vr(info,state) $_vr(info,country) | haltdef } 
  }
}
on *:text:!info:*: {
  if ($_vr(trigger,info) == $null) { _vw trigger info on }
  if ($_vr(trigger,info) == on) {  
    %ft = 1   
    if (%ft >= 3) { 
      .ignore -cu60 $nick | $ae 4[ ALERT ] $nick is trigger flooding. Ignore will be removed in  60 seconds. | .notice $nick You are ignored for trigger flooding. 
      if ($me isop $chan) { ban -u60 $chan $nick 3 | kick $chan $nick (AUTO-KICK) trigger flood | notice $nick You have been banned for trigger flooding. The ban and ignore will be revoked in 60 seconds. }
      haltdef 
    }   
    else { inc %f 1 | .timer 1 20 unset %ft | if ($_vr(info,age) != $null) { .notice $nick $chr(91) $+ age: $_vr(info,age) $+ $chr(93) } | if ($_vr(info,martial) != $null) { .notice $nick $chr(91) $+ status: $_vr(info,martial) $+ $chr(93) } | if ($_vr(info,gender) != $null) { .notice $nick $chr(91) $+ gender: $_vr(info,gender) $+ $chr(93) } | .notice $nick $chr(91) $+ location: $city $state $country $+ $chr(93) | .notice $nick $chr(91) $+ web page: $_vr(info,webpage) $+ $chr(93) | haltdef } 
  }
}
alias -l city { if ($_vr(info,city) != $null) { return $_vr(info,city) $+ , } | else return unknown, }
alias -l state { if ($_vr(info,state) != $null) { return $_vr(info,state) } | else return unknown, }
alias -l country { if ($_vr(info,country) != $null) { return $_vr(info,country) } | else return unknown, }
on *:TEXT:!ping*:*: {
  if ($_vr(trigger,ping) == $null) { _vw trigger ping on }
  if ($_vr(trigger,ping) == on) { 
    if (%upflood5 => 3) { 
      if ($me ison $chan) { .ignore -cpku60 $nick | $ae 0,4[ ALERT ] $nick is Trigger Flooding. Ignore will be removed in  60 seconds. | .notice $nick You are ignored for Trigger Flooding. }
      if ($me isop $chan) { ban -u60 $chan $nick 3 | kick $chan $nick AUTO-KICK Trigger Flood | notice $nick You have been banned for Trigger Flooding. The ban and Ignore will be revoked in 60 seconds. }
      haltdef
    } 
    inc %upflood5 1
    .timer 1 15 unset %upflood5     
    ctcp $nick ping
  }
}
on *:CTCPREPLY:PING*:{
  if ($_vr(trigger,ping) == on) { 
    if ($2 isnum) { 
      var %p = $calc($ctime - $2)  
      .noti $nick . ...[ $+ $nick ping reply $duration(%p) from server: $server $+ $chr(58) $+ $port $+ ]... .
    }
  }
}
alias -l showadd {
  if ($_vr(general,showaddy) == $null) { _vw general showaddy on }
  if ($_vr(general,showaddy) == on) { return $$1- }
  else return
}
#colortheme on
on ^*:join:#: {
  if ($_vr(color,join_switch) == on) { _vw color join_switch on }
  if ($_vr(general,antifreeze) == on) {
    if (%jc == $null) { %jc = 1 }
    .timerjc 1 4 unset %jc
    inc %jc    
    if (%jc == 15) { $e.join •4• warning »4 join flood detected(net merge?), on join event halt initiated (15+ joins in 4 secs). | inc %jc | halt }
    elseif (%jc > 15) { .timerjc 1 4 unset %jc | halt }
  } 
  %c.synch = $ctime 
  if ($_vr(color,join_switch) != off) {
    if (%exjoin == $null) { %exjoin = $c(join) $+ 14»4» join14 }
    if ($me != $nick ) { $e.join $space(1) %exjoin $nick $showadd(( $+ $address $+ ) $cc($address)) $prenick($nick,$chan,$address($nick,3)) $ts2 }
    halt 
  }
}
alias -l e.join {
  if ($_vr(echo,join) == -a) { return echo -t $chan }
  else { return echo -st }
}
alias ahc {
  var %c = $calc($count(%acr, $chr(32))+1)
  var %c1
  while (%c1 <= %c) { 
    if ($chr(36) $+ %c1 == $read(data/acronym.txt, w, $chr(36) $+ %c1)) { return yes }
  }
  else return
}
alias chechk.acro {
  var %tot = $calc($count($1-, $chr(32))+1)
  var %t1 = 1
  if (%t1 <= %tot) { var %t2 = $ $+ %t1 |  $read(data/acronym.txt, w, * [ $+ [ %t2 ] $+ ] *) }
}
alias -l yup {

}
on *:input:*: {
  if ($halted) return 
  else { 
    if ($_vr(color,menick_switch) == on) { _vw color menick_switch on }
    ;test start here---------------------------
    if (/* iswm $1 || $ctrlenter) { 
      return 
    } 
    ; check.acro $1- 
    ; if (brb isin $1-)  { msg $active $replace($1-,brb,Be Right Back) | halt } 
    ;elseif (bbl isin $1-) { msg $active $replace($1-,bbl,Be Back Later) | halt }   
    ; elseif (lol isin $1-) { msg $active $replace($1-,lol,*Laughing out Loud*) | halt }   
    ;end---------------------------  
    if ($_vr(color,nickstyler) == $null) { _vw color nickstyler off }
    if ($_vr(color,menick_switch) != off) { extcoloninput $1- }
    elseif ($_vr(color,menick_switch) == off) && ($_vr(color,nickstyler) == on) {
      if ($1- != $null) && ($left($1,1) != /) { 
        var %c = 1, %t
        while (%c <= $0) { 
          if ($gettok($1-,%c,32) ison $chan) { %t = %t %nick.com1.1 $+ $ifmatch $+ %nick.com1.2 }
          else { %t = %t $gettok($1-,%c,32) }
          inc %c
        }
        if ($charside($1) != $_vr(nick-completor,char)) {   
          msg $active %t 
          halt
        } 
      }
    }
  }
}
on *:input:?: { 
  if ($halted) return 
  else { if ($_vr(color,menick_switch) != off) { extcoloninput $1- } } 
}
on *:input:=: { 
  if ($halted) return 
  else { if ($_vr(color,menick_switch) != off) { extcoloninput $1- } } 
}
alias achro if ($dialog(acromancer) == $null) { dialog -m acromancer acromancer  } 
dialog acromancer {
  title "acromancer"
  size -1 -1 73 169
  option dbu
  edit "", 1, 4 22 64 10
  text "acronym", 2, 5 13 25 8
  edit "", 3, 4 42 64 10
  text "output text", 4, 5 33 37 8
  button "add", 5, 23 54 22 10, disable
  list 6, 5 66 62 50, size
  edit "", 7, 5 131 64 10, disable
  edit "", 8, 5 143 64 10, disable
  button "delete", 9, 21 119 27 10, disable
  button "apply", 10, 21 156 27 10, disable
  button "Button", 11, 22 188 37 12, ok
  check "enable", 12, 4 2 50 10
}
on *:dialog:acromancer:init:*:{
  if ($_vr(acromancer,switch) == on) { did -c acromancer 12 }
  acro.list
}
alias -l acro.list {
  did -r acromancer 6
  var %o = $lines(data/acronym.txt)
  var %o1 = 1
  while (%o1 <= %o) { did -a acromancer 6 $read(data/acronym.txt,%o1) | inc %o1 1 }
}
on *:dialog:acromancer:edit:*:{
  if ($did(1) != $null) && ($did(3) != $null) { did -e acromancer 5 } 
}
on *:dialog:acromancer:sclick:*:{
  if ($did == 5) { 
    writeini -n data/acronym.ini $did(acromancer,1).text acro $did(acromancer,1).text
    writeini -n data/acronym.ini $did(acromancer,1).text text $did(acromancer,3).text
    write data/acronym.txt $did(acromancer,1).text
    if ($readini(data/acronym.ini,$did(acromancer,1).text,acro)  != $null) { writeini -n data/acronym.ini acronym count $calc($readini(data/acronym.ini,acronym,count) + 1) }
    did -r acromancer 1,3 | did -b acromancer 5 
    acro.list 
  }
  if ($did == 12) { 
    if ($_vr(acromancer,switch) == on) { _vw acromancer switch off }
    else { _vw acromancer switch on }
  }
}
alias -l ue {
  if ($_vr(nick-completor,switch) == off) { return $1 }
}
alias -l extcoloninput {
  if ($_vr(color,menick_switch) == on) { _vw color menick_switch on }
  if ($_vr(color,menick_switch) != off) || ($server != $null) {
    if (%meext.1 == $null) || (%meext.2 == $null) { %meext.1 = 4[ | %meext.2 = 4] }
    if ($1- != $null) && ($left($1,1) != /) { 
      var %c = 1, %t
      while (%c <= $0) { 
        if ($gettok($1-,%c,32) ison $chan) { %t = %t %nick.com1.1 $+ $ifmatch $+ %nick.com1.2 }
        else { %t = %t $gettok($1-,%c,32) }
        inc %c
      }
      if ($charside($1) != $_vr(nick-completor,char)) {   
        if ($_vr(color,nickstyler) == on) { .msg $active %t | echo -t $active %meext.1 $+ $modechar($me) $+ %meext.2 $+ $c(own) %t | halt } 
        else { .msg $active $1- | echo -t $active %meext.1 $+ $modechar($me) $+ %meext.2 $+ $c(own) $1- | halt } 
      }
    }  
  }
  elseif ($server != $null) { echo $active $er can not send message, not connected to server. }
}
on ^*:quit: {
  var %quit.nick = $nick
  var %quit.chan = $comchan(%quit.nick,1)
  var %quit.inc = 1
  if ($_vr(general,antifreeze) == on) {
    if (%qc == $null) { %qc = 1 }
    .timerqc 1 4 unset %qc   
    inc %qc  
    if (%qc == 15) {  $e.quit(%quit.chan) •4• warning »4 quit flood detected(net split?), on quit event halt initiated (15+ quits in 4 secs). | inc %qc | halt }
    elseif (%qc > 15) { .timerqc 1 4 unset %qc | halt }
  }
  if ($_vr(color,quit_switch) == on) { _vw color quit_switch on }
  if ($_vr(color,quit_switch) != off) { 
    if (%exquit == $null) { %exquit = $c(quit) $+ 14«4« quit }
    if ($1 != $null) { var %q = ( $1- ) }
    while ($comchan($nick,%quit.inc)) {
      var %quit.chan = $comchan($nick,%quit.inc)
      $e.quit(%quit.chan) $space(1) %exquit $c(quit) $+ $nick $showadd($chr(91) $+ $address $+ $chr(93)) %q $c(quit) $ts2
      inc %quit.inc 1
    }
    haltdef  
  } 
}
alias -l ts2 {
  if ($_vr(general,timestamp) != on) { return $timestamp }
  else return 
}
alias -l e.quit {
  if ($_vr(echo,quit) == -s) { return echo -stl }
  else { return echo -t $1 }
}
alias capp { var %" = , %' = 1, %"' = $replace($1-,$chr(44),.) | while ($mid(%",%',1)) { %"' = $removecs(%"',$ifmatch) | inc %' } | return $round($iif($prop isnum,$round($calc(100 - (($len(%"') / $len($replace($1-,$chr(44),.))) *100)),$prop),$calc(100 - (($len(%"') / $len($replace($1-,$chr(44),.))) *100))),0) $+ % }
alias query {
  if ($_vr(color,menick_switch) == on) { _vw color menick_switch on }
  query $1  
  if ($2 != $null) { .msg $$1- }
  if ($_vr(color,menick_switch) != off) && ($3 != $null) { echo -t $1 %meext.1 $+ $1 $+ %meext.2 $2- }
}
on ^*:text:*:#: {
  if ($halted) return 
  else { 
    if ($_vr(color,channick_switch) == on) { _vw color channick_switch on }
    if ($_vr(color,channick_switch) != off) {
      if (%exnick1 == $null) || (%exnick2 == $null) { %exnick1 = 4[ | %exnick2 = 4] }
      echo -tlm $chan %exnick1 $+ $modechar($nick) $+ %exnick2  $1- 
      if ($me isin $1-) || ($left($me,4) isin $1-) && ($_vr(general,msgrelay) == on) { if ($chan != $active) { echo -lamt %exnick1 $+ $modechar($nick) $+ 4/ $+ $chan $+ ( $+ $network $+ ) $+ %exnick2 $1- } }
      haltdef
    }
  }
}
on ^*:text:*:?: {
  if ($halted) return 
  else { 
    if ($_vr(color,channick_switch) == on) { _vw color channick_switch on }
    if ($_vr(color,channick_switch) != off) { 
      if (%exnick1 == $null) || (%exnick2 == $null) { %exnick1 = 4[ | %exnick2 = 4] }
      echo -lbfmt $query($nick) %exnick1 $+ $modechar $+ $nick $+ %exnick2 $1- | haltdef
    }
  }
}
on ^*:action:*:#: {
  if ($halted) return 
  else { 
    if ($_vr(color,action_switch) == on) { _vw color action_switch on }
    if ($_vr(color,action_switch) != off) {
      if (%exaction == $null) { %exaction = $c(action) $+ • } 
      echo -lbfmt $chan $c(action) $+ %exaction $nick $1-
      haltdef
    }
  }
}
on ^*:notice:*:?: {
  if ($halted) return 
  else { 
    if  ($_vr(color,notice_switch) == $null) { _vw color notice_switch on }
    if  ($_vr(color,notice_switch) == on) { 
      if (%exnotice == $null) { %exnotice = $c(notice) $+ (..notice..) } 
      echo -albft $c(notice) $+ %exnotice $nick $+ : $c(notice) $1- | haltdef 
    }
  }
}
on ^*:voice:#: {
  if ($_vr(general,antifreeze) == on) {
    if (%vc == $null) { %vc = 1 }
    .timervc 1 4 unset %vc
    inc %vc    
    if (%vc == 15) { echo -t $chan •4• warning »4 voice mode flood detected(net merge?), voice mode event halt initiated (15+ voice modes in 4 secs). | inc %vc | halt }
    elseif (%vc > 15) { .timervc 1 4 unset %vc | halt }
  }
  if ($_vr(color,voice_switch) == $null) { _vw color voice_switch on }
  if ($_vr(color,voice_switch) != off) {
    if (%exvoice == $null) { %exvoice = $c(mode) $+ 14»4» voice14 }
    echo -t $chan $space(1) %exvoice $nick voices $vnick in $chan
    halt 
  }
}
on ^*:devoice:#: {
  if ($_vr(color,devoice_switch) == $null) { _vw color devoice_switch on }
  if ($_vr(color,devoice_switch) != off) { 
    if (%exdevoice == $null) { %exdevoice = $c(mode) $+ 14»4» devoice14 }
    echo -t $chan $space(1) %exdevoice $nick devoiced $vnick in $chan | haltdef
  }
}
on ^*:ban:#: {
  if ($_vr(color,ban_switch) == $null) { _vw color ban_switch on }
  if ($_vr(color,ban_switch) != off) { 
    if (%exban == $null) { %exban = $c(mode) $+ 14»4» ban14 }
    echo -t $chan $space(1) %exban $nick bans $bnick $banmask 
    haltdef
  }
}
on ^*:unban:#: {
  if ($_vr(color,unban_switch) == $null) { _vw color unban_switch on }
  if ($_vr(color,unban_switch) != off) { 
    if (%exunban == $null) { %exunban = $c(mode) $+ 14»4» unban14 }
    echo -t $chan $space(1) %exunban $nick unbans $bnick $banmask 
    haltdef
  }
}
on ^*:mode:#: {
  if ($_vr(color,mode_switch) == $null) { _vw color mode_switch on }
  if ($_vr(color,mode_switch) != off) { 
    if (%exmode == $null) { %exmode = $c(mode) $+ 14»4» mode14 }
    echo -t $chan $space(1) %exmode $nick changes mode(s) to $1- 
    haltdef
  }
}
on ^*:topic:#: {
  if ($halted) return 
  else { 
    if ($_vr(color,topic_switch) == $null) { _vw color topic_switch on } 
    if ($_vr(color,topic_switch) != off) { 
      if (%extopic == $null) { %extopic = $c(topic) $+ 14»4» topic14 }
      echo -t $chan $space(1) %extopic $nick changes topic to " $+ $1- $+ " 
      haltdef 
    }  
  }
}
on ^*:part:#: {
  %pc = 0
  inc %pc 1
  if (%pc <= 5) {
    if ($_vr(color,part_switch) == $null) { _vw color part_switch on } 
    if ($_vr(color,part_switch) != off) { 
      if ($1 != $null) var %q = ( $+ $1- $+ )  
      if (%expart == $null) { %expart = $c(part) $+ 14«4« part14 }
      if ($me != $nick ) { $e.part $space(1) %expart $nick $showadd($chr(91) $+ $address $+ $chr(93)) %q $ts2 }
      .timerpc 1 10 unset %pc
      haltdef 
    }
    elseif (%pc == 6) { $e.part •4• warning »4 part channel flood detected, low level protection initiated. }
    elseif (%pc > 6) { haltdef }
  }
}
alias -l e.part {
  if ($_vr(echo,part) == -s) { return echo -stl }
  else { return echo -lt $chan }
}
on ^*:kick:#: {
  if ($_vr(color,kick_switch) == $null) { _vw color kick_switch on }
  if ($_vr(color,kick_switch) != off) { 
    if (%exkick == $null) { %exkick = $c(kick) $+ 14«4« kick14 }
    if ($1 != $null) var %p = ( $+ $1- $+ )
    $e.kick $space(1) %exkick $nick has kicked $knick %p | haltdef 
  }
}
alias -l e.kick {
  if ($_vr(echo,kick) == -s) { return echo -slt }
  else { return echo -t $chan }
}
on ^*:help:#: {
  if ($_vr(color,halfop_switch) != off) { 
    if (%exhalfop == $null) { %exhalfop = $c(mode) $+ 14»4» half-op14 }
    echo -t $chan $space(1) %exhalfop $nick half-ops $hnick in $chan | haltdef
  }
} 
on ^*:dehelp:#: {
  if ($_vr(color,dehalfop_switch) == $null) { _vw color dehalfop_switch on } 
  if ($_vr(color,dehalfop_switch) != off) { 
    if (%exdehalfop == $null) { %exdehalfop = $c(mode) $+ 14»4» dehalf-op14 }
    echo -t $chan $space(1) %exdehalfop $nick dehalf-ops $hnick in $chan | haltdef
  }
} 
on ^*:op:#: {
  if ($_vr(color,op_switch) == $null) { _vw color op_switch on }
  if ($_vr(color,op_switch) != off) { 
    if (%exop == $null) { %exop = $c(mode) $+ 14»4» op14 }
    echo -t $chan $space(1) %exop $nick ops $opnick in $chan | haltdef
  }
} 
on ^*:deop:#: {
  if ($_vr(color,deop_switch) == $null) { _vw color deop_switch on }
  if ($_vr(color,deop_switch) != off) { 
    if (%exdeop == $null) { set %exdeop $c(mode) $+ 14»4» deop14 }
    echo -t $chan $space(1) %exdeop $nick deops $opnick in $chan | haltdef
  }
}
on ^*:nick: {
  if ($_vr(color,newnick_switch) != off) { 
    if (%exnew == $null) { %exnew = $c(nick) $+ 14»4» nick change14 }
    var %new.nick = $newnick
    var %new.chan = $comchan(%new.nick,1)
    var %temp = 1
    while ($comchan($newnick,%temp)) {
      echo -t $comchan($newnick,%temp) $space(1) %exnew $c(nick) $+ $nick ( $+ $address $+ ) changes nick to " $+ $newnick $+ "   
      inc %temp 1    
    }
    haltdef
  }
}
alias -l e.nickchange {
  if ($_vr(echo,nickchange) == -a) { return echo -st }
  else { return echo -t $chan }
}
#colortheme end
alias c { return  $+ $colour($1),00 }
alias modechar {
  if ($left($nick($chan,$1).pnick,1) == +) && ($_vr(color,voicechar_switch) == on) { return %exvoicechar $+ $1 }
  elseif ($left($nick($chan,$1).pnick,1) == @) && ($_vr(color,opchar_switch) == on) { return %exopchar $+ $1 }
  elseif ($left($nick($chan,$1).pnick,1) == %) && ($_vr(color,halfopchar_switch) == on) { return %exhalfopchar $+ $1 }
  elseif ($left($nick($chan,$1).pnick,1) == *) { return 14* $+ $1 }
  elseif ($left($nick($chan,$1).pnick,1) == !) { return 14! $+ $1 }
  elseif ($left($nick($chan,$1).pnick,1) == -) { return 14- $+ $1 }
  else return $1
}
;+oa = OP and protect: !
;+q = Chanowner: *
menu menubar,status,query,channel {
  $iif($acid == $true,• utilities)
  .color event theme:colortheme
  $iif($acid != $true,event color theme):colortheme
}
alias -l dnc {
  var %dnc.inc = 4
  :dncloop
  inc %dnc.inc 2
  if (%dnc.inc < 41) { did -a color %dnc.inc mirc | did -a color %dnc.inc acidmax | did -a color %dnc.inc custom | goto dncloop }
}
on *:start: {
  if ($_vr(color,color_switch) == $null) { _vw color color_switch on | .enable #colortheme } 
}
on ^*:open:?: {
  if ($_vr(general,queryblock) == on) {
    var %zk = $strip($1-,cbur) 
    if (*www.* iswm %zk) && (*team-nexgen.com* !iswm $1-) { _vw general spamblock $calc($_vr(general,spamblock) + 1) | .msg $nick SPAM BLOCKED:  $_vr(general,spamblock) spam(s) have been blocked. $nex2 | echo -at •4• alert »4 SPAM BLOCKED: $nick  $+ $_vr(general,spamblock) spam(s) have been blocked since $_vr(general,spamblockd) | bdate | .timer  -m 1 1 close -mc $nick  | sbq }
    elseif (*http:* iswm %zk) { _vw general spamblock $calc($_vr(general,spamblock) + 1) | .msg $nick SPAM BLOCKED: $_vr(general,spamblock) spam(s) have been blocked. $nex2 | echo -at •4• alert »4 SPAM BLOCKED: $nick  $+ $_vr(general,spamblock) spam(s) have been blocked since $_vr(general,spamblockd) | bdate | .timer -m 1 1 close -mc $nick | sbq }
    elseif (*irc.* iswm %zk) { _vw general spamblock $calc($_vr(general,spamblock) + 1) | .msg $nick SPAM BLOCKED: $_vr(general,spamblock) spam(s) have been blocked. $nex2 | echo -at •4• alert »4 SPAM BLOCKED: $nick  $+ $_vr(general,spamblock) spam(s) have been blocked since $_vr(general,spamblockd) | bdate | .timer -m 1 1 close -mc $nick | sbq }
    elseif (*WwW.erotiksex.sex.tr.tc* iswm %zk) { _vw general spamblock $calc($_vr(general,spamblock) + 1) | .msg $nick SPAM BLOCKED: $_vr(general,spamblock) spam(s) have been blocked. $nex2 | echo -at •4• alert »4 SPAM BLOCKED: $nick  $+ $_vr(general,spamblock) spam(s) have been blocked since $_vr(general,spamblockd) | bdate | .timer -m 1 1 close -mc $nick | sbq }
    elseif (*w w w.* iswm %zk) { _vw general spamblock $calc($_vr(general,spamblock) + 1) | .msg $nick SPAM BLOCKED: $_vr(general,spamblock) spam(s) have been blocked. $nex2 | echo -at •4• alert »4 SPAM BLOCKED: $nick  $+ $_vr(general,spamblock) spam(s) have been blocked since $_vr(general,spamblockd) | bdate | .timer -m 1 1 close -mc $nick | sbq }
    elseif ($chr(35) isin %zk) && (*xdcc* !iswm %zk) && (*#nexgen* !iswm %zk) { _vw general spamblock $calc($_vr(general,spamblock) + 1) | .msg $nick SPAM BLOCKED: $_vr(general,spamblock) spam(s) have been blocked. $nex2 | echo -at •4• alert »4 SPAM BLOCKED: $nick  $+ $_vr(general,spamblock) spam(s) have been blocked since $_vr(general,spamblockd) | bdate | .timer -m 1 1 close -mc $nick | sbq }
  }
}
alias -l sbq {
  if ($_vr(querycon,switch) == on) { .timer -m 1 1 dialog -c $nick | echo -at •4• secure query »4 auto-closed, spam detected. }
}
alias -l bdate {
  if ($_vr(general,spamblockd) == $null) {  _vw general spamblockd  $asctime(mmm dd yyyy) }  
  if ($_vr(general,spamblock) == $null) { _vw general spamblock 0 } 
}
