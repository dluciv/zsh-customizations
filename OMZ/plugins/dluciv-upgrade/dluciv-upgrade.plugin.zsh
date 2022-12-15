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
  function _host-upgrade () {
    upgrade
  }
  # upgrade alias already substituted to function, so...
  unalias upgrade
elif [[ -n "${functions[upgrade]}" ]]; then
  functions[_host-upgrade]=${functions[upgrade]}
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
    *) # linux-gnu* and others with upgrade defined
      function _host-upgrade () {
        >&2 echo "Use plugin defining some upgrade method before. No host-upgrade supported..."
      }
    ;;
esac
fi

function _timeout-yay () {
  if [[ -n $2 ]]; then
    timeout --preserve-status --foreground $2 yay -S --noconfirm $1
  else
    yay -S --noconfirm $1
  fi
}

function _upyay_greedy () {
  # https://github.com/Jguer/yay/issues/848#issuecomment-1068952668
  TIMEOUT=$1
  echo '== Sudo... =='
  # Just to ask it beforehands
  sudo true
  echo "== Upgrading AUR packages optimistically, t/o: ($TIMEOUT) =="
  yay -Quq --aur | while read pkg; do
    _timeout-yay $pkg $TIMEOUT
  done
  sleep 5
  echo '========== AUR packages failed to upgrade ==========='
  yay -Quq --aur
  echo '====================================================='
}

if [[ -f /etc/arch-release ]] && which yay &>/dev/null; then
  # Arch Linux with yay
  alias upgrade-src-greedy=_upyay_greedy
else
  function upgrade-src-greedy() {
    >&2 echo "Do not know how to upgrade src packages greedy on you host..."
  }
fi

function upgrade () {
  _cust-update
  omz update --unattended
  _host-upgrade
}
