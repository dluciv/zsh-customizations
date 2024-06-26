if [[ $OSTYPE == cygwin* ]]; then

  function upgrade () {
    if which _windows-pms-upgrade &> /dev/null; then
      echo "Upgrading Windows package managers"
      _windows-pms-upgrade
    fi
    apt-cyg -X upgrade-self
    apt-cyg -X dist-upgrade
  }

else
  >&2 echo "Cygwin upgrade plugin cannot be used with '$OSTYPE' OS"
fi
