import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../res/color/app_color.dart';
import '../../bloc/reports/reports_bloc.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  late String _currentDate;
  late TextEditingController _selectDateController;

  @override
  void initState() {
    super.initState();
    _currentDate = DateFormat("yyyy-MM").format(DateTime.now());
    _selectDateController = TextEditingController(text: _currentDate);
    context.read<ReportsBloc>().add(MonthlyReports(selectMonth: _currentDate));
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
        _selectDateController.text = _currentDate;
      });

      if (mounted) {
        context
            .read<ReportsBloc>()
            .add(MonthlyReports(selectMonth: _currentDate));
      }
    }
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
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Column(
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
                "Date: ${DateTime.now().toString().split(' ')[0]}",
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
            ],
          ),
          pw.TableHelper.fromTextArray(
            headers: ["Student ID", "Name", "Class", "Subject", "Amount"],
            data: reports.map((report) {
              return [
                report.studentCusId ?? "-",
                report.studentInitialName ?? "-",
                report.className ?? "-",
                report.subjectName ?? "-",
                report.paymentAmount != null
                    ? report.paymentAmount.toStringAsFixed(2)
                    : "0.00",
              ];
            }).toList(),
          ),
          pw.SizedBox(height: 100),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                // Space for the signature
                pw.Container(
                  width: 150,
                  child: pw.Divider(),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  "Signature:",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Convert List<int> to Uint8List and return
    return pdf.save();
  }

  void downloadPDF(BuildContext context, List<dynamic> studentDate) async {
    try {
      if (studentDate.isEmpty && _selectDateController.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data to generate PDF')),
        );
        return;
      }

      // Generate the PDF data (as Uint8List)
      final pdfData = await generatePDF(studentDate);

      // Share the PDF using Printing plugin
      await Printing.sharePdf(bytes: pdfData, filename: 'student_report.pdf');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error generating PDF: Use the website.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          if (state is ReportsMonthly && state.reportsModel.isNotEmpty) {
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
                  } else if (state is ReportsMonthly) {
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
                                        "Amount: LKR ${report.paymentAmount.toStringAsFixed(2)}",
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
    );
  }
}
