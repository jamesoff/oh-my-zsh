# check if 'screen' is in TERM
SCR_COLOR=%{$fg[white]%}

if [ "$TERM" = "screen" ]; then
	SCR_COLOR=%{$fg[yellow]%}
fi

if [ "$TERM" = "screen-bce" ]; then
	SCR_COLOR=%{$fg[yellow]%}
fi

if [ "x$WINDOW" != "x" ]; then
	SCR_WINDOW="%{$fg[yellow]%}#$WINDOW"
elif [ "x$TMUX" != "x" ]; then
	SCR_WINDOW="%{$fg[yellow]%}#$(tmux display-message -p '#I')"
else
	SCR_WINDOW=""
fi

if [ "x$(battery_pct_prompt)" = "x" ]; then
	BATTERY=""
else
	BATTERY="$(battery_pct_prompt) "
fi
BATTERY=""

HOSTNAME=$(hostname)
HOSTCOLOUR=$(string_hash $HOSTNAME:l 15)

# Average prompt length computed with:
# % COUNT=0; TOTAL=0; for j in $( for i in $( history | awk '{OFS="_"; $1 = ""; print $0}' ); do; echo "$i" | wc -c; done ); do; COUNT=$(( COUNT + 1 )); TOTAL=`echo $TOTAL+$j | bc`; done; echo total=$TOTAL count=$COUNT; echo -n average=; echo "$TOTAL / $COUNT" | bc
# total=74843 count=2749
# average=27
PROMPT_AVERAGE=40

function prompt_space() {
	# Returns maximum length of command prompt which leaves space for average length command, based on current terminal width
	echo $(( $(tput cols) - $PROMPT_AVERAGE ))
}

# Line break in here is on purpose
PROMPT='%{$reset_color%}%n%{$fg[white]%}@%{%F{$HOSTCOLOUR}%}%m$SCR_WINDOW$SCR_COLOR:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)$(svn_prompt_info) %(0?,,%{$fg[red]%}%?!%{$reset_color%} )%(!.%{$fg[red]%}.%{$fg[green]%})%($(prompt_space)l.
.)%#%{$reset_color%} '

RPROMPT='$BATTERY%{$fg_bold[black]%}%*%{$reset_color%}'
# include aws_prompt if the ec2 plugin is loaded
if [ "x$AWS_PLUGIN" = "x1" ]; then
	RPROMPT='$(aws_prompt) '$RPROMPT
fi

ZSH_THEME_GIT_PROMPT_PREFIX=":%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{161}!%{$reset_color%}"

ZSH_THEME_SVN_PROMPT_PREFIX=":%{$fg_bold[red]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_DIRTY="%F{161}!%{$reset_color%}"

