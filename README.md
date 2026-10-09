# Basic Setup VM (`basic-setup.sh`)

Script otomatisasi untuk melakukan setup dasar pada Virtual Machine (VM) berbasis **Ubuntu / Debian**.

---

## 📋 Fitur & Isi Script

Script `basic-setup.sh` melakukan langkah-langkah berikut secara otomatis:

1. **Pemeriksaan Hak Akses Root**: Memastikan script dijalankan sebagai `sudo` / `root`.
2. **Update & Upgrade Sistem**: Menjalankan paket update dan upgrade (`apt-get update` & `apt-get upgrade`).
3. **Instalasi Tools Dasar**:
   - `curl` & `wget` (Utilitas unduhan)
   - `git` (Version control)
   - `vim` (Teks editor)
   - `htop` (Monitoring resource sistem)
   - `net-tools` (Utilitas jaringan)
   - `unzip` (Ekstraksi arsip)
   - `tree` (Visualisasi struktur direktori)
   - `ca-certificates` & `gnupg` (Manajemen sertifikat & keamanan)
   - `ufw` (Firewall)
4. **Instalasi & Konfigurasi Docker**:
   - Memasang Docker Engine terbaru melalui script instalasi resmi Docker (`https://get.docker.com`).
   - Mengaktifkan dan menjalankan layanan Docker secara otomatis (`systemctl enable --now docker`).
   - Menambahkan user yang menjalankan perintah `sudo` ke grup `docker` (sehingga dapat menjalankan Docker tanpa `sudo`).
5. **Verifikasi Instalasi**: Menampilkan versi Docker, Docker Compose, dan Tree yang berhasil terpasang.

---

## 🚀 Cara Menjalankan

Anda dapat menjalankan script ini di server Ubuntu/Debian melalui salah satu opsi berikut:

### Opsi 1: Jalankan Langsung (Eksekusi Instan)

```bash
curl -fsSL https://raw.githubusercontent.com/ilhamlii21/script-tools/main/basic-setup.sh | sudo bash
```

---

### Opsi 2: Unduh, Inspect (Cek Isi Script), dan Jalankan

```bash
curl -fsSL https://raw.githubusercontent.com/ilhamlii21/script-tools/main/basic-setup.sh -o basic-setup.sh
less basic-setup.sh
sudo bash basic-setup.sh
```

---

## 💡 Catatan Setelah Instalasi

Agar perubahan grup `docker` berlaku pada user Anda tanpa perlu logout/login kembali, jalankan perintah berikut:

```bash
newgrp docker
```