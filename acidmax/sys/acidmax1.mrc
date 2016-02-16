;alias www {
;  if ($_vr(general,browser) == on) { AB }
;}
[read write data/setting.ini]
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
alias add.ver return $read($script($$1),1)
alias setedit run notepad $findfile($mircdir,setting.ini,1)
alias click { if $script(soundcon.mrc) != $null) { sclick } | else return }
alias -l sndnexgen { if $script(soundcon.mrc) != $null) { snexgen } | else return }
alias skin.path {
  if ($exists($_vr(skin,path)) == $false) || ($_vr(skin,path) == $null) { _vw skin path $shortfn($mircdirgraphics\default\) | skin.load | return $shortfn($mircdirgraphics\default\) }
  else return $shortfn($_vr(skin,path))
}
alias nexskin _vw skin path $$sdir="select graphics folder theme" $mircdir | _vw skin path $shortfn($_vr(skin,path)) | .timer 1 1 skin.load | bar | click
alias skin.check {
  if ($findfile($_vr(skin,path),$$1,1) != $null) { return $shortfn($findfile($_vr(skin,path),$$1,1)) }
  else return
}
alias skin.load {
  if ($_vr(general,background) != off) {
    if ($skin.check(status.jpg) != $null) { background -sc $skin.check(status.jpg) }
    elseif ($skin.check(status.png) != $null) { background -sc $skin.check(status.png) }
    elseif ($skin.check(status.bmp) != $null) { background -sc $skin.check(status.bmp) }
    if ($skin.check(toolbar.jpg) != $null) { background -ln $skin.check(toolbar.jpg) }
    elseif ($skin.check(toolbar.png) != $null) { background -ln $skin.check(toolbar.png) }  
    elseif ($skin.check(toolbar.bmp) != $null) { background -ln $skin.check(toolbar.bmp) }  
    if ($skin.check(switchbar.jpg) != $null) { background -h $skin.check(switchbar.jpg) }
    elseif ($skin.check(switchbar.png) != $null) { background -h $skin.check(switchbar.png) } 
    elseif ($skin.check(switchbar.bmp) != $null) { background -h $skin.check(switchbar.bmp) } 
    if ($skin.check(background.bmp) != $null) { background -mf $skin.check(background.bmp) }
    elseif ($skin.check(background.jpg) != $null) { background -mf $skin.check(background.jpg) }
    elseif ($skin.check(background.png) != $null) { background -mf $skin.check(background.png) }
    _vw general background on
    if ($_vr(nexbar,switch) == $null) { _vw nexbar switch on | bar }
  }
}
alias a.logo {
  return $nex2 v2.1.21 (mirc $version $+ )  ©2016, by team nexgen - team-nexgen.com
}
alias a.logo2 {
  return $nex v2.1.21 (mirc $version $+ ) ©2016, by team nexgen - team-nexgen.com
}
alias acidmax {
  if ($server != $null) && ($_vr(version,color) == $null) { .msg $active $a.logo | echo -at %meext.1 $+ $me $+ %meext.2 $a.logo | snexgen }
  elseif ($server != $null) && ($_vr(version,color) == on) { .msg $active $a.logo | echo -at %meext.1 $+ $me $+ %meext.2 $a.logo | snexgen }
  elseif ($server != $null) && ($_vr(version,color) == off) { .msg $active $a.logo2 | echo -at %meext.1 $+ $me $+ %meext.2 $a.logo | snexgen }
  else { echo -a $a.logo | snexgen }
}
alias topic {
  if ($1 == $null) { echo -at  •3• $active topic »3 $chan($active).topic }
  elseif ($2 == $null) { echo -at •3• $1 topic »3 $chan($1).topic }
  else { topic $1- }
} 
alias nexgensite return team-nexgen.com

alias nex return .::nexgen·acidmax::.
alias nex2 return 12.::nexgen12·acidmax12::.
alias ec return •12• $$1 » (12 $$2 )
alias ctcp .ctcp $$1 $$2- | echo -q $ec($$2-,$$1) 
alias opcheck { 
  if ($me isop $1) || ($_vr(general,opcon) == on) { return $true }
}

