// lib/services/route_service.dart
import 'package:flutter/material.dart';
import '../map/route_data.dart';

/// Сервис для работы с данными маршрутов
/// Предоставляет унифицированный интерфейс для получения информации о маршрутах
class RouteService {
  
  /// Получает список всех идентификаторов доступных маршрутов
  /// 
  /// Возвращает:
  /// [List<String>] - список идентификаторов маршрутов
  static List<String> getAllRouteNames() {
    return ['bagulov', 'green', 'decabristov', 'red'];
  }

  /// Получает подзаголовок (краткое описание) для маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута
  /// 
  /// Возвращает:
  /// [String] - подзаголовок маршрута
  static String getRouteSubtitle(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return "Путешествие в прошлое столицы Забайкалья";
      case 'green':
        return "Погрузитесь в уникальную архитектуру города Чита";
      case 'decabristov':
        return "Узнайте историю жизни забайкальских декабристов";
      case 'red':
        return "Погрузитесь в события визита Мао Цзедуна в столицу Забайкалья";
      default:
        return "";
    }
  }

  /// Получает полные данные маршрута включая точки и линии
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута
  /// 
  /// Возвращает:
  /// [RouteData?] - данные маршрута или null если не найден
  static RouteData? getRouteData(String routeName) {
    return RouteManager.getRoute(routeName);
  }

  /// Получает человеко-читаемое название маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута
  /// 
  /// Возвращает:
  /// [String] - отображаемое название маршрута
  static String getRouteTitle(String routeName) {
    switch (routeName) {
      case 'bagulov': return "Багулова линия";
      case 'green': return "Зеленая линия";
      case 'decabristov': return "Квартал Декабристов";
      case 'red': return "Красная улица";
      default: return "Маршрут";
    }
  }

  /// Получает цвет маршрута для визуального выделения
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута
  /// 
  /// Возвращает:
  /// [Color] - цвет маршрута
  static Color getRouteColor(String routeName) {
    switch (routeName) {
      case 'bagulov': return const Color(0xFF9C27B0); // Фиолетовый
      case 'green': return const Color(0xFF4CAF50);   // Зеленый
      case 'decabristov': return const Color(0x8b451300); // Коричневый
      case 'red': return const Color(0xFFF44336);     // Красный
      default: return const Color(0xFF2E2E2E);        // Серый по умолчанию
    }
  }

  /// Получает полное текстовое описание маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута
  /// 
  /// Возвращает:
  /// [String] - подробное описание маршрута
  static String getRouteFullDescription(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return 'Здравствуй дорогой друг! Сегодня тебе предстоит совершить небольшое путешествие в прошлое столицы Забайкалья и не только! Ведь в истории Читы нашло отражение истории всей нашей России! Наш маршрут мы назвали «Багуловая линия», потому что невзрачный на первый взгляд Рододендрон Даурский, в просторечии называемый «багульник» раз в год производит настоящий фурор, покрывая окрестные сопки лиловым, розовым, малиновым цветом. Надеемся и наш «багуловый» маршрут заставит тебя удивиться, восхититься и по-новому взглянуть на Читу.';
      case 'green':
        return 'Добро пожаловать на Зеленую линию! Этот маршрут проведет вас по самым красивым архитектурным памятникам города, сохранившим дух эпохи модерна и классицизма.';
      case 'decabristov':
        return 'Маршрут посвящен истории декабристов - дворянских революционеров, сосланных в Забайкалье после восстания 1825 года. Узнайте о их жизни и вкладе в развитие региона.';
      case 'red':
        return 'Красная линия рассказывает о советском периоде истории Читы, визите Мао Цзедуна и развитии советско-китайских отношений в середине XX века.';
      default:
        return 'Интересный маршрут по историческим местам города с богатой историей и архитектурой.';
    }
  }

  /// Получает данные изображений для галереи маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута
  /// 
  /// Возвращает:
  /// [List<Map<String, String>>] - список объектов с путями к изображениям и подписями
  static List<Map<String, String>> getRouteImageData(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return [
          {'image': 'assets/objects/post_office.jpg', 'label': '1. Здание почты и телеграфа'},
          {'image': 'assets/objects/polutovski.jpg', 'label': '2. Полутовский дворец'},
          {'image': 'assets/objects/missionerskoe.jpg', 'label': '3. Миссионерское училище'},
          {'image': 'assets/objects/ODORA.jpg', 'label': '4. ОДОРА'},
          {'image': 'assets/objects/beketov.jpg', 'label': '5. Памятник П.И. Бекетову'},
          {'image': 'assets/objects/shumovih.jpg', 'label': '6. Дворец Шумовых'},
          {'image': 'assets/objects/polutovski.jpg', 'label': '7. Полутовский дворец'},
          {'image': 'assets/objects/passaj.jpg', 'label': '8. Второвский Пассаж'},
          {'image': 'assets/objects/berguta.jpg', 'label': '9. Дом М.А. Бергута'},
          {'image': 'assets/objects/teatralnaia.jpg', 'label': '10. Театральная площадь'},
          {'image': 'assets/objects/gosbank.jpg', 'label': '11. Госбанк'},
          {'image': 'assets/objects/gubernatora.jpg', 'label': '12. Дом гражданского губернатора'},
          {'image': 'assets/objects/kafedralnii.jpg', 'label': '13. Кафедральный собор'},
        ];
      case 'green':
        return [
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '1. Зеленая усадьба'},
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '2. Парк культуры'},
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '3. Архитектурный ансамбль'},
        ];
      case 'decabristov':
        return [
          {'image': 'assets/street_icons/Decabristov_street.jpg', 'label': '1. Дом декабристов'},
          {'image': 'assets/street_icons/Decabristov_street.jpg', 'label': '2. Мемориальный комплекс'},
          {'image': 'assets/street_icons/Decabristov_street.jpg', 'label': '3. Исторический квартал'},
        ];
      case 'red':
        return [
          {'image': 'assets/street_icons/Red_street.jpg', 'label': '1. Площадь революции'},
          {'image': 'assets/street_icons/Red_street.jpg', 'label': '2. Дом советов'},
          {'image': 'assets/street_icons/Red_street.jpg', 'label': '3. Мемориал'},
        ];
      default:
        return [
          {'image': 'assets/street_icons/Bagulov_street.jpg', 'label': '1. Историческое здание'},
          {'image': 'assets/street_icons/Green_street.jpg', 'label': '2. Архитектурный памятник'},
        ];
    }
  }
}