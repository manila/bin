#!/bin/sh
# ~/barf.sh
#
# by Manila

dateandtime() {
	echo "$( date '+%a %I:%M' )"
}

batteryinfo() {
	echo "$( acpi | cut -d ',' -f 2 | tr -d ' \t\n\r\f' )"
}

cpuinfo() {
	echo "$( ps aux | awk '{ load+=$3 } END { print load }' )"
}

meminfo() {
	echo "$( cat /proc/meminfo | awk '
	NR < 3 {if (NR == 1) { free=$2; next }} {if (NR == 2) { free-=$2; next }} END {{if ((free/1000/1000) < 1) { printf "%3dMB", (free/1000) }} {if ((free/1000/1000) > 1) { printf "%1.2fGB", (free/1000/1000) }}}'
)"

}

brightness() {
	echo "$( awk '{ if (FNR==NR) { value=$0; next } { printf "%2.0d", (value / $0 * 100) }}' /sys/class/backlight/intel_backlight/brightness /sys/class/backlight/intel_backlight/max_brightness )"
}

networking() {
	echo "hi"
}

volume() {
	echo "$( amixer get Master | awk 'END { print $4 }' )"
}

uptime() {
	echo "\0"
}

#Status Bar
while :; do
	echo " %{r} $(cpuinfo) $(meminfo) $(volume)  $(batteryinfo) $(dateandtime)  "
	sleep 2
done
