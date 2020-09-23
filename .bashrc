# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# virtualenv and virtualenvwrapper
#export WORKON_HOME=/home/linn/.virtualenvs
#export PROJECT_HOME=/home/linn/work/virtual
#source /usr/local/bin/virtualenvwrapper.sh
source $HOME/.local/bin/virtualenvwrapper.sh


export EDITOR="/usr/bin/vim"
#export BROWSER=firefox
export TODOTXT_DEFAULT_ACTION=ls
alias t='/usr/bin/todo.sh -a'
source $HOME/.config/todo_completion
complete -F _todo t
#alias todo-txt='/usr/bin/todo-txt -a -d /etc/todo-txt/config'

if [[ -n "`which luarocks 2>/dev/null`" ]]; then
    eval `luarocks path --bin`
fi

export PATH="/home/linn/.local/bin/:$PATH"
#export PATH="/home/linn/.virtualenvs/pytools/bin/:$PATH"
export PATH="/home/linn/.local/bin/pandoc-2.10/bin/:$PATH"
# to fix problem with telegram-cli
#export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

#export LUA_PATH='/home/linn/.luarocks/share/lua/5.1/?.lua;/home/linn/.luarocks/share/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;./?.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua'
#export LUA_CPATH='/home/linn/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;./?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'

export SHARE_PATH=/media/linn/mycupboard/linux/quilt_packages
export QUILT_PRIMARY_PACKAGE_DIR=$SHARE_PATH

#alias config='/usr/bin/git --git-dir=/home/linn/dotfiles/ --work-tree=/home/linn'
export LESS=-R\ $LESS

# source bash functions from external file
if [[ -f ~/.bashrc_scripts ]]; then
    source ~/.bashrc_scripts
fi

# source secrets from external file
if [[ -f ~/.secrets ]]; then
    source ~/.secrets
fi

# enable bash completion for the pass program
if [[ -f ~/.config/pass.bash-completion ]]; then
    source ~/.config/pass.bash-completion
fi

#export PATH="/home/linn/.local/bin:$PATH"
#export PATH="/home/linn/miniconda3/bin:$PATH"

#set vim key-bindings in shell
#set -o vi
#bind ^L:clearscreen

#TODO:find a better color scheme for other writable attribute coloring.
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
export PATH="/usr/lib64/java/jre/bin/:$PATH"
export TERM=xterm-256color
#export PATH="/usr/local/texlive/2019/bin/x86_64-linux:$PATH"
export TEXMFHOME=/home/linn/.texmf/

# git prompt
source $HOME/.local/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_HIDE_IF_PWD_IGNORED=true

# version with short working directory

function shortwd() {
    num_dirs=3
    pwd_symbol="..."
    newPWD="${PWD/#$HOME/~}"
    if [ $(echo -n $newPWD | awk -F '/' '{print NF}') -gt $num_dirs ]; then
        newPWD=$(echo -n $newPWD | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')
    fi
    echo -n $newPWD
}

export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h:$(shortwd)\[\033[0;32m\]$(__git_ps1)\[\033[0;32m\]\$ '

export FZF_DEFAULT_COMMAND='fd .  --hidden --follow --exclude .git '
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
#export FZF_DEFAULT_COMMAND='find '
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

xrdb -load /dev/null
#eval "$(thefuck --alias f)"
export PROMPT_COMMAND='history -a'
HISTCONTROL=ignoredups:erasedups

#export PYTHONPATH="/$HOME/work/testbed/train/:$PYTHONPATH"
#export PYTHONPATH="/$HOME/work/ztf/testbed/train/:$PYTHONPATH"
export PYTHONPATH="$HOME/work/ztf/testbed/package:$PYTHONPATH"
unset SSH_ASKPASS

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
#bindkey -s 'Alt+f' cd_with_fzf
export TDIR="$HOME/Dropbox/todo"
complete -cf sudo
export MYBIB='/home/guest/mybib.bib'
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/.local/share/gems"
#export PATH="$HOME/.local/share/gems/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
#export PATH="/home/linn/.vim/plugged/vim-live-latex-preview/bin":$PATH

export XDG_CONFIG_HOME="$HOME/.config"
[ -f $XDG_CONFIG_HOME/shortcutrc ] && source $XDG_CONFIG_HOME/shortcutrc
export TERMINAL=/usr/local/bin/st
#workon tf
source /etc/profile.d/undistract-me.sh
export RANGER_LOAD_DEFAULT_RC=FALSE
stty -ixon
