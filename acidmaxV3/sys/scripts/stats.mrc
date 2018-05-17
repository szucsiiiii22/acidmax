;DarkEngine Professional 3.xx
;http://www.darkengine.net/

on *:load:{ echo -ae DarkEngine installed sucessfully... | dek 3 | fde }

alias morse { msg $active $dll(sys\dlls\darkenginex.dll,morse,$1-) }

alias mobo_manu { dem Mainboard Manufacturer: $de(mainboard_manufacturer) }
alias mobo_name { dem Mainboard: $de(mainboard_productname) }
alias mobo_ver { dem Mainboard Version: $de(mainboard_version) }

alias bios_ver { dem Bios Version: $de(bios_version) }

alias mem_slots { dem Total Memory Slots: $de(mem_totalslots) }

alias cpu_socket { dem CPU Socket: $de(cpu_socket) }

;Customizable Aliases
alias sysinfo { dem OS: $de(os)  $+ $dek $+ CPU: $de(cpuinfo) $+ ,  $de(cpuspeed)  $+ $dek $+ Video:  $de(monitor) on $de(videocard) ( $+ $de(res) $+ )  $+ $dek $+ Sound: $de(soundcard)  $+ $dek $+ Memory: Used: $de(usedphysicalmem) $+ / $+ $de(totalphysicalmem) $+ MB  $+ $dek $+ Uptime: $de(uptime)  $+ $dek $+ HD: Free: $de(hdspace)  $+ $dek $+ Connection: $de(conn) }
alias pamp { set %wamp.format is listening to  " $+ &a $+  " .: $+ &b / &c / &d - &e $+ / $+ &f $+ :. | me $dll(sys\dlls\darkenginex.dll,parsewinamp,%wamp.format) | unset %wamp.format }

alias isys { $dll(sys\dlls\darkenginex.dll,submitspecs,$me) }
alias cver { $de(checkver) }

alias totband { msg $active  $+ $dek $+ Downstream: $de(banddown)  KBytes/s  $+ $dek $+  Upstream: $de(bandup) KBytes/s }
alias tottrans { msg $active  $+ $dek $+ Downloaded: $de(total_down) MB  $+ $dek $+  Uploaded: $de(total_up) MB }

alias cpuinfo { dem CPU: $de(cpuinfo) $+ , $de(cpuspeed) $+ , $de(cpuL2cache) ( $+ $de(cpuload) Load $+ ) }

alias l1cache { dem L1 Cache: $de(cpuL1cache) }
alias l2cache { dem L2 Cache: $de(cpuL2cache) }
alias l3cache { dem L3 Cache: $de(cpuL3cache) }
alias biosname { dem Bios: $de(bios_vendor) }
alias biosdate { dem Bios Date: $de(bios_releasedate) }
alias winstall { dem Installed On: $de(installdate) }

alias cputemp { dem Temp: $de(mbm5cputemp) }
alias voltage { dem Voltage: $de(mbm5volt) }
alias fan { dem Fan: $de(mbm5fan) }

alias cpuload { dem CPU Load: $de(cpuload) }
alias cpuarch { dem CPU Architecture: $de(cpuarchitech) }
alias cpucount { dem CPU Count: $de(cpucount) }
alias videomem { dem Video Memory: $dll(sys\dlls\darkenginex.dll,videomem,_) MB }
alias oldhd { msg $active $dll(sys\dlls\darkenginex.dll,hdspaceold,_) }

alias psver { dem Pixel Shader Version: $de(ps) }

;Encrytion Aliases
alias encr { det encryption $1- } 
alias decr { det decryption $1- } 

;Info Aliases
alias about { $de(about) }
;alias descript { /me is using de.mrc v1.17.99 (written by: apexad (dll: Aprentice)) }
alias descript { $dll(sys\dlls\darkenginex.dll,about,script) }
alias newabout { about | descript }
alias hd { dem HD: $de(hdspace) }
alias hdspace { det spechdspace $1 }
alias osver { dem Operating System: $de(os) }
alias winuser { dem Windows User: $de(username) }
alias osinfo { dem OS info: $de(username) on $de(os) }
alias wamp { $de(winamp) }
alias cpu { dem CPU: $de(cpuinfo) }
alias cpuspeed { dem CPU Speed: $de(cpuspeed) }
alias cpudetail { dem CPU Details: $de(cpudetails) }
alias cpuinfo { dem CPU: $de(cpuinfo) $+ , $de(cpuspeed) }
alias uptime { dem Uptime: $de(uptime) }
alias luptime { dem Uptime: $de(uptimelong) }
alias memload { dem Memory Load: $de(memoryload) }
alias vmem { dem Avaliable Virtual Memory: $de(availvirtualmem) MB }
alias vusedmem { dem Virtual Memory Used: $de(usedvirtualmem) MB }
alias vtotalmem { dem Total Virtual Memory: $de(totalvirtualmem) MB }
alias mem { dem Avaliable Physical Memory: $de(availphysicalmem) MB }
alias usedmem { dem Used Physical Memory: $de(usedphysicalmem) MB }
alias totalmem { dem Total Physical Memory: $de(totalphysicalmem) MB }
alias memratio { dem RAM: Used: $de(usedphysicalmem) $+ / $+ $de(totalphysicalmem) $+ MB }
alias vmemratio { dem Virtual Memory: Used: $de(usedvirtualmem) $+ / $+ $de(totalvirtualmem) $+ MB }
alias pmemratio { dem Page File: Used: $de(usedPageFilemem) $+ / $+ $de(totalPageFilemem) $+ MB }
alias drunk { det drunk $1- }
alias leet { det leet $1- }
alias rev { det reverse $1- }
alias wave { $de(wave) }
alias ascii2bin { det ascii2bin $1- }
alias monitor { dem Monitor: $remove($de(monitor),Color,Monitor) }
alias videocard { dem Video Card: $de(videocard) }
alias secvidcard { dem Secondary Video Card: $de(sec_videocard) }
alias totvideocard { dem Video Cards Installed: $de(total_videocards) }
alias res { dem Resolution: $de(res) }
alias video { dem Video: $remove($de(monitor),Color,-Monitor) on $de(videocard)  $chr(40) $+ $de(res) $+ $chr(41) }
alias batlife { dem Battery Life: $de(BatteryLifeLeft) }
alias batcharge { dem Battery Charged: $de(BatteryChargeStatus) }
alias batpower { dem Battery Power: $de(ACPowerStatus) }
alias soundcard { dem Sound Card: $de(soundcard) }
alias conn { dem Connection: $de(conn) }
alias band { dem Current Downstream: $de(banddown) KBytes/s }
alias upband { dem Current Upstream: $de(bandup) KBytes/s }
alias sys { dem  $+ $replace($de(sysinfo),3, $+ $dek $+ ,-Monitor,,Color,) }
alias record { dem Record Uptime: $de(recorduptime) }
alias keyenc { det keyencryption $1- }
alias keydec { det keydecryption $1- }
alias chadapter { $de(change_adapter) }
alias totaldown { dem Total Downloaded: $de(total_down) $+ MB }
alias totalup { dem Total Uploaded: $de(total_up) $+ MB }
alias hdtotal { dem Total Free: $de(totalhdspacefree) $+ / $+ $de(totalhdspace) }
alias playwinamp { $de(winampplay) }
alias next { $de(winampnext) }
alias prev { $de(winampprev) }
alias stopwinamp { $de(winampstop) }
alias pausewinamp { $de(winamppause) }
alias verwinamp { dem Winamp Version: $de(winampver) }

