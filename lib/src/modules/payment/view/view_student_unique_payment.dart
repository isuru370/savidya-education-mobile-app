import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import the intl package for date and currency formatting

import '../../../models/payment_model_class/payment_model_class.dart';
import '../../../res/color/app_color.dart';
import '../bloc/get_payment/get_payment_bloc.dart';

class ViewStudentUniquePayment extends StatefulWidget {
  final int studentId;
  final int classCategoryHasStudentClassId;

  const ViewStudentUniquePayment({
    super.key,
    required this.studentId,
    required this.classCategoryHasStudentClassId,
  });

  @override
  State<ViewStudentUniquePayment> createState() =>
      _ViewStudentUniquePaymentState();
}

class _ViewStudentUniquePaymentState extends State<ViewStudentUniquePayment> {
  DateTime? selectedDate;
  late List<PaymentModelClass> filteredPaymentList;
  late List<PaymentModelClass> paymentList;

  @override
  void initState() {
    super.initState();
    paymentList = [];
    filteredPaymentList = [];
    context.read<GetPaymentBloc>().add(
          GetUniqueStudentPaymentEvent(
            studentId: widget.studentId,
            classCategoryHasStudentClassId:
                widget.classCategoryHasStudentClassId,
          ),
        );
  }

  void _filterPaymentsByDate(DateTime? date) {
    setState(() {
      selectedDate = date;
      if (date == null) {
        filteredPaymentList = paymentList;
      } else {
        filteredPaymentList = paymentList.where((payment) {
          final paymentMonth =
              DateFormat('yyyy-MM').format(payment.paymentDate!);
          final selectedMonth = DateFormat('yyyy-MM').format(date);
          return paymentMonth == selectedMonth; // Compare by year-month
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<GetPaymentBloc, GetPaymentState>(
              builder: (context, state) {
                if (state is GetPaymentProcess) {
                  return _buildLoadingIndicator();
                } else if (state is GetPaymentFailure) {
                  return _buildError(state.failureMessage);
                } else if (state is GetPaymentSuccess) {
                  paymentList = state.paymentModelClassList;

                  // Use post-frame callback to call setState after build is complete
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (selectedDate != null) {
                      _filterPaymentsByDate(selectedDate);
                    } else {
                      _filterPaymentsByDate(null);
                    }
                  });

                  return _buildPaymentList(filteredPaymentList);
                } else {
                  return _buildNoDataAvailable();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: ColorUtil.tealColor[10],
      title: const Text(
        "Student Unique Payment",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Center _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Center _buildNoDataAvailable() {
    return const Center(
      child: Text(
        "No Data Available",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }

  ListView _buildPaymentList(List<PaymentModelClass> uniquePaymentList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: uniquePaymentList.length,
      itemBuilder: (context, index) {
        final paymentData = uniquePaymentList[index];
        return _buildPaymentCard(paymentData);
      },
    );
  }

  Card _buildPaymentCard(PaymentModelClass paymentData) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDate(paymentData.paymentDate!),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatTime(paymentData.paymentDate!),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paymentData.className!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              _formatCurrency(paymentData.amount!),
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: Column(
          children: [
            Text(
              paymentData.categoryName!,
              style: TextStyle(
                color: Colors.teal[700], // Text color
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.teal[50], // Light background color
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal[300]!), // Border color
              ),
              child: Text(
                paymentData.paymentFor!,
                style: TextStyle(
                  color: Colors.teal[700], // Text color
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter =
        DateFormat('yyyy-MM-dd'); // Format the date as 'YYYY-MM-DD'
    return formatter.format(date);
  }

  String _formatTime(DateTime date) {
    final DateFormat formatter =
        DateFormat('HH:mm'); // Format the time as 'HH:mm'
    return formatter.format(date);
  }

  String _formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'en_LK',
      symbol: 'LKR ',
    ); // Format currency in Sri Lankan Rupees
    return currencyFormatter.format(amount);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.teal[50], // Light background color
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal[200]!), // Light border
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate == null
                    ? 'Select Month'
                    : DateFormat('MMMM yyyy').format(selectedDate!),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: selectedDate == null ? Colors.grey : Colors.teal[700],
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.teal[200], // Background color for the icon
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      // Delay the setState call using post-frame callback to avoid calling it during the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _filterPaymentsByDate(
            pickedDate); // Update filtered list based on selected date
      });
    }
  }
}
