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

## Requirements
- Debian 10/11, root access
- Node.js, MariaDB, Icecast2, NGINX
- OPAM for Liquidsoap

## Installation

(see Build & Run section above)

## Usage
- Add playlist media to `/var/bbradio/music/`
- Schedule via web UI or `POST /api/schedule`
- DJ via `/public/dj.html` with Web Audio support
- Stream via `http://radio.example.com/stream/stream.mp3`

## License
MIT License
