// lib/routes/routes_screen.dart (вариант с SafeArea)
import 'package:flutter/material.dart';
import '../widgets/large_route_card.dart';
import '../services/route_service.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false, // Не добавляем отступ снизу от SafeArea
        child: Column(
          children: [
            // Заголовок
            Container(
              padding: const EdgeInsets.all(16),
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
            
            // Список маршрутов
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100), // Отступ для навигации
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: RouteService.getAllRouteNames().map((routeName) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LargeRouteCard(
                        routeName: routeName,
                        onLearnMore: () => _onLearnMore(context, routeName),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLearnMore(BuildContext context, String routeName) {
    print('Learn more: $routeName');
  }
}