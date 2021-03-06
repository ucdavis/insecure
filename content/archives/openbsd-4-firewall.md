---
title: "Openbsd 4 Firewall"
date: 2011-12-11T09:16:54-08:00
draft: false
---
## Create a boot disk for OpenBSD Install:

On a Windows system:

Download ftp://ftp.openbsd.org/pub/OpenBSD/4.0/i386/cdemu40.iso for a bootable cd image.
OR

Download ftp://ftp.openbsd.org/pub/OpenBSD/4.0/tools/ntrw.exe
Download ftp://ftp.openbsd.org/pub/OpenBSD/4.0/i386/floppy40.fs for IDE install, floppyB40.fs for SCSI install and floppyC40.fs for laptop install.
Insert a blank floppy and from the command prompt type:

```
ntrw floppy40.fs a:
```

## Install OpenBSD:
Insert CD/floppy in machine on which you want to install OpenBSD and boot system from the disk. If you're using a system with no removable drives, attach and boot from a USB drive.

The following is an abbreviated list of prompts and responses:
```
(I)nstall, (U)pgrade or (S)hell? i
Terminal type [vt220] <return>
kbd(8) mapping? ('L' for list) [none] <return>
Do you wish to select a keyboard encoding table? [n] <return>
Proceed with install? [no] y
Which one is the root disk? (or ‘done’) [wd0] <return>
Do you want to use *all* of wd0 for OpenBSD? [no] y
Initial label editor (enter '?' for help at any prompt)
> p
> d a
> d b
```

## Partitioning Information

The configuration below creates a 512MB swap file, and utilizes the rest of the disk for a single partition for OpenBSD files and storage of new files. Below it is a recommendation for partitioning a 2GB flash card for use with a Lex Twister or similar compact flash based system. We partition it in this way so that we can mount most of the partitions as read-only and preserve the life of the flash card as long as possible.

For a hard drive, use this:

```
> a b
offset: [63] <return>
size: [78172227] 512M
FS type: [swap] <return>
> a a
offset: [917280] <return>
size: [77255010] <return>
FS type [4.2BSD] <return>
mount point: [none] /
> w
> q
```

For a 2 GB CF Card, use this:

```
> a a
offset: [] <return>
size: [] 64M
FS type [4.2BSD] <return>
mount point: [none] /
> a b
offset: [] <return>
size: [] 2M
FS type [swap] <return>
> a d
offset: [] <return>
size: [] 64M
FS type [4.2BSD] <return>
mount point: [none] /var
> a e
offset: [] <return>
size: [] <return>
FS type [4.2BSD] <return>
mount point: [none] /usr
> w
> q
```
This will give you swap = 2M, / = 64M, /var = 64M, and /usr = the rest (~1.8G).

Continuing on in the setup:

```
Are you really sure that you're ready to proceed? [n] y
System hostname (short form, e.g. 'foo'): [] gatekeeper1
Configure the network? [y] <return>
Which one do you wish to initialize? (or ‘done’) [ext0] <return>
Symbolic (host) name for ext0? [gatekeeper1] <return>
Do you want to change the media options? [n] <return>
IPv4 address for ext0? (or 'none' or 'dhcp') 169.237.abc.d
Netmask? [255.255.255.0] <enter>
IPv6 address for ext0? (or 'rtsol' or 'none') [none] <return>
Which one to you wish to initialize? (or ‘done’) [int1] done

DNS domain name (e.g. 'bar.com'): [my.domain] ucdavis.edu
DNS nameserver? (IP address or ‘none’) [none] 169.237.1.250 169.237.250.250
Use the nameserver now? [yes] <return>
Default IPv4 route? (IPv4 address, ‘dhcp’ or ‘none’) 169.237.abc.254
Edit hosts with ed? [n] <return>
Do you want to do any manual network configuration? [n] <return>
Password for root account? (will not echo): *******
Password for root account? (again): *******

Location of sets? (cd disk ftp http or ‘done’) [cd] ftp
HTTP/FTP proxy URL? (e.g. 'http://proxy:8080', or 'none') [none] <return>
Display a list of known ftp servers? [y] <return>
Server IP address, hostname, or list#? [] 63
Server IP address, hostname, or list#? [ftp3.usa.openbsd.org]
openbsd.engr.ucdavis.edu OR <return>
Does the server support passive mode ftp? [y] <return>
Server directory [pub/OpenBSD/4.0/i386] <return>
Login? [anonymous] <return>
File name? (or ‘done’) [bsd.rd] -g*
File name? (or ‘done’) [bsd.rd] done
Ready to install sets? [yes] <return>
Location of sets? (cd disk ftp http or ‘done’) [cd] done

Start sshd(8) by default? [yes] <return>
Start ntpd(8) by default? [no] y
Do you expect to run the X Window System? [no] <return>
Change the default console to com0? [no] <return>
What time zone are you in? ('?' for list) [Canada/Mountain] US/Pacific

CONGRATULATIONS! Yada yada.
# reboot
```
If installing from boot disk you should remove your disk before the system reboots.

