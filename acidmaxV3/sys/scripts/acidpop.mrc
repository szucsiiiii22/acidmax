menu nicklist,query {
  • dcc
  .send file: raw -q notice $1 : Preparing for DCC file transfer. | dcc send $$1
  .chat: dcc chat $$1
  • ctcp
  .ping: ctcp $$1 ping 
  .version: ctcp $$1 version
