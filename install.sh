#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx icecast2 mariadb-server mariadb-client nodejs npm git build-essential opam ocaml libtag1-dev libmad0-dev libsamplerate0-dev libcry-dev libssl-dev ffmpeg
opam init -y
. ~/.profile
opam install taglib mad lame cry ffmpeg liquidsoap -y
sudo mysql < sql/schema.sql
npm install
sudo cp nginx/broadbandradio.conf /etc/nginx/sites-available/broadbandradio.conf
sudo ln -s /etc/nginx/sites-available/broadbandradio.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx
sudo mkdir -p /etc/liquidsoap /var/bbradio/music
sudo cp liquidsoap/main.liq /etc/liquidsoap/
sudo cp liquidsoap/fallback.lua /etc/liquidsoap/
sudo tee /etc/systemd/system/bbradio.service > /dev/null <<EOF
[Unit]
Description=BroadBandRadio Liquidsoap
After=network.target

[Service]
User=www-data
ExecStart=/home/$(whoami)/.opam/default/bin/liquidsoap /etc/liquidsoap/main.liq
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start bbradio
sudo systemctl enable bbradio
node server/index.js
