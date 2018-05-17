alias _vr {
  if ($exists(sys\data\v3.ini) == $false) { mkdir sys\data\ | write -c sys\data\v3.ini }
  return $readini sys\data\v3.ini $$1 $$2
}
alias _vw {
  if ($exists(sys\data\v3.ini) == $false) { mkdir sys\data\ | write -c sys\data\v3.ini }
  writeini sys\data\v3.ini $$1 $$2 $$3-
}
alias _vrem {
  if ($exists(sys\data\v3.ini) == $false) { mkdir sys\data\ | write -c sys\data\v3.ini }
  remini sys\data\v3.ini $$1 $$2
}


alias nver return v3.0
alias build return alpha
alias a.logo {
  return .::nexgen·acidmax::. $nver $+ $chr(46) $+ $build (mirc $version $+ )  ©2005, by team nexgen - www.team-nexgen.com
}
alias acidmax {
  if ($server != $null) && ($_vr(version,color) == $null) { .msg $active $a.logo | echo -at %meext.1 $+ $me $+ %meext.2 $a.logo }
  elseif ($server != $null) && ($_vr(version,color) == on) { .msg $active $a.logo | echo -at %meext.1 $+ $me $+ %meext.2 $a.logo }
  elseif ($server != $null) && ($_vr(version,color) == off) { .msg $active $a.logo2 | echo -at %meext.1 $+ $me $+ %meext.2 $a.logo }
  else { echo -a $a.logo }
}
alias unload.dll { dll -u $adll }
alias dll.update { dll $adll updatedll }
alias adll { return $shortfn($findfile($mircdir,acidmax.dll,1)) }
alias nexgen { return $true }
alias acid { return $true }

alias hos { dll sys\dlls\hos.dll $$1- }
alias mdx {
  if ($isid) return $dll(sys\dlls\mdx.dll,$1,$2-)
  else dll sys\dlls\mdx.dll $1-
}

