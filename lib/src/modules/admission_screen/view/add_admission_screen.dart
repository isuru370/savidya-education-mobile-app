import 'package:aloka_mobile_app/src/extensions/str_extensions.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import intl package

import '../../../components/app_text_field.dart';
import '../../../components/button/app_main_button.dart';
import '../../../models/admission/admission_model_class.dart';
import '../bloc/admission/admission_bloc.dart';
import '../bloc/get_admission/get_admission_bloc.dart';

class AddAdmissionScreen extends StatefulWidget {
  const AddAdmissionScreen({super.key});

  @override
  State<AddAdmissionScreen> createState() => _AddAdmissionScreenState();
}

class _AddAdmissionScreenState extends State<AddAdmissionScreen> {
  final TextEditingController admissionFees = TextEditingController();
  final TextEditingController admissionName = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetAdmissionBloc>().add(GetAdmission());
  }

  // Function to format the amount in Sri Lankan Rupees
  String formatAmount(double amount) {
    final NumberFormat formatCurrency = NumberFormat.currency(
      locale: 'si_LK', // Sri Lanka locale for currency
      symbol: 'LKR', // Sri Lankan Rupees symbol
    );
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("Add Admission"),
      ),
      body: BlocListener<AdmissionBloc, AdmissionState>(
        listener: (context, state) {
          if (state is AddAdmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
              ),
            );
          } else if (state is AddAdmissionSuccess) {
            admissionFees.clear();
            admissionName.clear();
            context.read<GetAdmissionBloc>().add(GetAdmission());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
          }
        },
        child: BlocBuilder<AdmissionBloc, AdmissionState>(
          builder: (context, state) {
            if (state is AddAdmissionProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    MyTextField(
                        controller: admissionFees,
                        hintText: "Admission Fees",
                        inputType: TextInputType.number,
                        obscureText: false,
                        icon: const Icon(null)),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        controller: admissionName,
                        hintText: "Admission Name",
                        inputType: TextInputType.text,
                        obscureText: false,
                        icon: const Icon(null)),
                    AppMainButton(
                      testName: 'Admission Save',
                      onTap: () {
                        if (admissionFees.text.isNotEmpty &&
                            admissionName.text.isNotEmpty) {
                          insertAdmission();
                        }
                      },
                      height: 50,
                    ),
                    SizedBox(
                      height: 300,
                      child: BlocBuilder<GetAdmissionBloc, GetAdmissionState>(
                        builder: (context, state) {
                          if (state is GetAdmissionProcess) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetAdmissionFailure) {
                            return const Center(
                              child: Text("Data not found"),
                            );
                          } else if (state is GetAdmissionSuccess) {
                            return ListView.builder(
                              itemCount: state.admissionModel.length,
                              itemBuilder: (context, index) {
                                final admission = state.admissionModel[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  elevation: 4, // Add shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15), // Rounded corners
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              admission.admissionName!,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(
                                                height:
                                                    4), // Space between name and fees
                                            Text(
                                              formatAmount(
                                                  admission.admissionAmount!),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons
                                              .school, // Icon to represent admission, you can choose another
                                          color: Colors.teal,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("Data not found"),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void insertAdmission() {
    AdmissionModelClass admissionModelClass = AdmissionModelClass(
      admissionAmount: double.parse(admissionFees.text),
      admissionName: admissionName.text.firstCapital,
    );
    context
        .read<AdmissionBloc>()
        .add(AddAdmissionEvent(admissionModelClass: admissionModelClass));
  }
}
