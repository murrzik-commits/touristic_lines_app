// Импорт необходимых пакетов
import 'package:flutter/material.dart'; // Основные виджеты Material Design
import 'package:camera/camera.dart'; // Пакет для работы с камерой устройства
import 'app/app.dart'; // Импорт главного виджета приложения из модуля app

// Глобальная переменная для хранения списка доступных камер
// Инициализируется в функции main() перед запуском приложения
List<CameraDescription> cameras = [];

// Главная функция - точка входа в приложение
// async указывает на наличие асинхронных операций
Future<void> main() async {
  // Обязательная инициализация связки Flutter с нативными компонентами
  // Требуется перед вызовом любых плагинов или runApp()
  WidgetsFlutterBinding.ensureInitialized();
  
  // Асинхронное получение списка доступных камер устройства
  // await приостанавливает выполнение до завершения операции
  cameras = await availableCameras();
  
  // Запуск приложения с корневым виджетом MyApp
  runApp(const MyApp());
}