Login to your new installation:

```
Login: root
Password: *******
Terminal type? [vt220] <return>
```

Create non-root account with sudo privileges:

```
# adduser

Couldn't find /etc/adduser.conf: creating a new adduser configuration file
Reading /etc/shells
Enter your default shell: csh ksh nologin sh [sh]: ksh
Your default shell is: ksh -> /bin/ksh
Reading /etc/login.conf
Default login class: auth-defaults auth-ftp-defaults daemon default staff [default]:
Enter your default HOME partition: [/home]:
Copy dotfiles from: /etc/skel no [/etc/skel]:
Send message from file: /etc/adduser.message no [no]:
Do not send message
Prompt for passwords by default (y/n) [y]:
Default encryption method for passwords: auto blowfish des md5 old [auto]:
Use option ``-silent'' if you don't want to see all warnings and questions.

Reading /etc/shells
Check /etc/master.passwd
Check /etc/group

Ok, let's go.
Don't worry about mistakes. I will give you the chance later to correct any input.
Enter username []: adam
Enter full name []: Adam Getchell
Enter shell csh ksh nologin sh [ksh]:
Uid [1001]:
Login group adam [adam]: wheel
Login group is ``wheel''. Invite adam into other groups: guest no [no]:
Login class daemon default staff [default]:
Enter password []:
Enter password again []:

Name:adam
Password:****
Fullname:Adam Getchell
Uid: 1001
Gid: 0 (wheel)
Groups:wheel
Login Class: default
HOME:/home/adam
Shell: /bin/ksh
OK? (y/n) [y]: y
Added user ``adam''
Copy files from /etc/skel to /home/adam
Add another user? (y/n) [y]: n
Goodbye!
```

Uncomment the following line in /etc/sudoers:

```
%wheel ALL=(ALL) ALL
```

User 'adam' has sudo privileges because he's in the group "wheel".

Add Useful Utilities:

```
# pkg_add -v ftp://ftp.openbsd.org/pub/OpenBSD/4.0/packages/i386/pftop-0.5.tgz
# pkg_add -v ftp://ftp.openbsd.org/pub/OpenBSD/4.0/packages/i386/pico-4.10.tgz
# pkg_add -v ftp://ftp.openbsd.org/pub/OpenBSD/4.0/packages/i386/cvsup-16.1h-no_x11.tgz
# pkg_add -v ftp://ftp.openbsd.org/pub/OpenBSD/4.0/packages/i386/rsync-2.6.8.tgz
```

Let's ban root from logging in via SSH:

```
# cd /etc/ssh
# cp sshd_config sshd_config.old
# vi sshd_config
```

Change the following line:

```
PermitRootLogin no
```

Remove unnecessary cron jobs:

```
# sudo crontab -e
```

Comment out this line:

```
#*/30     *     *     *     *     /usr/sbin/sendmail -L sm-map-queue -Ac -q
```

Add this line:

```
ROOTBACKUP=0
```

under the line:

```
HOME=/var/log
```

Turn on soft dependencies in fstab:

Add "softdep" to all lines in /etc/fstab (except swap, if any)
e.g. "/dev/wd0a / ffs rw,noatime,softdep 1 1"

If you're configuring a Lex Twister (CF system) follow these instructions. If not, skip to "Update and compile"

## Configuring the Lex Twister for (nearly) read-only Compact Flash media
Mount /usr read-only:

```
# sudo cp /etc/fstab /etc/fstab.old
# sudo vi /etc/fstab
```

Change the line containing /usr to:

```
/dev/wd0e /usr ffs ro,nodev,softdep 1 2
# sudo reboot
```

After rebooting, configure mfs partitions in /etc/fstab:

```
# sudo vi /etc/fstab
```

Add these lines:

```
swap /tmp mfs rw,-s=65536,nodev,noatime,noexec,nosuid 0 0
swap /var/log mfs rw,-s=131072,nodev,noatime,noexec,nosuid 0 0
swap /var/run mfs rw,-s=2048,nodev,noatime,noexec,nosuid 0 0
swap /var/tmp mfs rw,-s=16384,nodev,noatime,noexec,nosuid 0 0
```

Now we want to persist /var/log across reboots:

```
# sudo mkdir -p /mfs/var.log
# sudo rm /var/log/*.gz
# sudo /usr/local/bin/rsync -vorpug /var/log/ /mfs/var.log
building file list ... done
adduser
authlog
daemon
failedlogin
ftpd
lastlog
lpd-errs
maillog
messages
pflog
secure
sendmail.st
wtmp
xferlog
wrote 328127 bytes  read 244 bytes  93820.29 bytes/sec
total size is 327215  speedup is 1.00

# sudo cp /etc/rc /etc/rc.old
# sudo vi /etc/rc
```

