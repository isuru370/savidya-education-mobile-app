import 'package:aloka_mobile_app/src/models/attendance/class_student_attendance_mode.dart';
import 'package:aloka_mobile_app/src/modules/attendance/bloc/class_student_attendance/class_student_attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../components/attendance_card.dart';

class ClassStudentAttendance extends StatefulWidget {
  final String className;
  final String gradeName;
  final String categoryName;
  final int classCatId;
  final String classDate;

  const ClassStudentAttendance({
    Key? key,
    required this.className,
    required this.gradeName,
    required this.categoryName,
    required this.classCatId,
    required this.classDate,
  }) : super(key: key);

  @override
  State<ClassStudentAttendance> createState() => _ClassStudentAttendanceState();
}

class _ClassStudentAttendanceState extends State<ClassStudentAttendance> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch data when the widget initializes
    context.read<ClassStudentAttendanceBloc>().add(
          GetClassStudentAttendance(
            classStudentAttendanceMode: ClassStudentAttendanceMode(
              classCategoryHasStudentClassId: widget.classCatId,
              atDate: DateTime.parse(widget.classDate),
            ),
          ),
        );
  }

  Future<void> _generateAndDownloadPdf(
      List<ClassStudentAttendanceMode> attendanceRecords) async {
    final pdf = pw.Document();

    // Calculate counts
    final totalCount = attendanceRecords.length;
    final presentCount = attendanceRecords
        .where((record) => record.attendanceStatus == "present")
        .length;
    final absentCount = totalCount - presentCount;

    // Add the header
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Class Attendance Report",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text("Class Name: ${widget.className}"),
              pw.Text("Grade: ${widget.gradeName}"),
              pw.Text("Category: ${widget.categoryName}"),
              pw.Text("Date: ${widget.classDate}"),
              pw.SizedBox(height: 10),
              pw.Text("Total Students: $totalCount"),
              pw.Text("Present: $presentCount"),
              pw.Text("Absent: $absentCount"),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(3),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(2),
                },
                children: [
                  // Header Row
                  pw.TableRow(
                    children: [
                      pw.Text('No',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Student Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Student ID',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Attendance',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  // Data Rows
                  for (int i = 0; i < attendanceRecords.length; i++)
                    pw.TableRow(
                      children: [
                        pw.Text((i + 1).toString()),
                        pw.Text(attendanceRecords[i].initialName ?? "Unknown"),
                        pw.Text(attendanceRecords[i].customId ?? "N/A"),
                        pw.Text(attendanceRecords[i].attendanceStatus ?? "N/A"),
                      ],
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Download the PDF
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "class_attendance_report.pdf",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Attendance"),
        actions: [
          BlocBuilder<ClassStudentAttendanceBloc, ClassStudentAttendanceState>(
            builder: (context, state) {
              if (state is ClassStudentAttendanceSuccess) {
                return IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () => _generateAndDownloadPdf(
                    state.classStudentAttendanceList,
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body:
          BlocBuilder<ClassStudentAttendanceBloc, ClassStudentAttendanceState>(
        builder: (context, state) {
          if (state is ClassStudentAttendanceProcess) {
            // Show a loading spinner while fetching data
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ClassStudentAttendanceFailure) {
            // Display an error message if the state is a failure
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is ClassStudentAttendanceSuccess) {
            // Display the list of attendance records on success
            final attendanceRecords = state.classStudentAttendanceList;

            if (attendanceRecords.isEmpty) {
              return const Center(
                child: Text("No attendance records found."),
              );
            }

            // Calculate attendance counts
            final totalCount = attendanceRecords.length;
            final presentCount = attendanceRecords
                .where((record) => record.attendanceStatus == "present")
                .length;
            final absentCount = totalCount - presentCount;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Total: $totalCount | Present: $presentCount | Absent: $absentCount",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: attendanceRecords.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final record = attendanceRecords[index];
                      return AttendanceCard(
                        studentName: record.initialName ?? "Unknown",
                        attendanceStatus: record.attendanceStatus ?? "Absent",
                        customId: record.customId ?? "N/A",
                        whatsappMobile: record.whatsappMobile ?? "N/A",
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            // Handle the default state with a fallback UI
            return const Center(
              child: Text("Unexpected state."),
            );
          }
        },
      ),
    );
  }
}
