// lib/camera/camera_ui_components.dart
import 'package:flutter/material.dart';
import 'camera_manager.dart';
import 'corner_painter.dart';

/// Класс для построения UI компонентов экрана камеры
/// Содержит статические методы для создания различных элементов интерфейса
class CameraUIComponents {
  
  /// Строит верхнюю панель управления камерой
  /// 
  /// Аргументы:
  /// [context] - контекст построения виджета
  /// [cameraManager] - менеджер камеры для управления функционалом
  /// [onClose] - колбэк для закрытия экрана камеры
  /// 
  /// Возвращает:
  /// [Widget] - верхнюю панель с кнопками управления
  static Widget buildTopPanel(BuildContext context, CameraManager cameraManager, VoidCallback onClose) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Кнопка переключения вспышки
            _buildIconButton(
              icon: Icon(
                cameraManager.isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 28,
              ),
              onTap: cameraManager.toggleFlash,
            ),
            
            // Заголовок "AI Камера"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "AI Камера",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            // Кнопка закрытия экрана
            _buildIconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onTap: onClose,
            ),
          ],
        ),
      ),
    );
  }

  /// Строит рамку с угловыми элементами и текстовой подсказкой
  /// 
  /// Возвращает:
  /// [Widget] - центрированную рамку для области сканирования
  static Widget buildCornerFrame() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Контейнер с угловыми элементами
          Container(
            width: 250,
            height: 250,
            child: Stack(
              children: [
                _buildCorner(Alignment.topLeft),
                _buildCorner(Alignment.topRight),
                _buildCorner(Alignment.bottomLeft),
                _buildCorner(Alignment.bottomRight),
              ],
            ),
          ),
          // Текстовая подсказка для пользователя
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Отсканируйте здание, чтобы получить информацию о нём",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Строит нижнюю панель с кнопкой съемки и элементами управления зумом
  /// 
  /// Аргументы:
  /// [cameraManager] - менеджер камеры для управления зумом
  /// [onTakePicture] - колбэк для выполнения съемки
  /// 
  /// Возвращает:
  /// [Widget] - нижнюю панель управления
  static Widget buildBottomPanel(CameraManager cameraManager, VoidCallback onTakePicture) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Основная кнопка съемки
              _buildCaptureButton(onTakePicture),
              const SizedBox(height: 30),
              // Панель управления зумом
              _buildZoomPanel(cameraManager),
            ],
          ),
        ),
      ),
    );
  }

  /// Строит угловой элемент рамки
  /// 
  /// Аргументы:
  /// [alignment] - выравнивание угла (topLeft, topRight, bottomLeft, bottomRight)
  /// 
  /// Возвращает:
  /// [Widget] - элемент угла рамки
  static Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 40,
        height: 40,
        child: CustomPaint(
          painter: CornerPainter(alignment: alignment),
        ),
      ),
    );
  }

  /// Строит панель управления зумом с кнопками и индикатором
  /// 
  /// Аргументы:
  /// [cameraManager] - менеджер камеры для получения данных о зуме
  /// 
  /// Возвращает:
  /// [Widget] - панель управления зумом
  static Widget _buildZoomPanel(CameraManager cameraManager) {
    return Container(
      width: 250,
      child: Row(
        children: [
          // Кнопка уменьшения зума
          _buildZoomButton(
            icon: Icons.remove,
            onTap: cameraManager.zoomOut,
          ),
          
          // Индикатор уровня зума
          Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  // Заполненная часть индикатора
                  Container(
                    width: (250 - 80) * ((cameraManager.currentZoomLevel - cameraManager.minZoomLevel) / (cameraManager.maxZoomLevel - cameraManager.minZoomLevel)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Кнопка увеличения зума
          _buildZoomButton(
            icon: Icons.add,
            onTap: cameraManager.zoomIn,
          ),
        ],
      ),
    );
  }

  /// Строит кнопку управления зумом
  /// 
  /// Аргументы:
  /// [icon] - иконка кнопки (Icons.add или Icons.remove)
  /// [onTap] - колбэк для обработки нажатия
  /// 
  /// Возвращает:
  /// [Widget] - круглую кнопку управления зумом
  static Widget _buildZoomButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  /// Строит универсальную иконку-кнопку
  /// 
  /// Аргументы:
  /// [icon] - виджет иконки
  /// [onTap] - колбэк для обработки нажатия
  /// 
  /// Возвращает:
  /// [Widget] - круглую кнопку с иконкой
  static Widget _buildIconButton({required Widget icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }

  /// Строит основную кнопку съемки фотографии
  /// 
  /// Аргументы:
  /// [onTakePicture] - колбэк для выполнения съемки
  /// 
  /// Возвращает:
  /// [Widget] - стилизованную кнопку камеры
  static Widget _buildCaptureButton(VoidCallback onTakePicture) {
    return GestureDetector(
      onTap: onTakePicture,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/Camera.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}