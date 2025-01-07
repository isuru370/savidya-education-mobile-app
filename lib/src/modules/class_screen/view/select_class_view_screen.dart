import 'package:aloka_mobile_app/src/provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/color/app_color.dart';
import '../bloc/class_has_category/class_has_category_bloc.dart';

class SelectClassViewScreen extends StatefulWidget {
  final String classPayHasAtt;
  const SelectClassViewScreen({
    super.key,
    required this.classPayHasAtt,
  });

  @override
  State<SelectClassViewScreen> createState() => _SelectClassViewScreenState();
}

class _SelectClassViewScreenState extends State<SelectClassViewScreen> {
  String? selectGradeName;
  @override
  void initState() {
    super.initState();
    context.read<ClassHasCategoryBloc>().add(ClassHasCategoryClassEvent());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/home');
            },
            icon: const Icon(Icons.arrow_back)),
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: Text(
          widget.classPayHasAtt == "Attendance" ? "Student Attendance" : "",
        ),
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
                            selectGradeName = null;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          margin: const EdgeInsets.only(
                              right: 8.0), // Space on the right
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectGradeName == null
                                ? ColorUtil.whiteColor[14]
                                : ColorUtil.tealColor[10],
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners if desired
                          ),
                          child: Text(
                            'All Grades',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectGradeName == null
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
                              selectGradeName = grade.gradeName;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 50,
                            margin: const EdgeInsets.only(
                                right: 8.0), // Space on the right
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selectGradeName == grade.gradeName
                                  ? ColorUtil.whiteColor[14]
                                  : ColorUtil.tealColor[10],
                              borderRadius: BorderRadius.circular(
                                  10), // Add rounded corners if desired
                            ),
                            child: Text(
                              '${grade.gradeName} Grade',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectGradeName == grade.gradeName
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
            child: BlocBuilder<ClassHasCategoryBloc, ClassHasCategoryState>(
              builder: (context, state) {
                if (state is ClassTheoryAndRevisionSuccess) {
                  return ListView(
                    children: state.theoryAnRevisionList
                        .where((studentClass) =>
                            selectGradeName == null ||
                            studentClass.gradeName == selectGradeName)
                        .map((classTR) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: ColorUtil.tealColor[10]!,
                                    width: 1,
                                  ),
                                ),
                                elevation: 3,
                                shadowColor: Colors.black45,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Text(
                                      classTR.categoryName![0],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtil.blackColor[20],
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${classTR.gradeName!} - "
                                    "${classTR.className!} - "
                                    "${classTR.subjectName!} - "
                                    " ${classTR.categoryName!}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.blackColor[10],
                                    ),
                                  ),
                                  subtitle: Text(
                                    classTR.fullName!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorUtil.blackColor[12],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  tileColor: Colors.white,
                                  trailing: GestureDetector(
                                    onTap: () {
                                      if (widget.classPayHasAtt ==
                                          "Attendance") {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed('/class_start_screen',
                                                arguments: {
                                              "classHasCatId":
                                                  classTR.classHasCatId,
                                              "classId": classTR.classId,
                                            });
                                        print(classTR.classHasCatId);
                                      } else {
                                        //payment screen
                                        // Navigator.of(context,
                                        //         rootNavigator: true)
                                        //     .pushNamed('/qr_code_read',
                                        //         arguments:
                                        //             SelectClassIdArguments(
                                        //           classHasCatId: classTR
                                        //               .classHasCatId,
                                        //         ));
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorUtil.tealColor[10],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                } else if (state is ClassHasCategoryProcess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ClassHasCategoryFailure) {
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
}
