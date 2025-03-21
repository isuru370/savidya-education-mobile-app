import 'package:aloka_mobile_app/src/modules/qr_code_screen/components/build_scanner_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../res/color/app_color.dart';
import '../../attendance/bloc/new_attendance_read/new_attendance_read_bloc.dart';
import '../components/qr_read_search_bar_widget.dart';

class NewAttendanceRead extends StatefulWidget {
  const NewAttendanceRead({super.key});

  @override
  State<NewAttendanceRead> createState() => _NewAttendanceReadState();
}

class _NewAttendanceReadState extends State<NewAttendanceRead> {
  final TextEditingController _searchStudentCustomId = TextEditingController();
  final MobileScannerController cameraController = MobileScannerController();

  String? studentCusId;
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

    studentCusId = qrCode.trim();
    context.read<NewAttendanceReadBloc>().add(
          GetAttendanceReadDateEvent(studentCustomId: studentCusId!),
        );

    Future.delayed(const Duration(seconds: 2), () {
      _isProcessing = false;
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
                isErrorDialogVisible = false;
                if (mounted) Navigator.of(context).pop();

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
    if (!isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<NewAttendanceReadBloc, NewAttendanceReadState>(
        listener: (context, state) {
          if (state is NewAttendanceReadFailure) {
            _showErrorDialog(state.failureMSG);
          } else if (state is NewAttendanceReadSuccess) {
            Navigator.of(context, rootNavigator: true).pushNamed(
              '/new_attendance_mark',
              arguments: {"read_student_data": state.newAttendanceReadModel},
            );
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

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('QR Code Scanner'),
      flexibleSpace: Container(
        decoration: BoxDecoration(color: ColorUtil.tealColor[10]),
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
      studentCusId = input.trim();
      context.read<NewAttendanceReadBloc>().add(
            GetAttendanceReadDateEvent(studentCustomId: studentCusId!),
          );
    } else {
      _showErrorDialog("Please enter a valid Student ID.");
    }
  }
}
