#!/bin/bash

set -e

echo "Updating system packages..."
sudo apt update
sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y \
    build-essential \
    libssl-dev \
    libcrypt-dev \
    libcurl4-openssl-dev \
    libmicrohttpd-dev \
    libtool \
    autoconf \
    automake \
    pkg-config \
    git \
    cmake \
    unzip \
    curl \
    ffmpeg \
    python3 \
    python3-pip \
    mariadb-server \
    apache2 \
    liquidsoap \
    icecast2 \
    nodejs \
    npm

echo "Setting up MariaDB..."
sudo systemctl start mariadb
sudo systemctl enable mariadb

echo "Installing backend dependencies..."
cd backend
npm install

echo "Installing frontend dependencies..."
cd ../frontend
npm install
npm run build

echo "Installation complete. Start the server using: npm start"