alias config_fkeyscript  { $dll(sys\dlls\darkenginex.dll,show_funckey_config,_) }

;DE Aliases (NO EDITING!)
alias fde { flushini de.ini }
alias de { return $dll(sys\dlls\darkenginex.dll,$1,_) }
alias det { if (key isin $1) { msg $active $remove($dll(sys\dlls\darkenginex.dll,$1,$2-),$left($2,2)) } | else { dem  $+ $dll(sys\dlls\darkenginex.dll,$1,$2-) } }
alias dem { msg $active  $+ $dek $+  $+ $1- } 
alias deq { return $$?="Enter message/text" }
alias dek { if ($isid == $true) { return $readini(de.ini,options,color) } | if ($isid == $false) { writeini de.ini options color $remove($1,) | flushini de.ini } }

; DarkEngine script menus
menu channel,query {
  -
  System Information.:/sys
  -
  Post Specs Online:/isys
  -
  Operating System
  .Version:/osver
  .Username:/winuser
  .Install Date:/winstall
  Processor Details
  .Name:/cpu
  .Load:/cpuload
  .Clock Speed:/cpuspeed
  .-
  .CPU Count:/cpucount
  .Model Details:/cpudetail
  .Architecture:/cpuarch
  .Socket:/cpu_socket
  .-
  .L1 Cache:/l1cache
  .L2 Cache:/l2cache
  .L3 Cache:/l3cache
  .-
  .Show All:/cpuinfo
  Memory
  .Memory Load:/memload
  .-
  .Physical Memory:/memratio
  .Paged Memory:/pmemratio
  .-
  .Total Memory Slots:/mem_slots
  Hard Drive
  .All Disks: /hd
  .Total Space:/hdtotal
  Uptime
  .System Uptime:/luptime
  .Record Uptime:/record
  Video
  .Monitor:/monitor
  .Resolution:/res
  .-
  .Primary Video Card:/videocard
  .Secondary Video Card:/secvidcard
  .Video Cards Installed:/totvideocard
  .-
  .Show All:/video
  Sound Card:/soundcard
  Internet
  .Connection Info:/conn
  .-
  .Upstream Usage:/upband
  .Downstream Usage :/band
  .Total Bandwidth Usage:/totband
  .-
  .Total Transferred:/tottrans
  .-
  .Change Adapter:/chadapter
  Mainboard
  .Product Name:/mobo_name
  .Manufacturer:/mobo_manu
  .Version:/mobo_ver

  System Bios
  .Bios Name:/biosname
  .Bios Date:/biosdate
  .Bios Version:/bios_ver
  Motherboard Monitor
  .Temperature:/cputemp
  .Voltage:/voltage
  .Fan Speed:/fan
  Battery (Laptops Only)
  .Life Remaining:/batlife
  .Charge Status:/batcharge
  .Power Status:/batpower
  -
  Winamp
  .Current Playing:/wamp
  .-
  .Play:/playwinamp
  .Pause:/pausewinamp
  .Stop:/stopwinamp
  .Prev:/prev
  .Next:/next
  .-
  Misc Functions
  .Encryption
  ..Encrypt Text:/encr $$deq
  ..Decrypt Text:/decr $$deq
  ..Key Encrypt Text:/keyenc $$?="Enter a 2 digit number (the key)" $$deq
  ..Key Decrypt Text:/keydec $$?="Enter the key" $+ $$deq
  .Text Manipulation
  ..Leet:/leet $$deq
  ..Drunk:/drunk $$deq
  ..Wave:/wave
  ..Reverse:/rev $$deq
  ..Morse:/morse $$deq
  ..Ascii to Binary:/ascii2bin $$deq
  Script Configuration
  .Function Keys:/config_fkeyscript
  -
  Help
  .About:/about
  .-
  .Check For Updates:/cver
}
