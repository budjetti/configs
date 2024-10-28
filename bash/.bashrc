#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# budjetti's aliases
# TODO add help function that lists out all these
alias sus='systemctl suspend'
alias rb='reboot'
alias sd='shutdown 0'
alias i='startx /usr/bin/i3'
alias sr='xrandr --output DP-0 --mode 1920x1080 --rate 144.00'
alias brc-edit='sudo vim ~/.bashrc'
alias brc-reload='source ~/.bashrc'
alias i3config-edit='sudo vim /etc/i3/config'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
