import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/register_form.dart';
import '../../../models/admission/admission_model_class.dart';
import '../../../models/admission/admission_payment_model.dart';
import '../../../models/student/student.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import '../../../components/app_text_field.dart';
import '../../../components/body_text_widget.dart';
import '../../../components/button/app_main_button.dart';
import '../../../components/disable_text_field_widget.dart';
import '../../../components/drop_down_button_widget.dart';
import '../../../components/radio_button_widget.dart';
import '../../../components/user_states_widget.dart';
import '../../../models/student/grade.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../provider/cubit_provider/radio_button_cubit/radio_button_cubit.dart';
import '../../../res/color/app_color.dart';
import '../../../res/strings/string.dart';
import '../../admission_screen/bloc/admission_payment/admission_payment_bloc.dart';
import '../../admission_screen/bloc/get_admission/get_admission_bloc.dart';
import '../bloc/get_student/get_student_bloc.dart';
import '../bloc/image_picker/image_picker_bloc.dart';
import '../bloc/manage_student_bloc/manage_student_bloc.dart';
import '../components/choser.dart';
import '../components/radio_group_widget.dart';
import '../components/student_image_area_widget.dart';
import '../../../extensions/str_extensions.dart';

class StudentScreen extends StatefulWidget {
  final StudentModelClass? studentModelClass;
  final bool editMode;
  const StudentScreen({
    super.key,
    this.studentModelClass,
    required this.editMode,
  });

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  // Student personal controller
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _initialName = TextEditingController();
  final TextEditingController _schoolName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _studentNic = TextEditingController();
  final TextEditingController _birthDay = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _whatsAppNumber = TextEditingController();
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _addressLine3 = TextEditingController();

  //Guardian Details controller
  final TextEditingController _guardianFullName = TextEditingController();
  final TextEditingController _guardianInitialName = TextEditingController();
  final TextEditingController _guardianNic = TextEditingController();
  final TextEditingController _guardianMNumber = TextEditingController();

  //edit mode

  File? studentImage;

  String? studentGender;
  int? studentGradeId;
  int? studentFreeCard;
  int? studentAdmission;
  double? admissionAmount;

