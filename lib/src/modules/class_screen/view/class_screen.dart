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

  String? classDayNames;
  int? subjectId;
  int? gradeId;
  int? teacherId;
  int? classOnGoingStatus;
  int? classActiveStatus;

  List<String>? selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<StudentSubjectBloc>().add(GetStudentSubject());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
    context.read<TeacherBloc>().add(GetTeacherData());
    if (widget.editMode) {
      context.read<DropdownButtonCubit>().selectTeacher(null);
      context.read<DropdownButtonCubit>().selectGrade(null);
      context.read<DropdownButtonCubit>().selectSubject(null);
      _className.text = widget.classScheduleModelClass!.className!;
      subjectId = widget.classScheduleModelClass!.subjectId;
      gradeId = widget.classScheduleModelClass!.gradeId;
      teacherId = widget.classScheduleModelClass!.teacherId;
      classActiveStatus = widget.classScheduleModelClass!.isActive;
      classOnGoingStatus = widget.classScheduleModelClass!.isOngoing;

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
                                classActiveStatus =
                                    state.isClassActiveStatus ? 1 : 0;
                                classOnGoingStatus =
                                    state.isOngoingStatus ? 1 : 0;
                                return Column(
                                  children: [
                                    UserStatesWidget(
                                      statesTitle: 'Class Active Status',
                                      value: state.isClassActiveStatus,
                                      onChanged: (status) {
                                        final isClassActiveStatus =
                                            state.isClassActiveStatus;
                                        if (isClassActiveStatus) {
                                          classActiveStatus = 1;
                                        } else {
                                          classActiveStatus = 0;
                                        }
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
                                        final isClassOnGoingStatus =
                                            state.isOngoingStatus;
                                        if (isClassOnGoingStatus) {
                                          classOnGoingStatus = 1;
                                        } else {
                                          classOnGoingStatus = 0;
                                        }
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

  validateClassData() {
    if (RegisterFrom.notEmpty(_className.text, "class name", context)) {
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
    if (subjectId != null &&
        gradeId != null &&
        teacherId != null &&
        classActiveStatus != null &&
        classOnGoingStatus != null) {
      ClassScheduleModelClass classModelClass = ClassScheduleModelClass(
        id: widget.classScheduleModelClass!.id,
        className: _className.text.capitalizeEachWord,
        isActive: classActiveStatus ?? 1,
        isOngoing: classOnGoingStatus ?? 0,
        teacherId: teacherId,
        subjectId: subjectId,
        gradeId: gradeId,
      );
      //print(classModelClass.toUpdateJson());
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
