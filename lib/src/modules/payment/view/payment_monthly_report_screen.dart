import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aloka_mobile_app/src/modules/payment/bloc/payment_monthly_report/payment_monthly_report_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import '../../../models/payment_model_class/payment_monthly_report_model.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class PaymentMonthlyReportScreen extends StatefulWidget {
  final int classHasCatId;
  final String gradeName;
  final String className;
  final String categoryName;

  const PaymentMonthlyReportScreen({
    super.key,
    required this.classHasCatId,
    required this.gradeName,
    required this.className,
    required this.categoryName,
  });

  @override
  State<PaymentMonthlyReportScreen> createState() =>
      _PaymentMonthlyReportScreenState();
}

class _PaymentMonthlyReportScreenState
    extends State<PaymentMonthlyReportScreen> {
  final TextEditingController _selectMonthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectMonthController.clear();
    // Get the current month in yyyy MMM format
    String paymentMonth = DateFormat('yyyy MMM').format(DateTime.now());
    // Trigger the event to get the payment for the selected month
    context.read<PaymentMonthlyReportBloc>().add(GetMonthlyPaymentEvent(
        paymentMonth: paymentMonth, classHasCatId: widget.classHasCatId));
  }

  // The function to generate PDF from the data
  Future<Uint8List> generatePaymentReportPdf(
      List<PaymentMonthlyReportModel> payments) async {
    final pdf = pw.Document();

    // Add a page to the PDF document
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment:
                    pw.MainAxisAlignment.center, // Ensures vertical centering
                children: [
                  // Institution Name
                  pw.Text(
                    'Savidya Higher Education Institute',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Payment Student Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    widget.className, // Class name
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.Text(
                    'Grade: ${widget.gradeName}', // Grade name
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    widget.categoryName, // Category name
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Month: ${_selectMonthController.text}', // Selected month
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // Table
                  pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      // Table Header
                      pw.TableRow(children: [
                        pw.Text(
                          'Student ID',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          'Student Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          'Payment Status',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          'Payment Date',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ]),
                      // Adding rows of payment data
                      for (var payment in payments)
                        pw.TableRow(children: [
                          pw.Text(payment.customId), // Student ID
                          pw.Text(payment.lname), // Student Name
                          pw.Text(payment.amount == null
                              ? 'Not Paid'
                              : 'Paid'), // Payment Status
                          pw.Text(payment.paymentDate ?? 'N/A'), // Payment Date
                        ])
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

// Function to trigger the PDF generation and sharing
  void generateAndSharePdf(List<PaymentMonthlyReportModel> payments) async {
    try {
      // Generate PDF
      Uint8List pdfData = await generatePaymentReportPdf(payments);

      // Send the PDF via WhatsApp (or any other platform)
      // In this case, we can use the printing package to open the PDF file
      await Printing.sharePdf(bytes: pdfData, filename: 'payment_report.pdf');
    } catch (e) {
      log('Error generating PDF: $e');

      // If you're in a StatefulWidget or have access to BuildContext
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error generating PDF: Use the website.'),
          backgroundColor: Colors.red,
        ),
      );
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: ColorUtil.tealColor[10],
        elevation: 5,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.className,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Grade: ${widget.gradeName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.categoryName,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download, color: Colors.white),
            onPressed: () {
              // Access the state and get the list of payments, ensuring it's a List<PaymentMonthlyReportModel>
              final payments = context.read<PaymentMonthlyReportBloc>().state
                      is MonthlyPaymentSuccess
                  ? (context.read<PaymentMonthlyReportBloc>().state
                          as MonthlyPaymentSuccess)
                      .paymentMonthlyReport
                  : [];

              // Cast the list to List<PaymentMonthlyReportModel> explicitly
              generateAndSharePdf(payments.cast<PaymentMonthlyReportModel>());
            },
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<DatePickerBloc, DatePickerState>(
            builder: (context, state) {
              if (state is DatePickerFailure) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              } else if (state is ClassEndDateSuccessState) {
                _selectMonthController.text = state.formatDate;

                // Modify the format to handle 'yyyy-MMM' (e.g., 2024-Dec)
                try {
                  DateTime selectedDate =
                      DateFormat('yyyy-MMM').parse(_selectMonthController.text);

                  // Then format it correctly
                  String paymentMonth =
                      DateFormat('yyyy MMM').format(selectedDate);

                  context.read<PaymentMonthlyReportBloc>().add(
                        GetMonthlyPaymentEvent(
                          paymentMonth: paymentMonth,
                          classHasCatId: widget.classHasCatId,
                        ),
                      );
                } catch (e) {
                  log(e.toString());
                  // Handle the error accordingly, e.g., show a snackbar or fallback value
                }
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildDatePickerCard(
                  controller: _selectMonthController,
                  hintText: 'Select Month',
                  icon: Icons.date_range,
                  onTap: () {
                    context
                        .read<DatePickerBloc>()
                        .add(ClassEndDatePicker(context: context));
                  },
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<PaymentMonthlyReportBloc,
                PaymentMonthlyReportState>(
              builder: (context, state) {
                if (state is MonthlyPaymentProcess) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                    ),
                  );
                } else if (state is MonthlyPaymentFailure) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          state.failureMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is MonthlyPaymentSuccess) {
                  if (state.paymentMonthlyReport.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.no_accounts, size: 40),
                          SizedBox(height: 8),
                          Text('No data found', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.paymentMonthlyReport.length,
                    itemBuilder: (context, index) {
                      final payment = state.paymentMonthlyReport[index];
                      return buildPaymentCard(payment);
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Unexpected state',
                        style: TextStyle(fontSize: 18)),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentCard(PaymentMonthlyReportModel payment) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtil.blackColor[16],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                payment.imgUrl), // Use a default image if none exists
            radius: 24, // Adjust the size of the image
          ),
          title: Text(
            payment.customId,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white, // White text for better contrast
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                payment.lname,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'Amount: ${payment.amount ?? "Not Paid"}',
                style: TextStyle(
                  color: payment.amount == null
                      ? Colors.red.shade300
                      : Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Date part
              Text(
                _formatDate(payment.paymentDate),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              // Time part (if available)
              Text(
                _formatTime(payment.paymentDate),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerCard({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.teal),
          onPressed: onTap,
        ),
      ),
    );
  }

  String _formatDate(String? paymentDate) {
    if (paymentDate == null) return '';
    try {
      // Assuming paymentDate is in 'yyyy-MM-dd HH:mm:ss' format
      DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(paymentDate);
      return DateFormat('yyyy MMM dd')
          .format(dateTime); // Displaying date in 'yyyy MMM dd' format
    } catch (e) {
      return '';
    }
  }

  String _formatTime(String? paymentDate) {
    if (paymentDate == null) return '';
    try {
      // Assuming paymentDate is in 'yyyy-MM-dd HH:mm:ss' format
      DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(paymentDate);
      return DateFormat('hh:mm a').format(
          dateTime); // Displaying time in 'hh:mm a' format (12-hour format with AM/PM)
    } catch (e) {
      return '';
    }
  }
}
