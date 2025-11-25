// lib/map/map_screen.dart
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../widgets/small_route_card.dart';
import '../widgets/settings_panel.dart';
import '../widgets/route_info_panel.dart';
import 'map_object_manager.dart';
import 'camera_manager.dart';
import '../services/route_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController mapController;
  bool isMapCreated = false;
  bool _showSettings = false;
  String? _selectedRoute;
  bool _showRouteInfo = false;

  late MapObjectManager _mapObjectManager;
  late CameraManager _cameraManager;

  @override
  void initState() {
    super.initState();
    _mapObjectManager = MapObjectManager();
  }

  void _showAllLines() {
    setState(() {
      _mapObjectManager.showAllLines();
      _selectedRoute = null;
      _showRouteInfo = false;
    });
    
    final allPoints = _mapObjectManager.getAllRoutesPoints();
    if (allPoints.isNotEmpty) {
      _cameraManager.zoomToAllPoints(allPoints);
    } else if (isMapCreated) {
      _cameraManager.setInitialCameraPosition();
    }
  }

  void _showRoute(String routeName) {
    final routeData = RouteService.getRouteData(routeName);
    if (routeData == null) return;

    setState(() {
      _mapObjectManager.showRoute(routeName, routeData);
      _selectedRoute = routeName;
      _showRouteInfo = true;
    });
    
    final allPoints = _mapObjectManager.getAllPoints(routeName, routeData);
    if (allPoints.length > 1) {
      _cameraManager.zoomToPoints(allPoints);
    }
  }

  void _closeRouteInfo() {
    setState(() {
      _showRouteInfo = false;
      _selectedRoute = null;
    });
    _showAllLines();
  }

  void _startTour() {
    print("Начинаем тур по маршруту: $_selectedRoute");
    _closeRouteInfo();
  }

  void _clearMap() {
    setState(() {
      _mapObjectManager.clearMap();
    });
    _cameraManager.setInitialCameraPosition();
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
                _showAllLines();
              },
              mapObjects: _mapObjectManager.mapObjects,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
          
          // Карточки маршрутов
          if (!_showRouteInfo) 
            Positioned(
              left: 0, right: 0, height: 150, bottom: 90,
              child: _buildRouteCards(),
            ),
          
          // Панель информации о маршруте
          if (_showRouteInfo && _selectedRoute != null)
            Positioned(
              left: 0, right: 0, bottom: 60,
              child: RouteInfoPanel(
                routeName: _selectedRoute!,
                onStartTour: _startTour,
                onClose: _closeRouteInfo,
              ),
            ),
          
          // Кнопка настроек
          if (!_showSettings && !_showRouteInfo) 
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

          // Кнопка очистки маршрута
          if (_mapObjectManager.currentRoute != null && !_showSettings && !_showRouteInfo) 
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

          // Панель настроек
          if (_showSettings)
            Positioned(
              right: 0, top: 0, bottom: 0,
              child: SettingsPanel(
                onClose: _closeSettings,
                onClearRoutes: _clearMap,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRouteCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: RouteService.getAllRouteNames().map((routeName) {
          return Padding(
            padding: const EdgeInsets.only(right: 3),
            child: SmallRouteCard(
              routeName: routeName,
              onTap: () => _showRoute(routeName),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}