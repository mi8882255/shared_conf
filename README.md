# shared_conf

dotfiles


usage:

install tmux vim git

clone to ~/shared_conf

install vimplug:
https://github.com/junegunn/vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
make symlinks for .vim .tmux.conf

```
mkdir .vim/swapfiles
ln -s ~/shared_conf/.vimrc ./
ln -s ~/shared_conf/.tmux.conf ./
```

add
 
. .shared_conf/.bash_profile 
to ~/.bashrc or ~/.bash_profile

```
echo '\n. ~/shared_conf/.bashrc' >> ~/.bashrc 
```
