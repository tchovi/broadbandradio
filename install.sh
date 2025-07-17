#!/bin/bash

set -e

echo "📦 Updating system packages..."
sudo apt update
sudo apt upgrade -y

echo "📥 Installing dependencies..."
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

echo "🚀 Starting MariaDB (WSL fallback using 'service')..."
if command -v service >/dev/null; then
    sudo service mysql start || sudo service mariadb start
else
    echo "⚠️ Unable to start MariaDB automatically. Please start it manually with: sudo service mariadb start"
fi

echo "🔍 Checking MariaDB status..."
if ! mysqladmin ping -u root --silent; then
    echo "❌ MariaDB is not responding. You may need to manually configure or start it."
else
    echo "✅ MariaDB is running."
fi

echo "📦 Installing backend dependencies..."
cd backend
npm install

echo "📦 Installing frontend dependencies..."
cd ../frontend
npm install
npm run build

echo "✅ Installation complete. Start the server using: npm start in backend directory."
