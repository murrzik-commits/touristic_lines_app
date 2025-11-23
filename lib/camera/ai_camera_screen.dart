import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Пакет для работы с камерой
import '../main.dart'; // Импорт глобальной переменной cameras

// Экран AI камеры - StatefulWidget для управления состоянием камеры
class AICameraScreen extends StatefulWidget {
  const AICameraScreen({super.key});

  @override
  State<AICameraScreen> createState() => _AICameraScreenState();
}

// Класс состояния для экрана камеры
// Управляет инициализацией камеры, вспышкой и съемкой фото
class _AICameraScreenState extends State<AICameraScreen> {
  // Контроллер для управления камерой устройства
  late CameraController controller;
  
  // Флаг инициализации камеры (для отображения индикатора загрузки)
  bool isInitialized = false;
  
  // Состояние вспышки (включена/выключена)
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    // Инициализация камеры при создании состояния
    _initializeCamera();
  }

  // Асинхронная инициализация камеры
  Future<void> _initializeCamera() async {
    // Создание контроллера для первой камеры в списке с высоким разрешением
    controller = CameraController(cameras[0], ResolutionPreset.high);
    
    // Ожидание инициализации камеры
    await controller.initialize();
    
    // Проверка что виджет все еще отображается (не уничтожен)
    if (mounted) {
      setState(() => isInitialized = true); // Обновление состояния
    }
  }

  // Переключение состояния вспышки
  Future<void> _toggleFlash() async {
    // Выбор режима в зависимости от текущего состояния
    final newMode = isFlashOn ? FlashMode.off : FlashMode.torch;
    
    // Установка нового режима вспышки
    await controller.setFlashMode(newMode);
    
    // Обновление состояния
    setState(() => isFlashOn = !isFlashOn);
  }

  // Съемка фотографии
  Future<void> _takePicture() async {
    // Асинхронный захват изображения
    final image = await controller.takePicture();
    
    // Проверка что виджет все еще отображается
    if (mounted) {
      // Показ уведомления о сохранении фото
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Фото сохранено: ${image.path}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Показ индикатора загрузки пока камера не готова
    if (!isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black, // Черный фон для камеры
        body: Center(child: CircularProgressIndicator()), // Круговой индикатор
      );
    }

    // Основной интерфейс камеры
    return Scaffold(
      backgroundColor: Colors.black, // Черный фон
      body: Stack(
        children: [
          // Превью камеры на весь экран
          SizedBox.expand(child: CameraPreview(controller)),
          
          // Рамка для наведения в центре
          _buildTargetFrame(),
          
          // Кнопка назад
          _buildBackButton(context),
          
          // Кнопка вспышки
          _buildFlashButton(),
          
          // Кнопка съемки
          _buildCaptureButton(),
        ],
      ),
    );
  }

  // Виджет рамки для наведения камеры
  Widget _buildTargetFrame() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 4),
          borderRadius: BorderRadius.circular(24), // Закругленные углы
        ),
      ),
    );
  }

  // Кнопка возврата на предыдущий экран
  Widget _buildBackButton(BuildContext context) {
    return SafeArea( // Учет безопасных зон (вырез, динамик и т.д.)
      child: Align(
        alignment: Alignment.topLeft, // Верхний левый угол
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context), // Возврат по навигации
          ),
        ),
      ),
    );
  }

  // Кнопка переключения вспышки
  Widget _buildFlashButton() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight, // Верхний правый угол
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IconButton(
            // Динамическая иконка в зависимости от состояния вспышки
            icon: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
              size: 30,
            ),
            onPressed: _toggleFlash, // Обработчик переключения
          ),
        ),
      ),
    );
  }

  // Основная кнопка съемки фотографии
  Widget _buildCaptureButton() {
    return Align(
      alignment: Alignment.bottomCenter, // Низ по центру
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60), // Отступ снизу
        child: GestureDetector( // Обработчик жестов (тапов)
          onTap: _takePicture, // Обработчик съемки
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: const Center(
              // Двойной круг для стилизации кнопки
              child: CircleAvatar(radius: 32, backgroundColor: Colors.white, child: CircleAvatar(radius: 28)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Освобождение ресурсов камеры при уничтожении виджета
    controller.dispose();
    super.dispose();
  }
}