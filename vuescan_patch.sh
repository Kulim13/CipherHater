#!/bin/bash
#

#############################################################################################
#
# Brief: Script for patching VueScan 9 x64 (9.6.38) Linux x86_64
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

version_vuescan='9.6.38'

#
##
### Start menu ##############################################################################

echo -en ${LYELLOW} "\nThis script supports only: \n\n \
	${GREEN}Platform: ${WHITE} Linux x86_64\n\n \
	${GREEN}VueScan 9 x64 (v9.6.38): ${LMAGENTA} $version_vuescan\n\n"

echo -en ${RESTORE}

#
##
### Function for VueScan 9 #############################################################

function vuescanPatching {
echo -en ${YELLOW} '\nChecking VueScan path ...\n'

if [[ -f './vuescan' ]]; then 
	p='.'
else
	echo -en ${WHITE} 
	read -r -p "Please input VueScan installed path (the directory contains vuescan): \
			    `echo $'\n> '`" p

	if [[ ! -d "$p" ]]; then
	    echo -en ${LRED} '\nError: '$p' Is not a directory!\n\n'
	    echo -en ${RED} 'Goodbay!\n\n'
	    echo -en ${RESTORE}
	    exit 11
	fi

	if [[ ! -f "$p/vuescan" ]]; then
	    echo -en ${LRED} '\nError: '$p' Is not a VueScan installed path!\n\n'
	    echo -en ${RESTORE}
	    echo -en ${RED} 'Goodbay!\n\n'
	    exit 12
	fi

	# Replace "\" with "/"
	p=$(echo $p | sed 's/\\/\//g')

	# Trim trailing "/"
	p=${p%/}

	echo -en ${RED} '\n'
	read -p 'Backup VueScan 9 binary? [y/n]: ' bt
	if [ -n $bt ] && [ $bt != "n" ]; then
	    # Backup VueScan
	    echo -en ${GREEN} '\nRunning backup: copy "vuescan" to "vuescan.orig" ...\n'
	    cp -i "$p/vuescan" "$p/vuescan.orig"
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
read -n1 -p "Pick a letter to run patching: V - VueScan 9, or E - Exit script." runPatching

case $runPatching in
	v|V) printf "\n\nStart patching VueScan 9 x64.\n" && vuescanPatching;;
	e|E) printf "\n\nGoodbay!\n\n" && exit 0;;
esac
}

