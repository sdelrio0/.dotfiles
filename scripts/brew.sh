#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Init taps
brew tap homebrew/bundle
brew tap caskroom/fonts
brew tap puma/puma
brew tap shopify/shopify
brew tap caskroom/fonts
brew tap dbcli/tap

# Install GNU core utilities (those that come with OS X are outdated).
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
LINE='export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin"'
grep -q "$LINE" ~/.init || echo "$LINE" >> ~/.init

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install zsh
brew install zsh
# Prompts for password
# echo "Adding the newly installed shell to the list of allowed shells"
# sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
# # Change to the new shell, prompts for password
# chsh -s /bin/zsh

# Install `wget` with IRI support.
brew install wget --with-iri

# Install Python
brew install python
brew install python3

# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.init || echo "$LINE" >> ~/.init

# Install nvm and node
brew install nvm
mkdir ~/.nvm
nvm install node
nvm install --lts
nvm use node
nvm run node --version
LINE='export NVM_DIR="$HOME/.nvm" && source "$(brew --prefix nvm)/nvm.sh && nvm use"'
grep -q "$LINE" ~/.init || echo "$LINE" >> ~/.init

# Install Java
brew cask install --appdir="/Applications" java

# DEV Fonts
brew cask install font-firacode-nerd-font-mono

# VIM
brew install vim --override-system-vi \
  && cp -r dotfiles/.vim ~/.vim \
  && [ ! -d ~/.vim/bundle/Vundle.vim ] \
  && git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim \
  && vim +PluginInstall +qall \
  && ~/.vim/bundle/YouCompleteMe/install.py

brew install tmux

# Install other useful binaries.
brew install the_silver_searcher
brew install ack
brew install git
brew install imagemagick --with-webp
brew install rename
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install ag
brew install unrar
brew install yarn
brew install tmux
brew install fzf && /usr/local/opt/fzf/install # shell integration Ctrl-T, Ctrl-R, Alt-C
brew install reattach-to-user-namespace
brew install ctags
brew install readline
brew install hivemind
brew install overmind
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install cmake
brew install pgcli
brew install hexcurse # hex editor
brew install openssl

# z for fuzzy find
brew install z
LINE='. /usr/local/etc/profile.d/z.sh'
grep -q "$LINE" ~/.init || echo "$LINE" >> ~/.init


# Install font tools.
# brew tap bramstein/webfonttools
# brew install sfnt2woff
# brew install sfnt2woff-zopfli
# brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install homebrew/x11/xpdf
brew install xz

#brew install dark-mode
#brew install exiv2
#brew install git-lfs
#brew install git-flow
#brew install git-extras
#brew install hub
#brew install lua
#brew install lynx
#brew install p7zip
#brew install pigz
#brew install pv
#brew install rhino
#brew install webkit2png
#brew install zopfli
#brew install pkg-config libffi
#brew install pandoc

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Install Heroku
brew install heroku-toolbelt
heroku update

# === CASKS ===

# Core casks
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="/Applications" iterm2
brew cask install --appdir="/Applications" xquartz

# Misc casks
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
#brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" 1password
#brew cask install --appdir="/Applications" gimp
#brew cask install --appdir="/Applications" inkscape
brew cask install --appdir="/Applications" spotify

#Remove comment to install LaTeX distribution MacTeX
#brew cask install --appdir="/Applications" mactex

brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" ngrok
brew cask install --appdir="/Applications" rescuetime
brew cask install --appdir="/Applications" postman
brew cask install --appdir="/Applications" bettertouchtool
# brew cask install --appdir="/Applications" rubymine
# brew cask install --appdir="/Applications" webstorm
brew cask install --appdir="/Applications" sketch
brew cask install --appdir="/Applications" macdown
brew cask install --appdir="/Applications" licecap
brew cask install --appdir="/Applications" google-backup-and-sync
brew cask install --appdir="/Applications" graphiql
brew cask install --appdir="/Applications" smcfancontrol
brew cask install --appdir="/Applications" skitch
brew cask install --appdir="/Applications" synergy
brew cask install --appdir="/Applications" telegram
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" jitouch

 # Install Docker, which requires virtualbox
brew install docker
brew install boot2docker

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
#brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Remove outdated versions from the cellar.
brew cleanup
