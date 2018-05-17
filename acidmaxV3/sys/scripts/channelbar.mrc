alias -l wfx.load { 
  var %t = winfx. $+ $chan $+ . $+ $cid winfx
  if ($dialog(%t)) != $null) { 
    dialog -m winfx. $+ $chan $+ . $+ $cid winfx | .timer -m 1 5 scid $cid window -a $chan 
  }  
} 
alias -l wfx { dll sys\dlls\windowfx.dll $1- }
alias -l mdx { dll sys\dlls\mdx.dll $1- }
alias -l bars { return sys\dlls\bars.mdx }

dialog winfx {
  title "wFX"
  size 0 0 516 0
  option dbu
  list 1, 0 -1 120 10, size
}



;we use a .* on the dialog name because we will be calling many of the same dialog tables, just assigning them different dialog names when we call them.
on *:dialog:winfx.*:sclick:1: {
  echo #nexgen 4channel toobar: $did(1).sel
  if ($did(1).sel == 3) { channel $active }
  elseif ($did(1).sel == 4) { var %c = $active | part $active | .timer 1 1 join %c }
  elseif ($did(1).sel == 6) && ($snick($active) != $null) { query $snick($active) }
  elseif ($did(1).sel == 7) && ($snick($active) != $null) { dcc send $snick($active) }
  elseif ($did(1).sel == 9) { msg $active $a.logo }
  elseif ($did(1).sel == 11) { kick $active $snick($active) }
}

on *:dialog:winfx.*:init:0: {
  var %s = $gettok($dname,-1,46)
  var %l = - $+ $calc($len($gettok($dname,-1,46)) +1)
  var %c = $left($right($dname,-6),%l)

  ;MDX INPUT
  mdx MarkDialog $dname

  ;creating toolbar here
  mdx SetControlMDX $dname 1 toolbar flat nodivider wrap > $bars

  ;removing border from listbox
  mdx SetBorderStyle $dname 1

  ;make the dialog titlebarless and frameless
  mdx SetDialog $dname style

  ;adding images
  did -r $dname 1
  did -i $dname 1 1 bmpsize 16 16
  ; did -i $dname 1 1 setimage icon small 31, $+ $shortfn($scriptdirimg\icons\nexgen.icl)
  did -i $dname 1 1 setimage icon small sys\img\icons\1.ico
  did -i $dname 1 1 setimage icon small sys\img\icons\cycle.ico
  did -i $dname 1 1 setimage icon small sys\img\icons\dcc_chat.ico 
  did -i $dname 1 1 setimage icon small sys\img\icons\dcc_send.ico 
  did -i $dname 1 1 setimage icon small sys\img\icons\acidmax.ico 
  did -i $dname 1 1 setimage icon small sys\img\icons\kick.ico


  ;adding information to the toolbar
  did -a $dname 1 -
  did -a $dname 1 1 $chr(9) $+ channel central: $active 
  did -a $dname 1 2 $chr(9) $+ cycle
  did -a $dname 1 -
  did -a $dname 1 3 $chr(9) $+ query
  did -a $dname 1 4 $chr(9) $+ dcc send
  did -a $dname 1 -
  did -a $dname 1 5 $chr(9) $+ advertise
  did -a $dname 1 -
  did -a $dname 1 6 $chr(9) $+ kick 
  ;WINDOWFX INPUT

  ;This is the main portion where you dock your dialog to any window.

  ;%s is the connection ID, and %c is the child name
  scid %s wfx SetPadding %c > 33 text
  scid %s wfx SetChild %c > $dname
  ;28 is the height of the bars' padding (how big it will look in the channel window)

  ;text means it will be docked in the channel window. If we used list, it would dock over the nicklist
}

on *:join:*: {
  if ($nick == $me) {
    wfx.load
  }
}


;Now, if we look at the wfx.load alias, look at how it is calling the dialog:

;dialog -m winfx. $+ $chan $+ . $+ $cid winfx
