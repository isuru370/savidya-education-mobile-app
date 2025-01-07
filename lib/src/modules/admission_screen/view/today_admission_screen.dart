import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/admission_payment/admission_payment_bloc.dart';

class TodayAdmissionScreen extends StatefulWidget {
  const TodayAdmissionScreen({super.key});

  @override
  State<TodayAdmissionScreen> createState() => _TodayAdmissionScreenState();
}

class _TodayAdmissionScreenState extends State<TodayAdmissionScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching today's admission payments
    context.read<AdmissionPaymentBloc>().add(TodayAdmissionPaymentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Admission Payments"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<AdmissionPaymentBloc, AdmissionPaymentState>(
        builder: (context, state) {
          if (state is AdmissionPaymentProcess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AdmissionPaymentFailure) {
            return const Center(
              child: Text(
                'Failed to load admission payments.',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else if (state is TodayAdmissionPaymentSuccess) {
            if (state.todayAdmissionPayment.isEmpty) {
              return const Center(
                child: Text(
                  'No admissions payments found for today.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.todayAdmissionPayment.length,
              itemBuilder: (context, index) {
                final payment = state.todayAdmissionPayment[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                payment.stuInitialName?.substring(0, 1) ?? '?',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    payment.stuInitialName ?? "No Name",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Student ID: ${payment.stuCustomId}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 20,
                          color: Colors.grey,
                        ),
                        Text(
                          'Admission: ${payment.admissionName}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Amount: LKR ${payment.amount?.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Unexpected error occurred.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
