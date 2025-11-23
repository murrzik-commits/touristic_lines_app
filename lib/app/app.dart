import 'package:flutter/material.dart';
import 'main_screen.dart'; // Импорт главного экрана приложения

// Корневой виджет приложения, не имеющий состояния (StatelessWidget)
// Отвечает за базовую конфигурацию MaterialApp
class MyApp extends StatelessWidget {
  // Конструктор с передачей ключа родительскому классу
  // super.key - сокращенный синтаксис для передачи параметра key
  const MyApp({super.key});

  // Обязательный метод build, описывающий как виджет должен отображаться
  @override
  Widget build(BuildContext context) {
    // MaterialApp - корневой виджет Material Design приложения
    // Обеспечивает структуру, навигацию, темы и другие базовые функции
    return MaterialApp(
      title: 'Touristic Lines', // Название приложения
      debugShowCheckedModeBanner: false, // Скрывает баннер DEBUG в углу
      // Светлая тема с использованием Material 3 (последняя версия дизайна)
      theme: ThemeData.light(useMaterial3: true),
      // Темная тема для устройств с включенным темным режимом
      darkTheme: ThemeData.dark(useMaterial3: true),
      // Стартовый экран приложения - MainScreen
      home: const MainScreen(),
    );
  }
}