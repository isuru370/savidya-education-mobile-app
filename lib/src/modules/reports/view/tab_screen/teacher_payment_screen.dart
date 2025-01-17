import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../components/drop_down_button_widget.dart';
import '../../../../models/teacher/teacher.dart';
import '../../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../../res/color/app_color.dart';
import '../../../teacher_screen/bloc/teacher_bloc/teacher_bloc.dart';
import '../../bloc/reports/reports_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class TeacherPaymentScreen extends StatefulWidget {
  const TeacherPaymentScreen({super.key});

  @override
  State<TeacherPaymentScreen> createState() => _TeacherPaymentScreenState();
}

class _TeacherPaymentScreenState extends State<TeacherPaymentScreen> {
  String? _currentDate;
  int? teacherId;
  late TextEditingController _selectDateController;

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(GetTeacherData());
    // Initialize the TextEditingController
    _selectDateController = TextEditingController();
  }

  @override
  void dispose() {
    _selectDateController.dispose();
    super.dispose();
  }


  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _currentDate = DateFormat("yyyy-MM").format(pickedDate);
        _selectDateController.text = _currentDate!;
      });

      if (teacherId != null) {
        context.read<ReportsBloc>().add(
          TeacherPaymentMonthlyReports(
            selectMonth: _currentDate!,
            teacherId: teacherId!,
          ),
        );
      }
    }
  }


  @override
  Widget getTeacher(List<TeacherModelClass> getTeacherList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Teacher'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectTeacher,
          items: getTeacherList.map((TeacherModelClass teacher) {
            return DropdownMenuItem<TeacherModelClass>(
              value: teacher,
              child: Text("${teacher.teacherCusId} ${teacher.initialName}"),
            );
          }).toList(),
          onChanged: (TeacherModelClass? newTeacher) {
            if (newTeacher != null) {
              // Update the selected teacher in the DropdownButtonCubit
              context.read<DropdownButtonCubit>().selectTeacher(newTeacher);

              // Update the local teacherId and dispatch the ReportsBloc event
              setState(() {
                teacherId = newTeacher.id;
              });

              if (_currentDate != null) {
                // Dispatch the ReportsBloc event with the selected teacher ID and date
                context.read<ReportsBloc>().add(
                  TeacherPaymentMonthlyReports(
                    selectMonth: _currentDate!,
                    teacherId: teacherId!,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select a Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _selectDateController,
              readOnly: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.calendar_today),
                hintText: "Select a date",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtil.tealColor[10]!),
                ),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 10),
            BlocBuilder<TeacherBloc, TeacherState>(
              builder: (context, state) {
                if (state is GetTeacherSuccess) {
                  return DropDownButtonWidget(
                    widget: getTeacher(state.getActiveTeacherList),
                  );
                } else if (state is GetTeacherFailure) {
                  return Text('Error: ${state.message}');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ReportsBloc, ReportsState>(
                builder: (context, state) {
                  if (state is ReportsProcess) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ReportsFailure) {
                    return const Center(
                      child: Text("No payment today."),
                    );
                  } else if (state is ReportsTeacherPayment) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Report Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.reportsModel.length,
                            itemBuilder: (context, index) {
                              final report = state.reportsModel[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Student ID: ${report.studentCusId ?? '-'}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          "Name: ${report.studentInitialName ?? '-'}"),
                                      Text("Class: ${report.className ?? '-'}"),
                                      Text("Grade: ${report.gradeName ?? '-'}"),
                                      Text(
                                          "Subject: ${report.subjectName ?? '-'}"),
                                      Text(
                                        "Amount: \$${report.paymentAmount.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          if (state is ReportsTeacherPayment && state.reportsModel.isNotEmpty) {
            return FloatingActionButton.extended(
              onPressed: () => downloadPDF(context, state.reportsModel),
              label: const Text("Download PDF"),
              icon: const Icon(Icons.download),
              backgroundColor: ColorUtil.tealColor[10],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<Uint8List> generatePDF(List<dynamic> reports) async {
    // Calculate the total amount and student count
    int studentCount = reports.length;
    double totalAmount = reports.fold(0.0, (sum, report) {
      return sum +
          (report.paymentAmount ?? 0.0); // Adds each student's paymentAmount
    });

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Monthly Report",
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Date: $_currentDate", // Ensure _currentDate is properly initialized
              style: const pw.TextStyle(fontSize: 16),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Student Count: $studentCount",
              style: const pw.TextStyle(fontSize: 16),
            ),
            pw.Text(
              "Total Amount: LKR ${totalAmount.toStringAsFixed(2)}",
              style: const pw.TextStyle(fontSize: 16),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ["Student ID", "Name", "Class", "Subject", "Amount"],
              data: reports.map((report) {
                return [
                  report.studentCusId ?? "-",
                  report.studentInitialName ?? "-",
                  report.className ?? "-",
                  report.subjectName ?? "-",
                  report.paymentAmount.toStringAsFixed(2),
                ];
              }).toList(),

            ),
          ],
        ),
      ),
    );

    // Convert List<int> to Uint8List and return
    return pdf.save();
  }

  void downloadPDF(BuildContext context, List<dynamic> studentDate) async {
    if (studentDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data to generate PDF')),
      );
      return;
    }

    // Generate the PDF data (as Uint8List)
    final pdfData = await generatePDF(studentDate);

    // Share the PDF using Printing plugin
    await Printing.sharePdf(bytes: pdfData, filename: 'student_report.pdf');
  }
}

