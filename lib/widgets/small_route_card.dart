// lib/widgets/small_route_card.dart
import 'package:flutter/material.dart';
import 'base_route_card.dart';

/// Маленькая карточка маршрута для горизонтального списка на главном экране
/// Отображает компактную версию карточки с изображением и основной информацией
class SmallRouteCard extends BaseRouteCard {
  /// Конструктор маленькой карточки маршрута
  /// 
  /// Аргументы:
  /// [routeName] - идентификатор маршрута для загрузки данных
  /// [onTap] - функция обратного вызова при нажатии на карточку
  const SmallRouteCard({
    super.key,
    required super.routeName,
    super.onTap,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      width: 230, // Фиксированная ширина карточки
      height: 190, // Фиксированная высота карточки
      margin: const EdgeInsets.only(right: 12), // Отступ справа для разделения карточек
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Закругленные углы карточки
        image: DecorationImage(
          image: AssetImage(backgroundImage), // Фоновое изображение маршрута
          fit: BoxFit.cover, // Обрезка изображения по размеру карточки
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Тень для эффекта глубины
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Градиент поверх изображения для лучшей читаемости текста
          gradient: LinearGradient(
            begin: Alignment.topRight, // Начало градиента в правом верхнем углу
            end: Alignment.bottomLeft, // Конец градиента в левом нижнем углу
            colors: [
              gradientColor.withOpacity(0.2), // Слабый цвет маршрута сверху
              gradientColor.withOpacity(0.5), // Более насыщенный цвет снизу
            ],
          ),
        ),
        padding: const EdgeInsets.all(16), // Внутренние отступы для текста
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание текста по левому краю
          mainAxisAlignment: MainAxisAlignment.end, // Размещение текста внизу карточки
          children: [
            /// Название маршрута
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600, // Полужирный шрифт для названия
                color: Colors.white, // Белый цвет для контраста на фоне
                height: 1.2, // Межстрочный интервал
              ),
              maxLines: 2, // Ограничение в 2 строки
              overflow: TextOverflow.ellipsis, // Многоточие при переполнении
            ),
            
            const SizedBox(height: 4), // Небольшой отступ между названием и подзаголовком
            
            /// Подзаголовок маршрута (краткое описание)
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9), // Полупрозрачный белый
                fontSize: 12, // Меньший размер шрифта чем у названия
                height: 1.3, // Межстрочный интервал
              ),
              maxLines: 2, // Ограничение в 2 строки
              overflow: TextOverflow.ellipsis, // Многоточие при переполнении
            ),
          ],
        ),
      ),
    );
  }
}