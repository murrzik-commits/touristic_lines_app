// lib/widgets/object_card.dart
import 'package:flutter/material.dart';

/// Карточка для отображения информации об объекте (достопримечательности)
/// Содержит изображение, название, тег маршрута, описание и кнопку для подробной информации
class ObjectCard extends StatelessWidget {
  /// Путь к изображению объекта из assets
  final String imagePath;
  
  /// Название объекта (достопримечательности)
  final String title;
  
  /// Тег маршрута к которому относится объект
  final String tag;
  
  /// Краткое описание объекта
  final String description;
  
  /// Колбэк функция при нажатии кнопки "Узнать больше"
  final VoidCallback onLearnMore;
  
  /// Цвет тега соответствующий цвету маршрута
  final Color tagColor;

  /// Конструктор карточки объекта
  /// 
  /// Аргументы:
  /// [imagePath] - путь к изображению объекта в assets
  /// [title] - название объекта для отображения
  /// [tag] - название маршрута к которому относится объект
  /// [description] - краткое описание объекта
  /// [onLearnMore] - функция вызываемая при нажатии "Узнать больше"
  /// [tagColor] - цвет для тега и акцентных элементов
  const ObjectCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.tag,
    required this.description,
    required this.onLearnMore,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Отступ между карточками
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Закругленные углы карточки
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Легкая тень для глубины
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание по верху
        children: [
          /// Изображение объекта (слева)
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover, // Обрезка изображения по размеру контейнера
              ),
            ),
          ),
          
          /// Текстовый контент (справа)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Заголовок объекта
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E2E2E), // Темно-серый цвет
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Многоточие при длинном тексте
                  ),
                  
                  const SizedBox(height: 4), // Отступ между элементами
                  
                  /// Тег маршрута (например "Багулова линия")
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: tagColor.withOpacity(0.1), // Светлый фон цвета маршрута
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: tagColor.withOpacity(0.3)), // Граница цвета маршрута
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        color: tagColor, // Цвет текста соответствует маршруту
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  /// Описание объекта
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666), // Серый цвет текста
                      height: 1.4, // Межстрочный интервал
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  /// Кнопка "Узнать больше"
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onLearnMore,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        backgroundColor: tagColor.withOpacity(0.1), // Светлый фон цвета маршрута
                      ),
                      child: Text(
                        'Узнать больше',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: tagColor, // Цвет текста соответствует маршруту
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}