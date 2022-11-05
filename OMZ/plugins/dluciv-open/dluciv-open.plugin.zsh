if ! which open &>/dev/null; then

  case $OSTYPE in
    linux-android*)
      alias open=termux-open
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
      function open () {
        xdg-open "$@" &|
      }
    ;;
  esac

fi
