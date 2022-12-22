
# CLEANUP:
[ -f ~/.config/zsh/zenvironment ] && source ~/.config/zsh/zenvironment
#if [[ ! $DISPLAY && $XDG_VTNR -le 2]] then


if [[ "$(tty)" = "/dev/tty1" ]] then
	pgrep dwm || startx
    xrdb ~/.Xresources
	exec startx "$XINITRC" vt1
fi

