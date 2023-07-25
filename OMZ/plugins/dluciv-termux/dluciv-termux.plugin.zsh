if [[ $OSTYPE == linux-android* ]]; then
  upgrade() {
    pkg upgrade
    apt autoclean
    apt autoremove
  }
else
  >&2 echo "Termux upgrade plugin cannot be used with '$OSTYPE' OS"
fi
