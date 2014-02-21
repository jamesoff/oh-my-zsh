# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jms"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew osx redis-cli battery ec2 zsh-syntax-highlighting svn)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11R6/bin:/Users/james/bin

if [ -d /Users/james/pebble ]; then
	export PATH=$PATH:/Users/james/pebble/PebbleSDK-2.0.0/bin
fi

if [ -d /Users/james/bin ]; then
	export PATH=$PATH:/Users/james/bin
fi

export COPYFILE_DISABLE=true

if [ -f /usr/local/bin/aws_zsh_completer.sh ]; then
	source /usr/local/bin/aws_zsh_completer.sh
fi

alias -g jspretty="| jq ."
setopt TRANSIENT_RPROMPT
REPORTTIME=10

# zsh-completions from homebrew
fpath=(/usr/local/share/zsh-completions $fpath)

# Fix ^U to behave correctly
bindkey ^U backward-kill-line
