import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloka_mobile_app/src/models/camera/quick_image_model.dart';
import 'package:aloka_mobile_app/src/modules/camera_screen/bloc/quick_image/quick_image_bloc.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../components/drop_down_button_widget.dart';
import '../../../models/student/grade.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../res/color/app_color.dart';
import '../bloc/crop_image/crop_image_bloc.dart';
import '../components/image_view_widget.dart';
import '../components/quick_image_dialog_box.dart';

class QuickCameraScreen extends StatefulWidget {
  final File studentImageUrl;

  const QuickCameraScreen({super.key, required this.studentImageUrl});

  @override
  State<QuickCameraScreen> createState() => _QuickCameraScreenState();
}

class _QuickCameraScreenState extends State<QuickCameraScreen> {
  File? studentCropImageFilePath;
  String? grade;
  int? gradeId;

  @override
  void initState() {
    super.initState();
    context.read<StudentGradeBloc>().add(GetStudentGrade());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text('Quick Image'),
      ),
      body: Center(
        child: BlocListener<QuickImageBloc, QuickImageState>(
          listener: (context, state) {
            if (state is QuickImageSaveFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? "Unknown error")),
              );
            } else if (state is QuickImageSaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "${state.successMessage ?? 'Success'} ${state.quickImageId}"),
                ),
              );
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(state.successMessage ?? 'Success',
                        textAlign: TextAlign.center),
                    content: QuickImageDialogBox(
                      quickImageId: state.quickImageId!,
                      quickImageDescription:
                          'Do not forget to note this number',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.read<DropdownButtonCubit>().selectGrade(null);
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/home');
                        },
                        child: const Text("Back"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<QuickImageBloc, QuickImageState>(
            builder: (context, state) {
              if (state is QuickImageSaveProcess) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<CropImageBloc, CropImageState>(
                    builder: (context, state) {
                      if (state is CropImageProcess) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CropImageSuccess) {
                        studentCropImageFilePath =
                            state.cropStudentImageFilePath;
                      } else if (state is CropImageFailure) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.message ?? "Crop failed")),
                          );
                        });
                      }
                      return ImageViewWidget(
                        file:
                            studentCropImageFilePath ?? widget.studentImageUrl,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: BlocBuilder<StudentGradeBloc, StudentGradeState>(
                      builder: (context, state) {
                        if (state is GetStudentGradeSuccess) {
                          return DropDownButtonWidget(
                              widget: studentGrade(state.getGradeList));
                        } else if (state is GetStudentGradeFailure) {
                          return Text('Error: ${state.message}');
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<CropImageBloc>().add(CropImageClickEvent(
                                studentImageFilePath: widget.studentImageUrl,
                              ));
                        },
                        child: Text(
                          'Crop Image',
                          style: TextStyle(
                              color: ColorUtil.blackColor[10], fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (grade != null && gradeId != null) {
                            File imgPath = studentCropImageFilePath ??
                                widget.studentImageUrl;
                            context
                                .read<QuickImageBloc>()
                                .add(QuickImageSaveEvent(
                                  quickImageModel: QuickImageModel(
                                    gradeId: gradeId!,
                                    isActive: 1,
                                  ),
                                  quickImageFilePath: imgPath,
                                ));
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please select the grade")),
                              );
                            });
                          }
                        },
                        child: Text(
                          'Save Image',
                          style: TextStyle(
                              color: ColorUtil.blackColor[10], fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget studentGrade(List<Grade> getGradeList) {
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
              setState(() {
                grade = newGrade.gradeName;
                gradeId = newGrade.id;
              });
              context.read<DropdownButtonCubit>().selectGrade(newGrade);
            }
          },
        );
      },
    );
  }
}
