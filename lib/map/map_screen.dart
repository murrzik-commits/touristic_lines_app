// lib/map/map_screen.dart
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../widgets/small_route_card.dart';
import '../widgets/settings_panel.dart';
import '../widgets/route_info_panel.dart';
import 'map_object_manager.dart';
import 'camera_manager.dart';
import '../services/route_service.dart';

/// Основной экран карты с отображением маршрутов и управлением
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// Контроллер Яндекс Карты
  late YandexMapController mapController;
  
  /// Флаг инициализации карты
  bool isMapCreated = false;
  
  /// Флаг отображения панели настроек
  bool _showSettings = false;
  
  /// Название выбранного маршрута
  String? _selectedRoute;
  
  /// Флаг отображения информации о маршруте
  bool _showRouteInfo = false;

  /// Менеджер объектов карты (метки, линии)
  late MapObjectManager _mapObjectManager;
  
  /// Менеджер камеры карты (масштабирование, перемещение)
  late CameraManager _cameraManager;

  @override
  void initState() {
    super.initState();
    // Инициализация менеджера объектов карты
    _mapObjectManager = MapObjectManager();
  }

  /// Показывает все линии маршрутов на карте
  /// Используется для общего обзора всех маршрутов
  void _showAllLines() {
    setState(() {
      _mapObjectManager.showAllLines();
      _selectedRoute = null;
      _showRouteInfo = false;
    });
    
    // Масштабирование карты чтобы показать все маршруты
    final allPoints = _mapObjectManager.getAllRoutesPoints();
    if (allPoints.isNotEmpty) {
      _cameraManager.zoomToAllPoints(allPoints);
    } else if (isMapCreated) {
      // Если точек нет - устанавливаем начальную позицию
      _cameraManager.setInitialCameraPosition();
    }
  }

  /// Показывает конкретный маршрут на карте
  /// 
  /// Аргументы:
  /// [routeName] - название маршрута для отображения
  void _showRoute(String routeName) {
    final routeData = RouteService.getRouteData(routeName);
    if (routeData == null) return;

    setState(() {
      _mapObjectManager.showRoute(routeName, routeData);
      _selectedRoute = routeName;
      _showRouteInfo = true;
    });
    
    // Масштабирование карты чтобы показать выбранный маршрут
    final allPoints = _mapObjectManager.getAllPoints(routeName, routeData);
    if (allPoints.length > 1) {
      _cameraManager.zoomToPoints(allPoints);
    }
  }

  /// Закрывает панель информации о маршруте
  /// Возвращает к отображению всех маршрутов
  void _closeRouteInfo() {
    setState(() {
      _showRouteInfo = false;
      _selectedRoute = null;
    });
    _showAllLines();
  }

  /// Запускает тур по выбранному маршруту
  /// В будущем может открывать навигацию или экран гида
  void _startTour() {
    print("Начинаем тур по маршруту: $_selectedRoute");
    _closeRouteInfo();
  }

  /// Очищает карту от всех маршрутов и объектов
  /// Возвращает карту в начальное состояние
  void _clearMap() {
    setState(() {
      _mapObjectManager.clearMap();
    });
    _cameraManager.setInitialCameraPosition();
  }

  /// Открывает панель настроек карты
  void _openSettings() {
    setState(() {
      _showSettings = true;
    });
  }

  /// Закрывает панель настроек карты
  void _closeSettings() {
    setState(() {
      _showSettings = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Скрываем стандартный AppBar
      body: Stack(
        children: [
          /// Основная карта Яндекс
          Positioned.fill(
            child: YandexMap(
              onMapCreated: (YandexMapController controller) {
                mapController = controller;
                _cameraManager = CameraManager(mapController);
                isMapCreated = true;
                _showAllLines(); // Показываем все маршруты при создании карты
              },
              mapObjects: _mapObjectManager.mapObjects, // Объекты для отображения
              zoomGesturesEnabled: true,    // Включено масштабирование
              scrollGesturesEnabled: true,  // Включена прокрутка
              rotateGesturesEnabled: true,  // Включен поворот
              tiltGesturesEnabled: true,    // Включен наклон
            ),
          ),
          
          /// Горизонтальная лента с карточками маршрутов
          /// Показывается когда не открыта информация о маршруте
          if (!_showRouteInfo) 
            Positioned(
              left: 0, right: 0, height: 150, bottom: 90,
              child: _buildRouteCards(),
            ),
          
          /// Панель информации о выбранном маршруте
          /// Показывается когда выбран конкретный маршрут
          if (_showRouteInfo && _selectedRoute != null)
            Positioned(
              left: 0, right: 0, bottom: 60,
              child: RouteInfoPanel(
                routeName: _selectedRoute!,
                onStartTour: _startTour,
                onClose: _closeRouteInfo,
              ),
            ),
          
          /// Кнопка настроек в правом верхнем углу
          /// Скрывается при открытых настройках или информации о маршруте
          if (!_showSettings && !_showRouteInfo) 
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: FloatingActionButton.small(
                heroTag: "settings_button", // Уникальный тег для анимаций
                backgroundColor: Colors.white,
                onPressed: _openSettings,
                child: const Icon(Icons.settings, color: Color(0xFF2E2E2E)),
              ),
            ),

          /// Кнопка очистки карты в левом верхнем углу
          /// Показывается только когда выбран маршрут
          if (_mapObjectManager.currentRoute != null && !_showSettings && !_showRouteInfo) 
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: FloatingActionButton.small(
                heroTag: "clear_button", // Уникальный тег для анимаций
                backgroundColor: Colors.white,
                onPressed: _clearMap,
                child: const Icon(Icons.clear, color: Color(0xFF2E2E2E)),
              ),
            ),

          /// Выдвижная панель настроек
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

  /// Строит горизонтальную ленту с карточками маршрутов
  /// 
  /// Возвращает:
  /// [Widget] - ScrollView с карточками всех доступных маршрутов
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
    /// Освобождение ресурсов контроллера карты
    mapController.dispose();
    super.dispose();
  }
}