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
    >&2 echo "ZSH customizations are likely not in Git with remotes"
  fi
  popd >/dev/null
  return $_rv
}

if [[ -n "${aliases[upgrade]}" ]]; then
  function _host-upgrade () {
    upgrade
  }
  # upgrade alias already substituted to function, so...
  unalias upgrade
elif [[ -n "${functions[upgrade]}" ]]; then
  functions[_host-upgrade]=${functions[upgrade]}
  unfunction upgrade
else
  function _host-upgrade () {
    >&2 echo "Use plugin defining some upgrade method before. No host-upgrade supported..."
  }
fi

function _omz-update () {
  if ( cd $ZSH; git status &>/dev/null ); then
    omz update --unattended
  else
    echo "OMZ is installed to $ZSH, to be updated by system"
  fi
}

function upgrade () {
  _cust-update
  _omz-update
  _host-upgrade
}
