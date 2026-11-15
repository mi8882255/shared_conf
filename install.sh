#!/usr/bin/env zsh
# Установка shared_conf. Повторный запуск безопасен.
# Существующие файлы не затираются, а переименовываются в *.bak-<дата>.
set -eu

REPO=${0:A:h}
TS=$(date +%Y%m%d-%H%M%S)

link() {  # link <файл в репо> <куда>
  local src=$REPO/$1 dst=$2
  [[ -L $dst && ${dst:A} == ${src:A} ]] && return
  if [[ -e $dst || -L $dst ]]; then
    mv "$dst" "$dst.bak-$TS"
    echo "backup: $dst -> $dst.bak-$TS"
  fi
  ln -s "$src" "$dst"
  echo "link:   $dst -> $src"
}

add_line() {  # add_line <строка> <файл>
  grep -qxF "$1" "$2" 2>/dev/null && return
  printf '\n# shared_conf\n%s\n' "$1" >> "$2"
  echo "added to $2: $1"
}

if [[ $OSTYPE == darwin* ]] && (( $+commands[brew] )); then
  brew install tmux ripgrep fzf
elif (( $+commands[apt-get] )); then
  # vim-gtk3: vim с поддержкой системного буфера; на сервере без X хватит обычного vim
  pkgs=(tmux ripgrep fzf xclip git curl)
  if [[ -n ${DISPLAY:-}${WAYLAND_DISPLAY:-} ]]; then pkgs+=(vim-gtk3); else pkgs+=(vim); fi
  sudo apt-get update -q && sudo apt-get install -y "${pkgs[@]}"
  [[ ${SHELL:t} == zsh ]] || echo "!! zsh не основной шелл. Выполни: chsh -s $(command -v zsh)"
else
  echo "!! Пакетный менеджер не распознан. Поставь вручную: tmux ripgrep fzf xclip vim"
fi
(( $+commands[node] )) || echo "!! node не найден: coc (автодополнение в vim) работать не будет"

# коммиты в этот репозиторий всегда с личной подписью, даже на рабочей машине
git -C "$REPO" config user.name  'Igor Morgunov'
git -C "$REPO" config user.email 'mi8882255@gmail.com'

link .vimrc     ~/.vimrc
link .tmux.conf ~/.tmux.conf
link .inputrc   ~/.inputrc

# Karabiner: раскладки на fn / правый ⌘ / правый ⌥ (пропустить: NO_KARABINER=1 ./install.sh)
if [[ $OSTYPE == darwin* && -z ${NO_KARABINER:-} ]]; then
  [[ -d /Applications/Karabiner-Elements.app ]] || brew install --cask karabiner-elements
  kconf=~/.config/karabiner/karabiner.json
  mkdir -p ${kconf:h}
  [[ -s $kconf ]] || print '{"profiles":[{"name":"Default profile","selected":true}]}' > $kconf
  tmp=$(mktemp)
  jq --slurpfile r "$REPO/karabiner/layouts.json" -f "$REPO/karabiner/merge.jq" $kconf > $tmp
  if cmp -s $tmp $kconf; then
    rm $tmp
  else
    cp $kconf "$kconf.bak-$TS" && mv $tmp $kconf   # Karabiner перечитает файл сам
    echo "karabiner: правила раскладок записаны (backup: $kconf.bak-$TS)"
  fi
  # «Press 🌐 key to» → Do Nothing, fn обрабатывает Karabiner
  defaults write com.apple.HIToolbox AppleFnUsageType -int 0
fi

add_line "source $REPO/zsh/zshrc" ~/.zshrc
# Apple Terminal ведёт отдельную историю для каждой вкладки, это мешает общей истории (SHARE_HISTORY)
[[ $OSTYPE == darwin* ]] && add_line 'SHELL_SESSIONS_DISABLE=1' ~/.zshenv

# tmux plugins
[[ -d ~/.tmux/plugins/tpm ]] || git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# vim plugins (vim-plug ставится из .vimrc сам)
vim -Es -i NONE --cmd 'let g:coc_start_at_startup = 0' -u ~/.vimrc +'PlugInstall --sync' +qa || true

echo "done. Открой новый терминал или: exec zsh"
