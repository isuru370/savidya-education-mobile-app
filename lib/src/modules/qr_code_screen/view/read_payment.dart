import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? studentId;
  bool isLoading = false;
  bool isErrorDialogVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        controller.pauseCamera();

        if (_isValidStudentId(scanData.code!)) {
          if (mounted) {
            setState(() {
              studentId = scanData.code;
            });
            if (studentId != null) {
              context
                  .read<QrScannerBloc>()
                  .add(StudentPaymentReadEvent(studentCustomId: studentId!));
            } else {
              Navigator.of(context).pop();
            }
          }
        } else {
          if (mounted) {
            _showErrorDialog("Invalid QR Code.");
          }
        }
      } else {
        if (mounted) {
          _showErrorDialog("QR Code could not be read.");
        }
      }
    });
  }

  bool _isValidStudentId(String id) {
    return id.isNotEmpty;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
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
                if (!mounted) return;
                isErrorDialogVisible = false;
                Navigator.of(context).pop();
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : BlocListener<QrScannerBloc, QrScannerState>(
              listener: (context, state) {
                if (state is PaymentReadSuccess) {
                  if (widget.title == "ordinary-level") {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/payment_screen', arguments: {
                      "student_last_payment": state.studentLastPaymentList,
                      "student_custom_id": studentId,
                    });
                  } else if (widget.title == "advance-level") {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/al_payment_screen', arguments: {
                      "student_last_payment": state.studentLastPaymentList,
                      "student_custom_id": studentId,
                    });
                  } else if (widget.title == "half_payment") {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/half_payment_screen', arguments: {
                      "student_last_payment": state.studentLastPaymentList,
                      "student_custom_id": studentId,
                    });
                  }
                } else if (state is PaymentReadFailure) {
                  Navigator.of(context).pop();
                }
              },
              child: BlocBuilder<QrScannerBloc, QrScannerState>(
                builder: (context, state) {
                  if (state is PaymentReadProcess) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _buildScannerBody();
                },
              ),
            ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Fetch Student ID'),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
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
    if (input.isNotEmpty) {
      setState(() {
        studentId = input;
      });
      context
          .read<QrScannerBloc>()
          .add(StudentPaymentReadEvent(studentCustomId: studentId!));
    } else {
      _showErrorDialog("Please enter a valid Student ID.");
    }
  }

  Widget _buildScannerBody() {
    return BuildScannerBodyWidget(
      qrKey: qrKey,
      onQRViewCreated: _onQRViewCreated,
      flashToggle: () async {
        await controller?.toggleFlash();
      },
      cameraFlip: () async {
        await controller?.flipCamera();
      },
    );
  }
}
