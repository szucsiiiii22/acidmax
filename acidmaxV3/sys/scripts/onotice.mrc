on ^*:notice:*:#:haltdef | if ($nick == ChanServ) { halt } | var %atual = @onotice` $+ $chan | if (!$window(%atual)) { window -kel13 %atual } | listar.ops $chan | echo -t %atual ( $+ $nick $+ ) $2- | halt 
on *:input:@onotice`*:if ($left($1,1) != /) { .notice @ $+ $gettok($active,2,96) $1- | echo -t $active ( $+ $me $+ ) $1- | halt }
alias onotice { if ($me !isop $chan) { echo -a You are not operator in $chan | halt } | var %atual = @onotice` $+ $chan | .notice @ $+ $active $1- | window -akel13 %atual | listar.ops $chan | echo -t $active ( $+ $me $+ ) $1- | halt }
on *:op:#:if ($me isop $chan) { checa.nick $chan }
on *:deop:#:if ($opnick == $me) { window -c @onotice` $+ $chan } | if ($me isop $chan) { checa.nick $chan }
on *:kick:#:if ($knick == $me) { window -c @onotice- $+ $chan } | if ($me isop $chan) { var %rula = @onotice` $+ $chan | if ($window(%rula)) { .timercheca 1 0 listar.ops $chan } }
on *:part:#:if ($nick == $me) { window -c @onotice` $+ $chan } | if ($me isop $chan) { var %rula = @onotice` $+ $chan | if ($window(%rula)) { .timercheca 1 0 listar.ops $chan } }
on ^*:QUIT:{
  haltdef
  var %aaa
  if ($comchan($nick,%aaa)) {
    if ($left($window(%aaa),8) == @onotice) && ($fline($window(%aaa),@ $+ $nick,1,1) != $null) { dline -l $window(%aaa) $fline($window(%aaa),@ $+ $nick,1,1) }
    goto loop
  }
}
alias listar.ops {
  var %atual2 = @onotice` $+ $1
  clear -l %atual2
  titlebar %atual2 [[ $+ $opnick($1,0) $+ ]] @Operators
  var %a = 1
  while (%a <= $opnick($1,0)) {
    aline -l %atual2 @ $+ $opnick($1,%a)
    inc %a
  }
}
alias checa.nick {
  var %janela = @onotice` $+ $1
  if ($window(%janela)) { listar.ops $1 }
}
menu @onotice* {
  dclick:{
    if ($mouse.lb == $true) { query $remove($sline($active,1),@) }
  }
  $iif($mouse.lb == $false, &clear): clear $active
  -
  $iif($mouse.lb == $false, &close): window -c $active
}
menu channel {
  -
  Onotice $chan:if ($me !isop $chan) { echo -a You are not operator in $chan | halt } | var %atual = @onotice` $+ $chan | window -akel13 %atual | listar.ops $chan | halt
}
on *:load:{
  echo -a type /onotice <nick>
}
