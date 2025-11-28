// lib/widgets/base_route_card.dart
import 'package:flutter/material.dart';
import '../services/route_service.dart';
import '../map/route_data.dart';

/// Абстрактный базовый класс для карточек маршрутов
/// Содержит общую логику и данные для всех типов карточек маршрутов
abstract class BaseRouteCard extends StatelessWidget {
  /// Идентификатор маршрута для загрузки данных
  final String routeName;
  
  /// Колбэк функция, вызываемая при нажатии на карточку
  final VoidCallback? onTap;

  /// Конструктор базового класса карточки маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута для загрузки данных
  /// [onTap] - функция обратного вызова при нажатии на карточку
  const BaseRouteCard({
    super.key,
    required this.routeName,
    this.onTap,
  });

  /// Геттер для получения данных маршрута
  /// 
  /// Возвращает:
  /// [RouteData] - данные маршрута (не null, предполагается что маршрут существует)
  RouteData get routeData => RouteManager.getRoute(routeName)!;
  
  /// Геттер для получения названия маршрута
  /// 
  /// Возвращает:
  /// [String] - человеко-читаемое название маршрута
  String get title => routeData.name;
  
  /// Геттер для получения подзаголовка маршрута
  /// 
  /// Возвращает:
  /// [String] - краткое описание маршрута
  String get subtitle => RouteService.getRouteSubtitle(routeName);
  
  /// Геттер для получения пути к фоновому изображению
  /// 
  /// Возвращает:
  /// [String] - путь к asset-файлу фонового изображения
  String get backgroundImage => routeData.backgroundImage;
  
  /// Геттер для получения цвета маршрута
  /// 
  /// Возвращает:
  /// [Color] - цвет маршрута для градиентов и акцентов
  Color get gradientColor => routeData.color;

  /// Абстрактный метод для построения содержимого карточки
  /// Должен быть реализован в производных классах
  /// 
  /// Аргументы:
  /// [context] - контекст построения виджета
  /// 
  /// Возвращает:
  /// [Widget] - виджет с содержимым карточки
  @protected
  Widget buildContent(BuildContext context);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Обработчик нажатия переданный извне
      child: buildContent(context), // Вызов абстрактного метода для построения содержимого
    );
  }
}