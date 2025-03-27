import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../bloc/QRScanner/qr_scanner_bloc.dart';
import '../components/build_scanner_body_widget.dart';
import '../components/qr_read_search_bar_widget.dart';

class QRCodeReadPaymentScreen extends StatefulWidget {
  final String title;

  const QRCodeReadPaymentScreen({super.key, required this.title});

  @override
  State<QRCodeReadPaymentScreen> createState() =>
      _QRCodeReadPaymentScreenState();
}

class _QRCodeReadPaymentScreenState extends State<QRCodeReadPaymentScreen> {
  final TextEditingController _searchStudentCustomId = TextEditingController();
  final MobileScannerController cameraController = MobileScannerController();

  String? studentId;
  bool isErrorDialogVisible = false;
  bool isCameraInitialized = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _initializeCamera() {
    cameraController.start();
    setState(() {
      isCameraInitialized = true;
    });
  }

  void _onQrDetected(BarcodeCapture capture) {
    if (_isProcessing || capture.barcodes.isEmpty) return;

    _isProcessing = true;
    final qrCode = capture.barcodes.first.rawValue;

    if (qrCode == null || qrCode.isEmpty) {
      _showErrorDialog("QR Code is empty.");
      _isProcessing = false;
      return;
    }

    studentId = qrCode.trim();
    context.read<QrScannerBloc>().add(
          StudentPaymentReadEvent(studentCustomId: studentId!),
        );

    Future.delayed(const Duration(seconds: 2), () {
      _isProcessing = false;
    });
  }

  bool _isValidStudentId(String id) {
    return id.isNotEmpty;
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

                // ✅ Restart camera safely
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<QrScannerBloc, QrScannerState>(
        listener: (context, state) {
          if (state is PaymentReadSuccess) {
            _navigateToPaymentScreen(state);
          } else if (state is PaymentReadFailure) {
            _showErrorDialog(state.failureMessage);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BuildScannerBodyWidget(
                cameraController: cameraController,
                onQrDetected: _onQrDetected,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPaymentScreen(PaymentReadSuccess state) {
    String routeName;
    switch (widget.title) {
      case "ordinary-level":
        routeName = '/payment_screen';
        break;
      case "advance-level":
        routeName = '/al_payment_screen';
        break;
      case "half_payment":
        routeName = '/half_payment_screen';
        break;
      default:
        return;
    }

    Navigator.of(context, rootNavigator: true).pushNamed(routeName, arguments: {
      "student_last_payment": state.studentLastPaymentList,
      "student_custom_id": studentId,
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Fetch Student ID'),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: ColorUtil.tealColor[10],
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildSearchTextField(),
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return QrReadSearchBarWidget(
      controller: _searchStudentCustomId,
      onSearch: _onSearchStudentId,
    );
  }

  void _onSearchStudentId(String input) {
    if (input.isNotEmpty && _isValidStudentId(input)) {
      setState(() {
        studentId = input;
      });

      context.read<QrScannerBloc>().add(
            StudentPaymentReadEvent(studentCustomId: studentId!),
          );
    } else {
      _showErrorDialog("Please enter a valid Student ID.");
    }
  }
}
