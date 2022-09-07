function _cust-update () {
  local _updpl_curpath=${(%):-%x}
  pushd ${_updpl_curpath:A:h} >/dev/null
  echo "Updading ZSH customizations in $(pwd)"
  local _rv=0
  if git remote &>/dev/null; then
    git stash &>/dev/null
    git pull --verbose --all --tags --rebase
    _rv=$?
    git stash pop &>/dev/null
  else
    _rv=$?
    echo "ZSH customizations are likely not in Git with remotes"
  fi
  popd >/dev/null
  return $_rv
}

function _scoop-update () {
  if which scoop &> /dev/null; then
    scoop update
    for app in $(ls -1 $USERPROFILE/scoop/apps); do
      if [[ scoop != $app ]]; then
        scoop update $app
      fi
    done
  else
    return 1
  fi
}

if [[ -n "${aliases[upgrade]}" ]]; then
  function host-upgrade () {
    upgrade
  }
  # upgrade alias already substituted to function, so...
  unalias upgrade
elif [[ -n "${functions[upgrade]}" ]]; then
  functions[host-upgrade]=${functions[upgrade]}
  unfunction upgrade
else
  case $OSTYPE in
    linux-android*)
      function _host-upgrade () {
        pkg upgrade
      }
    ;;
    darwin*)
      function _host-upgrade () {
        brew upgrade --greedy
      }
    ;;
    cygwin*)
      function _host-upgrade () {
        _scoop-update
        apt-cyg upgrade-self
        apt-cyg dist-upgrade
      }
    ;;
    *) # linux-gnu* and others with upgrade defined
      function _host-upgrade () {
        echo "Use plugin defining some upgrade method before. No host-upgrade supported..."
      }
    ;;
esac
fi

function upgrade () {
  _cust-update
  omz update --unattended
  _host-upgrade
}
