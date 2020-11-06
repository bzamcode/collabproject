#!/bin/bash

#check that the script is being run by the root user
clear

if [ $(id -u) != "0" ]; then
    echo "You must be the superuser to run this script" >&2
    exit 1
fi

















options[0]="Enable UFW"
options[1]="Disable UFW"
options[2]="Create UFW rules"
options[3]="Display UFW rules"
options[4]="Clear UFW rules"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        #Option 1 selected
        echo "Enabling UFW..."
		sudo ufw enable
    fi
    if [[ ${choices[1]} ]]; then
        #Option 2 selected
        echo "Disabling UFW"
		sudo ufw disable
    fi
    if [[ ${choices[2]} ]]; then
        #Option 3 selected
        echo "Creating UFW rules"
		sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw allow 443
	sudo ufw allow 22
	sudo ufw allow 80
	sudo ufw allow 3306
	sudo ufw status verbose 
		
    fi
	if [[ ${choices[3]} ]]; then
        #Option 1 selected
        echo "Displaying UFW Rules"
		sudo ufw status verbose
    fi
	if [[ ${choices[4]} ]]; then
        #Option 5 selected
        echo "Clearing UFW rules..."
		sudo ufw reset
    fi

}


#Clear screen for menu
clear

#Menu function
function MENU {
    echo "Menu Options"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}
#Variables
ERROR=" "
#Menu loop
while MENU && read -e -p "Select the desired options using their number (again to uncheck, ENTER when done): " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
