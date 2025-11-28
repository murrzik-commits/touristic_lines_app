// lib/map/camera_manager.dart
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Менеджер для управления камерой и навигацией на Яндекс Карте
/// Обеспечивает перемещение камеры, масштабирование и анимации
class CameraManager {
  /// Контроллер Яндекс Карты для управления отображением
  final YandexMapController mapController;

  /// Конструктор класса CameraManager
  /// 
  /// Аргументы:
  /// [mapController] - контроллер карты для выполнения операций с камерой
  CameraManager(this.mapController);

  /// Перемещение камеры к указанной точке (обычно текущее местоположение)
  /// 
  /// Аргументы:
  /// [point] - целевая точка на карте (широта и долгота)
  /// [zoom] - уровень масштабирования (по умолчанию 15.0)
  Future<void> moveToCurrentLocation(Point point, {double zoom = 15.0}) async {
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: zoom,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,  // Плавная анимация
        duration: 1.5,                  // Длительность 1.5 секунды
      ),
    );
  }

  /*
  // Закомментированный метод для добавления маркера текущего местоположения
  /// Добавляет маркер пользователя на карту
  /// 
  /// Аргументы:
  /// [point] - точка для размещения маркера
  Future<void> addUserLocationMarker(Point point) async {
    await mapController.addPlacemark(Placemark(
      point: point,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/icons/user_location.png'),
          scale: 0.5,
        ),
      ),
    ));
  }
  */

  /// Устанавливает начальную позицию камеры при загрузке карты
  /// Позиция по умолчанию: Чита (52.0311, 113.4958)
  Future<void> setInitialCameraPosition() async {
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: 52.0311, longitude: 113.4958), // Чита
          zoom: 13,     // Уровень масштабирования
          tilt: 30,     // Наклон камеры (3D-вид)
          azimuth: 0,   // Азимут (направление взгляда)
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,  // Плавная анимация
        duration: 1,                    // Длительность 1 секунда
      ),
    );
  }

  /// Масштабирует и перемещает камеру чтобы показать все точки в списке
  /// Автоматически вычисляет bounding box и подбирает оптимальный zoom
  /// 
  /// Аргументы:
  /// [points] - список точек для отображения на карте
  Future<void> zoomToPoints(List<Point> points) async {
    if (points.isEmpty) return;
    
    // Вычисление минимальных и максимальных координат
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

    // Вычисление центральной точки
    final centerLat = (minLat + maxLat) / 2;
    final centerLon = (minLon + maxLon) / 2;

    // Вычисление дельт координат
    final latDelta = maxLat - minLat;
    final lonDelta = maxLon - minLon;
    final maxDelta = latDelta > lonDelta ? latDelta : lonDelta;
    
    // Подбор оптимального уровня масштабирования в зависимости от области
    double zoomLevel;
    if (maxDelta < 0.01) {
      zoomLevel = 16.0; // Очень близкий zoom для маленьких областей
    } else if (maxDelta < 0.02) {
      zoomLevel = 15.0; // Близкий zoom
    } else if (maxDelta < 0.05) {
      zoomLevel = 14.0; // Средний zoom
    } else {
      zoomLevel = 13.0; // Широкий zoom для больших областей
    }
    
    // Перемещение камеры к вычисленной позиции
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

  /// Дублирующий метод для масштабирования ко всем точкам
  /// Функциональность идентична zoomToPoints, возможно для разных сценариев использования
  /// 
  /// Аргументы:
  /// [points] - список точек для отображения на карте
  Future<void> zoomToAllPoints(List<Point> points) async {
    if (points.isEmpty) return;
    
    // Вычисление bounding box (аналогично zoomToPoints)
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

    // Вычисление центра
    final centerLat = (minLat + maxLat) / 2;
    final centerLon = (minLon + maxLon) / 2;

    // Вычисление дельт и максимальной дельты
    final latDelta = maxLat - minLat;
    final lonDelta = maxLon - minLon;
    final maxDelta = latDelta > lonDelta ? latDelta : lonDelta;
    
    // Подбор уровня масштабирования
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
    
    // Перемещение камеры
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