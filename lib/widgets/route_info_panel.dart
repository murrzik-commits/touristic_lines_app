// lib/widgets/route_info_panel.dart
import 'package:flutter/material.dart';
import '../services/route_service.dart';
import 'route_image_gallery.dart';

/// Панель информации о маршруте для отображения на карте
/// Показывает название маршрута, галерею изображений и кнопку начала тура
class RouteInfoPanel extends StatelessWidget {
  /// Идентификатор маршрута для загрузки данных
  final String routeName;
  
  /// Колбэк функция для начала тура по маршруту
  final VoidCallback onStartTour;
  
  /// Колбэк функция для закрытия панели
  final VoidCallback onClose;

  /// Конструктор панели информации о маршруте
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута для отображения информации
  /// [onStartTour] - функция вызываемая при нажатии кнопки "Начать тур"
  /// [onClose] - функция вызываемая при закрытии панели
  const RouteInfoPanel({
    super.key,
    required this.routeName,
    required this.onStartTour,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16), // Внешние отступы от краев экрана
      padding: const EdgeInsets.all(16), // Внутренние отступы контента
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Закругленные углы панели
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Тень для эффекта "парящей" панели
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Занимает только необходимое пространство
        crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание по левому краю
        children: [
          _buildHeader(), // Заголовок с названием и кнопкой закрытия
          const SizedBox(height: 4), // Небольшой отступ между элементами
          RouteImageGallery(routeName: routeName, context: context), // Галерея изображений маршрута
          const SizedBox(height: 12), // Отступ перед кнопкой
          _buildStartTourButton(), // Кнопка начала тура
        ],
      ),
    );
  }

  /// Строит заголовок панели с названием маршрута и кнопкой закрытия
  /// 
  /// Возвращает:
  /// [Widget] - строка с названием маршрута и кнопкой закрытия
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Распределение по ширине
      children: [
        /// Название маршрута
        Text(
          RouteService.getRouteTitle(routeName),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E2E2E), // Темно-серый цвет текста
          ),
        ),
        /// Кнопка закрытия панели
        IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF2E2E2E)),
          onPressed: onClose,
        ),
      ],
    );
  }

  /// Строит кнопку для начала тура по маршруту
  /// 
  /// Возвращает:
  /// [Widget] - широкая кнопка с цветом соответствующем маршруту
  Widget _buildStartTourButton() {
    return SizedBox(
      width: double.infinity, // Кнопка на всю ширину контейнера
      child: ElevatedButton(
        onPressed: onStartTour,
        style: ElevatedButton.styleFrom(
          backgroundColor: RouteService.getRouteColor(routeName), // Цвет маршрута
          foregroundColor: Colors.white, // Белый цвет текста
          padding: const EdgeInsets.symmetric(vertical: 12), // Вертикальные отступы
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Закругленные углы кнопки
          ),
        ),
        child: const Text(
          'Начать тур',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Полужирный шрифт
          ),
        ),
      ),
    );
  }
}