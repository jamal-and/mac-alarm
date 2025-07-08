#!/bin/bash

#VIDEO_URL="https://www.youtube.com/watch?v=YOUR_VIDEOID"
VIDEO_URL="https://www.youtube.com/embed/YOUR_VIDEOID?autoplay=1&controls=0"


function fixsound(){
# Gradually increase system volume
vol=10
while [ $vol -le 70 ]; do
  osascript -e "set volume output volume $vol"
  sleep 1
  vol=$((vol + 10))
done
}

# Open Chrome with the video
open -a "Google Chrome" "$VIDEO_URL"

# Wait for the video to load
sleep 1
(fixsound)&
# Send Tab keys to focus video, then press 'f' for fullscreen
osascript <<'END'
tell application "System Events"
    tell process "Google Chrome"
        set frontmost to true
        delay 1

        # Send Tab a few times to reach the player
        keystroke tab
        delay 0.3
        keystroke tab
        delay 0.3
        keystroke tab
        delay 0.3

        # Now press 'f' to go fullscreen in YouTube player
        keystroke "f"
    end tell
end tell
END
