cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s $DOTFILES_ROOT/zshrc ~/.zshrc
ln -s $DOTFILES_ROOT/ackrc ~/.ackrc
ln -s $DOTFILES_ROOT/vimrc ~/.vimrc
ln -s $DOTFILES_ROOT/gvimrc ~/.gvimrc
ln -s $DOTFILES_ROOT/gitconfig ~/.gitconfig
