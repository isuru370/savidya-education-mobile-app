import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BuildScannerBodyWidget extends StatelessWidget {
  final MobileScannerController cameraController;
  final Function(BarcodeCapture) onQrDetected;

  const BuildScannerBodyWidget({
    super.key,
    required this.cameraController,
    required this.onQrDetected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCameraControls(),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              MobileScanner(
                controller: cameraController,
                onDetect: onQrDetected,
              ),
              _buildScannerOverlay(context),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildCameraControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => cameraController.toggleTorch(),
            icon: const Icon(Icons.flash_on, color: Colors.black),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () => cameraController.switchCamera(),
            icon: const Icon(Icons.switch_camera, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Transparent dark overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 26, 19, 88).withValues(alpha: 0.1),
          ),

          // Scanner frame
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blueAccent,
                width: 4,
              ),
            ),
          ),

          Positioned(
            top: 50,
            child: Container(
              width: 200,
              height: 4,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
