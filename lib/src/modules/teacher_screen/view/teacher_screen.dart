import 'package:aloka_mobile_app/src/extensions/str_extensions.dart';
import 'package:aloka_mobile_app/src/models/bank_details/bank_model.dart';
import 'package:aloka_mobile_app/src/models/bank_details/branch_details.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/bank_details_bloc/bank_details_bloc.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/branch_details_bloc/branch_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/app_text_field.dart';
import '../../../components/body_text_widget.dart';
import '../../../components/button/app_main_button.dart';
import '../../../components/disable_text_field_widget.dart';
import '../../../components/drop_down_button_widget.dart';
import '../../../components/radio_button_widget.dart';
import '../../../components/user_states_widget.dart';
import '../../../extensions/register_form.dart';
import '../../../models/teacher/teacher.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../provider/cubit_provider/radio_button_cubit/radio_button_cubit.dart';
import '../../../res/color/app_color.dart';
import '../../student_screen/components/radio_group_widget.dart';
import '../bloc/experience_year_bloc/experience_year_bloc.dart';
import '../bloc/teacher_bloc/teacher_bloc.dart';

class TeacherScreen extends StatefulWidget {
  final TeacherModelClass? teacherModelClass;
  final bool editMode;
  const TeacherScreen({
    super.key,
    required this.editMode,
    required this.teacherModelClass,
  });

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _initialName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _nicNumber = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _birthDay = TextEditingController();
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _addressLine3 = TextEditingController();
  final TextEditingController _graduationYear = TextEditingController();
  final TextEditingController _percentage = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();

  String? teacherGender;
  String? experience;
  int? bankId;
  int? branchId;

