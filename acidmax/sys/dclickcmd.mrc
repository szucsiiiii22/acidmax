alias dclick.version return 0.26
alias -l logo return [dclick]

on *:load: { 
  dclickcmd.mrc.reset
  dclick
}
on *:start: { 
  dclick.write.default
  if ($_vr(Dclickcmd,switch) == $null) _vw Dclickcmd switch on
  if ($_vr(Dclickcmd,switch) == on) dclick 
}
on *:unload: {
  dclickcmd.mrc.unload
}
alias dclickcmd.mrc.unload {
  if ($dialog(dclickcmd)) dialog -c dclickcmd
  remini data\setting.ini dclickcmd
  .remove data\dclick.ini
  writeini mirc.ini clicks query /whois $chr(36) $+ 1
  writeini mirc.ini clicks nicklist /query $chr(36) $+ 1
  writeini mirc.ini clicks channel /channel
  writeini mirc.ini clicks status /lusers
  if ($show) echo -a $logo you need to restart mIRC to enable default command
}
alias dclickcmd.mrc.reset {
  .dclickcmd.mrc.unload
  dclick.write.default
  _vw Dclickcmd switch on
  if ($readini(mirc.ini,clicks,query) != /dclickcmd.query.cmd $chr(36) $+ 1) { writeini mirc.ini clicks query /dclickcmd.query.cmd $chr(36) $+ 1 | var %restart = $true }
  if ($readini(mirc.ini,clicks,nicklist) != /dclickcmd.nicklist.cmd $chr(36) $+ 1) { writeini mirc.ini clicks nicklist /dclickcmd.nicklist.cmd $chr(36) $+ 1 | var %restart = $true }
  if ($readini(mirc.ini,clicks,channel) != /dclickcmd.channel.cmd $chr(36) $+ 1) { writeini mirc.ini clicks channel /dclickcmd.channel.cmd $chr(36) $+ 1 | var %restart = $true }
  if ($readini(mirc.ini,clicks,status) != /dclickcmd.status.cmd $chr(36) $+ 1) { writeini mirc.ini clicks status /dclickcmd.status.cmd $chr(36) $+ 1 | var %restart = $true }
  if (%restart) echo -a $logo you need to restart mIRC or type /dclick.help to know how to enable Dclick without restarting mIRC.
  dclick
}

alias dclick.help {
  echo -a $logo 1. Press ALT+O to open mIRC Options
  echo -a $logo 2. Select the category Mouse in the left menu
  echo -a $logo 3. Change query to: /dclickcmd.query.cmd $chr(36) $+ 1
  echo -a $logo 4. Change channel to: /dclickcmd.channel.cmd $chr(36) $+ 1
  echo -a $logo 5. Change nicklist to: /dclickcmd.nicklist.cmd $chr(36) $+ 1
  echo -a $logo 6. Change status to: /dclickcmd.status.cmd $chr(36) $+ 1
  echo -a $logo 7. Press OK to close mIRC Options
}

