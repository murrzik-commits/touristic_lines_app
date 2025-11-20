import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touristic Lines',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late YandexMapController mapController;
  bool isMapCreated = false;

  void _setInitialCameraPosition() {
    if (isMapCreated) {
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: 52.0311,
              longitude: 113.4958,
            ),
            zoom: 12,
            tilt: 30,
            azimuth: 0,
          ),
        ),
        animation: const MapAnimation(
          type: MapAnimationType.smooth,
          duration: 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Получаем высоту BottomNavigationBar из темы
    final bottomNavBarHeight = kBottomNavigationBarHeight; // Стандартная высота = 56
    // Получаем нижний отступ (например, от notch или навигации телефона)
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // Рассчитываем итоговый отступ снизу для ListView
    final listViewBottomOffset = 8.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: YandexMap(
              onMapCreated: (controller) {
                mapController = controller;
                isMapCreated = true;
                _setInitialCameraPosition();
                print("Yandex Map Created and initial position set");
              },
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
          // Список маршрутов поверх части карты, но ближе к BottomNavigationBar
          Positioned(
            left: 16,
            right: 16,
            height: 130, // Высота списка маршрутов
            // Используем рассчитанный отступ
            bottom: listViewBottomOffset, // <-- Вот тут изменение
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                routeCard("Маршрут 1", "Исторический центр • 8 объектов"),
                routeCard("Маршрут 2", "Парки и сады • 6 объектов"),
                routeCard("Маршрут 3", "Музеи и архитектура • 10 объектов"),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: () {
                print("Settings button pressed");
              },
              child: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => selectedIndex = index);
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AICameraScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer_outlined), label: "Акции"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "AI камера"),
          BottomNavigationBarItem(icon: Icon(Icons.route_outlined), label: "Маршруты"),
          BottomNavigationBarItem(icon: Icon(Icons.place_outlined), label: "Объекты"),
        ],
      ),
    );
  }

  Widget routeCard(String title, String subtitle) {
    return Container(
      width: 175,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          const Row(children: [Icon(Icons.star, color: Colors.amber, size: 20), Text(" 4.9")]),
        ],
      ),
    );
  }
}

class AICameraScreen extends StatefulWidget {
  const AICameraScreen({super.key});
  @override
  State<AICameraScreen> createState() => _AICameraScreenState();
}

class _AICameraScreenState extends State<AICameraScreen> {
  late CameraController controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (mounted) setState(() => isInitialized = true);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Весь экран — камера
          SizedBox.expand(child: CameraPreview(controller)),

          // Рамка для наведения
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.8), width: 4),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // Кнопка "Назад"
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // Вспышка
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IconButton(
                  icon: const Icon(Icons.flash_on, color: Colors.white, size: 30),
                  onPressed: () => controller.setFlashMode(FlashMode.torch),
                ),
              ),
            ),
          ),

          // Большая круглая кнопка "Снять"
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: GestureDetector(
                onTap: () async {
                  final image = await controller.takePicture();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Фото сохранено: ${image.path}")),
                    );
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: const Center(
                    child: CircleAvatar(radius: 32, backgroundColor: Colors.white, child: CircleAvatar(radius: 28)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
