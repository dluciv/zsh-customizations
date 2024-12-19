function _scoop-update () {
  scoop update
  scoop update '*'
  scoop cleanup -k '*'

  if false; then
    if which sudo.exe &> /dev/null; then
      sudo --inline scoop update
      sudo --inline scoop update '*'
      sudo --inline scoop cleanup -k '*'
    fi
  fi
}

function _windows-pms-upgrade () {
  local pms=()

  if which scoop &> /dev/null; then
    pms+=( scoop )
    _scoop-update
  fi

  if which choco &> /dev/null; then
    pms+=( choco )
    >&2 echo "Choco upgrade not yet implemented"
  fi
  
  if [ ${#pms[@]} -eq 0 ]; then
    echo "No Windows package managers installed"
  fi
}
