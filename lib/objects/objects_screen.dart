// lib/objects/objects_screen.dart
import 'package:flutter/material.dart';
import '../widgets/object_card.dart';
import '../services/route_service.dart';

class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Заголовок
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
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
          
          // Список объектов с отступом для навигационной панели
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
              child: ListView(
                children: [
                  ObjectCard(
                    imagePath: 'assets/objects/post_office.jpg',
                    title: 'Здание почты и телеграфа',
                    tag: 'Багулова линия',
                    description: 'Здание было возведено в 1893 году по проекту архитектора М.Ю. Арнольда специально для почтово-телеграфной конторы.',
                    onLearnMore: () => _onLearnMore(context, 'Здание почты и телеграфа'),
                    tagColor: RouteService.getRouteColor('bagulov'),
                  ),
                  
                  ObjectCard(
                    imagePath: 'assets/objects/polugov_palace.jpg',
                    title: 'Полуговский дворец',
                    tag: 'Багулова линия',
                    description: 'Архитектурная жемчужина Полуговского квартала – трёхэтажный доходный дом Полугова на улице Софийской.',
                    onLearnMore: () => _onLearnMore(context, 'Полуговский дворец'),
                    tagColor: RouteService.getRouteColor('bagulov'),
                  ),
                  
                  ObjectCard(
                    imagePath: 'assets/objects/mission_school.jpg',
                    title: 'Миссионерское училище',
                    tag: 'Багулова линия',
                    description: 'Архиерейский дом и храм был основан 26 сентября 1884 года в честь памяти святого апостола Андрея Первозванного и святителя Иннокентия.',
                    onLearnMore: () => _onLearnMore(context, 'Миссионерское училище'),
                    tagColor: RouteService.getRouteColor('bagulov'),
                  ),
                  
                  ObjectCard(
                    imagePath: 'assets/objects/green_estate.jpg',
                    title: 'Зеленая усадьба',
                    tag: 'Зеленая линия',
                    description: 'Историческая усадьба в стиле классицизма с сохранившимися элементами оригинальной отделки.',
                    onLearnMore: () => _onLearnMore(context, 'Зеленая усадьба'),
                    tagColor: RouteService.getRouteColor('green'),
                  ),
                  
                  ObjectCard(
                    imagePath: 'assets/objects/decembrist_house.jpg',
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

  void _onLearnMore(BuildContext context, String objectName) {
    // Навигация на детальный экран объекта
    print('Узнать больше: $objectName');
  }
}