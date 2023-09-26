/ Este sera otra opcion independiente a las 2 anteriores para ver si se encuentra una opcion con SNMP o Python /

event manager applet Enlace_WxC_Caido
event timer watchdog time 10000
action 0001 cli command "enable"
action 0002 cli command "show sip-ua register status | include no "
action 0003 regexp "[0-9]+.*no" "$_cli_result"
action 0004 if $_regexp_result eq "0"
action 0005 syslog priority notifications msg "La troncal esta caida"
action 0017 cli command "config t"
action 0018 cli command "dial-peer voice 301 voip"
action 0019 cli command "translation-profile outgoing Llamadas_WxC_Caida"
action 0020 cli command "exit"
action 0021 cli command "dial-peer voice 300 voip"
action 0022 cli command "no destination dpg 200"
action 0023 cli command "destination dpg 300"
action 0024 cli command "end"
action 0024 cli command end
action 0002 cli command else
action 0024 cli command "config t"
action 0024 cli command "event manager applet loop"
action 0024 cli command "event timer watchdog time 5000"
action 0024 cli command "action 0002 cli command "show sip-ua register status | include yes ""
action 0024 cli command "action 0003 regexp "[0-9]+.*yes" "$_cli_result""
action 0024 cli command "action 0004 if $_regexp_result eq "1""
action 0024 cli command "action 0016 syslog priority critical msg "La troncal esta arriba""
action 0024 cli command "action 0006 cli command "config t""
action 0024 cli command "action 0007 cli command "dial-peer voice 301 voip""
action 0024 cli command action 0008 cli command "no translation-profile outgoing Llamadas_WxC_Caida"
action 0024 cli command action 0009 cli command "exit"
action 0024 cli command action 0010 cli command "dial-peer voice 300 voip"
action 0024 cli command action 0011 cli command "no destination dpg 300"
action 0024 cli command action 0012 cli command "destination dpg 200"
action 0024 cli command action 0013 cli command "end"
action 0024 cli command "action 0025 end"



event timer watchdog time
action 0014 end




action 0015 if $_regexp_result eq "1"
action 0016 syslog priority critical msg "La troncal esta arriba"
action 0006 cli command "config t"
action 0007 cli command "dial-peer voice 301 voip"
action 0008 cli command "no translation-profile outgoing Llamadas_WxC_Caida"
action 0009 cli command "exit"
action 0010 cli command "dial-peer voice 300 voip"
action 0011 cli command "no destination dpg 300"
action 0012 cli command "destination dpg 200"
action 0013 cli command "end"
action 0025 end




