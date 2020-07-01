# ubuntu_patch_1.0
#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"

check_exit_status() {

	if [ $? -eq 0 ]
	then
	
		echo -e "${GREEN}Success${NOCOLOR}"
		echo
	else
		
		echo -e "${RED}[ERROR] Process Failed!${NOCOLOR}"
		echo
		
		read -p "The last command exited with an error. Exit script? (yes/no) " answer

            if [ "$answer" == "yes" ]
            then
                exit 1
            fi
	fi
}

greeting() {

	echo
	echo "Hello, $USER. Let's update this system."
	echo
	sleep 2

}

update() {
	echo -e "Step 1: ${YELLOW}Update apt cache...${NOCOLOR}"
        sudo apt-get update;
	check_exit_status

	echo -e "Step 2: ${YELLOW}Upgrade packages...${NOCOLOR}"
        sudo apt-get upgrade -y;
	check_exit_status

#       sudo apt-get dist-upgrade -y;
#	check_exit_status
}

housekeeping() {
	echo -e "Step 3: ${YELLOW}Remove unused packages...${NOCOLOR}"
	sudo apt-get autoremove -y;
	check_exit_status

	echo -e "Step 4: ${YELLOW}Clean up...${NOCOLOR}"
	sudo apt-get autoclean -y;
	check_exit_status

#	sudo updatedb;
#	check_exit_status
}

leave() {

	echo
	echo "--------------------"
	echo "- Update Complete! -"
	echo "--------------------"
	echo
	exit
}

greeting
update
housekeeping
leave
