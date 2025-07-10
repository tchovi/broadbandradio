fallback = external_script "fallback.lua"
music = playlist("/var/bbradio/music")
radio = fallback(music)
output.icecast(%mp3(bitrate=128), host="localhost", port=8000, password="hackme", mount="/stream.mp3", radio)
