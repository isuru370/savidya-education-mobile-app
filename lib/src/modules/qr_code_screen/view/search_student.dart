// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../../student_screen/bloc/get_student/get_student_bloc.dart';

// class SearchStudent extends StatefulWidget {
//   final String screenName;
//   const SearchStudent({super.key, required this.screenName});

//   @override
//   State<SearchStudent> createState() => _SearchStudentState();
// }

// class _SearchStudentState extends State<SearchStudent> {
//   final TextEditingController _searchStudentCustomId = TextEditingController();
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   bool scannerStudent = false;
//   String? qrCodeResult;

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;

//     controller.scannedDataStream.listen((scanData) {
//       if (scanData.code != null) {
//         if (!scannerStudent) {
//           controller.pauseCamera();
//           context.read<GetStudentBloc>().add(
//               GetUniqueStudentEvent(studentCustomId: scanData.code!.trim()));
//         }
//       } else {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("null value"),
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
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(100.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   controller: _searchStudentCustomId,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.grey),
//                     ),
//                     prefixIcon: const Icon(Icons.search),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     // Ensure the studentId is valid before proceeding
//                     if (_searchStudentCustomId.text.trim().isNotEmpty) {
//                       controller!.pauseCamera();
//                       context.read<GetStudentBloc>().add(GetUniqueStudentEvent(
//                           studentCustomId: _searchStudentCustomId.text.trim()));
//                     }
//                   },
//                   child: const Text('search')),
//             ],
//           ),
//         ),
//       ),
//       body: BlocListener<GetStudentBloc, GetStudentState>(
//         listener: (context, state) {
//           if (state is GetStudentDataFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.failureMessage),
//               ),
//             );
//           } else if (state is GetUniqueStudentSuccess) {
//             if (widget.screenName == "student-add-class") {
//               Navigator.of(context, rootNavigator: true)
//                   .pushNamed('/add_student_class', arguments: {
//                 "student_id": state.getUniqueStudentList.first.id,
//                 "student_custom_id": state.getUniqueStudentList.first.cusId,
//                 "student_initial_name":
//                     state.getUniqueStudentList.first.initialName,
//               });
//             } else if (widget.screenName == "student-search") {
//               Navigator.of(context, rootNavigator: true)
//                   .pushNamed('/view_student', arguments: {
//                 'student_model_class': state.getUniqueStudentList.first,
//               });
//             } else {
//               Navigator.of(context, rootNavigator: true).pushNamed('/');
//             }
//           }
//         },
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       await controller?.toggleFlash();
//                       setState(() {});
//                     },
//                     icon: const Icon(Icons.flash_off),
//                   ),
//                   IconButton(
//                     onPressed: () async {
//                       await controller?.flipCamera();
//                       setState(() {});
//                     },
//                     icon: const Icon(Icons.switch_camera),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: QRView(
//                   key: qrKey,
//                   onQRViewCreated: _onQRViewCreated,
//                   overlay: QrScannerOverlayShape(
//                     borderColor: Colors.white10,
//                     borderRadius: 10,
//                     borderLength: 20,
//                     borderWidth: 10,
//                     cutOutSize: MediaQuery.of(context).size.width * 0.7,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
