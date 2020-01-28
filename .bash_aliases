alias lt='ls -t | head'
alias llt='ls -lt | head'
alias ld='ls -d */'
alias lf='ls -ptw 1 | grep -v /'
alias lc='ls | wc -l'
alias cls='clear'
alias clr='clear;ls'
alias df='df -hT -x squashfs'
alias pg='ps aux | grep'
alias sudox="sudo chmod u+x"
alias pingg='ping -c 10 google.com'
alias wget='wget -c -U "mozilla"'
alias mpv='mpv --shuffle --no-audio-display'
alias mplayer='mpv'
alias word='sdcv'
alias sc='sc-im'
alias ytdl='youtube-dl --no-playlist -cit -f 18'
alias ytdl-music='youtube-dl --extract-audio --audio-format mp3'
alias gcal='gcalcli' #'gcalcli --nocache'
alias calw='gcal calw --monday today'
alias telegram-cli='telegram-cli -N'
alias link="watch -n1 '/sbin/iwconfig wlan0 | grep -i quality'"
alias lynx="lynx -accept-all-cookies"
alias fehs='feh --start-at'
alias chromium-browser='chromium-browser --password-store=basic %U' #--incognito
alias config='/usr/bin/git --git-dir=/home/guest/.myconf/ --work-tree=/home/guest/'
alias gs="git status"
alias gc='git commit -m '
