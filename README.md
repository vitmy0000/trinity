# trinity

```bash
cd ~
git clone git@github.com:vitmy0000/trinity.git
git clone git@github.com:vitmy0000/iCheat.git
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
echo 'export SHELL=$(which zsh)' >> ~/.bashrc
echo '[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l' >> ~/.bashrc
ln -s trinity/tmux.conf ~/.tmux.conf
ln -s trinity/gitconfig ~/.gitconfig
ln -s trinity/vimrc ~/.vimrc
ln -s trinity/zshrc ~/.zshrc
```
