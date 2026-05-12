if [[ $OSTYPE == darwin* ]]; then
    brews_upgrade() {
	local outdated_names
	if command -v zb &>/dev/null; then
	    outdated_names=$(zb outdated --json | jq -r '.[] | .name')
	    while IFS= read -r outdated_name; do
		zb install $outdated_name
	    done <<< "$outdated_names"
	fi
	if command -v brew &>/dev/null; then
	    brew upgrade --greedy
	fi
    }
    alias upgrade='brews_upgrade'
else
    >&2 echo "Darwin upgrade plugin cannot be used with '$OSTYPE' OS"
fi
