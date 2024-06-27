#/bin/bash

# Source: https://github.com/junegunn/fzf/blob/master/ADVANCED.md

_open_path() {
	local input_path=$1

	if [ ! -n "$input_path" ]; then
		echo 'No choice'
		return 1
	fi
	echo '[ ] cd'
	echo '[r] remove'
	echo '[v] nvim'
	echo -n 'Enter your choice: '
	read choice

	if [[ "$input_path" =~ ^[^:]*:[^:]*:[^:]*:.*$ ]]; then
		input_path="${input_path%%:*}"
	fi

	case $choice in
	'' | ' ')
		if [ -f "$input_path" ]; then
			input_path=$(dirname "$input_path")
		fi
		cd "$input_path"
		;;
	'r' | 'R') rm -rf "$input_path" ;;
	'v' | 'V') nvim "$input_path" ;;
	*) echo 'Selection is invalid!' ;;
	esac
}

_get_path_using_fd() {
	local input_path=$(
		fd --type file |
			fzf --prompt 'Files> ' \
				--header 'CTRL-S: Switch between Files/Directories' \
				--bind 'ctrl-s:transform:[[ ! $FZF_PROMPT =~ Files ]] &&
        echo "change-prompt(Files> )+reload(fd --type file)" ||
        echo "change-prompt(Directories> )+reload(fd --type directory)"' \
				--preview '[[ $FZF_PROMPT =~ Files ]] && bat --color=always {} || tree -C {}'
	)
	echo "$input_path"
}

_get_path_using_rg() {
	rm -f /tmp/rg-fzf-{r,f}
	local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	local INITIAL_QUERY="${*:-}"
	local input_path=$(
		fzf --ansi --disabled --query "$INITIAL_QUERY" \
			--bind "start:reload:$RG_PREFIX {q}" \
			--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
			--bind 'ctrl-s:transform:[[ ! $FZF_PROMPT =~ ripgrep ]] &&
      echo "rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
      echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
			--color "hl:-1:underline,hl+:-1:underline:reverse" \
			--prompt '1. ripgrep> ' \
			--delimiter : \
			--header 'CTRL-S: Switch between ripgrep/fzf' \
			--preview 'bat --color=always {1} --highlight-line {2}' \
			--preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
	)
	echo "$input_path"
}

fdg() {
	_open_path "$(_get_path_using_fd)"
}

rgg() {
	_open_path "$(_get_path_using_rg)"
}

bindkey -s '^g' 'rgg\n'
bindkey -s '^f' 'fdg\n'
