// lib/map/map_screen.dart
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../widgets/route_card.dart';
import '../widgets/settings_panel.dart';
import 'route_data.dart';
import 'map_object_manager.dart';
import 'camera_manager.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController mapController;
  bool isMapCreated = false;
  bool _showSettings = false;
  
  late MapObjectManager _mapObjectManager;
  late CameraManager _cameraManager;

  @override
  void initState() {
    super.initState();
    _mapObjectManager = MapObjectManager();
  }

  void _setInitialCameraPosition() {
    if (isMapCreated) {
      _cameraManager.setInitialCameraPosition();
    }
  }

  void _showRoute(String routeName) {
    final routeData = RouteManager.getRoute(routeName);
    if (routeData == null) return;

    setState(() {
      _mapObjectManager.showRoute(routeName, routeData);
    });
    
    final allPoints = _mapObjectManager.getAllPoints(routeName, routeData);
    if (allPoints.length > 1) {
      _cameraManager.zoomToPoints(allPoints);
    }
  }

  void _clearMap() {
    setState(() {
      _mapObjectManager.clearMap();
    });
    _setInitialCameraPosition();
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
                _cameraManager = CameraManager(mapController);
                isMapCreated = true;
                _setInitialCameraPosition();
                print("Yandex Map Created and initial position set");
              },
              mapObjects: _mapObjectManager.mapObjects,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
          
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
                  _buildRouteCard('bagulov'),
                  _buildRouteCard('green'),
                  _buildRouteCard('decabristov'),
                  _buildRouteCard('red'),
                ],
              ),
            ),
          ),
          
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

          if (_mapObjectManager.currentRoute != null && !_showSettings)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: FloatingActionButton.small(
                heroTag: "clear_button",
                backgroundColor: Colors.white,
                onPressed: _clearMap,
                child: const Icon(Icons.clear, color: Color(0xFF2E2E2E)),
              ),
            ),

          if (_showSettings)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SettingsPanel(
                onClose: _closeSettings,
                onClearRoutes: _clearMap,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(String routeName) {
    final routeData = RouteManager.getRoute(routeName);
    if (routeData == null) return const SizedBox();

    return RouteCard(
      title: routeData.name,
      subtitle: _getRouteSubtitle(routeName),
      backgroundImage: routeData.backgroundImage,
      gradientColor: routeData.color,
      onTap: () => _showRoute(routeName),
    );
  }

  String _getRouteSubtitle(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return "Путешествие в прошлое столицы Забайкалья";
      case 'green':
        return "Погрузитесь в уникальную архитекрутру города Чита";
      case 'decabristov':
        return "Узнайте историю жизни забайкальских декабристов";
      case 'red':
        return "Погрузитесь в события визита Мао Цзедуна в столицу Забайкалья";
      default:
        return "";
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}