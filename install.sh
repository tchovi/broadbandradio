#!/bin/bash

# Exit on error
set -e

# Update System
sudo apt update && sudo apt upgrade -y

# Install OPAM first (fix for missing opam)
sudo apt install -y opam

# Install required dependencies
sudo apt install -y nginx icecast2 mariadb-server mariadb-client \
  nodejs npm git build-essential ocaml \
  libtag1-dev libmad0-dev libsamplerate0-dev libcry-dev libssl-dev ffmpeg

# Setup OPAM and install Liquidsoap
opam init -y --disable-sandboxing
. ~/.profile
opam install taglib mad lame cry ffmpeg liquidsoap -y

# Setup MariaDB database schema
sudo service mariadb start
sudo mysql < sql/schema.sql

# Install Node.js packages
npm install

# Copy NGINX config
sudo cp nginx/broadbandradio.conf /etc/nginx/sites-available/broadbandradio.conf
sudo ln -sf /etc/nginx/sites-available/broadbandradio.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Setup folders for media
sudo mkdir -p /etc/liquidsoap /var/bbradio/music
sudo cp liquidsoap/main.liq /etc/liquidsoap/
sudo cp liquidsoap/fallback.lua /etc/liquidsoap/

# Create systemd service for Liquidsoap
sudo tee /etc/systemd/system/bbradio.service > /dev/null <<EOF
[Unit]
Description=BroadBandRadio Liquidsoap
After=network.target

[Service]
User=www-data
ExecStart=/root/.opam/default/bin/liquidsoap /etc/liquidsoap/main.liq
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
sudo systemctl daemon-reload
sudo systemctl start bbradio
sudo systemctl enable bbradio

# Start the Node.js application
npm start
