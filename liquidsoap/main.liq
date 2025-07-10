# load Lua fallback logic
fallback = external_script "fallback.lua"

# base playlist
music = playlist("/var/bbradio/music")
radio = fallback(music)

# mount to Icecast
output.icecast(%mp3(bitrate=128), host="localhost",
  port=8000, password="hackme",
  mount="stream.mp3", radio)
