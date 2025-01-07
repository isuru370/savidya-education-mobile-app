import 'package:aloka_mobile_app/src/extensions/str_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/app_text_field.dart';
import '../../../components/button/app_main_button.dart';
import '../../../components/drop_down_button_widget.dart';
import '../../../components/user_states_widget.dart';
import '../../../extensions/register_form.dart';
import '../../../models/class_schedule/class_schedule.dart';
import '../../../models/student/grade.dart';
import '../../../models/student/subject.dart';
import '../../../models/teacher/teacher.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../provider/bloc_provider/student_bloc/student_subject/student_subject_bloc.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../res/color/app_color.dart';
import '../../teacher_screen/bloc/teacher_bloc/teacher_bloc.dart';
import '../bloc/class_bloc/class_bloc_bloc.dart';

class ClassScreen extends StatefulWidget {
  final ClassScheduleModelClass? classScheduleModelClass;
  final bool editMode;
  const ClassScreen({
    super.key,
    this.classScheduleModelClass,
    required this.editMode,
  });

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final TextEditingController _className = TextEditingController();
  final TextEditingController _classStart = TextEditingController();
  final TextEditingController _classEnd = TextEditingController();

  String? classDayNames;
  int? subjectId;
  int? gradeId;
  int? teacherId;

  List<String>? selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<StudentSubjectBloc>().add(GetStudentSubject());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
    context.read<TeacherBloc>().add(GetTeacherData());
    if (widget.editMode) {
      _className.text = widget.classScheduleModelClass!.className!;
      subjectId = widget.classScheduleModelClass!.subjectId;
      gradeId = widget.classScheduleModelClass!.gradeId;
      teacherId = widget.classScheduleModelClass!.teacherId;

      if (widget.classScheduleModelClass!.isActive == 1) {
        context.read<CheckboxButtonCubit>().toggleClassActiveStatus(true);
      } else {
        context.read<CheckboxButtonCubit>().toggleClassActiveStatus(false);
      }
      if (widget.classScheduleModelClass!.isOngoing == 1) {
        context.read<CheckboxButtonCubit>().toggleClassOngoingStatus(true);
      } else {
        context.read<CheckboxButtonCubit>().toggleClassOngoingStatus(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: Text(widget.editMode ? "Edit Class" : "Add Class"),
      ),
      body: BlocListener<ClassBlocBloc, ClassBlocState>(
        listener: (context, state) {
          if (state is ClassDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
              ),
            );
          } else if (state is ClassDataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
            Navigator.of(context).pushNamed('/class_at_category', arguments: {
              'class_id': int.parse(state.classId),
            });
          } else if (state is ClassDataUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.updateMessage),
              ),
            ); 
            context.read<ClassBlocBloc>().add(GetActiveClass());
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ClassBlocBloc, ClassBlocState>(
          builder: (context, state) {
            if (state is ClassDataProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        MyTextField(
                          controller: _className,
                          hintText: 'Class Name',
                          inputType: TextInputType.name,
                          obscureText: false,
                          icon: const Icon(Icons.class_),
                        ),
                        const SizedBox(height: 15),
                        BlocBuilder<StudentSubjectBloc, StudentSubjectState>(
                          builder: (context, state) {
                            if (state is GetStudentSubjectSuccess) {
                              return DropDownButtonWidget(
                                widget: studentSubject(state.getSubjectList),
                              );
                            } else if (state is GetStudentSubjectFailure) {
                              return Text('Error: ${state.message}');
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        BlocBuilder<StudentGradeBloc, StudentGradeState>(
                          builder: (context, state) {
                            if (state is GetStudentGradeSuccess) {
                              return DropDownButtonWidget(
                                widget: studentGrade(state.getGradeList),
                              );
                            } else if (state is GetStudentGradeFailure) {
                              return Text('Error: ${state.message}');
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        if (widget.editMode)
                          BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
                            builder: (context, state) {
                              if (state is CheckboxButtonInitial) {
                                return Column(
                                  children: [
                                    UserStatesWidget(
                                      statesTitle: 'Class Active Status',
                                      value: state.isClassActiveStatus,
                                      onChanged: (status) {
                                        context
                                            .read<CheckboxButtonCubit>()
                                            .toggleClassActiveStatus(status);
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    UserStatesWidget(
                                      statesTitle: 'Class Ongoing Status',
                                      value: state.isOngoingStatus,
                                      onChanged: (status) {
                                        context
                                            .read<CheckboxButtonCubit>()
                                            .toggleClassOngoingStatus(status);
                                      },
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        const SizedBox(height: 15),
                        BlocBuilder<TeacherBloc, TeacherState>(
                          builder: (context, state) {
                            if (state is GetTeacherSuccess) {
                              return DropDownButtonWidget(
                                widget: getTeacher(state.getActiveTeacherList),
                              );
                            } else if (state is GetTeacherFailure) {
                              return Text('Error: ${state.message}');
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        AppMainButton(
                          testName:
                              widget.editMode ? 'Update Class' : 'Save Class',
                          onTap: () {
                            widget.editMode
                                ? updateClassData()
                                : insertClassData();
                          },
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget studentGrade(List<Grade> getGradeList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
        builder: (context, state) {
      return DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Grade'),
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
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
              gradeId = newGrade.id;
            }
          });
    });
  }

  Widget studentSubject(List<Subject> getSubjectList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton(
            isExpanded: true,
            underline: const SizedBox(),
            iconSize: 40,
            hint: const Text('Select a Subject'),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            value: state.selectedSubject,
            items: getSubjectList.map((Subject subject) {
              return DropdownMenuItem<Subject>(
                value: subject,
                child: Text(subject.subjectName),
              );
            }).toList(),
            onChanged: (Subject? newSubject) {
              if (newSubject != null) {
                context.read<DropdownButtonCubit>().selectSubject(newSubject);
                subjectId = newSubject.id;
              }
            });
      },
    );
  }

  Widget getTeacher(List<TeacherModelClass> getTeacherList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
        builder: (context, state) {
      return DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Teacher'),
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          value: state.selectTeacher,
          items: getTeacherList.map((TeacherModelClass teachers) {
            return DropdownMenuItem<TeacherModelClass>(
              value: teachers,
              child: Text("${teachers.id} ${teachers.initialName}"),
            );
          }).toList(),
          onChanged: (TeacherModelClass? newTeacher) {
            if (newTeacher != null) {
              context.read<DropdownButtonCubit>().selectTeacher(newTeacher);
              teacherId = newTeacher.id;
            }
          });
    });
  }

  // void _classScheduleTime(String test) {
  //   showModalBottomSheet(
  //       backgroundColor: ColorUtil.whiteColor[14],
  //       shape: const BeveledRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(5),
  //           topRight: Radius.circular(5),
  //         ),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return Padding(
  //           padding: const EdgeInsets.only(left: 20, bottom: 20),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(
  //                 height: 30,
  //               ),
  //               test == "Start Time"
  //                   ? Text(
  //                       "Class Start Time",
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           color: ColorUtil.blackColor[10],
  //                           fontWeight: FontWeight.bold),
  //                     )
  //                   : Text(
  //                       "Class End Time",
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           color: ColorUtil.blackColor[10],
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //               Expanded(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     SizedBox(
  //                       width: 70,
  //                       child: ListWheelScrollView.useDelegate(
  //                           onSelectedItemChanged: (hours) {
  //                             context.read<TimeCubit>().updateHours(hours);
  //                           },
  //                           itemExtent: 50,
  //                           perspective: 0.005,
  //                           diameterRatio: 1.2,
  //                           physics: const FixedExtentScrollPhysics(),
  //                           childDelegate: ListWheelChildBuilderDelegate(
  //                               childCount: 13,
  //                               builder: (context, index) {
  //                                 return MyHoursWidget(hours: index);
  //                               })),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     SizedBox(
  //                       width: 70,
  //                       child: ListWheelScrollView.useDelegate(
  //                           onSelectedItemChanged: (minutes) {
  //                             context.read<TimeCubit>().updateMinutes(minutes);
  //                           },
  //                           itemExtent: 50,
  //                           perspective: 0.005,
  //                           diameterRatio: 1.2,
  //                           physics: const FixedExtentScrollPhysics(),
  //                           childDelegate: ListWheelChildBuilderDelegate(
  //                               childCount: 60,
  //                               builder: (context, index) {
  //                                 return MyMinutesWidget(mins: index);
  //                               })),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     SizedBox(
  //                       width: 70,
  //                       child: ListWheelScrollView.useDelegate(
  //                           onSelectedItemChanged: (value) {
  //                             setState(() {
  //                               context
  //                                   .read<TimeCubit>()
  //                                   .updateAmPm(value == 0 ? "AM" : "PM");
  //                             });
  //                           },
  //                           itemExtent: 50,
  //                           perspective: 0.005,
  //                           diameterRatio: 1.2,
  //                           physics: const FixedExtentScrollPhysics(),
  //                           childDelegate: ListWheelChildBuilderDelegate(
  //                               childCount: 2,
  //                               builder: (context, index) {
  //                                 if (index == 0) {
  //                                   return const MyAmorPmWidget(
  //                                     isItAml: true,
  //                                   );
  //                                 } else {
  //                                   return const MyAmorPmWidget(isItAml: false);
  //                                 }
  //                               })),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     TextButton(
  //                         onPressed: () {
  //                           final timeState = context.read<TimeCubit>().state;
  //                           if (timeState is TimeInitial) {
  //                             if (test == 'Start Time') {
  //                               _classStart.text =
  //                                   "${timeState.hours} : ${timeState.minutes} - ${timeState.amPm}";
  //                             } else {
  //                               _classEnd.text =
  //                                   "${timeState.hours} : ${timeState.minutes} - ${timeState.amPm}";
  //                             }

  //                             Navigator.pop(context);
  //                           }
  //                         },
  //                         child: const Text(
  //                           'Ok',
  //                           style: TextStyle(fontSize: 16),
  //                         )),
  //                     TextButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Text(
  //                           'Cancel',
  //                           style: TextStyle(fontSize: 16),
  //                         )),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  validateClassData() {
    if (RegisterFrom.notEmpty(_className.text, "class name", context) &&
        RegisterFrom.notEmpty(_classStart.text, "class start time", context) &&
        RegisterFrom.notEmpty(_classEnd.text, "class end time", context)) {
      return true;
    }
    return false;
  }

  insertClassData() {
    if (subjectId != null && gradeId != null && teacherId != null) {
      ClassScheduleModelClass classModelClass = ClassScheduleModelClass(
        className: _className.text.capitalizeEachWord,
        isActive: 1,
        isOngoing: 0,
        teacherId: teacherId,
        subjectId: subjectId,
        gradeId: gradeId,
      );
      context
          .read<ClassBlocBloc>()
          .add(InsertClassData(studentClassModel: classModelClass));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter correct data"),
          ),
        );
      });
    }
  }

  updateClassData() {
    if (subjectId != null && gradeId != null && teacherId != null) {
      ClassScheduleModelClass classModelClass = ClassScheduleModelClass(
        id: widget.classScheduleModelClass!.id,
        className: _className.text.capitalizeEachWord,
        isActive: 1,
        isOngoing: 0,
        teacherId: teacherId,
        subjectId: subjectId,
        gradeId: gradeId,
      );
      context
          .read<ClassBlocBloc>()
          .add(UpdateClassDataEvent(studentClassModel: classModelClass));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter correct data"),
          ),
        );
      });
    }
  }
}
