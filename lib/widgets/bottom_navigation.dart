import 'package:flutter/material.dart';

/// Кастомный виджет нижней навигационной панели
/// Отображает иконки и подписи для навигации между основными разделами приложения
class BottomNavigation extends StatelessWidget {
  /// Текущий выбранный индекс вкладки
  final int currentIndex;
  
  /// Функция обратного вызова при нажатии на элемент навигации
  final Function(int) onTap;

  /// Конструктор нижней навигационной панели
  /// 
  /// Аргументы:
  /// [currentIndex] - индекс текущей активной вкладки (0-4)
  /// [onTap] - функция вызываемая при выборе вкладки, принимает индекс новой вкладки
  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Отступы со всех сторон кроме верха
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Закругленные углы контейнера
        boxShadow: [
          // Основная тень для "парящего" эффекта
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          // Дополнительная тень для глубины
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Обрезка содержимого по границам контейнера
        child: BottomNavigationBar(
          currentIndex: currentIndex, // Текущая выбранная вкладка
          type: BottomNavigationBarType.fixed, // Фиксированная ширина всех элементов
          backgroundColor: Colors.white, // Белый фон панели
          elevation: 0, // Убираем стандартную тень
          selectedItemColor: const Color(0xFF2E2E2E), // Цвет активной иконки и текста
          unselectedItemColor: const Color(0xFF2E2E2E).withOpacity(0.5), // Цвет неактивных элементов
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600, // Полужирный для активной вкладки
            fontSize: 11,
            height: 1.2,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal, // Обычный шрифт для неактивных
            fontSize: 11,
            height: 1.2,
          ),
          showSelectedLabels: true, // Показывать подписи активных вкладок
          showUnselectedLabels: true, // Показывать подписи неактивных вкладок
          onTap: onTap, // Обработчик нажатия на элементы
          items: const [
            /// Вкладка "Главная" - экран карты
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2), // Отступ снизу для выравнивания
                child: Icon(Icons.home_outlined, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.home, size: 24), // Заполненная иконка для активного состояния
              ),
              label: "Главная",
            ),
            
            /// Вкладка "Акции" - промо-предложения
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.local_offer_outlined, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.local_offer, size: 24),
              ),
              label: "Акции",
            ),
            
            /// Вкладка "AI камера" - распознавание объектов
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(IconData(0xe12f, fontFamily: 'MaterialIcons'), size: 24), // Кастомная иконка камеры
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.camera_alt, size: 24), // Стандартная иконка камеры для активного состояния
              ),
              label: "AI камера",
            ),
            
            /// Вкладка "Маршруты" - список туристических маршрутов
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(IconData(0xe3c8, fontFamily: 'MaterialIcons'), size: 24), // Кастомная иконка маршрута
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.route, size: 24), // Стандартная иконка маршрута
              ),
              label: "Маршруты",
            ),
            
            /// Вкладка "Объекты" - список достопримечательностей
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.place_outlined, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.place, size: 24),
              ),
              label: "Объекты",
            ),
          ],
        ),
      ),
    );
  }
}