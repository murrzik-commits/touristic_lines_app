// lib/widgets/route_image_gallery.dart
import 'package:flutter/material.dart';
import '../services/route_service.dart';

/// Виджет галереи изображений для маршрута
/// Отображает горизонтальный список изображений с подписями
/// Поддерживает просмотр изображений в полноэкранном режиме
class RouteImageGallery extends StatelessWidget {
  /// Идентификатор маршрута для загрузки изображений
  final String routeName;
  
  /// Контекст построения для показа диалогов
  final BuildContext context;

  /// Конструктор галереи изображений маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута для загрузки данных изображений
  /// [context] - контекст построения для отображения диалогов
  const RouteImageGallery({
    super.key,
    required this.routeName,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140, // Фиксированная высота галереи
      child: ListView(
        scrollDirection: Axis.horizontal, // Горизонтальная прокрутка
        children: _getRouteImagesWithLabels(),
      ),
    );
  }

  /// Создает список виджетов изображений с подписями для галереи
  /// 
  /// Возвращает:
  /// [List<Widget>] - список элементов галереи
  List<Widget> _getRouteImagesWithLabels() {
    final imageData = RouteService.getRouteImageData(routeName);
    
    return List.generate(imageData.length, (index) {
      final data = imageData[index];
      final imagePath = data['image'] ?? 'assets/street_icons/Bagulov_street.jpg'; // Изображение по умолчанию
      final label = data['label'] ?? '${index + 1}. Объект'; // Подпись по умолчанию
      
      return GestureDetector(
        onTap: () => _showImageDialog(imagePath, label), // Обработчик нажатия для полноэкранного просмотра
        child: Container(
          width: 160, // Фиксированная ширина элемента галереи
          margin: const EdgeInsets.only(right: 12), // Отступ между элементами
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Контейнер для изображения
              Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Закругленные углы изображения
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover, // Обрезка изображения по размеру контейнера
                  ),
                ),
              ),
              const SizedBox(height: 6), // Отступ между изображением и подписью
              
              /// Подпись к изображению
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2E2E2E), // Темно-серый цвет текста
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Многоточие при длинном тексте
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Показывает диалог с полноэкранным просмотром изображения
  /// 
  /// Аргументы:
  /// [imagePath] - путь к изображению для отображения
  /// [label] - подпись изображения (не используется в текущей реализации)
  void _showImageDialog(String imagePath, String label) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8), // Затемненный фон позади диалога
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Прозрачный фон диалога
          insetPadding: const EdgeInsets.all(20), // Отступы от краев экрана
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Контейнер с полноэкранным изображением
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover, // Заполнение всего контейнера
                  ),
                ),
              ),
              
              /// Кнопка закрытия в правом верхнем углу
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(), // Закрытие диалога
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6), // Полупрозрачный черный фон
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}