cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd)

ln -s $DOTFILES_ROOT/zshrc ~/.zshrc
ln -s $DOTFILES_ROOT/ackrc ~/.ackrc
ln -s $DOTFILES_ROOT/vimrc ~/.vimrc
ln -s $DOTFILES_ROOT/gvimrc ~/.gvimrc
