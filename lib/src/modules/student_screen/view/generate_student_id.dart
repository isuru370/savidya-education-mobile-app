import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../models/student/student.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../res/color/app_color.dart';
import '../bloc/get_student/get_student_bloc.dart';

class GenerateStudentId extends StatefulWidget {
  const GenerateStudentId({super.key});

  @override
  State<GenerateStudentId> createState() => _GenerateStudentIdState();
}

class _GenerateStudentIdState extends State<GenerateStudentId> {
  int? studentGradeId;
  String? dateOnly;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetStudentBloc>().add(GetActiveStudentData());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("All Students"),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by student name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // Grade Filter
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            height: 80,
            child: BlocBuilder<StudentGradeBloc, StudentGradeState>(
              builder: (context, state) {
                if (state is GetStudentGradeSuccess) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            studentGradeId = null;
                          });
                        },
                        child: gradeSelectionContainer(
                          isSelected: studentGradeId == null,
                          title: 'All Grades',
                        ),
                      ),
                      ...state.getGradeList.map((grade) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              studentGradeId = grade.id;
                            });
                          },
                          child: gradeSelectionContainer(
                            isSelected: studentGradeId == grade.id,
                            title: '${grade.gradeName} Grade',
                          ),
                        );
                      }),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<GetStudentBloc, GetStudentState>(
                builder: (context, state) {
                  if (state is GetAllActiveStudentSuccess) {
                    return Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await downloadAllIdsPdf(state.activeStudentList);
                          },
                          child: const Text('Download All IDs (PDF)'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () async {
                            await downloadAllIdsImage(state.activeStudentList);
                          },
                          child: const Text('Download All Images'),
                        ),
                      ],
                    );
                  }
                  return const Text("No actions available.");
                },
              ),
            ),
          ),

          // Student List
          Expanded(
            child: BlocBuilder<GetStudentBloc, GetStudentState>(
              builder: (context, state) {
                if (state is GetAllActiveStudentSuccess) {
                  final filteredStudents = state.activeStudentList
                      .where((activeStudent) =>
                          (studentGradeId == null ||
                              activeStudent.gradeId == studentGradeId) &&
                          (searchQuery.isEmpty ||
                              activeStudent.initialName!
                                  .toLowerCase()
                                  .contains(searchQuery)))
                      .toList();

                  return ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final activeStudent = filteredStudents[index];
                      convertDate(activeStudent.createdAt!);

                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activeStudent.initialName ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    dateOnly ?? '',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  QrImageView(
                                    data: activeStudent.cusId!,
                                    version: QrVersions.auto,
                                    size: 100.0,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    downloadQrPdf(
                                      activeStudent.cusId!,
                                      activeStudent.initialName!,
                                    );
                                  },
                                  child: const Text('Download QR PDF'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    downloadQrImage(
                                      activeStudent.cusId!,
                                      activeStudent.initialName!,
                                    );
                                  },
                                  child: const Text('Download QR Image'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is GetStudentDataProcess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetStudentDataFailure) {
                  return Center(
                    child: Text(state.failureMessage),
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Convert date to string format
  void convertDate(DateTime createdAt) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    dateOnly = dateFormat.format(createdAt);
  }

  // Grade selection container widget
  Widget gradeSelectionContainer(
      {required bool isSelected, required String title}) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.3,
      height: 50,
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? ColorUtil.whiteColor[14] : ColorUtil.tealColor[10],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.blue : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Download QR code as PDF for a student
  Future<void> downloadQrPdf(String qrData, String studentName) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  'Student: $studentName',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 16),
                pw.BarcodeWidget(
                  data: qrData,
                  barcode: pw.Barcode.qrCode(),
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: '${studentName}_QR_Code.pdf',
    );
  }

  // Download all student IDs as PDF
  Future<void> downloadAllIdsPdf(
      List<StudentModelClass> activeStudentList) async {
    final pdf = pw.Document();

    for (var student in activeStudentList) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Student: ${student.initialName}',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 16),
                  pw.BarcodeWidget(
                    data: student.cusId!,
                    barcode: pw.Barcode.qrCode(),
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    final pdfBytes = await pdf.save();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'All_Student_IDs.pdf',
    );
  }

  // Download all student IDs as images
  Future<void> downloadAllIdsImage(
      List<StudentModelClass> activeStudentList) async {
    for (var student in activeStudentList) {
      // Create a composite widget that dynamically adjusts its size.
      final qrCodeWidget = Center(
        child: Container(
          padding: const EdgeInsets.all(16), // Add padding for better layout
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color to white
            borderRadius: BorderRadius.circular(12), // Optional rounded corners
          ),
          constraints: const BoxConstraints(
            minWidth: 250, // Minimum width for the container
            maxWidth: 400, // Maximum width to prevent overflow
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                student.initialName ?? '',
                textAlign: TextAlign.center, // Center align the name
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              QrImageView(
                data: student.cusId!,
                version: QrVersions.auto,
                size: 200.0, // QR code size
              ),
              const SizedBox(height: 8),
              Text(
                student.cusId!,
                textAlign: TextAlign.center, // Center align the ID
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );

      // Capture the widget as an image.
      final byteData = await captureWidgetOffScreen(qrCodeWidget);
      if (byteData != null) {
        // Save the image to the gallery.
        final result = await ImageGallerySaver.saveImage(byteData);
        print('Image saved: $result');
      } else {
        print('Failed to capture image for ${student.cusId}');
      }
    }
  }

  Future<Uint8List?> captureWidgetOffScreen(Widget widget) async {
    final GlobalKey repaintBoundaryKey = GlobalKey();

    final completer = Completer<Uint8List?>();
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: RepaintBoundary(
              key: repaintBoundaryKey,
              child: Material(
                type: MaterialType.transparency,
                child: widget,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 200), () async {
      try {
        final RenderRepaintBoundary? boundary =
            repaintBoundaryKey.currentContext?.findRenderObject()
                as RenderRepaintBoundary?;
        if (boundary == null) {
          completer.complete(null);
          return;
        }

        final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        final ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        completer.complete(byteData?.buffer.asUint8List());
      } catch (e) {
        print("Error capturing widget: $e");
        completer.complete(null);
      } finally {
        overlayEntry.remove();
      }
    });

    return completer.future;
  }

  Future<void> downloadQrImage(String qrData, String studentName) async {
    // Define the widget structure for the QR image with student details.
    final qrCodeWidget = Material(
      color: Colors.transparent, // Transparent background for flexibility
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16), // Add padding around content
          decoration: BoxDecoration(
            color: Colors.white, // White background for the image
            borderRadius: BorderRadius.circular(12), // Optional rounded corners
          ),
          constraints: const BoxConstraints(
            minWidth: 250, // Minimum width for the background
            maxWidth: 400, // Maximum width to prevent overflow
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                studentName,
                textAlign: TextAlign.center, // Center align the text
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true, // Allow the text to wrap to the next line
                overflow: TextOverflow.clip, // Clip the text if it overflows
              ),
              const SizedBox(height: 12),
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 12),
              Text(
                qrData,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Capture the widget as an image.
    final byteData = await captureWidgetOffScreen(qrCodeWidget);
    if (byteData != null) {
      // Save the captured image to the gallery.
      final result = await ImageGallerySaver.saveImage(byteData);
      print('Image saved: $result');
    } else {
      print('Failed to capture image for $qrData');
    }
  }
}