menu menubar {
  d $+ click toolbar
  .open: dclick
  .load on startup
  ..$iif($_vr(Dclickcmd,switch) != off,$style(1)) on: _vw dclickcmd switch on
  ..$iif($_vr(Dclickcmd,switch) == off,$style(1)) off: _vw dclickcmd switch off
  .-
  .add/modify: dclickaddmod
  .delete: dclickdel
  .reset to default: dclickcmd.mrc.reset
}
alias dclick if ($dialog(dclickcmd) == $null) dialog -m dclickcmd dclickcmd
dialog dclickcmd {
  title "Double Click Command Toolbar"
  size $calc($window(-1).w - 600) 1 263 32
  option dbu
  button "ok", 99, 1 1 1 1, hide cancel
  box "Channel", 1, 2 9 64 21
  combo 2, 4 16 60 50, size drop
  box "Nicklist", 3, 67 9 64 21
  combo 4, 69 16 60 50, size drop
  box "Query", 5, 132 9 64 21
  combo 6, 134 16 60 50, size drop
  box "Status", 7, 197 9 64 21
  combo 8, 199 16 60 50, size drop
  check "enable", 9, 3 1 30 9
}
on *:dialog:dclickcmd:init:0: {
  if ($_vr(Dclickcmd,switch) == on) { did -c dclickcmd 9 }
  dclickcmd.channel dclickcmd 2
  dclickcmd.nicklist dclickcmd 4
  dclickcmd.query dclickcmd 6
  dclickcmd.status dclickcmd 8
}
on *:dialog:dclickcmd:sclick:*:{ 
  if ($did == 2) { _vw Dclickcmd Channel $did(dclickcmd,2).seltext }
  if ($did == 4) { _vw Dclickcmd Nicklist $did(dclickcmd,4).seltext }
  if ($did == 6) { _vw Dclickcmd Query $did(dclickcmd,6).seltext }
  if ($did == 9) {
    if ($_vr(Dclickcmd,switch) == on) { _vw Dclickcmd switch off }
    else { _vw Dclickcmd switch on }
  }
  if ($did == 8) { _vw Dclickcmd status $did(dclickcmd,8).seltext }
}  
alias dclickcmd.nicklist {
  did -r $1 $2
  var %dc.loop = 0
  :loop
  inc %dc.loop 1
  if ($ini(data\dclick.ini,nicklist,%dc.loop) != $null) {
    did -a $1 $2 $ini(data\dclick.ini,nicklist,%dc.loop)
    goto loop
  }
  if ($_vr(Dclickcmd,nicklist) == $null) _vw Dclickcmd nicklist query
  did -c $1 $2 $didwm($1,$2,$_vr(Dclickcmd,nicklist),1)
}
alias dclickcmd.query {
  did -r $1 $2
  var %dc.loop = 0
  :loop
  inc %dc.loop 1
  if ($ini(data\dclick.ini,query,%dc.loop) != $null) {
    did -a $1 $2 $ini(data\dclick.ini,query,%dc.loop)
    goto loop
  }
  if ($_vr(Dclickcmd,query) == $null) _vw Dclickcmd query whois
  did -c $1 $2 $didwm($1,$2,$_vr(Dclickcmd,query),1)
}
alias dclickcmd.channel {
  did -r $1 $2
  var %dc.loop = 0
  :loop
  inc %dc.loop 1
  if ($ini(data\dclick.ini,channel,%dc.loop) != $null) {
    did -a $1 $2 $ini(data\dclick.ini,channel,%dc.loop)
    goto loop
  }
  if ($_vr(Dclickcmd,Channel) == $null) _vw Dclickcmd channel channel control
  did -c $1 $2 $didwm($1,$2,$_vr(Dclickcmd,channel),1)
}
alias dclickcmd.status {
  did -r $1 $2
  var %dc.loop = 0
  :loop
  inc %dc.loop 1
  if ($ini(data\dclick.ini,status,%dc.loop) != $null) {
    did -a $1 $2 $ini(data\dclick.ini,status,%dc.loop)
    goto loop
  }
  if ($_vr(Dclickcmd,status) == $null) _vw Dclickcmd status lusers
  did -c $1 $2 $didwm($1,$2,$_vr(Dclickcmd,status),1)
}

alias dclickcmd.channel.cmd {
  if ($_vr(Dclickcmd,Channel) == $null) _vw Dclickcmd channel channel control
  var %dc.cmd = $readini(data\dclick.ini,channel,$_vr(Dclickcmd,channel))
  if (%dc.cmd) %dc.cmd 
  if (%dc.cmd == dclick.sonica.random) { show.s }
}
alias dclickcmd.nicklist.cmd {
  if ($_vr(Dclickcmd,nicklist) == $null) _vw Dclickcmd nicklist query
  var %dc.cmd = $readini(data\dclick.ini,nicklist,$_vr(Dclickcmd,nicklist))
  if (%dc.cmd) %dc.cmd
}
alias dclickcmd.query.cmd {
  if ($_vr(Dclickcmd,query) == $null) _vw Dclickcmd query whois
  var %dc.cmd = $readini(data\dclick.ini,query,$_vr(Dclickcmd,query))
  if (%dc.cmd) %dc.cmd
}
alias dclickcmd.status.cmd {
  if ($_vr(Dclickcmd,status) == $null) _vw Dclickcmd status lusers
  var %dc.cmd = $readini(data\dclick.ini,status,$_vr(Dclickcmd,status))
  if (%dc.cmd) && ($server != $null) %dc.cmd
}
alias dclick.sonica.play {
  if ($dialog(sonica)) {
    set %sonica.active $chan
    if ($isalias(sonica.play.sel)) sonica.play.sel
    else echo -a [Dclick error] wrong version of sonica
  }
  else echo 4 -a [Dclick error] sonica not open
}
alias dclick.sonica.random {
  set %sonica.active $chan
  smp3
}
alias dclick.write.default.channel {
  writeini data\dclick.ini channel channel control channel
  writeini data\dclick.ini channel sonica - play dclick.sonica.play
  writeini data\dclick.ini channel sonica - random dclick.sonica.random
}
alias dclick.write.default.nicklist {
  writeini data\dclick.ini nicklist query query $chr(36) $+ 1
  writeini data\dclick.ini nicklist whois whois $chr(36) $+ 1
  writeini data\dclick.ini nicklist uwho uwho $chr(36) $+ 1
  writeini data\dclick.ini nicklist dcc chat dcc chat $chr(36) $+ 1
  writeini data\dclick.ini nicklist dcc send dcc send $chr(36) $+ 1
  writeini data\dclick.ini nicklist ctcp ping ctcp $chr(36) $+ 1 ping
  writeini data\dclick.ini nicklist ctcp version ctcp $chr(36) $+ 1 version
}
alias dclick.write.default.query {
  writeini data\dclick.ini query whois whois $chr(36) $+ 1
  writeini data\dclick.ini query uwho uwho $chr(36) $+ 1
  writeini data\dclick.ini query dcc chat dcc chat $chr(36) $+ 1
  writeini data\dclick.ini query dcc send dcc send $chr(36) $+ 1
  writeini data\dclick.ini query ctcp ping ctcp $chr(36) $+ 1 ping
  writeini data\dclick.ini query ctcp version ctcp $chr(36) $+ 1 version
}
alias dclick.write.default.status {
  writeini data\dclick.ini status lusers lusers
  writeini data\dclick.ini status Connection ms.newconnect
}
alias dclick.write.default {
  dclick.write.default.channel
  dclick.write.default.nicklist
  dclick.write.default.query
  dclick.write.default.status
}

