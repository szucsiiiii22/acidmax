;##############################################
; Script:   ByteCam.mrc
; Module:   ByteCam.dll
; Purpose:  WebCam Module for mIRC
; Author:   Bill Mullins (Byte187)
; Support:  http://www.Byte187.com/bytecam/
;##############################################

#ByteCam on

menu status,channel,menubar {
  -
  $bc.modname $bc.vstr
  .$iif(# == $null, $style(2)) Advertise $bc.modname $bc.vstr:bc.ad
  .-
  .Open $bc.modname $bc.vstr:bc.open
  .$iif($exists($shortfn($scriptdirByteCam\Snapshots)) == $false, $style(2)) Open Snapshot Folder:bc.opensnaps
  .$iif($exists($shortfn($scriptdirByteCam\Videos)) == $false, $style(2)) Open Video Folder:bc.openvids
  .-
  .$iif($bc.bcast != $true, $style(2)) Invite <?>:bc.invite $$?="Type the nick to invite:"
  .-
  .$bc.modname IRC:bc.irc
  .$bc.modname Website:bc.website
  .$bc.modname Online Forum:bc.forum
  .$bc.modname Pro Upgrade:bc.upgrade
  .About $bc.modname $bc.vstr:bc.about
  .-
  .$iif($exists($bcdll) == $false, $style(2)) Shutdown $bc.modname $bc.vstr:bc.close
  -
}
menu query,chat {
  -
  $bc.modname $bc.vstr
  .Advertise $bc.modname $bc.vstr:bc.ad
  .-
  .Open $bc.modname $bc.vstr:bc.open
  .$iif($exists($shortfn($scriptdirByteCam\Snapshots)) == $false, $style(2)) Open Snapshot Folder:bc.opensnaps
  .$iif($exists($shortfn($scriptdirByteCam\Videos)) == $false, $style(2)) Open Video Folder:bc.openvids
  .-
  .$iif($bc.bcast != $true, $style(2)) Invite $1:bc.invite $1
  .-
  .$bc.modname IRC:bc.irc
  .$bc.modname Website:bc.website
  .$bc.modname Online Forum:bc.forum
  .$bc.modname Pro Upgrade:bc.upgrade
  .About $bc.modname $bc.vstr:bc.about
  .-
  .$iif($exists($bcdll) == $false, $style(2)) Shutdown $bc.modname $bc.vstr:bc.close
  -
}
menu nicklist {
  -
  $bc.modname $bc.vstr
  .Open $bc.modname $bc.vstr:bc.open
  .$iif($exists($shortfn($scriptdirByteCam\Snapshots)) == $false, $style(2)) Open Snapshot Folder:bc.opensnaps
  .$iif($exists($shortfn($scriptdirByteCam\Videos)) == $false, $style(2)) Open Video Folder:bc.openvids
  .-
  .$iif(!$bc.bcast, $style(2)) Invite $$snick(#,1):bc.invite $$snick(#,1)
  .-
  .$bc.modname IRC:bc.irc
  .$bc.modname Website:bc.website
  .$bc.modname Online Forum:bc.forum
  .$bc.modname Pro Upgrade:bc.upgrade
  .About $bc.modname $bc.vstr:bc.about
  .-
  .$iif($exists($bcdll) == $false, $style(2)) Shutdown $bc.modname $bc.vstr:bc.close
  -
}

alias bc.open { dll $bcdll OpenCam }
alias bc.close { dll -u $bcdll }
alias bc.website { dll $bcdll WebSite }
alias bc.forum { dll $bcdll Forum }
alias bc.upgrade { dll $bcdll Upgrade }
alias bc.about { dll $bcdll ShowAbout }
alias bc.opensnaps { .run $+(",$scriptdirByteCam\Snapshots,") }
alias bc.openvids { .run $+(",$scriptdirByteCam\Videos,") }
alias bc.bcast { return $dll($bcdll, ServerUp, $null) }
alias bc.port { return $dll($bcdll, ServerPort, $null) }
alias bc.modname { return $dll($bcdll, ModuleName, $null) }
alias bc.camname { return $dll($bcdll, CamName, $null) }
alias bc.cam { if ($bc.camname != $null) return $+($chr(91),$bc.camname,$chr(93)) | return $null }
alias bc.vstr { return $dll($bcdll, VersionString, $null) }
alias bc.vnum { return $dll($bcdll, VersionNumber, $null) }
alias bc.ad { say $bc.modname $bc.vstr $bc.cam - Get it Free @ http://www.byte187.com/bytecam/ }
alias bc.invite { 
  dll $bcdll SendInvite $cid $$1
}
alias bc.irc {
  var %tmp = 1
  while (%tmp <= $scon(0)) {
    if ($scon(%tmp).network == ByteNet) {
      scon -t1 %tmp join #ByteCam
      if (scon -s %tmp $window(#ByteCam) != $null) { scon %tmp window -a #ByteCam }
      return
    }
    inc %tmp
  }
  server -m irc.byte187.com -j #ByteCam
}

ctcp *:BYTECAM: {
  ;echo -s $1-
  if ($2 == INVITE && $3 isnum && $4 isnum && $5 isnum 1025-65535) {
    dll $bcdll RecvInvite $cid $nick $3-
  }
  else if ($2 == REQUEST) {
  }
  haltdef
}

on *:CTCPREPLY:BYTECAM *: {
  ;echo -s $1-
  if ($2 == INVITE && $3 isnum && $4 isnum && $5 isnum 1025-65535) {
    dll $bcdll InviteReply $cid $nick $3-
  }
  haltdef
}
#ByteCam end

on *:load:{
  if ($bc.compatible) { .enable #ByteCam | set %bc.dir $bc.dir }
  else { .disable #ByteCam }
}

on *:unload:{
  if ($sock(gdiplus.head) != $null) { sockclose gdiplus.head }
  if ($sock(gdiplus.data) != $null) { sockclose gdiplus.data }
}

alias bc.dir { return $scriptdir }
alias bcdll { return $shortfn($+($bc.dir,ByteCam.dll)) }
alias bc.compatible { 
  if (!$exists($bcdll)) return $false
  if ($version < 6.14) {
    echo $color(Info2) -s -
    echo $color(Info2) -s mIRC $version is too old to run ByteCam.
    echo $color(Info2) -s ByteCam will be disabled until you update your copy of mIRC.
    echo $color(Info2) -s -
    .timer 1 1 .unload -rs $shortfn($script)
    return $false
  }
  if (($os != XP) && ($os != 2003)) {
    if (!$exists($shortfn($+($bc.dir,gdiplus.dll)))) {
      .timer 1 1 bc.gdiplus
      return $false
    }
    if ($md5($shortfn($+($bc.dir,gdiplus.dll)), 2) != 3317698f2090dd811f0aa93190e13c82) {
      .timer 1 1 bc.gdiplus
      return $false
    }
  }
  return $true
}
alias bc.copy {
  var %err = 0
  if (!$exists($shortfn($+($bc.dir,ByteCam\.tmp\ByteCam.dll)))) return
  if ($dll(ByteCam.dll) != $null) { dll -u $dll(ByteCam.dll) | .timer 1 2 bc.copy | return }
  reseterror
  %err = 12
  .copy -o $+(",$scriptdirByteCam\.tmp\ByteCam.dll,") $+(",$scriptdirByteCam.dll,")
  %err = 10
  .remove $+(",$scriptdirByteCam\.tmp\ByteCam.dll,")
  %err = 0
  bc.open
  return
  :error
  if (%err == 12) { 
    .disable #ByteCam
    echo $color(Info) -s -
    echo $color(Info) -s Error copying ByteCam.dll
    echo $color(Info) -s ByteCam will be disabled.
    echo $color(Info) -s -
  }
  if (%err == 10) { bc.open }
  reseterror
}

dialog -l bc.gdiplus.table {
  title "gdiplus.dll update"
  size -1 -1 320 240
  option type pixels

  edit "", 101, 0 0 320 210, multi, read, return, vsbar, autovs
  text "", 102, 5 220 220 18, 
  button "Ok", 201, 265 212 50 25, default, ok, hide
}

on *:dialog:bc.gdiplus.dlg:init:0: {
}

alias -l bc.gdiplus.report {
  if ($dialog(bc.gdiplus.dlg)) {
    did -a bc.gdiplus.dlg 101 $+($$1-, $crlf)
    return
  }
  echo $color(Info2) -s $$1-
}

alias -l bc.gdiplus {
  if (($os == XP) || ($os == 2003)) return
  if (!$dialog(bc.gdiplus.dlg)) dialog -m bc.gdiplus.dlg bc.gdiplus.table
  if ($sock(gdiplus.head) != $null) {
    sockclose gdiplus.head
    .timer 1 1 bc.gdiplus
    return
  }
  if ($sock(gdiplus.data) != $null) {
    sockclose gdiplus.data
    .timer 1 1 bc.gdiplus
    return
  }
  unset %gdiplus.*
  if ($dialog(bc.gdiplus.dlg)) {
    did -r bc.gdiplus.dlg 101
    did -h bc.gdiplus.dlg 201
  }
  bc.gdiplus.report ByteCam uses the GDI+ library which was introduced with Windows XP.
  bc.gdiplus.report -
  bc.gdiplus.report To run ByteCam on Windows $os $+ , you need to have gdiplus.dll copied to $+($bc.dir,gdiplus.dll)
  bc.gdiplus.report -
  bc.gdiplus.report ByteCam will now attempt to download gdiplus.dll for you.
  bc.gdiplus.report -
  sockopen gdiplus.head www.byte187.com 80
}

alias -l bc.gdiplus.fail {
  if (($os == XP) || ($os == 2003)) return
  if ($exists($shortfn($+($bc.dir,gdiplus.dll)))) .remove $+(",$bc.dir,gdiplus.dll,")
  bc.gdiplus.report GDI+ Download failed. ByteCam will be unloaded.
  unset %gdiplus.*
  .timer 1 1 .unload -rs $shortfn($script)
}

on *:sockopen:*: {
  if ($sockname == gdiplus.head) {
    sockwrite -n $sockname GET /bytecam/gdiplus.dll HTTP/1.1
    sockwrite -n $sockname Host: www.byte187.com
    sockwrite -n $sockname User-Agent: $os + mIRC $version
    sockwrite -n $sockname Accept: */*
    sockwrite -n $sockname Connection: close
    sockwrite -n $sockname
  }
}

on *:sockread:*:{
  if ($sockname == gdiplus.head) {
    sockread %gdiplus.head
    if ($sockerr > 0 || $sockbr == 0) { sockclose $sockname | bc.gdiplus.fail | return }
    if (%gdiplus.head == $null) {
      sockrename $sockname gdiplus.data
      return
    }
    tokenize 32 %gdiplus.head
    if ($1 == HTTP/1.1) {
      if ($2 != 200) { bc.gdiplus.report $3- | sockclose $sockname | bc.gdiplus.fail | return }
      write -c $+(",$bc.dir,gdiplus.dll,")
      bc.gdiplus.report When the gdiplus.dll download is complete, ByteCam will be ready to run.
      bc.gdiplus.report -
      bc.gdiplus.report Downloading gdiplus.dll, please wait...
    }
    if (($1 == Content-Length:) && ($2 isnum)) {
      set %gdiplus.length $2
      set %gdiplus.recv 0
    }
  }
  if ($sockname == gdiplus.data) {
    sockread &data
    if ($sockerr > 0 || $sockbr == 0) { sockclose $sockname | bc.gdiplus.fail | return }
    inc %gdiplus.recv $sockbr
    bwrite $+(",$bc.dir,gdiplus.dll,") -1 -1 &data
    if (%gdiplus.length > 0) {
      var %rem = $calc(%gdiplus.length - %gdiplus.recv)
      if ($dialog(bc.gdiplus.dlg)) {
        did -o bc.gdiplus.dlg 102 1 $+($round($calc(100 - ((%rem / %gdiplus.length) * 100)), 0), %) Complete - $&
          $round($calc(%gdiplus.recv / 1024^2), 2) MB of $round($calc(%gdiplus.length / 1024^2), 2) MB
      }
    }
  }
}

on *:sockclose:*:{
  if ($sockname == gdiplus.data) {
    unset %gdiplus.*
    if ($dialog(bc.gdiplus.dlg)) { did -vf bc.gdiplus.dlg 201 }
    if ($bc.compatible) {
      .enable #ByteCam
      bc.gdiplus.report -
      bc.gdiplus.report GDI+ download complete!
      bc.gdiplus.report $$bc.modname $bc.vstr is now enabled.
    }
    else { .disable #ByteCam }
  }
}
