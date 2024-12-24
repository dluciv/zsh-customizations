function _scoop-update () {
  # Could not get Windows 11 sudo to wait for finish,
  # used this tool https://github.com/gerardog/gsudo then.
  if which gsudo.exe &> /dev/null; then
    gsudo.exe 'scoop update & scoop update * & scoop cleanup -k *'
  else
    scoop update
    scoop update '*'
    scoop cleanup -k '*'
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
