Linux Dotfiles
---------------

# Submodules
## Suckless
1. dwm
2. dsblocks
3. st
4. slock
5. dmenu
6. slstatus
7. sxiv

# Configs
1. dunst
2. neovim
3. polybar
4. bspwm
5. ranger
6. alacritty
7. sxhkd
8. zathura

# Installation (credits [Atlassian Blog](https://www.atlassian.com/git/tutorials/dotfiles))
1. Add alias for bare repo config
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
2. Clone repo
```
git clone --bare git@github.com:yzia2000/dotfiles.git $HOME/.cfg
```
3. Ignore untracked files
```
config config --local status.showUntrackedFiles no
```
3. Checkout files
```
config checkout -f
```
