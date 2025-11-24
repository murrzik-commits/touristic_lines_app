// lib/widgets/route_info_panel.dart
import 'package:flutter/material.dart';

class RouteInfoPanel extends StatelessWidget {
  final String routeName;
  final VoidCallback onStartTour;
  final VoidCallback onClose;

  const RouteInfoPanel({
    super.key,
    required this.routeName,
    required this.onStartTour,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок и кнопка закрытия
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getRouteTitle(routeName),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E2E),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF2E2E2E)),
                onPressed: onClose,
              ),
            ],
          ),
          
          const SizedBox(height: 4),

          // Фотографии объектов с подписями
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _getRouteImagesWithLabels(routeName, context),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Кнопка начать тур
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onStartTour,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getRouteColor(routeName),
                foregroundColor: Colors.white,
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
          ),
        ],
      ),
    );
  }

  List<Widget> _getRouteImagesWithLabels(String routeName, BuildContext context) {
    final imageData = _getImageData(routeName);
    
    return List.generate(imageData.length, (index) {
      final data = imageData[index];
      final imagePath = data['image'] ?? 'assets/street_icons/Bagulov_street.jpg';
      final label = data['label'] ?? '${index + 1}. Объект';
      
      return GestureDetector(
        onTap: () => _showImageDialog(context, imagePath, label),
        child: Container(
          width: 160,
          margin: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Фотография
              Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Подпись
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2E2E2E),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showImageDialog(BuildContext context, String imagePath, String label) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8), // Затемненный фон
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Основное изображение
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Заголовок поверх изображения
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              // Кнопка закрытия
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
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

  // ... остальные методы без изменений ...
  String _getRouteTitle(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return "Багулова линия";
      case 'green':
        return "Зеленая линия";
      case 'decabristov':
        return "Квартал Декабристов";
      case 'red':
        return "Красная улица";
      default:
        return "Маршрут";
    }
  }

  Color _getRouteColor(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return const Color(0xFF9C27B0);
      case 'green':
        return const Color(0xFF4CAF50);
      case 'decabristov':
        return const Color(0x8B4513);
      case 'red':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF2E2E2E);
    }
  }

  List<Map<String, String>> _getImageData(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return [
          {'image': 'assets/street_icons/Bagulov_street.jpg', 'label': '1. Дом купца Петрова'},
          {'image': 'assets/street_icons/Bagulov_street.jpg', 'label': '2. Старая аптека'},
          {'image': 'assets/street_icons/Bagulov_street.jpg', 'label': '3. Исторический музей'},
        ];
      case 'green':
        return [
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '1. Зеленая усадьба'},
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '2. Парк культуры'},
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '3. Архитектурный ансамбль'},
        ];
      case 'decabristov':
        return [
          {'image': 'assets/street_icons/Decabristov_street.jpg', 'label': '1. Дом декабристов'},
          {'image': 'assets/street_icons/Decabristov_street.jpg', 'label': '2. Мемориальный комплекс'},
          {'image': 'assets/street_icons/Decabristov_street.jpg', 'label': '3. Исторический квартал'},
        ];
      case 'red':
        return [
          {'image': 'assets/street_icons/Red_street.jpg', 'label': '1. Площадь революции'},
          {'image': 'assets/street_icons/Red_street.jpg', 'label': '2. Дом советов'},
          {'image': 'assets/street_icons/Red_street.jpg', 'label': '3. Мемориал'},
        ];
      default:
        return [
          {'image': 'assets/street_icons/Bagulov_street.jpg', 'label': '1. Историческое здание'},
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '2. Архитектурный памятник'},
        ];
    }
  }
}