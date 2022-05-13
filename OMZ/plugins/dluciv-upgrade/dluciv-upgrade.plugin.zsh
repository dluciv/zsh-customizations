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
      function _dluciv_upgrade () {
        upgrade
        omz update
      }
      # upgrade alias already substituted to function, so...
      unalias upgrade
      functions[upgrade]=$functions[_dluciv_upgrade]
      unfunction _dluciv_upgrade
    elif [[ -n "${functions[upgrade]}" ]]; then
      functions[_omz_plug_upgrade]=${functions[upgrade]}
      function upgrade () {
        _omz_plug_upgrade
        omz update
      }
    else
      echo "Use plugin defining some upgrade method before. Only upgrading OMZ..."
      function upgrade () {
        omz update
      }
    fi
  ;;
esac
