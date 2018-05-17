
alias bottombar2 {
  if (!$dialog(bottombar2)) { dialog -m bottombar2 bottombar2 }
}


dialog bottombar2 {
  title "bottombar2"
  size -1 -1 504 35
  option dbu

  ;list 20, 374 21 110 11, size
  list 1, 2 2 2978 20, size

}
alias mdx { return sys\dlls\mdx.dll }

on *:dialog:bottombar2:init:0:{
  dll $mdx SetMircVersion $version
  dll $mdx MarkDialog $dname
  ;This sets the desired listbox control to a toolbar control, we will look at the different styles later

  ;dll $mdx SetControlMDX $dname 1 Toolbar list arrows flat wrap nodivider > sys\dlls\bars.mdx
  dll sys\dlls\mdx.dll SetControlMDX $dname 1 toolbar flat nodivider wrap > sys\dlls\bars.mdx
  ;Takes away the dialog's titlebar and border and takes off the control's border
  ; dll $mdx SetDialog $dname style
  dll $mdx SetBorderStyle 1
  ;Sets icon size


  ;did -i bottombar 1 1 setimage icon small sys\img\icons\1.ico



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



}
