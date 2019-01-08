WSL VIM CONFIG
-------------------------

Jealous of Mac and Linux users flaunting their beautiful vim configs and unable to replicate them on
WSL Ubuntu? Checkout my .vimrc file for a customized VIM fit for programming, editing files
and much more!

Use the .tmux.conf for mouse support

Recommend Terminal Emulator: [wsltty](https://github.com/mintty/wsltty)

![alt text](https://github.com/yzia2000/dotfiles/blob/master/WSL_m.jpg)


FULL SETUP INSTRUCTIONS

First of all:
```
sudo apt-get update
sudo apt-get upgrade
```

Setting up essential development tools:
```
sudo apt-get install build-essential cmake
```

Python Setup:
```
sudo apt-get install python-dev python3-dev
```

Nodejs setup:
```
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt install nodejs
```

Typescript setup:
```
sudo npm install -g typescript
```

Remove old vim:
```
sudo apt-get remove vim vim-runtime gvim
sudo apt-get remove vim-tiny vim-common vim-gui-common vim-nox
```

Dependencies for Vim and Ruby:
```
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion
```

Update these packages:
```
sudo apt-get update
sudo apt-get upgrade
```

Install Ruby:
```
sudo apt install ruby-full
```

Install latest vim:
```
cd ~
git clone https://github.com/vim/vim.git
cd vim

./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
sudo make
sudo make install
```



Setting up Vundle plugin manager (this adds those additional features):
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Next copy my config:
```
git clone https://github.com/yzia2000/dotfiles.git
cd dotfiles
cp .vimrc ~
cp .bashrc ~
cp .tmux.conf ~
```

Next open vim:
```
:PluginInstall
```
(this can take some time)

Installing clang:
```
sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7  main"
sudo apt-get update
sudo apt-get install clang-7  lldb
```

Next setup YCM autocomplete:
```
cd ~/.vim/bundle/YouCompleteMe 
./install.py --clang-completer --tern-completer
```

Add default compiler flags for YCM to work:
```
cd ~/.vim/bundle/YouCompleteMe 
wget https://raw.githubusercontent.com/JDevlieghere/dotfiles/master/.vim/.ycm_extra_conf.py
```

Install these download these fonts on Windows (just download files from browser and click on them to follow install instructions):
https://github.com/haasosaurus/nerd-fonts/tree/regen-mono-font-fix/patched-fonts/DejaVuSansMono/Regular/complete
(Download all fonts from this link. It gives you the cool status line) 

Install WSLtty (best terminal emulator):
https://github.com/mintty/wsltty/releases/download/1.9.5/wsltty-1.9.5-install.exe
(You have to allow windows defender to install the file)

Changing WSLtty settings:
Open file on windows:
Press Windows + R
Type:
```
%appdata%\wsltty\config
```

```
Replace the contents of the file with this:
Font=DejaVuSansMono Nerd Font Mono
Term=xterm-256color
Transparency=low
CursorType=underscore
BackgroundColour=13,25,38
ForegroundColour=217,230,242
CursorColour=217,230,242
CtrlShiftShortcuts=yes
```


Lastly, configuring tmux:
Run tmux in wsl:
```
tmux
```
Press Ctrl-b
Type: 
```
:source-file ~/.tmux.conf
```

Then run the following shortcut: ` + I
