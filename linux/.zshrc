# Path to your oh-my-zsh installation.
export ZSH="/home/nikita/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#===========================================================================================================================================================
# Personal configurations
export EDITOR='vim'
bindkey -v
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# Custom env
export MXNET_CUDNN_AUTOTUNE_DEFAULT=0

# PATHS
export TOOLS=/data/tools
export GIT_PROJECTS=$HOME/git_projects

export SCRIPTS=$HOME/Documents/Scripts
export APPIMAGES=$HOME/appimages

export CUDA_HOME=/usr/local/cuda 
export GOLANG_HOME=$TOOLS/GoLang
export EMACS_HOME=$HOME/.emacs.d
export CARGO_HOME=$HOME/.cargo
export FLUTTER_HOME=$TOOLS/Flutter
export ANDROID_SDK_HOME=$HOME/Android/Sdk

# CPATH
export CPATH=/usr/include/hdf5/serial

# LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib32/:/lib/x86_64-linux-gnu/:/usr/lib/x86_64-linux-gnu/hdf5/serial/:/usr/lib:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64

# PATH
export PATH=$SCRIPTS:$PATH
export PATH=$APPIMAGES:$PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$CUDA_HOME/bin
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:$GOLANG_HOME/bin
export PATH=$PATH:$EMACS_HOME/bin
export PATH=$PATH:/opt/baidunetdisk
export PATH=$PATH:$FLUTTER_HOME/bin

# Theme
export BAT_THEME="base16"

# Custom aliases
alias ls='exa'
alias tldr='tldr -t base16'
alias hc='herbstclient'
alias baidu_disk='baidunetdisk & disown'
alias prog_folder='cd /data/disk/Data/Programming'
alias svn_fix='sudo ip route add 192.168.1.93/32 via 192.168.220.13'
alias gitlab_fix='sudo ip route add 192.168.1.92/32 via 192.168.220.12'
alias emulator="$ANDROID_SDK_HOME/emulator/emulator -avd Pixel_3a_API_30_x86 -netdelay none -netspeed full"
alias nvid="neovide --multigrid"
alias nvid_remote="nvid --remote-tcp=localhost:1337"

# svn
svndiff() {
    svn diff $1 | bat
}

alias ss='svn status'
alias sa='svn add'
alias sc='svn cl'
alias sr='svn remove'
alias sd='svndiff'
alias sb='svn blame'

# git
gitdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

alias gd='gitdiff'

# init starship
eval "$(starship init zsh)"

# switch caps and esc
setxkbmap -option "caps:escape"
