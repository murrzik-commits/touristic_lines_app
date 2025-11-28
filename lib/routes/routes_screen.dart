// lib/routes/routes_screen.dart (вариант с SafeArea)
import 'package:flutter/material.dart';
import '../widgets/large_route_card.dart';
import '../services/route_service.dart';
import 'route_detail_screen.dart';

/// Экран со списком всех доступных маршрутов
/// Отображает карточки маршрутов с возможностью перехода к детальной информации
class RoutesScreen extends StatelessWidget {
  /// Колбэк функция, вызываемая при нажатии на карточку маршрута
  /// Передает название маршрута для отображения детальной информации
  final Function(String) onRouteTap;

  /// Конструктор класса RoutesScreen
  /// 
  /// Аргументы:
  /// [onRouteTap] - функция обратного вызова при выборе маршрута
  const RoutesScreen({super.key, required this.onRouteTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// Заголовок экрана "Маршруты"
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16, // Отступ с учетом статус-бара
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Text(
              'Маршруты',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E2E2E),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          /// Список маршрутов с отступом для нижней навигационной панели
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16), // Отступ снизу 100px для навигации
              child: ListView(
                children: RouteService.getAllRouteNames().map((routeName) {
                  /// Создание карточки для каждого маршрута
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16), // Отступ между карточками
                    child: LargeRouteCard(
                      routeName: routeName,
                      onLearnMore: () => onRouteTap(routeName), // Передаем колбэк при нажатии "Узнать больше"
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}