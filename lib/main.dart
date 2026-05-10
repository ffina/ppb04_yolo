// import 'package:flutter/material.dart';
// import 'package:ultralytics_yolo/ultralytics_yolo.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'YOLO Realtime Detection',
//       theme: ThemeData.dark(),
//       home: const YOLODetection(),
//     );
//   }
// }

// class YOLODetection extends StatefulWidget {
//   const YOLODetection({super.key});

//   @override
//   State<YOLODetection> createState() => _YOLODetectionState();
// }

// class _YOLODetectionState extends State<YOLODetection> {
//   List<YOLOResult> _detections = [];
//   double _fps = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black54,
//         title: Text('${_detections.length} objects'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Center(
//               child: Text(
//                 '${_fps.toStringAsFixed(1)} FPS',
//                 style: const TextStyle(color: Colors.greenAccent),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: YOLOView(
//         modelPath: 'assets/models/yolo11n_int8.tflite',
//         confidenceThreshold: 0.5,
//         iouThreshold: 0.45,
//         lensFacing: LensFacing.back,
//         showOverlays: true,
//         onResult: (results) {
//           setState(() => _detections = results);
//         },
//         onPerformanceMetrics: (metrics) {
//           setState(() => _fps = metrics.fps);
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import ini wajib
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VisionTalk AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const YOLODetection(),
    );
  }
}

class YOLODetection extends StatefulWidget {
  const YOLODetection({super.key});

  @override
  State<YOLODetection> createState() => _YOLODetectionState();
}

class _YOLODetectionState extends State<YOLODetection> {
  final FlutterTts _flutterTts = FlutterTts();
  List<YOLOResult> _detections = [];
  double _fps = 0;
  String _lastSpokenObject = "";

  @override
  void initState() {
    super.initState();
    _initTTS();
  }

  // Inisialisasi Suara
  Future<void> _initTTS() async {
    await _flutterTts.setLanguage("id-ID");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
  }

  // Fungsi agar HP bisa bicara
  Future<void> _speak(String label) async {
    // Logika agar tidak berisik (hanya bicara jika objek baru)
    if (label.toLowerCase() != _lastSpokenObject.toLowerCase()) {
      _lastSpokenObject = label;
      await _flutterTts.speak("Ini adalah $label");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Widget Utama dari project kamu
          YOLOView(
            modelPath: 'assets/models/yolo11n_int8.tflite',
            confidenceThreshold: 0.5,
            iouThreshold: 0.45,
            lensFacing: LensFacing.back,
            showOverlays: true,
            onResult: (results) {
              setState(() => _detections = results);
              
              // TRIGGER SUARA DI SINI
              if (results.isNotEmpty) {
                // Ambil label dari objek pertama yang terdeteksi
                _speak(results.first.className);
              }
            },
            onPerformanceMetrics: (metrics) {
              setState(() => _fps = metrics.fps);
            },
          ),

          // 2. UI Overlay Modern (Glassmorphism)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("VisionTalk AI", 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text("Edge Computing Active", 
                      style: TextStyle(color: Colors.greenAccent.withOpacity(0.8), fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${_fps.toStringAsFixed(1)} FPS', 
                    style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _detections.isEmpty ? "Mencari..." : _detections.first.className.toUpperCase(),
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${_detections.length} objek terdeteksi",
                        style: const TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}