  //camera image
  File? studentImageFilePath;
  String? quickImageUrl;
  int? quickImageId;

//Date Picker
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    context.read<StudentGradeBloc>().add(GetStudentGrade());
    if (widget.editMode) {
      editStudent();
    } else {
      context.read<ImagePickerBloc>().add(QuickImageUpdateEvent(
          quickSearchImage: StringData.appMainLogo, quickImageId: null));
    }
    context.read<GetAdmissionBloc>().add(GetAdmission());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.tealColor[10],
        title: Text(
          widget.editMode ? 'Edit Student' : 'Student',
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/home');
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await Navigator.of(context, rootNavigator: true)
                    .pushNamed('/search_quick_image');

                if (result != null &&
                    result is Map<String, dynamic> &&
                    mounted) {
                  // ignore: use_build_context_synchronously
                  context.read<ImagePickerBloc>().add(QuickImageUpdateEvent(
                      quickSearchImage: result['imageUrl'],
                      quickImageId: result['quickImgId']));
                }
              },
              icon: Icon(
                Icons.search,
                color: ColorUtil.whiteColor[10],
              )),
        ],
      ),
      body: BlocListener<ManageStudentBloc, ManageStudentState>(
        listener: (context, state) {
          // Handle Student Data Failure
          if (state is StudentDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
              ),
            );
          }

          // Handle Student Data Success
          else if (state is StudentDataProcessSuccess) {
            // Trigger Image Update
            context.read<ImagePickerBloc>().add(QuickImageUpdateEvent(
                quickSearchImage: StringData.appMainLogo, quickImageId: null));

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );

            // Check for admission details and trigger Admission event if needed
            if (admissionAmount != null && studentAdmission != null) {
              AdmissionPaymentModelClass admissionPaymentModelClass =
                  AdmissionPaymentModelClass(
                admissionId: studentAdmission,
                amount: admissionAmount,
                studentId: int.parse(state.studentId),
              );

              // Trigger Add Admission event
              context.read<AdmissionPaymentBloc>().add(AdmissionPayment(
                  admissionPaymentModelClass: admissionPaymentModelClass));

              if (state is AdmissionPaymentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.successMessage),
                    backgroundColor: ColorUtil.skyBlueColor[10],
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Admission Not Paid"),
                  backgroundColor: ColorUtil.skyBlueColor[10],
                ),
              );
            }

            // Clear text fields after success
            clearTextFields();

            // Navigate to add student class screen
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/add_student_class', arguments: {
              "student_id": int.parse(state.studentId),
              "student_custom_id": state.studentCusId,
              "student_initial_name": _initialName.text.capitalizeEachWord,
              "is_bottom_nav_bar": true,
            });
          }

          // Handle Student Update Success
          else if (state is StudentUpDataProcessSuccess) {
            context.read<GetStudentBloc>().add(GetActiveStudentData());
            context.read<ImagePickerBloc>().add(QuickImageUpdateEvent(
                quickSearchImage: StringData.appMainLogo, quickImageId: null));

            // Show success message for update
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );

            // Clear text fields after success
            clearTextFields();

            // Close the current screen after success
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        child: BlocBuilder<ManageStudentBloc, ManageStudentState>(
          builder: (context, state) {
            if (state is StudentDataProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<ImagePickerBloc, ImagePickerState>(
                      builder: (context, state) {
                        if (state is ImagePickerProcess) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ImagePickerFailure) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          });
                        } else if (state is ImagePickerSuccess) {
                          if (state.studentImageUrl != null) {
                            quickImageUrl = null;
                            quickImageId = null;

                            studentImage = state.studentImageUrl;
                          } else if (state.quickUpdateImage != null) {
                            studentImage = null;
                            quickImageUrl = state.quickUpdateImage;
                            quickImageId = state.quickImageId;
                          }
                        } else if (state is ImageCleared) {
                          studentImage = null;
                          studentImageFilePath = null;
                          quickImageUrl = null;
                        }
                        return StudentImageAreaWidget(
                            decorationImage: DecorationImage(
                                image: studentImage != null
                                    ? FileImage(studentImage!)
                                    : NetworkImage(
                                        "$quickImageUrl",
                                      ) as ImageProvider,
                                fit: BoxFit.cover),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    _timer =
                                        Timer(const Duration(seconds: 5), () {
                                      Navigator.of(context).pop();
                                    });
                                    return imageChoice(context);
                                  }).then(
                                (value) {
                                  if (_timer.isActive) {
                                    _timer.cancel();
                                  }
                                },
                              );
                            },
                            buttonName:
                                studentImage != null ? 'Crop' : 'Upload');
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          MyTextField(
                              controller: _fullName,
                              hintText: "Full Name",
                              inputType: TextInputType.name,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _initialName,
                              hintText: "Name with Initial",
                              inputType: TextInputType.name,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _schoolName,
                              hintText: "School Name",
                              inputType: TextInputType.emailAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _emailAddress,
                              hintText: "Email Address",
                              inputType: TextInputType.emailAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _studentNic,
                              hintText: "Student Nic",
                              inputType: TextInputType.text,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<RadioButtonCubit, RadioButtonState>(
                            builder: (context, gender) {
                              if (gender is RadioButtonInitial) {
                                studentGender = gender.studentGender.name;

                                return RadioGroupWidget(
                                  mainText: 'Gender',
                                  children: [
                                    RadioButtonWidget(
                                      buttonTitle: 'Male',
                                      value: Gender.male,
                                      groupValue: gender.studentGender,
                                      onChanged: (genders) {
                                        context
                                            .read<RadioButtonCubit>()
                                            .selectStudentGender(genders);
                                        studentGender =
                                            gender.studentGender.name;
                                      },
                                    ),
                                    RadioButtonWidget(
                                      buttonTitle: 'Female',
                                      value: Gender.female,
                                      groupValue: gender.studentGender,
                                      onChanged: (genders) {
                                        context
                                            .read<RadioButtonCubit>()
                                            .selectStudentGender(genders);
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          BlocBuilder<DatePickerBloc, DatePickerState>(
                            builder: (context, state) {
                              if (state is DatePickerFailure) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                });
                              } else if (state is DatePikerSuccessState) {
                                _birthDay.text = state.birthdayDate;
                              }
                              return DisableTextFieldWidget(
                                controller: _birthDay,
                                hintText: 'Birthday',
                                icon: Icons.date_range,
                                onPressed: () {
                                  context.read<DatePickerBloc>().add(
                                      BirthdayDatePickerEvent(
                                          context: context));
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _mobileNumber,
                              hintText: "Mobile Number",
                              inputType: TextInputType.phone,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _whatsAppNumber,
                              hintText: "WhatsApp Number",
                              inputType: TextInputType.phone,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _addressLine1,
                              hintText: "Address Line 1",
                              inputType: TextInputType.streetAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _addressLine2,
                              hintText: "Address Line 2",
                              inputType: TextInputType.streetAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _addressLine3,
                              hintText: "Address Line 3",
                              inputType: TextInputType.streetAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
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
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          widget.editMode
                              ? BlocBuilder<CheckboxButtonCubit,
                                  CheckboxButtonState>(
                                  builder: (context, state) {
                                    if (state is CheckboxButtonInitial) {
                                      return UserStatesWidget(
                                        statesTitle: 'Student Active Status',
                                        value: state.isStudentActiveStatus,
                                        onChanged: (status) {
                                          context
                                              .read<CheckboxButtonCubit>()
                                              .toggleStudentActiveStatus(
                                                  status);
                                        },
                                      );
                                    }
                                    return Container();
                                  },
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          const BodyTextWidget(
                            bodyTextTitle: 'Payment Details',
                            icon: Icons.payment_outlined,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                    top: 10,
                                  ),
                                  child: Text(
                                    "Free Card :",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                BlocBuilder<CheckboxButtonCubit,
                                    CheckboxButtonState>(
                                  builder: (context, freeCard) {
                                    if (freeCard is CheckboxButtonInitial) {
                                      studentFreeCard =
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
                                    return Container();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<GetAdmissionBloc, GetAdmissionState>(
                            builder: (context, state) {
                              if (state is GetAdmissionSuccess) {
                                return DropDownButtonWidget(
                                  widget:
                                      _studentAdmission(state.admissionModel),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      context
                                          .read<DropdownButtonCubit>()
                                          .selectAdmission(null);
                                    },
                                    child: const Text("Reset Admission")),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const BodyTextWidget(
                            bodyTextTitle: 'Guardian Details',
                            icon: Icons.family_restroom_outlined,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                              controller: _guardianFullName,
                              hintText: "Guardian Full Name",
                              inputType: TextInputType.name,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _guardianInitialName,
                              hintText: "Guardian Initial Name",
                              inputType: TextInputType.name,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _guardianNic,
                              hintText: "Guardian Nic",
                              inputType: TextInputType.text,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _guardianMNumber,
                              hintText: "Mobile Number",
                              inputType: TextInputType.phone,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    AppMainButton(
                      testName:
                          widget.editMode ? 'Update Student' : 'Student Save',
                      onTap: () {
                        insertStudentData();
                        // Navigator.of(context).pushNamed('/add_student_class',
                        //     arguments: StudentIdData(
                        //       studentId: 5,
                        //       cusStudentId: "CS0002",
                        //       studentInitialName:
                        //           "a a i fernando".capitalizeEachWord,
                        //     ));
                      },
                      height: 50,
                    ),
                  ],
                ),
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
              studentGradeId = newGrade.id;
            }
          });
    });
  }

// Image Chooser
  Widget imageChoice(BuildContext context) {
    return ChooserWidget(
      isStudentImage: studentImage,
      galleryTap: () {
        context.read<ImagePickerBloc>().add(ImagePickerGalleryEvent());
      },
      cameraTap: () {
        context.read<ImagePickerBloc>().add(ImagePickerCameraEvent());
      },
      cropImageTap: () {
        context
            .read<ImagePickerBloc>()
            .add(ImagePickerCropEvent(studentImageFilePath: studentImage!));
      },
    );
  }

  Widget _studentAdmission(List<AdmissionModelClass> admissions) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
        builder: (context, state) {
      return DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Admission'),
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          value: state.selectAdmission,
          items: admissions.map((AdmissionModelClass admission) {
            return DropdownMenuItem<AdmissionModelClass>(
              value: admission,
              child: Text(
                  '${admission.admissionName} - LKR ${admission.admissionAmount}'),
            );
          }).toList(),
          onChanged: (AdmissionModelClass? admissionModel) {
            if (admissionModel != null) {
              context
                  .read<DropdownButtonCubit>()
                  .selectAdmission(admissionModel);
              studentAdmission = admissionModel.admissionId;
              admissionAmount = admissionModel.admissionAmount;
              //print(studentAdmission);
            }
          });
    });
  }

  //Validation

  bool studentRegisterValidation() {
    if (RegisterFrom.notEmpty(_fullName.text, "full name", context) &&
        RegisterFrom.charactersCheck(_fullName.text, "full name", context) &&
        RegisterFrom.notEmpty(_initialName.text, "initial name", context) &&
        RegisterFrom.studentEmailCheck(_emailAddress.text, context) &&
        RegisterFrom.studentNicNumberCheck(_studentNic.text, context) &&
        RegisterFrom.notEmpty(_birthDay.text, "Birthday Date", context) &&
        RegisterFrom.mobileNUmberCheck(_mobileNumber.text, context) &&
        RegisterFrom.mobileNUmberCheck(_whatsAppNumber.text, context) &&
        RegisterFrom.notEmpty(
            _guardianFullName.text, "guardian full name", context) &&
        RegisterFrom.notEmpty(
            _guardianInitialName.text, "guardian initial name", context) &&
        RegisterFrom.studentNicNumberCheck(_guardianNic.text, context) &&
        RegisterFrom.mobileNUmberCheck(_guardianMNumber.text, context)) {
      return true;
    }
    return false;
  }

  insertStudentData() {
    // if (studentImageFilePath != null || quickImageUrl != null) {
    //   quickImageUrl = "https://admin.coopcitycollege.com/images/logo.png";
    // }
    if (studentGender != null &&
        studentFreeCard != null &&
        studentGradeId != null) {
      if (studentRegisterValidation()) {
        StudentModelClass studentModelClass = StudentModelClass(
          fullName: _fullName.text.trim().capitalizeEachWord,
          initialName: _initialName.text.trim().capitalizeEachWord,
          schoolName: _schoolName.text.trim().capitalizeEachWord,
          emailAddress: _emailAddress.text.trim(),
          studentNic: _studentNic.text.trim(),
          gender: studentGender!.trim().firstCapital,
          birthDay: _birthDay.text.trim(),
          mobileNumber: _mobileNumber.text.trim(),
          whatsappNumber: _whatsAppNumber.text.trim(),
          addressLine1: _addressLine1.text.trim().capitalizeEachWord,
          addressLine2: _addressLine2.text.trim().capitalizeEachWord,
          addressLine3: _addressLine3.text.trim().capitalizeEachWord,
          gradeId: studentGradeId,
          freeCard: studentFreeCard,
          admission: 0,
          guardianFName: _guardianFullName.text.trim().capitalizeEachWord,
          guardianLName: _guardianInitialName.text.trim().capitalizeEachWord,
          guardianNic: _guardianNic.text.trim(),
          guardianMNumber: _guardianMNumber.text.trim(),
          studentImageUrl: quickImageUrl,
          quickImageId: quickImageId,
          activeStatus: 1,
        );
        if (widget.editMode) {
          context.read<ManageStudentBloc>().add(UpdateManageStudentEvent(
              studentModelClass: studentModelClass,
              studentImagePath: studentImage,
              studentId: widget.studentModelClass!.id));
        } else {
          context.read<ManageStudentBloc>().add(InsertManageStudentEvent(
              studentModelClass: studentModelClass,
              studentImagePath: studentImage));
        }
      } else {}
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

  // Method to clear all the controllers
  void clearTextFields() {
    _fullName.clear();
    _initialName.clear();
    _emailAddress.clear();
    _studentNic.clear();
    _birthDay.clear();
    _mobileNumber.clear();
    _whatsAppNumber.clear();
    _addressLine1.clear();
    _addressLine2.clear();
    _addressLine3.clear();

    _guardianFullName.clear();
    _guardianInitialName.clear();
    _guardianNic.clear();
    _guardianMNumber.clear();

    admissionAmount = null;
    studentAdmission = null;
    studentGender = null;
    studentGradeId = null;

    context.read<DropdownButtonCubit>().selectGrade(null);
    context.read<DropdownButtonCubit>().selectAdmission(null);
    context.read<RadioButtonCubit>().selectStudentGender(Gender.male);
    context.read<CheckboxButtonCubit>().toggleFreeCardCheck(false);
  }

  void editStudent() {
    context.read<ImagePickerBloc>().add(QuickImageUpdateEvent(
        quickSearchImage: widget.studentModelClass!.studentImageUrl,
        quickImageId: null));
    _fullName.text = widget.studentModelClass!.fullName!;
    _initialName.text = widget.studentModelClass!.initialName!;
    _schoolName.text = widget.studentModelClass!.schoolName!;
    _emailAddress.text = widget.studentModelClass!.emailAddress!;
    _studentNic.text = widget.studentModelClass!.studentNic!;
    _birthDay.text = widget.studentModelClass!.birthDay!;
    _mobileNumber.text = widget.studentModelClass!.mobileNumber!;
    _whatsAppNumber.text = widget.studentModelClass!.whatsappNumber!;
    _addressLine1.text = widget.studentModelClass!.addressLine1!;
    _addressLine2.text = widget.studentModelClass!.addressLine2!;
    _addressLine3.text = widget.studentModelClass!.addressLine3!;
    _guardianFullName.text = widget.studentModelClass!.guardianFName!;
    _guardianInitialName.text = widget.studentModelClass!.guardianLName!;
    _guardianNic.text = widget.studentModelClass!.guardianNic!;
    _guardianMNumber.text = widget.studentModelClass!.guardianMNumber!;

    context.read<RadioButtonCubit>().selectStudentGender(
        widget.studentModelClass!.gender! == "Male"
            ? Gender.male
            : Gender.female);
    studentGradeId = widget.studentModelClass!.gradeId;
    context.read<CheckboxButtonCubit>().toggleFreeCardCheck(
        widget.studentModelClass!.freeCard == 1 ? true : false);
    context.read<CheckboxButtonCubit>().toggleStudentActiveStatus(
        widget.studentModelClass!.activeStatus == 1 ? true : false);
  }
}
