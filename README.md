# shared_conf

dotfiles: zsh, vim, tmux.

## Установка

```sh
git clone git@github.com:mi8882255/shared_conf.git ~/shared_conf
~/shared_conf/install.sh
```

Нужен zsh (на Linux сначала `sudo apt install zsh`). Скрипт:
- ставит `tmux ripgrep fzf` через brew (macOS) или apt (Debian/Ubuntu, плюс xclip и vim);
- прописывает в репо личные user.name/email, чтобы не закоммитить сюда с рабочего адреса;
- делает симлинки `~/.vimrc`, `~/.tmux.conf`, `~/.inputrc` (старые файлы переименовывает в `*.bak-<дата>`);
- добавляет `source ~/shared_conf/zsh/zshrc` в `~/.zshrc`;
- ставит плагины tmux (tpm) и vim (vim-plug, coc: нужен node).

## Что внутри

**zsh** (`zsh/zshrc`):
- промпт `user@host dir (branch) $`;
- общая история между вкладками;
- ↑/↓ ищут по истории по набранному началу команды;
- fzf: Ctrl-R история, Ctrl-T файлы.

| команда | что делает |
|---|---|
| `gpush` | `git push -u origin HEAD` |
| `gpull` | `git pull --rebase --autostash` |
| `gcommit msg...` | `git commit -am`, предупреждает о console.log |
| `gco_clean <branch>` | fetch + полная очистка + switch + reset на origin |
| `gsub_clean` | сброс всех сабмодулей на origin/HEAD |
| `g_what2push` | коммиты и файлы, которые ещё не запушены |
| `g_notreleased [dev] [master]` | коммиты, которые есть только в одной из веток |
| `g_uncommit` | отменить последний коммит, оставив изменения |
| `g_reset_orig` | reset --hard на upstream |
| `ta` / `mosht host` | tmux-сессия main локально / через mosh |

**tmux**:
- prefix F10;
- hjkl для переключения панелей;
- vi copy-mode, `y` копирует в системный буфер (pbcopy/xclip/OSC52);
- `prefix C-p` вставляет из системного буфера.

**vim**:
- `C-n` NERDTree;
- `C-p` поиск файлов (fzf);
- `,a` поиск по содержимому (ripgrep);
- `,f` easymotion;
- coc: `gd`/`gr`/`K`/`,rn`/`,p` (prettier).

Старые bash-файлы (`.bash_profile`, `git_helpers/`) оставлены для серверов с bash.
