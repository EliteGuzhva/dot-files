#!/usr/bin/env bash

# this is a simple config for herbstluftwm

hc() {
    herbstclient "$@"
}

hc emit_hook reload

# set background color
# xsetroot -solid '#404040'
# feh --bg-scale /home/nikita/Pictures/Wallpapers/01.jpg
feh --bg-scale /home/nikita/git_projects/nord-backgrounds/operating-systems/1920x1080/ubuntu.png

# set compton for opacity
# compton -b --config /home/nikita/.config/compton/compton.conf
compton -f &

# remove all existing keybindings
hc keyunbind --all

function get_sink() {
	pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,'
}

# keybindings
# if you have a super key you will be much happier with Mod set to Mod4
Mod=Mod1    # Use alt as the main modifier
#Mod=Mod4   # Use the super key as the main modifier

# custom key bindings
hc keybind Mod4-n spawn nautilus
hc keybind Mod4-f spawn firefox
hc keybind Mod4-s spawn skype
hc keybind Mod4-t spawn telegram-desktop
hc keybind Mod4-m spawn spotify
hc keybind Mod4-i spawn clion
hc keybind Mod4-e spawn /home/nikita/git_projects/Goneovim/goneovim

hc keybind $Mod-Shift-Return spawn dmenu_run

hc keybind Mod4-1 spawn ibus engine xkb:us::eng
hc keybind Mod4-2 spawn ibus engine xkb:ru::rus
hc keybind Mod4-3 spawn ibus engine libpinyin

hc keybind Print spawn gnome-screenshot -a

# hc keybind $Mod-F9 spawn pactl set-sink-mute $(get_sink) toggle
# hc keybind $Mod-F10 spawn pactl set-sink-volume $(get_sink) -5%
# hc keybind $Mod-F11 spawn pactl set-sink-volume $(get_sink) +5%

hc keybind XF86AudioMute spawn amixer -D pulse -q sset Master toggle
hc keybind XF86AudioLowerVolume spawn amixer -D pulse -q sset Master 5%- unmute
hc keybind XF86AudioRaiseVolume spawn amixer -D pulse -q sset Master 5%+ unmute

hc keybind $Mod-F9 spawn amixer -D pulse -q sset Master toggle
hc keybind $Mod-F10 spawn amixer -D pulse -q sset Master 5%- unmute
hc keybind $Mod-F11 spawn amixer -D pulse -q sset Master 5%+ unmute
# to set balance: amixer -D pulse set Master 45%,55%

hc keybind $Mod-F7 spawn playerctl --player=spotify,firefox play-pause
hc keybind $Mod-F6 spawn playerctl --player=spotify,firefox previous
hc keybind $Mod-F8 spawn playerctl --player=spotify,firefox next

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
# tag_names=("Net" "Config" "Social" "Files" "Terminal" "Dev" "Dev2" "Misc" "Free")
tag_names=("Net" "Config" "Social" "Files" "Terminal" "Dev" "Dev2" "Music" "Free")
tag_keys=( {1..9} 0 )

hc rename default "${tag_names[0]}" || true
for i in ${!tag_names[@]} ; do
    hc add "${tag_names[$i]}"
    # hc merge_tag "${tag_names[$i]}"
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
hc set frame_border_active_color '#81a1c1'
hc set frame_border_normal_color '#2e3440'
hc set frame_bg_normal_color '#565656'
hc set frame_bg_active_color '#345F0C'
hc set frame_border_width 0
hc set always_show_frame 0
hc set frame_bg_transparent 1
hc set frame_transparent_width 0
hc set frame_gap 0

hc attr theme.active.color '#81a1c1' # '#9fbc00'
hc attr theme.normal.color '#2e3440'
hc attr theme.urgent.color '#bf616a'
hc attr theme.inner_width 1
hc attr theme.inner_color black
hc attr theme.border_width 3
hc attr theme.floating.border_width 4
hc attr theme.floating.outer_width 1
hc attr theme.floating.outer_color black
hc attr theme.active.inner_color '#3E4A00'
hc attr theme.active.outer_color '#3E4A00'
hc attr theme.background_color '#141414'

hc set window_gap 20
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

# do multi monitor setup here, e.g.:
# hc set_monitors 1920x1060+0+20 1920x1060+1920+20
# or simply:
# xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal
xrandr --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal
hc detect_monitors

# find the panel
# panel=~/.config/herbstluftwm/bash/launch.sh
# [ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
# for monitor in $(herbstclient list_monitors | cut -d: -f1) ; do
#     # start it on each monitor
#     "$panel" $monitor &
# done

# launch polybar
~/.config/herbstluftwm/bash/launch.sh
