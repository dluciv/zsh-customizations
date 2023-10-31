if [[ $OSTYPE == msys* ]]; then

  function upgrade () {
    pacman -Syyu
    echo -e 'y\ny' | /usr/bin/pacman -Scc
  }

else
  >&2 echo "MSYS upgrade plugin cannot be used with '$OSTYPE' OS"
fi
