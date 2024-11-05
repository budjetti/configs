#!/bin/bash
echo "hello jon"
for var in "$@"
do
	# TODO overengineer this with structs
	echo "$var"
	if [ $var == "i3" -o $var == "all" ]; then
		cp i3/config ~/.config/i3/config
		echo "i3 needs to be restarted"
	fi
	if [ $var == "bash" -o $var == "all" ]; then
		cp  bash/.bashrc ~/.bashrc
		source ~/.bashrc
	fi
	if [ $var == "nvim" -o $var == "neovim" -o $var == "all" ]; then
		cp neovim/init.lua ~/.config/nvim/init.lua
		echo "nvim may need be restarted"
	fi
	if [ $var == "all" ]; then
		break
	fi
done
