import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button/app_main_button.dart';
import '../../../components/drop_down_button_widget.dart';
import '../../../models/class_schedule/class_has_category_model_class.dart';
import '../../../models/student/student.dart';
import '../../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../res/color/app_color.dart';
import '../../class_screen/bloc/class_has_category/class_has_category_bloc.dart';
import '../../class_screen/bloc/class_has_student/class_has_student_bloc.dart';
import '../arguments/student_Id_data.dart';
import '../bloc/change_student_class/chenge_student_class_bloc.dart';
import '../bloc/manage_student_bloc/manage_student_bloc.dart';
import '../components/student_subject_widget.dart';

class StudentAddClass extends StatefulWidget {
  final int studentId;
  final String cusStudentId;
  final String? studentInitialName;
  final bool isBottomNavBar;

  const StudentAddClass({
    super.key,
    required this.studentId,
    required this.cusStudentId,
    this.studentInitialName,
    required this.isBottomNavBar
  });

  @override
  _StudentAddClassState createState() => _StudentAddClassState();
}

class _StudentAddClassState extends State<StudentAddClass> {
  int? studentClassId;
  int? classHasCatId;
  int? studentClassFreeCard;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context
        .read<ClassHasStudentBloc>()
        .add(GetClassHasStudentUniqueClassEvent(studentId: widget.studentId));
    context.read<ClassHasCategoryBloc>().add(GetAllClassHasCategory());
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showChangeClassDialog(
      StudentHasCategoryHasClassModelClass studentData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Class"),
          content: BlocBuilder<ClassHasCategoryBloc, ClassHasCategoryState>(
            builder: (context, state) {
              if (state is GetClassHasCategorySuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _classList(state.allClassHasCatList),
                    const SizedBox(height: 10),
                    BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
                      builder: (context, freeCardState) {
                        if (freeCardState is CheckboxButtonInitial) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: ColorUtil.tealColor[10],
                                  checkColor: ColorUtil.whiteColor[10],
                                  value: freeCardState.isStudentFreeCard,
                                  onChanged: (isChecked) {
                                    context
                                        .read<CheckboxButtonCubit>()
                                        .toggleFreeCardCheck(isChecked!);
                                  },
                                ),
                              ),
                              const Text("Free Card"),
                            ],
                          );
                        }
                        return const SizedBox(); // Default fallback
                      },
                    ),
                  ],
                );
              } else if (state is ClassHasCategoryFailure) {
                return Center(
                  child: Text(
                    'Error: ${state.failureMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                
                if (classHasCatId != null &&
                    studentClassId != null &&
                    studentClassFreeCard != null) {
                  final modelClass = StudentHasCategoryHasClassModelClass(
                    studentHasClassesId: studentData.studentHasClassesId,
                    classId: studentClassId,
                    classHasCatId: classHasCatId,
                    studentClassFreeCard: studentClassFreeCard,
                  );

                  context
                      .read<ChangeStudentClassBloc>()
                      .add(ChangeClassEvent(modelClass: modelClass));

                  Navigator.of(context)
                      .pop(); // Close the dialog after submission
                } else {
                  // Show feedback for missing fields if needed
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a class")),
                  );
                }
              },
              child: const Text("Change Class"),
            ),
          ],
        );
      },
    );
  }

  Widget _classList(List<ClassHasCategoryModelClass> getClassCatList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<ClassHasCategoryModelClass>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 24,
          hint: const Text('Select a Class'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectCatHasClass,
          items: getClassCatList.map((selectClass) {
            return DropdownMenuItem<ClassHasCategoryModelClass>(
              value: selectClass,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Grade ${selectClass.gradeName} - ",
                      style: const TextStyle(
                          fontSize: 14), // Add your desired styling here
                    ),
                    TextSpan(
                      text: "${selectClass.className} - ",
                      style: const TextStyle(
                          fontSize: 14), // Add a different style if needed
                    ),
                    TextSpan(
                      text: "${selectClass.subjectName} - ",
                      style: const TextStyle(fontSize: 14),
                    ),
                    TextSpan(
                      text: "${selectClass.categoryName}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (newClass) {
            if (newClass != null) {
              context
                  .read<DropdownButtonCubit>()
                  .selectClassHasCategory(newClass);
              setState(() {
                studentClassId = newClass.classId;
                classHasCatId = newClass.classHasCatId;
              });
            }
          },
        );
      },
    );
  }

  void _studentAddClass() {
    if (studentClassId != null &&
        classHasCatId != null &&
        studentClassFreeCard != null) {
      final studentModelClass = StudentModelClass(
        id: widget.studentId,
        classId: studentClassId,
        classHasCatId: classHasCatId,
        activeStatus: 1,
        freeCard: studentClassFreeCard,
      );
      context
          .read<ManageStudentBloc>()
          .add(StudentAddClassEvent(studentModelClass: studentModelClass));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSnackbar("Please select a student class");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add Student Class"),
            Text(
              '${widget.studentInitialName}',
              style: TextStyle(fontSize: 16, color: ColorUtil.whiteColor[16]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _studentAddClass,
        backgroundColor: ColorUtil.tealColor[10],
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ManageStudentBloc, ManageStudentState>(
            listener: (context, state) {
              if (state is StudentClassAddSuccess) {
                // Clear inputs and reset state
                setState(() {
                  studentClassId = null;
                  classHasCatId = null;
                  studentClassFreeCard = null;
                });
                context.read<CheckboxButtonCubit>().toggleFreeCardCheck(false);
                context.read<ClassHasStudentBloc>().add(
                    GetClassHasStudentUniqueClassEvent(
                        studentId: widget.studentId));
                context
                    .read<DropdownButtonCubit>()
                    .selectClassHasCategory(null);
                _showSnackbar(state.successMessage);
              } else if (state is StudentDataFailure) {
                _showSnackbar(state.failureMessage);
              }
            },
          ),
          BlocListener<ChangeStudentClassBloc, ChangeStudentClassState>(
            listener: (context, state) {
              if (state is ChangeStudentClassSuccess) {
                // Clear dialog and reset state
                Navigator.of(context).pop();
                _showSnackbar(state.successMessage);
                setState(() {
                  studentClassId = null;
                  classHasCatId = null;
                  studentClassFreeCard = null;
                });
                context.read<CheckboxButtonCubit>().toggleFreeCardCheck(false);
              } else if (state is ChangeStudentClassFailure) {
                _showSnackbar(state.failureMessage);
              }
            },
          ),
        ],
        child: BlocBuilder<ManageStudentBloc, ManageStudentState>(
          builder: (context, state) {
            if (state is StudentDataProcess) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildContent();
          },
        ),
      ),
      bottomNavigationBar: widget.isBottomNavBar
          ? _buildBottomNavigationBar()
          : const SizedBox()
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: BlocBuilder<ClassHasCategoryBloc, ClassHasCategoryState>(
              builder: (context, state) {
                if (state is GetClassHasCategorySuccess) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: DropDownButtonWidget(
                          widget: _classList(state.allClassHasCatList),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Free Card:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
                            builder: (context, freeCard) {
                              if (freeCard is CheckboxButtonInitial) {
                                studentClassFreeCard =
                                    freeCard.isStudentFreeCard ? 1 : 0;

                                return Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    activeColor: ColorUtil.tealColor[10],
                                    checkColor: ColorUtil.whiteColor[10],
                                    value: freeCard.isStudentFreeCard,
                                    onChanged: (check) {
                                      context
                                          .read<CheckboxButtonCubit>()
                                          .toggleFreeCardCheck(check!);
                                    },
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is ClassHasCategoryFailure) {
                  return Center(child: Text('Error: ${state.failureMessage}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            flex: 7,
            child:
                BlocListener<ChangeStudentClassBloc, ChangeStudentClassState>(
              listener: (context, state) {
                if (state is ChangeStudentClassFailure) {
                  _showSnackbar(state.failureMessage);
                } else if (state is ChangeStudentClassSuccess) {
                  _showSnackbar(state.successMessage);
                  Navigator.pop(context);
                }
              },
              child:
                  BlocBuilder<ChangeStudentClassBloc, ChangeStudentClassState>(
                builder: (context, state) {
                  if (state is ChangeStudentClassProcess) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return BlocBuilder<ClassHasStudentBloc, ClassHasStudentState>(
                    builder: (context, state) {
                      if (state is GetClassHasStudentUniqueData) {
                        if (state.getUniqueStudent.isEmpty) {
                          return const Center(child: Text("No data available"));
                        }
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.getUniqueStudent.length,
                          itemBuilder: (context, index) {
                            final studentData = state.getUniqueStudent[index];
                            return GestureDetector(
                              onTap: () => _showChangeClassDialog(studentData),
                              child: StudentSubjectWidget(
                                onTap: () {
                                  print(studentData.studentClassFreeCard);
                                },
                                circleAvatarText:
                                    studentData.teacherInitialName ?? '',
                                teacherName: studentData.className ?? '',
                                subjectName: studentData.categoryName ?? '',
                                gradeName: "Grade ${studentData.gradeName}",
                                studentFreeCard:
                                    studentData.studentClassFreeCard ?? 0,
                                trailingIcon: Icons.delete,
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: ColorUtil.blackColor[18]!)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppMainButton(
          testName: 'Preview Id',
          onTap: () {
            if (widget.studentInitialName != null) {
              Navigator.of(context, rootNavigator: true).pushNamed(
                "/generate_id",
                arguments: StudentIdData(
                  studentId: widget.studentId,
                  cusStudentId: widget.cusStudentId,
                  studentInitialName: widget.studentInitialName!,
                ),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showSnackbar("Initial name is null, can't preview ID");
              });
            }
          },
          height: 50,
        ),
      ),
    );
  }
}
