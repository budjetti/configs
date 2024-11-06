#!/bin/bash
try_copy(){
	DIFF=$(diff $1 $2)
	if [ "$DIFF" == "" ] 
	then
		echo "$2 is already up to date"
		return
	else
		cp $1 $2
		echo -n "Updated $2"
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
	if [ $var == "bash" -o $var == "all" ]; then
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
		break
	fi
done
