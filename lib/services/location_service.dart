// lib/services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Сервис для работы с геолокацией пользователя
/// Обеспечивает получение разрешений, текущей позиции и отслеживание перемещений
class LocationService {
  
  /// Проверка и запрос разрешений на доступ к геолокации
  /// 
  /// Возвращает:
  /// [Future<bool>] - true если разрешение получено, false если доступ запрещен
  static Future<bool> checkAndRequestPermissions() async {
    // Проверка текущего статуса разрешения
    LocationPermission permission = await Geolocator.checkPermission();
    
    // Если разрешение не предоставлено - запрашиваем его
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    
    // Если пользователь навсегда запретил доступ к геолокации
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    
    // Возвращаем true если разрешение получено (во время использования или всегда)
    return permission == LocationPermission.whileInUse || 
           permission == LocationPermission.always;
  }

  /// Получение текущей позиции пользователя
  /// 
  /// Возвращает:
  /// [Future<Position?>] - текущая позиция или null при ошибке/отсутствии разрешений
  static Future<Position?> getCurrentPosition() async {
    try {
      // Проверяем и запрашиваем разрешения
      bool hasPermission = await checkAndRequestPermissions();
      if (!hasPermission) return null;

      // Получаем текущую позицию с максимальной точностью
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print('Ошибка получения геолокации: $e');
      return null;
    }
  }

  /// Преобразование объекта Position из geolocator в Point для Яндекс Карт
  /// 
  /// Аргументы:
  /// [position] - позиция из пакета geolocator
  /// 
  /// Возвращает:
  /// [Point] - точка для использования в Яндекс Картах
  static Point positionToPoint(Position position) {
    return Point(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  /// Получение текущей позиции в формате Point для Яндекс Карт
  /// 
  /// Возвращает:
  /// [Future<Point?>] - текущая позиция как Point или null при ошибке
  static Future<Point?> getCurrentPoint() async {
    final position = await getCurrentPosition();
    if (position == null) return null;
    
    return positionToPoint(position);
  }

  /// Создание потока для отслеживания обновлений местоположения
  /// 
  /// Возвращает:
  /// [Stream<Position>] - поток обновлений позиции пользователя
  static Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,     // Максимальная точность
        distanceFilter: 10,                  // Обновлять каждые 10 метров перемещения
      ),
    );
  }
}