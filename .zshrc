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
plugins=(git brew osx redis-cli battery ec2 zsh-syntax-highlighting svn iterm-tab-colour)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11R6/bin:/Users/james/bin

if [ -d /Users/james/pebble ]; then
	export PATH=$PATH:/Users/james/pebble/PebbleSDK-2.0.0/bin
fi

if [ -d /Users/james/bin ]; then
	export PATH=$PATH:/Users/james/bin
fi

if [ $( hostname -s ) = "yukino" ]; then
	# At work
	hash -d puppet=/Users/jseward/src/puppet
	hash -d sm5=/Users/jseward/src/sm5
fi

export COPYFILE_DISABLE=true

if [ -f /usr/local/bin/aws_zsh_completer.sh ]; then
	source /usr/local/bin/aws_zsh_completer.sh
fi

alias -g jspretty="| jq ."
alias flake8="flake8 --ignore=E501"

setopt TRANSIENT_RPROMPT
REPORTTIME=10

# zsh-completions from homebrew
fpath=(/usr/local/share/zsh-completions $fpath)

# zsh-syntax-highlighting
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Fix ^U to behave correctly
bindkey ^U backward-kill-line

function fuck() {
	killall -9 $2;
	if [ $? == 0 ]
		then
		echo
		echo " (╯°□°）╯︵$(echo $2|flip &2>/dev/null)"
		echo
	fi
}
export EDITOR=nvim
PERL_MB_OPT="--install_base \"/Users/jseward/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/jseward/perl5"; export PERL_MM_OPT;

alias md5sum=md5

function tidy_nagios() {
	python ~/src/puppet/modules/nagios/tidy_nagios.py "$1" > "${1}_tmp" && mv "$1_tmp" "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias vim=nvim

function remove-ami-and-disk {
   SNAPSHOT=$( aws ec2 describe-images --image-ids $1 | jq -r ".Images[].BlockDeviceMappings[].Ebs.SnapshotId" | grep -vF null )
   aws ec2 deregister-image --image-id $1 && aws ec2 delete-snapshot --snapshot-id $SNAPSHOT
}

if [ -x $( which ccat ) ]; then
	alias cat=$( which ccat )
fi

agvim () {
	nvim $(ag --color "$1" | fzf --ansi | awk 'BEGIN { FS=":" } { printf "+%d %s\n", $2, $1 } ')
}
