// lib/map/map_object_manager.dart
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'route_data.dart';

class MapObjectManager {
  final List<MapObject> _mapObjects = [];
  String? _currentRoute;

  List<MapObject> get mapObjects => _mapObjects;
  String? get currentRoute => _currentRoute;

  void showRoute(String routeName, RouteData routeData) {
    _mapObjects.clear();
    _currentRoute = routeName;
    
    _addPoints(routeName, routeData.points, routeData.color);
    _addLines(routeName, routeData.lines, routeData.color);
  }

  void clearMap() {
    _mapObjects.clear();
    _currentRoute = null;
  }

  void _addPoints(String routeName, List<Point> points, Color color) {
    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      
      final pin = PlacemarkMapObject(
        mapId: MapObjectId('${routeName}_pin_$i'),
        point: point,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(_addPinIcon(routeName)),
            scale: 0.2,
            anchor: const Offset(0.5, 1.0),
          ),
        ),
        opacity: 0.9,
      );
      _mapObjects.add(pin);
    }
  }

  String _addPinIcon(String routeName)
  {
    switch (routeName) {
      case 'bagulov':
        return 'assets/icons/bagulova_line_pin.png';
      case 'green':
        return 'assets/icons/green_street_pin.png';
      case 'decabristov':
        return 'assets/icons/decabristov_street_pin.png';
      case 'red':
        return 'assets/icons/red_street_pin.png';
    }
    return 'assets/icons/ic_pin.png';
  }  
  void _addLines(String routeName, List<Point> points, Color color) {
    if (points.length < 2) return;

    final polyline = Polyline(points: points);
    
    final polylineObject = PolylineMapObject(
      mapId: MapObjectId('${routeName}_line'),
      polyline: polyline,
      strokeColor: color,
      strokeWidth: 5,
      outlineColor: Colors.black,
      outlineWidth: 2,
      zIndex: 1,
    );
    
    _mapObjects.add(polylineObject);
  }

  List<Point> getAllPoints(String routeName, RouteData routeData) {
    return <Point>[
      ...routeData.points,
      ...routeData.lines,
    ];
  }
}