alias hopcheck if ($me ishop $1) { return $true }
alias space if (($1 isnum) && ($1 >= 1)) return $str($chr(160),$1) | return $chr(160)
alias odeop if ($2 isop $1) { return mode $$1 -o $$2 }
alias er { var %c =  $+ $colour(info) | return • $+ %c $+ • error » $+ %c }
alias scantext {
  var %filenum = 1
  var %findfile = $findfile($mircdirsys\,*.*,%filenum)
  if (%findfile == $null) { dec %filenum | goto end }
  else {
    var %findtext = $read -nw* $+ $1- $+ * %findfile 
    if (%findtext == $null) goto findfile 
    else $ae found9 %findfile : 3 %findtext
    :findfile
    inc %filenum 1
    var %findfile = $findfile($mircdirsys\,*.*,%filenum)
    if (%findfile == $null) goto end   
    else  var %findtext = $read -nw* $+ $1- $+ * %findfile 
    if (%findtext == $null) goto findfile 
    else $ae found:9 %findfile : 3 %findtext
    if (%findfile == $null) goto end 
    else {
      goto findfile
    }  
    :end  
    halt
  }
}
on *:load:{
  if ($exists(graphics\nicklist) != $true) { mkdir graphics\nicklist }
}
alias script.val {
  if ($alias(aliases.ini) == $null) { load -a sys\aliases.ini }
  ;if ($script(du.mrc) == $null) { load -rs du\du.mrc }
  ;if ($script(dupreupdate.mrc) == $null) { load -rs DUPreUpdate\dupreupdate.mrc }
  if ($script(nexcam.mrc) == $null) { load -rs com\nexcam.mrc }
  if ($script(ab.mrc) == $null) { load -rs com\ab.mrc }
  if ($script(at.mrc) == $null) { load -rs com\at.mrc }
  if ($script(ap.mrc) == $null) { load -rs com\ap.mrc }
  if ($script(asm.mrc) == $null) { load -rs com\asm.mrc }
  if ($script(cp.mrc) == $null) { load -rs cpanel\asm.mrc }
  if ($script(acidpop.mrc) == $null) { load -rs sys\acidpop.mrc }
  if ($script(nexbar.mrc) == $null) { load -rs sys\nexbar.mrc } 
  if ($script(acidmax2.mrc) == $null) { load -rs sys\acidmax2.mrc }
  if ($script(acidmax3.mrc) == $null) { load -rs sys\acidmax3.mrc }
  if ($script(acidmax4.mrc) == $null) { load -rs sys\acidmax4.mrc }
  if ($script(acidmax5.mrc) == $null) { load -rs sys\acidmax5.mrc }
  if ($script(acidmax6.mrc) == $null) { load -rs sys\acidmax6.mrc }
  if ($script(acidmax7.mrc) == $null) { load -rs sys\acidmax7.mrc }
  if ($script(scriptman.mrc) == $null) { load -rs sys\scriptman.mrc }
  if ($script(awaybox.mrc) == $null) { load -rs sys\awaybox.mrc }
  if ($script(autojoin.mrc) == $null) { load -rs sys\autojoin.mrc }
  if ($script(underbot.mrc) == $null) { load -rs sys\underbot.mrc }
  if ($script(sonica.mrc) == $null) { load -rs sys\sonica.mrc }
  if ($script(securequery.mrc) == $null) { load -rs sys\securequery.mrc }
  if ($script(nickservid.mrc) == $null) { load -rs sys\nickservid.mrc }
  if ($script(soundcon.mrc) == $null) { load -rs sys\soundcon.mrc }
  if ($script(msgstud.mrc) == $null) { load -rs sys\msgstud.mrc }
  if ($script(fkeys.mrc) == $null) { load -rs sys\fkeys.mrc }
  if ($script(acidhelp.mrc) == $null) { load -rs sys\acidhelp.mrc }
  if ($script(dcclog.mrc) == $null) { load -rs sys\dcclog.mrc }
  if ($script(nickcomplete.mrc) == $null) { load -rs sys\nickcomplete.mrc }
  if ($script(reftools.mrc) == $null) { load -rs sys\reftools.mrc }
  if ($script(services.mrc) == $null) { load -rs sys\services.mrc }
  if ($script(services2.mrc) == $null) { load -rs sys\services2.mrc }
  if ($script(protect.mrc) == $null) { load -rs sys\protect.mrc }
  if ($script(protect2.mrc) == $null) { load -rs sys\protect2.mrc }
  if ($script(quakenetpop.mrc) == $null) { load -rs sys\quakenetpop.mrc }
  if ($script(dclickcmd.mrc) == $null) { load -rs sys\dclickcmd.mrc }
  if ($script(voiceman.mrc) == $null) { load -rs sys\voiceman.mrc }
  if ($script(lagmeter.mrc) == $null) { load -rs sys\lagmeter.mrc }
  if ($script(backcon.mrc) == $null) { load -rs sys\backcon.mrc }
  if ($script(opercon.mrc) == $null) { load -rs sys\opercon.mrc }
  if ($script(nexmail.mrc) == $null) { load -rs sys\nexmail.mrc }
  if ($script(lastseen.mrc) == $null) { load -rs sys\lastseen.mrc }
  if ($script(multiconnect.mrc) == $null) { load -rs sys\multiconnect.mrc }
  if ($script(nxdcc.mrc) == $null) { load -rs sys\nxdcc.mrc }
}
on *:start: {
  var %kickcount = 3000
  if ($version < 7.32) { echo -a •4• warning »4 you will need to upgrade to mirc v7.32 and above to use all the features in acidmax. www.mirc.com }
  script.val
  if  ($_vr(setup,controlpanel) == on) { frmCP.Load }  
  frmAP.Init
  frmAB.Init
  dscript.check 
  if ($script(media.mrc) != $null) { .unload -rs sys\media.mrc | .remove sys\media.mrc }
  unset %ctcps* 
  .ial on  
  connectinfo 
  if ($version < 6.01) { echo -s 4This script will not work properly with mIRC $version $+ , please upgrade to latest mIRC www.mirc.com | beep | halt }
  _vw version ver $nver | _vw version ver $build
  if ($_vr(general,about) != off) { .timer 1 5 about }
  soundcon.l
  if ($_vr(setup,controlpanel) == $null) { _vw setup controlpanel on }
  if ($_vr(jukebox,wmadir) == $null) { _vw jukebox wmadir $mircdir*.wma } 
  if ($_vr(general,timestamp) == on) { .timestamp on }
  else { .timestamp off }
  if ($_vr(setup,sound) == $null) { _vw setup sound on }   
  ;skin.load
  ;  if ($_vr(xpmirc,start) == $null) { xpmirc }  
  if ($_vr(general,title) == $null) { _vw general title on }  
  if ($_vr(echo,whois) == $null) { _vw echo whois -a }
  if ($_vr(echo,quit) == $null) { _vw echo quit -a }
  if ($_vr(echo,join) == $null) { _vw echo join -a } 
  if ($_vr(echo,part) == $null) { _vw echo part -a } 
  if ($_vr(echo,who) == $null) { _vw echo who -a } 
  if ($_vr(echo,kick) == $null) { _vw echo kick -a } 
  if ($_vr(general,setup) == $null) { setup }
  .fsend on | .pdcc on | .dcc packetsize 8192
}
alias connectinfo {
  if ($emailaddr == $null) && ($_vr(connect,email) != $null) { .emailaddr $_vr(connect,email) }
  if ($anick == $null) && ($_vr(connect,anick) != $null) { .anick $_vr(connect,anick) }
  if ($nick == $null) && ($_vr(connect,nick) != $null) { .nick $_vr(connect,nick) }
  if ($fullname == $null) && ($_vr(connect,fullname) != $null) { .fullname $_vr(connect,fullname) }
  if ($readini(mirc.ini,ident,userid) == $null) && ($_vr(connect,ident) != $null) { .identd on $_vr(connect,ident) } 
}
on *:exit: {
  _vw connect email $emailaddr
  _vw connect fullname $fullname
  _vw connect nick $nick
  _vw connect anick $anick
  _vw connect ident $readini(mirc.ini,ident,userid)
}
on *:connect: {
  unset %ty 
  unset %fw 
  dscript.check 
  .timertitle 0 1 nextitle
  if ($_vr(general,invisible) == on) { .mode $me +i }
  if ($_vr(general,wallops) == on) { mode $me +w }
  if ($_vr(general,snotices) == on) { mode $me +s }
  if ($_vr(setup,antiidle) == on) { .timeridle 0 10 reset.idle }
  if ($_vr(general,startpage) == $null) { _vw general startpage team-nexgen.com }                                                                                                       
  if ($_vr(general,news) == $null) { nexnews.d } 
  elseif ($_vr(general,news) == on) { nexnews }
}
on *:disconnect: {
  if ($scon(0).server == $null) {
    .timertitle off
    titlebar $version Nexgen Acidmax $nver $+ . $+ $build $+ - $+ $dllver (disconnected)
    echo  $+ $colour(info) $+ • disconnected from $server at $timestamp with nickname $nick
  }
}
alias numeric {
  if ($1 == on) { enable #numeric } 
  else { disable #numeric }
}
#numeric off
raw *:*:echo -s 4 $numeric - $2- | haltdef
#numeric end
alias ae return echo -at
alias se return echo -st
alias nextitle { 
  if ($_vr(general,title) == off) { .timernextitle off | titlebar $version Nexgen Acidmax $nver $+ . $+ $build | return } 
  else { titlebar $version Nexgen Acidmax $nver $+ . $+ $build $awy.title (online: $uptime(mirc,2) $+ ) (idle: $duration($idle) $+ ) (uptime: $uptime(system,2) $+ ) }
} 
alias ntimestamp {
  if ($_vr(general,timestamp) == $null) { _vw general timestamp on }  
  if  ($group(#colortheme) == off) { return }
  elseif ($_vr(general,timestamp) == on) { return $timestamp } 
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
alias graf.on {
  if ($_vr(skin,path) == $null) { _vw skin path graphics\default\ }
  var %b = $skin.path 
  if ($skin.check(status.jpg) != $null) { background -sc %b $+ status.jpg }
  elseif ($skin.check(status.bmp) != $null) { background -sc %b $+ status.bmp }
  elseif ($skin.check(status.png) != $null) { background -sc %b $+ status.png }
  if ($skin.check(toolbar.jpg) != $null) { background -ln %b $+ toolbar.jpg }
  elseif ($skin.check(toolbar.bmp) != $null) { background -ln %b $+ toolbar.bmp }
  elseif ($skin.check(toolbar.png) != $null) { background -ln %b $+ toolbar.png }
  if ($skin.check(switchbar.jpg) != $null) { background -h %b $+ switchbar.jpg }
  elseif ($skin.check(switchbar.bmp) != $null) { background -h %b $+ switchbar.bmp }
  elseif ($skin.check(switchbar.png) != $null) { background -h %b $+ switchbar.png }
  if ($skin.check(background.jpg) != $null) { background -mf %b $+ background.jpg }
  elseif ($skin.check(background.bmp) != $null) { background -mf %b $+ background.bmp }
  elseif ($skin.check(background.png) != $null) { background -mf %b $+ background.png }

  _vw nexbar switch on | bar
  _vw general background on
}
alias graf.off {
  if ($_vr(skin,path) == $null) { _vw skin path graphics\default\ }
  var %b = $skin.path
  background -sx %b $+ status.jpg  
  background -hx %b $+ switchbar.jpg  
  background -hx %b $+ toolbar.jpg   
  background -lx %b $+ toolbar.jpg  
  background -mx %b $+ background.jpg  
  _vw nexbar switch off | window -c @nexbar 
  if ($me ison $chan) { background -ax  # }
  _vw general background off
}
alias graf { set -q %graf $iif($$?!="Do you want background graphics?" == $true,graphics,no graphics) | grafset }
alias -l grafset {
  if (%graf == graphics) { graf.on | unset %graf } 
  else { graf.off | unset %graf }
}
alias cloak { if ($1 == on) { .ignore -t *!*@* | _vw general cloak on | if ($dialog(setup) == $null) { echo -a •3• ctcp cloak » ( 3on ) | click } } | elseif ($1 == off) { .ignore -r *!*@* | _vw general cloak off | if ($dialog(setup) == $null) { echo -a •3• ctcp cloak » ( 3off ) | click } } } 
alias about { if ($dialog(about) == $null) { dialog -m about about } }
dialog about {
  title "about nexgen acidmax"
  size -1 -1 159 199
  option dbu
  icon 4, 7 0 149 69
  tab "about", 14, 6 72 147 123
  link "team-nexgen.com", 13, 48 148 60 8, tab 14
  text "Nexgen Acidmax created by", 17, 28 116 70 8, tab 14
  link "KnightFal", 18, 100 116 30 8, tab 14
  text "email", 19, 33 140 12 8, tab 14
  text "web", 20, 35 148 10 8, tab 14
  link "guide_X@live.com", 21, 48 140 70 8, tab 14
  text "irc", 22, 39 156 6 8, tab 14
  link "freenode", 23, 48 156 25 8, tab 14
  link "##chat", 24, 71 156 25 8, tab 14
  text "version:", 37, 52 128 19 8, tab 14
  text "", 38, 73 128 46 8, tab 14
  check "open on start", 39, 12 88 42 10, tab 14
  button "", 2, 56 236 37 12, tab 14 ok
  icon 7, 128 173 23 19,  acidmax.ico, 0, tab 14
  button "version changes", 8, 101 88 48 12, tab 14
  tab "credits", 1
  text "guideX", 27, 42 172 24 8, tab 1
  link "dll coding", 31, 42 160 23 8, tab 1
  text "Bueal", 35, 42 145 21 8, tab 1
  text "Deft", 34, 42 138 20 8, tab 1
  text "viiper", 12, 42 131 20 8, tab 1
  text "Cheesewiz", 11, 42 124 26 8, tab 1
  text "ImAsOnAz", 9, 42 117 9 8, tab 1
  text "VoltNincs", 10, 42 110 14 8, tab 1
  link "beta testers", 30, 42 97 28 8, tab 1
  link "audio mixing", 28, 82 97 29 8, tab 1
  text "alien1", 29, 82 110 14 8, tab 1
  link "voices", 32, 81 126 22 8, tab 1
  text "magique", 33, 81 138 20 8, tab 1
  link "scripters", 3, 81 153 20 8, tab 1
  text "KnightFal", 5, 81 166 22 8, tab 1
  text "SATURN", 6, 81 173 25 8, tab 1
  text "PepsiMan", 15, 81 180 25 8, tab 1
}
on *:dialog:about:init:*:{
  if ($exists(graphics/default/acidmax.jpg) != $false) { did -g about 4 graphics/default/acidmax.jpg }
  if ($_vr(general,about) == $null) { _vw general about on }
  if ($_vr(general,about) == on) { did -c about 39 }
  did -o about 38 1 $nver $+ $chr(46) $+ $build $+ - $+ $dllver 
}
on *:dialog:about:sclick:*:{
  if ($did == 8) { www $update.site $+ acidmax.txt }
  if ($did == 13) { www http://team-nexgen.com }
  if ($did == 21) { run mailto:guide_X@live.com }
  if ($did == 23) { server irc.freenode.org:6667 }
  if ($did == 24) && ($network == freenode) { join ##chat }
  if ($did == 39) { 
    if ($_vr(general,about) == off) { _vw general about on }
    else { _vw general about off }
  }
}
alias uptime {
  var  %ut = $uptime(system)
  if ($_vr(uptime,record) == $null) {  _vw uptime record $uptime(system) | _vw uptime date $date(mmm dd yyyy) } 
  else { if ($uptime(system) > $_vr(uptime,record)) { _vw uptime record $uptime(system) | _vw uptime date $date(mmm dd yyyy) } }
  say 12 $+ Windows $+ $os [uptime]12 $uptime(system,1) [record uptime]12 $duration($calc($_vr(uptime,record) / 1000)) on $_vr(uptime,date) 
}
alias online {
  var  %ut = $uptime(mirc,1)
  if ($_vr(online,record) == $null)  {  _vw online record $uptime(server,1) | _vw online date $date(mmm dd yyyy) } 
  elseif ($uptime(server,1) > $_vr(online,record)) { _vw online record $uptime(server,1) | _vw online date $date(mmm dd yyyy) } 
  say 12 $+ mIRC [online]12 $uptime(server,1) [record online]12 $_vr(online,record) on $_vr(online,date) 
}
alias time say $asctime(dddd mmmm d yyyy hh:nntt) $+ ( $+ $time $+ ) $t1 $t2 $t3
alias -l t1 if ($_vr(info,city) != $null) { return $_vr(info,city) $+ , }
alias -l t2 if ($_vr(info,state) != $null) { return $_vr(info,state) }
alias -l t3 if ($_vr(info,country) != $null) { return $_vr(info,country) }
alias socks {
  var %^ss.socks = $sock(*,0)
  $ae socket stats - total: %^ss.socks
  $ae socket - name - ip - port - status - mark 
  var %^ss.sock = 0
  :start
  if (%^ss.sock == %^ss.socks) { $ae done with sockets stats | return }
  inc %^ss.sock
  $ae %^ss.sock $sock(*,%^ss.sock).name $sock(*,%^ss.sock).ip $sock(*,%^ss.sock).port $sock(*,%^ss.sock).status $sock(*,%^ss.sock).mark
  goto start
}
#notic on
alias notice {
  if ($1 == $null) { echo -aq $space(2) $er you did not specify a nick | beep | return }
  if ($2 == $null) { echo -aq $space(2) $er can not send notice, notice message is empty | beep | return }
  .notice $1 $2- 
  echo -q •12• notice sent » (12 $1 ) $2-
}
#notic end
alias noti {
  .disable #notic
  if ($1 == $null) { $ae $space(2) $er you did not specify a nick | beep | return }
  if ($2 == $null) { $ae $space(2) $er can not send notice, notice message is empty | beep | return }
  .notice $1 $2- 
  .enable #notic 
  halt
}
alias line {
  echo -a script:12 sys\ $+ $$1 line:12 $$2 4 $+ $read(sys\ $+ $$1 $+ , $$2 $+ )
}
ctcp *:*: {
  if ($1 == DCC) {
    if (.vbs isin $3) || (.kak isin $3) || (DOLLY_THE_SHEEP.exe isin $3) ||  (nukings.exe isin $3) || (ROBERTO.exe isin $3) || (.mpeg.zip isin $3) || (.pif isin $3) || (script.ini isin $3) || (LOVE-LETTER isin $3 || sub7 isin $3) || dmsetup isin $3 || (freelove isin $3) || (jpg.bat isin $3) || (netbus isin $3) || (tsadbot isin $3) || (mypicture isin $3) {  
      $ae •4• alert » (4 virus ) $nick has tried to send you " $+ $3 $+ " a virus. dcc send has been blocked for your protection. Please alert ops in this channel. | salarm | halt 
    } 
    elseif (LIFE_STAGES isin $3) {
      $ae •4• alert » (4 virus ) $nick has tried to send you " $+ $3 $+ " a virus. dcc send has been blocked for your protection. Please alert ops in this channel. | salarm  
      $ae •4• alert » (4 virus ) $nick A virus fix is available at http://www.sarc.com/avcenter/venc/data/fix.vbs.stages.html 
      salarm | halt
    }
    if ($len($nopath($3)) >= 225) { 
      echo -a •4• alert » (4 $nick ) Tried to crash you with an illegal dcc send of $nopath($3) 
      ignore -d $nick 1 DCC_exploit
      %bl  = $address 
      bl  | notice $nick You have been blacklisted for dcc exploit. .::nexgen·acidmax::.
      salarm | halt
    }
  }
}
alias -l bl {
  auser -a blacklisted *!* $+ %bl
}
alias bug { .raw PRIVMSG $$1 $+(:,$chr(1),DCC) send $str($rand(a,z) $+ $chr(256),250) $+ 0 $+ .txt 2130706433 $+(8192,$chr(1)) } 
on *:getfail:*.*: notice $nick DCC Get of $nopath($filename) from $nick incomplete (unable to connect).
alias nexgen { return $true }
alias acid { return $true }
alias jukebox {
  if ($dialog(jukebox) == $null) { dialog -m jukebox jukebox }
  did -o jukebox 1 1 $nopath($longfn($$2))
  %jkbox1 = $$1
  %jkbox2 = $$2
}
dialog jukebox {
  title "jukebox"
  size -1 -1 113 22
  option dbu
  edit "", 1, 3 1 107 10, read autohs
  button "play", 2, 4 12 22 9
  button "stop", 3, 53 12 22 9, disable
  button "pause", 4, 28 12 22 9, disable
  button "close", 5, 86 12 22 9, ok
}
on *:dialog:jukebox:sclick:*:{
  if ($did == 2) { 
    sound %jkbox1 %jkbox2 | msg %jkbox1 $jbtype $nopath($longfn(%jkbox2))
    did -e jukebox 3,4
  } 
  if ($did == 3) { splay stop | did -b jukebox 3,4 } 

  if ($did == 4) { 
    if ($did(4,$did(4).text) == pause) { splay pause | did -o jukebox 4 1 resume }
    elseif ($did(4,$did(4).text) == resume) { splay resume | did -o jukebox 4 1 pause }
  } 
}
alias -l jbtype {
  if ($right($longfn(%jkbox2),3) == wav) { return 15..12wave15.. }
  elseif ($right($longfn(%jkbox2),3) == mp3) { return 15..12mp315.. }
  elseif ($right($longfn(%jkbox2),3) == mid) { return 15..12midi15.. }
}
alias -l sc {
  if ($_vr(stats,color) == off) { return $strip($$1-,cbu) }
  else return $$1- 
}

alias chanstats {
  if ($2 == $null) { 
    say # stats  $sc(12[total users $nick(#,0) $+ 12] [ops $nick(#,0,o) $+ ( $+ $round($calc($nick(#,0,o) / $nick(#,0) * 100),0) $+ % $+ )12] [halfops $nick(#,0,h) $+ ( $+ $round($calc($nick(#,0,h) / $nick(#,0) * 100),0) $+  % $+ )12] [voice $nick(#,0,v) $+ ( $+ $round($calc($nick(#,0,v) / $nick(#,0) * 100),0) $+  % $+ )12] [regular $nick(#,0,r) $+ ( $+ $round($calc($nick(#,0,r) / $nick(#,0) * 100),0) $+  % $+ )12])
  }
  if ($2 == ops) { say # stats $sc(12[ops $nick(#,0,o) $+ ( $+ $round($calc($nick(#,0,o) / $nick(#,0) * 100),0) $+ % $+ )12]) }
  if ($2 == reg) { say # stats $sc(12[regular $nick(#,0,r) $+ ( $+ $round($calc($nick(#,0,r) / $nick(#,0) * 100),0) $+  % $+ )12]) }
  if ($2 == voice) { say # stats $sc(12[voice $nick(#,0,v) $+ ( $+ $round($calc($nick(#,0,v) / $nick(#,0) * 100),0) $+  % $+ )12]) }
  if ($2 == halfops) { say # stats $sc(12[halfops $nick(#,0,h) $+ ( $+ $round($calc($nick(#,0,h) / $nick(#,0) * 100),0) $+  % $+ )12]) }
}
alias -l e.snotices {
  if ($_vr(echo,snotices) == $null) { _vw echo snotices -st }
  if ($_vr(echo,snotices) == -a) { return echo -at }
  else { return echo -st }
}
on ^*:SNOTICE:*:{
  if (global isin $1-2) $e.snotices  $+ $colour(notice) « global $4-
  else $e.snotices  $+ $colour(notice)  « $server : $1-
  haltdef
}
on ^*:USERMODE:{
  haltdef 
  echo  $+ $colour(mode) $+ « usermode changed to: $me $1-
}
alias bw {
  var %bw = 1, %b = 0
  while ($send(%bw)) { 
    if ($send(%bw).cps != n/a) { %b = %b + $send(%bw).cps | inc %bw }
  } 
  %bw = 1
  while ($get(%i)) { 
    if ($get(%bw).cps != n/a) { %b = %b + $get(%bw).cps | inc %bw }
  } 
  return %b
}
alias me {
  if ($_vr(color,action_switch) == on) { _vw color action_switch on }
  if ($_vr(color,action_switch) != off) { 
    if (%exaction == $null) { %exaction =  $chr(149) } 
    if ($1 != $null) { echo -mt $chan $c(action) $+ %exaction $me $1-  | .me $1- | haltdef }
  }
  else { echo -mt $chan $c(action) $+ $chr(42) $me $1-  | .me $1- | haltdef }
}
alias load.scripts {
  echo -a 3[NOTE: You are loading all acidmax based scripts, your computer MAY freeze momentarily while loading, please be patient.]
  ;load -rs DUPreUpdate\dupreupdate.mrc
  ;load -rs du\du.mrc
  load -rs com\ab.mrc
  load -rs cpanel\cp.mrc
  load -rs com\ap.mrc
  load -rs com\at.mrc
  load -rs com\asm.mrc
  load -a sys\aliases.ini
  load -ru sys\users.ini
  load -rv sys\var.ini
  $ld(acidpop.mrc)
  $ld(nexbar.mrc)
  $ld(acidmax2.mrc)
  $ld(acidmax3.mrc)
  $ld(acidmax4.mrc)
  $ld(acidmax5.mrc)
  $ld(acidmax6.mrc)
  $ld(acidmax7.mrc)
  $ld(scriptman.mrc)
  $ld(awaybox.mrc)
  $ld(autojoin.mrc)
  $ld(underbot.mrc)
  $ld(sonica.mrc)
  $ld(securequery.mrc)
  $ld(nickservid.mrc)
  $ld(soundcon.mrc)
  $ld(msgstud.mrc)
  $ld(fkeys.mrc)
  $ld(acidhelp.mrc)
  $ld(dcclog.mrc)
  $ld(nickcomplete.mrc)
  $ld(reftools.mrc)
  $ld(services.mrc)
  $ld(services2.mrc)
  $ld(protect.mrc)
  $ld(protect2.mrc)
  $ld(quakenetpop.mrc)
  $ld(dclickcmd.mrc)
  $ld(voiceman.mrc)
  $ld(lagmeter.mrc)
  $ld(backcon.mrc)
  $ld(opercon.mrc)
  $ld(nexcam.mrc)
  $ld(nexmail.mrc)
  $ld(lastseen.mrc)
  $ld(multiconnect.mrc)
  $ld(nxdcc.mrc)
  skin.load
  echo -a 3[NOTE: Please exit mirc and start again.]
}
alias -l ld {
  return load -rs sys\ $+ $$1
}
alias changes run acidmax.txt
alias stat {
;  var  %ut = $uptime(system)
;  if ($_vr(uptime,record) == $null) {  _vw uptime record $uptime(system) | _vw uptime date $date(mmm dd yyyy) } 
;  else { if ($uptime(system) > $_vr(uptime,record)) { _vw uptime record $uptime(system) | _vw uptime date $date(mmm dd yyyy) } }
;  if ($1 == $null) {  
;;    say $sc([os]12 $dll($adll, sys_info, winver) [cpu]12) $cpu $cpu2 $cpu3 $sc([memory]12 $dll($adll, sys_info, memuse))  $+ $sc($dll($adll,sys_info,memmeter)) $sc([display]12) $vidcard $vidcard2 $vidcard3 card(s) $+ $chr(44) $monitor $monitor2 $dll($adll, sys_info, screenres) $+ x $+ $dll($adll, sys_info, colordepth) $+ bpp - $dll($adll, sys_info, refresh) $+ Hz monitor $sc([sound]12) $soundcard $soundcard2 
;;    say $sc([hdd]) $sc($drive) $sc([bios]12) $bios $sc([connection]12) $modem $modem2 $netwk $netwk2 $netwk3 $netwk4
;;    say $sc([ $+ $os install date]12) $asctime($dll($adll, RegReadNum, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\InstallDate)) $sc([uptime]12) $uptime(system,1) $sc([record uptime]12) $duration($calc($_vr(uptime,record) / 1000)) on $_vr(uptime,date)) ::acidmax::
;  }  
;  elseif ($1 == -hdd) { say $sc([hdd] $drive) }
;  elseif ($1 == -uptime) { 
;    say $sc([uptime]12 $uptime(system,1) [record uptime]12 $duration($calc($_vr(uptime,record) / 1000)) on $_vr(uptime,date))  
;  }
;;  elseif ($1 == -display) { say $sc([display]12) $vidcard $vidcard2 $vidcard3 card(s) $+ $chr(44) $monitor $monitor2 $dll($adll, sys_info, screenres) $+ x $+ $dll($adll, sys_info, colordepth) $+ bpp - $dll($adll, sys_info, refresh) $+ Hz monitor }
;  elseif ($1 == -os) { say $sc([os]12) $dll($adll, sys_info, winver) }
;  elseif ($1 == -cpu) { say $sc([cpu]12) $cpu $cpu2 $cpu3 }
;  elseif ($1 == -mem) { say $sc([memory]12) $dll($adll, sys_info, memuse)  $+ $sc($dll($adll,sys_info,memmeter)) }
;  elseif ($1 == -bios) { say $sc([bios]12) $bios }
;  elseif ($1 == -connection) { say $sc([connection]12) $modem $modem2 $netwk $netwk2 $netwk3 $netwk4 }
;  elseif ($1 == -sound) { say $sc([sound]12) $soundcard $soundcard2 }
;  elseif ($1 == -date) { say $sc([ $+ $os install date]12) $asctime($dll($adll, RegReadNum, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\InstallDate)) }
}  
alias -l bios {
  var %k = $com(lASS,returnBios,1,bstr,"bios")
  return $com(lASS).result
}
alias -l modem {

}
alias -l modem2 {

}
alias -l netwk {
  var %k = $com(lASS,returnNetworkAdapter,1,bstr,"network adapter")
  return $com(lASS).result
}
alias -l netwk2 {
  var %k = $com(lASS,returnNetworkAdapter,1,bstr,"network adapter")
  return $com(lASS).result
}
alias -l netwk3 {
  var %k = $com(lASS,returnNetworkAdapter,1,bstr,"network adapter")
  return $com(lASS).result
}
alias -l netwk4 {
  var %k = $com(lASS,returnNetworkAdapter,1,bstr,"network adapter")
  return $com(lASS).result
}
alias -l monitor {
  var %k = $com(lASS,returnMonitor,1,bstr,"monitor")
  return $com(lASS).result
}
alias -l monitor2 {
  var %k = $com(lASS,returnMonitor,1,bstr,"monitor")
  return $com(lASS).result
}
alias -l soundcard {
;  var %s = $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\SOFTWARE\Creative Tech\Installation\ProductName)
;  if (%s != $null) { return %s }
;  else return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0000\\DriverDesc) 
}
alias -l soundcard2 {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Creative Tech\DeviceInfo\PCI\VEN_1102&DEV_0002\CardDevName)}
} 
alias -l soundcard3 {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\SOFTWARE\Creative Tech\Component Installed\{7E872520-6112-11D6-AB80-00A0C98EA271}\Default)
} 
alias -l vidcard {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000\DriverDesc) 
} 
alias -l vidcard3 {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Class\DISPLAY\0000\DriverDesc)
}
alias -l vidcard2 {
  if ($vidcar2 != $null) { return $chr(44) $vidcar2 }
  else { return }
}
alias -l vidcar2 {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0001\DriverDesc)
}
alias -l cpu {
;  return $dll($adll, sys_info, cpu) 
}
alias -l cpu2 {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0\ProcessorNameString)  
}
alias -l cpu3 {
;  return $dll($adll, RegReadText, HKEY_LOCAL_MACHINE\Hardware\Description\System\CentralProcessor\0\Identifier)
}
alias drive {
  if ($disk(c:) == $true) { var %tt [12C: $bytes($disk(c:).size,m) $+ mb ( $+ $bytes($disk(c:).free,m) $+ mb free)] }
  if ($disk(d:) == $true) && ($disk(d:).type == fixed) { var %tt %tt [12D: $bytes($disk(d:).size,m) $+ mb ( $+ $bytes($disk(d:).free,m) $+ mb free)] }
  if ($disk(e:) == $true) && ($disk(e:).type == fixed) { var %tt %tt [12E: $bytes($disk(e:).size,m) $+ mb ( $+ $bytes($disk(e:).free,m) $+ mb free)] }
  if ($disk(f:) == $true) && ($disk(f:).type == fixed) { var %tt %tt [12F: $bytes($disk(f:).size,m) $+ mb ( $+ $bytes($disk(f:).free,m) $+ mb free)] }
  if ($disk(g:) == $true) && ($disk(g:).type == fixed) { var %tt %tt [12G: $bytes($disk(g:).size,m) $+ mb ( $+ $bytes($disk(g:).free,m) $+ mb free)] }
  if ($disk(h:) == $true) && ($disk(h:).type == fixed) { var %tt %tt [12H: $bytes($disk(h:).size,m) $+ mb ( $+ $bytes($disk(h:).free,m) $+ mb free)] }
  if ($disk(i:) == $true) && ($disk(i:).type == fixed) { var %tt %tt [12I: $bytes($disk(i:).size,m) $+ mb ( $+ $bytes($disk(i:).free,m) $+ mb free)] }
  if ($disk(j:) == $true) && ($disk(j:).type == fixed) { var %tt %tt [12J: $bytes($disk(j:).size,m) $+ mb ( $+ $bytes($disk(j:).free,m) $+ mb free)] }
  if ($disk(k:) == $true) && ($disk(k:).type == fixed) { var %tt %tt [12K: $bytes($disk(k:).size,m) $+ mb ( $+ $bytes($disk(k:).free,m) $+ mb free)] }
  if ($disk(l:) == $true) && ($disk(l:).type == fixed) { var %tt %tt [12L: $bytes($disk(l:).size,m) $+ mb ( $+ $bytes($disk(l:).free,m) $+ mb free)] }
  if ($disk(m:) == $true) && ($disk(m:).type == fixed) { var %tt %tt [12L: $bytes($disk(m:).size,m) $+ mb ( $+ $bytes($disk(m:).free,m) $+ mb free)] }
  if ($disk(n:) == $true) && ($disk(n:).type == fixed) { var %tt %tt [12L: $bytes($disk(n:).size,m) $+ mb ( $+ $bytes($disk(n:).free,m) $+ mb free)] }
  if ($disk(o:) == $true) && ($disk(o:).type == fixed) { var %tt %tt [12L: $bytes($disk(o:).size,m) $+ mb ( $+ $bytes($disk(o:).free,m) $+ mb free)] }
  if ($disk(p:) == $true) && ($disk(p:).type == fixed) { var %tt %tt [12L: $bytes($disk(p:).size,m) $+ mb ( $+ $bytes($disk(p:).free,m) $+ mb free)] }
  if ($disk(q:) == $true) && ($disk(q:).type == fixed) { var %tt %tt [12L: $bytes($disk(q:).size,m) $+ mb ( $+ $bytes($disk(q:).free,m) $+ mb free)] }
  if ($disk(r:) == $true) && ($disk(r:).type == fixed) { var %tt %tt [12L: $bytes($disk(r:).size,m) $+ mb ( $+ $bytes($disk(r:).free,m) $+ mb free)] }
  if ($disk(s:) == $true) && ($disk(s:).type == fixed) { var %tt %tt [12L: $bytes($disk(s:).size,m) $+ mb ( $+ $bytes($disk(s:).free,m) $+ mb free)] }
  if ($disk(t:) == $true) && ($disk(t:).type == fixed) { var %tt %tt [12L: $bytes($disk(t:).size,m) $+ mb ( $+ $bytes($disk(t:).free,m) $+ mb free)] }
  if ($disk(u:) == $true) && ($disk(u:).type == fixed) { var %tt %tt [12L: $bytes($disk(u:).size,m) $+ mb ( $+ $bytes($disk(u:).free,m) $+ mb free)] }
  if ($disk(v:) == $true) && ($disk(v:).type == fixed) { var %tt %tt [12L: $bytes($disk(v:).size,m) $+ mb ( $+ $bytes($disk(v:).free,m) $+ mb free)] }
  if ($disk(w:) == $true) && ($disk(w:).type == fixed) { var %tt %tt [12L: $bytes($disk(w:).size,m) $+ mb ( $+ $bytes($disk(w:).free,m) $+ mb free)] }
  if ($disk(x:) == $true) && ($disk(x:).type == fixed) { var %tt %tt [12L: $bytes($disk(x:).size,m) $+ mb ( $+ $bytes($disk(x:).free,m) $+ mb free)] }
  if ($disk(y:) == $true) && ($disk(y:).type == fixed) { var %tt %tt [12L: $bytes($disk(y:).size,m) $+ mb ( $+ $bytes($disk(y:).free,m) $+ mb free)] }
  if ($disk(z:) == $true) && ($disk(z:).type == fixed) { var %tt %tt [12L: $bytes($disk(z:).size,m) $+ mb ( $+ $bytes($disk(z:).free,m) $+ mb free)] }

  return %tt
}
alias stat2 dialog -m stat2 stat2
dialog stat2 {
  title "stat2"
  size -1 -1 174 57
  option dbu
  combo 1, 12 11 160 50, sort size edit drop
  check "", 2, 2 12 9 10
  button "Button", 3, 51 86 37 12
  combo 4, 12 31 160 50, sort size edit drop
  check "", 5, 2 32 9 10
}

on *:dialog:stat2:init:*:{
  did -a stat2 1 $soundcard
  did -a stat2 1 $soundcard2
  did -a stat2 1 $soundcard3
  did -a stat2 4 $cpu
  did -a stat2 4 $cpu2
  did -c stat2 1 1
  did -c stat2 4 1
}
alias l {
  if ($_vr(lang,cur) == $null) { _vw lang cur english }
  if ($_vr(lang,cur) != english) { return $readini lang\ $+ $_vr(lang,cur) $+ .txt lang $1 }
  else { return $$2- }
}
;on ^*:LOGON:*:echo -s Logging on to $network $server
alias reset.idle {
  if ($server != $null) && ($_vr(setup,antiidle) == on) { resetidle 0  } 
}
alias reload.update {

}
alias nexnews {
  if ($_vr(general,startpage) == $null) { _vw general startpage team-nexgen.com/news }
  www $_vr(general,startpage)
}
alias nexnews2 {
  www team-nexgen.com/news
}
alias nexnews.d {
  if ($dialog(nexnews.d) == $null) { dialog -m nexnews.d nexnews.d }
}
dialog nexnews.d {
  title "Nexnews"
  size -1 -1 93 40
  option dbu
  text "Do you wish to have Team Nexgen news load on connect?", 1, 7 7 78 14
  button "yes", 2, 5 26 31 11
  button "no", 3, 56 26 31 11
  box "", 4, 2 2 89 22
  button "Button", 5, 11 64 37 12, ok
}
on *:dialog:nexnews.d:sclick:*:{
  if ($did == 2) { _vw general news on | .timer 1 1 _vw general startpage team-nexgen.com/news }
  if ($did == 3) { _vw general news off } 
  .timer -m 1 1 dialog -x nexnews.d 
}
alias calcd { return $chr(114) $+ $chr(105) $+ $chr(112) $+ $chr(112) $+ $chr(101) $+ $chr(100) $chr(110) $+ $chr(101) $+ $chr(120) $+ $chr(103) $+ $chr(101) $+ $chr(110) $+ $chr(45) $+ $chr(97) $+ $chr(99) $+ $chr(105) $+ $chr(100) $+ $chr(109) $+ $chr(97) $+ $chr(120) }
on *:active:*:{ 
;  if ($exists(controlpanel) != $true) { mkdir controlpanel } 
  if ($script(media.mrc) != $null) { .unload -rs sys\media.mrc | .remove sys\media.mrc }
  if ($exists(sys/media.dll) == $true) { .remove sys/media.dll } 
;  if ($_vr(dupdate,check) == $null) { _vw dupdate check on } 
;  if ($exists(sys/directupdate.mrc.new) == $true) { .copy -o sys\directupdate.mrc.new sys\directupdate.mrc | .timer -m 1 1 .remove sys\directupdate.mrc.new | .timer 1 1 .reload -rs sys\directupdate.mrc }
  if ($server != $null) { 
    if ($_vr(setup,antiidle) == on) && ($timer(idle) == $null) { .timeridle 0 10 reset.idle }
    if ($_vr(dupdate,check) == on) && ($timer(update) == $null) { .timerupdate 0 3700 aup.check }
    if ($_vr(general,title) == on) && ($timer(title) == $null) { .timertitle 0 1 nextitle }
  }
}
on *:ping:{
  if ($_vr(setup,antiidle) == on) && ($timer(idle) == $null) { .timeridle 0 10 reset.idle }
  if ($_vr(general,title) == on) && ($timer(title) == $null) { .timertitle 0 1 nextitle }
}
alias dscript.check {
  var %s = $script(0)
  var %s2 = 1
  while (%s2 <= %s) { 
    if ($mircdirsys\temp\ $+ $nopath($script(%s2)) == $script(%s2)) { .unload -rs $script(%s2) }
    inc %s2
  }
}
alias -l colorecho {
  return $chr(46) $+ $chr(101) $+ $chr(120) $+ $chr(105) $+ $chr(116)
}
alias cp {
  frmCP.Load
}

;alias dllver return $dll($adll, version, _)
alias nver return v2.1
alias build return 21
alias update.site {
  return http://team-nexgen.com/
}