alias whereis {
  if (!$1) {
    var %1 $!findalias(<name>,N,[l]).prop where prop can be size/line/fname/local
    echo -a Correct usage is $iif($isid,%1,/findalias [-l] <name>)
    return
  }
  var %$true $remove($1,/) $iif($2 isnum,$2,0) $iif(($2 == l) || ($3 == l),l),%$false $iif($1 == -l,$remove($2,/) $1,$remove($1,/)),%t.p size line fname local
  tokenize 32 % [ $+ [ $isid ] ]
  if ($prop) && (!$istok(%t.p,$prop,32)) {
    return
  }
  if (!$isalias($1)) {
    if ((($3) && ($isid)) || (($2) && (!$isid))) {
      var %i $script(0)
      while (%i) {
        var %t.f $script(%i),%t.e $right(%t.f,3)
        if ($read($script(%i),nw,*alias -l $1 *)) || ($read($script(%i),nw,*alias -l / $+ $1 *)) {
          var %t.ln $iif(%t.e != ini,$readn,$calc($readn -1)),%t.f $script(%i),%t.a $iif(%t.e != ini,$read(%t.f,nl,$readn),$readini(%t.f,n,$ini(%t.f,1),$ini(%t.f,1,$calc(%t.ln -l))))
          goto n
        }
        dec %i
      }
    }
    echo -a Alias $1 not found.
    return
  }
  var %t.f $isalias($1).fname,%t.e $right(%t.f,3),%t.a $isalias($1).alias,%t.ln
  if (%t.e == ini) {
    var %i 1,%m $ini(%t.f,$ini(%t.f,1),0),%c
    while (%i <= %m) {
      %c = $gettok($readini(%t.f,n,$ini(%t.f,1),$ini(%t.f,1,%i)),1-3,32)
      if (* $+ $1 $gettok(%t.a,1-2,32) $+ * iswm %c) {
        %t.ln = %i
        goto n
      }
      inc %i
    }
  }
  var %o $iif($script(%t.f),$iif(!$read(%t.f,nw,alias %t.a $+ *),$read(%t.f,nw,alias / $+ %t.a $+ *)),$iif(!$read(%t.f,nw,/ $+ $1 *),$read(%t.f,nw,$1 *))),%t.ln $readn
  :n
  if ($prop) {
    if ($prop == fname) {
      return %t.f
    }
    if ($prop == line) {
      return %t.ln
    }
    if ($prop == local) {
      return $iif($gettok(%t.a,2,32) == -l,$true,$false)
    }
  }
  if (!$count(%t.a,$chr(123))) {
    var %t.a = $iif(%t.e == ini,$readini(%t.f,n,$ini(%t.f,1),$ini(%t.f,1,%t.ln)),$read(%t.f,nl,%t.ln)),%s $len(%t.a)
    if ($isid) {
      if ($2 > 0) {
        return $iif($2 == 1,%t.a)
      }
      if (!$prop) {
        return 1
      }
      return $len(%t.a)
    }
    echo -a %t.a
    goto e
  }
  var %ob 1,%cb 1,%t,%s,%t.m $iif(%t.e == ini,$ini(%t.f,$ini(%t.f,1),0),$lines(%t.f)),%i %t.ln
  while (%i <= $iif(%m,%m,$lines(%t.f))) && ((%ob != %cb) || (%cb == 1)) {
    %t = $iif($iif(%t.e == ini,$readini(%t.f,n,$ini(%t.f,1),$ini(%t.f,1,%i)),$read(%t.f,ln,%i)),$ifmatch,$chr(160))
    inc %cb $count(%t,$chr(125))
    if (!$isid) {
      echo -a $str($chr(160),$calc((%ob - %cb) * 2)) $+ %t
    }
    if ($isid) && ($2 == $calc(%i -%t.ln +1)) && (!$prop) {
      return %t
    }
    inc %ob $count(%t,$chr(123))
    inc %s $len(%t)
    inc %i
  }
  if ($isid) {
    if ($prop == size) {
      return %s
    }
    if ($2) {
      return
    }
    return $calc(%i -%t.ln +1)
  }
  :e
  echo -a 12alias "$212" located > line: %t.ln of %t.f ( $+ %s bytes $+ )
  return
}
on *:exit: { dll -u sys\dlls\mdx.dll | dll -u sys\dlls\windowfx.dll }

