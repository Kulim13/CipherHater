# [Script for patching Sublime Text 3, Sublime Merge]()

**Only for builds 3206 and 1111 and only for Linux x86_64**

#### License key required: NO

---

## [Detailed explanation]()


**Automatic re-registration is triggered by the "About Sublime Text" in the program menu.**

```
If the registration is valid, then the window of the program
"Preferences -> Settings" opens in a new window, if not, then
you need to call the window "About Sublime Text" from program
menu and the registration status of the program will be resumed.

Enough to do one time.
```

**Automatic re-registration is triggered by the "About Sublime Merge" in the program menu.**

```
If the registration is valid, "Preferences -> Theme" the Dark mode
working, if not, then you need to call the window "About Sublime Merge"
from program menu and the registration status of the program will 
be resumed. 

Enough to do one time.
```

---


#### [First Step:]()

 
#### How to patch the executable? Copy/Paste this script and run:

- ```$ sudo chmod +x sublime_patch.sh```
- ```$ sudo ./sublime_patch.sh```
 

 
 
---

#### [Second Step:]()

 - ```$ sudo nano /etc/hosts``` (u can use other text editor)
 - copy & paste

Entries to add to /etc/hosts:

```
0.0.0.0 www.sublimemerge.com
0.0.0.0 sublimemerge.com
0.0.0.0 www.sublimetext.com
0.0.0.0 sublimetext.com
0.0.0.0 sublimehq.com
0.0.0.0 telemetry.sublimehq.com
0.0.0.0 license.sublimehq.com
0.0.0.0 download.sublimetext.com
0.0.0.0 download.sublimemerge.com
```
 
 - Ctrl + w & click enter to save
 
 ---


#### [Third Step:]()
 
Add IP addresses to block:

```bash
iptables -A OUTPUT -d 45.55.41.223/32 -j REJECT
iptables -A OUTPUT -d 45.55.255.55/32 -j REJECT
```

For Ubuntu UFW:

```bash
$ sudo ufw insert 1 deny out to 45.55.255.55/32 comment 'Block Sublime out host-1'
$ sudo ufw insert 2 deny in to 45.55.255.55/32 comment 'Block Sublime in host-1'
$ sudo ufw insert 3 deny out to 45.55.41.223/32 comment 'Block Sublime out host-2'
$ sudo ufw insert 4 deny in to 45.55.41.223/32 comment 'Block Sublime in host-2'
$ sudo ufw status numbered verbose
$ sudo dpkg-reconfigure iptables-persistent
```

---


Run Sublime Text & appreciate the magic ^^


**@cipherhater (c) 2019**

