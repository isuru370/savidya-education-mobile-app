import 'package:aloka_mobile_app/src/modules/class_screen/bloc/class_bloc/class_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/grade_chip_widget.dart';
import '../../../components/slidable_details_view_widget.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../res/color/app_color.dart';

class AllClassScreen extends StatefulWidget {
  final bool classEditable;
  const AllClassScreen({super.key, required this.classEditable});

  @override
  State<AllClassScreen> createState() => _AllClassScreenState();
}

class _AllClassScreenState extends State<AllClassScreen> {
  int? studentGradeId;
  String? dateOnly;

  @override
  void initState() {
    super.initState();
    context.read<ClassBlocBloc>().add(GetActiveClass());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("All Classes"),
      ),
      body: Column(
        children: [
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
                        child: GradeChipWidget(
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
                          child: GradeChipWidget(
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
          ),
          Expanded(
            child: BlocBuilder<ClassBlocBloc, ClassBlocState>(
              builder: (context, state) {
                if (state is GetActiveClassSuccess) {
                  return ListView(
                    children: state.studentModelClass
                        .where((activeClasses) =>
                            studentGradeId == null ||
                            activeClasses.gradeId == studentGradeId)
                        .map((activeClasses) {
                      convertDate(activeClasses.createdAt!);
                      return SlidableDetailsViewWidget(
                        onTap: (cxt) {
                          widget.classEditable
                              ? Navigator.of(cxt, rootNavigator: true)
                                  .pushNamed('/class_screen', arguments: {
                                  'edit_mode': true,
                                  'class_schedule_model_class': activeClasses
                                })
                              : Navigator.of(cxt, rootNavigator: true)
                                  .pushNamed('/view_class', arguments: {
                                  'class_details': activeClasses
                                });
                        },
                        circleWidget: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/logo/brr.png"),
                        ),
                        contend: "${activeClasses.className}",
                        subContend: "${activeClasses.teacherInitialName} ",
                        joinDate: activeClasses.subjectName!,
                        icon: widget.classEditable ? Icons.edit : Icons.report,
                      );
                    }).toList(),
                  );
                } else if (state is ClassDataProcess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ClassDataFailure) {
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
