# VisionTalk AI

VisionTalk AI adalah aplikasi mobile berbasis Flutter yang mengimplementasikan konsep Edge Computing untuk deteksi objek secara real-time. Aplikasi ini akanmengenali berbagai jenis objek melalui kamera smartphone dan akan memberikan umpan balik berupa suara (audio) secara instan kepada pengguna. Aplikasi ini akan secara otomatis menyebutkan nama objek yang terdeteksi dalam Bahasa Indonesia ("Ini adalah botol", "Ini adalah person", dll).

Aplikasi ini dapat dikembangkan lebih lanjut sesuai dengan kebutuhan, seperti alat bantu tunanetra, edukasi anak, atau Automated Inventory (mempercepat proses pengecekan barang secara mandiri).

<img width="30%" alt="image" src="https://github.com/user-attachments/assets/0a874afd-56b9-42fd-aa09-a91384ce2374" />

<img width="30%" alt="image" src="https://github.com/user-attachments/assets/a2a32196-e569-4238-8aad-e0fd9aeb6f58" />


## Tech Stack
1. Framework: Flutter (Dart)
2. AI Model: YOLOv11 (Optimized for Mobile - .tflite)
3. AI Feature: * Computer Vision: Deteksi objek real-time dengan tingkat akurasi tinggi.
   Speech Synthesis: Flutter Text-to-Speech (TTS) untuk konversi label visual ke audio.
4. Computing Paradigm: Edge Computing (Seluruh proses AI dilakukan di dalam perangkat/on-device tanpa memerlukan koneksi internet atau API eksternal).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
