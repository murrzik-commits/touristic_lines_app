// lib/widgets/large_route_card.dart
import 'package:flutter/material.dart';
import 'base_route_card.dart';
import '../services/route_service.dart';

/// Виджет большой карточки маршрута, наследуется от BaseRouteCard
class LargeRouteCard extends BaseRouteCard {
  const LargeRouteCard({
    super.key,
    /// Название маршрута (наследуется от BaseRouteCard)
    required super.routeName,
    /// Обработчик нажатия кнопки "Узнать больше"
    required this.onLearnMore,
  });

  /// Обработчик нажатия кнопки "Узнать больше"
  final VoidCallback onLearnMore;

  @override
  /// Построение содержимого карточки маршрута
  Widget buildContent(BuildContext context) {
    return Container(
      /// Высота контейнера карточки
      height: 220,
      decoration: BoxDecoration(
        /// Скругление углов карточки
        borderRadius: BorderRadius.circular(20),
        /// Изображение фона карточки
        image: DecorationImage(
          /// Изображение фона из ассетов
          image: AssetImage(backgroundImage),
          /// Режим подгонки изображения
          fit: BoxFit.cover,
        ),
        /// Тень карточки
        boxShadow: [
          BoxShadow(
            /// Цвет тени с прозрачностью
            color: Colors.black.withOpacity(0.15),
            /// Радиус размытия тени
            blurRadius: 15,
            /// Смещение тени
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          /// Скругление углов внутреннего контейнера
          borderRadius: BorderRadius.circular(20),
          /// Градиент наложения поверх изображения
          gradient: LinearGradient(
            /// Начало градиента (сверху)
            begin: Alignment.topCenter,
            /// Конец градиента (снизу)
            end: Alignment.bottomCenter,
            /// Цвета градиента
            colors: [
              /// Светлый прозрачный цвет вверху
              gradientColor.withOpacity(0.2),
              /// Темный насыщенный цвет внизу
              gradientColor.withOpacity(0.5),
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              /// Отступы внутри карточки
              padding: const EdgeInsets.all(20),
              child: Column(
                /// Выравнивание дочерних элементов по левому краю
                crossAxisAlignment: CrossAxisAlignment.start,
                /// Выравнивание дочерних элементов по нижнему краю
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Заголовок маршрута
                  Text(
                    /// Текст заголовка
                    title,
                    style: const TextStyle(
                      /// Размер шрифта заголовка
                      fontSize: 22,
                      /// Жирность шрифта заголовка
                      fontWeight: FontWeight.bold,
                      /// Цвет текста заголовка
                      color: Colors.white,
                      /// Высота строки заголовка
                      height: 1.2,
                    ),
                  ),
                  /// Отступ между заголовком и подзаголовком
                  const SizedBox(height: 6),
                  /// Подзаголовок маршрута
                  Text(
                    /// Текст подзаголовка
                    subtitle,
                    style: const TextStyle(
                      /// Размер шрифта подзаголовка
                      fontSize: 16,
                      /// Цвет текста подзаголовка
                      color: Colors.white,
                      /// Высота строки подзаголовка
                      height: 1.3,
                    ),
                  ),

                  Row(
                    /// Выравнивание элементов по правому краю
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Кнопка "Узнать больше" 
                      SizedBox(
                        /// Установка фиксированной ширины кнопки
                        width: 140,
                        /// Ограничение максимальной ширины
                        // width: 120, // или max-width: 120
                        child: ElevatedButton(
                          /// Обработчик нажатия кнопки
                          onPressed: onLearnMore,
                          style: ElevatedButton.styleFrom(
                            /// Цвет фона кнопки
                            backgroundColor: gradientColor,
                            /// Цвет текста кнопки
                            foregroundColor: Colors.white,
                            /// Внутренние отступы кнопки
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            /// Форма кнопки (скругленные углы)
                            shape: RoundedRectangleBorder(
                              /// Радиус скругления углов кнопки
                              borderRadius: BorderRadius.circular(12),
                            ),
                            /// Высота тени кнопки
                            elevation: 2,
                          ),
                          child: const Text(
                            /// Текст на кнопке
                            'Узнать больше',
                            style: TextStyle(
                              /// Размер шрифта текста кнопки
                              fontSize: 14,
                              /// Жирность шрифта текста кнопки
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}