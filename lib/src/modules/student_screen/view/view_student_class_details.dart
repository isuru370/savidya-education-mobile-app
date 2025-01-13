import 'package:aloka_mobile_app/src/models/student/percentage_model_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
import '../../../res/color/app_color.dart';
import '../../class_screen/bloc/class_has_student/class_has_student_bloc.dart';
import '../bloc/change_student_class/chenge_student_class_bloc.dart';

class ViewStudentClassDetails extends StatefulWidget {
  final int studentId;
  final String customId;
  final String initialName;
  const ViewStudentClassDetails({
    super.key,
    required this.studentId,
    required this.customId,
    required this.initialName,
  });

  @override
  State<ViewStudentClassDetails> createState() =>
      _ViewStudentClassDetailsState();
}

class _ViewStudentClassDetailsState extends State<ViewStudentClassDetails> {
  @override
  void initState() {
    super.initState();

    context
        .read<ClassHasStudentBloc>()
        .add(GetClassHasStudentUniqueClassEvent(studentId: widget.studentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Add Class Button
          _buildAddClassButton(),

          // Student List
          Expanded(
            child: BlocBuilder<ChangeStudentClassBloc, ChangeStudentClassState>(
              builder: (context, changeState) {
                if (changeState is ChangeStudentClassProcess) {
                  return _buildLoadingIndicator();
                }
                return BlocBuilder<ClassHasStudentBloc, ClassHasStudentState>(
                  builder: (context, classState) {
                    if (classState is GetClassHasStudentUniqueData) {
                      if (classState.getUniqueStudent.isEmpty) {
                        return _buildNoDataAvailable();
                      }
                      return _buildStudentList(
                        classState.getUniqueStudent,
                        classState.getPercentage,
                      );
                    }
                    return const SizedBox();
                  },
                );
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
        "View Details",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Center _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Center _buildNoDataAvailable() {
    return const Center(child: Text("No data available"));
  }

  // Add Class Button
  Padding _buildAddClassButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed('/add_student_class', arguments: {
            "student_id": widget.studentId,
            "student_custom_id": widget.customId,
            "student_initial_name": widget.initialName,
            "is_bottom_nav_bar": false,
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          "Add Class",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ListView _buildStudentList(
      List<StudentHasCategoryHasClassModelClass> students,
      List<PercentageModelClass> percentage) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final studentData = students[index];
        final studentPercentage = percentage[index] ;
        return _buildStudentCard(studentData, studentPercentage);
      },
    );
  }

  Card _buildStudentCard(StudentHasCategoryHasClassModelClass studentData,
      PercentageModelClass percentage) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentInfo(studentData, percentage),
            const SizedBox(height: 16),
            _buildActionButtons(studentData),
          ],
        ),
      ),
    );
  }

  Row _buildStudentInfo(StudentHasCategoryHasClassModelClass studentData,
      PercentageModelClass percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studentData.teacherInitialName!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                studentData.className!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                studentData.categoryName!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal[400],
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 4),
              studentData.studentClassFreeCard! == 1
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorUtil.roseColor[10],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ColorUtil.tealColor[20]!,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Free Card",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorUtil.whiteColor[10],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        SizedBox(
          width: 80, // Constrain the width
          child: CircularPercentIndicator(
            radius: 35.0, // Reduced radius
            lineWidth: 8.0, // Adjust line width
            percent: (percentage.attendancePercentage?.toDouble() ?? 0.0),
            center: Text(
              '${(percentage.percentage ?? 0.0).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 12), // Reduce font size
            ),
            progressColor: ColorUtil.tealColor[10],
          ),
        ),
      ],
    );
  }

  Row _buildActionButtons(StudentHasCategoryHasClassModelClass studentData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(studentData, 'Payments', Colors.blue, Colors.white),
        _buildActionButton(
            studentData, 'Attendance', Colors.green, Colors.white),
      ],
    );
  }

  TextButton _buildActionButton(
      StudentHasCategoryHasClassModelClass studentData,
      String label,
      Color backgroundColor,
      Color textColor) {
    return TextButton(
      onPressed: () {
        if (label == 'Payments') {
          Navigator.of(context, rootNavigator: true)
              .pushNamed('/view_student_unique_payment', arguments: {
            "student_id": widget.studentId,
            "class_category_has_student_class_id": studentData.classHasCatId,
          });
        } else if (label == 'Attendance') {
          Navigator.of(context, rootNavigator: true)
              .pushNamed('/unique_attendance', arguments: {
            "studentId": widget.studentId,
            "class_category_has_student_class_id": studentData.classHasCatId,
            "student_has_class_id" : studentData.studentHasClassesId,
          });
        } else {
          Navigator.of(context, rootNavigator: true).pushNamed('/');
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
