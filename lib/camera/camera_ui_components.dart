// lib/camera/camera_ui_components.dart
import 'package:flutter/material.dart';
import 'camera_manager.dart';
import 'corner_painter.dart';

class CameraUIComponents {
  static Widget buildTopPanel(BuildContext context, CameraManager cameraManager, VoidCallback onClose) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
              icon: Icon(
                cameraManager.isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 28,
              ),
              onTap: cameraManager.toggleFlash,
            ),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "AI Камера",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            _buildIconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onTap: onClose,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildCornerFrame() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            child: Stack(
              children: [
                _buildCorner(Alignment.topLeft),
                _buildCorner(Alignment.topRight),
                _buildCorner(Alignment.bottomLeft),
                _buildCorner(Alignment.bottomRight),
              ],
            ),
          ),
            Container(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Отсканируйте здание, чтобы получить информацию о нём",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildBottomPanel(CameraManager cameraManager, VoidCallback onTakePicture) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCaptureButton(onTakePicture),
              const SizedBox(height: 30),
              _buildZoomPanel(cameraManager),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 40,
        height: 40,
        child: CustomPaint(
          painter: CornerPainter(alignment: alignment),
        ),
      ),
    );
  }

  static Widget _buildZoomPanel(CameraManager cameraManager) {
    return Container(
      width: 250,
      child: Row(
        children: [
          _buildZoomButton(
            icon: Icons.remove,
            onTap: cameraManager.zoomOut,
          ),
          
          Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Container(
                    width: (250 - 80) * ((cameraManager.currentZoomLevel - cameraManager.minZoomLevel) / (cameraManager.maxZoomLevel - cameraManager.minZoomLevel)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          _buildZoomButton(
            icon: Icons.add,
            onTap: cameraManager.zoomIn,
          ),
        ],
      ),
    );
  }

  static Widget _buildZoomButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  static Widget _buildIconButton({required Widget icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }

  static Widget _buildCaptureButton(VoidCallback onTakePicture) {
    return GestureDetector(
      onTap: onTakePicture,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/Camera.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}