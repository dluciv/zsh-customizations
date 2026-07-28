if ! command -v open &>/dev/null; then

  case "$OSTYPE" in
    linux-android*)
      function __open_one () { termux-open "$1"; }
    ;;
    cygwin*)
      function __open_one () { cygstart "$1"; }
    ;;
    msys*)
      function __open_one () { start "$1"; }
    ;;
    win32)
      function __open_one () { cmd /c start "${1//&/^&}"; }
    ;;
    linux-gnu*)
      function __open_one () { xdg-open "$1" >/dev/null 2>&1 &|; }
    ;;
    *)
      function __open_one () { echo "OS not supported, canot open <<$1>>"; return 1; }
    ;;
  esac

  function open () {
    local rpf
    for a in "$@"; do

      if [[ "$a" =~ ^[a-z]+:// ]]; then
        __open_one "$a"
      else
        rpf=$(realpath "$a" 2>/dev/null) || rpf="$a"
        __open_one "$rpf"
      fi
    done
  }

fi
