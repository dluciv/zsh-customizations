if ! which open &>/dev/null; then

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
    cygwin*)
      alias open=cygstart
    ;;
    msys*)
      alias open=start
    ;;
    win32)  # Will not likely happen
      function open () {
        cmd /c start "${@//&/^&}"
      }
    ;;
    linux-gnu*)
      alias open='xdg-open'
    ;;
  esac

fi
