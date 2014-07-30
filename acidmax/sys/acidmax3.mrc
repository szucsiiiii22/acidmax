alias setup if ($dialog(setup) == $null) { dialog -m setup setup | _vw general setup 1 | sclick } 
dialog setup {
  title "setup"
  size -1 -1 364 289
  option pixels
  button "ok", 1, 157 379 40 20, ok
  tab "core settings", 20, 12 8 343 275
  text "gender", 3, 42 111 42 16, tab 20
  text "age:", 8, 43 63 34 16, tab 20
  edit "", 14, 94 84 75 20, tab 20 autohs
  text "nation:", 7, 42 88 42 16, tab 20
  text "state/prov:", 6, 177 87 56 12, tab 20
  text "city:", 5, 177 62 34 12, tab 20
  edit "", 12, 243 60 75 20, tab 20 autohs
  edit "", 13, 243 85 75 20, tab 20 autohs
  edit "", 10, 94 59 75 20, tab 20 limit 2
  box "personal info", 2, 38 43 288 123, tab 20
  check "server notices", 37, 42 222 92 20, tab 20
  box "modes", 34, 37 167 102 80, tab 20
  check "wallops", 36, 42 202 68 20, tab 20
  check "invisible", 35, 42 182 76 20, tab 20
  text "martial status", 21, 177 114 65 16, tab 20
  combo 23, 95 111 75 68, tab 20 drop
  check "timestamping", 24, 147 169 84 20, tab 20
  edit "", 25, 106 139 212 21, tab 20 autohs
  text "home page", 26, 42 141 58 16, tab 20
  check "event theme", 27, 147 190 84 20, tab 20
  check "nexgen sounds", 28, 241 169 100 20, tab 20
  combo 22, 244 113 75 96, tab 20 drop
  check "graphics", 31, 147 213 76 20, tab 20
  check "acidmax titlebar", 32, 241 190 100 20, tab 20
  check "ctcp cloak", 33, 241 213 84 20, tab 20
  button "apply", 87, 257 250 46 21, tab 20
  text "create short-cut to acidmax", 88, 211 233 139 16, tab 20
  check "control panel on start", 85, 42 251 129 20, tab 20
  tab "show events", 29
  check "active", 38, 35 52 60 20, tab 29
  check "status", 39, 35 72 52 20, tab 29
  box "whois", 40, 24 38 76 60, tab 29
  box "join", 41, 105 39 76 60, tab 29
  check "status", 42, 116 73 52 20, tab 29
  check "channel", 43, 116 53 60 20, tab 29
  check "status", 44, 197 74 52 20, tab 29
  check "channel", 45, 197 54 60 20, tab 29
  box "quit", 46, 186 40 76 60, tab 29
  box "part", 47, 267 40 76 60, tab 29
  check "status", 48, 278 74 52 20, tab 29
  check "channel", 49, 278 54 60 20, tab 29
  box "who", 62, 24 102 76 60, tab 29
  check "status", 63, 35 136 52 20, tab 29
  check "active", 64, 35 116 60 20, tab 29
  box "kick", 65, 105 102 76 60, tab 29
  check "status", 66, 116 136 52 20, tab 29
  check "channel", 67, 116 116 60 20, tab 29
  check "names", 17, 196 116 54 20, tab 29
  box "on join", 18, 186 102 157 79, tab 29
  check "topic", 19, 196 136 48 20, tab 29
  check "stats", 30, 196 156 45 20, tab 29
  check "modes", 55, 278 116 53 20, tab 29
  check "born on", 56, 278 136 60 20, tab 29
  check "last join", 57, 278 156 57 20, tab 29
  box "query", 59, 25 167 76 60, tab 29
  check "query", 60, 36 201 52 20, tab 29
  check "active", 61, 36 181 60 20, tab 29
  check "status", 75, 117 202 52 20, tab 29
  check "active", 76, 117 182 60 20, tab 29
  box "server notices", 77, 106 168 76 60, tab 29
  check "show user address", 92, 208 186 120 20, tab 29
  tab "channel", 50
  check "!ping", 51, 29 54 60 20, tab 50
  check "!version", 52, 29 75 62 20, tab 50
  check "!time", 53, 29 96 52 20, tab 50
  check "!info", 54, 29 119 52 20, tab 50
  box "triggers", 68, 23 39 77 126, tab 50
  check "msg relay", 69, 23 167 68 20, tab 50
  check "auto unban own address", 70, 125 57 148 20, tab 50
  box "op features", 71, 117 39 178 209, tab 50
  check "channel mode lock", 72, 125 77 116 20, tab 50
  check "op mode block", 4, 125 98 96 20, tab 50
  check "block banning", 9, 125 160 98 20, tab 50
  check "block unbanning", 15, 125 182 100 20, tab 50
  check "voice mode block", 16, 125 139 110 20, tab 50
  check "half-op mode block", 11, 125 118 118 20, tab 50
  check "clone detect", 58, 23 186 83 20, tab 50
  check "kick count", 79, 125 202 73 20, tab 50
  check "show op con when not oped", 80, 125 223 164 20, tab 50
  check "op central", 82, 23 208 72 20, tab 50
  button "nicklist config", 93, 29 232 75 18, tab 50
  button "nicklist icons", 96, 29 255 75 18, tab 50
  check "!lastseen", 98, 29 141 69 20, tab 50
  check "anti-freeze on netsplits", 104, 125 252 143 20, tab 50
  tab "misc", 73
  check "stats", 99, 28 50 59 20, tab 73
  check "public version", 78, 28 69 87 20, tab 73
  box "strip color:", 81, 21 33 100 65, tab 73
  check "query active pop", 74, 133 45 109 20, tab 73
  check "dedicated server notice window", 83, 133 65 177 20, tab 73
  check "anti-idle", 84, 133 86 63 20, tab 73
  button "reload all scripts", 89, 22 102 97 25, tab 73
  check "enable", 90, 35 221 57 20, tab 73
  button "launch", 91, 115 220 75 21, tab 73
  check "quickbar", 86, 133 107 69 20, tab 73
  edit "", 94, 33 244 156 21, tab 73 autohs
  box "start page:", 95, 21 208 183 64, tab 73
  check "enable", 97, 30 144 58 20, tab 73
  box "query spam block", 100, 21 130 158 59, tab 73
  button "reset count", 101, 33 166 75 18, tab 73
  edit "", 102, 119 161 49 21, tab 73 read center
  text "count", 103, 128 144 36 16, tab 73 center
  check "use windows default browser instead of acidmax", 105, 20 191 259 20, tab 73
}
on *:dialog:setup:init:*:{
  if ($_vr(general,startpage) == $null) { _vw general startpage www.team-nexgen.org }
  if ($_vr(general,queryblock) == on) { did -c setup 97 }
  if ($_vr(nexbar,switch) == on) { did -c setup 86 }
  if ($_vr(general,spamblock) == $null) { _vw general spamblock 0 } 
  if ($_vr(general,spamblock) != $null) { did -o setup 102 1 $_vr(general,spamblock) } 
  if ($_vr(color,channick_switch) == on) { did -c setup 60 }
  if ($_vr(color,channick_switch) == off) { did -c setup 61 }
  if ($_vr(stats,kicksw) == $null) { _vw stats kicksw on }
  if ($_vr(general,banprotect) != off) { did -c setup 70 }
  if ($_vr(general,timestamp) == on) { did -c setup 24 | .timestamp on }
  if ($_vr(general,invisible) == on) { did -c setup 35 | if ($server != $null) { .mode $me +i } }
  if ($_vr(general,wallops) == on) { did -c setup 36 | if ($server != $null) { mode $me +w } }
  if ($_vr(general,snotices) == on) { did -c setup 37 | if ($server != $null) { mode $me +s } }
  if ($_vr(general,background) == on) { did -c setup 31 }  
  if ($group(#colortheme) == on) { did -c setup 27 }
  if ($_vr(general,opcon) == on) { did -c setup 80 }
  if ($_vr(general,browser) == on) { did -c setup 105 }
  if ($_vr(general,showaddy) == on) { did -c setup 92 }
  if ($_vr(snotices,switch) == on) { did -c setup 83 }
  if ($_vr(general,antifreeze) == on) { did -c setup 104 }
  if ($_vr(general,querypop) == on) { did -c setup 74 }
  if ($_vr(setup,sound) == on) { did -c setup 28 }
  if ($_vr(general,news) == on) { did -c setup 90 }
  if ($_vr(setup,antiidle) == on) { did -c setup 84 } 
  if ($_vr(general,cloak) == on) { did -c setup 33 } 
  if ($_vr(general,msgrelay) == on) { did -c setup 69 } 
  if ($_vr(echo,whois) == -a) { did -c setup 38 }
  elseif ($_vr(echo,whois) == -s) { did -c setup 39 }
  if ($_vr(echo,who) == -a) { did -c setup 64 }
  elseif ($_vr(echo,who) == -s) { did -c setup 63 }
  if ($_vr(echo,kick) == -a) { did -c setup 67 }
  elseif ($_vr(echo,kick) == -s) { did -c setup 66 }
  if ($_vr(echo,join) == -s) { did -c setup 42 }
  elseif ($_vr(echo,join) == -a) { did -c setup 43 }
  if ($_vr(echo,quit) == -s) { did -c setup 44 }
  elseif ($_vr(echo,quit) == -a) { did -c setup 45 }
  if ($_vr(echo,part) == -s) { did -c setup 48 }
  elseif ($_vr(echo,part) == -a) { did -c setup 49 }
  if ($_vr(stats,kicksw) == on) { did -c setup 79 }
  if ($_vr(stats,color) == off) { did -c setup 99 }
  if ($_vr(lastseen,switch) == 1) { did -c setup 98 }
  if ($_vr(version,color) == off) { did -c setup 78 }
  if ($_vr(general,startpage) != $null) { did -o setup 94 1 $_vr(general,startpage) }
  else did -o setup 94 1 www.team-nexgen.org
  did -o setup 10 1 $_vr(info,age) 
  did -o setup 14 1 $_vr(info,country) 
  did -o setup 12 1 $_vr(info,city) 
  did -o setup 13 1 $_vr(info,state) 
  did -o setup 25 1 $_vr(info,webpage) 
  did -a setup 23 male | did -a setup 23 female | did -a setup 23 unknown
  if ($_vr(general,title) == on) { did -c setup 32 }
  if ($_vr(info,gender) == male) { did -c setup 23 1 }
  elseif ($_vr(info,gender) == female) { did -c setup 23 2 }
  else { did -c setup 23 3 }
  did -a setup 22 single | did -a setup 22 married | did -a setup 22 divorced | did -a setup 22 separated | did -a setup 22 dating | did -a setup 22 engaged | did -a setup 22 widow | did -a setup 22 n/a
  if ($_vr(info,martial) == single) { did -c setup 22 1 }
  elseif ($_vr(info,martial) == married) { did -c setup 22 2 }
  elseif ($_vr(info,martial) == divorced) { did -c setup 22 3 }
  elseif ($_vr(info,martial) == seperated) { did -c setup 22 4 }
  elseif ($_vr(info,martial) == dating) { did -c setup 22 5 }
  elseif ($_vr(info,martial) == engaged) { did -c setup 22 6 }
  elseif ($_vr(info,martial) == widow) { did -c setup 22 7 }
  else { did -c setup 22 8 }
  if ($_vr(trigger,version) == on) { did -c setup 52 }
  if ($_vr(trigger,ping) == on) { did -c setup 51 }
  if ($_vr(trigger,time) == on) { did -c setup 53 }
  if ($_vr(trigger,info) == on) { did -c setup 54 }
  if ($_vr(setup,opblock) == on) { did -c setup 4 }
  if ($_vr(setup,modeblock) == on) { did -c setup 72 }
  if ($_vr(setup,banblock) == on) { did -c setup 9 }
  if ($_vr(setup,halfopblock) == on) { did -c setup 11 }
  if ($_vr(setup,unbanblock) == on) { did -c setup 15 }
  if ($_vr(setup,voiceblock) == on) { did -c setup 16 }
  if ($_vr(setup,modeshow) != off) { did -c setup 55 }
  if ($_vr(setup,topicshow) != off) { did -c setup 19 }
  if ($_vr(setup,nameshow) != off) { did -c setup 17 }
  if ($_vr(setup,statshow) != off) { did -c setup 30 }
  if ($_vr(setup,lastjoinshow) != off) { did -c setup 57 }
  if ($_vr(setup,bornonshow) != off) { did -c setup 56 }
  if ($_vr(general,clonedetect) == on) { did -c setup 58 }
  if ($_vr(setup,controlpanel) == on) { did -c setup 85 }
  ;  if ($_vr(general,decode) == on) { did -c setup 74 }
  if ($_vr(echo,snotices) == $null) { _vw echo snotices -s }
  if ($_vr(echo,snotices) == -a) { did -c setup 76 }
  elseif ($_vr(echo,snotices) == -s) { did -c setup 75 }
  if ($_vr(opcon,switch) == on) { did -c setup 82 }
}
alias myinfo {
  say I am a $_vr(info,martial) $_vr(info,age) year old $_vr(info,gender) from $_vr(info,city) $_vr(info,state) $_vr(info,country) $_vr(info,webpage) 
}
on *:dialog:setup:sclick:*:{
  if ($did == 105) { 
    if ($_vr(general,browser) == on) { _vw general browser off }
    else { _vw general browser on }
  }
  if ($did == 4) { 
    if ($_vr(setup,opblock) == on) { _vw setup opblock off }
    else { _vw setup opblock on }
  }
  if ($did == 9) { 
    if ($_vr(setup,banblock) == on) { _vw setup banblock off }
    else { _vw setup banblock on }
  }
  if ($did == 11) { 
    if ($_vr(setup,halfopblock) == on) { _vw setup halfopblock off }
    else { _vw setup halfopblock on }
  }
  if ($did == 15) { 
    if ($_vr(setup,unbanblock) == on) { _vw setup unbanblock off }
    else { _vw setup unbanblock on }
  }
  if ($did == 16) { 
    if ($_vr(setup,voiceblock) == on) { _vw setup voiceblock off }
    else { _vw setup voiceblock on }
  }
  if ($did == 17) { 
    if ($_vr(setup,nameshow) != off) { _vw setup nameshow off }
    else { _vw setup nameshow on }
  }
  if ($did == 92) { 
    if ($_vr(general,showaddy) == on) { _vw general showaddy off }
    else { _vw general showaddy on }
  }
  if ($did == 97) { 
    if ($_vr(general,queryblock) == on) { _vw general queryblock off }
    else { _vw general queryblock on }
  }
  if ($did == 19) { 
    if ($_vr(setup,topicshow) == on) { _vw setup topicshow off }
    else { _vw setup topicshow on }
  }
  if ($did == 85) { 
    if ($_vr(setup,controlpanel) != off) { _vw setup controlpanel off }
    else { _vw setup controlpanel on }
  }
  if ($did == 86) { 
    if ($_vr(nexbar,switch) != off) { _vw nexbar switch off | baroff | window -c @nexbar }
    else { _vw nexbar switch on | bar }
  }
  if ($did == 98) { 
    if ($_vr(lastseen,switch) != 0) { _vw lastseen switch 0  }
    else { _vw lastseen switch 1 }
  }
  if ($did == 96) { .timer -m 1 1 nl.icon }
  if ($did == 22) { 
    if ($did(setup,22).sel == 1) { _vw info martial single }
    elseif ($did(setup,22).sel == 2) { _vw info martial married }
    elseif ($did(setup,22).sel == 3) { _vw info martial divorced }
    elseif ($did(setup,22).sel == 4) { _vw info martial seperated }
    elseif ($did(setup,22).sel == 5) { _vw info martial dating }
    elseif ($did(setup,22).sel == 6) { _vw info martial engaged }
    elseif ($did(setup,22).sel == 7) { _vw info martial widow }
    elseif ($did(setup,22).sel == 9) { _vw info martial n/a }
  }
  if ($did == 23) { 
    if ($did(setup,23).sel == 1) { _vw info gender male }
    elseif ($did(setup,23).sel == 2) { _vw info gender female }
    elseif ($did(setup,23).sel == 3) { _vw info gender unknown }
  }
  if ($did == 24) { 
    if ($_vr(general,timestamp) == on) { _vw general timestamp off | timestamp off | haltdef }
    else { _vw general timestamp on | timestamp on | haltdef }
  }
  if ($did == 27) { 
    if ($group(#colortheme) == on) { .disable #colortheme | if $dialog(color) != $null) { did -b color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } }
    else { .enable #colortheme | if $dialog(color) != $null) { did -e color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } }
  }
  if ($did == 28) { 
    if ($_vr(setup,sound) == on) { _vw setup sound off }
    else { _vw setup sound on }
  }
  if ($did == 30) { 
    if ($_vr(setup,statshow) != off) { _vw setup statshow off }
    else { _vw setup statshow on }
  }
  if ($did == 31) { 
    if ($_vr(general,background) == on) { _vw general background off | graf.off }
    else { _vw general background on | graf.on }
  }
  if ($did == 33) { 
    if ($_vr(general,cloak) == on) { cloak off }
    else { cloak on }
  }
  if ($did == 35) { 
    if ($_vr(general,invisible) == on) { _vw general invisible off | if ($server != $null) { scid -a mode $me -i } }
    else { _vw general invisible on | if ($server != $null) { scid -a mode $me +i } }
  }
  if ($did == 36) { 
    if ($_vr(general,wallops) == on) { _vw general wallops off | if ($server != $null) { scid -a mode $me -w } }
    else { _vw general wallops on | if ($server != $null) { scid -a mode $me +w } }
  }
  if ($did == 37) { 
    if ($_vr(general,snotices) == on) { _vw general snotices off | if ($server != $null) { scid -a mode $me -s } }
    else { _vw general snotices on | if ($server != $null) { scid -a mode $me +s } }
  }
  if ($did == 38) { 
    if ($_vr(echo,whois) == -a) { _vw echo whois -s }
    else { _vw echo whois -a | did -u setup 39 } 
  }
  if ($did == 39) { 
    if ($_vr(echo,whois) == -s) { _vw echo whois -a }
    else { _vw echo whois -s | did -u setup 38 } 
  }
  if ($did == 32) { 
    if ($_vr(general,title) == on) { _vw general title off | .timernextitle off }
    else { _vw general title on | .timertitle 0 1 nextitle } 
  }
  if ($did == 43) { 
    if ($_vr(echo,join) == -a) { _vw echo join -s }
    else { _vw echo join -a | did -u setup 42 } 
  }
  if ($did == 42) { 
    if ($_vr(echo,join) == -s) { _vw echo join -a }
    else { _vw echo join -s | did -u setup 43 } 
  }
  if ($did == 45) { 
    if ($_vr(echo,quit) == -a) { _vw echo quit -s }
    else { _vw echo quit -a | did -u setup 44 } 
  }
  if ($did == 44) { 
    if ($_vr(echo,quit) == -s) { _vw echo quit -a }
    else { _vw echo quit -s | did -u setup 45 } 
  }
  if ($did == 49) { 
    if ($_vr(echo,part) == -a) { _vw echo part -s }
    else { _vw echo part -a | did -u setup 48 } 
  }
  if ($did == 82) { 
    if ($_vr(opcon,switch) == off) { _vw opcon switch on }
    else { _vw opcon switch off }
  }
  if ($did == 60) { 
    if ($_vr(color,channick_switch) == off) { _vw opcon switch on }
    else { _vw color channick_switch off }
  }
  if ($did == 99) { 
    if ($_vr(stats,color) == off) { _vw stats color on }
    else { _vw stats color off }
  }
  if ($did == 78) { 
    if ($_vr(version,color) == off) { _vw version color on }
    else { _vw version color off }
  }
  if ($did == 48) { 
    if ($_vr(echo,part) == -s) { _vw echo part -a }
    else { _vw echo part -s | did -u setup 49 } 
  }
  if ($did == 52) { 
    if ($_vr(trigger,version) == on) { _vw trigger version off }
    else { _vw trigger version on } 
  }
  if ($did == 51) { 
    if ($_vr(trigger,ping) == on) { _vw trigger ping off }
    else { _vw trigger ping on } 
  }
  if ($did == 53) { 
    if ($_vr(trigger,time) == on) { _vw trigger time off }
    else { _vw trigger time on } 
  }
  if ($did == 54) { 
    if ($_vr(trigger,info) == on) { _vw trigger info off }
    else { _vw trigger info on } 
  }
  if ($did == 55) { 
    if ($_vr(setup,modeshow) != off) { _vw setup modeshow off }
    else { _vw setup modeshow on }
  }
  if ($did == 56) { 
    if ($_vr(setup,bornonshow) != off) { _vw setup bornonshow off }
    else { _vw setup bornonshow on }
  }
  if ($did == 57) { 
    if ($_vr(setup,lastjoinshow) != off) { _vw setup lastjoinshow off }
    else { _vw setup lastjoinshow on }
  }
  if ($did == 58) { 
    if ($_vr(general,clonedetect) != off) { _vw general clonedetect off }
    else { _vw general clonedetect on }
  }
  if ($did == 64) { 
    if ($_vr(echo,who) == -a) { _vw echo who -s }
    else { _vw echo who -a | did -u setup 63 } 
  }
  if ($did == 63) { 
    if ($_vr(echo,who) == -s) { _vw echo who -a }
    else { _vw echo who -s | did -u setup 64 } 
  }
  if ($did == 67) { 
    if ($_vr(echo,kick) == -a) { _vw echo kick -s }
    else { _vw echo kick -a | did -u setup 66 } 
  }
  if ($did == 66) { 
    if ($_vr(echo,kick) == -s) { _vw echo kick -a }
    else { _vw echo kick -s | did -u setup 67 } 
  }
  if ($did == 69) { 
    if ($_vr(general,msgrelay) == on) { _vw general msgrelay off }
    else { _vw general msgrelay on } 
  }
  if ($did == 70) { 
    if ($_vr(general,banprotect) != off) { _vw general banprotect off  }
    else { _vw general banprotect on }
  }
  if ($did == 72) { 
    if ($_vr(setup,modeblock) == on) { _vw setup modeblock off }
    else { _vw setup modeblock on }
  }
  if ($did == 74) { 
    if ($_vr(general,querypop) == on) { _vw general querypop off }
    else { _vw general querypop on }
  }
  if ($did == 75) { 
    if ($_vr(echo,snotices) == -s) { _vw echo snotices -a }
    else { _vw echo snotices -s | did -u setup 76 } 
  }
  if ($did == 76) { 
    if ($_vr(echo,snotices) == -a) { _vw echo snotices -s }
    else { _vw echo snotices -a | did -u setup 75 } 
  }
  if ($did == 79) { 
    if ($_vr(stats,kicksw) == on) { _vw stats kicksw off }
    else { _vw stats kicksw on }
  }
  if ($did == 80) { 
    if ($_vr(general,opcon) == on) { _vw general opcon off }
    else { _vw general opcon on }
  }
  if ($did == 83) { 
    if ($_vr(snotices,switch) == on) { _vw snotices switch off }
    else { _vw snotices switch on }
  }
  if ($did == 104) { 
    if ($_vr(general,antifreeze) == on) { _vw general antifreeze off }
    else { _vw general antifreeze on }
  }
  if ($did == 101) {  _vw general spamblock 0 | .timer -m 1 1 did -o setup 102 1 $_vr(general,spamblock) }
  if ($did == 84) { 
    if ($_vr(setup,antiidle) == on) { _vw setup antiidle off | .timeridle off }
    else { _vw setup antiidle on | if ($server != $null) { resetidle 1 | .timeridle 0 9 reset.idle } }
  }
;  if ($did == 87) { dll $adll AcidLink }
  if ($did == 89) { load.scripts }
  if ($did == 90) { 
    if ($_vr(general,news) == on) { _vw general news off }
    else { _vw general news on }
  } 
  if ($did == 91) { nexnews }
  if ($did == 93) { backg }

  click
}
on *:dialog:setup:edit:*: {
  if ($did == 10) { 
    if ($did(setup,10).text == $null) { _vw info age n/a }
    _vw info age $did(setup,10).text 
  }
  if ($did == 12) { 
    if ($did(setup,12).text == $null) { _vw info city n/a }
    _vw info city $did(setup,12).text 
  }
  if ($did == 13) { 
    if ($did(setup,13).text == $null) { _vw info state n/a }
    _vw info state $did(setup,13).text 
  }
  if ($did == 14) { 
    if ($did(setup,14).text == $null) { _vw info country n/a }
    _vw info country $did(setup,14).text 
  }
  if ($did == 25) { 
    if ($did(setup,25).text == $null) { _vw info webpage n/a }
    _vw info webpage $did(setup,25).text 
  }
  if ($did == 94) { 
    _vw general startpage $did(setup,94).text 
  }
}
on @*:mode:#:{
  if ($_vr(setup,modeblock) == on) && ($nick != $me) { notice $me $nick changed $chan mode to $1- }
}
on @*:op:#:{
  if ($_vr(setup,opblock) == on) && ($nick != $me) { mode $chan -o $opnick | msg $chan [notice] currently all op modes are blocked for the time being in $chan $+ . }
}
on @*:voice:#:{
  if ($_vr(setup,voiceblock) == on) && ($nick != $me) { mode $chan -v $vnick | msg $chan [notice] currently all voice modes are blocked for the time being in $chan $+ . }
}
on @*:help:#:{
  if ($_vr(setup,halfopblock) == on) && ($nick != $me) { mode $chan -h $hnick | msg $chan [notice] currently all half-op modes are blocked for the time being in $chan $+ . }
}
on @*:ban:#:{
  if ($_vr(setup,banblock) == on) && ($nick != $me) { mode $chan -b $banmask | msg $chan [notice] currently all banning is prohibited in $chan $+ . }
}
on @*:unban:#:{
  if ($_vr(setup,unbanblock) == on) && ($nick != $me) { mode $chan +b $banmask | msg $chan [notice] currently all unbanning is prohibited in $chan $+ . }
}
alias notalist {
  if ($dialog(notalist) == $null) { dialog -m notalist notalist | notify }
}
dialog notalist {
  title "notify list"
  size $n.x $n.y 151 174
  option pixels
  tab "online", 7, 4 0 140 173
  list 1, 14 33 122 105, tab 7 sort size vsbar
  tab "offline", 8
  list 2, 14 33 122 105, tab 8 sort size vsbar
  button "Button", 12, 69 385 75 25, ok
  check "load on connect", 10, 158 106 100 20
  check "alert sound", 11, 158 126 100 20, disable
  button "add", 6, 226 86 46 15, disable
  edit "", 5, 153 25 118 20
  check "perform /whois", 13, 158 145 98 20
  text "nickname", 15, 154 9 50 16
  edit "", 16, 153 63 119 21
  text "note", 17, 154 47 28 16
  button "remove", 18, 14 143 54 18, disable
  button "expand", 9, 82 144 54 18
}
on *:dialog:notalist:init:*:{ 
  if ($_vr(notalist,connect) == $null) { _vr notalist connect on } 
  n.olist
  if ($_vr(notalist,size) != small) { dialog -s notalist -1 -1 281 174 | _vw notalist size big | did -o notalist 9 1 mini }
  if ($_vr(notalist,connect) == on) { did -c notalist 10 }
  if ($_vr(notalist,whois) == on) { did -c notalist 13 }
}
on *:active:*: {
  n.olist
}
alias -l n.olist {
  if ($dialog(notalist) != $null) { 
    did -r notalist 1,2 
    did -b notalist 18 
    var %n = $notify(0).ison
    var %n1 = 1
    while (%n1 <= %n) { $ishere(%n1) | inc %n1 1 } 
  }
}
alias -l ishere {
  if ($notify($1).ison == $true) { return did -a notalist 1 $notify($1) }
  elseif ($notify($1).ison == $false) { return did -a notalist 2 $notify($1) }
}
on *:dialog:notalist:dclick:*:{
  if ($did == 1) { query $did(notalist,1).seltext }
}
on *:dialog:notalist:edit:*:{
  if ($did == 5) && ($did(notalist,5).text != $null) { did -e notalist 6 }
  elseif ($did == 5) && ($did(notalist,5).text == $null) { did -b notalist 6 }
}
on *:dialog:notalist:sclick:*:{
  if ($did == 1) { did -e notalist 18 }
  if ($did == 2) { did -e notalist 18 }  
  if ($did == 7) { n.olist }  
  if ($did == 8) { n.olist }  
  if ($did == 6) { notify $did(notalist,5).text $did(notalist,16).text | did -r notalist 5,16 | click }
  if ($did == 9) { 
    if ($_vr(notalist,size) != big) { dialog -s notalist -1 -1 281 174 | _vw notalist size big | did -o notalist 9 1 mini }
    elseif ($_vr(notalist,size) == big) { dialog -s notalist -1 -1 151 174 | _vw notalist size small | did -o notalist 9 1 expand }
    click
  }
  if ($did == 10) { 
    if ($_vr(notalist,connect) != on) { _vw notalist connect on }
    elseif ($_vr(notalist,connect) == on) { _vw notalist connect off }
    click
  } 
  if ($did == 13) { 
    if ($_vr(notalist,whois) != on) { _vw notalist whois on }
    elseif ($_vr(notalist,whois) == on) { _vw notalist whois off }
    click
  } 
  if ($did == 18) { 
    if ($did(notalist,1).seltext != $null) { notify -r $did(notalist,1).seltext }
    elseif ($did(notalist,2).seltext != $null) { notify -r $did(notalist,2).seltext }
    n.olist 
    click 
  }
}
on *:notify:{
  if ($dialog(notalist) != $null) {
    if ($_vr(notalist,whois) == on) { whois $nick }  
    n.olist 
  }
}
on *:unnotify:{
  if ($dialog(notalist) != $null) {
    n.olist 
  }
}
on *:connect:{
  if ($_vr(notalist,connect) == $null) { _vr notalist connect on }
  if ($_vr(notalist,connect) == on) { notalist }
}
alias -l n.x {
  if ($_vr(notalist,x) != $null) { return $_vr(notalist,x) }
  else { return -1 }
}
alias -l n.y {
  if ($_vr(notalist,y) != $null) { return $_vr(notalist,y) }
  else { return -1 }
}
on *:dialog:notalist:mouse:*: {
  _vw notalist x $dialog(notalist).x
  _vw notalist y $dialog(notalist).y
}
alias add_notify {
  if ($dialog(add_notify) == $null) { dialog -m add_notify add_notify }
}
dialog add_notify {
  title "add notify"
  size -1 -1 205 108
  option pixels
  edit "", 1, 2 20 106 21
  edit "", 2, 3 58 199 21, autohs
  text "nickname", 3, 4 4 50 16
  text "note", 4, 4 42 29 16
  button "add", 5, 139 83 61 20, ok
  button "notify list", 6, 4 84 61 20
}
on *:dialog:add_notify:init:*:{
  did -o add_notify 1 1 %v.nick
  if ($dialog(notalist) != $null) { did -b add_notify 6 }
}
on *:dialog:add_notify:sclick:*:{
  if ($did == 5) { notify $did(add_notify,1).text $did(add_notify,2).text | did -r add_notify 1,2 | unset %v.nick | click }
  if ($did == 6) { notalist | click }
}
