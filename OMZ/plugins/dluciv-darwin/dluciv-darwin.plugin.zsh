if [[ $OSTYPE == darwin* ]]; then
  brews_upgrade() {
    if command -v zb &>/dev/null; then
      zb update
    fi
    if command -v brew &>/dev/null; then
      brew upgrade --greedy
    fi
    alias upgrade='brews_upgrade'
  }
else
  >&2 echo "Darwin upgrade plugin cannot be used with '$OSTYPE' OS"
fi
