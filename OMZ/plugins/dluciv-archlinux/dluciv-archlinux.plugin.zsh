#######################################
#           More upgrades             #
#######################################

if [[ -f /etc/arch-release ]] && which yay &>/dev/null; then
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

  alias upgrade-src-greedy=_upyay_greedy

else
  >&2 echo "Arch Linux upgrade plugin cannot be used with on this distribution"
fi
