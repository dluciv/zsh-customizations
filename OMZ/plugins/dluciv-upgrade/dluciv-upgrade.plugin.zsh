function _upd_dzcust () {
  local _updpl_curpath=${(%):-%x}
  pushd ${_updpl_curpath:A:h} >/dev/null
  echo "Updading ZSH customizations in $(pwd)"
  local _rv=0
  if git remote &>/dev/null; then
    git stash &>/dev/null
    git pull
    _rv=$?
    git stash pop &>/dev/null
  else
    _rv=$?
    echo "ZSH customizations are likely not in Git with remotes"
  fi
  popd >/dev/null
  return $_rv
}

case $OSTYPE in
  linux-android*)
    function upgrade () {
      pkg upgrade
      _upd_dzcust
      omz update
    }
  ;;
  darwin*)
    function upgrade () {
      brew upgrade --greedy
      _upd_dzcust
      omz update
    }
  ;;
  cygwin)
    function upgrade () {
      apt-cyg upgrade-self
      apt-cyg dist-upgrade
      _upd_dzcust
      omz update
    }
  ;;
  *) # linux-gnu* and others with upgrade defined
    if [[ -n "${aliases[upgrade]}" ]]; then
      function _dluciv_upgrade () {
        upgrade
        _upd_dzcust
        omz update
      }
      # upgrade alias already substituted to function, so...
      unalias upgrade
      functions[upgrade]=$functions[_dluciv_upgrade]
      unfunction _dluciv_upgrade
    elif [[ -n "${functions[upgrade]}" ]]; then
      functions[_omz_plug_upgrade]=${functions[upgrade]}
      function upgrade () {
        _omz_plug_upgrade
        _upd_dzcust
        omz update
      }
    else
      echo "Use plugin defining some upgrade method before. Only upgrading OMZ and customizations..."
      function upgrade () {
        _upd_dzcust
        omz update
      }
    fi
  ;;
esac
