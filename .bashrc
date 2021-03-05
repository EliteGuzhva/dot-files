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
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
force_color_prompt=yes

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

#===========================================================================================================================================================
# Personal configurations
set -o vi

# PATHS
export TOOLS=/opt/tools 

export CUDA_HOME=/usr/local/cuda 
export CMAKE_HOME=$TOOLS/cmake/cmake-3.17.2-Linux-x86_64 
export QT_HOME=$TOOLS/qt/Qt5.14.2/5.14.2/gcc_64
export QT_CREATOR_HOME=$TOOLS/qt/Qt5.14.2/Tools/QtCreator
export LIBTORCH_HOME=$TOOLS/libtorch
export TORCHVISION_HOME=$TOOLS/torchvision
export TORCHSERVER_HOME=$TOOLS/torchserver
export GOLANG_HOME=/usr/local/go
export EMACS_HOME=/home/nikita/.emacs.d
export CARGO_HOME=/home/nikita/.cargo
export GONEOVIM_HOME=/home/nikita/git_projects/Goneovim

export OPENCV_ROOT_DIR=/usr
export Python_ROOT_DIR=/usr
export TRT_ROOT_DIR=/opt/tools/TensorRT-7.0.0.11
export TRT_OSS_ROOT_DIR=/opt/tools/tensorrt-oss/cmake-build-release/install
export TRT_COGN_ROOT_DIR=/opt/tools/tensorrt-cognitive-plugins/cmake-build-release/install
export TRT_SERVER_LIBS_DIR=/opt/tools/libtensorrtserver/cmake-build-release

export CPP_DEPS_HOME=/home/nikita/git_projects/cpp-dependencies

# CPATH
export CPATH=$CPATH:/usr/include/hdf5/serial

# LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib32/:/lib/x86_64-linux-gnu/:/usr/lib/x86_64-linux-gnu/hdf5/serial/:$CUDA_HOME/lib64:/home/nikita/ar13_so:/usr/lib:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TRT_ROOT_DIR/lib:$TRT_OSS_ROOT_DIR/lib:$TRT_COGN_ROOT_DIR/lib:$TRT_SERVER_LIBS_DIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBTORCH_HOME/lib/:$TORCHVISION_HOME/install/lib/:$TORCHSERVER_HOME/build/
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$QT_HOME/lib:$QT_CREATOR_HOME/lib

# PATH
export PATH=$GONEOVIM_HOME:$CARGO_HOME/bin:$EMACS_HOME/bin:$CUDA_HOME/bin:$CMAKE_HOME/bin:$GOLANG_HOME/bin:$PATH
export PATH=$PATH:$QT_HOME/bin:$QT_CREATOR_HOME/bin
export PATH=$PATH:/opt/baidunetdisk
export PATH=$PATH:$CPP_DEPS_HOME/build/src

# Theme
export GTK_THEME="Adwaita:dark"

# Custom aliases
alias prog_folder='cd /data/disk/Data/Programming'
alias svn_fix='sudo ip route add 192.168.1.93/32 via 192.168.220.13'
alias gitlab_fix='sudo ip route add 192.168.1.92/32 via 192.168.220.12'
alias connect_vpn='sudo /home/nikita/Documents/Scripts/connect_vpn.sh'
alias mount_ftp='/home/nikita/Documents/Scripts/mount_ftp.sh'

alias baidu_disk='baidunetdisk & disown'

alias storage='df -t ext4 -h'
alias top20='find /home -type f -exec du -h {} + | sort -hr | head -20'

alias allow_access='ngrok tcp --region=eu 22'

alias hc='herbstclient'

alias gim='goneovim & disown'
alias gims='goneovim -S Session.vim & disown'

alias vim='nvim'
alias vims='nvim -S Session.vim'

alias ss='svn status'
alias sa='svn add'
alias sc='svn cl'
alias sr='svn remove'
alias sd='svn diff'
alias sb='svn blame'

# alacritty stuff (needed?)
source ~/.bash_completion/alacritty
