alias trans translate
alias translate { 
  if ($dialog(translate) == $null) { dialog -m translate translate } 
  sockclose translate 
  if $1 != $null { sockopen translate www.systranlinks.com 80 }
}
dialog translate {
  title "translator"
  size -1 -1 406 141
  option pixels
  edit "", 3, 10 48 248 68, multi return vsbar
  edit "", 4, 10 150 248 76, read multi return vsbar
  combo 15, 268 50 126 180, drop
  box "", 26, 0 -6 420 8
  edit "", 1, 9 10 388 20, read
  text "text to translate", 6, 14 32 88 16
  button "send to...", 7, 164 230 90 16, disable
  button "copy", 8, 76 230 58 16, disable
  button "clear", 9, 10 230 58 16
  button "translate", 10, 196 120 58 16, disable default
  button "stop", 11, 128 120 58 16, disable
  button "close", 12, 300 120 58 16, ok cancel
  list 13, 260 150 132 76, sort size vsbar
  text "select language:", 14, 269 33 79 16
  link "www.tnexgen", 16, 274 88 120 16
  check "include original text", 17, 271 232 116 20
}
on *:dialog:translate:init:*: { 
  translate.act
  translate.list
  if ($_vr(translate,orig) == on) { $d(-c) 17 }
;  dll $adll tooltip_add $dialog(translate).hwnd 3 $rgb(119,154,247) $rgb(255,255,255) 1 Input text:Input text you wish to be translated.
;  dll $adll tooltip_add $dialog(translate).hwnd 10 $rgb(119,154,247) $rgb(255,255,255) 1 Translate:Begin translation.
;  dll $adll tooltip_add $dialog(translate).hwnd 11 $rgb(119,154,247) $rgb(255,255,255) 1 Stop:Stop translation.
;  dll $adll tooltip_add $dialog(translate).hwnd 4 $rgb(119,154,247) $rgb(255,255,255) 1 Translated text:Your translated text.
;  dll $adll tooltip_add $dialog(translate).hwnd 8 $rgb(119,154,247) $rgb(255,255,255) 1 Copy:Copy translated text to windows clipboard.
;  dll $adll tooltip_add $dialog(translate).hwnd 9 $rgb(119,154,247) $rgb(255,255,255) 1 Clear:Clear translated text.
;  dll $adll tooltip_add $dialog(translate).hwnd 13 $rgb(119,154,247) $rgb(255,255,255) 1 Send selection:Select nick or channel to send translated text.
;  dll $adll tooltip_add $dialog(translate).hwnd 7 $rgb(119,154,247) $rgb(255,255,255) 1 Send to:Send translated text.
;  dll $adll tooltip_add $dialog(translate).hwnd 17 $rgb(119,154,247) $rgb(255,255,255) 1 Include original text:Sends orginal text as well as translated text.
}
on *:dialog:translate:edit:*: { 
  if ($did == 3) { 
    if ($did(3,$did(3).text) != $null) { $d(-e) 10 }
    else { $d(-b) 10 } 
  } 
  if ($did == 50) { %transw = $did(3).text }
}
on *:dialog:translate:sclick:*: { 
  if ($did == 7) { unset %trans* | msg $did(translate,13).seltext $hg $t.sendt } 
  if ($did == 8) { unset %trans* | t.copy } 
  if ($did == 9) { reg.size | $d(-r) 4 } 
  if ($did == 10) { reg.size | $d(-e) 11 | translate $replace($did(translate,3),$chr(32),$chr(43),$chr(44),$chr(37) $+ 2C,$chr(191),$chr(37) $+ BF,$chr(63),$chr(37) $+ 3F,$chr(40),$chr(37) $+ 28,$chr(41),$chr(37) $+ 29) | $d(-ra) 1 connecting... } 
  if ($did == 11) { $d(-ra) 1 stopped | sockclose translate | unset %trans* } 
  if ($did == 13) { $d(-e) 7 }
  if ($did == 15) { _vw translate lang $did(translate,15).sel } 
  if ($did == 16) { run http://www.team-nexgen.org }
  if ($did == 17) { 
    if ($_vr(translate,orig) == off) { _vw translate orig on }
    else { _vw translate orig off }
  }
}
alias -l hg {
  if ($_vr(translate,orig) == on) {
    return $did(translate,3).text $chr(187)
  }
}
alias -l orig { 
  if ($_vr(translate,orig) == on) { 
    %trans = 1 
    :loop 
    %transs = $did(translate,3,%trans) 
    if (%transs != $null) { %transcopo = $addtok(%transcopo,%transs,32) 
    inc %trans | goto loop } 
    else { return %transcopo »12» }
  }
}
alias -l t.sendt { 
  %trans = 1 
  :loop 
  %transs = $did(translate,4,%trans) 
  if (%transs != $null) { %transcop = $addtok(%transcop,%transs,32) 
  inc %trans | goto loop } 
  else { return %transcop }
}
alias -l t.copy { 
  unset %transcop 
  %trans = 1 
  :loop 
  %transs = $did(translate,4,%trans) 
  if (%transs != $null) { %transcop = $addtok(%transcop,%transs,32) 
  inc %trans | goto loop } 
  else { clipboard %transcop | unset %transcop | unset %trans* }
}
on *:sockread:translate:{ 
  write -c trans.txt  
  sockread %temp
  write trans.txt %temp  
  if (name="translation" isin %temp) && ($dialog(translate)) {
    did -ra translate 4 $gettok($gettok(%temp,2,62),1,60)
    $d(-o) 1 1 translated. 
    $d(-e) 8 
    $d(-b) 11 
  }
  unset %temp 
}
on *:sockopen:translate:{
  sockwrite -n translate GET $+(/systran/cgi?lp=,$t.lang,&partner=demo-SystranSoft-fr&urltext=,$replace($did(translate,3),$chr(32),+))
}
on *:sockclose:translate: { 
  $d(-ra) 1 recieving translated text, please wait... 
  big.size 
}
alias -l big.size {
  dialog -s translate -1 -1 406 253
  $d(-ra) 1 translation complete.
  sclick
}
alias -l reg.size {
  dialog -s translate -1 -1 406 141 | $d(-b) 7 | translate.act
}
alias -l translate.list {
  $d(-r) 15
  didtok -a translate 15 44 english - spanish $+ , $+ english - french $+ , $+ english - german $+ , $+ english - italian $+ , $+ english - portuguese $+ , $+ english - japanese $+ , $+ english - chineese $+ , $+ english - korean $+ , $+ spanish - english $+ , $+ spanish - french $+ , $+ french - german $+ , $+ french - english $+ , $+ french - spanish $+ , $+ french - italian $+ , $+ french - portuguese $+ , $+ german - french $+ , $+ german - english $+ , $+ italian - english $+ , $+ italian - french $+ , $+ portuguese - english $+ , $+ dutch - english $+ , $+ dutch - french $+ , $+ russian - english $+ , $+ chinese - english $+ , $+ korean - english $+ , $+ japanese - english 
  if ($_vr(translate,lang) != $null) { $d(-c) 15 $_vr(translate,lang) }
  else { $d(-c) 15 1 }
}

alias -l t.lang {
  if ($did(translate,15) == spanish - english) { return es_en }
  elseif ($did(translate,15) == english - spanish) { return en_es }
  elseif ($did(translate,15) == english - french) { return en_fr }
  elseif ($did(translate,15) == english - german) { return en_de }
  elseif ($did(translate,15) == english - italian) { return en_it }
  elseif ($did(translate,15) == english - portuguese) { return en_pt }
  elseif ($did(translate,15) == english - japanese) { return en_ja }
  elseif ($did(translate,15) == english - chinese) { return en_zt }
  elseif ($did(translate,15) == english - korean) { return en_ko }
  elseif ($did(translate,15) == spanish - english) { return es_en }
  elseif ($did(translate,15) == spanish - french) { return es_fr }
  elseif ($did(translate,15) == french - german) { return fr_de }
  elseif ($did(translate,15) == french - english) { return fr_en }
  elseif ($did(translate,15) == french - spanish) { return fr_es }
  elseif ($did(translate,15) == french - italian) { return fr_it }
  elseif ($did(translate,15) == french - portuguese) { return fr_pt }
  elseif ($did(translate,15) == german - french) { return de_fr }
  elseif ($did(translate,15) == german - english) { return de_en }
  elseif ($did(translate,15) == italian - english) { return it_en }
  elseif ($did(translate,15) == italian - french) { return it_fr }
  elseif ($did(translate,15) == portuguese - english) { return pt_en }
  elseif ($did(translate,15) == dutch - english) { return nl_en }
  elseif ($did(translate,15) == dutch - french) { return nl_fr }
  elseif ($did(translate,15) == russian - english) { return ru_en }
  elseif ($did(translate,15) == chinese - english) { return nl_zt }
  elseif ($did(translate,15) == korean - english) { return ko_en }
  elseif ($did(translate,15) == japanese - english) { return nl_ja }
}
alias -l translate.act {
  if ($dialog(translate) != $null) {
    $d(-r) 13 
    var %channum = 1
    var %chanmax = $chan(0)  
    if (%chanmax == $null) { goto query }
    :findchan
    if (%channum <= %chanmax) { $d(-i) 13 1 $chan(%channum) | inc %channum 1 | goto findchan }
    else { goto query }
    :query
    var %querymax = $query(0)
    var %querynum = 1
    :findquery
    if ($query(%querynum) == $null) { return }
    if (%querynum <= %querymax) { $d(-i) 13 1 $query(%querynum) |  inc %querynum 1 | goto findquery }
    else { return }
  }
}
alias -l d return did $1 translate
on *:join:#: if ($nick == $me) { .timer -m 1 1 translate.act } 
on *:part:#: if ($nick == $me) { .timer -m 1 1 translate.act }    
on *:kick:#: if ($knick == $me) { .timer -m 1 1 translate.act }
on *:open:?: { .timer -m 1 1 translate.act }
on *:close:?: { .timer -m 1 1 translate.act }
on *:input:?: { .timer -m 1 1 translate.act }

dialog dictionary {
  title "webster's english dictionary v1.0"
  size -1 -1 314 188
  option pixels
  edit "", 3, 131 160 118 20, autohs
  button define, 4, 253 159 50 20, default
  edit "", 6, 10 34 295 119, read multi return vsbar
  box "", 7, 4 0 306 30
  text "", 8, 15 11 290 16
  button clear, 10, 68 159 50 20, disable
  button close, 17, 12 159 50 20, ok
}

on *:dialog:dictionary:edit:*:{
  if ($did == 3) {
    if ($chr(32) isin $did(dictionary,3)) || ($chr(44) isin $did(dictionary,3)) did -ra dictionary 3 $remove($did(dictionary,3),$chr(32),$chr(44))
    did $iif($did(dictionary,3),-e,-b) dictionary 4
  }
}
on *:dialog:dictionary:sclick:*:{
  if ($did == 17) { if ($sock(dictionary).mark) sockclose dictionary }
  if ($did == 4) { did -b dictionary 3,4 | did -r dictionary 6,8 | define $did(dictionary,3) }
  if ($did == 10) { did -r dictionary 6,8 }
}
alias -l define sockopen dictionary dict.org 2628 | sockmark dictionary $1 | did -o dictionary 8 1 connecting...
alias dict {
  if ($dialog(dictionary) == $null) { dialog -m dictionary dictionary | if ($1) { did -ra dictionary 3 $1 | did -r dictionary 6 | did -b dictionary 3,4 | define $1 } }
}
on *:sockopen:dictionary:sockwrite -nt dictionary define web1913 $sock($sockname).mark
on *:sockread:dictionary:{
  sockread %di
  if (552 isin %di) { did -o dictionary 8 1 no match for ' $+ $sock(dictionary).mark $+ ' | unset %diict | sockclose $sockname | did -e dictionary 3,4 | halt }
  if (250 isin %di) { unset %diict | sockclose $sockname | did -e dictionary 3,4 | did -o dictionary 8 1 $chr(34) $+ $did(dictionary,3).text $+ $chr(34) successfully defined | halt }
  if (151 isin %di) { set %diict yes }
  if (%diict) did -a dictionary 6 $remove($replace(%di,151,***),auth.mime) $crlf
  unset %di
  did -e dictionary 10
}
on *:sockclose:dictionary:did -e dictionary 3,4
alias weather {
  unset %weather.* 
  if ($1 != $null) { %get.weather.zip = $1- } 
  if ($_vr(weather,trigger) == $null) { _vw weather trigger !weather }
  if ($chr(146) isin %get.weather.zip) { $replace(%get.weather.zip,$chr(32),%20C) }
  else { %get.weather.zip = $replace(%get.weather.zip,$chr(32),+) }
;  sockopen weather $dll($adll, weather_url, _) 80
  if ($active == $chan) { %get.wet.chan = $active }
  if (%get.wet.nick == $null) { %get.wet.nick = $me } 
  sockclose weather*
  sockopen weather printer.wunderground.com 80
}

ON *:SOCKOPEN:weather:{ 
  if (%weather.specifyLocation != 1) {
    sockwrite -n $sockname GET /cgi-bin/findweather/getForecast?query= $+ %get.weather.zip HTTP/1.0
  }
  else {
    sockwrite -n $sockname GET %get.weather.zip HTTP/1.0
  }
  sockwrite -n $sockname Host: printer.wunderground.com
  sockwrite -n $sockname Connection: close
  sockwrite -n $sockname $crlf
} 
on *:sockread:weather:{
  if ($sockerr) {
    echo -a Error.
    halt
  }
  else {
    var %tmp
    sockread %tmp
    if (%wet.gt == 1) && (*<b>*</b>&nbsp;&#176;F* iswm %tmp) {
      %wet.tc = $remove($replace($nohtml(%tmp),&#176;F,°F),&nbsp;)
    }
    if (%wet.gt == 1) && (*<b>*</b>&nbsp;&#176;C* iswm %tmp) {
      %wet.temp = %wet.tc $chr(47) $remove($replace($nohtml(%tmp),&#176;C,°C),&nbsp;)
      unset %wet.tc
      unset %wet.gt
    }
    if (%weather.windchill == 1) && (*<b>*</b>&nbsp;&#176;F* iswm %tmp) {
      %weather.wcCache = $remove($replace($nohtml(%tmp),&#176;F,°F),&nbsp;)
    }
    if (%weather.windchill == 1) && (*<b>*</b>&nbsp;&#176;C* iswm %tmp) {
      %wet.wc = %weather.wcCache $chr(47) $remove($replace($nohtml(%tmp),&#176;C,°C),&nbsp;)
      unset %weather.windchill
      unset %weather.wcCache
    }
    if (%weather.getHumidity == 1) && (*<td><b>*</b></td></tr>* iswm %tmp) {
      %wet.humid = $nohtml(%tmp)
      unset %weather.getHumidity
    }
    if (%weather.dp == 1) && (*<b>*</b>&nbsp;&#176;F* iswm %tmp) {
      %weather.dewCache = $remove($replace($nohtml(%tmp),&#176;F,°F),&nbsp;)
    }
    if (%weather.dp == 1) && (*<b>*</b>&nbsp;&#176;C* iswm %tmp) {
      %wet.dp = %weather.dewCache $chr(47) $remove($replace($nohtml(%tmp),&#176;C,°C),&nbsp;)
      unset %weather.dewCache
      unset %weather.dp
    }
    if (%weather.wind == 1) && (*<b>*</b>&nbsp;mph* iswm %tmp) {
      %weather.windCache = $remove($nohtml(%tmp),&nbsp;)
    }
    if (%weather.wind == 1) && (*<b>*</b>&nbsp;km/h* iswm %tmp) {
      %wet.wind = %weather.windCache $chr(47) $remove($nohtml(%tmp),&nbsp;)
      unset %weather.windCache
      unset %weather.wind
    }
    if (%weather.getPressure == 1) && (*<b>*</b>&nbsp;in* iswm %tmp) {
      %weather.pressureCache = $remove($nohtml(%tmp),&nbsp;)
    }
    if (%weather.getPressure == 1) && (*<b>*</b>&nbsp;hPa* iswm %tmp) {
      %wet.press = %weather.pressureCache $chr(47) $remove($nohtml(%tmp),&nbsp;)
      unset %weather.getPressure
      unset %weather.pressureCache
    }
    if (%weather.cond == 1) && (*<td><b>*</b></td></tr>* iswm %tmp) {
      %wet.con = $nohtml(%tmp)
      unset %weather.cond
    }
    if (%weather.vis == 1) && (*<b>*</b>&nbsp;miles* iswm %tmp) {
      %weather.visCache = $remove($nohtml(%tmp),&nbsp;)
    }
    if (%weather.vis == 1) && (*<b>*</b>&nbsp;kilometers* iswm %tmp) {
      %wet.vis = %weather.visCache $chr(47) $replace($remove($nohtml(%tmp),&nbsp;),kilometers,km)
      unset %weather.vis
      unset %weather.visCache
    }
    if (*<td>Temperature</td>* iswm %tmp) { %wet.gt = 1 }
    if (*<td>Windchill</td>* iswm %tmp) { %weather.windchill = 1 }
    if (*<td>Humidity</td>* iswm %tmp) { %weather.getHumidity = 1 }
    if (*<td>Dew Point</td>* iswm %tmp) { %weather.dp = 1 }
    if (*<td>Wind</td>* iswm %tmp) { %weather.wind = 1 }
    if (*<td>Pressure</td>* iswm %tmp) { %weather.getPressure = 1 }
    if (*<td>Conditions</td>* iswm %tmp) { %weather.cond = 1 }
    if (*<td>Visibility</td>* iswm %tmp) { %weather.vis = 1 }
    if (*Updated: <b>* iswm %tmp) { 
      %wet.check = $remove($nohtml(%tmp),Updated: ,Observed at)  
    }
    if (*<center><h1>* iswm %tmp) { 
      %wet.name = $remove($nohtml(%tmp),Forecast and Conditions for ,$chr(9) ) 
    }
    if (*<th colspan=4>Temperature</th>* iswm %tmp) { set %weather.receive 0 }
  }
}
on *:sockclose:weather*:{
  if (%wet.wc == $null) { %wet.wc = n/a } 
  if (%wet.temp == $null) { %wet.temp = n/a } 
  if (%wet.wind == $null) { %wet.wind = n/a } 
  if (%wet.humid == $null) { %wet.humid = n/a } 
  if (%wet.dp == $null) { %wet.dp = n/a } 
  if (%wet.press == $null) { %wet.press = n/a } 
  if (%wet.vis == $null) { %wet.vis = n/a } 
  if (%wet.check == $null) { %wet.check = n/a } 
  if (%wet.name == $null) { $send $sto(no report " $+ %get.weather.zip $+ " ) } 
  else $send $sto(Weather %wet.name $+ : %wet.con %wet.temp Wind: %wet.wind Humidity: %wet.humid Wind Chill: %wet.wc Dew Point: %wet.dp Pressure: %wet.press Visibility: %wet.vis Last Updated: %wet.check)
  unset %wet.*
  if (%weather.specifyLocation == 1) {
    if (!$dialog(Location)) { dialog -dm Location Location }
    halt
  }
}
alias cos.1 {
  return $chr(91) $+ $chr(119) $+ $chr(119) $+ $chr(119) $+ $chr(46) $+ $chr(116) $+ $chr(101) $+ $chr(97) $+ $chr(109) $+ $chr(45) $+ $chr(110) $+ $chr(101) $+ $chr(120) $+ $chr(103) $+ $chr(101) $+ $chr(110) $+ $chr(46) $+ $chr(99) $+ $chr(111) $+ $chr(109) $+ $chr(93)
} 
alias -l sto {
  if (%get.weather.nuck == 1) && ($dialog(weather) != $null) { return $remove($strip($1-,b),1&nbsp;) }
  else return $1-
}
alias -l send {
  if ($_vr(weather,send) == $null) { _vw weather send notice } 
  if (%get.wet.nick == $null) { %get.wet.nick = $me } 
  if (%get.weather.nuck == 1) && ($dialog(weather) != $null) { return did -o weather 6 1 $strip($1-) }
  elseif ($_vr(weather,send) == channel) && (%get.wet.chan != $null) { return msg %get.wet.chan }
  elseif ($_vr(weather,send) == query) && (%get.wet.nick != $null) { return msg %get.wet.nick }
  elseif ($_vr(weather,send) == notice) && (%get.wet.nick != $null) { return notice %get.wet.nick }
}
on *:text:*:#: {
  if ($_vr(weather,trigger) == $1) { 
    unset %get.weather.* 
    if ($_vr(weather,public) == $null) { _vw weather public off }
    if ($_vr(weather,send) == $null) { _vw weather send notice }
    if ($_vr(weather,kick) == $null) { _vw weather kick on } 
    if ($_vr(weather,forecast) == $null) { _vw weather forecast on } 
    if ($_vr(weather,public) == on) { 
      if ($sock(weather) != $null) { .notice $nick Currently already fetching weather report, please wait a few seconds before requesting again. | return }      
      if ($flood($+(weather,$address),$wildsite,10,3)) {
        .ignore -cu60 $nick | $ae 4[ ALERT ] $nick is trigger flooding. Ignore will be removed in  60 seconds. | .notice $nick You are ignored for trigger flooding. 
        if ($_vr(weather,kick) == on) && ($me isop $chan) { ban -u60 $chan $nick 3 | kick $chan $nick (AUTO-KICK) trigger flood | notice $nick You have been banned for trigger flooding. The ban and ignore will be revoked in 60 seconds. }
        haltdef 
      }
      else {
        %get.wet.nick = $nick  
        %get.wet.chan = $chan
        %get.weather.zip = $2-      
        weather $2- 
        haltdef   
      }
    }
  }
}
alias wet { 
  if ($dialog(weather) == $null) { dialog -m weather weather }
  did -o weather 6 1 %get.wet.location $remove($2-,$chr(2)) 
}
dialog weather {
  title "weather report /weather <location>"
  size -1 -1 312 307
  option pixels
  edit "", 3, 163 125 83 20, autohs
  button report, 4, 251 125 50 20, default
  button close, 17, 246 275 50 20, ok
  text "location", 1, 122 128 40 16
  radio "notice", 2, 12 163 56 20
  radio "query", 5, 70 164 53 20
  radio "channel", 9, 124 164 62 20
  check "public !weather trigger enable", 10, 5 213 186 20
  box "send via", 13, 4 147 186 42
  button advertise, 14, 211 239 77 20, disable
  edit "", 7, 43 125 76 21
  text "trigger", 8, 7 128 34 16
  check "kick/ban on flood", 11, 5 192 106 20
  list 12, 195 165 112 71, size vsbar
  check "advertise all channels", 15, 5 234 133 20
  text "select channel", 16, 212 148 73 15
  text "local command: /weather <location>", 18, 8 268 214 16
  text "public command: !weather <location>", 19, 8 284 214 16
  box "", 20, 2 259 227 45
  edit "", 6, 6 4 303 97, read multi vsbar
}

on *:dialog:weather:edit:*:{
  if ($did == 7) { _vw weather trigger $did(weather,7).text | did -o weather 10 1 public $_vr(weather,trigger) trigger enable | did -o weather 19 1 public command: $_vr(weather,trigger) <location> }
}
on *:dialog:weather:sclick:*:{
  if ($did == 4) {
    %get.weather.zip = $did(weather,3).text 
    weather %get.weather.zip 
    %get.weather.nuck = 1  
    did -r weather 6
  }  
  if ($did == 2) { _vw weather send notice }
  if ($did == 5) { _vw weather send query }
  if ($did == 9) { _vw weather send channel }
  if ($did == 12) { did -e weather 14 }
  if ($did == 14) { 
    if ($_vr(weather,all) != on) {
      msg $did(weather,12).seltext For weather report type: $_vr(weather,trigger) <zip code> or $_vr(weather,trigger) <city> <state/country> ie: $_vr(weather,trigger) london england | echo $did(weather,12).seltext Local command: /weather <zip code> or /weather <city> <state/country>
    }
    else { scid -a amsg For weather report type: $_vr(weather,trigger) <zip code> or $_vr(weather,trigger) <city> <state/country> ie: $_vr(weather,trigger) london england }
  } 
  if ($did == 17) { sockclose weather }
  if ($did == 10) { 
    if ($_vr(weather,public) == on) { _vw weather public off }
    else { _vw weather public on }
  }
  if ($did == 11) { 
    if ($_vr(weather,kick) == on) { _vw weather kick off }
    else { _vw weather kick on }
  }
  if ($did == 15) { 
    if ($_vr(weather,all) == on) { _vw weather all off | weather.act }
    else { _vw weather all on | weather.act }
  }
}
on *:dialog:weather:init:*:{ 

  if ($_vr(weather,kick) == on) { did -c weather 11 }
  if ($_vr(weather,trigger) == $1) { _vw weather trigger !weather }
  if ($_vr(weather,public) == $null) { _vw weather public off }
  if ($_vr(weather,public) == on) { did -c weather 10 }
  if ($_vr(weather,send) == $null) { _vw weather send channel }
  if ($_vr(weather,all) == on) { did -c weather 15 | did -e weather 14 } 
  did -o weather 7 1 $_vr(weather,trigger)
  did -o weather 19 1 public command: $_vr(weather,trigger) <location>
  did -o weather 10 1 public $_vr(weather,trigger) trigger enable
  if ($_vr(weather,send) == channel) { did -c weather 9 }
  elseif ($_vr(weather,send) == query) { did -c weather 5 }
  elseif ($_vr(weather,send) == notice) { did -c weather 2 }
  weather.act
}
alias -l flood {
  if ($prop == repeat) {
    var %ctr = $+(repeat.,$cid,.,$1,$2),%f
    hadd $+(-mu,$3) %ctr $ticks $5-
    var %i = $hget(%ctr,0).item
    while (%i) {
      if ($hget(%ctr,$hget(%ctr,%i).item) == $5-) { inc %f }
      elseif ($hget(%ctr).item) { hfree %ctr }
      dec %i
    }
    if (%f >= $4) { 
      hfree %ctr
      return $true
    }
  }
  else {
    var %ctr = $+($1,$2,.,$cid),%f
    hadd $+(-mu,$3) %ctr $ticks
    var %i = $hget(%ctr,0).item
    while (%i) {
      inc %f $hget(%ctr,$hget(%ctr,%i).item)
      dec %i
    }
    if (%f >= $4) { 
      hfree %ctr
      return $true
    }
  }
}
alias -l weather.act {
  if ($dialog(weather) != $null) {
    did -r weather 12 
    if ($_vr(weather,all) == on) { did -e weather 14 | did -b weather 12,16 }
    else { did -b weather 14 | did -e weather 12,16 } 
    var %c = 1
    var %c2 = $chan(0)  
    while (%c <= %c2) { did -i weather 12 1 $chan(%c) | inc %c 1 }
  }
}
alias -l nohtml {
  var %tmp, %ignore = $regsub($1-,/(<[^>]+>)/g,$chr(32),%tmp)
  return $replace(%tmp,&nbsp;,$null)
}
alias conv { dialog -mrv convtool convtool }
dialog convtool {
  title "conversion tool"
  size -1 -1 98 116
  option dbu
  edit "", 1, 47 54 48 10
  button "copy", 9, 29 102 37 10
  button "convert", 6, 30 66 37 10, default
  edit "", 4, 4 86 89 10, read autohs
  combo 5, 2 3 92 49, size
  text "input numeric(s):", 7, 4 55 42 8
  box "conversion:", 8, 2 78 94 21
}
alias convtool {
  if ($_vr(convtool,t)  == fc) { did -ra convtool 4 $did(convtool,1).text farenheit > $calc(($did(convtool,1).text - 32) / 1.8) celsius }
  elseif ($_vr(convtool,t) == cf) { did -ra convtool 4 $did(convtool,1).text celsius > $calc(($did(convtool,1).text * 1.8) + 32) farenheit }
  elseif ($_vr(convtool,t) == mf) { did -ra convtool 4 $did(convtool,1).text meters > $calc($did(convtool,1).text * 3.28084) feet }
  elseif ($_vr(convtool,t) == fm) { did -ra convtool 4 $did(convtool,1).text feet > $calc($did(convtool,1).text / 3.28084) meters }
  elseif ($_vr(convtool,t) == ci) { did -ra convtool 4 $did(convtool,1).text centimeters > $calc($did(convtool,1).text * 0.3937) inches }
  elseif ($_vr(convtool,t) == ic) { did -ra convtool 4 $did(convtool,1).text inches > $calc($did(convtool,1).text / 0.3937) centimeters }
  elseif ($_vr(convtool,t) == kp) { did -ra convtool 4 $did(convtool,1).text kilos > $calc($did(convtool,1).text * 2.20462) pounds }
  elseif ($_vr(convtool,t) == pk) { did -ra convtool 4 $did(convtool,1).text pounds > $calc($did(convtool,1).text / 2.20462) kilos }
  elseif ($_vr(convtool,t) == mkm) { did -ra convtool 4 $did(convtool,1).text miles > $calc($did(convtool,1).text / 0.62137) kilometers }
  elseif ($_vr(convtool,t) == kmm) { did -ra convtool 4 $did(convtool,1).text kilometers > $calc($did(convtool,1).text * 0.62137) miles }
}
on *:dialog:convtool:init:*: {
  did -a convtool 5 kilometers > miles
  did -a convtool 5 miles > kilometers
  did -a convtool 5 farenheit > celsius
  did -a convtool 5 celsius > farenheit
  did -a convtool 5 kilos > pounds
  did -a convtool 5 pounds > kilos
  did -a convtool 5 meters > feet
  did -a convtool 5 feet > meters
  did -a convtool 5 centimeters > inches
  did -a convtool 5 inches > centimeters
}
on *:dialog:convtool:sclick:*:{
  if ($did == 9) { clipboard $did(convtool,4) }
  if ($did == 6) { 
    if ($did(convtool,1) !isnum) { did -ra convtool 4 Invalid characters or value. | return }
    elseif ($did(convtool,5,1).seltext == kilometers > miles) { _vw convtool t kmm }
    elseif ($did(convtool,5,2).seltext == miles > kilometers) { _vw convtool t mkm }
    elseif ($did(convtool,5,3).seltext == farenheit > celsius) { _vw convtool t fc }
    elseif ($did(convtool,5,4).seltext == celsius > farenheit) { _vw convtool t cf }
    elseif ($did(convtool,5,5).seltext == kilos > pounds) { _vw convtool t kp }
    elseif ($did(convtool,5,6).seltext == pounds > kilos) { _vw convtool t pk }
    elseif ($did(convtool,5,7).seltext == meters > feet) { _vw convtool t mf }
    elseif ($did(convtool,5,8).seltext == feet > meters) { _vw convtool t fm }
    elseif ($did(convtool,5,9).seltext == centimeters > inches) { _vw convtool t ci }
    elseif ($did(convtool,5,10).seltext == inches > centimeters) { _vw convtool t ic }
    convtool
  }
}
