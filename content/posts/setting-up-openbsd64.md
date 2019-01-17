---
title: "Setting Up OpenBSD 6.4"
date: 2019-01-15T14:50:45-08:00
draft: false
---

## Prerequisites

First, setup a USB install key:

### Windows

[Rufus]

### MacOS

[Etcher]
```
brew install balenaetcher
```

Note: If you aren't familiar with [Homebrew], definitely familiarize yourself
with it!

## Initial install

Boot from USB, changing boot order as needed. You should see a screen like
the following:

{{< figure src="/images/setup.png" caption="OpenBSD 6.4 Setup screen" >}}

Pick the closest mirror to you to get the files. (I picked Sonic.net).
The installation is the usual guided screens, you can safely use the defaults.
I go back and forth between putting X on a firewall, I left it on because
we might want to do nice graphic libraries which will require it.

## Configuration

First, setup [doas] with something like the following in `\etc\doas.conf`:

```
permit nopass adam as root
```

From here on out, we'll use `doas` for operations requiring administrative
access.

### [Updating] to Stable

We'll want to update our fresh OpenBSD install with the latest source from the
`-stable` branch. Do the following:

Add yourself to the `wsrc` group, which has write permissions to `/usr/src`.
```
doas user mod -G wsrc adam
```
You'll have to logout and login for this to take effect.

Next, set permissions to enable fetching `ports` and [xenocara] (OpenBSD's
custom X server):

```
cd /usr
doas mkdir -p xenocara ports
doas chgrp wsrc xenocara ports
doas chmod 755 xenocara ports
```
Now fetch `-stable`:
```
cd /usr
cvs -qd anoncvs@anoncvs1.usa.openbsd.org:/cvs checkout -rOPENBSD_6_4 -P src
```
This example is fetching from the mirror at Bend, Oregon, and will take awhile.
Use the closest mirror.

#### Build and install a new kernel

```
cd /sys/arch/$(machine)/compile/GENERIC.MP
doas make obj
doas make config
doas make
doas make install
```

The current kernel is copied to `/obsd` and the new kernel is `/bsd`. Reboot.
If you have a kernel panic, [boot] the old kernel and try again.

#### Build and update a new base system

```
cd /usr/src
doas make obj
doas make build
doas sysmerge
cd /dev
doas ./MAKEDEV all
```
This will take a few hours. Building OpenBSD from source is a good hardware
burn-in test. If you are getting [Signal 11] errors, your firewall hardware is
not ready for production.

#### Building X

Since we specified X11 packages on the initial install, we'll need to update
Xenocara, OpenBSD's meta-build for [X.Org]. Note that you will need at least
4GB on `/usr`!

```
cd /usr
doas cvs -qd anoncvs@anoncvs1.usa.openbsd.org:/cvs checkout -rOPENBSD_6_4 -P xenocara
cd /usr/xenocara
doas make bootstrap
doas make obj
doas make build
```
This will take another couple of hours.

## Configure routing firewall for a VLAN:

In order to protect your VLAN using a [routing] firewall, you'll need to first get a subnet configured by the NOC to run all of your VLAN traffic through two NAMs. You'll connect both NAMs to the routing firewall. One will be the external interface and will have a new subnet and subnet mask. The other will be the internal interface and will be configured as the gateway for your current subnet.

The following section assumes the following:

1. The public side of your firewall sits on subnet 169.237.efg.0/24 and the mask for that subnet is 255.255.255.0.
2. The NIC on the public side of the firewall will have the ip address 169.237.efg.hij
3. The up-level router in subnet 169.237.efg.0 has IP address 169.237.efg.klm.
4. The clients on the private side of your subnet use 169.237.abc.254 as their gateway.
5. The NICs on your firewall are ext0 and int1. Type 'ifconfig -a' to find out their real names.

Try Paul Waterstraat's VLAN routing firewall configuration tool [here][PaulGeoTool]

Start out by deleting the external interface:
```
# ifconfig ext0 delete
```

If you configured the second NIC delete it as well:
```
# ifconfig int1 delete
```

This is the IP in the new subnet NOC gave you:
```
# echo 'inet 169.237.efg.hij 255.255.255.252 NONE' > /etc/hostname.ext0
```

This is in your current subnet. This address will be the gateway for your clients:
```
# echo 'inet 169.237.abc.254 255.255.255.0 NONE' > /etc/hostname.int1
```

This is the gateway for your OpenBSD router. It's a NOC router on the same subnet as ext0's ip address:
```
# echo '169.237.efg.klm ' > /etc/mygate
```

After rebooting your computer will begin using the IP addresses configured above. To avoid conflicting addresses you should either turn off other computers with these IP addresses or you should unplug this firewall from the network.

Reboot:
```
# reboot
```


[Rufus]: https://rufus.ie/en_IE.html
[Etcher]: https://www.balena.io/etcher/
[Homebrew]: https://brew.sh
[doas]: https://man.openbsd.org/doas
[Updating]: https://www.openbsd.org/faq/faq5.html
[xenocara]: https://github.com/openbsd/xenocara
[X.org]: https://www.x.org/wiki/
[Signal 11]: https://www.bitwizard.nl/sig11/
[boot]: https://man.openbsd.org/boot.8
[routing]: https://www.openbsd.org/faq/pf/example1.html
[PaulGeoTool]: http://computing.geology.ucdavis.edu/security/openbsd_routing_firewall-worksheet.php
