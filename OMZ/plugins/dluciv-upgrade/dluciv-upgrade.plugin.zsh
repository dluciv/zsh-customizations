case $OSTYPE in
  linux-android*)
    function upgrade () {
      pkg upgrade
      omz update
    }
  ;;
  darwin*)
    function upgrade () {
      brew upgrade --greedy
      omz update
    }
  ;;
  cygwin)
    function upgrade () {
      apt-cyg upgrade-self
      apt-cyg dist-upgrade
    }
  ;;
  *) # linux-gnu* and others with upgrade defined
    if [[ -n "${aliases[upgrade]}" ]]; then
      alias omz_plug_upgrade=${aliases[upgrade]}
      unalias upgrade
    elif [[ -n "${functions[upgrade]}" ]]; then
      functions[omz_plug_upgrade]=${functions[upgrade]}
      unfunction upgrade
    else
      echo "Use plugin defining some upgrade method before"
      alias omz_plug_upgrade='echo No idea how to perform global upgrade'
    fi

    function upgrade () {
      omz_plug_upgrade
      omz update
    }
  ;;
esac
