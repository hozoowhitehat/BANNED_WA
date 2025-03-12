#!/bin/bash
clear
apt instal mpv -y
clear
# Banner ASCII
echo -e "\e[34m╭────────────────────────────────────────────────────────────╮"
echo -e "\e[31m
 ███████╗██╗     ██╗██████╗ ██████╗ ███████╗██████╗ ███████╗███████╗██████╗  ██████╗
 ██╔════╝██║     ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
 █████╗  ██║     ██║██████╔╝██████╔╝█████╗  ██████╔╝  ███╔╝ █████╗  ██████╔╝██║   ██║
 ██╔══╝  ██║     ██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
 ██║     ███████╗██║██║     ██║     ███████╗██║  ██║███████╗███████╗██║  ██║╚██████╔╝
 ╚═╝     ╚══════╝╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝
"
echo -e "\e[34m╰────────────────────────────────────────────────────────────╯"
date
# Meminta input email dan password
read -p "Masukkan email Anda: " email_from
read -s -p "Masukkan password Anda: " email_password
echo

# Meminta input nomor telepon
read -p "Masukkan nomor telepon Anda: " phoneNumber

# Meminta jumlah pengiriman email
read -p "Masukkan jumlah pengiriman email (max 999): " maxSpam

if ! [[ "$maxSpam" =~ ^[0-9]+$ ]] || [ "$maxSpam" -gt 999 ]; then
  echo -e "\e[31m❌ Jumlah pengiriman harus berupa angka dan tidak boleh lebih dari 999."
  exit 1
fi

# Konfigurasi email
email_to="smb@support.whatsapp.com"
email_subject="Permintaan Dukungan WhatsApp"
email_body="Boa noite, querido Whatsapp Party.\n\nNos últimos dias, muitas vezes enviei fotos de minhas tarefas escolares que causaram spam. Peço desculpas pelas violações yang saya lakukan. Mohon bantuannya untuk memulihkan akun WhatsApp saya, porque isso é muito importante para a escola. Terima kasih. \n\nNomor: $phoneNumber"

# Fungsi untuk mengirim email berulang kali
send_emails() {
  for ((i=1; i<=maxSpam; i++)); do
    # Menggunakan msmtp untuk mengirim email
    msmtp -a default -f "$email_from" -t "$email_to" --subject="$email_subject" <<< "$email_body"

    if [ $? -eq 0 ]; then
      echo -e "\e[34m[${i}/${maxSpam}] Email berhasil dikirim ke ${email_to} untuk nomor: ${phoneNumber}."
    else
      echo -e "\e[31m❌ Gagal mengirim email ke ${email_to}"
    fi

    # Opsional: Tambahkan jeda agar tidak dianggap spam (delay 2 detik)
    sleep 2
  done

  echo -e "\e[32m✅ Selesai mengirim ${maxSpam} email."
}

# Jalankan fungsi pengiriman email
send_emails
