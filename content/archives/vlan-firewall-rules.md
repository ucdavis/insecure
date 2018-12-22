---
title: "Vlan Firewall Rules"
date: 2007-09-13T09:44:45-08:00
draft: false
---
A sample ingress and egress ruleset for common campus services and ports.
```
######################################################################
# VLAN ROUTING FIREWALL RULES
# check in revisions with 'ci -l /etc/pf.conf'
#
# DEFAULT POLICIES
# block all inbound packets from outside
# block all outbound packets from inside
#
# em0 is external interface
# em1 is internal interface
#
# Note: pf uses "skip steps", so rules should be ordered by:
# 1) interface 2) protocol 3) source addr 4) source port
# 5) dest addr 6) dest port
#
#       REPLACE em0 and em1 with YOUR NIC DEVICES!
#
#    REPLACE ".abc." WITH YOUR SUBNET!
#

# Interfaces
ext_if = "em0"
int_if = "em1"

###########
# Department Specific Hosts
###########

# Department subnet(s)
department1 = "169.237.abc.0/24"
aesdean = "169.237.124.0/24"

# Domain Controllers
dc1 = "169.237.abc.1"
dc2 = "169.237.abc.2"
table <dcs> { $dc1 $dc2 }

# Mail servers
exchange = "169.237.abc.4"

# Public webservers
www1 = "169.237.abc.6"
www2 = "169.237.abc.3"
www3 = "169.237.abc.246"
www4 = "169.237.abc.247"
www5 = "169.237.abc.249"
www6 = "169.237.abc.233"
table <pub_web> { $www1 $www2 $www3 $www4 $www5 $www6 $exchange }

# Secure FTP servers
sftp1 = "169.237.abc.6"
sftp2 = "169.237.abc.5"
table <sftp> { $sftp1 $sftp2 }

#VPN server
vpn = "169.237.abc.2"
vpn_port = "1723"

# RDP
rdp_port = "3389"

# PPS Printers enabled for direct printing
table <pps_printers> { 169.237.abc.1 }

# Banner Printers enabled for direct printing
table <banner_printers> { 169.237.abc.1 }

# Departmental iChat server
my_ichatserver = "169.237.abc.ichatsrv"

### Definitions
#
# 5060 udp iChat AV Session Initialization Protocol (SIP)
# 5190 tcp/udp iChat/AIM - file transfer 5190
# 5222 tcp ichat Jabber server,
# 5223 tcp ichat server SSL
# 5269 tcp iChat server-to-server
# 7777 tcp iChat server file transfer proxy
# 16384-16404 udp iChat AV Realtime Transport Protocol, Realtime Control Protocol
ichat = "5060, 5190, 5222, 5223, 5269, 7777, 16384:16404"

# it looks like snatmap is used to map the visible IP address of a machine
# that sits behind a NAT router so it can get a chat connection
snatmap = "17.250.248.149" # snatmap.mac.com

###########
# Generic Campus Hosts
###########

# Campus DNS servers
dns = "{ 169.237.250.250 169.237.1.250 }"

# Campus Scanners
table <campusscanners> { 169.237.105.111 169.237.105.112 169.237.246.3 \
        169.237.246.4 169.237.246.5 169.237.246.6 }

# Banner
ica_tcp = "1494"
ica_udp = "1604"
banner7_prod_port = "1525"
print_ports = "{" 515 9100 "}"
#print_ports_snmp = "{" 161 162 "}"

banner1 = "169.237.224.131"
banner2 = "169.237.224.132"
banner3 = "169.237.224.133"
banner4 = "169.237.224.134"
banner5 = "169.237.224.135"
banner6 = "169.237.224.136"
banner7 = "169.237.224.137"
banner8 = "169.237.224.138"
banner9 = "169.237.224.139"
banner10 = "169.237.224.140"
table <banner> { $banner1 $banner2 $banner3 $banner4 \
        $banner5 $banner6 $banner7 $banner8 $banner9 \
        $banner10 }
table <banner_print_servers>  { 169.237.104.59 169.237.104.62 \
        169.237.104.63 128.120.38.64 128.120.38.72 }
confluence = "confluence.ucdavis.edu"

banner_web_sites = "{" $confluence "}"

# AIS
ais1 = "dillon.ucdavis.edu"
ais2 = "catalina.ucdavis.edu"
ais3 = "pebble.ucdavis.edu"
ais = "{" $ais1 $ais2 $ais3 "}"

# DaFIS
afs1 = "afs1.ucdavis.edu"
afs2 = "afs2.ucdavis.edu"
afs3 = "afs3.ucdavis.edu"
afsadmin4 = "afsadmin4.ucdavis.edu"
afsadmin5 = "afsadmin5.ucdavis.edu"
afsadmin6 = "afsadmin6.ucdavis.edu"
afsadmin7 = "afsadmin7.ucdavis.edu"
dafis = "{" $afs1 $afs2 $afs3 $afsadmin4 \
        $afsadmin5 $afsadmin6 $afsadmin7 "}"

# DaFIS Monitor
afsmon1 = "169.237.59.25"
afsmon2 = "169.237.59.26"
afsmon3 = "169.237.59.27"
table <dafismon> { $afsmon1 $afsmon2 $afsmon3 }

# DaFIS AFS Proxy Servers
afsp1 = "169.237.105.130"
afsp2 = "169.237.105.131"
afsp3 = "169.237.105.132"
afsp4 = "169.237.105.133"
table <dafisp> { $afsp1 $afsp2 $afsp3 $afsp4 }

# DaFIS Database Servers
afsd1 = "169.237.59.20"
afsd2 = "169.237.59.38"
table <dafisd> { $afsd1 $afsd2 }

# DaFIS DNS
#afsdns1 = "169.237.104.103"
#afsdns2 = "169.237.105.108"
afsdns1 = "128.120.32.98"
afsdns2 = "128.120.32.99"
table <dafisdns> { $afsdns1 $afsdns2 }

# Oracle
oraport = "1521"
tnsport = "1522"
calosoma = "calosoma.ucdavis.edu"
fisdss = "fis-dss.ucdavis.edu"
zeus = "zeus.ucdavis.edu"
aedes = "aedes.ucdavis.edu"
oranames1 = "oranames1.ucdavis.edu"
oranames2 = "oranames2.ucdavis.edu"
bahn = "bahn.ucdavis.edu"
oracle = "{" $calosoma $fisdss $zeus $aedes $bahn "}"

# PPS
pps_port = "515"
pps1 = "128.48.178.6"
pps2 = "128.48.96.57"
pps3 = "128.48.96.51"
pps4 = "128.48.96.64"
table <pps> { $pps1 $pps2 $pps3 $pps4 }

# LDAP Campus
ldap1 = "169.237.104.189"
table <ldap> { $ldap1 }

# Campus KMS
kms = "vista.ucdavis.edu"

# Tables
table <badhosts> persist file "/etc/badhosts"
table <private> const { 10/8, 172.16/12, 192.168/16 }
table <campus> const { 169.237/16, 128.120/16, 152.79/16 }

###########
# Logging, Timeouts, Limits, Interface skips, Scrubs, FTP Proxy
###########

# Setup logging interface
set loginterface $ext_if

# Revised - Adaptive Set higher state limits
set timeout { adaptive.start 10000, adaptive.end 110000 }
set limit states 100000
set timeout interval 10

# Don't filter on loopback interface
set skip on lo

# Normalize all incoming/outgoing traffic to prevent malformed packets
scrub in on $ext_if all random-id fragment reassemble
scrub out on $ext_if all random-id fragment reassemble

# FTP-Proxy
nat-anchor "ftp-proxy/*"
rdr-anchor "ftp-proxy/*"
rdr on $int_if proto tcp from any to any port 21 -> 127.0.0.1 \
        port 8021

# Don't filter on internal interface
pass in on $int_if all
pass out on $int_if all

###########
# Default Block Rules
###########

# Default deny all traffic
block  in log on $ext_if all label "Default block in"
block out log on $ext_if all label "Default block out"

# Default block in IPv6 traffic for unpatched
block in quick inet6 label "Default block in IPv6"

# Block spoofed traffic and bad hosts
block  in log quick on $ext_if from <badhosts> \
    label "Badhosts in"
block out log quick on $ext_if to <badhosts> \
        label "Badhosts out"
block  in log quick on $ext_if from <private> \
        label "Private in"
block out log quick on $ext_if to <private> \
        label "Private out"

#Block Campus Scanners for quick Kerberos/distauth login
block return in from <campusscanners> label "Block Campus Scanners"

# Reject auth connections for fast SMTP handshake
block return-rst in proto tcp to any port auth \
        label "Reject auth for SMTP"

###########
# Ingress Rules
###########

########### General Rules [Ingress] ###########

# Allow ICMP (ping, neterrors, traceroute)
pass in on $ext_if inet proto icmp icmp-type 8 \
        code 0 label "ICMP in"

########### Campus Systems [Ingress] ###########

# Banner Printing
pass in on $ext_if proto tcp from <banner_print_servers> to \
    <banner_printers> port $print_ports \
    modulate state \
    label "Banner printing $dstport in"

# Banner SNMP Print Config, uncomment if remote print config is needed
#pass in quick on $ext_if proto udp from <banner_print_servers> to \
#       <banner_printers> port $print_ports_snmp \
#       keep state \
#    label "Banner SNMP Print Config"

# PPS
pass in on $ext_if proto tcp from <pps> to any \
    port $pps_port \
    modulate state \
    label "PPS Printing $srcaddr in"
pass in on $ext_if proto tcp from <pps> to <pps_printers> \
    port $print_ports \
    modulate state \
    label "PPS Printing $srcaddr in"

########### Department Specific Rules [Ingress] ###########

# pass in to DNS servers (DCs)
pass in on $ext_if proto udp from any to <dcs> \
    port domain \
        modulate state \
        label "dns in to DCs"

# pass in ssh from Dean's Office
pass in log on $ext_if proto tcp from $aesdean to ($ext_if) \
    port ssh \
        modulate state \
        label "ssh in"

# Allow http/s requests to public web servers
pass in on $ext_if proto tcp from any to <pub_web> \
        port { http https } \
        modulate state \
        label "Public Web $dstaddr:$dstport in"

# Allow mail into to Exchange server
pass in on $ext_if proto tcp to $exchange \
    port smtp \
        modulate state \
        label "SMTP $dstaddr:$dstport in"

#Pass inbound traffic to VPN
pass in on $ext_if proto tcp to $vpn \
    port $vpn_port \
    flags S/SA modulate state \
        label "VPN in"
pass in on $ext_if proto gre to $vpn \
    label "VPN in"

# Allow iChat in
pass in on $ext_if proto { tcp, udp } from any to $my_ichatserver \
    port { $ichat  } \
    flags S/SA modulate state \
    label "iChat $dstaddr:$dstport in"

###########
# Egress Rules
###########

########### General Rules [Egress] ###########

# ICMP (ping, neterrors, traceroute) out
pass out on $ext_if inet proto icmp all icmp-type 8 code 0 \
    label "ICMP out"

# DNS out
pass out on $ext_if proto udp to any \
    port { domain } \
    modulate state \
    label "dns out"

# NTP out
pass out on $ext_if proto udp to any \
    port ntp \
    modulate state \
    label "$dstport out"

# HTTP(S) out
pass out on $ext_if proto tcp to any \
    port { http https } \
    flags S/SA modulate state \
    label "web $dstport out"

# SMTP/POP(S)/IMAP(S) out
pass out on $ext_if proto tcp to any \
    port { smtp 587 imap imaps pop3 pop3s } \
    flags S/SA modulate state \
    label "email $dstport out"

# RDP out
pass out on $ext_if proto tcp to any \
    port $rdp_port \
    flags S/SA modulate state \
    label "RDP $dstport out"

# VPN out
pass out on $ext_if proto tcp from $vpn to any \
    port $vpn_port \
    flags S/SA modulate state \
    label "VPN out"
pass out on $ext_if proto gre from $vpn \
    label "VPN out"

# FTP-Proxy out
anchor "ftp-proxy/*"
pass out proto tcp from localhost to any \
    port 21 \
    keep state \
        label "ftp-proxy out $dstport"

# FTP out
pass out on $ext_if proto tcp to any \
    port ftp \
    flags S/SA modulate state \
    label "ftp $dstport out"

# Kerberos out
pass out on $ext_if proto { tcp, udp } to any \
    port kerberos \
    flags S/SA modulate state \
    label "Kerberos $dstport out"

# Telnet/SSH out
pass out on $ext_if proto tcp to any \
    port { ssh telnet } \
    flags S/SA modulate state \
    label "ssh/telnet $dstport out"

# NNTP out
pass out on $ext_if proto tcp from $department1 to any \
    port { 119 563 } \
    modulate state \
    label "NNTP $dstport out"

# LDAP out
pass out on $ext_if proto tcp from $department1 to any \
    port { ldap ldaps } \
    modulate state \
    label "LDAP $dstport out"

# CVS Update for OpenBSD out
pass out on $ext_if proto tcp from $department1 to any \
    port 5999 \
    modulate state \
    label "CVS Update out"

# WHOIS out (e.g. whois -h directory.ucdavis.edu getchell )
pass out on $ext_if proto tcp from any to any \
        port 43 \
        modulate state \
        label "WHOIS $dstport out"

########### Campus Systems [Egress] ###########

# AIS
pass out on $ext_if proto tcp to $ais \
    port $ica_tcp \
    flags S/SA modulate state \
    label "AIS $dstaddr:$dstport out"
pass out on $ext_if proto udp to $ais \
    port $ica_udp \
    keep state \
    label "AIS  $dstaddr:$dstport out"

# Banner
pass out on $ext_if proto tcp to <banner> \
    port $ica_tcp \
    flags S/SA modulate state \
    label "Banner/DESII $dstport TCP out"
pass out on $ext_if proto udp to <banner> \
    port $ica_udp \
    keep state \
    label "Banner/DESII $dstport UDP out"
pass out on $ext_if proto tcp to <banner_print_servers> \
    port $banner7_prod_port \
    modulate state \
    label "Banner third-party DB access out"

# Banner production
pass out on $ext_if proto tcp to $zeus \
    port $banner7_prod_port \
    modulate state \
    label "Banner $dstaddr:$dstport out"

# Banner web site out
pass out on $ext_if proto tcp from $department1 to sis.ucdavis.edu \
    port { 4443 } \
    modulate state \
    label "Banner Web site out"

# UCD Sites on 8443: MyInfoVault, etc.
pass out on $ext_if proto tcp from $department1 to any \
    port { 8443 } \
    modulate state \
    label "UCD Secure site on 8443 out"

# Online Provision System
pass out on $ext_if proto tcp from $department1 to escalante.ucdavis.edu \
    port 7777 \
    modulate state \
    label "Web sites on port $dstport out"

# DaFIS
pass out on $ext_if proto udp to $dafis  \
    keep state \
        (udp.multiple 2700, adaptive.start 6000, adaptive.end 12000) \
        label "DaFIS AFS $dstaddr out"
# DaFIS Monitor
pass out on $ext_if proto tcp to <dafismon>  \
    keep state \
        (adaptive.start 6000, adaptive.end 12000) \
        label "DaFIS $dstaddr:$dstport out"
# DaFIS Proxy
pass out on $ext_if proto tcp to <dafisp> \
    port { 139 445 } \
        modulate state \
        label "DaFIS $dstaddr:$dstport out"
# DaFIS Database Servers
pass out on $ext_if proto tcp to <dafisd> \
    port 1521 \
        modulate state \
        label "DaFIS $dstaddr:$dstport out"
# DaFIS Oracle DNS
pass out on $ext_if proto tcp to <dafisdns> \
    port 1522 \
    modulate state \
    label "DaFIS $dstaddr:$dstport out"

# Campus Oracle
# TNS Names
pass out on $ext_if proto tcp to $oracle \
    port $oraport \
    flags S/SA modulate state \
        label "DaFIS $dstaddr:$dstport out"
pass out on $ext_if proto tcp to { $oranames1 $oranames2 $zeus }\
        port $tnsport \
        flags S/SA modulate state \
        label "DaFIS $dstaddr:$dstport out"

# PPS
pass out on $ext_if proto tcp to <pps> \
    flags S/SA modulate state \
    label "PPS->$dstaddr"

# Vista activation
pass out on $ext_if proto tcp to $kms \
        port 1688 \
        flags S/SA modulate state \
        label "MS activation $dstaddr:$dstport out"

# UCOP academic site
pass out on $ext_if proto tcp from $department1 \
         to accept.ucop.edu port { 4430 8131 } \
         label "AcceptUCOP->$dstaddr"

########### Department Specific [Egress] ###########

# AIM/IRC
pass out on $ext_if proto tcp from $department1 to any \
    port { 5190 5222 6667 } \
    modulate state \
    label "AIM $dstport out"

# Non-standard web site ports
pass out on $ext_if proto tcp from $department1 to any \
    port { 4443 8080 } \
    modulate state \
    label "Non-standard Web $dstport out"

# Windows Media player
pass out on $ext_if proto tcp from $department1 to any \
    port { 1755 554 } \
    modulate state \
    label "Windows Media player $dstport out"

# Breeze out
pass out on $ext_if proto tcp from any to any \
    port 1935 \
        flags S/SA modulate state \
        label "Breeze out"

# MatLab
pass out on $ext_if proto tcp to any \
    port { 2013 2015 7241 32910 } \
    flags S/SA modulate state \
    label "MatLab out"

# SciFinder Scholar
pass out on $ext_if proto tcp to any \
    port 210 \
        flags S/SA modulate state \
        label "SciFinder out"

# eJournals out
pass out on $ext_if proto tcp from any to ucelinks.cdlib.org \
    port 8888 \
        flags S/SA modulate state \
        label "eJournals port $dstport out"
pass out on $ext_if proto tcp from any to sfx.lib.ucdavis.edu \
    port 9003 \
        flags S/SA modulate state \
        label "eJournals port $dstport out"
pass out on $ext_if proto tcp from any to request.cdlib.org \
    port 8082 \
        flags S/SA modulate state \
        label "eJournals port $dstport out"

# iTunes radio
# Apple tech docs claim a restricted range of ports are used
# but in practice various internet radio stations unfortunately
# use different port numbers outside the documented range.
# The following rule gets about half the stations I looked at
# and all the stations I happened to care about.

pass out on $ext_if proto tcp from any to any \
        port 8000:8999 keep state \
        label "iTunes radio out"

# iChat
pass out on $ext_if proto { tcp, udp } from any to any \
    port { $ichat } \
    flags S/SA modulate state \
    label "iChat to $dstport out"

# snatmap out (used for iChat AV to clients behind NAT )
pass out on $ext_if proto udp from any to $snatmap \
    keep state \
    label "snatmap $dstport out"

# AIM/IRC
pass out on $ext_if proto { tcp, udp } from any port { $ichat } to any \
    flags S/SA modulate state \
    label "iChat from $srcport out"
```
