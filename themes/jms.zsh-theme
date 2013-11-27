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

PROMPT='%{$reset_color%}%n%{$fg[white]%}@%{$reset_color%}%m$SCR_WINDOW$SCR_COLOR:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info) %(0?,,%{$fg[red]%}%?!%{$reset_color%} )$BATTERY%(!.%{$fg[red]%}.%{$fg[green]%})%#%{$reset_color%} '
RPROMPT='$(aws_prompt) %{$fg_bold[black]%}%T%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=":%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{161}!%{$reset_color%}"

