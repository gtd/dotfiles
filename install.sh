# Initial setup:
#
# - Install Mac OS Command Line Tools
# - Install Homebrew

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd)

ln -sv $DOTFILES_ROOT/zshrc ~/.zshrc
ln -sv $DOTFILES_ROOT/ackrc ~/.ackrc
ln -sv $DOTFILES_ROOT/vimrc ~/.vimrc
ln -sv $DOTFILES_ROOT/gvimrc ~/.gvimrc
ln -sv $DOTFILES_ROOT/gitconfig ~/.gitconfig
ln -sv $DOTFILES_ROOT/gitignore_global ~/.gitignore_global

mkdir -p ~/.config/nvim
ln -sv $DOTFILES_ROOT/nvim/init.vim ~/.config/init.vim

mkdir -p ~/.vim/autoload
ln -sv $DOTFILES_ROOT/plug.vim ~/.vim/autoload/plug.vim

array=( macvim rbenv ruby-build ack )
for i in "${array[@]}"
do
  if brew ls --versions $i > /dev/null; then
    echo "Already installed $i"
  else
    echo "Installing $i"
    brew install $i
  fi
done
