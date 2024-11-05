#!/bin/bash
for var in "$@"
do
	# TODO overengineer this with structs
	if [ $var == "bash" -o $var == "all" ]; then
		cp  bash/.bashrc ~/.bashrc
		source ~/.bashrc
		echo "Updated and reloaded bashrc"
	fi
	if [ $var == "i3" -o $var == "all" ]; then
		cp i3/config ~/.config/i3/config
		echo "Updated i3/config ... NEEDS RESTART"
	fi
	if [ $var == "nvim" -o $var == "neovim" -o $var == "all" ]; then
		cp neovim/init.lua ~/.config/nvim/init.lua
		echo "Updated nvim/init.lua ... NEEDS RESTART"
	fi
	# TODO vencord
	# TODO hypr
	# TODO waybar
	if [ $var == "all" ]; then
		break
	fi
done
