import 'package:aloka_mobile_app/src/modules/student_screen/bloc/get_student/get_student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../res/color/app_color.dart';
import '../components/qr_read_search_bar_widget.dart';
import '../components/build_scanner_body_widget.dart';

class QRStudentIdFetcher extends StatefulWidget {
  final String screenName;

  const QRStudentIdFetcher({super.key, required this.screenName});

  @override
  State<QRStudentIdFetcher> createState() => _QRStudentIdFetcherState();
}

class _QRStudentIdFetcherState extends State<QRStudentIdFetcher> {
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

  void _initializeCamera() async {
    try {
      await cameraController.start();
      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      _showErrorDialog("Failed to initialize camera: $e");
    }
  }

  void _onQrDetected(BarcodeCapture capture) {
    // Ensure that the camera is initialized and processing is not in progress
    if (!_isProcessing && isCameraInitialized && capture.barcodes.isNotEmpty) {
      _isProcessing = true;
      final qrCode = capture.barcodes.first.rawValue;

      if (qrCode == null || qrCode.isEmpty) {
        _showErrorDialog("QR Code is empty.");
        _isProcessing = false;
        return;
      }

      setState(() {
        studentId = qrCode;
      });
      if (widget.screenName == "view_student" ||
          widget.screenName == "student_add_class" ||
          widget.screenName == "student_tute") {
        context.read<GetStudentBloc>().add(
              GetUniqueStudentEvent(studentCustomId: studentId!),
            );
      } else {
        _showErrorDialog("Invalid screen name");
      }
      Future.delayed(const Duration(seconds: 2), () {
        _isProcessing = false;
      });
    }
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
                _isProcessing = false; // Reset processing flag
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<GetStudentBloc, GetStudentState>(
        listener: (context, state) {
          if (state is GetUniqueStudentSuccess) {
            _navigateToNextScreen(state);
          } else if (state is GetStudentDataFailure) {
            _showErrorDialog(state.failureMessage);
          }
        },
        child: BuildScannerBodyWidget(
          cameraController: cameraController,
          onQrDetected: _onQrDetected,
        ),
      ),
    );
  }

  void _navigateToNextScreen(GetUniqueStudentSuccess state) {
    if (state.getUniqueStudentList.isEmpty) {
      _showErrorDialog("No student found with the given ID.");
      return;
    }

    final student = state.getUniqueStudentList.first;

    if (widget.screenName == "view_student") {
      Navigator.of(context, rootNavigator: true).pushNamed(
        '/view_student',
        arguments: {'student_model_class': student},
      );
    } else if (widget.screenName == "student_add_class") {
      Navigator.of(context, rootNavigator: true).pushNamed(
        '/add_student_class',
        arguments: {
          "student_id": student.id,
          "student_custom_id": student.cusId,
          "student_initial_name": student.initialName,
          "is_bottom_nav_bar": false,
        },
      );
    } else if (widget.screenName == "student_tute") {
      Navigator.of(context, rootNavigator: true).pushNamed(
        '/student_tute_screen',
        arguments: {
          "student_id": student.id,
          "student_custom_id": student.cusId,
          "student_initial_name": student.initialName,
        },
      );
    }
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

      context.read<GetStudentBloc>().add(
            GetUniqueStudentEvent(studentCustomId: studentId!),
          );
    } else {
      _showErrorDialog("Please enter a valid Student ID.");
    }
  }
}
