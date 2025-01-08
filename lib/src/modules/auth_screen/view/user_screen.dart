
import 'package:aloka_mobile_app/src/extensions/str_extensions.dart';
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
import '../../../models/user/user_model.dart';
import '../../../models/user/user_type_model.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../provider/cubit_provider/radio_button_cubit/radio_button_cubit.dart';
import '../../../res/color/app_color.dart';
import '../../student_screen/components/radio_group_widget.dart';
import '../bloc/user_bloc/user_login_bloc.dart';
import '../bloc/user_type_bloc/user_type_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _userFName = TextEditingController();
  final TextEditingController _userLName = TextEditingController();
  final TextEditingController _userEAddress = TextEditingController();
  final TextEditingController _userNicNo = TextEditingController();
  final TextEditingController _userMobileNo = TextEditingController();
  final TextEditingController _userBirthday = TextEditingController();
  final TextEditingController _userAL1 = TextEditingController();
  final TextEditingController _userAL2 = TextEditingController();
  final TextEditingController _userAL3 = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  bool editMode = false;
  String? userGender;
  int? userTypeId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: Text(editMode ? "Edit System User" : "System User"),
      ),
      body: BlocListener<UserLoginBloc, UserLoginState>(
        listener: (context, state) {
          if (state is SystemUserLoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is SystemUserInsertSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
            clearTextField();
          }
        },
        child: BlocBuilder<UserLoginBloc, UserLoginState>(
          builder: (context, state) {
            if (state is SystemUserLoginProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          MyTextField(
                              controller: _userFName,
                              hintText: "First Name",
                              inputType: TextInputType.name,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _userLName,
                              hintText: "Last Name",
                              inputType: TextInputType.name,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _userEAddress,
                              hintText: "Email Address",
                              inputType: TextInputType.emailAddress,
                              obscureText: false,
                              icon: const Icon(Icons.email)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _userNicNo,
                              hintText: "Nic Number",
                              inputType: TextInputType.text,
                              obscureText: false,
                              icon: const Icon(Icons.add_card)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _userMobileNo,
                              hintText: "Mobile Number",
                              inputType: TextInputType.phone,
                              obscureText: false,
                              icon: const Icon(Icons.call)),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<RadioButtonCubit, RadioButtonState>(
                            builder: (context, gender) {
                              if (gender is RadioButtonInitial) {
                                userGender = gender.userGender.name;

                                return RadioGroupWidget(
                                  mainText: 'Gender',
                                  children: [
                                    RadioButtonWidget(
                                      buttonTitle: 'Male',
                                      value: Gender.male,
                                      groupValue: gender.userGender,
                                      onChanged: (genders) {
                                        context
                                            .read<RadioButtonCubit>()
                                            .selectUserGender(genders);
                                      },
                                    ),
                                    RadioButtonWidget(
                                      buttonTitle: 'Female',
                                      value: Gender.female,
                                      groupValue: gender.userGender,
                                      onChanged: (genders) {
                                        context
                                            .read<RadioButtonCubit>()
                                            .selectUserGender(genders);
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
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
                                _userBirthday.text = state.birthdayDate;
                              }
                              return DisableTextFieldWidget(
                                controller: _userBirthday,
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
                              controller: _userAL1,
                              hintText: "Address Line 1",
                              inputType: TextInputType.streetAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _userAL2,
                              hintText: "Address Line 2",
                              inputType: TextInputType.streetAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: _userAL3,
                              hintText: "Address Line 3",
                              inputType: TextInputType.streetAddress,
                              obscureText: false,
                              icon: const Icon(null)),
                          Column(
                            children: [
                              editMode
                                  ? BlocBuilder<CheckboxButtonCubit,
                                      CheckboxButtonState>(
                                      builder: (context, state) {
                                        if (state is CheckboxButtonInitial) {
                                          return UserStatesWidget(
                                            statesTitle: 'User Active Status',
                                            value: state.isStudentActiveStatus,
                                            onChanged: (status) {
                                              context
                                                  .read<CheckboxButtonCubit>()
                                                  .toggleUserActiveStatus(
                                                      status);
                                            },
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          editMode
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    const BodyTextWidget(
                                      bodyTextTitle: 'User Login Details',
                                      icon: Icons.payment_outlined,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<UserTypeBloc, UserTypeState>(
                                      builder: (context, state) {
                                        if (state is GetUserTypeState) {
                                          return DropDownButtonWidget(
                                            widget:
                                                selectUser(state.userTypeList),
                                          );
                                        } else if (state
                                            is GetUserTypeFailureState) {
                                          return Text(
                                              'Error: ${state.failureMessage}');
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                        controller: _userName,
                                        hintText: "User Name",
                                        inputType: TextInputType.text,
                                        obscureText: false,
                                        icon: const Icon(
                                          Icons.key,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                        controller: _userPassword,
                                        hintText:
                                            "User Password  (ex :- abc123! )",
                                        inputType: TextInputType.text,
                                        obscureText: true,
                                        icon: const Icon(Icons.lock)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                          AppMainButton(
                              testName: editMode ? 'Update Users' : 'Save User',
                              onTap: () {
                                insertUserData();
                              },
                              height: 50),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget selectUser(List<UserTypeModelClass> getUserTypeList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
        builder: (context, state) {
      return DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a User type'),
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          value: state.selectUser,
          items: getUserTypeList.map((UserTypeModelClass userType) {
            return DropdownMenuItem<UserTypeModelClass>(
              value: userType,
              child: Text("${userType.id} " " ${userType.type}"),
            );
          }).toList(),
          onChanged: (UserTypeModelClass? newUserType) {
            if (newUserType != null) {
              context.read<DropdownButtonCubit>().selectUser(newUserType);
              userTypeId = newUserType.id;
            }
          });
    });
  }

  validation() {
    if (RegisterFrom.notEmpty(_userFName.text, 'first name', context) &&
        RegisterFrom.notEmpty(_userLName.text, 'last name', context) &&
        RegisterFrom.emailCheck(_userEAddress.text, context) &&
        RegisterFrom.nicNumberCheck(_userNicNo.text, context) &&
        RegisterFrom.mobileNUmberCheck(_userMobileNo.text, context) &&
        RegisterFrom.passwordCheck(_userPassword.text, context) &&
        RegisterFrom.notEmpty(_userName.text, "user name", context) &&
        RegisterFrom.notEmpty(_userBirthday.text, 'birthday', context) &&
        RegisterFrom.notEmpty(_userAL1.text, 'address line 1', context) &&
        RegisterFrom.notEmpty(_userAL2.text, 'address line 2', context)) {
      return true;
    } else {
      return false;
    }
  }

  insertUserData() {
    if (userGender != null) {
      if (validation()) {
        MyUserModelClass userModelClass = MyUserModelClass(
          userName: _userName.text,
          email: _userEAddress.text,
          password: _userPassword.text,
          userTypeId: userTypeId,
          isActive: 1,
          firstName: _userFName.text.capitalizeEachWord,
          lastName: _userLName.text.capitalizeEachWord,
          mobileNumber: _userMobileNo.text,
          nic: _userNicNo.text,
          birthday: _userBirthday.text,
          gender: userGender!.firstCapital,
          addressLine1: _userAL1.text.capitalizeEachWord,
          addressLine2: _userAL2.text.capitalizeEachWord,
          addressLine3: _userAL3.text.capitalizeEachWord,
        );
        context
            .read<UserLoginBloc>()
            .add(InsertSystemUserEvent(myUser: userModelClass));
      }
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

  clearTextField() {
    _userFName.clear();
    _userLName.clear();
    _userEAddress.clear();
    _userNicNo.clear();
    _userMobileNo.clear();
    _userBirthday.clear();
    _userAL1.clear();
    _userAL2.clear();
    _userAL3.clear();
    _userName.clear();
    _userPassword.clear();

    context.read<RadioButtonCubit>().selectStudentGender(Gender.male);
    context.read<DropdownButtonCubit>().selectUser(null);
  }
}
