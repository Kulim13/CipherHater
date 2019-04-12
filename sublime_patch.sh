#!/bin/bash
#

#############################################################################################
#
# Brief: Script for patching Sublime Text 3 Build 3207 and Sublime Merge Build 1111
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

versions_text='3207'
versions_merge='1111'

support_versions=${versions_text}${versions_merge}

#
##
#### Make sure only root can run our script #################################################
if [[ $EUID -ne 0 ]]; then
    echo -en ${LRED}"\nThis script must be run as root!\n\n"
    echo -en ${RED} 'Goodbay!\n\n'
    echo -en ${RESTORE}
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
	if [[ -f '/opt/sublime_text/sublime_text' ]]; then
	p='/opt/sublime_text'
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
    fi
fi

echo -en ${RED} '\n'
read -p 'Backup Sublime Text 3 binary? [y/n]: ' bt
    if [ -n $bt ] && [ $bt != "n" ]; then
	# Backup Sublime Text
	echo -en ${GREEN} '\nRunning backup: copy "sublime_text" to "sublime_text.orig" ...\n'
	cp -i "$p/sublime_text" "$p/sublime_text.orig"
	echo
    fi

echo -en ${WHITE} '\n'
read -p 'Show Sublime Text 3 license key? [y/n]: ' key

if [ -n $key ] && [ $key != "n" ]; then

echo -en ${LYELLOW} '\n' \
	'Instead of "Free World User" you can enter your name or any text.\n'
echo -en ${WHITE}

cat <<- license
	
— BEGIN LICENSE —–
Free World User
00 User License
HK3B-100025
1D77F72E 390CDD93 4DCBA022 FAF60790
61AA12C0 A37081C5 D0316412 4584D136
94D7F7D4 95BC8C1C 527DA828 560BB037
D1EDDD8C AE7B379F 50C9D69D B35179EF
2FE898C4 8E4277A8 555CE714 E1FB0E43
D5D52613 C3D12E98 BC49967F 7652EED2
9D2D2E61 67610860 6D338B72 5CF95C69
E36B85CC 84991F19 7575D828 470A92AB
—— END LICENSE ——
	
license
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
	if [[ -f '/opt/sublime_merge/sublime_merge' ]]; then
	p='/opt/sublime_merge'
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

    fi
fi

echo -en ${RED} '\n'
read -p 'Backup Sublime Merge binary? [y/n]: ' bm
    if [ -n $bm ] && [ $bm != "n" ]; then
	# Backup Sublime Merge
	echo -en ${GREEN} '\nRunning backup: copy "sublime_merge" to "sublime_merge.orig" ...\n'
	cp -i "$p/sublime_merge" "$p/sublime_merge.orig"
	echo
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
    "3207" )
	st3207='
	0x31365A \xEB 0x313A47 \xEB 0x31C93E \x90 0x31C93F \x90 0x31C945 \x90 0x31C946 \x90 0x31C94C \x90 0x31C94D \x90
	0x31C951 \x90 0x31C952 \x90 0x31C958 \x90 0x31C959 \x90 0x31C96D \xEB 0x31D667 \x90 0x31D668 \x90 0x31D669 \x90
	0x31D66A \x90 0x31D66B \x90 0x31D66C \x90 0x31D69C \x90 0x31D69D \x90 0x31D69E \x90 0x31D69F \x90 0x31D6A0 \x90
	0x31D6A1 \x90 0x31DE27 \xE9 0x31DE28 \xF9 0x31DE29 \x00 0x31DEC7 \xEB'
	patch sublime_text $st3207
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
