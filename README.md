# BroadBandRadio

Self-hosted open source radio station platform featuring:
- 🎧 Web DJ live broadcasting
- 📂 AutoDJ playlists with scheduling
- 🔄 Liquidsoap + Lua audio processing
- 📡 Icecast2 streaming front-end
- 🔧 Node.js backend & MariaDB database
- 🌐 NGINX reverse proxy

## Features
- Manage playlists & schedules via web UI
- Auto-fallback to emergency content
- Real-time DJ broadcasting via web socket
- Proxy streaming via NGINX
- AutoDJ playlist engine
- DJ live broadcasting via browser
- Scheduling engine
- Icecast streaming relay
- Web dashboard

## Requirements
- Debian 10 or higher (tested on Debian 12)
- Root privileges

## Installation

## Installation
```bash
git clone https://github.com/tchovi/broadbandradio.git
cd broadbandradio
chmod +x install.sh
./install.sh
```

Then visit `http://localhost` to access the platform.

## Streaming
Listen to the stream at:
```
http://localhost/stream/stream.mp3
```
## License
MIT License
