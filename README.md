# Panduan & Script Basic Setup VM (`basic-setup.sh`)

Dokumen ini berisi isi script `basic-setup.sh` beserta panduan langkah demi langkah untuk menjalankannya pada VM (Virtual Machine) berbasis Ubuntu/Debian.

---

## 1. Isi Script (`basic-setup.sh`)

Berikut adalah isi lengkap dari script `basic-setup.sh`:

```bash
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
```

---

## 2. Cara Menjalankan di VM (Ubuntu/Debian)

### Langkah 1: Masuk ke VM via SSH
```bash
ssh user@ip_address_vm
```

### Langkah 2: Buat File `basic-setup.sh` di VM
Buat file script menggunakan editor teks seperti `nano`:

```bash
nano basic-setup.sh
```
*Salin dan tempel kode script di atas, lalu simpan (`Ctrl+O`, `Enter`, `Ctrl+X`).*

> **Atau** unggah langsung dari komputer lokal Anda via `scp`:
> ```bash
> scp basic-setup.sh user@ip_address_vm:~/
> ```

### Langkah 3: Beri Akses Eksekusi (Executable Permission)
```bash
chmod +x basic-setup.sh
```

### Langkah 4: Jalankan Script dengan Akses Sudo / Root
```bash
sudo ./basic-setup.sh
```

### Langkah 5: Terapkan Perubahan Grup Docker
Supaya user bisa menggunakan perintah `docker` tanpa `sudo`, lakukan logout lalu login kembali, atau jalankan:

```bash
newgrp docker
```

---

## 3. Verifikasi Instalasi

Jalankan perintah berikut di VM untuk memastikan tools telah berhasil terpasang:

```bash
docker --version
docker compose version
git --version
```