// lib/routes/route_detail_screen.dart
import 'package:flutter/material.dart';
import '../services/route_service.dart';
import '../widgets/route_image_gallery.dart';

/// Экран детальной информации о маршруте
/// Показывает подробное описание, галерею изображений и кнопку начала тура
class RouteDetailScreen extends StatelessWidget {
  /// Название маршрута для отображения информации
  final String routeName;
  
  /// Колбэк для начала тура по маршруту
  final VoidCallback onStartTour;
  
  /// Колбэк для закрытия экрана
  final VoidCallback onClose;

  /// Конструктор класса RouteDetailScreen
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута для загрузки данных
  /// [onStartTour] - функция вызываемая при нажатии кнопки "Начать тур"
  /// [onClose] - функция вызываемая при закрытии экрана
  const RouteDetailScreen({
    super.key,
    required this.routeName,
    required this.onStartTour,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Прозрачный фон для затемнения
      body: Stack(
        children: [
          /// Затемненный фон позади контента
          Container(color: Colors.black.withOpacity(0.3)),
          /// Основной контент экрана
          _buildContent(context),
        ],
      ),
    );
  }

  /// Строит основной контент экрана с информацией о маршруте
  /// 
  /// Аргументы:
  /// [context] - контекст построения для доступа к размерам экрана
  /// 
  /// Возвращает:
  /// [Widget] - позиционированный контейнер с информацией о маршруте
  Widget _buildContent(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 100, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(), // Заголовок и кнопка закрытия
                const SizedBox(height: 12),
                RouteImageGallery(routeName: routeName, context: context), // Галерея изображений
                const SizedBox(height: 16),
                _buildDescription(), // Описание маршрута
                const SizedBox(height: 16),
                _buildStartTourButton(), // Кнопка начала тура
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Строит заголовок экрана с названием маршрута и кнопкой закрытия
  /// 
  /// Возвращает:
  /// [Widget] - строка с названием маршрута и кнопкой закрытия
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Название маршрута
        Expanded(
          child: Text(
            RouteService.getRouteTitle(routeName),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        /// Кнопка закрытия экрана
        IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF2E2E2E)),
          onPressed: onClose,
        ),
      ],
    );
  }

  /// Строит блок с описанием маршрута
  /// 
  /// Возвращает:
  /// [Widget] - контейнер с текстовым описанием маршрута
  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Светло-серый фон
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        RouteService.getRouteFullDescription(routeName),
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF666666), // Серый цвет текста
          height: 1.4, // Межстрочный интервал
        ),
      ),
    );
  }

  /// Строит кнопку для начала тура по маршруту
  /// 
  /// Возвращает:
  /// [Widget] - стилизованную кнопку с цветом соответствующем маршруту
  Widget _buildStartTourButton() {
    return SizedBox(
      width: 160, // Фиксированная ширина кнопки
      child: ElevatedButton(
        onPressed: onStartTour,
        style: ElevatedButton.styleFrom(
          backgroundColor: RouteService.getRouteColor(routeName), // Цвет маршрута
          foregroundColor: Colors.white, // Белый текст
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Начать тур',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}