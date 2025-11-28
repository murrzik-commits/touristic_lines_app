// lib/camera/camera_manager.dart
import 'package:camera/camera.dart';

/// Менеджер для управления камерой и ее функциями
/// Обеспечивает работу с вспышкой, зумом и съемкой фотографий
class CameraManager {
  /// Контроллер камеры для управления аппаратной частью
  late CameraController _controller;
  
  /// Флаг инициализации камеры
  bool _isInitialized = false;
  
  /// Состояние вспышки (включена/выключена)
  bool _isFlashOn = false;
  
  /// Текущий уровень зума
  double _currentZoomLevel = 1.0;
  
  /// Минимальный доступный уровень зума
  double _minZoomLevel = 1.0;
  
  /// Максимальный доступный уровень зума
  double _maxZoomLevel = 5.0;

  // Геттеры для доступа к приватным полям

  /// Возвращает контроллер камеры
  CameraController get controller => _controller;
  
  /// Возвращает статус инициализации камеры
  bool get isInitialized => _isInitialized;
  
  /// Возвращает состояние вспышки
  bool get isFlashOn => _isFlashOn;
  
  /// Возвращает текущий уровень зума
  double get currentZoomLevel => _currentZoomLevel;
  
  /// Возвращает минимальный уровень зума
  double get minZoomLevel => _minZoomLevel;
  
  /// Возвращает максимальный уровень зума
  double get maxZoomLevel => _maxZoomLevel;

  /// Инициализирует камеру с указанными параметрами
  /// 
  /// Аргументы:
  /// [cameras] - список доступных камер устройства
  /// 
  /// Инициализирует контроллер, получает пределы зума и устанавливает начальные значения
  Future<void> initialize(List<CameraDescription> cameras) async {
    // Создание контроллера с первой доступной камерой и высоким качеством
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller.initialize();
    
    // Получение пределов зума от устройства
    _minZoomLevel = await _controller.getMinZoomLevel();
    _maxZoomLevel = await _controller.getMaxZoomLevel();
    _currentZoomLevel = _minZoomLevel;
    
    _isInitialized = true;
  }

  /// Переключает состояние вспышки (вкл/выкл)
  /// 
  /// Изменяет режим вспышки между torch (постоянный свет) и off (выключено)
  Future<void> toggleFlash() async {
    final newMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
    await _controller.setFlashMode(newMode);
    _isFlashOn = !_isFlashOn;
  }

  /// Выполняет съемку фотографии
  /// 
  /// Возвращает:
  /// [String] - путь к сохраненному файлу изображения
  Future<String> takePicture() async {
    final image = await _controller.takePicture();
    return image.path;
  }

  /// Увеличивает zoom на 0.5 единиц
  /// 
  /// Проверяет максимальный предел и устанавливает новое значение
  void zoomIn() {
    if (_currentZoomLevel < _maxZoomLevel) {
      _currentZoomLevel = (_currentZoomLevel + 0.5).clamp(_minZoomLevel, _maxZoomLevel);
      _controller.setZoomLevel(_currentZoomLevel);
    }
  }

  /// Уменьшает zoom на 0.5 единиц
  /// 
  /// Проверяет минимальный предел и устанавливает новое значение
  void zoomOut() {
    if (_currentZoomLevel > _minZoomLevel) {
      _currentZoomLevel = (_currentZoomLevel - 0.5).clamp(_minZoomLevel, _maxZoomLevel);
      _controller.setZoomLevel(_currentZoomLevel);
    }
  }

  /// Освобождает ресурсы камеры
  /// 
  /// Должен вызываться при завершении работы с камерой
  void dispose() {
    _controller.dispose();
  }
}