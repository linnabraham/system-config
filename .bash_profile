shortcuts >/dev/null 2>&1 &
# Use settings from ~/.bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/statusbar/:$PATH"
#export PATH="$HOME/miniconda3/bin:$PATH"
if [ -f ~/.local/share/radio_urls ]; then
    source ~/.local/share/radio_urls
fi

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
