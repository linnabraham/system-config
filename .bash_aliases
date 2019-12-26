
alias lt='ls -lt | head'
alias ld='ls -d */'
alias lf='ls -ptw 1 | grep -v /'
alias telegram-cli='telegram-cli -N'
alias cls='clear'
alias lc='ls | wc -l'
alias ping='ping -c 10 google.com'
alias clr='clear;ls'
alias rtm='f(){ if [ "$1" == "ls" -a "$2" == "" ] ; then rtm  "$1" list:inbox AND NOT tag:personal -x false;\
elif [ "$1" == "planner" ] ; then rtm "$1" list:inbox ; else rtm "$@" ; fi; unset -f f; }; f'
alias config='/usr/bin/git --git-dir=/home/guest/.myconf/ --work-tree=/home/guest/'
alias word='sdcv'
