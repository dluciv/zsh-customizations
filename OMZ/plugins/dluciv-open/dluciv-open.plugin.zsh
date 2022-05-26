if [[ -n "${aliases[open]}" ]] || [[ -n "${functions[open]}" ]] || command -v open; then
  # Already having some open defined
else

  case $OSTYPE in
    linux-android*)
      function open () {
        if [[ "$1" =~ .*://.* ]]; then
          termux-open-url $*
        else
          termux-open $*
        fi
      }
    ;;
    cygwin)
      function open () {
        start $*
      }
    ;;
    linux-gnu*)
      alias open='xdg-open'
    ;;
  esac

fi

