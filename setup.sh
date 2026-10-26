#!/bin/bash
# i3-style keybindings on top of GNOME defaults

# Fixed workspaces 1-10
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# Free Super+1-9 and Super+Shift+1-9 from app hotkeys
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
for i in $(seq 1 9); do
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

# Super+N switches to workspace N, Super+Shift+N moves the window there (0 = 10)
for i in $(seq 1 10); do
    key=$((i % 10))
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$key']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$key']"
done

# Windows
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4', '<Super><Shift>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"

# Terminal and lock
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t', '<Super>Return']"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>l', '<Super>x']"

# Alt+Super+K toggles left Alt/Super swap
path=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
schema=org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$path
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$path']"
gsettings set "$schema" name 'Alt-Win Key Swap'
gsettings set "$schema" command 'bash -c "if gsettings get org.gnome.desktop.input-sources xkb-options | grep -q swap_lalt_lwin; then gsettings set org.gnome.desktop.input-sources xkb-options \"[]\"; else gsettings set org.gnome.desktop.input-sources xkb-options \"[\\\"altwin:swap_lalt_lwin\\\"]\"; fi"'
gsettings set "$schema" binding '<Alt><Super>k'
