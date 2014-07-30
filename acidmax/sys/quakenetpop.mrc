;by {3nV|Tr0}
menu nicklist {
  $iif($qnetwork($network),QuakeNet)
  .q control
  ..$me
  ...auth: msg q@CServe.quakenet.org auth $$?="auth nickname:" $$?="password:"
  ...voice: msg q voice #
  ...op: msg q op #
  ...-
  ...hello: msg q hello
  ...who am i: msg q whoami
  ...set e-mail: msg q email $$?="enter your e-mail address:"
  ...change q password: msg q newpass $$?="password:" $$?="verify password:"
  ...request password: msg q requestpassword $$?="enter e-mail address:"
  ..ban menu
  ...ban user: msg q ban # $$1
  ...banlist: msg q banlist #
  ...ban clear: msg q banclear #
  ...remove q ban: msg q bandel # $$?="hostmask or index-number:"
  ...unban all: msg q unbanall #
  ..user
  ...whois: msg q whois $$1
  ...add: msg q adduser # $$1
  ...remove: msg q removeuser  # $$1
  ...chanlev Info: msg q chanlev #
  ...chanlev User: msg q chanlev # $$1 $$?="set flags for user:"
  ..channel
  ...chanflag Info: msg q chanflags #
  ...set chanflag: msg q chanflags # $$?="set $chan flags:"
  ...deop all: msg q deopall #
  ...clearchan: msg q clearchan #
  ...auto-userlimit: msg q chanflags # +c
  ...set topic: msg q settopic # $$?="enter topic:"
  ...set welcome: msg q welcome # $$?="enter welcome message:"
  ...set key: msg q key # $$?="enter key:"
  ...set limit: msg q limit # $$?="enter the limit:"
  ..other
  ...show commands: msg q showcommands
  .faq
  ..english:run txt\quakenetfaq\eng.txt
  ..swedish:run txt\quakenetfaq\swe.txt
  ..finnish:run txt\quakenetfaq\fi.txt
  ..french:run txt\quakenetfaq\fr.txt
  ..italian:run txt\quakenetfaq\it.txt
  ..dutch:run txt\quakenetfaq\nl.txt
  ..german:run txt\quakenetfaq\ger.txt
}
alias -l qnetwork { if ($network == QuakeNet) { return $true } }
