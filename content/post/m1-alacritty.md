---
title: Alacritty on M1 Mac
date: 2021-07-29T21:42:44+09:00
categories:
- Mac
- 環境構築
tags:
- Mac
- 環境構築
- M1
- Alacritty
- 端末エミュレータ
thumbnailImage: /images/m1-alacritty/icon.jpg
summary: Alacritty on M1 Mac

---
[alacritty/alacritty: A cross-platform, OpenGL terminal emulator.](https://github.com/alacritty/alacritty)
Alacrittyを使い始めた。YAMLで設定ファイルを管理できるのと動作が軽いのが好ましいのだけどいくつか問題点が。
- 日本語入力に難アリ
- tmuxのプレフィックスキー(C-Spaceに設定している)が反応しない時がある。(端末を再度立ち上げれば使用できるようになる)

まだM1用の公式ビルドがないので自前でビルドした。それが原因なのかも。  
参考までにAlacrittyとtmuxの設定ファイルを

- alacritty.yml
```yaml
background_opacity: 0.9

key_bindings:
  - { key: Key0, mods: Command, action: ResetFontSize }
  - { key: Plus, mods: Command|Shift, action: IncreaseFontSize }
  - { key: Minus, mods: Command|Shift, action: DecreaseFontSize }
  - { key: 36, mods: Command, action: ToggleSimpleFullscreen }


import:
  - ~/.config/alacritty/themes/substrata.yml

font:
  normal:
    family: "MesloLGS NF"
    style: Regular
  bold:
    family: "MesloLGS NF"
    style: Bold
  italic:
    family: "Meslo LG S for Powerline"
    style: Italic
  size: 14.5
  offset:
      y: 1
      x: 1


window:
  decolations: buttonless 
  dimensions:
    columns: 105
    lines: 45
  padding:
    x: 8
    y: 4
```
- .tmux.conf
```conf
set-option -g default-shell /opt/homebrew/bin/fish

set-option -g default-terminal screen-256color
set -ga terminal-overrides ",alacritty:Tc"

unbind C-b
set -g prefix C-Space

set -s escape-time 0
set-option -g status-position top

set-option -g status-left-length 90
set-option -g status-right-length 90

set-option -g status-left '#H:[#P]'

set-option -g status-right '#(wifi) #(battery --tmux) [%Y-%m-%d(%a) %H:%M]'
set-option -g status-interval 1
set-option -g status-justify centre
set-option -g status-bg "colour28"

set-option -g status-fg "colour255"

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

bind | split-window -h

bind - split-window -v

set-option -g base-index 1

set-option -g mouse on
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"

setw -g mode-keys vi

bind -T copy-mode-vi v send -X begin-selection

bind -T copy-mode-vi V send -X select-line

bind -T copy-mode-vi C-v send -X rectangle-toggle

bind -T copy-mode-vi y send -X copy-selection

bind -T copy-mode-vi Y send -X copy-line

```




<!--more-->
