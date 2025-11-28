import 'package:flutter/material.dart';
import '../camera/ai_camera_screen.dart';
import '../map/map_screen.dart';
import '../routes/routes_screen.dart';
import '../widgets/bottom_navigation.dart';
import '../objects/objects_screen.dart';
import '../routes/route_detail_screen.dart'; 

/// Главный экран приложения с навигацией между основными разделами
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Текущий выбранный индекс в нижней навигации
  int selectedIndex = 0;
  
  /// Название выбранного маршрута для отображения детальной информации
  /// Если null - отображается основной экран
  String? _selectedRouteForDetail;

  /// Обработчик нажатия на элемент нижней навигации
  /// 
  /// Аргументы:
  /// [index] - индекс выбранного элемента навигации (0-4)
  /// [context] - контекст построения для навигации между экранами
  void _onItemTapped(int index, BuildContext context) {
    if (index == 2) { // AI Камера - навигация на отдельный экран
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AICameraScreen()),
      );
    } else {
      // Для остальных вкладок - переключение внутри MainScreen
      setState(() {
        selectedIndex = index;
        _selectedRouteForDetail = null; // Сбрасываем детальный экран при переключении вкладок
      });
    }
  }

  /// Открывает детальный экран маршрута
  /// [routeName] - название маршрута для отображения детальной информации
  void _openRouteDetail(String routeName) {
    setState(() {
      _selectedRouteForDetail = routeName;
    });
  }

  /// Закрывает детальный экран маршрута и возвращается к основному экрану
  void _closeRouteDetail() {
    setState(() {
      _selectedRouteForDetail = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            /// Основной контент экрана - текущий выбранный раздел
            child: _buildCurrentScreen(),
          ),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            /// Панель нижней навигации, всегда отображается поверх контента
            /// 
            /// Аргументы:
            /// [currentIndex] - текущий выбранный индекс для подсветки
            /// [onTap] - обработчик нажатия на элементы навигации
            child: BottomNavigation(
              currentIndex: selectedIndex,
              onTap: (index) => _onItemTapped(index, context),
            ),
          ),
        ],
      ),
    );
  }

  /// Строит текущий экран в зависимости от состояния
  /// 
  /// Возвращает:
  /// - RouteDetailScreen если выбран маршрут для детального просмотра
  /// - Соответствующий экран по selectedIndex в остальных случаях
  Widget _buildCurrentScreen() {
    // Если открыт детальный экран маршрута, показываем его поверх основного контента
    if (_selectedRouteForDetail != null) {
      return RouteDetailScreen(
        routeName: _selectedRouteForDetail!,
        onStartTour: () {
          print("Начинаем тур по маршруту: $_selectedRouteForDetail");
          _closeRouteDetail();
        },
        onClose: _closeRouteDetail,
      );
    }

    // Иначе показываем обычные экраны согласно выбранной вкладке
    switch (selectedIndex) {
      case 0: // Карта
        return const MapScreen();
      case 1: // Акции (заглушка)
        return _buildPlaceholderScreen("Акции");
      case 3: // Маршруты
        return RoutesScreen(onRouteTap: _openRouteDetail); // Передаем колбэк для открытия деталей маршрута
      case 4: // Объекты
        return const ObjectsScreen();
      default: // По умолчанию - карта
        return const MapScreen();
    }
  }

  /// Создает экран-заглушку с заголовком
  /// 
  /// Аргументы:
  /// [title] - текст заголовка для отображения на экране-заглушке
  /// 
  /// Возвращает:
  /// Widget с центрированным текстом заголовка
  Widget _buildPlaceholderScreen(String title) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}