if [[ $OSTYPE == linux-gnu && $(lsb_release --id --short | tail -n1) == Ubuntu ]]; then
  upgrade() {
    apt upgrade
    apt autoclean
    apt autoremove
  }
else
  >&2 echo "Ubuntu upgrade plugin cannot be used with '$OSTYPE' OS"
fi
