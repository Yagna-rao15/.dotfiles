# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]: then
#   startx
# fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

