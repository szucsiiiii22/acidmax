alias -l echon {
  if ($_vr(echo,whois) == -a) { return echo $_vr(echo,whois) }
  else { return echo -s }
}
alias -l p return  $+ $colour(info) $+ $chr(149) $+ 
raw 1:*: $se $p  $+ $color(info) $+ $2- | haltdef
raw 2:*: $se $p $2- | haltdef
raw 3:*: $se $p $2- | haltdef
raw 4:*: $se $p $2- | haltdef
raw 5:*: haltdef
raw 211:*: $se $p $2- | haltdef
raw 219:*: $se $p $2- | haltdef
raw 242:*: $se $p $2- | haltdef
raw 250:*: $se $p $2- | haltdef
raw 242:*: $se $p $2- | haltdef
raw 251:*: $se $p $2- | haltdef
raw 252:*: $se $p $2- | haltdef
raw 253:*: $se $p $2- | haltdef
raw 254:*: $se $p $2- | haltdef
raw 255:*: $se $p $2- | haltdef
alias -l onjoint {
  if ($_vr(setup,lastjoinshow) == off) && ($_vr(setup,bornonshow) == off) && ($_vr(setup,modeshow) == off) && ($_vr(setup,topicshow) == off) && ($_vr(setup,statshow) == off) && ($_vr(setup,nameshow) == off) { return $false }   
  else return $true
}

raw 324:*: { if ($_vr(setup,modeshow) != off) { echo $2 $space(4) 12• mode(s) $3- } | haltdef } 
raw 325:*: { echo $2 $space(4) 12• mode lock $6- | haltdef } 
raw 329:*:{ 
  if ($file(data\syslog.ini).size >= 40000) { write -c data\syslog.ini }
  if ($_vr(setup,lastjoinshow) != off) { if ($_lr($2 $+ $network,laston) != $null) { echo $2 $space(4) 12• last join $_lr($2 $+ $network,laston) 12joined $_lr($2 $+ $network,hits) times } }
  if ($_vr(setup,bornonshow) != off) { if ($asctime($3) != $null) { echo $2 $space(4) 12• 12channel born $asctime($3) } }
  _lw $2 $+ $network chan $2 | _lw $2 $+ $network laston $asctime(h:nn:sstt dddd mmm d  yyyy) | _lw $2 $+ $network hits $calc($_lr($2 $+ $network,hits) + 1)
  if ($onjoint != $false) { echo $2 $space(4) 12• synched in $duration($calc($ctime - %c.synch)) }
  if ($onjoint != $false) { echo $2 $space(3) 12[end12] }  
  unset %nraw.* 
  haltdef
}
raw 332:*:{ if ($_vr(setup,topicshow) != off) { unset %topic* | %topicr = echo $2 $space(4) 12• topic $3- } | haltdef }
raw 333:*:{ if ($_vr(setup,topicshow) != off) { if ($3 != $null) { %topica = echo $2 $space(4) 12• topic author $3 ( $+ $asctime($4) $+ )12) } } | haltdef } 
alias names {
  if ($1 != $null) { _vw names switch off | names $$1 }
  else { _vw names switch on | names $$1 }
}
raw 366:*:{ 
  if ($_vr(names,switch) != off) {
    if ($onjoint != $false) { echo $2 $space(3) 12[ $+ $2 $+ 12] }
    if ($_vr(setup,statshow) != off) { echo $2 $space(4) 12• [total users $nick($2,0) $+ 12] [ops $nick($2,0,o) $+ ( $+ $round($calc($nick($2,0,o) / $nick($2,0) * 100),0) $+  % $+ )12] [halfops $nick($2,0,h) $+ ( $+ $round($calc($nick($2,0,h) / $nick($2,0) * 100),0) $+  % $+ )12] [voice $nick($2,0,v) $+ ( $+ $round($calc($nick($2,0,v) / $nick($2,0) * 100),0) $+  % $+ )12] [regular $nick($2,0,r) $+ ( $+ $round($calc($nick($2,0,r) / $nick($2,0) * 100),0) $+  % $+ )12] } 
    if ($_vr(setup,topicshow) != off) { %topicr | %topica | unset %topic* }
  }
  if ($_vr(setup,nameshow) != off) { echo 12[end $2 name listing] }
  _vw names switch on
  haltdef
}
raw 317:*: {
  $echon $space(4) 12»14 idle 12: $duration($3) | $echon $space(4) 12»14 signon 12: $asctime($4,mmmm dd yyyy) | $echon $space(4) 12»14 resolved 12: $duration($calc($ctime - %s.whois)) | $echon $space(1) 12[14end12]
  haltdef
}
raw 307:*: {
  $echon $space(4) 12»14 nick info 12: $2 is a registered nick 
  halt
}
raw 301:*: {
  if ($2 == $me) && ($timer(Lag) != $null) { halt }
  $echon $space(4) 12»14 away 12: $3-
  haltdef
}
raw 309:*: {
  $echon $space(4) 12»14 info 12: $3-
  haltdef
}
raw 310:*: $echon $space(4) 12»14 status 12: $3- | haltdef 
raw 311:*: {
  $echon $space(1) 12[14whois: $2 $+ 12]
  $echon $space(4) 12»14 address 12: $3 $+ @ $+ $4 
  $echon $space(4) 12»14 name 12: $6-
  $echon $space(4) 12»14 origin 12: $cc2($4)
  $echon $space(4) 12»14 level 12: $level($address($2,3))
  if ($left($3,1) == ~) {  $echon $space(4) 12»14 identd 12: ident is off }
  else { $echon $space(4) 12»14 identd 12: ident is on }   
  haltdef
}
raw 312:*: {
  $echon $space(4) 12»14 server 12: $3-
  haltdef
}
raw 313:*: {
  $echon $space(4) 12»14 server/ network 12: $5-
  haltdef
}
raw 379:*: {
  $echon $space(4) 12»14 mode(s) 12: $6-
  haltdef
}
raw 615:*: {
  $echon $space(4) 12»14 mode(s) 12: $6-
  haltdef
}
raw 616:*: {
  $echon $space(4) 12»14 real hostname 12: $5-
  haltdef
}
raw 319:*: {
  $echon $space(4) 12»14 channel(s) 12: $replace($replace($replace($3-,@,12@),+,12+),%,12%)
  haltdef
}
raw 320:*: {
  $echon $space(3) 12»14 connection 12: $5-
  haltdef
}
raw 318:*: {
  ;$echon $space(1) [12 end ]
  haltdef
}
raw 330:*: {
  $echon $space(4) 12»14 username 12: $3
  haltdef
}
raw 338:*: {
  $echon $space(4) 12»14 actual host/ ip 12: $3 $4
  haltdef
}
raw 353:*:{ 
  if ($_vr(setup,nameshow) != off) {
    echo 12[names in $3] | echo $4- 
  }
  haltdef 
}
raw 378:*:{ 
  if ($network != AustNet) { $echon $space(4) 12»14 connecting from 12: $6- 
    haltdef
  }
}

