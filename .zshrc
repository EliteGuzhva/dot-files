# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/elit3guzhva/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
bindkey -v
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

SCRIPTS_HOME="$HOME/git_projects/scripts"
CARGO_HOME="$HOME/.cargo"

TOOLS="$HOME/tools"
ANDROID_HOME="$TOOLS/Android_SDK"

BREW_HOME="/opt/homebrew"
LLVM_HOME="$BREW_HOME/opt/llvm"
NODE_HOME="$BREW_HOME/opt/node@14"
OPENJDK_HOME="$BREW_HOME/opt/openjdk@11"
PYTHON_HOME="$BREW_HOME/opt/python@3.9"
GCC_HOME="$BREW_HOME/opt/gcc"

export PATH="$SCRIPTS_HOME:$PATH"
export PATH="$CARGO_HOME/bin:$PATH"
# export PATH="$LLVM_HOME/bin:$PATH"
export PATH="$NODE_HOME/bin:$PATH"
export PATH="$OPENJDK_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$PYTHON_HOME/bin:$PATH"
# export PATH="$GCC_HOME/bin:$PATH"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# Aliases
alias vim="nvim"
alias bs="brew search"
alias bi="brew install"
alias allow_access="ngrok tcp --region=eu 22"
alias hg="history | grep"
alias prog_folder="cd ~/Yandex.Disk.localized/Data/Programming"
alias uni_folder="cd ~/Yandex.Disk.localized/Data/Uni"
alias emulator="/Users/eliteguzhva/Library/Android/sdk/emulator/emulator -avd Pixel_4_API_29i -netdelay none -netspeed full"
alias tmux="tmux -2"
alias uber_folder="cd ~/Library/Application\ Support/Übersicht/widgets/"
alias ls='exa'
alias nvid="neovide --multigrid"
alias nvid_remote="neovide --multigrid --remote-tcp=localhost:1337"

alias connect_vpn="sudo openvpn --config ~/Documents/Robots_NikitaGuzhva_ctvpn.ovpn & disown"
alias rbt_fix='sudo route add -net 192.168.0.64/32 192.168.220.14'
alias ftp_fix='sudo route add -net 192.168.0.168/32 192.168.220.18'
alias svn_fix='sudo route add -net 192.168.1.93/32 192.168.220.13'
alias gitlab_fix='sudo route add -net 192.168.1.92/32 192.168.220.12'

alias ezmix='arch -x86_64 /Applications/Toontrack/EZmix.app/Contents/MacOS/EZmix'

gitdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

alias gd='gitdiff'

export BAT_THEME="Nord"

export EDITOR='vim'
bindkey -v

eval "$(starship init zsh)"

# Switch to an arm64e shell by default
if [ `machine` != arm64e ]; then
    exec arch -arm64 zsh
fi

