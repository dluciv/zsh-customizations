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
      omz_plug_upgrade_v=${aliases[upgrade]}
      unalias upgrade
    elif [[ -n "${functions[upgrade]}" ]]; then
      omz_plug_upgrade_v=${functions[upgrade]}
      unfunction upgrade
    else
      echo "Use plugin defining some upgrade method before"
      omz_plug_upgrade_v='echo No idea how to perform global upgrade'
    fi

    function upgrade () {
      eval $omz_plug_upgrade_v
      omz update
    }
  ;;
esac
