import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  QrScannerCubit() : super(QrScannerInitial());

  final MobileScannerController cameraController = MobileScannerController();

  // Start scanning QR codes
  void startScanning() {
    cameraController.start();
    cameraController.stop();
  }

  // Process scanned QR code
  void processQRCode(BarcodeCapture capture) {
    if (capture.barcodes.isEmpty) {
      emit(const QrScannerFailure(failureMSG: 'Invalid QR Code'));
      return;
    }

    emit(QrScannerProcess());
    try {
      final qrScannerResult = capture.barcodes.first.rawValue ?? '';

      if (qrScannerResult.isNotEmpty) {
        emit(QrScannerSuccess(qrScannerResult: qrScannerResult));
      } else {
        emit(const QrScannerFailure(failureMSG: 'Invalid QR Code'));
      }
    } catch (e) {
      emit(QrScannerFailure(failureMSG: 'Failed to process QR Code: $e'));
    }
  }

  // Dispose the camera
  void disposeCamera() {
    cameraController.dispose();
  }
}
