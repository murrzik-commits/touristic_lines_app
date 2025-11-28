// lib/map/map_object_manager.dart
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'route_data.dart';

/// Менеджер для управления объектами на карте (метки, линии маршрутов)
/// Обеспечивает отображение маршрутов, точек интереса и их визуализацию
class MapObjectManager {
  /// Список всех объектов на карте
  final List<MapObject> _mapObjects = [];
  
  /// Название текущего отображаемого маршрута (null если отображаются все маршруты)
  String? _currentRoute;

  // Геттеры для доступа к приватным полям

  /// Возвращает список всех объектов карты
  List<MapObject> get mapObjects => _mapObjects;
  
  /// Возвращает название текущего маршрута
  String? get currentRoute => _currentRoute;

  /// Отображает конкретный маршрут на карте
  /// 
  /// Аргументы:
  /// [routeName] - название маршрута для отображения
  /// [routeData] - данные маршрута (точки, линии, цвет)
  void showRoute(String routeName, RouteData routeData) {
    _mapObjects.clear();
    _currentRoute = routeName;
    
    _addPoints(routeName, routeData.points, routeData.color);
    _addLines(routeName, routeData.lines, routeData.color);
  }

  /// Очищает карту от всех объектов
  void clearMap() {
    _mapObjects.clear();
    _currentRoute = null;
  }

  /// Добавляет точки маршрута на карту в виде меток (пинов)
  /// 
  /// Аргументы:
  /// [routeName] - название маршрута
  /// [points] - список точек для отображения
  /// [color] - цвет маршрута (не используется в текущей реализации)
  void _addPoints(String routeName, List<Point> points, Color color) {
    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      
      final pin = PlacemarkMapObject(
        mapId: MapObjectId('${routeName}_pin_$i'), // Уникальный ID для каждой метки
        point: point,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(_addPinIcon(routeName)),
            scale: 0.3,      // Масштаб иконки
            anchor: const Offset(0.5, 1.0), // Якорь внизу иконки для точного позиционирования
          ),
        ),
        opacity: 0.9,        // Прозрачность метки
      );
      _mapObjects.add(pin);
    }
  }

  /// Возвращает путь к иконке пина в зависимости от названия маршрута
  /// 
  /// Аргументы:
  /// [routeName] - название маршрута
  /// 
  /// Возвращает:
  /// [String] - путь к asset-файлу иконки
  String _addPinIcon(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return 'assets/icons/bagulova_pin.png';
      case 'green':
        return 'assets/icons/green_pin.png';
      case 'decabristov':
        return 'assets/icons/decabristov_pin.png';
      case 'red':
        return 'assets/icons/red_street_pin.png';
    }
    return 'assets/icons/red_street_pin.png'; // Иконка по умолчанию
  }  

  /// Добавляет линии маршрута на карту
  /// 
  /// Аргументы:
  /// [routeName] - название маршрута
  /// [points] - список точек для построения линии
  /// [color] - цвет линии маршрута
  void _addLines(String routeName, List<Point> points, Color color) {
    if (points.length < 2) return; // Для линии нужно минимум 2 точки

    final polyline = Polyline(points: points);
    
    final polylineObject = PolylineMapObject(
      mapId: MapObjectId('${routeName}_line'), // Уникальный ID для линии
      polyline: polyline,
      strokeColor: color,     // Цвет линии
      strokeWidth: 5,         // Толщина линии
      outlineWidth: 2,        // Толщина обводки
      zIndex: 1,              // Уровень Z для порядка отрисовки
    );
    
    _mapObjects.add(polylineObject);
  }

  /// Показывает все точки всех маршрутов на карте
  /// Используется для общего обзора всех достопримечательностей
  void showAllPoints() {
    _mapObjects.clear();
    _currentRoute = null;
    
    final allRoutes = RouteManager.getRouteNames();
    
    for (final routeName in allRoutes) {
      final routeData = RouteManager.getRoute(routeName);
      if (routeData != null) {
        _addPoints(routeName, routeData.points, routeData.color);
      }
    }
  }

  /// Показывает все линии всех маршрутов на карте
  /// Используется для отображения всех маршрутов одновременно
  void showAllLines() {
    _mapObjects.clear();
    _currentRoute = null;
    
    final allRoutes = RouteManager.getRouteNames();
    
    for (final routeName in allRoutes) {
      final routeData = RouteManager.getRoute(routeName);
      if (routeData != null) {
        _addLines(routeName, routeData.lines, routeData.color);
      }
    }
  }

  /// Получает все уникальные точки всех маршрутов
  /// Используется для масштабирования карты чтобы показать все точки
  /// 
  /// Возвращает:
  /// [List<Point>] - список всех уникальных точек всех маршрутов
  List<Point> getAllRoutesPoints() {
    final allPoints = <Point>[];
    final allRoutes = RouteManager.getRouteNames();
    
    for (final routeName in allRoutes) {
      final routeData = RouteManager.getRoute(routeName);
      if (routeData != null) {
        // Добавляем только уникальные точки из точек интереса
        for (final point in routeData.points) {
          if (!allPoints.any((p) => p.latitude == point.latitude && p.longitude == point.longitude)) {
            allPoints.add(point);
          }
        }
        // Добавляем только уникальные точки из линий маршрута
        for (final point in routeData.lines) {
          if (!allPoints.any((p) => p.latitude == point.latitude && p.longitude == point.longitude)) {
            allPoints.add(point);
          }
        }
      }
    }
    
    return allPoints;
  }

  /// Получает все точки конкретного маршрута (точки интереса + точки линии)
  /// 
  /// Аргументы:
  /// [routeName] - название маршрута
  /// [routeData] - данные маршрута
  /// 
  /// Возвращает:
  /// [List<Point>] - объединенный список всех точек маршрута
  List<Point> getAllPoints(String routeName, RouteData routeData) {
    return <Point>[
      ...routeData.points, // Точки интереса
      ...routeData.lines,  // Точки линии маршрута
    ];
  }
}