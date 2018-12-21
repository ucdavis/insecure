---
title: "Setting Up OpenBSD 6.4"
date: 2018-12-11T23:45:45-08:00
draft: false
---
First, setup a USB install key:

Rufus(Windows)
https://rufus.ie/en_IE.html

Etcher(MacOS)
```
brew install balenaetcher
```

Pick the closest mirror to you to get the files. (I picked Sonic.net).
The installation is the usual guided screens, you can safely use the defaults.
I go back and forth between putting X on a firewall, I left it on because
we might want to do nice graphic libraries which will require it.

A couple of options I *do*.
