#!/bin/sh

i3status | while :
do
  layout=$(setxkbmap -query | grep -o -E '(us|se)')
  dataDown=$(ifconfig eno1 | grep -o -m 1 -E '(\(.* MiB\)|\(.* GiB\))' | head -1)
  dataUp=$(ifconfig eno1 | grep -o -m 2 -E '(\(.* MiB\)|\(.* GiB\))' | tail -1)
  disk=$(df -hl | grep -w "/" | awk '{print $4}')
  time=$(date)
  packages=$(pacman -Qu | wc -l)
	volume=$(amixer get Master | grep -o -m 1 -E '([0-9]*\%)')

  echo "  Layout: ${layout^^} | Volume: $volume  |  Pkgs: $packages  |  Down: $dataDown  |  Up: $dataUp  | ${disk}B  | $time  " || exit 1
done
