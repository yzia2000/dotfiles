install:
	git clone --bare git@github.com:yzia2000/dotfiles.git $HOME/.cfg
	alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
	config config --local status.showUntrackedFiles no
	config checkout -f