Add just after "mount /var >/dev/null 2>&1:

```
# Fill /var/log directory
printf "copying files to mfs ..."
/usr/local/bin/rsync -orpug /mfs/var.log/ /var/log
echo " done."

# sudo reboot
```

Now /var/log is in memory. We need to copy it to disk during shutdown, using /etc/rc.shutdown:

```
# sudo cp /etc/rc.shutdown /etc/rc.shutdown.old
# sudo vi /etc/rc.shutdown
```

Append these lines:

```
# Save /var/log directory
printf "Copying /var/log to CF ..."
# ReMount / read-write now
mount -uw /dev/wd0a /
/usr/local/bin/rsync -orpug --delete /var/log/ /mfs/var.log
echo " done."

# sudo reboot
```

Now we're going to setup the device files in /dev:
```
# sudo mkdir /mfs/dev
# sudo cp /dev/MAKEDEV /mfs/dev
# cd /mfs/dev
# sudo ./MAKEDEV all
# sudo mkdir -p /mfs/var.db
```
Edit /etc/fstab so that it looks like this:
```
/dev/wd0a / ffs ro,noatime,softdep 1 1
/dev/wd0e /usr ffs ro,nodev,noatime,softdep 1 2
/dev/wd0d /var ffs rw,nodev,noatime,nosuid,softdep 1 2
swap /tmp mfs rw,-s=65536,nodev,noatime,noexec,nosuid 0 0
swap /var/log mfs rw,-s=131072,nodev,noatime,noexec,nosuid 0 0
swap /var/run mfs rw,-s=2048,nodev,noatime,noexec,nosuid 0 0
swap /var/tmp mfs rw,-s=16384,nodev,noatime,noexec,nosuid 0 0
swap /dev mfs rw,-s=16384,nosuid 0 0
swap /var/db mfs rw,-s=65536,nodev,noatime,noexec,nosuid 0 0
```

Now we edit /etc/rc appropriately by editing near the rm -f fastboot line:
```
#mount -uw /# root on nfs requires this, others aren't hurt
rm -f /fastboot # XXX (root now writeable)
# Copy dev files before anything else
cp -Rp /mfs/dev/* /dev
# Remount / read-only
mount -ur /dev/wd0a /
```

And then at our normal spot:
```
mount /var >/dev/null 2>&1
# Fill /var/log directory
printf "copying files to mfs ..."
/usr/local/bin/rsync -orpug /mfs/var.log/ /var/log
/usr/local/bin/rsync -orpug /mfs/var.db/ /var/db
echo " done."
```

So we've done three things:

- prevented / from mounting writeable by commenting out ``#mount -uw`
- copied our device files
- copied our `/var/db` files.

Now we need to reboot to let `/var/db` get copied to `/mfs/var.db`

Now let's go edit `rc.shutdown` to ensure our `/var/db` files get written:
```
# Save /var/log directory
printf "Copying /var/log /var/db to CF ..."
# Remount / read-write now
mount -uw /dev/wd0a /
/usr/local/bin/rsync -orpug --delete /var/log/ /mfs/var.log
/usr/local/bin/rsync -orpug --delete /var/db/ /mfs/var.db
echo " done."
```

Now when we want to save this file, we get Read-only filesystem! What to do?

Control-Z to suspend vi:
```
[1] + Stopped            sudo vi /etc/rc.shutdown
# sudo mount -uw /
# fg
```

Now save the file using `:wq!`

To verify this works, let's look at the contents of `/var/db`
```
# ls
  host.random     libc.tags       ns
  kvm_bsd.db      locate.database pkg
```

Now we'll reboot and see if everything is kosher:
```
# cd /var/db
# ls
host.random libc.tags ns
kvm_bsd.dblocate.database pkg
# pkg_info -a
pftop-0.5 curses-based real time state and rule display for pf
rsync-2.6.8 mirroring/synchronization over low bandwidth links
```

## Update and compile current OpenBSD source code

There's not enough space on the 2GB flash card for this section!
Create a CVS update configuration file (using vi, pico, or your favorite editor):
```
#vi /etc/cvs-supfile

-----------------------BEGIN-(don't include this line)-----
*default release=cvs
*default base=/usr/src
*default prefix=/usr
*default host=cvsup.usa.openbsd.org
*default delete use-rel-suffix
*default umask=002
OpenBSD-src tag=OPENBSD_4_0
OpenBSD-ports tag=OPENBSD_4_0
------------------------END-(don't include this line)------
```