mainWork

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
case $version_vuescan in
    "9.6.38" )
	vs9638='
	0x03D78B \x01 0x04B7D2 \x90 0x04B7D3 \x90 0x04B7D4 \x90 0x04B7D5 \x90 0x04B7D6 \x90 0x04B7D7 \x90 0x04B803 \x00
	0x04D42E \x90 0x04D42F \x90 0x04D430 \x90 0x04D431 \x90 0x04D432 \x90 0x04D433 \x90 0x04D997 \x90 0x04D998 \x90
	0x04D999 \x90 0x04D99A \x90 0x04D99B \x90 0x04D99C \x90 0x04D99D \x90 0x04D99E \x90 0x04D99F \x90 0x04D9A0 \x90
	0x04D9A1 \x90 0x04D9A2 \x90 0x04D9A3 \x90 0x04D9A4 \x90 0x04D9A5 \x90 0x04D9A6 \x90 0x04D9A7 \x90 0x04D9A8 \x90
	0x04D9A9 \x90 0x04E247 \x90 0x04E248 \x90 0x04E249 \x90 0x04E24A \x90 0x04E24B \x90 0x04E24C \x90 0x072EE6 \x90
	0x072EE7 \x90 0x072EE8 \x90 0x072EE9 \x90 0x072EEA \x90 0x072EEB \x90 0x076546 \xE9 0x076547 \xCB 0x076548 \x07
	0x076549 \x00 0x076D18 \xE9 0x076D19 \x62 0x076D1A \xF8 0x076D1B \xFF 0x0775F0 \x90 0x0775F1 \x90 0x0775FB \x90
	0x0775FC \x90 0x077605 \xEB 0x07760E \x90 0x07760F \x90 0x07761E \xEB 0x07765A \xEB 0x077683 \x90 0x077684 \x90
	0x07768E \x90 0x07768F \x90 0x077698 \xE9 0x077699 \x9E 0x07769A \x00 0x077735 \x90 0x077736 \x90 0x077737 \x90
	0x077738 \x90 0x077739 \x90 0x07773A \x90 0x08859A \x90 0x08859B \x90 0x08859C \x90 0x08859D \x90 0x08859E \x90
	0x08859F \x90 0x08B70F \x90 0x08B710 \x90 0x08B711 \x90 0x08B712 \x90 0x08B713 \x90 0x08B714 \x90 0x08B715 \x90
	0x08B716 \x90 0x08B717 \x90 0x08B718 \x90 0x08B71A \x90 0x08B71B \x90 0x08B71C \x90 0x08B71D \x90 0x08B71E \x90
	0x08B71F \x90 0x08B720 \x90 0x08B721 \x90 0x08B722 \x90 0x08B723 \x90 0x08B724 \x90 0x08B725 \x90 0x08B726 \x90
	0x08B727 \x90 0x08B728 \x90 0x08B729 \x90 0x08B72A \x90 0x08B72B \x90 0x08B72C \x90 0x08B72D \x90 0x08B72E \x90
	0x08B72F \x90 0x08B730 \x90 0x08B731 \x90 0x08B732 \x90 0x08B733 \x90 0x08B734 \x90 0x08B735 \x90 0x08B736 \x90
	0x08B737 \x90 0x08BA56 \xE9 0x08BA57 \xB2 0x08BA58 \xFC 0x08BA59 \xFF 0x08BA5E \x90 0x08BA5F \x90 0x08BA60 \x90
	0x08BA61 \x90 0x08BA62 \x90 0x08BA63 \x90 0x08BB9C \x90 0x08BB9D \x90 0x08BBB6 \x01 0x08BD66 \x90 0x08BD67 \x90
	0x08BD68 \x90 0x08BD69 \x90 0x08BD6A \x90 0x08BD6B \x90 0x08BD7F \x90 0x08BD80 \x90 0x08BD81 \x90 0x08BD82 \x90
	0x08BD83 \x90 0x08BD84 \x90 0x096625 \xE9 0x096626 \xAE 0x096627 \x0B 0x096628 \x00 0x09E300 \xC3 0x09E3E0 \xC3
	0x09E3E1 \x90 0x09E3E2 \x90 0x09E3E3 \x90 0x09E3E4 \x90 0x09E3F0 \xC3 0x09E402 \xEB 0x09E416 \x90 0x09E417 \x90
	0x09E434 \x90 0x09E435 \x90 0x09E43B \x90 0x09E43C \x90 0x09E45F \x90 0x09E460 \x90 0x09E468 \x90 0x09E469 \x90
	0x09E46D \x90 0x09E46E \x90 0x09E46F \x90 0x09E470 \x90 0x09E471 \x90 0x09E472 \x90 0x09E476 \x90 0x09E477 \x90
	0x09E478 \x90 0x09E479 \x90 0x09E47A \x90 0x09E47B \x90 0x09E480 \x90 0x09E481 \x90 0x09E482 \x90 0x09E483 \x90
	0x09E484 \x90 0x09E485 \x90 0x09E489 \x90 0x09E48A \x90 0x09E491 \x90 0x09E492 \x90 0x09E493 \x90 0x09E494 \x90
	0x09E495 \x90 0x09E496 \x90 0x09E4B7 \xEB 0x09E4DF \x90 0x09E4E0 \x90 0x09E630 \xC3 0x09E631 \x90 0x09E632 \x90
	0x09E633 \x90 0x09E748 \x90 0x09E749 \x90 0x09EFE2 \xEB 0x0A1940 \xC3 0x0A1941 \x90 0x0A1942 \x90 0x0A1943 \x90
	0x0A1944 \x90'
	patch vuescan $vs9638
	;;

	* )
    echo -en ${RED} 'Error: Patching failed...\n'
    exit 1
    ;;
esac

echo -en ${LCYAN} 'The patching was done without errors.\n\n'
echo -en ${LGREEN} 'Congratulation!\n'
echo -en ${RESTORE} '\n'
#
exit 0
