// lib/map/camera_manager.dart
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CameraManager {
  final YandexMapController mapController;

  CameraManager(this.mapController);

  Future<void> setInitialCameraPosition() async {
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: 52.0311, longitude: 113.4958),
          zoom: 13, 
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

  Future<void> zoomToPoints(List<Point> points) async {
    if (points.isEmpty) return;
    
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLon = points.first.longitude;
    double maxLon = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLon) minLon = point.longitude;
      if (point.longitude > maxLon) maxLon = point.longitude;
    }

    final centerLat = (minLat + maxLat) / 2;
    final centerLon = (minLon + maxLon) / 2;

    final latDelta = maxLat - minLat;
    final lonDelta = maxLon - minLon;
    final maxDelta = latDelta > lonDelta ? latDelta : lonDelta;
    
    double zoomLevel;
    if (maxDelta < 0.01) {
      zoomLevel = 16.0; 
    } else if (maxDelta < 0.02) {
      zoomLevel = 15.0;
    } else if (maxDelta < 0.05) {
      zoomLevel = 14.0; 
    } else {
      zoomLevel = 13.0; 
    }
    
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: centerLat, longitude: centerLon),
          zoom: zoomLevel,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 1.5,
      ),
    );
  }
  Future<void> zoomToAllPoints(List<Point> points) async {
    if (points.isEmpty) return;
    
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLon = points.first.longitude;
    double maxLon = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLon) minLon = point.longitude;
      if (point.longitude > maxLon) maxLon = point.longitude;
    }

    final centerLat = (minLat + maxLat) / 2;
    final centerLon = (minLon + maxLon) / 2;

    final latDelta = maxLat - minLat;
    final lonDelta = maxLon - minLon;
    final maxDelta = latDelta > lonDelta ? latDelta : lonDelta;
    
    double zoomLevel;
    if (maxDelta < 0.01) {
      zoomLevel = 16.0;
    } else if (maxDelta < 0.02) {
      zoomLevel = 15.0;
    } else if (maxDelta < 0.05) {
      zoomLevel = 14.0;
    } else {
      zoomLevel = 13.0;
    }
    
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: centerLat, longitude: centerLon),
          zoom: zoomLevel,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 1.5,
      ),
    );
  }

}