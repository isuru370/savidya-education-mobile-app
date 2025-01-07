import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  QrScannerCubit() : super(QrScannerInitial());

  QRViewController? controller;

  // Initialize the QRViewController and process the QR code
  void initializeController(QRViewController controller) {
    this.controller = controller;
  }

  void processQRCode() {
    if (controller == null) {
      emit(
          const QrScannerFailure(failureMSG: 'Controller is not initialized.'));
      return;
    }

    controller!.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        emit(QrScannerProcess());
        try {
          final qrScannerResult = scanData.code!;

          // Emit success with the QR code result
          emit(QrScannerSuccess(qrScannerResult: qrScannerResult));
        } catch (e) {
          // Emit failure with error message
          emit(QrScannerFailure(failureMSG: 'Failed to process QR Code: $e'));
        }
      } else {
        // Emit failure for invalid QR code
        emit(const QrScannerFailure(failureMSG: 'Invalid QR Code'));
      }
    });
  }
}
