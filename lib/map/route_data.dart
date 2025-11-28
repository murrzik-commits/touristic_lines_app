// lib/map/route_data.dart
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Класс данных маршрута для хранения информации о туристических маршрутах
/// Содержит точки интереса, линии маршрута, цвет и изображение фона
class RouteData {
  /// Название маршрута для отображения пользователю
  final String name;
  
  /// Список точек интереса на маршруте (достопримечательности, объекты)
  final List<Point> points;
  
  /// Список точек для построения линии маршрута (путь следования)
  final List<Point> lines;
  
  /// Цвет маршрута для отображения на карте
  final Color color;
  
  /// Путь к фоновому изображению для карточки маршрута
  final String backgroundImage;

  /// Конструктор класса RouteData
  /// 
  /// Аргументы:
  /// [name] - человеко-читаемое название маршрута
  /// [points] - точки интереса (метки на карте)
  /// [lines] - точки для построения линии маршрута
  /// [color] - цвет для визуализации маршрута
  /// [backgroundImage] - путь к изображению для фона карточки
  const RouteData({
    required this.name,
    required this.points,
    required this.lines,
    required this.color,
    required this.backgroundImage,
  });
}

/// Менеджер для работы с данными маршрутов
/// Предоставляет доступ к предопределенным маршрутам города
class RouteManager {
  /// Статическая карта всех доступных маршрутов
  /// Ключ - идентификатор маршрута, Значение - данные маршрута
  static final Map<String, RouteData> _routes = {
    'bagulov': RouteData(
      name: "Багулова линия",
      points: [
        Point(latitude: 52.033735, longitude: 113.498426),
        Point(latitude: 52.034328, longitude: 113.499369),
        Point(latitude: 52.035059, longitude: 113.501076),
        Point(latitude: 52.032333, longitude: 113.504939),
        Point(latitude: 52.031504, longitude: 113.505065),
        Point(latitude: 52.031347, longitude: 113.506996),
        Point(latitude: 52.028194, longitude: 113.504993),
        Point(latitude: 52.030006, longitude: 113.501930),
        Point(latitude: 52.030880, longitude: 113.503550),
        Point(latitude: 52.030993, longitude: 113.501435),
        Point(latitude: 52.030760, longitude: 113.499441),
        Point(latitude: 52.030028, longitude: 113.497159),
      ],
      lines: [
        Point(latitude: 52.031116, longitude: 113.496326),
        Point(latitude: 52.034998, longitude: 113.500261),
        Point(latitude: 52.033927, longitude: 113.503049),
        Point(latitude: 52.033099, longitude: 113.502237),
        Point(latitude: 52.031091, longitude: 113.507347),
        Point(latitude: 52.029076, longitude: 113.505239),
        Point(latitude: 52.031043, longitude: 113.500077),
        Point(latitude: 52.030046, longitude: 113.499046),
        Point(latitude: 52.031116, longitude: 113.496326),
      ],
      color: Color(0xFF9C27B0), // Фиолетовый цвет
      backgroundImage: 'assets/street_icons/Bagulov_street.jpg',
    ),
    'green': RouteData(
      name: "Зеленая линия",
      points: [
        Point(latitude: 52.028416, longitude: 113.508254),
        Point(latitude: 52.028538, longitude: 113.507014),
        Point(latitude: 52.028205, longitude: 113.506628),
        Point(latitude: 52.029286, longitude: 113.506026),
        Point(latitude: 52.028194, longitude: 113.504993),
        Point(latitude: 52.028244, longitude: 113.507535),
        Point(latitude: 52.029142, longitude: 113.501732),
        Point(latitude: 52.028255, longitude: 113.500043),
        Point(latitude: 52.028288, longitude: 113.502055),
        Point(latitude: 52.027513, longitude: 113.504346),
        Point(latitude: 52.026997, longitude: 113.505900),
        Point(latitude: 52.026964, longitude: 113.507625),
        Point(latitude: 52.025451, longitude: 113.509808),
        Point(latitude: 52.023970, longitude: 113.508685),
        Point(latitude: 52.024151, longitude: 113.512693),
        Point(latitude: 52.023113, longitude: 113.513679),
        Point(latitude: 52.022215, longitude: 113.512063),
        Point(latitude: 52.021483, longitude: 113.513149),
      ],
      lines: [
        Point(latitude: 52.027974, longitude: 113.507971),
        Point(latitude: 52.029959, longitude: 113.502811),
        Point(latitude: 52.028943, longitude: 113.501785),
        Point(latitude: 52.024670, longitude: 113.512662),
        Point(latitude: 52.024437, longitude: 113.512411),
        Point(latitude: 52.023869, longitude: 113.513010),
        Point(latitude: 52.021759, longitude: 113.513634),
        Point(latitude: 52.021428, longitude: 113.513378),
      ],
      color: Color(0xFF4CAF50), // Зеленый цвет
      backgroundImage: 'assets/street_icons/Green_street.jpg',
    ),
    'decabristov': RouteData(
      name: "Квартал Декабристов",
      points: [
        Point(latitude: 52.024151, longitude: 113.512693),
        Point(latitude: 52.021548, longitude: 113.511790),
        Point(latitude: 52.022215, longitude: 113.512063),
        Point(latitude: 52.021483, longitude: 113.513149),
      ],
      lines: [
        Point(latitude: 52.024303, longitude: 113.512169),
        Point(latitude: 52.022489, longitude: 113.510232),
        Point(latitude: 52.022125, longitude: 113.510171),
        Point(latitude: 52.021763, longitude: 113.510569),
        Point(latitude: 52.022106, longitude: 113.513677),
        Point(latitude: 52.021734, longitude: 113.513794),
        Point(latitude: 52.021567, longitude: 113.513126),
      ],
      color: Color(0x8b451300), // Коричневый цвет
      backgroundImage: 'assets/street_icons/Decabristov_street.jpg',
    ),
    'red': RouteData(
      name: "Красная улица",
      points: [
        Point(latitude: 52.028366, longitude: 113.495057),
        Point(latitude: 52.028194, longitude: 113.504993),
        Point(latitude: 52.032333, longitude: 113.504939),
        Point(latitude: 52.035907, longitude: 113.507966),
        Point(latitude: 52.035907, longitude: 113.507966),
        Point(latitude: 52.033685, longitude: 113.501158),
        Point(latitude: 52.038134, longitude: 113.490159),
        Point(latitude: 52.049898, longitude: 113.473533),
        Point(latitude: 52.034092, longitude: 113.522589),
      ],
      lines: [
        Point(latitude: 52.028627, longitude: 113.495721),
        Point(latitude: 52.027976, longitude: 113.497303),
        Point(latitude: 52.029721, longitude: 113.499158),
        Point(latitude: 52.027723, longitude: 113.504247),
        Point(latitude: 52.030968, longitude: 113.507603),
        Point(latitude: 52.031776, longitude: 113.505632),
        Point(latitude: 52.035665, longitude: 113.509562),
        Point(latitude: 52.036953, longitude: 113.506290),
        Point(latitude: 52.034083, longitude: 113.503295),
        Point(latitude: 52.038407, longitude: 113.492237),
        Point(latitude: 52.037394, longitude: 113.491152),
        Point(latitude: 52.038419, longitude: 113.488561),
        Point(latitude: 52.042539, longitude: 113.477969),
        Point(latitude: 52.044218, longitude: 113.470286),
        Point(latitude: 52.049971, longitude: 113.473497),
      ],
      color: Color(0xFFF44336), // Красный цвет
      backgroundImage: 'assets/street_icons/Red_street.jpg',
    ),
  };

  /// Получает данные маршрута по его идентификатору
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута (bagulov, green, decabristov, red)
  /// 
  /// Возвращает:
  /// [RouteData?] - данные маршрута или null если маршрут не найден
  static RouteData? getRoute(String routeName) {
    return _routes[routeName];
  }

  /// Получает список всех идентификаторов маршрутов
  /// 
  /// Возвращает:
  /// [List<String>] - список идентификаторов доступных маршрутов
  static List<String> getRouteNames() {
    return _routes.keys.toList();
  }

  /// Получает копию карты всех маршрутов
  /// 
  /// Возвращает:
  /// [Map<String, RouteData>] - копия карты всех маршрутов
  static Map<String, RouteData> getAllRoutes() {
    return Map.from(_routes);
  }
}