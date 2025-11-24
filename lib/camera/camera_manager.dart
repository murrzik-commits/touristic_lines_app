// lib/camera/camera_manager.dart
import 'package:camera/camera.dart';

class CameraManager {
  late CameraController _controller;
  bool _isInitialized = false;
  bool _isFlashOn = false;
  double _currentZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 5.0;

  CameraController get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isFlashOn => _isFlashOn;
  double get currentZoomLevel => _currentZoomLevel;
  double get minZoomLevel => _minZoomLevel;
  double get maxZoomLevel => _maxZoomLevel;

  Future<void> initialize(List<CameraDescription> cameras) async {
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller.initialize();
    
    _minZoomLevel = await _controller.getMinZoomLevel();
    _maxZoomLevel = await _controller.getMaxZoomLevel();
    _currentZoomLevel = _minZoomLevel;
    
    _isInitialized = true;
  }

  Future<void> toggleFlash() async {
    final newMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
    await _controller.setFlashMode(newMode);
    _isFlashOn = !_isFlashOn;
  }

  Future<String> takePicture() async {
    final image = await _controller.takePicture();
    return image.path;
  }

  void zoomIn() {
    if (_currentZoomLevel < _maxZoomLevel) {
      _currentZoomLevel = (_currentZoomLevel + 0.5).clamp(_minZoomLevel, _maxZoomLevel);
      _controller.setZoomLevel(_currentZoomLevel);
    }
  }

  void zoomOut() {
    if (_currentZoomLevel > _minZoomLevel) {
      _currentZoomLevel = (_currentZoomLevel - 0.5).clamp(_minZoomLevel, _maxZoomLevel);
      _controller.setZoomLevel(_currentZoomLevel);
    }
  }

  void dispose() {
    _controller.dispose();
  }
}