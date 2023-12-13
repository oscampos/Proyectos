/ Este sere¿a la prueba funcional 2 que se podria utilizar para mientras ya que la anterior se ejecuta demasiado /



No tienen directo service desk



















!
configure terminal
!
voice translation-rule 10
rule 10 /\+18095665162$/ /01150322686600/
rule 11 /\+18095665161$/ /01150322686600/


exit
!
voice translation-profile Llamadas_WxC_Caida
translate called 10

exit
!
ip sla 1
!
icmp-echo webex.com source-ip 10.8.2.250
!
request-data-size 32
!
frequency 30
!
timeout 5000
!
ip sla schedule 1 life forever start-time now  
!
end
wr
!
!
config t
!
track 1 ip sla 1 state
!
delay up 10 down 5
!
end
wr
!
!
config terminal
!
event manager applet Enlace_WxC_Caido
 event track 1 state down
 action 0001 cli command "ena"
 action 0002 cli command "config t"
 action 0003 cli command "dial-peer voice 301 voip"
 action 0004 cli command "translation-profile outgoing Llamadas_WxC_Caida"
 action 0005 cli command "exit"
 action 0006 cli command "dial-peer voice 300 voip"
 action 0007 cli command "no destination dpg 200"
 action 0008 cli command "destination dpg 300"
 action 0009 cli command "end"
!
 exit
!
event manager applet Enlace_WxC_arriba
 event track 1 state up
 action 0001 cli command "ena"
 action 0002 cli command "config t"
 action 0003 cli command "dial-peer voice 301 voip"
 action 0004 cli command "no translation-profile outgoing Llamadas_WxC_Caida"
 action 0005 cli command "exit"
 action 0006 cli command "dial-peer voice 300 voip"
 action 0007 cli command "no destination dpg 300"
 action 0008 cli command "destination dpg 200"
 action 0009 cli command "end"
!
end
wr
!
