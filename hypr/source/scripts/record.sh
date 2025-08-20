#!/usr/bin/env bash

getdate() {
    date '+%Y-%m-%d_%H.%M.%S'
}

getaudiooutput() {
    pactl list sources | grep 'Name' | grep 'monitor' | cut -d ' ' -f2
}

getactivemonitor() {
    hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
}

# Setup video directory
xdgvideo="$(xdg-user-dir VIDEOS)"
if [[ $xdgvideo = "$HOME" ]]; then
    unset xdgvideo
fi
mkdir -p "${xdgvideo:-$HOME/Videos}"
cd "${xdgvideo:-$HOME/Videos}" || exit

# Toggle recording
if pgrep wf-recorder > /dev/null; then
    notify-send "Recording Stopped" "Stopped" -a 'Recorder' &
    pkill wf-recorder &
else
    filename="recording_$(getdate).mp4"
    notify-send "Starting recording" "$filename" -a 'Recorder' & 
    wf-recorder -o "$(getactivemonitor)" --pixel-format yuv420p -f "./$filename" -t --audio="$(getaudiooutput)"
fi