import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../models/student/student.dart';
import '../../../res/color/app_color.dart';

class StudentViewScreen extends StatefulWidget {
  final StudentModelClass studentModel;
  const StudentViewScreen({super.key, required this.studentModel});

  @override
  State<StudentViewScreen> createState() => _StudentViewScreenState();
}

class _StudentViewScreenState extends State<StudentViewScreen> {
  final GlobalKey _qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("Student Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),
            _buildPersonalInfoSection(),
            const SizedBox(height: 20),
            _buildGuardianInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: ColorUtil.tealColor[10],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.studentModel.initialName ?? 'No Name',
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorUtil.whiteColor[10],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.studentModel.cusId ?? 'N/A',
                  style: TextStyle(
                    fontSize: 23,
                    color: ColorUtil.whiteColor[10],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Grade ${widget.studentModel.gradeName ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 23,
                    color: ColorUtil.whiteColor[10],
                  ),
                ),
                const SizedBox(height: 10),
                _buildStatusBadge(),
              ],
            ),
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: widget.studentModel.studentImageUrl != null
                    ? NetworkImage(widget.studentModel.studentImageUrl!)
                    : null,
                child: widget.studentModel.studentImageUrl == null
                    ? const Icon(Icons.person, size: 55, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Show Student ID"),
                        content: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.teal),
                          ),
                          child: RepaintBoundary(
                            key: _qrKey,
                            child: SizedBox(
                              width: 300, // Specify a fixed width
                              child: Container(
                                color: Colors.white, // Background color
                                padding:
                                    const EdgeInsets.all(16), // Add padding
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.studentModel.initialName ??
                                          'No Name',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    QrImageView(
                                      data: widget.studentModel.cusId!,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                      backgroundColor: Colors.white,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.studentModel.cusId ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _shareQRCode();
                            },
                            child: const Text('Share'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.qr_code, size: 24),
                    SizedBox(width: 10),
                    Text('Student ID'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color:
            widget.studentModel.activeStatus == 1 ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        widget.studentModel.activeStatus == 1 ? 'Active' : 'Inactive',
        style: TextStyle(
          color: ColorUtil.whiteColor[10],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection(
      title: "Personal Info",
      children: [
        _infoRow(Icons.person, widget.studentModel.fullName ?? 'N/A'),
        _infoRow(Icons.phone, widget.studentModel.mobileNumber ?? 'N/A'),
        _infoRow(
            FontAwesome5.whatsapp, widget.studentModel.whatsappNumber ?? 'N/A'),
        _infoRow(Icons.location_city,
            '${widget.studentModel.addressLine1 ?? ''} ${widget.studentModel.addressLine2 ?? ''} ${widget.studentModel.addressLine3 ?? ''}'),
        _infoRow(Icons.email, widget.studentModel.emailAddress ?? 'N/A'),
        _infoRow(Icons.notes_sharp, widget.studentModel.studentNic ?? 'N/A'),
        _infoRow(Icons.face_6, widget.studentModel.gender ?? 'N/A'),
        _infoRow(Icons.cake, widget.studentModel.birthDay ?? 'N/A'),
      ],
      onAddPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed('/view_student_details', arguments: {
          "student_id": widget.studentModel.id!,
          "custom_id": widget.studentModel.cusId!,
          "initial_name": widget.studentModel.initialName!
        });
      },
    );
  }

  Widget _buildGuardianInfoSection() {
    return _buildSection(
      title: "Guardian Info",
      children: [
        _infoRow(Icons.person, widget.studentModel.guardianFName ?? 'N/A'),
        _infoRow(Icons.person, widget.studentModel.guardianLName ?? 'N/A'),
        _infoRow(Icons.phone_iphone_sharp,
            widget.studentModel.guardianMNumber ?? 'N/A'),
        _infoRow(
            Icons.notes_outlined, widget.studentModel.guardianNic ?? 'N/A'),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
    VoidCallback? onAddPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorUtil.whiteColor[10],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                Colors.grey.withAlpha((0.2 * 255).toInt()), // Replace withAlpha
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.tealColor[10],
                ),
              ),
              if (onAddPressed !=
                  null) // Show the button only if onAddPressed is provided
                ElevatedButton(
                  onPressed: onAddPressed,
                  style: ElevatedButton.styleFrom(
                    iconColor:
                        ColorUtil.tealColor[10], // Button background color
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'View Class',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Future<void> _shareQRCode() async {
    try {
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/student_qr.png';
      await File(imagePath).writeAsBytes(pngBytes);

      final xFile = XFile(imagePath);
      await Share.shareXFiles(
        [xFile],
        text: 'Student QR Code ${widget.studentModel.cusId}',
      );
    } catch (e) {
      debugPrint('Error capturing or sharing QR code: $e');
    }
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 22, color: ColorUtil.tealColor[10]),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: ColorUtil.blackColor[10],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
