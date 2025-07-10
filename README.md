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

1. Clone repo & install:

git clone https://github.com/tchovi/broadbandradio.git

cd broadbandradio

npm install
mariadb < sql/schema.sql

2. Setup Liquidsoap service:

sudo cp liquidsoap/main.liq /etc/liquidsoap/main.liq
sudo tee /etc/systemd/system/bbradio.service > /dev/null << EOF
[Unit]
Description=BroadBandRadio Liquidsoap
After=network.target

[Service]
User=www-data
ExecStart=/usr/bin/liquidsoap /etc/liquidsoap/main.liq
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start bbradio
sudo systemctl enable bbradio

3.Start Node.js app:
node server/index.js

4. Setup NGINX:
sudo cp nginx/broadbandradio.conf /etc/nginx/sites-available/
sudo ln -s ../sites-available/broadbandradio.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx


## Usage
- Add playlist media to `/var/bbradio/music/`
- Schedule via web UI or `POST /api/schedule`
- DJ via `/public/dj.html` with Web Audio support
- Stream via `http://radio.example.com/stream/stream.mp3`

## License
MIT License
