if which open &>/dev/null; then
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
    cygwin*|msys*)
      alias open='cmd /c start'
    ;;
    linux-gnu*)
      alias open='xdg-open'
    ;;
  esac

fi

