import 'package:aloka_mobile_app/src/modules/admission_screen/bloc/get_admission/get_admission_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/admission/admission_model_class.dart';
import '../../../models/admission/admission_payment_model.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../student_screen/bloc/get_student/get_student_bloc.dart';
import '../../../res/color/app_color.dart';
import '../bloc/admission_payment/admission_payment_bloc.dart';

class AddStudentAdmission extends StatefulWidget {
  const AddStudentAdmission({super.key});

  @override
  State<AddStudentAdmission> createState() => _AddStudentAdmissionState();
}

class _AddStudentAdmissionState extends State<AddStudentAdmission> {
  int? studentGradeId;
  int? admissionId;
  double? admissionAmount;
  String? dateOnly;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<GetStudentBloc>().add(GetActiveStudentData());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
    context.read<GetAdmissionBloc>().add(GetAdmission());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text(
          "Admission",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<AdmissionPaymentBloc, AdmissionPaymentState>(
        listener: (context, state) {
          if (state is AdmissionPaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failureMessage)),
            );
          } else if (state is AdmissionPaymentSuccess) {
            context.read<GetStudentBloc>().add(GetActiveStudentData());
            context.read<StudentGradeBloc>().add(GetStudentGrade());
            context.read<GetAdmissionBloc>().add(GetAdmission());
            context.read<DropdownButtonCubit>().selectAdmission(null);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage)),
            );
          }
        },
        child: BlocBuilder<AdmissionPaymentBloc, AdmissionPaymentState>(
          builder: (context, state) {
            if (state is AdmissionPaymentProcess) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                _buildGradeSelectionArea(),
                _buildSearchBar(),
                _buildStudentListArea(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGradeSelectionArea() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      height: 80,
      child: BlocBuilder<StudentGradeBloc, StudentGradeState>(
        builder: (context, state) {
          if (state is GetStudentGradeSuccess) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      studentGradeId = null;
                    });
                  },
                  child: gradeChip(
                    label: 'All Grades',
                    selected: studentGradeId == null,
                  ),
                ),
                ...state.getGradeList.map((grade) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        studentGradeId = grade.id;
                      });
                    },
                    child: gradeChip(
                      label: '${grade.gradeName} Grade',
                      selected: studentGradeId == grade.id,
                    ),
                  );
                }),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Search by cusId, name, or date',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim().toLowerCase();
          });
        },
      ),
    );
  }

  Widget _buildStudentListArea() {
    return Expanded(
      child: BlocBuilder<GetStudentBloc, GetStudentState>(
        builder: (context, state) {
          if (state is GetAllActiveStudentSuccess) {
            final filteredStudents = state.activeStudentList.where((student) {
              final matchesGrade =
                  studentGradeId == null || student.gradeId == studentGradeId;
              final matchesSearch = student.cusId
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery) ||
                  (student.initialName ?? "")
                      .toLowerCase()
                      .contains(_searchQuery) ||
                  (convertDate(student.createdAt) ?? "")
                      .toLowerCase()
                      .contains(_searchQuery);
              return matchesGrade && matchesSearch;
            }).toList();

            if (filteredStudents.isEmpty) {
              return const Center(
                child: Text('No students match your search criteria.'),
              );
            }

            return ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final activeStudent = filteredStudents[index];

                return activeStudent.admission! == 0
                    ? Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStudentInfo(activeStudent),
                              _buildPaymentButton(activeStudent),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            );
          } else if (state is GetStudentDataProcess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetStudentDataFailure) {
            return Center(child: Text(state.failureMessage));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildStudentInfo(activeStudent) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activeStudent.initialName!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'ID: ${activeStudent.cusId!}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Register Date: ${convertDate(activeStudent.createdAt)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(activeStudent) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        _showAdmissionDialog(activeStudent);
      },
      child: const Text(
        'Pay',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showAdmissionDialog(activeStudent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Admission'),
          content: BlocBuilder<GetAdmissionBloc, GetAdmissionState>(
            builder: (context, state) {
              if (state is GetAdmissionSuccess) {
                return studentAdmission(state.admissionModel);
              } else if (state is GetAdmissionFailure) {
                return const Text('Error: admission data not found');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                AdmissionPaymentModelClass admissionPaymentModelClass =
                    AdmissionPaymentModelClass(
                  admissionId: admissionId,
                  amount: admissionAmount,
                  studentId: activeStudent.id,
                );

                context.read<AdmissionPaymentBloc>().add(AdmissionPayment(
                    admissionPaymentModelClass: admissionPaymentModelClass));
              },
              child: const Text('Pay'),
            ),
          ],
        );
      },
    );
  }

  String? convertDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
    return null;
  }

  Widget gradeChip({required String label, required bool selected}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Chip(
        label: Text(label),
        backgroundColor: selected ? Colors.teal : Colors.grey[300],
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget studentAdmission(List<AdmissionModelClass> admissions) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton<int>(
          value: admissionId,
          hint: const Text('Select Admission'),
          isExpanded: true,
          items: admissions.map((admission) {
            return DropdownMenuItem<int>(
              value: admission.admissionId,
              child: Text(
                '${admission.admissionName} - \$${admission.admissionAmount}',
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                admissionId = value;
                admissionAmount = admissions
                    .firstWhere((admission) => admission.admissionId == value)
                    .admissionAmount;
              });
            }
          },
        );
      },
    );
  }
}
