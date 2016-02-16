;nexDVD 2.12 / 2.11 (Express)
;http://team-nexgen.com
;guide_X@live.com

alias nexdvddll { return sys\nexDVD.dll }
on *:load:{ echo -a  4 nexDVD Express v2.0 | echo -a  4Type: '/dll nexdvd.dll playdvd' to start dvd playback }

alias nexdvdexe { 
  run sys\nexDVD.exe | click
}

menu query,channel,status,menubar {
  • media
  .nexdvd: run sys\NexDVD.exe | click
  .nexdvd dll (old)
  ..nexdvd
  ..-
  ..play (full screen mode): dll -u $nexdvddll | .timer 1 1 dll $nexdvddll playdvd_fsm
  ..play (windowed): dll -u $nexdvddll | .timer 1 1 dll $nexdvddll playdvd
  ..pause: dll $nexdvddll pausedvd
  ..stop: dll $nexdvddll stopdvd
  ...-
  ..fast forward: dll $nexdvddll fastforward
  ..rewind: dll $nexdvddll rewinddvd
  ..go to time: dll $nexdvddll gotime
  ..-
  ..chapter
  ...choose chapter...: dll $nexdvddll gochapter
  ...-
  ...next chapter: dll $nexdvddll forwardchapter
  ...previous chapter: dll $nexdvddll backwardchapter
  ..menu
  ...root menu: dll $nexdvddll navigatemenu
  ...titles menu: dll $nexdvddll titlemenu
  ..bookmark
  ...save bookmark: dll $nexdvddll savebookmark
  ...go to bookmark: dll $nexdvddll gobookmark
  ..-
  ..options
  ...set on top: dll $nexdvddll setontop
  ...remove from top: dll $nexdvddll removefromtop
  ...-
  ...angle..: dll $nexdvddll goangle
  ...audio stream..: dll $nexdvddll getaudiostream
  ...select disc: dll $nexdvddll selectdisc
  ...about..: dll $nexdvddll aboutscreen
  ...-
  ...enter fullscreen: dll $nexdvddll startfullscreen
  ...exit fullscreen: dll $nexdvddll stopfullscreen
  ..-
  ..close: dll -u $nexdvddll
}
