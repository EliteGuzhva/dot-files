#!/usr/bin/env bash

# @brief Herbstluftwm config
# @author EliteGuzhva

# Utils
hc() {
    herbstclient "$@"
}

hc emit_hook reload

# set background
feh --bg-scale --randomize /home/nikita/git_projects/wallpapers/*

# set compton for opacity
# compton -f &
compton --config /home/nikita/.config/compton/compton.conf &

# remove all existing keybindings
hc keyunbind --all

# keybindings
Mod=Mod1    # Use alt as the main modifier

# custom key bindings
hc keybind Mod4-n spawn nautilus
hc keybind Mod4-f spawn brave-browser
hc keybind Mod4-s spawn skype
hc keybind Mod4-t spawn telegram-desktop
hc keybind Mod4-m spawn spotify
hc keybind Mod4-i spawn clion
hc keybind Mod4-c spawn code

hc keybind Mod4-1 spawn ibus engine xkb:us::eng
hc keybind Mod4-2 spawn ibus engine xkb:ru::rus
hc keybind Mod4-3 spawn ibus engine libpinyin

hc keybind $Mod-Print spawn scrot -s -e 'mv $f ~/Pictures/Screenshots/'

hc keybind $Mod-Shift-Return spawn ~/.config/rofi/bin/launcher_colorful

hc keybind $Mod-Shift-b spawn feh --bg-scale --randomize /home/nikita/git_projects/wallpapers/*

hc keybind XF86AudioMute spawn amixer -D pulse -q sset Master toggle
hc keybind XF86AudioLowerVolume spawn amixer -D pulse -q sset Master 5%- unmute
hc keybind XF86AudioRaiseVolume spawn amixer -D pulse -q sset Master 5%+ unmute

hc keybind $Mod-F10 spawn amixer -D pulse -q sset Master toggle
hc keybind $Mod-F11 spawn amixer -D pulse -q sset Master 5%- unmute
hc keybind $Mod-F12 spawn amixer -D pulse -q sset Master 5%+ unmute
# to set balance: amixer -D pulse set Master 45%,55%

hc keybind $Mod-F8 spawn playerctl --player=playerctld play-pause
hc keybind $Mod-F7 spawn playerctl --player=playerctld previous
hc keybind $Mod-F9 spawn playerctl --player=playerctld next

hc keybind $Mod-Shift-q quit
hc keybind $Mod-Shift-r reload
hc keybind $Mod-q close
hc keybind $Mod-Return spawn alacritty

# basic movement
# focusing clients
hc keybind $Mod-Left  focus left
hc keybind $Mod-Down  focus down
hc keybind $Mod-Up    focus up
hc keybind $Mod-Right focus right
hc keybind $Mod-h     focus left
hc keybind $Mod-j     focus down
hc keybind $Mod-k     focus up
hc keybind $Mod-l     focus right

# moving clients
hc keybind $Mod-Shift-Left  shift left
hc keybind $Mod-Shift-Down  shift down
hc keybind $Mod-Shift-Up    shift up
hc keybind $Mod-Shift-Right shift right
hc keybind $Mod-Shift-h     shift left
hc keybind $Mod-Shift-j     shift down
hc keybind $Mod-Shift-k     shift up
hc keybind $Mod-Shift-l     shift right

# splitting frames
# create an empty frame at the specified direction
hc keybind $Mod-u       split   bottom  0.5
hc keybind $Mod-o       split   right   0.5
# let the current frame explode into subframes
hc keybind $Mod-Control-space split explode

# resizing frames
resizestep=0.05
hc keybind $Mod-Control-h       resize left +$resizestep
hc keybind $Mod-Control-j       resize down +$resizestep
hc keybind $Mod-Control-k       resize up +$resizestep
hc keybind $Mod-Control-l       resize right +$resizestep
hc keybind $Mod-Control-Left    resize left +$resizestep
hc keybind $Mod-Control-Down    resize down +$resizestep
hc keybind $Mod-Control-Up      resize up +$resizestep
hc keybind $Mod-Control-Right   resize right +$resizestep

# tags
tag_names=("Net" "Terminal" "Social" "Notes" "Music" "Free")
new_tag_names=("Net" "Terminal" "Social" "Notes" "Music" "Free")
tag_keys=( {1..6} 0 )

hc rename default "${tag_names[0]}" || true
for i in ${!tag_names[@]} ; do
    # hc merge_tag "${tag_names[$i]}"
    hc add "${new_tag_names[$i]}"
    key="${tag_keys[$i]}"
    if ! [ -z "$key" ] ; then
        hc keybind "$Mod-$key" use_index "$i"
        hc keybind "$Mod-Shift-$key" move_index "$i"
    fi
done

# cycle through tags
hc keybind $Mod-period use_index +1 --skip-visible
hc keybind $Mod-comma  use_index -1 --skip-visible

# layouting
hc keybind $Mod-r remove
hc keybind $Mod-f fullscreen toggle
hc keybind $Mod-p pseudotile toggle
hc keybind $Mod-Shift-f attr clients.focus.floating toggle

# The following cycles through the available layouts within a frame, but skips
# layouts, if the layout change wouldn't affect the actual window positions.
# I.e. if there are two windows within a frame, the grid layout is skipped.
hc keybind $Mod-space                                                           \
            or , and . compare tags.focus.curframe_wcount = 2                   \
                     . cycle_layout +1 vertical horizontal max vertical grid    \
               , cycle_layout +1

# mouse
hc mouseunbind --all
hc mousebind $Mod-Button1 move
hc mousebind $Mod-Button2 zoom
hc mousebind $Mod-Button3 resize

# focus
hc keybind $Mod-BackSpace   cycle_monitor
hc keybind $Mod-Tab         cycle_all +1
hc keybind $Mod-Shift-Tab   cycle_all -1
hc keybind $Mod-c cycle
hc keybind $Mod-i jumpto urgent

# theme
hc attr theme.tiling.reset 1
hc attr theme.floating.reset 1
hc set frame_border_active_color '#61afef'
hc set frame_border_normal_color '#282c34'
hc set frame_bg_normal_color '#565656'
hc set frame_bg_active_color '#345F0C'
hc set frame_border_width 0
hc set always_show_frame 0
hc set frame_bg_transparent 1
hc set frame_transparent_width 0
hc set frame_gap 0

hc attr theme.active.color '#61afef' # '#9fbc00'
hc attr theme.normal.color '#282c34'
hc attr theme.urgent.color '#e86671'
hc attr theme.inner_width 0
hc attr theme.inner_color black
hc attr theme.border_width 2
hc attr theme.floating.border_width 0
hc attr theme.floating.outer_width 0
hc attr theme.floating.outer_color black
hc attr theme.active.inner_color '#3E4A00'
hc attr theme.active.outer_color '#3E4A00'
hc attr theme.background_color '#141414'

hc set window_gap 10
hc set frame_padding 0
hc set smart_window_surroundings 0
hc set smart_frame_surroundings 1
hc set mouse_recenter_gap 0

# rules
hc unrule -F
#hc rule class=XTerm tag=3 # move all xterms to tag 3
hc rule focus=on # normally focus new clients
#hc rule focus=off # normally do not focus new clients
# give focus to most common terminals
#hc rule class~'(.*[Rr]xvt.*|.*[Tt]erm|Konsole)' focus=on
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on
hc rule windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off

# unlock, just to be sure
hc unlock

herbstclient set tree_style '╾│ ├└╼─┐'

# multi monitor setup:
# hc set_monitors 1920x1060+0+20 1920x1060+1920+20
xrandr --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal
hc detect_monitors

# launch polybar
~/.config/herbstluftwm/bash/launch.sh
