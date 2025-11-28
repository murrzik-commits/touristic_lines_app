// lib/camera/ai_camera_screen.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../main.dart';
import 'camera_manager.dart';
import 'camera_ui_components.dart';

/// Экран AI-камеры с возможностью съемки и обработки изображений
class AICameraScreen extends StatefulWidget {
  const AICameraScreen({super.key});

  @override
  State<AICameraScreen> createState() => _AICameraScreenState();
}

class _AICameraScreenState extends State<AICameraScreen> {
  /// Менеджер для управления камерой и ее состоянием
  late CameraManager _cameraManager;

  @override
  void initState() {
    super.initState();
    // Инициализация менеджера камеры
    _cameraManager = CameraManager();
    // Запуск инициализации камеры
    _initializeCamera();
  }

  /// Инициализирует камеру устройства
  /// 
  /// Загружает доступные камеры и настраивает контроллер
  Future<void> _initializeCamera() async {
    await _cameraManager.initialize(cameras);
    // Обновление состояния после инициализации
    if (mounted) {
      setState(() {});
    }
  }

  /// Выполняет съемку фотографии
  /// 
  /// Сохраняет снимок и показывает уведомление о результате
  Future<void> _takePicture() async {
    final imagePath = await _cameraManager.takePicture();
    if (mounted) {
      // Показ SnackBar с путем к сохраненному файлу
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Фото сохранено: $imagePath")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Показ индикатора загрузки пока камера не инициализирована
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
          /// Предпросмотр с камеры
          SizedBox.expand(child: CameraPreview(_cameraManager.controller)),
          
          /// Верхняя панель с кнопками управления
          CameraUIComponents.buildTopPanel(
            context, 
            _cameraManager, 
            () => Navigator.pop(context) // Колбэк для закрытия экрана
          ),
          
          /// Угловая рамка для визуального оформления
          CameraUIComponents.buildCornerFrame(),
          
          /// Нижняя панель с основной кнопкой съемки
          CameraUIComponents.buildBottomPanel(_cameraManager, _takePicture),
        ],
      ),
    );
  }

  @override
  void dispose() {
    /// Освобождение ресурсов камеры при уничтожении экрана
    _cameraManager.dispose();
    super.dispose();
  }
}