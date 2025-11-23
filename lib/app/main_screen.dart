import 'package:flutter/material.dart';
import '../camera/ai_camera_screen.dart';
import '../map/map_screen.dart';
import '../widgets/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    setState(() => selectedIndex = index);
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AICameraScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // УБИРАЕМ bottomNavigationBar из Scaffold
      body: Stack(
        children: [
          // ОСНОВНОЙ КОНТЕНТ РАСТЯНУТ НА ВЕСЬ ЭКРАН
          Positioned.fill(
            child: _buildCurrentScreen(),
          ),
          
          // НАВИГАЦИЯ ПОВЕРХ КАРТЫ С ТЕНЬЮ
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
        return _buildPlaceholderScreen("Маршруты");
      case 4:
        return _buildPlaceholderScreen("Объекты");
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