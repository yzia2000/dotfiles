export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export EDITOR=/usr/bin/nvim

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep dwm || startx
fi
