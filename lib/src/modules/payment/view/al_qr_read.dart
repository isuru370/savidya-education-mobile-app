// import 'dart:io';

// import 'package:aloka_mobile_app/src/res/color/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../../qr_code_screen/bloc/QRScanner/qr_scanner_bloc.dart';


// class AlQrRead extends StatefulWidget {
//   final String? title;
//   const AlQrRead({super.key, required this.title});

//   @override
//   State<AlQrRead> createState() =>
//       _AlQrReadState();
// }

// class _AlQrReadState extends State<AlQrRead> {
//   final TextEditingController _searchStudentCustomId = TextEditingController();
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String? qrCodeResult;

//     late MethodChannel _channel;

//   @override
//   void initState() {
//     super.initState();
//     _channel = MethodChannel('qr_code_read_channel');
//     debugPrint('Channel initialized: $_channel');
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;

//     controller.scannedDataStream.listen((scanData) {
//       if (scanData.code != null) {
//         controller.pauseCamera();
//         qrCodeResult = scanData.code;
//         context
//             .read<QrScannerBloc>()
//             .add(StudentPaymentReadEvent(studentCustomId: scanData.code!));
//       } else {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Invalid QR code"),
//             ),
//           );
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QR Code Scanner'),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             color: ColorUtil.blueColor[10],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(100.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _searchStudentCustomId,
//                   decoration: InputDecoration(
//                     hintText: 'Search by Student ID',
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: BorderSide.none,
//                     ),
//                     prefixIcon:
//                         const Icon(Icons.search, color: Colors.blueAccent),
//                     contentPadding: const EdgeInsets.all(16),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     qrCodeResult = _searchStudentCustomId.text.trim();
//                     context.read<QrScannerBloc>().add(StudentPaymentReadEvent(
//                         studentCustomId: _searchStudentCustomId.text.trim()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 32, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     backgroundColor: Colors.blueAccent,
//                   ),
//                   child: const Text('Search'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: BlocListener<QrScannerBloc, QrScannerState>(
//         listener: (context, state) {
//           if (state is PaymentReadFailure) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               showDialog(
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text("Error"),
//                     content: Text(state.failureMessage),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: const Text("OK"),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             });
//           } else if (state is PaymentReadSuccess) {
//             if (widget.title == "ordinary-level") {
//               Navigator.of(context, rootNavigator: true)
//                   .pushNamed('/payment_screen', arguments: {
//                 "read_student_data": state.studentList,
//                 "student_last_payment": state.studentLastPaymentList,
//                 "student_custom_id": qrCodeResult,
//               });
//             } else if (widget.title == "advance-level") {
//               Navigator.of(context, rootNavigator: true)
//                   .pushNamed('/payment_screen', arguments: {
//                 "read_student_data": state.studentList,
//                 "student_last_payment": state.studentLastPaymentList,
//                 "student_custom_id": qrCodeResult,
//               });
//             } else {
//               Navigator.of(context, rootNavigator: true).pushNamed('/');
//             }
//           }
//         },
//         child: BlocBuilder<QrScannerBloc, QrScannerState>(
//           builder: (context, state) {
//             if (state is PaymentReadProcess) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             return Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () async {
//                           await controller?.toggleFlash();
//                           setState(() {});
//                         },
//                         icon: Icon(Icons.flash_on,
//                             color: ColorUtil.blackColor[10]),
//                       ),
//                       const SizedBox(width: 20),
//                       IconButton(
//                         onPressed: () async {
//                           await controller?.flipCamera();
//                           setState(() {});
//                         },
//                         icon: Icon(Icons.switch_camera,
//                             color: ColorUtil.blackColor[10]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: QRView(
//                     key: qrKey,
//                     onQRViewCreated: _onQRViewCreated,
//                     overlay: QrScannerOverlayShape(
//                       borderColor: Colors.blueAccent,
//                       borderRadius: 16,
//                       borderLength: 30,
//                       borderWidth: 8,
//                       cutOutSize: MediaQuery.of(context).size.width * 0.7,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