Get current (stable) source code:
```
# /usr/local/bin/cvsup /etc/cvs-supfile
```

Skip the following line if this is your first compilation. Otherwise, make sure `/usr/obj` exists:
```
# rm -rf /usr/obj/*
```

Build the OpenBSD kernel (this may take several minutes):
```
# cd /usr/src
# make obj
# cd /usr/src/etc && make DESTDIR=/ distrib-dirs
# cd /usr/src/sys/arch/i386/conf (/usr/src/sys/arch/amd64/conf)
```

For single processor boxes:
```
# config GENERIC
# cd ../compile/GENERIC
```

For multi-processor boxes:
```
# config GENERIC.MP
# cd ../compile/GENERIC.MP
```

Compile and install new kernel:
```
# make clean && make depend && make
# cp /bsd /bsd.old && cp bsd /bsd
# reboot
```

Build OpenBSD userland (this may take hours):
```
# cd /usr/src
# make build
# reboot
```

## Enable ip forwarding:
Edit /etc/sysctl.conf and uncomment (remove the #) from the line that reads:
```
net.inet.ip.forwarding=1
```

## Turn on PF:
To turn packet filtering on create a new file /etc/rc.conf.local and enter the following (favorite editor again):
```
/etc/rc.conf.local

  -----------------------BEGIN--------------------------------
  ntpd_flags=             # enabled during install
  pf=YES                  # Turn on pf
  inetd=NO                # Turn off inetd
  ftpproxy_flags=""       # FTP-Proxy for Active FTP
  ------------------------END---------------------------------

  # reboot
```

## Configure rules for pf:
Write your rules and save them in pf.test

To test your rules type:
```
# pfctl -nf /etc/pf.test
```

When you are confident that you want to apply the rules type:
```
# cp pf.conf pf.old && cp pf.test pf.conf
```

To load your rules type:
```
# pfctl -f /etc/pf.conf
```

Choose the mode your firewall will run in:

- Bridging: Transparently filters packets, no DNS resolution of addresses. No IP address.
- VLAN Routing: Routes packets between networks. Typical setup for departmental VLAN firewall.

## Configure OpenBSD as a transparent bridge:

Assuming your NICs are ext0 and int1 type the following:
```
# ifconfig ext0 delete
```

If you configured the second NIC type:
```
# ifconfig int1 delete
# echo 'up' > /etc/hostname.ext0
# echo 'up' > /etc/hostname.int1
```

Now configure bridging across interfaces:
```
# echo 'add ext0 add int1 up' > /etc/bridgename.bridge0
# reboot
```

Verify that the bridge is running by typing:
```
# ifconfig -a
```

You'll see a lot of output but you will know your bridge is working if you see the following line:
```
bridge0: flags=41 <UP,RUNNING> mtu 1500
```

## Configure OpenBSD as a routing firewall for a VLAN:

In order to firewall your VLAN using a routing firewall, you'll need to first get a subnet configured by the NOC to run all of your VLAN traffic through two NAMs. You'll connect both NAMs to the routing firewall. One will be the external interface and will have a new subnet and subnet mask. The other will be the internal interface and will be configured as the gateway for your current subnet.

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

## Useful OpenBSD Commands:
To show how many states are running concurrently and other useful information type (press right arrow to toggle modes):
```
# /usr/local/sbin/pftop
```

To mount the root filesystem as read-write type:
```
# mount -uw /
```

To mount the root filesystem as read-only type:
```
# mount -urf /
```

To see logged packets scroll on the screen type:
```
# tcpdump -n -e -ttt -i pflog0
```

To see logged packets scroll on the screen for a single host type:
```
# tcpdump -n -e -ttt -i pflog0 host <hostname or ip>
```

To show the amount of free disk space type:
```
# df -h
```

To show the amount of CPU utilization type:
```
# top
```

To mount a floppy type:
```
# mount -t msdos /dev/fd0a /mnt
```

To mount a USB flash drive type (typical):
```
# mount -t msdos /dev/sd0i /mnt
```
To copy a file to floppy type:
```
# cp <filename> /mnt
```

To unmount a drive mounted to /mnt type (Make sure your current directory isn't /mnt or a subfolder when you do this or it won't unmount.):
```
# umount /mnt
```

To display your current default directory type:
```
# pwd
```

To clear the display type:
```
# clear
```

To change your password type:
```
# passwd
```

To change another user's password type:
```
# sudo passwd username
```

`Ctrl-Z` pushes the current job into the background and `fg` to return it to the foreground.

`Ctrl-C` kills the job running in the foreground.

Setting up ftp-proxy: Instructions available here: http://www.bgnett.no/~peter/pf/en/newftpproxy.html

[PaulGeoTool]: http://computing.geology.ucdavis.edu/security/openbsd_routing_firewall-worksheet.php
