case $OSTYPE in
  linux-gnu*)
  ;;
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
esac

