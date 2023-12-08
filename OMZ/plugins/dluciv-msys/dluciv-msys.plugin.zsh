if [[ $OSTYPE == msys* ]]; then

  function upgrade () {
    pacman -Syyu
    echo -e 'y\ny' | /usr/bin/pacman -Scc
    if which _windows-pms-upgrade &> /dev/null; then
      echo "Upgrading Windows package managers"
      _windows-pms-upgrade
    fi
  }

else
  >&2 echo "MSYS upgrade plugin cannot be used with '$OSTYPE' OS"
fi
