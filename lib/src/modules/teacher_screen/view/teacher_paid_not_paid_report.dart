import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/payment_model_class/payment_monthly_report_model.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

import '../../../res/color/app_color.dart';
import '../../reports/bloc/reports/reports_bloc.dart';

class TeacherPaidNotPaidReport extends StatefulWidget {
  final int classHasCatId;
  final String gradeName;
  final String className;
  final String categoryName;

  const TeacherPaidNotPaidReport({
    super.key,
    required this.classHasCatId,
    required this.gradeName,
    required this.className,
    required this.categoryName,
  });

  @override
  State<TeacherPaidNotPaidReport> createState() =>
      _TeacherPaidNotPaidReportState();
}

class _TeacherPaidNotPaidReportState extends State<TeacherPaidNotPaidReport> {
  final TextEditingController _selectMonthController = TextEditingController();
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _selectMonthController.clear();
    // Get the current month in yyyy MMM format
    String paymentMonth = DateFormat("yyyy-MM").format(DateTime.now());
    // Trigger the event to get the payment for the selected month
    context.read<ReportsBloc>().add(ClassPaymentMonthlyReports(
        selectMonth: paymentMonth, classHasCatId: widget.classHasCatId));
  }

  List<PaymentMonthlyReportModel> _filterPayments(
      List<PaymentMonthlyReportModel> payments) {
    if (selectedFilter == 'Paid') {
      return payments.where((p) => p.amount != null).toList();
    } else if (selectedFilter == 'Not Paid') {
      return payments.where((p) => p.amount == null).toList();
    } else if (selectedFilter == 'Free Card') {
      return payments.where((p) => p.classFreeCrad == 1).toList();
    }
    return payments;
  }

  // The function to generate PDF from the data
  Future<Uint8List> generatePaymentReportPdf(
      List<PaymentMonthlyReportModel> payments) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          // Institution and Report Details
          pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment:
                  pw.MainAxisAlignment.center, // Ensures vertical centering
              children: [
                pw.Text(
                  'Savidya Higher Education Institute',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Payment Monthly Report',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  widget.className, // Class Name
                  style: const pw.TextStyle(fontSize: 16),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'Grade: ${widget.gradeName}', // Grade
                  style: const pw.TextStyle(fontSize: 16),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  widget.categoryName, // Category
                  style: const pw.TextStyle(fontSize: 16),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Month: ${_selectMonthController.text}', // Selected Month
                  style: const pw.TextStyle(fontSize: 16),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
              ],
            ),
          ),

          // Payment Table
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {
              0: const pw.FlexColumnWidth(1), // Student ID
              1: const pw.FlexColumnWidth(2), // Student Name
              2: const pw.FlexColumnWidth(1.5), // Payment Status
              3: const pw.FlexColumnWidth(2), // Payment Date
              4: const pw.FlexColumnWidth(1.5), // Payment For
              5: const pw.FlexColumnWidth(1), // Amount
            },
            children: [
              // Table Header Row
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('Student ID',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('Student Name',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('Payment Status',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('Payment Date',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('Payment For',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('Amount',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
              // Payment Data Rows
              ...payments.map((payment) {
                return pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        payment.customId,
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        payment.lname,
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        payment.classFreeCrad == 1
                            ? "Free Card"
                            : payment.amount == null
                                ? 'Not Paid'
                                : 'Paid',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        payment.paymentDate ?? 'N/A',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        payment.paymentFor ?? 'N/A',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        payment.amount?.toStringAsFixed(2) ?? '0.00',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
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
      // ignore: use_build_context_synchronously
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
              Text(widget.className,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text('Grade: ${widget.gradeName}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              Text(widget.categoryName,
                  style: const TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download, color: Colors.white),
            onPressed: () {
              final state = context.read<ReportsBloc>().state;
              if (state is ReportsClassPaidNotPaid) {
                generateAndSharePdf(_filterPayments(state.reportsModel));
              }
            },
          ),
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
                        backgroundColor: Colors.red),
                  );
                });
              }
              if (state is ClassEndDateSuccessState) {
                _selectMonthController.text = state.formatDate;
                try {
                  DateTime selectedDate =
                      DateFormat('yyyy-MMM').parse(_selectMonthController.text);
                  String paymentMonth =
                      DateFormat('yyyy-MM').format(selectedDate);

                  context.read<ReportsBloc>().add(ClassPaymentMonthlyReports(
                      selectMonth: paymentMonth,
                      classHasCatId: widget.classHasCatId));
                } catch (e) {
                  debugPrint(e.toString());
                }
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _buildDatePickerCard(),
              );
            },
          ),

          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3))
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedFilter,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: InputBorder.none,
                ),
                items: ['All', 'Paid', 'Not Paid', 'Free Card']
                    .map((filter) => DropdownMenuItem(
                          value: filter,
                          child: Text(filter,
                              style: const TextStyle(fontSize: 16)),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedFilter = value;
                    });
                  }
                },
                dropdownColor: Colors.white,
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.teal, size: 28),
              ),
            ),
          ),

          // Payment List
          Expanded(
            child: BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                if (state is ReportsProcess) {
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 3.0));
                } else if (state is ReportsFailure) {
                  return _buildErrorWidget(state.failureMSG);
                } else if (state is ReportsClassPaidNotPaid) {
                  List<PaymentMonthlyReportModel> filteredList =
                      _filterPayments(state.reportsModel);

                  if (filteredList.isEmpty) {
                    return _buildNoDataWidget();
                  }
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) =>
                        buildPaymentCard(filteredList[index]),
                  );
                } else {
                  return const Center(
                      child: Text('Unexpected state',
                          style: TextStyle(fontSize: 18)));
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
            backgroundImage: NetworkImage(payment.imgUrl),
            radius: 24,
          ),
          title: Text(
            payment.customId,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
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
              payment.classFreeCrad == 1
                  ? Text(
                      "Free Card",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorUtil.blueColor[10],
                      ),
                    )
                  : Text(
                      'Amount: ${payment.amount ?? "Not Paid"}',
                      style: TextStyle(
                        color: payment.amount == null
                            ? Colors.red.shade300
                            : Colors.white,
                        fontSize: 14,
                      ),
                    ),
              payment.classFreeCrad == 1
                  ? const SizedBox.shrink()
                  : payment.amount == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _makeCall(payment.whatsappMobile),
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Student",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _makeCall(payment.parentMobile!),
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Parent",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
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

  // Error Widget
  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          Text(message,
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // No Data Widget
  Widget _buildNoDataWidget() {
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

  Widget _buildDatePickerCard() {
    return GestureDetector(
      onTap: () {
        context
            .read<DatePickerBloc>()
            .add(ClassEndDatePicker(context: context));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black26.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                _selectMonthController.text.isEmpty
                    ? 'Select Month'
                    : _selectMonthController.text,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            const Icon(Icons.date_range, color: Colors.teal),
          ],
        ),
      ),
    );
  }

  // Function to launch the dialer
  void _makeCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
}
