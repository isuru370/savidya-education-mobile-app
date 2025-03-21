import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/grade_chip_widget.dart';
import '../../../models/student/grade.dart';
import '../../../models/student/student.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../res/color/app_color.dart';
import '../bloc/get_student/get_student_bloc.dart';

class ChangeGradeScreen extends StatefulWidget {
  const ChangeGradeScreen({super.key});

  @override
  State<ChangeGradeScreen> createState() => _ChangeGradeScreenState();
}

class _ChangeGradeScreenState extends State<ChangeGradeScreen> {
  int? selectedCurrentGradeId; // Grade to filter students
  Grade? selectedNewGrade; // New grade to update students to
  int? studentGradeId;
  List<StudentModelClass> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    context.read<GetStudentBloc>().add(GetActiveStudentData());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("Change Student Grades"),
      ),
      body: BlocListener<GetStudentBloc, GetStudentState>(
        listener: (context, state) {
          if (state is UpdateStudentGradeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is GetStudentDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.failureMessage}")),
            );
          }
        },
        child: Column(
          children: [
            // Grade Filter
            _buildGradeFilter(),

            // Student List
            Expanded(child: _buildStudentList()),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => updateAllStudentsInGrade(context),
          child: const Text('Update Grade for All'),
        ),
      ),
    );
  }

  // Widget: Grade Filter
  Widget _buildGradeFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      height: 80,
      child: BlocBuilder<StudentGradeBloc, StudentGradeState>(
        builder: (context, state) {
          if (state is GetStudentGradeSuccess) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: state.getGradeList.map((grade) {
                return GestureDetector(
                  onTap: () =>
                      setState(() => selectedCurrentGradeId = grade.id),
                  child: GradeChipWidget(
                    label: '${grade.gradeName} Grade',
                    selected: selectedCurrentGradeId == grade.id,
                  ),
                );
              }).toList(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // Widget: Student List
  Widget _buildStudentList() {
    return BlocBuilder<GetStudentBloc, GetStudentState>(
      builder: (context, state) {
        if (state is GetAllActiveStudentSuccess) {
          filteredStudents = state.activeStudentList
              .where((student) =>
                  selectedCurrentGradeId == null ||
                  student.gradeId == selectedCurrentGradeId)
              .toList();

          return ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              return Card(
                child: ListTile(
                  title: Text(student.initialName!,
                      style: const TextStyle(fontSize: 16)),
                  subtitle: Text("Current Grade: ${student.gradeName}"),
                ),
              );
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
    );
  }

  // Update all students in the selected grade
  void updateAllStudentsInGrade(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select New Grade'),
          content: BlocBuilder<StudentGradeBloc, StudentGradeState>(
            builder: (context, state) {
              if (state is GetStudentGradeSuccess) {
                return studentGradeDropdown(state.getGradeList);
              } else if (state is GetStudentGradeFailure) {
                return Text('Error: ${state.message}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (studentGradeId != null) {
                  confirmUpdate(context, filteredStudents);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // Dropdown for selecting a new grade
  Widget studentGradeDropdown(List<Grade> getGradeList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<Grade>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Grade'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectedGrade,
          items: getGradeList.map((Grade grade) {
            return DropdownMenuItem<Grade>(
              value: grade,
              child: Text("${grade.gradeName} Grade"),
            );
          }).toList(),
          onChanged: (Grade? newGrade) {
            if (newGrade != null) {
              context.read<DropdownButtonCubit>().selectGrade(newGrade);
              setState(() {
                studentGradeId = newGrade.id; // Update grade ID
              });
            }
          },
        );
      },
    );
  }

  // Confirm & update all students to the selected grade
  void confirmUpdate(
      BuildContext context, List<StudentModelClass> filteredStudents) {
    if (studentGradeId == null) return;

    for (var student in filteredStudents) {
      context.read<GetStudentBloc>().add(UpdateStudentsGrade(
            studentId: student.id!,
            gradeId: studentGradeId!,
          ));
    }

    Navigator.pop(context); // Close the dialog
  }
}
