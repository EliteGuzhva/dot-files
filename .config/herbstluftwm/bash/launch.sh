#!/usr/bin/env bash
#allow ourselves to run herbstclient as hc
hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}

# Terminate already running bar instances
killall -q  polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
i=0
for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m polybar -c ~/.config/herbstluftwm/bash/polybar.ini example &
	hc pad $i 15 0 0 0
	i=$(( $i + 1 ))
done