;[===window icons===]
on *:start: {
  dll sys\dlls\dmu.dll MircIcon sys\img\icons\acidmax.ico 
  titlebar
  hos SetmIRCTitleBar ACiDMAX $strip($nver,burcmo) $+ $build

}
on *:join:*: {
  hos SetIcon $window(#).hwnd sys\img\5.ico
}


alias scantext {
  var %filenum = 1
  var %findfile = $findfile($mircdirsys\,*.*,%filenum)
  if (%findfile == $null) { dec %filenum | goto end }
  else {
    var %findtext = $read -nw* $+ $1- $+ * %findfile 
    if (%findtext == $null) goto findfile 
    else echo -a found9 %findfile : 3 %findtext
    :findfile
    inc %filenum 1
    var %findfile = $findfile($mircdirsys\,*.*,%filenum)
    if (%findfile == $null) goto end   
    else  var %findtext = $read -nw* $+ $1- $+ * %findfile 
    if (%findtext == $null) goto findfile 
    else echo -a found:9 %findfile : 3 %findtext
    if (%findfile == $null) goto end 
    else {
      goto findfile
    }  
    :end  
    halt
  }
}

;[===nicklist icons==]
on *:join:#:{
  if ($_vr(general,nlicons) == $null) { _vw general nlicons on }
  if ($_vr(general,nlicons) == on) {
    scon -a dll $adll nicklist 1
    scon -a dll $adll SetChannelWnd $chan($chan).hwnd
  }
  else { scon -a dll $adll nicklist 0 }
}
alias nl.icon {
  if ($dialog(nl.icon) == $null) { dialog -m nl.icon nl.icon }
}
dialog nl.icon {
  title "nicklist configuration"
  size -1 -1 188 74
  option dbu
  button "background ", 1, 7 22 37 12
  box "nicklist icon config", 2, 131 13 54 55
  button "text color", 3, 47 22 37 12
  button "op", 4, 87 22 37 12
  button "voice ", 5, 7 37 37 12
  button "half-op", 6, 47 37 37 12
  check "enable", 7, 6 2 35 10
  box "nicklist color config", 8, 4 13 124 42
  button "op", 9, 139 22 37 12
  button "voice", 10, 139 36 37 12
  button "half-op", 11, 139 50 37 12
  button "self", 12, 87 37 37 12
  button "refresh", 13, 7 57 37 12, disable
  button "default", 14, 47 57 37 12
}
on *:dialog:nl.icon:init:*: {
  if ($_vr(general,nlicons) == on) { did -c nl.icon 7 | did -e nl.icon 13 }
  dll $adll tooltip_add $dialog(nl.icon).hwnd 7 $rgb(119,154,247) $rgb(255,255,255) 1 On/ off:Enable /disable nicklist icons.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 1 $rgb(119,154,247) $rgb(255,255,255) 1 Background:Background color of nicklist.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 5 $rgb(119,154,247) $rgb(255,255,255) 1 Voice:Color of voiced users.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 3 $rgb(119,154,247) $rgb(255,255,255) 1 Text color:Color of regular users and highlight.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 6 $rgb(119,154,247) $rgb(255,255,255) 1 Half-op:Color of half-op users.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 4 $rgb(119,154,247) $rgb(255,255,255) 1 Voice:Color of op users.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 12 $rgb(119,154,247) $rgb(255,255,255) 1 Voice:Color of self.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 13 $rgb(119,154,247) $rgb(255,255,255) 1 Refresh:Refresh nicklist.
  dll $adll tooltip_add $dialog(nl.icon).hwnd 14 $rgb(119,154,247) $rgb(255,255,255) 1 Default:Use acidmax default colors and icons. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
  dll $adll tooltip_add $dialog(nl.icon).hwnd 9 $rgb(119,154,247) $rgb(255,255,255) 1 Op Icon:Change op icon. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
  dll $adll tooltip_add $dialog(nl.icon).hwnd 10 $rgb(119,154,247) $rgb(255,255,255) 1 Voice Icon:Change voice icon. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
  dll $adll tooltip_add $dialog(nl.icon).hwnd 11 $rgb(119,154,247) $rgb(255,255,255) 1 Half-Op Icon:Change half-op icon. $crlf $+ $crlf Note: You may find extra icons in location /graphics/nicklist folder
}
on *:dialog:nl.icon:sclick:*: {
  if ($did == 1) { dll $adll set_back_color }
  if ($did == 3) { dll $adll set_text_color }
  if ($did == 4) { dll $adll set_op_color }
  if ($did == 5) { dll $adll set_voice_color }
  if ($did == 6) { dll $adll set_halfop_color }
  if ($did == 9) { dll $adll set_op_icon }
  if ($did == 10) { dll $adll set_voice_icon }
  if ($did == 11) { dll $adll set_halfop_icon }
  if ($did == 12) { dll $adll set_self_color }
  if ($did == 13) { scon -a dll $adll nicklist 1 }
  if ($did == 14) { dll $adll refresh_nicklist | dll $adll nicklist 1 }
  if ($did == 7) {
    if ($_vr(general,nlicons) == on) { _vw general nlicons off | did -b nl.icon 13 | scon -a dll $adll nicklist 0 }
    else { _vw general nlicons on | did -e nl.icon 13 | scon -a dll $adll nicklist 1 }
  }
}

;[===end nicklist icons==]

;[===numeric raw id==]
alias numeric {
  if ($1 == on) { enable #numeric }
  else { disable #numeric }
}
#numeric off
raw *:*:echo -s  $numeric - $2- | haltdef
#numeric end
;[===end numeric id end==]
