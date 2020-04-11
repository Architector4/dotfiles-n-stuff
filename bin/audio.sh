# Start recording audio off the microphone in WAV format
# You know, when you need to snoop on your friends lol
arecord -fdat -twav -c1 -r44100 "$@"
