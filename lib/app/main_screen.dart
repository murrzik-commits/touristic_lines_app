import 'package:flutter/material.dart';
import '../camera/ai_camera_screen.dart';
import '../map/map_screen.dart';
import '../routes/routes_screen.dart';
import '../widgets/bottom_navigation.dart';
import '../objects/objects_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    if (index == 2) { // AI Камера - навигация
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AICameraScreen()),
      );
    } else {
      // Для остальных вкладок - переключение внутри MainScreen
      setState(() => selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ОСНОВНОЙ КОНТЕНТ
          Positioned.fill(
            child: _buildCurrentScreen(),
          ),
          
          // НАВИГАЦИОННАЯ ПАНЕЛЬ ПОВЕРХ КОНТЕНТА
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavigation(
              currentIndex: selectedIndex,
              onTap: (index) => _onItemTapped(index, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (selectedIndex) {
      case 0:
        return const MapScreen();
      case 1:
        return _buildPlaceholderScreen("Акции");
      case 3:
        return const RoutesScreen();
      case 4:
        return const ObjectsScreen(); // Заменяем заглушку на реальный экран
      default:
        return const MapScreen();
    }
  }

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