alias dclickaddmod if (!$dialog(dclickaddmod)) dialog -m dclickaddmod dclickaddmod
dialog dclickaddmod {
  title "add/modify command"
  size -1 -1 164 43
  option dbu
  combo 1, 31 6 60 50, size drop
  edit "", 3, 31 30 86 10, autohs
  text "group:", 4, 5 8 25 8, right
  text "show:", 5, 5 19 25 8, right
  text "command:", 6, 5 31 25 8, right
  button "add/mod", 7, 122 9 37 12, ok
  button "cancel", 8, 122 25 37 12, cancel
  combo 9, 31 18 86 50, size edit drop
}
on *:dialog:dclickaddmod:init:0: {
  dclickaddmod.channel.re
  dclickaddmod.show.re
  dclickaddmod.cmd.re
}
on *:dialog:dclickaddmod:sclick:1: {
  dclickaddmod.show.re
  dclickaddmod.cmd.re
}
on *:dialog:dclickaddmod:sclick:9: {
  dclickaddmod.cmd.re
}
on *:dialog:dclickaddmod:sclick:7: {
  if (($did(dclickaddmod,9).text) && ($did(dclickaddmod,3).text)) {
    .writeini data\dclick.ini $did(dclickaddmod,1).seltext $replace($did(dclickaddmod,9).text,$chr(32), $chr(0160)) $did(dclickaddmod,3).text
    if ($dialog(dclickcmd)) {
      dclickcmd.channel dclickcmd 2
      dclickcmd.nicklist dclickcmd 4
      dclickcmd.query dclickcmd 6
      dclickcmd.status dclickcmd 8
    }
  }
}
alias dclickaddmod.channel.re {
  did -r dclickaddmod 1
  did -a dclickaddmod 1 channel
  did -a dclickaddmod 1 nicklist
  did -a dclickaddmod 1 query
  did -a dclickaddmod 1 status
  did -c dclickaddmod 1 1
}
alias dclickaddmod.show.re {
  dclickcmd. $+ $did(dclickaddmod,1).seltext dclickaddmod 9
}
alias dclickaddmod.cmd.re {
  did -r dclickaddmod 3
  if ($did(dclickaddmod,9).seltext) did -a dclickaddmod 3 $readini(data\dclick.ini,n,$did(dclickaddmod,1).seltext,$did(dclickaddmod,9).seltext)
}
alias dclickdel if (!$dialog(dclickdel)) dialog -m dclickdel dclickdel
dialog dclickdel {
  title "delete command"
  size -1 -1 164 31
  option dbu
  combo 1, 31 6 60 50, size drop
  text "group:", 4, 5 8 25 8, right
  text "show:", 5, 5 19 25 8, right
  button "delete", 7, 122 3 37 12, ok
  button "cancel", 8, 122 17 37 12, cancel
  combo 9, 31 18 86 50, size drop
}
on *:dialog:dclickdel:init:0: {
  did -a dclickdel 1 channel
  did -a dclickdel 1 nicklist
  did -a dclickdel 1 query
  did -a dclickdel 1 status
  did -c dclickdel 1 1
  dclickdel.show.re
}
on *:dialog:dclickdel:sclick:1: {
  dclickdel.show.re
}
on *:dialog:dclickdel:sclick:7: {
  if ($?!="Are you sure you want to delete ' $+ $did(dclickdel,9).seltext $+ '?" == $true) .remini data\dclick.ini $did(dclickdel,1).seltext $did(dclickdel,9).seltext
  if ($dialog(dclickcmd)) {
    dclickcmd.channel dclickcmd 2
    dclickcmd.nicklist dclickcmd 4
    dclickcmd.query dclickcmd 6
    dclickcmd.query dclickcmd 8
  }
}
alias dclickdel.show.re {
  dclickcmd. $+ $did(dclickdel,1).seltext dclickdel 9
}
