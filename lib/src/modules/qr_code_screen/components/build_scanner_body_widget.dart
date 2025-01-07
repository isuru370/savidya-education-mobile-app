import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BuildScannerBodyWidget extends StatelessWidget {
  final Key qrKey;
  final Function(QRViewController) onQRViewCreated;
  final Function()? flashToggle;
  final Function()? cameraFlip;

  const BuildScannerBodyWidget({
    super.key,
    required this.qrKey,
    required this.onQRViewCreated,
    this.flashToggle,
    this.cameraFlip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCameraControls(),
        Expanded(
          child: QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blueAccent,
              borderRadius: 16,
              borderLength: 30,
              borderWidth: 8,
              cutOutSize: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildCameraControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: flashToggle,
            icon: const Icon(Icons.flash_on, color: Colors.black),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: cameraFlip,
            icon: const Icon(Icons.switch_camera, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
