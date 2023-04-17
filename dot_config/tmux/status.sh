#!/bin/bash
set -e
# status_right=`tmux show-options -gv status-right | sed \
#     -e 's/brightcyan/cyan/g' \                          # prefix-hightlight の色変更
#     -e 's/#\[fg=brightblack,bg=black.* %H:%M //g' \     # 時計を除去
#     -e 's/fg=cyan,bg=brightblack/fg=blue,bg=black/g' \  # ホスト名の色変更（矢羽）
#     -e 's/fg=black,bg=cyan/fg=black,bg=blue/g' \        # ホスト名の色変更（本体）
#     -e 's/ #H / #h /g' \                                # ホスト名からドメイン部分を除く
#     `

status_right=`tmux show-options -gv status-right | sed -e 's/brightcyan/cyan/g' -e 's/#\[fg=brightblack,bg=black.* %H:%M //g' -e 's/fg=cyan,bg=brightblack/fg=blue,bg=black/g' -e 's/fg=black,bg=cyan/fg=black,bg=blue/g' -e 's/ #H / #h /g'`
tmux set-option -g status-right "$status_right"