  @override
  void initState() {
    super.initState();
    if (widget.editMode) {
      editTeacher();
    }
    context.read<DropdownButtonCubit>().selectBranch(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: Text(
          widget.editMode ? 'Update Teacher' : 'Teacher',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<TeacherBloc, TeacherState>(
        listener: (context, state) {
          if (state is GetTeacherFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is InsertDataSuccess) {
            context.read<TeacherBloc>().add(GetTeacherData());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
            clearTextField();
            //Navigator.pop(context);
          }
        },
        child: BlocBuilder<TeacherBloc, TeacherState>(
          builder: (context, state) {
            if (state is InsertDataProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextField(
                    controller: _fullName,
                    hintText: "Full Name",
                    inputType: TextInputType.name,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _initialName,
                    hintText: "Initial Name",
                    inputType: TextInputType.name,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _emailAddress,
                    hintText: "Email Address",
                    inputType: TextInputType.emailAddress,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _nicNumber,
                    hintText: "NIC Number",
                    inputType: TextInputType.text,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _mobileNumber,
                    hintText: "Mobile Number",
                    inputType: TextInputType.phone,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<RadioButtonCubit, RadioButtonState>(
                    builder: (context, gender) {
                      if (gender is RadioButtonInitial) {
                        teacherGender = gender.teacherGender.name;
                        return RadioGroupWidget(
                          mainText: 'Gender',
                          children: [
                            RadioButtonWidget(
                              buttonTitle: 'Male',
                              value: Gender.male,
                              groupValue: gender.teacherGender,
                              onChanged: (genders) {
                                context
                                    .read<RadioButtonCubit>()
                                    .selectTeacherGender(genders);
                              },
                            ),
                            RadioButtonWidget(
                              buttonTitle: 'Female',
                              value: Gender.female,
                              groupValue: gender.teacherGender,
                              onChanged: (genders) {
                                context
                                    .read<RadioButtonCubit>()
                                    .selectTeacherGender(genders);
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<DatePickerBloc, DatePickerState>(
                    builder: (context, state) {
                      if (state is DatePickerFailure) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                          context
                              .read<DatePickerBloc>()
                              .add(BirthdayDatePickerEvent(context: context));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _addressLine1,
                    hintText: "Address Line 1",
                    inputType: TextInputType.streetAddress,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _addressLine2,
                    hintText: "Address Line 2",
                    inputType: TextInputType.streetAddress,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _addressLine3,
                    hintText: "Address Line 3",
                    inputType: TextInputType.streetAddress,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  widget.editMode
                      ? BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
                          builder: (context, state) {
                            if (state is CheckboxButtonInitial) {
                              return UserStatesWidget(
                                statesTitle: 'Teacher Active Status',
                                value: state.isTeacherActiveStatus,
                                onChanged: (status) {
                                  context
                                      .read<CheckboxButtonCubit>()
                                      .toggleTeacherActiveStatus(status);
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  const BodyTextWidget(
                    bodyTextTitle: 'Graduation Details',
                    icon: Icons.abc,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _percentage,
                    hintText: "Percentage",
                    inputType: TextInputType.number,
                    obscureText: false,
                    icon: const Icon(Icons.percent),
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _graduationYear,
                    hintText: "Teacher Graduation Details",
                    inputType: TextInputType.text,
                    obscureText: false,
                    icon: const Icon(null),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<ExperienceYearBloc, ExperienceYearState>(
                    builder: (context, state) {
                      if (state is ExperienceYearLoaded) {
                        return DropDownButtonWidget(
                          widget: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            iconSize: 40,
                            hint: const Text('Select Experience Year'),
                            icon: const Icon(Icons.arrow_drop_down),
                            value: state.selectedExperienceYear,
                            items: state.experienceYearList
                                .map((String experienceYear) {
                              return DropdownMenuItem<String>(
                                value: experienceYear,
                                child: Text(experienceYear),
                              );
                            }).toList(),
                            onChanged: (String? newExperienceYear) {
                              if (newExperienceYear != null) {
                                context.read<ExperienceYearBloc>().add(
                                      SelectExperienceYear(
                                          selectedExperienceYear:
                                              newExperienceYear),
                                    );
                                experience = newExperienceYear;
                              }
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 12),
                  const BodyTextWidget(
                    bodyTextTitle: 'Bank Details',
                    icon: Icons.account_balance,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _accountNumber,
                    hintText: "Account Number",
                    inputType: TextInputType.number,
                    obscureText: false,
                    icon: const Icon(Icons.account_balance),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<BankDetailsBloc, BankDetailsState>(
                    builder: (context, state) {
                      if (state is GetBankDetailsSuccess) {
                        return DropDownButtonWidget(
                          widget: bankDetails(state.bankModelClass),
                        );
                      } else if (state is GetBankDetailsFailure) {
                        return Text('Error: ${state.failureMessage}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<BranchDetailsBloc, BranchDetailsState>(
                    builder: (context, state) {
                      if (state is GetBranchDetailsSuccess) {
                        return DropDownButtonWidget(
                          widget: branchDetails(state.branchModelClass),
                        );
                      } else if (state is GetBranchDetailsFailure) {
                        return Text('Error: ${state.failureMessage}');
                      } else {
                        return const Text('First select the bank');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  AppMainButton(
                    testName:
                        widget.editMode ? 'Update Teacher' : 'Save Teacher',
                    onTap: () {
                      insertTeacherData();
                    },
                    height: 50,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bankDetails(List<BankModelClass> getBank) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<BankModelClass>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Bank'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectBankName,
          items: getBank.map((BankModelClass bank) {
            return DropdownMenuItem<BankModelClass>(
              value: bank,
              child: Text("${bank.bankName} ${bank.bankCode}"),
            );
          }).toList(),
          onChanged: (BankModelClass? newBank) {
            if (newBank != null) {
              context.read<DropdownButtonCubit>().selectBranch(null);
              context.read<DropdownButtonCubit>().selectBank(newBank);
              context
                  .read<BranchDetailsBloc>()
                  .add(GetBranchDetailsEvent(bankId: newBank.id!));

              bankId = newBank.id;
            }
          },
        );
      },
    );
  }

  Widget branchDetails(List<BankBranchModelClass> getBranch) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<BankBranchModelClass>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Branch'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectBranchName,
          items: getBranch.map((BankBranchModelClass branch) {
            return DropdownMenuItem<BankBranchModelClass>(
              value: branch,
              child: Text("${branch.branchName} ${branch.branchCode}"),
            );
          }).toList(),
          onChanged: (BankBranchModelClass? newBranch) {
            if (newBranch != null) {
              context.read<DropdownButtonCubit>().selectBranch(newBranch);
              branchId = newBranch.id;
            }
          },
        );
      },
    );
  }

  Widget selectExperienceYear(List<String> experienceYearList) {
    return DropdownButton<String>(
      isExpanded: true,
      underline: const SizedBox(),
      iconSize: 40,
      hint: const Text('Select Experience Year'),
      icon: const Icon(Icons.arrow_drop_down),
      value: experience,
      items: experienceYearList.map((String experienceYear) {
        return DropdownMenuItem<String>(
          value: experienceYear,
          child: Text(experienceYear),
        );
      }).toList(),
      onChanged: (String? newExperienceYear) {
        if (newExperienceYear != null) {
          context.read<ExperienceYearBloc>().add(
                SelectExperienceYear(selectedExperienceYear: newExperienceYear),
              );
          experience = newExperienceYear;
        }
      },
    );
  }

  bool validationTeacherData() {
    return RegisterFrom.notEmpty(_fullName.text, "full name", context) &&
        RegisterFrom.notEmpty(_initialName.text, "initial name", context) &&
        RegisterFrom.emailCheck(_emailAddress.text, context) &&
        RegisterFrom.nicNumberCheck(_nicNumber.text, context) &&
        RegisterFrom.mobileNUmberCheck(_mobileNumber.text, context) &&
        RegisterFrom.notEmpty(_birthDay.text, "birthday", context) &&
        RegisterFrom.notEmpty(_percentage.text, "percentage", context) &&
        RegisterFrom.notEmpty(_addressLine1.text, "address line 1", context) &&
        RegisterFrom.notEmpty(_accountNumber.text, "account No", context) &&
        RegisterFrom.notEmpty(_addressLine2.text, "address line 2", context);
  }

  void insertTeacherData() {
    if (teacherGender != null &&
        experience != null &&
        bankId != null &&
        branchId != null) {
      if (validationTeacherData()) {
        TeacherModelClass teacherModelClass = TeacherModelClass(
          fullName: _fullName.text.trim().capitalizeEachWord,
          initialName: _initialName.text.trim().capitalizeEachWord,
          email: _emailAddress.text.trim(),
          nic: _nicNumber.text.trim(),
          mobile: _mobileNumber.text.trim(),
          gender: teacherGender!.trim().firstCapital,
          birthday: _birthDay.text.trim(),
          address1: _addressLine1.text.trim(),
          address2: _addressLine2.text.trim(),
          address3: _addressLine3.text.trim(),
          isActive: 1,
          graduationDetails: _graduationYear.text.trim(),
          experience: experience,
          percentage: double.parse(_percentage.text.trim()),
          accountNo: _accountNumber.text.trim(),
          bankId: bankId,
          branchId: branchId,
        );
        if (widget.editMode) {
          context.read<TeacherBloc>().add(
                UpdateTeacherData(
                  teacherModelClass: teacherModelClass,
                  teacherId: widget.teacherModelClass!.id!,
                ),
              );
        } else {
          context.read<TeacherBloc>().add(
                InsertTeacherData(teacherModelClass: teacherModelClass),
              );
        }
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please Enter valid value"),
          ),
        );
      });
    }
  }

  void editTeacher() {
    _fullName.text = widget.teacherModelClass!.fullName!;
    _initialName.text = widget.teacherModelClass!.initialName!;
    _emailAddress.text = widget.teacherModelClass!.email!;
    _nicNumber.text = widget.teacherModelClass!.nic!;
    _mobileNumber.text = widget.teacherModelClass!.mobile!;
    _birthDay.text = widget.teacherModelClass!.birthday!;
    _addressLine1.text = widget.teacherModelClass!.address1!;
    _addressLine2.text = widget.teacherModelClass!.address2!;
    _addressLine3.text = widget.teacherModelClass!.address3!;
    _percentage.text = widget.teacherModelClass!.percentage!.toString();
    _graduationYear.text = widget.teacherModelClass!.graduationDetails!;
    _accountNumber.text = widget.teacherModelClass!.accountNo!;

    context.read<RadioButtonCubit>().selectTeacherGender(
        widget.teacherModelClass!.gender! == "Male"
            ? Gender.male
            : Gender.female);
    experience = widget.teacherModelClass!.experience;

    context.read<CheckboxButtonCubit>().toggleTeacherActiveStatus(
        widget.teacherModelClass!.isActive == 1 ? true : false);
  }

  clearTextField() {
    _fullName.clear();
    _initialName.clear();
    _emailAddress.clear();
    _nicNumber.clear();
    _mobileNumber.clear();
    _birthDay.clear();
    _addressLine1.clear();
    _addressLine2.clear();
    _addressLine3.clear();
    _percentage.clear();
    _graduationYear.clear();
    _accountNumber.clear();
    bankId = null;
    branchId = null;
    experience = null;
    teacherGender = null;

    context.read<RadioButtonCubit>().selectTeacherGender(Gender.male);
    context.read<DropdownButtonCubit>().selectBranch(null);
    context.read<DropdownButtonCubit>().selectBank(null);
  }
}
