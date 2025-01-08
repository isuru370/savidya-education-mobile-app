import 'dart:typed_data';
import 'package:aloka_mobile_app/src/models/student/students_in_the_class_mode.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/bloc/student_in_the_class/student_in_the_class_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../res/color/app_color.dart';
import '../../class_screen/bloc/student_percentage/student_percentage_bloc.dart';

class TeacherHasStudentReport extends StatefulWidget {
  final int classHasCatId;
  final int classId;
  final String gradeName;
  final String teacherName;

  const TeacherHasStudentReport({
    super.key,
    required this.classHasCatId,
    required this.classId,
    required this.gradeName,
    required this.teacherName,
  });

  @override
  State<TeacherHasStudentReport> createState() =>
      _TeacherHasStudentReportState();
}

class _TeacherHasStudentReportState extends State<TeacherHasStudentReport> {
  final List<List<dynamic>> studentDate = [];

  @override
  void initState() {
    super.initState();
    context.read<StudentInTheClassBloc>().add(GetStudentInTheClassEvent(
        studentClassId: widget.classId, studentHasCatId: widget.classHasCatId));
  }

  Future<Uint8List> generatePDF(List<List<dynamic>> studentData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              pw.Text(
                'Savidya Higher Education Institute',
                style: pw.TextStyle(
                  fontSize: 26,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Class Name: ${studentData.isNotEmpty ? studentData[0][0] : "N/A"}',
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                'Grade Name: ${studentData.isNotEmpty ? studentData[0][1] : "N/A"}',
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                'Teacher Name: ${studentData.isNotEmpty ? studentData[0][2] : "N/A"}',
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.SizedBox(height: 20),

              // Report Title
              pw.Text(
                'Student Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),

              // Table Section
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Student ID',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Student Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Parent No',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Attendance %',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Present Count',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Absent Count',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...studentData.map((data) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(data[3].toString()), // Student ID
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(data[4].toString()), // Student Name
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(data[5].toString()), // Parent No
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(data[6].toString()), // Attendance %
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(data[7].toString()), // Present Count
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(data[8].toString()), // Absent Count
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  void downloadPDF() async {
    if (studentDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data to generate PDF')),
      );
      return;
    }
    final pdfData = await generatePDF(studentDate);
    await Printing.sharePdf(bytes: pdfData, filename: 'student_report.pdf');
  }

  Widget buildStudentCard(
      BuildContext context, StudentsInTheClassModel studentClass) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorUtil.tealColor[50],
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: ColorUtil.tealColor[300],
                      ),
                    ),
                    Text(
                      studentClass.customId,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorUtil.tealColor[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentClass.initialName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        studentClass.studentFreeCard == 1
                            ? "Free Card"
                            : "Non Free Card",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorUtil.tealColor[900],
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocProvider(
                        create: (context) => StudentPercentageBloc()
                          ..add(GetStudentPercentageEvent(
                            studentId: studentClass.studentId,
                            classHasCatId: studentClass.studentStudentClassId,
                          )),
                        child: BlocBuilder<StudentPercentageBloc,
                            StudentPercentageState>(builder: (context, state) {
                          if (state is StudentPercentageSuccess) {
                            final percentage =
                                state.getPercentage.first.percentage!;
                            final presentCount =
                                state.getPercentage.first.presentCount!;
                            final absentCount =
                                state.getPercentage.first.absentCount!;

                            studentDate.add([
                              studentClass.studentFreeCard,
                              studentClass.customId,
                              studentClass.initialName,
                              studentClass.parentNo,
                              percentage,
                              presentCount,
                              absentCount,
                            ]);

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Attendance: $percentage%',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Present Count: $presentCount',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Absent Count: $absentCount',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is StudentPercentageFailure) {
                            return Text(
                              'Failed to load attendance',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[300],
                              ),
                            );
                          }
                          return const Text(
                            'Loading attendance...',
                            style: TextStyle(fontSize: 12),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Move the canceled message here, outside of the row and at the bottom of the column
            studentClass.studentStates == 0
                ? Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      "The class has been canceled.",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            // This will show nothing if student is attending
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text(
          "Student Report",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: downloadPDF,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StudentInTheClassBloc, StudentInTheClassState>(
          builder: (context, state) {
            if (state is StudentInTheClassProcess) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentInTheClassFailure) {
              return Center(
                child: Text(
                  state.failureMessage,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            } else if (state is StudentInTheClassSuccess) {
              final filteredClasses = state.studentInTheClassModel;

              if (filteredClasses.isEmpty) {
                return const Center(
                  child: Text(
                    'No students available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredClasses.length,
                itemBuilder: (context, index) {
                  final studentClass = filteredClasses[index];
                  return buildStudentCard(context, studentClass);
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No data available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
