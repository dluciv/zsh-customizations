if [[ $OSTYPE == linux-android* ]]; then
  alias upgrade='pkg upgrade'
else
  >&2 echo "Termux upgrade plugin cannot be used with '$OSTYPE' OS"
fi
