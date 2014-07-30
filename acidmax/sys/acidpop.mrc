menu @snotices {
  $iif($server && o isin $usermode, • ircop/admin $l(10,notice))
  .admin $l(70,chat):adchat $$?=" $l(91,enter text) "
  .chat ops:chatops $$?=" $l(91,enter text) "
  .global ops:globops $$?=" $l(91,enter text) "
  .local ops:locops $$?=" $l(91,enter text) "
}
on *:input:@snotices:{
  if ($server && o isin $usermode) {
    locops $1-    
  }
  else halt
}
menu query {
  • clear:clear 
  • control panel:frmCP.Reload
  • uwho:uwho $$1
  • dns:dns $$1
  • notice:.notice $$1 $$?="notice message user"
  • popups:popload
  • dcc
  .send: raw -q notice $1 : Preparing for DCC file transfer. | dcc send $$1 
  .chat: dcc chat $$1
  .fserve:fserve $$1 $?="how many file gets:" $$sdir="Path for user to get files:"  txt\welcome.txt
  .$iif(*.dal.net iswm $server,dccallow)
  ..add:{ .quote dccallow + $+ $$1 | echo -a •12• dcc allow » (12 $$1 ) added }
  ..remove:{ .quote dccallow - $+ $$1 | echo -a •12• dcc allow » (12 $$1 ) removed }
  • ctcp
  .ping: ctcp $$1 ping 
  .version: ctcp $$1 version 
  .help: ctcp $$1 help 
  .finger: ctcp $$1 finger 
  .time: ctcp $$1 time 
  .userinfo: ctcp $$1 userinfo 
  .clientinfo: ctcp $$1 clientinfo 
  .xdcc
  ..list:.ctcp $1 xdcc list
  ..get:.ctcp $1 xdcc get $?=" $l(79,please enter xdcc packet number) "
  .-
  .custom:ctcp $1 $?=" $l(81,please enter a ctcp request) "
  • utilities
  .log $1
  ..on:log on $1  
  ..off:log off $1  
  • media 
  .jukebox
  ..wav { var %wav $$hfile="Select wave file to play" $wavedir | _vw jukebox wavdir $nofile(%wav) $+ *.wav | jukebox $$1 $shortfn(%wav) } 
  ..midi { var %mid $$hfile="Select midi file to play " $mididir | _vw jukebox middir $nofile(%mid) $+ *.mid | jukebox $$1 $shortfn(%mid) } 
  ..mp3 { var %mp3 $$hfile="Select mp3 file to play" $mp3dir | _vw jukebox mp3dir $nofile(%mp3) $+ *.mp3 | jukebox $$1 $shortfn(%mp3) }
  ..wma { var %wma $$hfile="Select wma file to play" $_vr(jukebox,wmadir) | _vw jukebox wmadir $nofile(%wma) $+ *.wma | run $shortfn(%wma) | say 15..12wma15.. $nopath(%wma) } 
  • stats
  .$chr(164) system:stat 
  .os:stat -os  
  .processor:stat -cpu
  .memory:stat -mem
  .display:stat -display
  .sound:stat -sound
  .hard drive(s):stat -hdd
  .bios:stat -bios
  .connection:stat -connection
  .uptime:stat -uptime 
  notify list:notalist
} 
menu channel {
  [acidmax]:acidmax
  -
  • clear:clear
  • $l(2,tray):showmirc -t | tray -i1 acidmax.ico
  • $l(1,control panel):cp  
  • nexgen
  .home: var %k = $com(lAB,GoUrl,1,bstr,http://www.team-nexgen.org)
  .forum: var %k = $com(lAB,GoUrl,1,bstr,http://www.team-nexgen.org/forum)
  .software: var %k = $com(lAB,GoUrl,1,bstr,http://www.team-nexgen.org/software.php)
  .scripts: var %k = $com(lAB,GoUrl,1,bstr,http://www.team-nexgen.org/scripts.php)
  .guest book: var %k = $com(lAB,GoUrl,1,bstr,http://www.team-nexgen.org/vgb/)
  .staff: var %k = $com(lAB,GoUrl,1,bstr,http://www.team-nexgen.org/members.php)
  • setup
  .timestamping $chr(91) $+ $_vr(general,timestamp) $+ $chr(93): {
    if ($_vr(general,timestamp) == on) { _vw general timestamp off | timestamp off | haltdef }
    else { _vw general timestamp on | timestamp on | haltdef }
  } 
  .event color theme $chr(91) $+ $group(#colortheme) $+ $chr(93): { if ($group(#colortheme) == on) { .disable #colortheme | if $dialog(color) != $null) { did -b color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } | echo -a •03• event color theme » (03 off ) }
    else { .enable #colortheme | if $dialog(color) != $null) { did -e color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } | echo -a •03• event color theme » (03 on ) }
  }   
  .nexgen sounds $chr(91) $+ $_vr(setup,sound) $+ $chr(93): { if ($_vr(setup,sound) == on) { _vw setup sound off | echo -a •03• nexgen sounds » (03 off ) }
    else { _vw setup sound on | echo -a •03• nexgen sounds » (03 on ) }
  }
  .ctcp $l(15,cloak) $chr(91) $+ $_vr(general,cloak) $+ $chr(93): { if ($_vr(general,cloak) == on) { cloak off }
    else { cloak on }
  }
  .-
  .more ...:setup 
  • notice
  .notice #:notice # $$?="notice message to channel"
  .$iif($me isop #,)
  .notice ops:o $$?="notice message to ops"
  $iif($opcheck(#) || $hopcheck(#),• op con)
  .ban $+ / $l(14,kick): unset %i.nick | %i.chan = # | banpop 
  .protect: unset %i.nick | %i.chan = # | protectpop 
  .blacklist
  ..$l(17,blacklist): %i.nick = $$?="nick/address to blacklist" | %i.chan = # | blacklistpop %i.nick
  ..$l(19,blacklisted list):blacklist
  • IRCops
  ; $iif($server && o isin $usermode, • IRCops)
  .logon/ logoff
  ..log on:oper
  ..log off:mode $me -o
  .operserv
  ..-
  ..admin 
  ...add admin:msg operserv ADMIN add $$?="nick to add as admin"
  ...del admin:msg operserv ADMIN del $$?="nick to delete as admin"
  ...list admin:msg operserv ADMIN list
  ..-
  ..jupe server:msg operserv jupe $$?="enter server" $$?="reason"
  ..news
  ...opernews
  ....add:msg operserv opernews add $$"enter oper news" 
  ....delete:msg operserv opernews del $$"enter #"
  ....list:msg operserv opernews list 
  ...logonnews
  ....add:msg operserv logonnews add &&"enter log on news"
  ....delete:msg operserv logonnews del $$"Enter #"
  ....list:msg operserv logonnews list
  ..Oper List 
  ...Add:msg operserv oper add $$?="Nick to add to Oper list"
  ...Del:msg operserv oper del $$?="Nick to delete from Oper list"
  ...List:msg operserv oper list 
  ..Raw
  ...Raw Text:msg operserv raw $$?="Enter Text" 
  ...Change user's nick:msg operserv raw :operserv svsnick $$?="Old Nick" $$?="New Nick" :0
  ...Join Services
  ....Chanserv:msg operserv raw :chanserv join $$?=" Enter #Channel Name"
  ....Nickserv:msg operserv raw : nickserv join $$?=" Enter #Channel Name"
  ..Set
  ...Set ReadOnly:/msg operserv set readonly $$?="On or Off" 
  ...Set Debug:msg operserv set debug $$?=" On, Off or Number" 
  ..Services
  ...Update:msg operserv update 
  ...Restart:msg operserv restart 
  ...Shutdown (normal):msg operserv shutdown 
  ...Quit (Emergency):msg operserv quit 
  ..-
  ..IRC Operators:/
  ..-
  ..A-Kill (G-line) 
  ...Add Lvl 1:msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *leet@pm2-s11.his.domain.com OR *leet@192.168.127.12" $$?="Enter Reason"
  ...Add Lvl 2:msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *leet@pm*.his.domain.com OR *leet@192.168.127.*" $$?="Enter Reason"
  ...Add Lvl 3:msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *@*.his.domain.com OR *@192.168.127.*" $$?="Enter Reason"
  ...Add Lvl 4(isp ban):msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *@*.domain.com OR *@192.168.*" $$?="Enter Reason"
  ...-
  ...Delete:msg operserv akill del $$?="User@HostMask"
  ...List:msg operserv akill list $$?="User@HostMask or blank"
  ...View:msg operserv akill view $$?="User@HostMask or blank"
  ..Channel Modes
  ...Set Modes:msg operserv mode $$?="Channel" $$?="Modes" 
  ...Clear Modes:msg operserv clearmodes $$?="Channel" 
  ..Global Message:msg operserv global $$?="Message"
  ..Kick User:msg operserv kick $$?="Channel" $$?="Nick" $$?="Reason" 
  ..Stats:msg operserv stats $$?="Akill, All or blank" 
  ..-
  ..Help
  ...Admin:msg operserv help admin
  ...-
  ...Jupe:msg operserv help jupe
  ...News
  ....OperNews:/msg operserv help opernews
  ....LogonNews:msg operserv help logonnews
  ...Oper List:msg operserv help oper
  ...Raw:msg operserv help raw 
  ...Set
  ....Set ReadOnly:/say Sets read-only mode on or off. In read-only mode, normal users will not be allowed to modify any Services data, including channel and nickname access lists, etc. IRCops with sufficient Services privileges will be able to modify Services' AKILL list and drop or forbid nicknames and channels, but any such changes will not be saved unless read-only mode is deactivated before Services is terminated or restarted. This option is equivalent to the command-line option -readonly. Limited to Services admins. 
  ....Set Debug:/say Sets debug mode on or off. In debug mode, all data sent to and from Services as well as a number of other debugging messages are written to the log file. If num is given, debug mode is activated, with the debugging level set to num. This option is equivalent to the command-line option -debug. Limited to Services admins. 
  ...Services
  ....Update:msg operserv help update 
  ....Restart:msg operserv help restart 
  ....Shutdown:/msg operserv help shutdown
  ....Quit:msg operserv help quit 
  ...-
  ...A-Kill:msg operserv help akill
  ...Modes
  ....Mode:msg operserv help mode
  ....Clear Modes:/say Clears all binary modes (i,k,l,m,n,p,s,t) and bans from a channel. If ALL is given, also clears all ops and voices (+o and +v modes) from the channel. Limited to Services operators. ..Global:msg operserv help global
  ...Kick:msg operserv help kick
  ...Stats:msg operserv help stats
  .IRCD Commands
  ..Adchat:adchat $$?="Enter Text"
  ..Chatops:chatops $$?="Enter Text"
  ..-
  ..Globops:globops $$?="Enter Text"
  ..Locops:locops $$?="Enter Text"
  ..Wallops:/wallops $$?="Message"
  ..-
  ..Snotes:snotes $$?="Enter Number"
  ..Snote:snote $$?="Enter text"
  ..-
  ..Trace:trace $$?="Nick or leave blank"
  ..Kill:/kill $$?="user1,user2,user3 etc." $$?="Reason"
  ..Kline:kline $$?="nick or user@host" $$?="reason"
  ..Unkline:unkline $$?="user@host"
  ..Akill:/akill $$?="nick!user@host" $$?="Reason"
  ..Rakill:rakill $$?="nick!user@host"
  ..Gline:gline $$?="user@host" $$?="Seconds" $$?="Reason"
  ..Remgline:remgline $$?="user@host"
  ..Zline:zline $$?="Enter IP"
  ..Shun: shun $$?="nick" $$?="Minutes" $$?="Reason"
  ..Unshun: unshun $$?="nick" 
  ..Local Connect:/connect $$?="Enter Server Name"
  ..Remote Connect:/connect $$?="Enter Server 1" $$?="Enter Port" $$?="Enter Server 2"
  ..Squit:/squit $$?="Enter server to delink from"
  ..Rehash:/rehash
  ..Restart:/restart $$?="Password"
  ..Die:/die $$?="Password
  ..Addline:/addline $$?="Enter Line"
  ..-
  ..Help
  ...Local connect:/echo Links together two servers. Your're on one of servers which is about to link to another. Syntax: /CONNECT <servername>
  ...Remote connect:/echo Links together two servers. Remote = You're not on any of the two servers which are getting linked. Syntax: /CONNECT <server1> <port> <server2>
  ...Server quit:/echo Delinks the server you are on from the specified server. Syntax: /SQUIT <server to delink from>
  ...Kill:/echo Kills the specified user off the server, but the user may reconnect. Syntax: /KILL <user1,user2,user3...> <reason>
  ...Wallops:/echo Sends text to the server, anyone with +w may listen but must be an IRCop to send the message. Syntax: /WALLOPS <message>
  ...Rehash:/echo Reloads the ircd.conf (Used when changes are made in the ircd.conf). Syntax: /REHASH
  ...Restart:/echo Restarts the server you are on. Syntax: /RESTART <possibly need passwd>
  ...Die:/echo Shuts down current irc server. Syntax: /DIE <possibly need passwd>
  ...Akill:/echo Auto-kills and bans the specificed hostmask from the network. Syntax: /AKILL <nick!user@host> <reason>
  ...Rakill:/echo Removes an akill. Syntax: /RAKILL <nick!user@host>
  ...Kline:/echo Adds a local server ban. Syntax: /KLINE <nick> or <user@host> <reason>
  ...Unkline:/echo Removes a kline. Syntax: /UNKLINE <user@host>
  ...Shun:echo Prevents all traffic from the nickname specified in the shun from reaching the server (text, msg, joins, parts, etc).  The time is in minutes, and the user will be automatically unshunned when the time is up.  If you set time for 0, they will be shunned until they disconnect. 
  ...Globops:/echo Sends a message to all opers with +g flag on. Syntax: /GLOBOPS :<text> NOTE: The ':' is required.
  ...Locops:/echo Sends a message to all local irc operators with +g flag. Syntax: /LOCOPS <text>
  ...Chatops:/echo Sends a message to all ircops using +b flag. Syntax: /CHATOPS :<text> NOTE: The ':' is required.
  ...Adchat:/echo Sends a message to all server admins (+A). Syntax: /ADCHAT :<text> NOTE: The ':' is required.
  ...Trace:/echo Shows information about the server or user. Syntax: /TRACE or /TRACE <user>
  ...Server notes:/echo Opers can view messages posted on the server. Syntax: /SNOTES <#>
  ...Server note:/echo Writes a message to the server and is saved to file. Syntax: /SNOTE <text>
  ...Addline:/echo Writes the exact line inputted from irc into the ircd.conf. Limited to only server admins. Syntax: /ADDLINE <line>
  ...Gline:echo Creates a network-ban on the user@host. Also the ban may be timed. Syntax: /GLINE <user@host> <seconds> <reason>
  ...Rem Gline:/echo Removes a gline. Syntax: /REMGLINE <user@host>
  ...zline:echo adds a ban to an IP syntax: zline <IP>s Server operators
  ..server admins
  ...irc operators 
  ...forbid nick:msg nickserv forbid $$?="enter nick"
  ...drop nick:msg nickserv drop $$?="enter nick"
  ...-
  ...forbid channel:msg chanserv forbid $$?="enter #channel"
  ...drop channel:msg chanserv drop $$?="enter #channel"
  ...-
  ...get nick pass:msg nickserv getpass $$?="enter nick"
  ...get chan pass:msg chanserv getpass $$?="enter #channel"
  ...-
  ...connect server:connect $$?="server name ex. roa*"
  ...reHash:rehash
  • popups:popload
  • ctcp
  .ping:.ctcp # ping 
  .$l(20,version):.ctcp # version 
  .$l(21,help):.ctcp # help 
  .$l(22,finger):ctcp # finger
  .$l(23,time):ctcp # time
  .$l(24,userinfo):ctcp # userinfo
  .$l(25,clientInfo):ctcp # clientinfo
  • $l(26,utilities)
  .$l(27,log) #
  ..$l(7,on):log on #  
  ..$l(8,off):log off #  
  • $l(28,media) 
  .$l(29,jukebox)
  ..wav { var %wav $$hfile=" $l(30,Select wave file to play) " $wavedir | _vw jukebox wavdir $nofile(%wav) $+ *.wav | jukebox # $shortfn(%wav) } 
  ..midi { var %mid $$hfile=" $l(31,Select midi file to play) " $mididir | _vw jukebox middir $nofile(%mid) $+ *.mid | jukebox # $shortfn(%mid) } 
  ..mp3 { var %mp3 $$hfile=" $l(32,Select mp3 file to play) " $mp3dir | _vw jukebox mp3dir $nofile(%mp3) $+ *.mp3 | jukebox # $shortfn(%mp3) }
  ..wma { var %wma $$hfile=" $l(33,Select wma file to play) " $_vr(jukebox,wmadir) | _vw jukebox wmadir $nofile(%wma) $+ *.wma | run $shortfn(%wma) | say 15..12wma15.. $nopath(%wma) } 
  • $l(34,stats)
  .$chr(164) $l(35,system):stat 
  .os:stat -os  
  .$l(36,processor):stat -cpu
  .$l(37,memory):stat -mem
  .$l(38,display):stat -display
  .$l(39,sound):stat -sound
  .$l(40,hard drive(s)):stat -hdd
  .$l(41,bios):stat -bios
  .$l(42,connection):stat -connection
  .$l(43,uptime):stat -uptime 
  .-
  .$chr(164) #:halt
  .op - $nick(#,0,o) $+ ( $+ $round($calc($nick(#,0,o) / $nick(#,0) * 100),0) $+  % $+ ):chanstats # ops
  .$l(44,halfop) - $nick(#,0,h) $+ ( $+ $round($calc($nick(#,0,h) / $nick(#,0) * 100),0) $+  % $+ ):chanstats # halfops
  .$l(45,voice) - $nick(#,0,v) $+ ( $+ $round($calc($nick(#,0,v) / $nick(#,0) * 100),0) $+  % $+ ):chanstats # voice
  .$l(46,regular) - $nick(#,0,r) $+ ( $+ $round($calc($nick(#,0,r) / $nick(#,0) * 100),0) $+  % $+ ):chanstats # reg
  .-
  .$l(47,total) - $nick(#,0):chanstats #
  - 
  $l(48,theme)  
  .$l(49,graphics): nexskin
  .$l(50,edit theme):edittheme
  .$l(39,sound): soundcon  
  $l(51,notify list):notalist
}
menu menubar {
  • $l(52,hide window)
  .$l(53,status)
  ..$l(54,hide):scid -a window -hn "Status Window"
  ..$l(55,show):scid -a window -aw "Status Window"
  • $l(1,control panel):cp 
  • $l(56,about):about
  • $l(57,debug):debug @debug
  • nexgen
  .home: frmAB.Load
  .forum: frmAB.Forum
  .software: frmAB.Software
  .scripts: frmAB.Scripts
  .guest book: frmAB.GuestBook
  .staff: frmAB.Staff
  • $l(3,setup)
  .$l(4,timestamping) $chr(91) $+ $_vr(general,timestamp) $+ $chr(93): {
    if ($_vr(general,timestamp) == on) { _vw general timestamp off | timestamp off | haltdef }
    else { _vw general timestamp on | timestamp on | haltdef }
  } 
  .$l(5,event color theme) $chr(91) $+ $group(#colortheme) $+ $chr(93): { if ($group(#colortheme) == on) { .disable #colortheme | if $dialog(color) != $null) { did -b color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } | echo -a •3• $l(5,event color theme) » (3 $l(8,off) ) }
    else { .enable #colortheme | if $dialog(color) != $null) { did -e color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } | echo -a •3• $l(5,event color theme) » ( 3$l(7,on) ) }
  }   
  .nexgen $l(6,sounds) $chr(91) $+ $_vr(setup,sound) $+ $chr(93): { if ($_vr(setup,sound) == on) { _vw setup sound off | echo -a •3• nexgen $l(6,sounds) » (3 $l(8,off) ) }
    else { _vw setup sound on | echo -a •3• nexgen $l(6,sounds) » ( 3$l(7,on) ) }
  }
  .ctcp $l(15,cloak) $chr(91) $+ $_vr(general,cloak) $+ $chr(93): { if ($_vr(general,cloak) == on) { cloak off }
    else { cloak on }
  }
  .-
  .$l(9,more) ...:setup 
  • popups:popload
  • $l(26,utilities) 
  • $l(28,media) 
  -
  setedit: setedit
}
menu status {
  $submenu($dserver($1))
  $iif($server == $null,$style(2)) • $l(58,server)
  .$server:halt
  .-
  .disconnect:if ($server != $null) { disconnect } 
  .motd:motd
  .$l(59,links):links
  .$l(60,server version):version
  • $l(1,clear):clear
  • $l(2,tray):showmirc -t | tray -i1 acidmax.ico
  • IRCops
  ; $iif($server && o isin $usermode, • IRCops)
  .logon/ logoff
  ..log on:oper
  ..log off:mode $me -o
  .operserv
  ..-
  ..admin 
  ...add admin:msg operserv ADMIN add $$?="nick to add as admin"
  ...del admin:msg operserv ADMIN del $$?="nick to delete as admin"
  ...list admin:msg operserv ADMIN list
  ..-
  ..jupe server:msg operserv jupe $$?="enter server" $$?="reason"
  ..news
  ...opernews
  ....add:msg operserv opernews add $$"enter oper news" 
  ....delete:msg operserv opernews del $$"enter #"
  ....list:msg operserv opernews list 
  ...logonnews
  ....add:msg operserv logonnews add &&"enter log on news"
  ....delete:msg operserv logonnews del $$"Enter #"
  ....list:msg operserv logonnews list
  ..Oper List 
  ...Add:msg operserv oper add $$?="Nick to add to Oper list"
  ...Del:msg operserv oper del $$?="Nick to delete from Oper list"
  ...List:msg operserv oper list 
  ..Raw
  ...Raw Text:msg operserv raw $$?="Enter Text" 
  ...Change user's nick:msg operserv raw :operserv svsnick $$?="Old Nick" $$?="New Nick" :0
  ...Join Services
  ....Chanserv:msg operserv raw :chanserv join $$?=" Enter #Channel Name"
  ....Nickserv:msg operserv raw : nickserv join $$?=" Enter #Channel Name"
  ..Set
  ...Set ReadOnly:/msg operserv set readonly $$?="On or Off" 
  ...Set Debug:msg operserv set debug $$?=" On, Off or Number" 
  ..Services
  ...Update:msg operserv update 
  ...Restart:msg operserv restart 
  ...Shutdown (normal):msg operserv shutdown 
  ...Quit (Emergency):msg operserv quit 
  ..-
  ..IRC Operators:/
  ..-
  ..A-Kill (G-line) 
  ...Add Lvl 1:msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *leet@pm2-s11.his.domain.com OR *leet@192.168.127.12" $$?="Enter Reason"
  ...Add Lvl 2:msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *leet@pm*.his.domain.com OR *leet@192.168.127.*" $$?="Enter Reason"
  ...Add Lvl 3:msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *@*.his.domain.com OR *@192.168.127.*" $$?="Enter Reason"
  ...Add Lvl 4(isp ban):msg operserv AKILL add $$?="Enter Time(+d,h or m, +0 perm)" $$?="Enter User@Host.Mask *@*.domain.com OR *@192.168.*" $$?="Enter Reason"
  ...-
  ...Delete:msg operserv akill del $$?="User@HostMask"
  ...List:msg operserv akill list $$?="User@HostMask or blank"
  ...View:msg operserv akill view $$?="User@HostMask or blank"
  ..Channel Modes
  ...Set Modes:msg operserv mode $$?="Channel" $$?="Modes" 
  ...Clear Modes:msg operserv clearmodes $$?="Channel" 
  ..Global Message:msg operserv global $$?="Message"
  ..Kick User:msg operserv kick $$?="Channel" $$?="Nick" $$?="Reason" 
  ..Stats:msg operserv stats $$?="Akill, All or blank" 
  ..-
  ..Help
  ...Admin:msg operserv help admin
  ...-
  ...Jupe:msg operserv help jupe
  ...News
  ....OperNews:/msg operserv help opernews
  ....LogonNews:msg operserv help logonnews
  ...Oper List:msg operserv help oper
  ...Raw:msg operserv help raw 
  ...Set
  ....Set ReadOnly:/say Sets read-only mode on or off. In read-only mode, normal users will not be allowed to modify any Services data, including channel and nickname access lists, etc. IRCops with sufficient Services privileges will be able to modify Services' AKILL list and drop or forbid nicknames and channels, but any such changes will not be saved unless read-only mode is deactivated before Services is terminated or restarted. This option is equivalent to the command-line option -readonly. Limited to Services admins. 
  ....Set Debug:/say Sets debug mode on or off. In debug mode, all data sent to and from Services as well as a number of other debugging messages are written to the log file. If num is given, debug mode is activated, with the debugging level set to num. This option is equivalent to the command-line option -debug. Limited to Services admins. 
  ...Services
  ....Update:msg operserv help update 
  ....Restart:msg operserv help restart 
  ....Shutdown:/msg operserv help shutdown
  ....Quit:msg operserv help quit 
  ...-
  ...A-Kill:msg operserv help akill
  ...Modes
  ....Mode:msg operserv help mode
  ....Clear Modes:/say Clears all binary modes (i,k,l,m,n,p,s,t) and bans from a channel. If ALL is given, also clears all ops and voices (+o and +v modes) from the channel. Limited to Services operators. ..Global:msg operserv help global
  ...Kick:msg operserv help kick
  ...Stats:msg operserv help stats
  .IRCD Commands
  ..Adchat:adchat $$?="Enter Text"
  ..Chatops:chatops $$?="Enter Text"
  ..-
  ..Globops:globops $$?="Enter Text"
  ..Locops:locops $$?="Enter Text"
  ..Wallops:wallops $$?="Message"
  ..-
  ..Snotes:snotes $$?="Enter Number"
  ..Snote:snote $$?="Enter text"
  ..-
  ..Trace:trace $$?="Nick or leave blank"
  ..Kill:kill $$?="user1,user2,user3 etc." $$?="Reason"
  ..Kline:/kline $$?="nick or user@host" $$?="reason"
  ..Unkline:unkline $$?="user@host"
  ..Akill:akill $$?="nick!user@host" $$?="Reason"
  ..Rakill:rakill $$?="nick!user@host"
  ..Gline:gline $$?="user@host" $$?="Seconds" $$?="Reason"
  ..Remgline:remgline $$?="user@host"
  ..Zline:/zline $$?="Enter IP"
  ..Shun: shun $$?="nick" $$?="Minutes" $$?="Reason"
  ..Unshun: unshun $$?="nick" 
  ..Local Connect:/connect $$?="Enter Server Name"
  ..Remote Connect:/connect $$?="Enter Server 1" $$?="Enter Port" $$?="Enter Server 2"
  ..Squit:/squit $$?="Enter server to delink from"
  ..Rehash:/rehash
  ..Restart:/restart $$?="Password"
  ..Die:/die $$?="Password
  ..Addline:/addline $$?="Enter Line"
  ..-
  ..Help
  ...Local connect:/echo Links together two servers. Your're on one of servers which is about to link to another. Syntax: /CONNECT <servername>
  ...Remote connect:/echo Links together two servers. Remote = You're not on any of the two servers which are getting linked. Syntax: /CONNECT <server1> <port> <server2>
  ...Server quit:/echo Delinks the server you are on from the specified server. Syntax: /SQUIT <server to delink from>
  ...Kill:/echo Kills the specified user off the server, but the user may reconnect. Syntax: /KILL <user1,user2,user3...> <reason>
  ...Wallops:/echo Sends text to the server, anyone with +w may listen but must be an IRCop to send the message. Syntax: /WALLOPS <message>
  ...Rehash:/echo Reloads the ircd.conf (Used when changes are made in the ircd.conf). Syntax: /REHASH
  ...Restart:/echo Restarts the server you are on. Syntax: /RESTART <possibly need passwd>
  ...Die:/echo Shuts down current irc server. Syntax: /DIE <possibly need passwd>
  ...Akill:/echo Auto-kills and bans the specificed hostmask from the network. Syntax: /AKILL <nick!user@host> <reason>
  ...Rakill:/echo Removes an akill. Syntax: /RAKILL <nick!user@host>
  ...Kline:/echo Adds a local server ban. Syntax: /KLINE <nick> or <user@host> <reason>
  ...Unkline:/echo Removes a kline. Syntax: /UNKLINE <user@host>
  ...Shun:/echo Prevents all traffic from the nickname specified in the shun from reaching the server (text, msg, joins, parts, etc).  The time is in minutes, and the user will be automatically unshunned when the time is up.  If you set time for 0, they will be shunned until they disconnect. 
  ...Globops:/echo Sends a message to all opers with +g flag on. Syntax: /GLOBOPS :<text> NOTE: The ':' is required.
  ...Locops:/echo Sends a message to all local irc operators with +g flag. Syntax: /LOCOPS <text>
  ...Chatops:/echo Sends a message to all ircops using +b flag. Syntax: /CHATOPS :<text> NOTE: The ':' is required.
  ...Adchat:/echo Sends a message to all server admins (+A). Syntax: /ADCHAT :<text> NOTE: The ':' is required.
  ...Trace:/echo Shows information about the server or user. Syntax: /TRACE or /TRACE <user>
  ...Server notes:/echo Opers can view messages posted on the server. Syntax: /SNOTES <#>
  ...Server note:/echo Writes a message to the server and is saved to file. Syntax: /SNOTE <text>
  ...Addline:/echo Writes the exact line inputted from irc into the ircd.conf. Limited to only server admins. Syntax: /ADDLINE <line>
  ...Gline:echo Creates a network-ban on the user@host. Also the ban may be timed. Syntax: /GLINE <user@host> <seconds> <reason>
  ...Rem Gline:/echo Removes a gline. Syntax: /REMGLINE <user@host>
  ...zline:echo adds a ban to an IP syntax: zline <IP>s Server operators
  ..server admins
  ...irc operators 
  ...forbid nick:msg nickserv forbid $$?="enter nick"
  ...drop nick:msg nickserv drop $$?="enter nick"
  ...-
  ...forbid channel:msg chanserv forbid $$?="enter #channel"
  ...drop channel:msg chanserv drop $$?="enter #channel"
  ...-
  ...get nick pass:msg nickserv getpass $$?="enter nick"
  ...get chan pass:msg chanserv getpass $$?="enter #channel"
  ...-
  ...connect server:connect $$?="server name ie: roa*"
  ...reHash:rehash
  • $l(1,control panel):frmCP.Reload
  • nexgen
  .home: frmAB.Homepage
  .forum: frmAB.Forum
  .software: frmAB.Software
  .scripts: frmAB.Scripts
  .guest book: frmAB.GuestBook
  .staff: frmAB.Staff

  • $l(3,setup)
  .$l(4,timestamping) $chr(91) $+ $_vr(general,timestamp) $+ $chr(93): {
    if ($_vr(general,timestamp) == on) { _vw general timestamp off | timestamp off | haltdef }
    else { _vw general timestamp on | timestamp on | haltdef }
  } 
  .$l(5,event color theme) $chr(91) $+ $group(#colortheme) $+ $chr(93): { if ($group(#colortheme) == on) { .disable #colortheme | if $dialog(color) != $null) { did -b color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } | echo -a •3• $l(5,event color theme) » (3 $l(8,off) ) }
    else { .enable #colortheme | if $dialog(color) != $null) { did -e color 2,3,4,5,7,9,11,13,15,17,19,21,27,25,29,23,31,37,39,33,35 } | echo -a •3• $l(5,event color theme) » ( 3$l(7,on) ) }
  }   
  .nexgen $l(6,sounds) $chr(91) $+ $_vr(setup,sound) $+ $chr(93): { if ($_vr(setup,sound) == on) { _vw setup sound off | echo -a •3• nexgen $l(6,sounds) » (3 $l(8,off) ) }
    else { _vw setup sound on | echo -a •3• nexgen $l(6,sounds) » ( 3$l(7,on) ) }
  }
  .ctcp $l(15,cloak) $chr(91) $+ $_vr(general,cloak) $+ $chr(93): { if ($_vr(general,cloak) == on) { cloak off }
    else { cloak on }
  }
  .-
  .$l(9,more) ...:setup 
  • $l(52,hide window):window -hn "Status Window"
  • popups:popload
  • $l(26,utilities)
  • $l(28,media) 
  .$l(61,jukebox)
  ..wav { var %wav $$hfile=" $l(30,Select wave file to play) " $wavedir | _vw jukebox wavdir $nofile(%wav) $+ *.wav | jukebox # $shortfn(%wav) } 
  ..midi { var %mid $$hfile=" $l(31,Select midi file to play) " $mididir | _vw jukebox middir $nofile(%mid) $+ *.mid | jukebox # $shortfn(%mid) } 
  ..mp3 { var %mp3 $$hfile=" $l(32,Select mp3 file to play) " $mp3dir | _vw jukebox mp3dir $nofile(%mp3) $+ *.mp3 | jukebox # $shortfn(%mp3) }
  ..wma { var %wma $$hfile=" $l(33,Select wma file to play) " $_vr(jukebox,wmadir) | _vw jukebox wmadir $nofile(%wma) $+ *.wma | run $shortfn(%wma) | say 15..12wma15.. $nopath(%wma) } 
  -
  setedit: setedit
  $l(51,notify list):notalist
}
menu nicklist {
  • $l(62,info)
  .$address($snick(#,1),0):halt
  .$duration($nick($active,$1).idle) $l(63,idle in) #:halt 
  .-
  .$l(64,refresh): .who # 
  • $l(65,query):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { query $snick(#,%t2) | inc %t2 1 } }
  • $l(10,notice): notice $$1 $?=" $l(66,notice message) "
  • uwho: uwho $$1
  • whois:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { whois $snick(#,%t2) | inc %t2 1 } }
  • dns:dns $$1
  • popups:popload
  • $l(26,utilities) 
  • dcc
  .$l(67,send): raw -q notice $1 : $l(68,Preparing for DCC file transfer.) | dcc send $$1 
  .$l(70,chat):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { dcc chat $snick(#,%t2) | inc %t2 1 } }
  .fserve:fserve $$1 $?=" $l(71,how many file gets:) " $$sdir=" $l(69,Path for user to get files:) "  txt\welcome.txt
  .$iif(*.dal.net iswm $server,dccallow)
  ..$l(72,add):{ .quote dccallow + $+ $$1 | echo -a •12• dcc $l(74,allow) » (12 $$1 ) $l(75,added) }
  ..$l(73,remove):{ .quote dccallow - $+ $$1 | echo -a •12• dcc $l(74,allow) » (12 $$1 ) $l(76,removed) }
  • ctcp
  .ping:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) ping | inc %t2 1 } }
  .$l(20,version):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) version | inc %t2 1 } }
  .$l(21,help):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) help | inc %t2 1 } }
  .$l(22,finger):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) finger | inc %t2 1 } }
  .$l(23,time):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) time | inc %t2 1 } }
  .userinfo:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) userinfo | inc %t2 1 } }
  .clientinfo:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { ctcp $snick(#,%t2) clientinfo | inc %t2 1 } }
  .xdcc
  ..$l(77,list):.ctcp $1 xdcc list
  ..$l(78,get):.ctcp $1 xdcc get $?=" $l(79,please enter xdcc packet number) "
  .-
  .$l(80,custom):ctcp $1 $?=" $l(81,please enter a ctcp request) "
  $iif($opcheck(#),• op con)
  .op 
  ..op:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # +o $snick(#,%t2) | inc %t2 1 } } 
  ..deop:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # -o $snick(#,%t2) | inc %t2 1 } }
  ..-
  ..auto-op: %i.nick = $$1 | %i.chan = # | aopop $$1
  ..auto-op $l(77,list):aoplist
  $iif($network != undernet,halfop)
  ..halfop:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # +h $snick(#,%t2) | inc %t2 1 } }
  ..dehalfop:{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # -h $snick(#,%t2) | inc %t2 1 } }
  .$l(45,voice)
  ..$l(45,voice):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # +v $snick(#,%t2) | inc %t2 1 } }
  ..$l(82,devoice):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # -v $snick(#,%t2) | inc %t2 1 } }
  ..-
  ..$l(83,auto-voice): %i.nick = $$1 | %i.chan = # | avpop $$1
  ..$l(84,auto-voice list):voicelist
  .$l(14,kick) 
  ..$l(14,kick):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { kick # $snick(#,%t2) | inc %t2 1 } }
  ..$l(14,kick) (?):kickr2 $$?=" $l(85,enter kick reason) "
  .$l(13,ban)
  ..$l(13,ban) (multi):banr
  ..-
  ..$address($snick(#,1),0):$odeop(#,$$1) | ban # $1 0
  ..$address($snick(#,1),1):$odeop(#,$$1) | ban # $1 1
  ..$address($snick(#,1),2):$odeop(#,$$1) | ban # $1 2
  ..$address($snick(#,1),3):$odeop(#,$$1) | ban # $1 3
  ..$address($snick(#,1),4):$odeop(#,$$1) | ban # $1 4
  ..-
  .$l(13,ban) $+ / $l(14,kick)
  ..$l(13,ban) $+ / $l(14,kick): %i.nick = $$1 | %i.chan = # | banpop $$1
  ..$l(86,ban/ kick (multi)):bankickr 
  .$l(87,protect): %i.nick = $$1 | %i.chan = # | protectpop $$1
  .$l(17,blacklist)
  ..$l(17,blacklist): %i.nick = $$1 | %i.chan = # | blacklistpop $$1
  ..$l(19,blacklisted list):blacklist
  $iif($hopcheck(#),• op con)
  .$l(45,voice)
  ..$l(45,voice):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # +v $snick(#,%t2) | inc %t2 1 } }
  ..$l(82,devoice):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { mode # -v $snick(#,%t2) | inc %t2 1 } }
  .$l(14,kick) 
  ..$l(14,kick):{ var %t = $snick(#,0) | var %t2 = 1 | while (%t2 <= %t) { kick # $snick(#,%t2) | inc %t2 1 } }
  ..$l(14,kick) (?):kickr2 $$?="enter kick reason"
  .$l(13,ban)
  ..$l(88,ban (multi)):banr
  ..-
  ..$address($snick(#,1),0):$odeop(#,$$1) | ban # $1 0
  ..$address($snick(#,1),1):$odeop(#,$$1) | ban # $1 1
  ..$address($snick(#,1),2):$odeop(#,$$1) | ban # $1 2
  ..$address($snick(#,1),3):$odeop(#,$$1) | ban # $1 3
  ..$address($snick(#,1),4):$odeop(#,$$1) | ban # $1 4
  ..-
  .$l(13,ban) $+ / $l(14,kick)
  ..$l(13,ban) $+ / $l(14,kick): %i.nick = $$1 | %i.chan = # | banpop $$1
  ..$l(86,ban/ kick (multi)):bankickr 
  .$l(87,protect): %i.nick = $$1 | %i.chan = # | protectpop $$1
  .$l(17,blacklist)
  ..$l(17,blacklist): %i.nick = $$1 | %i.chan = # | blacklistpop $$1
  ..$l(19,blacklisted list):blacklist
  - 
  $l(89,invite): invite $1 $$?="channel to invite to:"
  $l(90,add notify):%v.nick = $1 | add_notify 
  supa slap:%sslap = $1 | %sslapc = $chan | supaslap
}
alias -l dserver {
  if ($server == $null) { 
    if ($1 == begin) return -
    if ($1 == 1) return connect:server 
    if ($1 == end) return -
  }
}
alias -l dnetwork {
  if ($network != $null) { 
    if ($1 == 1) return $server 
  }
}
alias -l dccallow {
  if ($network == DALnet) { 
    if ($1 == 1) return .dcc allow:dccallow - $+ $snick(#,1) 
  }
}
alias _ssr {
  if ($exists(data\supaslap.ini) == $false) { mkdir data | write -c data\supaslap.ini }
  return $readini data\supaslap.ini $$1 $$2 
}
alias _ssw {
  if ($exists(data\supaslap.ini) == $false) { mkdir data | write -c data\supaslap.ini }
  writeini data\supaslap.ini $$1 $$2 $$3-
}
alias _ssrem {
  if ($exists(data\supaslap.ini) == $false) { mkdir data | write -c data\supaslap.ini }
  remini data\supaslap.ini $$1 $$2 
}
alias supaslap if ($dialog(supaslap) == $null) { dialog -m supaslap supaslap | click } 
dialog supaslap {
  title "supaslap"
  size -1 -1 81 106
  option dbu
  text "victim:", 4, 2 3 16 8
  text "", 5, 19 3 58 8
  tab "slap", 6, 2 11 77 91
  list 1, 10 35 61 41, tab 6 size vsbar
  button "SLAP!", 3, 21 88 37 12, disable tab 6 ok
  text "slap with:", 2, 11 27 25 8, tab 6
  button "remove", 13, 55 78 22 9, disable tab 6
  tab "add slap", 7
  text "name of slap(use one word):", 8, 6 29 70 8, tab 7
  edit "", 9, 6 38 70 10, tab 7 autohs
  edit "", 10, 6 58 70 10, tab 7 autohs
  text "slap with(ie: a smelly carp):", 11, 6 49 66 8, tab 7
  button "ADD!", 12, 21 79 37 12, disable tab 7
}

alias -l slaplist {
  did -r supaslap 1 
  var %s1 = $lines(data\supaslap.txt) 
  var %s = 1
  while (%s <= %s1) { did -a supaslap 1 $read(data\supaslap.txt,%s) | inc %s 1 }
}
on *:dialog:supaslap:init:*:{
  did -o supaslap 5 1 %sslap 
  slaplist
}
on *:dialog:supaslap:edit:*:{
  if ($did == 9) && ($did(supaslap,9).text != $null) && ($did(supaslap,10).text != $null) { did -e supaslap 12 } 
  if ($did == 10) && ($did(supaslap,10).text != $null) && ($did(supaslap,9).text != $null) { did -e supaslap 12 } 
}
on *:dialog:supaslap:sclick:*:{
  if ($did == 1) { did -e supaslap 3,13 }
  if ($did == 3) { describe %sslapc slaps %sslap $_ssr($did(supaslap,1).seltext,slap) | unset %sslap | unset %sslapc | click }  
  if ($did == 12) { 
    _ssw $did(supaslap,9).text slap $did(supaslap,10).text | write data\supaslap.txt $did(supaslap,9).text
    did -r supaslap 9,10
    did -b supaslap 12
    slaplist
    click
  }
  if ($did == 13) { 
    remini data\supaslap.ini $did(supaslap,1).seltext  | write -ds $+ $did(supaslap,1).seltext data\supaslap.txt
    slaplist
    click  
  }
}
