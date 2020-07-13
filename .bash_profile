export PATH="$HOME/.local/bin:$PATH"
shortcuts >/dev/null 2>&1 &
# Use settings from ~/.bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
export PATH="$HOME/.local/bin/statusbar/:$PATH"
#export PATH="$HOME/miniconda3/bin:$PATH"
export AIRM="http://airmalayalam-lh.akamaihd.net/i/airmalayalam_1@507816/master.m3u8"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi


