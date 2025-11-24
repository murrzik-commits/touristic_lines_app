// lib/camera/ai_camera_screen.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../main.dart';
import 'camera_manager.dart';
import 'camera_ui_components.dart';

class AICameraScreen extends StatefulWidget {
  const AICameraScreen({super.key});

  @override
  State<AICameraScreen> createState() => _AICameraScreenState();
}

class _AICameraScreenState extends State<AICameraScreen> {
  late CameraManager _cameraManager;

  @override
  void initState() {
    super.initState();
    _cameraManager = CameraManager();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _cameraManager.initialize(cameras);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    final imagePath = await _cameraManager.takePicture();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Фото сохранено: $imagePath")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraManager.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox.expand(child: CameraPreview(_cameraManager.controller)),
          CameraUIComponents.buildTopPanel(context, _cameraManager, () => Navigator.pop(context)),
          CameraUIComponents.buildCornerFrame(),
          CameraUIComponents.buildBottomPanel(_cameraManager, _takePicture),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraManager.dispose();
    super.dispose();
  }
}