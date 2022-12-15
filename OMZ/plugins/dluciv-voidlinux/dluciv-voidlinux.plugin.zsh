#######################################
#                XBPS                 #
#######################################

# XBPS - https://docs.voidlinux.org/xbps/index.html

if which xbps-install &>/dev/null; then
  alias upgrade='xbps-install --sync --update'
else
  >&2 echo "Void Linux upgrade plugin cannot be used with on this distribution"
fi
