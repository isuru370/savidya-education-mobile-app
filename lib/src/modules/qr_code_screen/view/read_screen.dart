import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../models/qr_read/qr_read.dart';
import '../bloc/QRScanner/qr_scanner_bloc.dart';
import '../components/build_scanner_body_widget.dart';
import '../components/qr_read_search_bar_widget.dart';

class QRCodeReadScreen extends StatefulWidget {
  final int? classHasId;
  final int? classAttendanceId;

  const QRCodeReadScreen({
    super.key,
    this.classHasId,
    this.classAttendanceId,
  });

  @override
  State<QRCodeReadScreen> createState() => _QRCodeReadScreenState();
}

class _QRCodeReadScreenState extends State<QRCodeReadScreen> {
  final TextEditingController _searchStudentCustomId = TextEditingController();
  final MobileScannerController cameraController = MobileScannerController();

  bool isErrorDialogVisible = false;
  bool _isProcessing = false; 
  String? studentId;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetectBarcode(BarcodeCapture capture) {
    if (_isProcessing || capture.barcodes.isEmpty) return;

    _isProcessing = true;
    final String? code = capture.barcodes.first.rawValue;

    if (code != null && code.isNotEmpty) {
      cameraController.stop();
      studentId = code.trim();

      QrReadStudentModelClass qrReadModelClass = QrReadStudentModelClass(
        studentCustomId: studentId,
        classHasCatId: widget.classHasId,
      );

      context.read<QrScannerBloc>().add(
            ReadAttendanceEvent(readAttendance: qrReadModelClass),
          );
    } else {
      _showErrorDialog("Invalid QR Code.");
      _isProcessing = false;
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted || isErrorDialogVisible) return;

    isErrorDialogVisible = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                isErrorDialogVisible = false;
                if (mounted) Navigator.of(context).pop();

                _isProcessing = false;
                if (!cameraController.autoStart) {
                  cameraController.start();
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAttendanceScreen(ReadAttendanceSuccess state) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      '/attendance_mark',
      arguments: {
        "read_student_data": state.studentList,
        "read_class_data": state.classAttList,
        "read_payment_data": state.paymentList,
        "attendance_id": widget.classAttendanceId,
        "student_cus_id": studentId,
      },
    );

    _isProcessing = false; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<QrScannerBloc, QrScannerState>(
        listener: (context, state) {
          if (state is ReadAttendanceFailure) {
            _showErrorDialog(state.failureMessage);
          } else if (state is ReadAttendanceSuccess) {
            _navigateToAttendanceScreen(state);
          }
        },
        child: BuildScannerBodyWidget(
          cameraController: cameraController,
          onQrDetected: _onDetectBarcode, 
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('QR Code Scanner'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: QrReadSearchBarWidget(
            controller: _searchStudentCustomId,
            onSearch: _onSearchStudentId,
          ),
        ),
      ),
    );
  }

  void _onSearchStudentId(String input) {
    if (input.isNotEmpty) {
      studentId = input.trim();
      QrReadStudentModelClass qrReadModelClass = QrReadStudentModelClass(
        studentCustomId: studentId,
        classHasCatId: widget.classHasId,
      );

      context.read<QrScannerBloc>().add(
            ReadAttendanceEvent(readAttendance: qrReadModelClass),
          );
    } else {
      _showErrorDialog("Please enter a valid Student ID.");
    }
  }
}
