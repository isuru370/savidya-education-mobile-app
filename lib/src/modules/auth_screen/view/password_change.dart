import 'package:aloka_mobile_app/src/extensions/str_extensions.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/bloc/reset_password/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aloka_mobile_app/src/components/button/app_main_button.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import '../../../components/app_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String userName;
  const ChangePasswordScreen({super.key, required this.userName});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
        backgroundColor: ColorUtil.tealColor[10],
        elevation: 0,
      ),
      body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is PasswordResetFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
              ),
            );
          } else if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
            Navigator.of(context, rootNavigator: true).pushNamed('/');
          }
        },
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          builder: (context, state) {
            if (state is PasswordResetProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/resetpassword.svg',
                      width: 120,
                      height: 120,
                      colorFilter: ColorFilter.mode(
                          ColorUtil.tealColor[10]!, BlendMode.srcIn),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Password Reset",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorUtil.tealColor[10],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: ColorUtil.whiteColor[10],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ColorUtil.blackColor[12]!,
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          MyTextField(
                            controller: _otp,
                            hintText: "Enter OTP",
                            obscureText: true,
                            icon: Icon(Icons.numbers,
                                color: ColorUtil.tealColor[10]),
                            inputType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          MyTextField(
                            controller: _password,
                            hintText: "New Password",
                            obscureText: true,
                            icon: Icon(Icons.lock,
                                color: ColorUtil.tealColor[10]),
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          MyTextField(
                            controller: _confirmPassword,
                            hintText: "Confirm Password",
                            obscureText: true,
                            icon: Icon(Icons.lock,
                                color: ColorUtil.tealColor[10]),
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          AppMainButton(
                            testName: "Save",
                            onTap: () {
                              if (checkPassword()) {
                                if (_password.text.toString().trim() ==
                                    _confirmPassword.text.toString().trim()) {
                                  context.read<ResetPasswordBloc>().add(
                                      ChangePasswordEvent(
                                          otp: int.parse(_otp.text.trim()),
                                          password: _password.text.trim(),
                                          userName: widget.userName));
                                } else {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("password not match"),
                                      ),
                                    );
                                  });
                                }
                              }
                            },
                            height: 50,
                          ),
                        ],
                      ),
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

  checkPassword() {
    if (_password.text.isValidPassword) {
      return true;
    }
    return false;
  }
}
