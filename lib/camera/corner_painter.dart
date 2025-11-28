// lib/camera/corner_painter.dart
import 'package:flutter/material.dart';

/// Кастомный художник (CustomPainter) для отрисовки угловых элементов рамки камеры
/// Рисует L-образные углы в разных позициях экрана
class CornerPainter extends CustomPainter {
  /// Выравнивание угла определяет его позицию на экране
  /// Возможные значения: Alignment.topLeft, Alignment.topRight, 
  /// Alignment.bottomLeft, Alignment.bottomRight
  final Alignment alignment;

  /// Конструктор класса CornerPainter
  /// 
  /// Аргументы:
  /// [alignment] - выравнивание угла, определяет его позицию на экране
  CornerPainter({required this.alignment});

  /// Основной метод отрисовки, вызывается Flutter для отображения кастомной графики
  /// 
  /// Аргументы:
  /// [canvas] - холст для рисования графических элементов
  /// [size] - размер области доступной для рисования
  @override
  void paint(Canvas canvas, Size size) {
    // Настройка кисти для рисования
    final paint = Paint()
      ..color = Colors.white           // Белый цвет линий
      ..style = PaintingStyle.stroke    // Режим обводки (не заливки)
      ..strokeWidth = 3;                // Толщина линии 3 пикселя

    // Создание пути (path) для отрисовки фигуры
    final path = Path();

    // Построение пути в зависимости от позиции угла
    if (alignment == Alignment.topLeft) {
      // Левый верхний угол: ┌
      path
        ..moveTo(0, 20)        // Перемещение к началу вертикальной линии
        ..lineTo(0, 0)         // Вертикальная линия вверх
        ..lineTo(20, 0);       // Горизонтальная линия вправо
    } else if (alignment == Alignment.topRight) {
      // Правый верхний угол: ┐
      path
        ..moveTo(size.width - 20, 0)    // Перемещение к началу горизонтальной линии
        ..lineTo(size.width, 0)         // Горизонтальная линия вправо
        ..lineTo(size.width, 20);       // Вертикальная линия вниз
    } else if (alignment == Alignment.bottomLeft) {
      // Левый нижний угол: └
      path
        ..moveTo(0, size.height - 20)   // Перемещение к началу вертикальной линии
        ..lineTo(0, size.height)        // Вертикальная линия вниз
        ..lineTo(20, size.height);      // Горизонтальная линия вправо
    } else if (alignment == Alignment.bottomRight) {
      // Правый нижний угол: ┘
      path
        ..moveTo(size.width - 20, size.height)  // Перемещение к началу горизонтальной линии
        ..lineTo(size.width, size.height)       // Горизонтальная линия вправо
        ..lineTo(size.width, size.height - 20); // Вертикальная линия вверх
    }

    // Отрисовка пути на холсте с заданной кистью
    canvas.drawPath(path, paint);
  }

  /// Метод определяет нужно ли перерисовывать элемент при изменениях
  /// 
  /// Аргументы:
  /// [oldDelegate] - предыдущий экземпляр художника для сравнения
  /// 
  /// Возвращает:
  /// [bool] - false, так как углы статичны и не требуют перерисовки
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}