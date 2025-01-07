import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/slidable_details_view_widget.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../res/color/app_color.dart';
import '../../home_screen/arguments/student_editable.dart';
import '../bloc/get_student/get_student_bloc.dart';

class AllStudentScreen extends StatefulWidget {
  final bool studentEditable;
  const AllStudentScreen({super.key, required this.studentEditable});

  @override
  State<AllStudentScreen> createState() => _AllStudentScreenState();
}

class _AllStudentScreenState extends State<AllStudentScreen> {
  int? studentGradeId;
  String? dateOnly;
  String searchQuery = ''; // Add search query
  final TextEditingController searchController =
      TextEditingController(); // Add controller

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
        title: const Text("All Student"),
      ),
      body: Column(
        children: [
          // Add search field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by student name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Update search query
                });
              },
            ),
          ),
          // Filter by grade
          Container(
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
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          margin: const EdgeInsets.only(right: 8.0),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: studentGradeId == null
                                ? ColorUtil.whiteColor[14]
                                : ColorUtil.tealColor[10],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'All Grades',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: studentGradeId == null
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ...state.getGradeList.map((grade) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              studentGradeId = grade.id;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 50,
                            margin: const EdgeInsets.only(right: 8.0),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: studentGradeId == grade.id
                                  ? ColorUtil.whiteColor[14]
                                  : ColorUtil.tealColor[10],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${grade.gradeName} Grade',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: studentGradeId == grade.id
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<GetStudentBloc, GetStudentState>(
              builder: (context, state) {
                if (state is GetAllActiveStudentSuccess) {
                  final filteredStudents = state.activeStudentList
                      .where((activeStudent) =>
                          (studentGradeId == null ||
                              activeStudent.gradeId == studentGradeId) &&
                          (searchQuery.isEmpty ||
                              activeStudent.initialName!
                                  .toLowerCase()
                                  .contains(searchQuery) ||
                              activeStudent.cusId!
                                  .toLowerCase()
                                  .contains(searchQuery)))
                      .toList();

                  return ListView(
                    children: filteredStudents.map((activeStudent) {
                      convertDate(activeStudent.createdAt!);
                      return SlidableDetailsViewWidget(
                        onTap: (cxt) {
                          widget.studentEditable
                              ? Navigator.of(cxt, rootNavigator: true)
                                  .pushNamed('/student',
                                      arguments: StudentEditable(
                                          editable: true,
                                          studentModelClass: activeStudent))
                              : Navigator.of(cxt, rootNavigator: true)
                                  .pushNamed('/view_student', arguments: {
                                  'student_model_class': activeStudent,
                                });
                        },
                        circleWidget: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(activeStudent.studentImageUrl!),
                        ),
                        contend: "${activeStudent.initialName}",
                        subContend: "${activeStudent.mobileNumber} ",
                        joinDate: dateOnly!,
                        icon:
                            widget.studentEditable ? Icons.edit : Icons.report,
                
                      );
                    }).toList(),
                  );
                } else if (state is GetStudentDataProcess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetStudentDataFailure) {
                  return Center(
                    child: Text(state.failureMessage),
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void convertDate(DateTime createAt) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    dateOnly = dateFormat.format(createAt);
  }
}
