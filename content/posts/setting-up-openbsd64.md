---
title: "Setting Up OpenBSD 6.4"
date: 2018-12-11T23:45:45-08:00
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

A couple of options I *do* recommend:

Blah blah blah

[Rufus]: https://rufus.ie/en_IE.html
[Etcher]: https://www.balena.io/etcher/
[Homebrew]: https://brew.sh
