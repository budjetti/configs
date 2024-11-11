#!/bin/bash
try_copy(){
	copy_from=$1
	copy_to=$2
	if [ $reverse == "TRUE" ]; then
		copy_from=$2
		copy_to=$1
	fi

	# TODO make this thing work
	NULL_DIR=$(diff $copy_from $copy_to | grep 'No such')
	if [ "$NULL_DIR" != "" ]; then
		echo "NOT FOUND $copy_to"
		return
	fi

	DIFF=$(diff $copy_from $copy_to)
	if [ "$DIFF" == "" ]; then
		echo "UP-TO-DATE $copy_to"
		return
	else
		if [ $copy_from -ot $copy_to ]; then
			read -r -p "Replace with older file? $copy_to [Y/n] " response
			if [[ "$response" =~ ^([nN][oO]|[nN])$ ]]
			then
				return
			fi
		fi
		cp $copy_from $copy_to
		echo -n "UPDATED $copy_to"
	fi

	# Check for the "--restart" at the end. There's probably a cleaner way to do this
	if [ ! -z $3 ] && [ $reverse == "FALSE" ]; then
		echo " ... NEEDS RESTART"
	else
		echo ""
	fi
}

reverse="FALSE"
for var in "$@"
do
	if [ $var == "-r" -o $var == "--reverse" ]; then
		reverse="TRUE"
	fi
done

for var in "$@"
do
	# TODO overengineer this with structs
	if [ $var == "bash" ]; then
		try_copy bash/.bashrc ~/.bashrc
		source ~/.bashrc
	fi
	if [ $var == "bash-dell" ]; then
		try_copy bash/.bashrc-dell ~/.bashrc
		source ~/.bashrc
	fi

	if [ $var == "i3" -o $var == "all" ]; then
		try_copy i3/config ~/.config/i3/config --restart
	fi
	if [ $var == "i3status" -o $var == "all" ]; then
		try_copy i3status/config ~/.config/i3status/config --restart
	fi

	# TODO make arch/dell a flag or something
	if [ $var == "i3-arch" -o $var == "all" ]; then
		try_copy i3/config ~/etc/i3/config --restart
	fi
	if [ $var == "i3status-arch" -o $var == "all" ]; then
		try_copy i3status/config ~/etc/i3status/config --restart
	fi

	if [ $var == "nvim" -o $var == "neovim" -o $var == "all" ]; then
		try_copy neovim/init.lua ~/.config/nvim/init.lua --restart
	fi

	# partially broken
	if [ $var == "vencord" -o $var == "all" ]; then
		if [ -d ~/.var/app/com.discordapp.Discord/config/Vencord ]; then
			try_copy vencord/ClearVision_v6_edit.theme.css ~/.var/app/com.discordapp.Discord/config/Vencord/themes --restart
			try_copy vencord/settings.json ~/.var/app/com.discordapp.Discord/config/Vencord/settings --restart
		else
			#TODO add .deb
			echo "no flatpak install of vencord found"
		fi
	fi

	# TODO hypr
	# TODO waybar
	if [ $var == "all" ]; then
		echo "WARNING: the 'all' argument does not include 'bash' or 'bash-dell'"
		break
	fi
done
