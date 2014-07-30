; tetris
; guide_X@live.com

alias frmTetris.Init {
  .comopen lTetris Tetris.clsTetris
  if ($comerr) {
    .comreg games\tetris\tetris.dll
    .comopen lTetris Tetris.clsTetris
    if ($comerr) halt
  }
}

alias frmTetris.Load {
  window -rik +te @tetris 40 20 540 412 acidmax.ico
  var %k = $com(lTetris,StartTetris,3,bstr,$window(@tetris).hwnd)
}

alias frmTetris.Reload {
  var %k = $com(lTetris,StartTetris,3,bstr,$window(@tetris).hwnd)
}

alias frmTetris.Unload {
  .comclose lTetris
}