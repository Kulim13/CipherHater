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
 

<details>
	<summary>DOWNLOAD MAGIC SCRIPT</summary>
<p> 

```bash
#!/bin/bash
#

#############################################################################################
#
# Brief: Script for patching Sublime Text 3 Build 3206 and Sublime Merge Build 1111
# Author: cipherhater <https://gist.github.com/cipherhater>
# Copyright: © 2019 CipherHater, Inc.
#
#############################################################################################

#
##
### Colored output ##########################################################################

RESTORE='\001\033[0m\002'
RED='\001\033[00;31m\002'
GREEN='\001\033[00;32m\002'
YELLOW='\001\033[00;33m\002'
BLUE='\001\033[00;34m\002'
MAGENTA='\001\033[00;35m\002'
PURPLE='\001\033[00;35m\002'
CYAN='\001\033[00;36m\002'
LIGHTGRAY='\001\033[00;37m\002'
LRED='\001\033[01;31m\002'
LGREEN='\001\033[01;32m\002'
LYELLOW='\001\033[01;33m\002'
LBLUE='\001\033[01;34m\002'
LMAGENTA='\001\033[01;35m\002'
LPURPLE='\001\033[01;35m\002'
LCYAN='\001\033[01;36m\002'
WHITE='\001\033[01;37m\002'

echo -en ${RESTORE}

#
##
### Supported version #######################################################################

version_text='3206'
version_merge='1111'

support_versions=${version_text}${version_merge}

#
##
#### Make sure only root can run our script #################################################
if [[ $EUID -ne 0 ]]; then
    echo -en ${LRED}"\nThis script must be run as root!\n\n"
    echo -en ${RED} 'Goodbay!\n\n'
    exit 1
fi

#
##
### Start menu ##############################################################################

echo -en ${LYELLOW} "\nThis script supports only: \n\n \
	${GREEN}Platform: ${WHITE} Linux x86_64\n\n \
	${GREEN}Sublime Text 3 Build: ${LMAGENTA} $versions_text\n\n \
	${GREEN}Sublime Merge Build: ${LMAGENTA} $versions_merge\n\n"

echo -en ${RESTORE}

#
##
### Function for Sublime Text 3 #############################################################

function textPatching {
echo -en ${YELLOW} '\nChecking Sublime Text path ...\n'

if [[ -f './sublime_text' ]]; then 
	p='.'
else
	echo -en ${WHITE} 
	read -r -p "Please input sublime_text installed path (the directory contains sublime_text): \
			    `echo $'\n> '`" p

	if [[ ! -d "$p" ]]; then
	    echo -en ${LRED} '\nError: '$p' Is not a directory!\n\n'
	    echo -en ${RED} 'Goodbay!\n\n'
	    echo -en ${RESTORE}
	    exit 11
	fi

	if [[ ! -f "$p/sublime_text" ]]; then
	    echo -en ${LRED} '\nError: '$p' Is not a sublime_text installed path!\n\n'
	    echo -en ${RESTORE}
	    echo -en ${RED} 'Goodbay!\n\n'
	    exit 12
	fi

	# Replace "\" with "/"
	p=$(echo $p | sed 's/\\/\//g')

	# Trim trailing "/"
	p=${p%/}

	echo -en ${RED} '\n'
	read -p 'Backup Sublime Text 3 binary? [y/n]: ' bt
	if [ -n $bt ] && [ $bt != "n" ]; then
	    # Backup Sublime Text
	    echo -en ${GREEN} '\nRunning backup: copy "sublime_text" to "sublime_text.orig" ...\n'
	    cp -i "$p/sublime_text" "$p/sublime_text.orig"
	    echo
	fi
fi
echo -en ${RESTORE}
}

#
##
### Function for Sublime Merge ##############################################################

function mergePatching {
echo -en ${YELLOW} '\nChecking Sublime Merge path ...\n'

if [[ -f './sublime_merge' ]]; then
	p='.'
else
	echo -en ${WHITE} 
	read -r -p "Please input sublime_merge installed path (the directory contains sublime_merge): \
			    `echo $'\n> '`" p

	if [[ ! -d "$p" ]]; then
	    echo -en ${LRED} '\nError: '$p' Is not a directory!\n\n'
	    echo -en ${RESTORE}
	    echo -en ${RED} 'Goodbay!\n\n'
	    exit 11
	fi

	if [[ ! -f "$p/sublime_merge" ]]; then
	    echo -en ${LRED} '\nError: '$p' Is not a sublime_merge installed path!\n\n'
	    echo -en ${RESTORE}
	    echo -en ${RED} 'Goodbay!\n\n'
	    exit 12
	fi

	# Replace "\" with "/"
	p=$(echo $p | sed 's/\\/\//g')

	# Trim trailing "/"
	p=${p%/}

	echo -en ${RED} '\n'
	read -p 'Backup Sublime Merge binary? [y/n]: ' bm
	if [ -n $bm ] && [ $bm != "n" ]; then
	    # Backup Sublime Merge
	    echo -en ${GREEN} '\nRunning backup: copy "sublime_merge" to "sublime_merge.orig" ...\n'
	    cp -i "$p/sublime_merge" "$p/sublime_merge.orig"
	    echo
	fi
fi
echo -en ${RESTORE}
}

#
##
### Function select which program to patch ##################################################

function mainWork {
echo -en ${WHITE}
read -n1 -p "Pick a letter to run patching: T - Sublime Text, M - Sublime Merge, or E - Exit script." runPatching

case $runPatching in
	t|T) printf "\n\nStart patching Sublime Text 3.\n" && textPatching;;
	m|M) printf "\n\nStart patching Sublime Merge.\n" && mergePatching;;
	e|E) printf "\n\nGoodbay!\n\n" && exit 0;;
esac
}

mainWork

#
##
### Detect Sublime build number #############################################################

echo -en ${PURPLE} 'Checking Sublime Text/Merge version...\n\n'
if [[ -f "$p/changelog.txt" ]]; then
	v=$(cat "$p/changelog.txt" | grep -P -o '^<h2>.*Build \d{4}' | grep -P -o '\d{4}' | head -n 1)
	echo -en ${LYELLOW}
	read -p "Detected Sublime version *$v*, is it right? [y/n]: " flag
	if [[ -n "$flag" ]]; then
	    case $flag in
		"y" )
		    ;;
		"n" )
		    # Input build number manually
		    echo -en ${WHITE}
		    read -p "Please input your Sublime Text/Merge build number (supported builds are [$support_versions]): `echo $'\n> '`" v
		    ;;
		* )
		    echo -en ${LRED} '\nInvalid input: '$flag'\n'
		    exit 1
	    esac
	fi
else
	echo -en ${LRED} '\nFail detecting Sublime Text/Merge version!\n'
	echo -en ${WHITE}
	read -p "Please input your Sublime Text/Merge build manually (supported builds are [$support_versions]): `echo $'\n> '`" v
fi

#
##
#### Check Sublime Text/Merge if the build is supported #####################################

if [[ ! $support_versions = *"$v"* ]]; then
	echo -en ${LRED} '\nError: Version '$v' is not in support list: ['$support_versions']\n'
	echo -en ${RED} '\nGoodbay!\n'
	echo -en ${RESTORE}
	exit 1
fi

#
##
### Patching binary #########################################################################

function patch {
    prog=$1
    shift
    until [ $# -eq 0 ]
	do
	    printf $2 | dd seek=$(($1)) conv=notrunc bs=1 of="$p/$prog" &> /dev/null
	    shift 2
	done
}

echo -en ${CYAN} '\nStart patching...\n\n'
case $v in
    "3206" )
	st3206='
	0x313659 \x08 0x31365A \x01 0x31365B \x90 0x31365C \x90 0x3136B1 \x08 0x3136B2 \x01 0x3136B3 \x90 0x3136B4 \x90
	0x31C57C \xC3 0x31C57D \x90 0x31C5EB \x90 0x31C905 \x74 0x31C9C6 \x90 0x31C9C7 \x90 0x31C9C8 \x90 0x31C9C9 \x90
	0x31C9CA \x90 0x31C9CB \x90 0x31C9CC \x90 0x31C9CD \x90 0x31C9CE \x90 0x31C9E6 \x75 0x31D258 \xC3 0x31D6CF \x90
	0x31D6D0 \x90 0x31D6D1 \x90 0x31D6D2 \x90 0x31D6D3 \x90 0x31D6D4 \x90 0x31D9E2 \xC3 0x31D9E3 \x90 0x31D9E4 \x90
	0x31DBCA \x90 0x31DBCB \x90 0x31DBCC \x90 0x31DBCD \x90 0x31DBCE \x90 0x31DBCF \x90 0x31DBD0 \x90 0x31DBD1 \x90
	0x31DBD2 \x90 0x31DBD3 \x90 0x31DBD4 \x90 0x31DBD5 \x90 0x31DBD6 \x90 0x31DBD7 \xC3 0x31DBD8 \x90 0x31DBD9 \x90
	0x31DBDA \x90 0x31DBDB \x90 0x31DBDC \x90 0x31DBDD \x90 0x31DBDE \x90 0x31DBDF \x90 0x31DBE0 \x90 0x31DBE1 \x90
	0x31DBE2 \x90 0x31DBE3 \x90 0x31DBE4 \x90 0x31DBE5 \xC3 0x3BF406 \x90 0x3BF407 \x90 0x3BF408 \x90 0x3BF409 \x90
	0x3BF40A \x90 0x3BF40B \x90 0x3BF40C \x90 0x3BF4CA \x90 0x3BF4CB \x90 0x3BF4CC \x90 0x3BF4CD \x90 0x3BF4CE \x90
	0x3BF4CF \x90 0x3BF4D0 \x90 0x3BF536 \x90 0x3BF537 \x90 0x3BF538 \x90 0x3BF539 \x90 0x3BF53A \x90 0x3BF53B \x90
	0x3BF53C \x90 0x3BF53E \xC3 0x3C0459 \x0F 0x3C045A \x01 0x3C045B \x90 0x3C045C \x90 0x3C045D \x90 0x3C045E \x90
	0x3C045F \x90 0x3C0460 \x90 0x479800 \x90 0x479801 \x90 0x479806 \x90 0x479807 \x90 0x479808 \x90 0x479809 \x90
	0x3C046E \x90 0x3C046F \x90 0x3C0470 \x90 0x3C0471 \x90 0x3C0472 \x90 0x3C0473 \x90 0x3C0474 \x90 0x3C0475 \x90 
	0x3C0476 \x90 0x3C0477 \x90 0x3C0478 \x90 0x3C0479 \x90 0x3C047A \x90 0x3C047B \x90 0x47980A \x90 0x47980B \x90'
	patch sublime_text $st3206
	;;

    "1111" )
	sm1111='
	0x2F6295 \x0F 0x2F6296 \x01 0x2F6297 \x90 0x2F6298 \x90 0x2F6299 \x90 0x2F629A \x90 0x2F629B \x90 0x2F629C \x90
	0x2F62AA \x90 0x2F62AB \x90 0x2F62AC \x90 0x2F62AD \x90 0x2F62AE \x90 0x2F62AF \x90 0x2F62B0 \x90 0x2F62B1 \x90
	0x2F62B2 \x90 0x2F62B3 \x90 0x2F62B4 \x90 0x2F62B5 \x90 0x2F62B6 \x90 0x2F62B7 \x90 0x308216 \x90 0x308217 \x90
	0x308218 \x90 0x308219 \x90 0x30821A \x90 0x30821B \x90 0x30821C \x90 0x30821E \xC3 0x308288 \x90 0x30830A \x90
	0x30830B \x90 0x30830C \x90 0x30830D \x90 0x30830E \x90 0x30830F \x90 0x308310 \x90 0x308312 \xC3 0x30EC74 \xC3
	0x30EC75 \x90 0x30ECE3 \x90 0x30ECE4 \xC3 0x30ECE5 \x90 0x30ECE6 \x90 0x30EF35 \x90 0x30F357 \xC3 0x30FBD3 \xC3
	0x30FCE0 \x90 0x30FCE1 \x90 0x30FCE2 \x90 0x30FCE3 \x90 0x30FCE4 \x90 0x30FCE5 \x90 0x30FCE6 \x90 0x30FCE7 \x90
	0x30FCE8 \x90 0x30FCE9 \x90 0x30FCEA \x90 0x30FCEB \x90 0x30FCEC \x90 0x30FCED \x90 0x30FCEE \x90 0x30FCEF \x90
	0x30FCF0 \x90 0x30FCF1 \x90 0x30FCF2 \x90 0x30FCF3 \x90 0x30FCF4 \x90 0x30FCF5 \x90 0x30FCF6 \x90 0x30FCF7 \x90
	0x30FCF9 \x90 0x30FCFA \x90 0x30FCFB \x90 0x310037 \xEB 0x310F6C \x08 0x310F6D \x01 0x310F6E \xEB 0x3DDC2C \xEB
	0x3DDC45 \x90 0x3DDC46 \x90 0x3DDC47 \x90 0x3DDC48 \x90 0x3DDC49 \x90 0x3DDC4A \x90 0x501B2A \x90 0x501B2B \x90
	0x501B30 \x90 0x501B31 \x90 0x501B32 \x90 0x501B33 \x90 0x501B34 \x90 0x501B35 \x90 0x501B3A \xE9 0x501B3B \x8F
	0x501B3C \x00 0x501B3F \x0F 0x501B40 \x84 0x501B41 \x89 0x501B42 \x00 0x501B43 \x00 0x501B44 \x00 0x7BC5D1 \xEB'
	patch sublime_merge $sm1111
	;;

	* )
    echo -en ${RED} 'Error: Version not supported for patching...\n'
    exit 1
    ;;
esac

echo -en ${LCYAN} 'The patching was done without errors.\n\n'
echo -en ${LGREEN} 'Congratulation!\n'
echo -en ${RESTORE} '\n'
#
exit 0
```

</p>
</details>
 
 
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

