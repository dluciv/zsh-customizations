if [[ $OSTYPE == cygwin* ]]; then

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

  function upgrade () {
    _scoop-update
    apt-cyg upgrade-self
    apt-cyg dist-upgrade
  }

else
  >&2 echo "Cygwin upgrade plugin cannot be used with '$OSTYPE' OS"
fi
