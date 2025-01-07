import 'dart:io';

import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrCodeResult;
  bool isErrorDialogVisible = false;
  String? studentId;

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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        controller.pauseCamera();
        studentId = scanData.code;
        QrReadStudentModelClass qrReadModelClass = QrReadStudentModelClass(
          studentCustomId: scanData.code,
          classHasCatId: widget.classHasId,
        );

        if (qrReadModelClass.studentCustomId!.isNotEmpty) {
          if (mounted) {
            // Guard the context usage with mounted check
            context.read<QrScannerBloc>().add(
                  ReadAttendanceEvent(readAttendance: qrReadModelClass),
                );
          }
        } else {
          _showErrorDialog("Invalid QR Code.");
        }
      } else {
        _showErrorDialog("QR Code could not be read.");
      }
    });
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
      body: BlocListener<QrScannerBloc, QrScannerState>(
        listener: (context, state) {
          if (state is ReadAttendanceFailure) {
            _showErrorDialog(state.failureMessage);
          } else if (state is ReadAttendanceSuccess) {
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
          }
        },
        child: BlocBuilder<QrScannerBloc, QrScannerState>(
          builder: (context, state) {
            if (state is AttendanceProcess) {
              return const Center(child: CircularProgressIndicator());
            }

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
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('QR Code Scanner'),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: ColorUtil.tealColor[10],
        ),
      ),
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
      studentId = input;
      QrReadStudentModelClass qrReadModelClass = QrReadStudentModelClass(
        studentCustomId: input.trim(),
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
