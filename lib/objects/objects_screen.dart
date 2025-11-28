// lib/objects/objects_screen.dart
import 'package:flutter/material.dart';
import '../widgets/object_card.dart';
import '../services/route_service.dart';

/// Экран отображения списка исторических объектов и достопримечательностей
/// Показывает карточки объектов с изображениями и описаниями
class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// Заголовок экрана
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16, // Отступ с учетом статус бара
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Text(
              'Объекты',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E2E2E),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          /// Список объектов с отступом для нижней навигационной панели
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16), // Отступ снизу для навигации
              child: ListView(
                children: [
                  /// Карточка объекта: Здание почты и телеграфа
                  ObjectCard(
                    imagePath: 'assets/objects/post_office.jpeg',
                    title: 'Здание почты и телеграфа',
                    tag: 'Багулова линия',
                    description: 'Здание было возведено в 1893 году по проекту архитектора М.Ю. Арнольда специально для почтово-телеграфной конторы.',
                    onLearnMore: () => _onLearnMore(context, 'Здание почты и телеграфа'),
                    tagColor: RouteService.getRouteColor('bagulov'), // Цвет соответствует маршруту
                  ),

                  /// Карточка объекта: Миссионерское училище
                  ObjectCard(
                    imagePath: 'assets/objects/xram.jpg',
                    title: 'Миссионерское училище',
                    tag: 'Багулова линия',
                    description: 'Архиерейский дом и храм был основан 26 сентября 1884 года в честь памяти святого апостола Андрея Первозванного и святителя Иннокентия.',
                    onLearnMore: () => _onLearnMore(context, 'Миссионерское училище'),
                    tagColor: RouteService.getRouteColor('bagulov'),
                  ),
                  
                  /// Карточка объекта: Дом Хлыновского
                  ObjectCard(
                    imagePath: 'assets/objects/xlynovskogo.jpg',
                    title: 'Дом Хлыновского',
                    tag: 'Зеленая линия',
                    description: 'Историческая усадьба в стиле классицизма с сохранившимися элементами оригинальной отделки.',
                    onLearnMore: () => _onLearnMore(context, 'Зеленая усадьба'),
                    tagColor: RouteService.getRouteColor('green'),
                  ),
                  
                  /// Карточка объекта: Дом декабристов
                  ObjectCard(
                    imagePath: 'assets/objects/decabristov.jpg',
                    title: 'Дом декабристов',
                    tag: 'Квартал Декабристов',
                    description: 'Мемориальный дом, где проживали ссыльные декабристы в период сибирской ссылки.',
                    onLearnMore: () => _onLearnMore(context, 'Дом декабристов'),
                    tagColor: RouteService.getRouteColor('decabristov'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Обработчик нажатия кнопки "Узнать больше" на карточке объекта
  /// 
  /// Аргументы:
  /// [context] - контекст построения для навигации
  /// [objectName] - название объекта для которого запрашивается информация
  void _onLearnMore(BuildContext context, String objectName) {
    // Навигация на детальный экран объекта
    // В будущем можно реализовать переход на экран с подробной информацией
    print('Узнать больше: $objectName');
  }
}