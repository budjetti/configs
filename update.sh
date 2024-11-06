#!/bin/bash
try_copy(){
	# TODO make this thing work
	NULL_DIR=$(diff $1 $2 | grep 'No such')
	if [ "$NULL_DIR" != "" ]; then
		echo "NOT FOUND $2"
		return
	fi

	DIFF=$(diff $1 $2)
	if [ "$DIFF" == "" ]; then
		echo "UP-TO-DATE $2"
		return
	else
		cp $1 $2
		echo -n "UPDATED $2"
	fi

	# Check for the "-r" at the end. There's probably a cleaner way to do this
	if [ ! -z $3 ]; then
		echo " ... NEEDS RESTART"
	else
		echo ""
	fi
}

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
		try_copy i3/config ~/.config/i3/config -r
	fi
	if [ $var == "nvim" -o $var == "neovim" -o $var == "all" ]; then
		try_copy neovim/init.lua ~/.config/nvim/init.lua -r
	fi
	# TODO vencord
	# TODO hypr
	# TODO waybar
	if [ $var == "all" ]; then
		echo "WARNING: the 'all' argument does not include 'bash' or 'bash-dell'"
		break
	fi
done
