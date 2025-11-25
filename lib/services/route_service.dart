// lib/services/route_service.dart
import 'package:flutter/material.dart';
import '../map/route_data.dart';

class RouteService {
  static List<String> getAllRouteNames() {
    return ['bagulov', 'green', 'decabristov', 'red'];
  }

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

  static String getRouteDescription(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return "Исторический маршрут по старинным улочкам города с посещением архитектурных памятников XVIII-XIX веков.";
      case 'green':
        return "Архитектурный тур по самым красивым зданиям в стиле модерн и классицизм.";
      case 'decabristov':
        return "Маршрут посвященный истории декабристов, их жизни и деятельности в Забайкалье.";
      case 'red':
        return "Исторический маршрут, связанный с визитом Мао Цзедуна и советско-китайскими отношениями.";
      default:
        return "Интересный маршрут по историческим местам города.";
    }
  }
    static Color getRouteColor(String routeName) {
    switch (routeName) {
      case 'bagulov':
        return const Color(0xFF9C27B0);
      case 'green':
        return const Color(0xFF4CAF50);
      case 'decabristov':
        return const Color(0x8B4513);
      case 'red':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF2E2E2E);
    }
  }
  static RouteData? getRouteData(String routeName) {
    return RouteManager.getRoute(routeName);
  }
}