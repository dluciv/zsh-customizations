function _scoop-update () {
  scoop update
  if true; then
    scoop update -a -f
  else
    # older
    for app in $(ls -1 $USERPROFILE/scoop/apps); do
      if [[ scoop != $app ]]; then
        scoop update $app
      fi
    done
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