raw 381:*: {
  $echon $space(2) •3• oper »3 $2-
  haltdef
}
raw 401:*: {
  $ae $er no such user " $+ $2 $+ " | beep 
  haltdef
}
raw 402:*: $ae $er no such user/server " $+ $2 $+ " | beep | haltdef
raw 421:*: $ae $er unknown command " $+ $2 $+ " | beep | haltdef
raw 422:*: $ae $er $2- | beep | haltdef
raw 433:*: $ae $er " $+ $2 $+ " nickname in use. | whois $2 | beep | haltdef
raw 460:*: $ae $er you do not have permission to set halfops/dehalfops | beep | haltdef
raw 471:*: {
  $echon $space(2) •4• channel full »4 $2 is at full channel limit
  haltdef
}
raw 473:*: {
  $echon $space(2) •4• channel restricted »4 invitation only
  haltdef
}
raw 473:*: {
  $echon $space(2) •4• channel restricted »4 invitation only
  haltdef
}
raw 474:*: {
  $echon $space(2) •4• banned »4 $2- 
  haltdef
}
raw 482:*: $ae $er $3- on $2 | beep | haltdef
raw 550:*: {
  $echon $space(4) 12»14 mask 12: $6 
  halt
}
alias coun {
  if (*.users.undernet.org iswm $1 ) { return UnderNet Hidden Host }
  if (*.af iswm $1 ) { return Afghanistan }
  if (*.al iswm $1 ) { return Albania }
  if (*.dz iswm $1 ) { return Algeria }
  if (*.as iswm $1 ) { return American Samoa }
  if (*.ad iswm $1 ) { return Andorra }
  if (*.ao iswm $1 ) { return Angola }
  if (*.ai iswm $1 ) { return Anguilla }
  if (*.aq iswm $1 ) { return Antarctia }
  if (*.ag iswm $1 ) { return Antigua and Barbuda }
  if (*.ar iswm $1 ) { return Argentina }
  if (*.am iswm $1 ) { return Armenia }
  if (*.aw iswm $1 ) { return Aruba }
  if (*.ac iswm $1 ) { return Ascension Island }
  if (*.au iswm $1 ) { return Australia }
  if (*.at iswm $1 ) { return Austria }
  if (*.az iswm $1 ) { return Azerbaijan }
  if (*.bs iswm $1 ) { return Bahamas }
  if (*.bh iswm $1 ) { return Bahrain }
  if (*.bd iswm $1 ) { return Bangladesh }
  if (*.bb iswm $1 ) { return Barbados }
  if (*.by iswm $1 ) { return Belarus }
  if (*.be iswm $1 ) { return Belgium }
  if (*.bz iswm $1 ) { return Belize }
  if (*.bj iswm $1 ) { return Benin }
  if (*.bm iswm $1 ) { return Bermuda }
  if (*.bt iswm $1 ) { return Bhutan }
  if (*.bo iswm $1 ) { return Bolivia }
  if (*.ba iswm $1 ) { return Bosnia and Herzegowina }
  if (*.bw iswm $1 ) { return Botswana }
  if (*.bv iswm $1 ) { return Bouvet Island }
  if (*.br iswm $1 ) { return Brazil }
  if (*.io iswm $1 ) { return British Indian Ocean Territory }
  if (*.bn iswm $1 ) { return Brunei Darussalam }
  if (*.bg iswm $1 ) { return Bulgaria }
  if (*.bf iswm $1 ) { return Burkina Faso }
  if (*.bi iswm $1 ) { return Burundi }
  if (*.kh iswm $1 ) { return Cambodia }
  if (*.cm iswm $1 ) { return Cameroon }
  if (*.ca iswm $1 ) { return Canada }
  if (*.ky iswm $1 ) { return Cayman Islands }
  if (*.cv iswm $1 ) { return Cape Verde }
  if (*.cf iswm $1 ) { return Central African Republic }
  if (*.td iswm $1 ) { return Chad }
  if (*.cl iswm $1 ) { return Chile }
  if (*.cn iswm $1 ) { return China }
  if (*.cx iswm $1 ) { return Christmas Island }
  if (*.cc iswm $1 ) { return Cocos (Keeling) Islands }
  if (*.co iswm $1 ) { return Columbia }
  if (*.com iswm $1 ) { return Internic Commercial } 
  if (*.km iswm $1 ) { return Comoros }
  if (*.cd iswm $1 ) { return Democratic People's Republic of Congo }
  if (*.cg iswm $1 ) { return Republic Of Congo }
  if (*.ck iswm $1 ) { return Cook Islands }
  if (*.cr iswm $1 ) { return Costa Rica }
  if (*.ci iswm $1 ) { return Cote D'Ivoire }
  if (*.hr iswm $1 ) { return Croatia/Hrvatska }
  if (*.cu iswm $1 ) { return Cuba }
  if (*.cy iswm $1 ) { return Cyprus }
  if (*.cz iswm $1 ) { return Czech Republic }
  if (*.dk iswm $1 ) { return Denmark }
  if (*.dj iswm $1 ) { return Djibouti }
  if (*.dm iswm $1 ) { return Dominica }
  if (*.do iswm $1 ) { return Dominican Republic }
  if (*.tp iswm $1 ) { return East Timor }
  if (*.ec iswm $1 ) { return Ecuador }
  if (*.edu iswm $1 ) { return Educational Institution }
  if (*.eg iswm $1 ) { return Egypt }
  if (*.sv iswm $1 ) { return El Salvador }
  if (*.gq iswm $1 ) { return Equatorial Guinea }
  if (*.er iswm $1 ) { return Eritrea }
  if (*.ee iswm $1 ) { return Estonia }
  if (*.et iswm $1 ) { return Ethiopia }
  if (*.fk iswm $1 ) { return Falkland Islands (Malvinas) }
  if (*.fo iswm $1 ) { return Faroe Islands }
  if (*.fj iswm $1 ) { return Fiji }
  if (*.fi iswm $1 ) { return Finland }
  if (*.fr iswm $1 ) { return France }
  if (*.fx iswm $1 ) { return Metropolitan France }
  if (*.gf iswm $1 ) { return French Guiana }
  if (*.pf iswm $1 ) { return French Polynesia }
  if (*.tf iswm $1 ) { return French Southern Terrirories }
  if (*.ga iswm $1 ) { return Gabon }
  if (*.gm iswm $1 ) { return Gambania }
  if (*.ge iswm $1 ) { return Georgia }
  if (*.de iswm $1 ) { return Germany }
  if (*.gh iswm $1 ) { return Ghana }
  if (*.gi iswm $1 ) { return Gibraltar }
  if (*.gr iswm $1 ) { return Greece }
  if (*.gl iswm $1 ) { return Greenland }
  if (*.gd iswm $1 ) { return Grenada }
  if (*.gp iswm $1 ) { return Guadeloupe }
  if (*.gu iswm $1 ) { return Guam }
  if (*.gt iswm $1 ) { return Guatemala }
  if (*.gg iswm $1 ) { return Guernsey }
  if (*.gn iswm $1 ) { return Guinea }
  if (*.gw iswm $1 ) { return Guinea-Bissau }
  if (*.gy iswm $1 ) { return Guyana }
  if (*.ht iswm $1 ) { return Haiti }
  if (*.hm iswm $1 ) { return Heard and McDonald Islands }
  if (*.va iswm $1 ) { return Holy See (Vatican City State) }
  if (*.hn iswm $1 ) { return Honduras }
  if (*.hk iswm $1 ) { return Hong Kong }
  if (*.hu iswm $1 ) { return Hungary }
  if (*.is iswm $1 ) { return Iceland }
  if (*.in iswm $1 ) { return India }
  if (*.id iswm $1 ) { return Indonesia }
  if (*.ir iswm $1 ) { return Iran (Islamic Republic Of) }
  if (*.iq iswm $1 ) { return Iraq }
  if (*.ie iswm $1 ) { return Ireland }
  if (*.im iswm $1 ) { return Isle of Man }
  if (*.il iswm $1 ) { return Israel }
  if (*.it iswm $1 ) { return Italy } 
  if (*.jm iswm $1 ) { return Jamaica }
  if (*.jp iswm $1 ) { return Japan }
  if (*.je iswm $1 ) { return Jersey }
  if (*.jo iswm $1 ) { return Jordan }
  if (*.kz iswm $1 ) { return Kazakhstan }
  if (*.ke iswm $1 ) { return Kenya }
  if (*.ki iswm $1 ) { return Kiribati }
  if (*.kp iswm $1 ) { return Democratic People's Republic of Korea }
  if (*.kr iswm $1 ) { return Republic Of Korea }
  if (*.kw iswm $1 ) { return Kuwait }
  if (*.kg iswm $1 ) { return Kyrgzstan }
  if (*.la iswm $1 ) { return People's Democratic Republic Of Lao }
  if (*.lv iswm $1 ) { return Latvia }
  if (*.lb iswm $1 ) { return Lebanon }
  if (*.ls iswm $1 ) { return Lesotho }
  if (*.lr iswm $1 ) { return Liberia }
  if (*.ly iswm $1 ) { return Libyan Arab Jamahiriya }
  if (*.li iswm $1 ) { return Liechtenstein }
  if (*.lt iswm $1 ) { return Lithuania }
  if (*.lu iswm $1 ) { return Luxembourg }
  if (*.mo iswm $1 ) { return Macau }
  if (*.mk iswm $1 ) { return Macedonia }
  if (*.mg iswm $1 ) { return Madagascar }
  if (*.mw iswm $1 ) { return Malawi }
  if (*.my iswm $1 ) { return Malaysia }
  if (*.mv iswm $1 ) { return Maldives }
  if (*.ml iswm $1 ) { return Mali }
  if (*.mt iswm $1 ) { return Malta }
  if (*.mh iswm $1 ) { return Marshall Islands }
  if (*.mq iswm $1 ) { return Martinique }
  if (*.mr iswm $1 ) { return Mauritania }
  if (*.mu iswm $1 ) { return Mauritius }
  if (*.yt iswm $1 ) { return Mayotte }
  if (*.mx iswm $1 ) { return Mexico }
  if (*.fm iswm $1 ) { return Federal States of Micronesia }
  if (*.md iswm $1 ) { return Republic Of Moldova }
  if (*.mc iswm $1 ) { return Monaco }
  if (*.mn iswm $1 ) { return Mongolia }
  if (*.ms iswm $1 ) { return Monsterrat }
  if (*.ma iswm $1 ) { return Morocco }
  if (*.mz iswm $1 ) { return Mozambique }
  if (*.mm iswm $1 ) { return Myanmar }
  if (*.na iswm $1 ) { return Nambia }
  if (*.nr iswm $1 ) { return Nauru }
  if (*.np iswm $1 ) { return Nepal }
  if (*.nl iswm $1 ) { return Netherlands }
  if (*.an iswm $1 ) { return Netherlands Antilles }
  if (*.nc iswm $1 ) { return New Calendonia }
  if (*.nz iswm $1 ) { return New Zealand }
  if (*.ni iswm $1 ) { return Nicaragua }
  if (*.ne iswm $1 ) { return Niger }
  if (*.net iswm $1 ) { return Internic Network }
  if (*.info iswm $1 ) { return Internic Information }
  if (*.ng iswm $1 ) { return Nigeria }
  if (*.nu iswm $1 ) { return Niue }
  if (*.nf iswm $1 ) { return Norfolk Island }
  if (*.mp iswm $1 ) { return Northern Mariana Islands }
  if (*.no iswm $1 ) { return Norway }
  if (*.om iswm $1 ) { return Oman }
  if (*.pk iswm $1 ) { return Pakistan }
  if (*.pw iswm $1 ) { return Palau }
  if (*.pa iswm $1 ) { return Panama }
  if (*.pg iswm $1 ) { return Papua New Guinea }
  if (*.py iswm $1 ) { return Paraguay }
  if (*.pe iswm $1 ) { return Peru }
  if (*.ph iswm $1 ) { return Phillippines }
  if (*.pn iswm $1 ) { return Pitcairn }
  if (*.pl iswm $1 ) { return Poland }
  if (*.ot iswm $1 ) { return Portugal }
  if (*.pt iswm $1 ) { return Portugal }
  if (*.org iswm $1 ) { return Internic Non-Profit Organization }
  if (*.pr iswm $1 ) { return Puerto Rico }
  if (*.qa iswm $1 ) { return Qatar }
  if (*.re iswm $1 ) { return Reunion }
  if (*.ro iswm $1 ) { return Romania }
  if (*.ru iswm $1 ) { return Russian Federation }
  if (*.rw iswm $1 ) { return Rwanda }
  if (*.kn iswm $1 ) { return Saint Kitts and Nevis }
  if (*.lc iswm $1 ) { return Saint Lucia }
  if (*.vc iswm $1 ) { return Saint Vincent and the Grenadines }
  if (*.ws iswm $1 ) { return Samoa }
  if (*.sm iswm $1 ) { return San Marino }
  if (*.st iswm $1 ) { return Sao Tome and Principe }
  if (*.sa iswm $1 ) { return Saudi Arabia }
  if (*.sn iswm $1 ) { return Senegal }
  if (*.sc iswm $1 ) { return Seychelles }
  if (*.sl iswm $1 ) { return Sierra Leone }
  if (*.sg iswm $1 ) { return Singapore }
  if (*.sk iswm $1 ) { return Slovakia (Slovak Republic) }
  if (*.si iswm $1 ) { return Slovenia }
  if (*.sb iswm $1 ) { return Soloman Islands }
  if (*.so iswm $1 ) { return Somalia }
  if (*.za iswm $1 ) { return South Africa }
  if (*.gs iswm $1 ) { return South Georgia and Sandwich Isl. }
  if (*.es iswm $1 ) { return Spain }
  if (*.lk iswm $1 ) { return Sri Lanka }
  if (*.sh iswm $1 ) { return St. Helena }
  if (*.pm iswm $1 ) { return St. Pierre and Miquelon }
  if (*.sd iswm $1 ) { return Sudan }
  if (*.sr iswm $1 ) { return Suriname }
  if (*.sj iswm $1 ) { return Svalbard and Jan Mayen Isl. }
  if (*.sz iswm $1 ) { return Swaziland }
  if (*.se iswm $1 ) { return Sweden }
  if (*.ch iswm $1 ) { return Switzerland }
  if (*.sy iswm $1 ) { return Syrian arab Republic }
  if (*.tw iswm $1 ) { return Taiwan }
  if (*.tj iswm $1 ) { return Tajikistan }
  if (*.tz iswm $1 ) { return Tanzania }
  if (*.th iswm $1 ) { return Thailand }
  if (*.tg iswm $1 ) { return Togo }
  if (*.tk iswm $1 ) { return Tokelau }
  if (*.to iswm $1 ) { return Tonga }
  if (*.tt iswm $1 ) { return Trinidad and Tobago }
  if (*.tn iswm $1 ) { return Tunisia }
  if (*.tr iswm $1 ) { return Turkey }
  if (*.tm iswm $1 ) { return Turkmenistan }
  if (*.tc iswm $1 ) { return Turks and Ciacos Islands }
  if (*.tv iswm $1 ) { return Tuvalu }
  if (*.ug iswm $1 ) { return Uganda }
  if (*.ua iswm $1 ) { return Ukraine }
  if (*.ae iswm $1 ) { return United Arab Emirates }
  if (*.gb iswm $1 ) { return United Kingdom }
  if (*.us iswm $1 ) { return United States }
  if (*.uk iswm $1 ) { return United Kingdom }
  if (*.um iswm $1 ) { return United States Minor Outlying Islands }
  if (*.uy iswm $1 ) { return Uruguay }
  if (*.uz iswm $1 ) { return Uzbekistan }
  if (*.vu iswm $1 ) { return Vanuatu }
  if (*.ve iswm $1 ) { return Venezuela }
  if (*.vn iswm $1 ) { return Viet Nam }
  if (*.vg iswm $1 ) { return Virgin Islands (British) }
  if (*.vi iswm $1 ) { return Virgin Islands (United States) }
  if (*.wf iswm $1 ) { return Wallis and Futuna Islands }
  if (*.eh iswm $1 ) { return Western Sahara }
  if (*.ye iswm $1 ) { return Yemen }
  if (*.yu iswm $1 ) { return Yugoslavia }
  if (*.zr iswm $1 ) { return Zaire }
  if (*.zm iswm $1 ) { return Zambia }
  if (*.zw iswm $1 ) { return Zimbabwe }
  if (*.*0 iswm $1 ) { return Unknown }
  if (*.*1 iswm $1 ) { return Unknown }
  if (*.*2 iswm $1 ) { return Unknown }
  if (*.*3 iswm $1 ) { return Unknown }
  if (*.*4 iswm $1 ) { return Unknown }
  if (*.*5 iswm $1 ) { return Unknown }
  if (*.*6 iswm $1 ) { return Unknown }
  if (*.*7 iswm $1 ) { return Unknown }
  if (*.*8 iswm $1 ) { return Unknown }
  if (*.*9 iswm $1 ) { return Unknown }
  if ($1 == $null ) { return Unknown }
  else { return Unknown }
}
alias cc2 {
  if ($1 != $null) { return $coun($1) }
  else { return unknown } 
}
alias cc {
  if ($1 != $null) { return $chr(91) $+ $coun($1) $+ $chr(93) }
  else { return } 
}
alias -l _lr {
  if ($exists(data\syslog.ini) == $false) { mkdir data | write -c data\syslog.ini }
  return $readini data\syslog.ini $1 $2 
}
alias -l _lw {
  if ($exists(data\syslog.ini) == $false) { mkdir data | write -c data\syslog.ini }
  writeini data\syslog.ini $1 $2 $3-
}
alias -l _lrem {
  if ($exists(data\syslog.ini) == $false) { mkdir data | write -c data\syslog.ini }
  remini data\syslog.ini $1 $2 
}
