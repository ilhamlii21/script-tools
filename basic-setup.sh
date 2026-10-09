#!/usr/bin/env bash
set -euo pipefail

# --- Cek root ---
if [[ $EUID -ne 0 ]]; then
  echo "Jalankan dengan sudo/root"; exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "==> Update & upgrade sistem"
apt-get update -y
apt-get upgrade -y

echo "==> Install tools dasar"
apt-get install -y curl wget git vim htop net-tools unzip tree ca-certificates gnupg ufw

echo "==> Install Docker"
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | sh
else
  echo "Docker sudah terpasang, dilewati"
fi

systemctl enable --now docker

# Tambahkan user yang menjalankan sudo ke grup docker
TARGET_USER="${SUDO_USER:-$USER}"
if [[ "$TARGET_USER" != "root" ]]; then
  usermod -aG docker "$TARGET_USER"
  echo "User $TARGET_USER ditambahkan ke grup docker (logout/login ulang)"
fi

echo "==> Selesai"
docker --version
docker compose version
tree --version