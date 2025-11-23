import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../widgets/route_card.dart';
import '../widgets/settings_panel.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController mapController;
  bool isMapCreated = false;
  bool _showSettings = false;

  void _setInitialCameraPosition() {
    if (isMapCreated) {
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: 52.0311,
              longitude: 113.4958,
            ),
            zoom: 12,
            tilt: 30,
            azimuth: 0,
          ),
        ),
        animation: const MapAnimation(
          type: MapAnimationType.smooth,
          duration: 1,
        ),
      );
    }
  }

  void _openSettings() {
    setState(() {
      _showSettings = true;
    });
  }

  void _closeSettings() {
    setState(() {
      _showSettings = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned.fill(
            child: YandexMap(
              onMapCreated: (YandexMapController controller) {
                mapController = controller;
                isMapCreated = true;
                _setInitialCameraPosition();
                print("Yandex Map Created and initial position set");
              },
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
          
          // Карточки маршрутов поверх карты
          // В части с карточками маршрутов замените на:
          Positioned(
            left: 0,
            right: 0,
            height: 150,
            bottom: 90,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                RouteCard(
                  title: "Багулова линия", 
                  subtitle: "Путешествие в прошлое столицы Забайкалья",
                  backgroundImage: 'assets/Icons/Bagulov_street.jpg',
                  gradientColor: const Color(0xFF9C27B0), // Красивый фиолетовый
                ),
                RouteCard(
                  title: "Зеленая линия",
                  subtitle: "Погрузитесь в уникальную архитекрутру города Чита",
                  backgroundImage: 'assets/Icons/Green_street.jpg',
                  gradientColor: const Color(0xFF4CAF50), // Красивый зеленый
                ),
                  RouteCard(
                  title: "Квартал Декабристов",
                  subtitle: "Узнайте историю жизни забайкальских декабристов", 
                  backgroundImage: 'assets/Icons/Decabristov_street.jpg',
                  gradientColor: const Color(0x8b4513), // Красивый синий
                ),
                RouteCard(
                  title: "Красная улица",
                  subtitle: "Погрузитесь в события визита Мао Цзедуна в столицу Забайкалья",
                  backgroundImage: 'assets/Icons/Red_street.jpg',
                  gradientColor: const Color(0xFFF44336), // Красивый красный
                ),
                ],
              ),
            ),
          ),
          
          // КНОПКА НАСТРОЕК (ПОКАЗЫВАЕТСЯ ТОЛЬКО КОГДА НАСТРОЙКИ ЗАКРЫТЫ)
          if (!_showSettings)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: FloatingActionButton.small(
                heroTag: "settings_button",
                backgroundColor: Colors.white,
                onPressed: _openSettings,
                child: const Icon(Icons.settings, color: Color(0xFF2E2E2E)),
              ),
            ),

          // ВЫДВИЖНОЙ ВИДЖЕТ НАСТРОЕК СПРАВА
          if (_showSettings)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SettingsPanel(onClose: _closeSettings),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}