import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../res/color/app_color.dart';
import '../../attendance/bloc/new_attendance_read/new_attendance_read_bloc.dart';
import '../components/build_scanner_body_widget.dart';
import '../components/qr_read_search_bar_widget.dart';

class NewAttendanceRead extends StatefulWidget {
  const NewAttendanceRead({
    super.key,
  });

  @override
  State<NewAttendanceRead> createState() => _NewAttendanceReadState();
}

class _NewAttendanceReadState extends State<NewAttendanceRead> {
  final TextEditingController _searchStudentCustomId = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrCodeResult;
  bool isErrorDialogVisible = false;
  String? studentCusId;

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
        studentCusId = scanData.code;

        if (mounted) {
          // Guard the context usage with mounted check
          context.read<NewAttendanceReadBloc>().add(
                GetAttendanceReadDateEvent(studentCustomId: studentCusId!),
              );
        }
      } else {
        _showErrorDialog("Invalid QR Code.");
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
      body: BlocListener<NewAttendanceReadBloc, NewAttendanceReadState>(
        listener: (context, state) {
          if (state is NewAttendanceReadFailure) {
            _showErrorDialog(state.failureMSG);
          } else if (state is NewAttendanceReadSuccess) {
            Navigator.of(context, rootNavigator: true).pushNamed(
              '/new_attendance_mark',
              arguments: {
                "read_student_data": state.newAttendanceReadModel,
              },
            );
          }
        },
        child: BlocBuilder<NewAttendanceReadBloc, NewAttendanceReadState>(
          builder: (context, state) {
            if (state is NewAttendanceReadProcess) {
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
      studentCusId = input;

      context.read<NewAttendanceReadBloc>().add(
            GetAttendanceReadDateEvent(studentCustomId: studentCusId!),
          );
    } else {
      _showErrorDialog("Please enter a valid Student ID.");
    }
  }
}
