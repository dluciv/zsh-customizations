function cust-update () {
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
      function host-upgrade () {
        pkg upgrade
      }
    ;;
    darwin*)
      function host-upgrade () {
        brew upgrade --greedy
      }
    ;;
    cygwin)
      function host-upgrade () {
        apt-cyg upgrade-self
        apt-cyg dist-upgrade
      }
    ;;
    *) # linux-gnu* and others with upgrade defined
      function host-upgrade () {
        echo "Use plugin defining some upgrade method before. No host-upgrade supported..."
      }
    ;;
esac
fi

function upgrade () {
  cust-update
  omz update --unattended
  host-upgrade
}
