export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export LAST_DIR="$HOME"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:/home/yushi/.local/share/coursier/bin"
export PATH="/opt/clang-format-static:$PATH"
export EDITOR=/usr/local/bin/nvim
export PATH=$HOME/.ghcup/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH

if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep dwm || startx
fi

awsnotify() {
  aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:663639379546:awsnotify --message "$1"
}
