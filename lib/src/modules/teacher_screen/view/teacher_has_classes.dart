import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../models/teacher/teacher.dart';
import '../../../res/color/app_color.dart';
import '../../class_screen/bloc/class_bloc/class_bloc_bloc.dart';

class TeacherHasClasses extends StatefulWidget {
  final TeacherModelClass teacherModelClass;

  const TeacherHasClasses({super.key, required this.teacherModelClass});

  @override
  State<TeacherHasClasses> createState() => _TeacherHasClassesState();
}

class _TeacherHasClassesState extends State<TeacherHasClasses> {
  @override
  void initState() {
    super.initState();
    context.read<ClassBlocBloc>().add(GetActiveClass());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorUtil.tealColor[10],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Classes",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              widget.teacherModelClass.fullName ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              _downloadPdf(context, widget.teacherModelClass);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ClassBlocBloc, ClassBlocState>(
          builder: (context, state) {
            if (state is GetActiveClassSuccess) {
              final filteredClasses = state.studentModelClass
                  .where((activeClass) =>
                      activeClass.teacherId == widget.teacherModelClass.id)
                  .toList();

              if (filteredClasses.isEmpty) {
                return const Center(
                  child: Text(
                    'No classes available for this teacher.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredClasses.length,
                itemBuilder: (context, index) {
                  final activeClass = filteredClasses[index];
                  final formattedDate = convertDate(activeClass.createdAt);

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          '/teacher_has_category_screen',
                          arguments: {
                            'teacher_class_id': activeClass.id,
                            'grade_name' : activeClass.gradeName,
                            'teacher_name' : activeClass.teacherInitialName,
                            'class_name' : activeClass.className,
                          });
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Badge(
                              backgroundColor: activeClass.isOngoing != null
                                  ? Colors.green
                                  : Colors.red,
                              smallSize: 15,
                              child: Icon(
                                Icons.class_,
                                color: ColorUtil.tealColor[10],
                                size: 40,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activeClass.className ?? 'Class Name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.blackColor[10],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Grade: ${activeClass.gradeName ?? 'Grade Name'}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorUtil.blackColor[14],
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 4),
                                  Text(
                                    'Created At: $formattedDate',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is ClassDataProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ClassDataFailure) {
              return Center(
                child: Text(
                  state.failureMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
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

  String convertDate(DateTime? createdAt) {
    if (createdAt == null) return 'Unknown';
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(createdAt);
  }

  // Future<Uint8List> _loadSignature() async {
  //   try {
  //     final byteData = await rootBundle
  //         .load('assets/logo/brr.png'); // Adjust the path to your asset
  //     return byteData.buffer.asUint8List();
  //   } catch (e) {
  //     throw Exception("Failed to load signature image: $e");
  //   }
  // }

  Future<void> _downloadPdf(
      BuildContext context, TeacherModelClass teacherModelClass) async {
    final pdf = pw.Document();
    final classBlocState = context.read<ClassBlocBloc>().state;

    if (classBlocState is GetActiveClassSuccess) {
      // Filter classes for the teacher
      final filteredClasses = classBlocState.studentModelClass
          .where((activeClass) => activeClass.teacherId == teacherModelClass.id)
          .toList();

      // Calculate totals
      final totalClasses = filteredClasses.length;
      final activeClassesCount =
          filteredClasses.where((c) => c.isOngoing == 1).length;
      final inactiveClassesCount =
          filteredClasses.where((c) => c.isOngoing == 0).length;

      // Add PDF content
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Savidya Higher Education Institute",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "Teacher: ${teacherModelClass.fullName}",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                "Total Classes: $totalClasses",
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                "Active Classes: $activeClassesCount",
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                "Inactive Classes: $inactiveClassesCount",
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                "Classes:",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.TableHelper.fromTextArray(
                headers: ['Class Name', 'Grade Name'],
                data: filteredClasses
                    .map((c) =>
                        [c.className ?? '', "Grade: ${c.gradeName ?? ''}"])
                    .toList(),
              ),
            ],
          ),
        ),
      );

      try {
        // Share the PDF
        await Printing.sharePdf(
          bytes: await pdf.save(),
          filename: 'teacher_class_report.pdf',
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating PDF: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to generate PDF. Data is not available.'),
        ),
      );
    }
  }
}
