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
This is fetching from the mirror at Bend, Oregon, and will take awhile.

#### Build and install a new kernel

```
cd /sys/arch/$(machine)/compile/GENERIC.MP
doas make obj
doas make config
doas make
doas make install
```

The current kernel is in `/obsd` and the new kernel is `/bsd`. Reboot.

#### Build and update a new base system

```
cd /usr/src
doas make obj
doas make build
doas sysmerge
cd /dev
doas ./MAKEDEV all
```

[Rufus]: https://rufus.ie/en_IE.html
[Etcher]: https://www.balena.io/etcher/
[Homebrew]: https://brew.sh
[doas]: https://man.openbsd.org/doas
[Updating]: https://www.openbsd.org/faq/faq5.html
[xenocara]: https://github.com/openbsd/xenocara
