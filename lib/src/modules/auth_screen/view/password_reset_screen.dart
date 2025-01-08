import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text_field.dart';
import '../../../components/button/app_main_button.dart';
import '../../../res/color/app_color.dart';
import '../bloc/reset_password/reset_password_bloc.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _userName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Verify user name"),
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
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/password_change_screen', arguments: {
                "userName": _userName.text.trim(),
              });
            }
          },
          child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            builder: (context, state) {
              if (state is PasswordResetProcess) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Forget Password',
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorUtil.greenColor[10],
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SvgPicture.asset(
                        'assets/svg/avatar.svg',
                        width: 100,
                        height: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyTextField(
                            controller: _userName,
                            hintText: 'user name',
                            obscureText: false,
                            icon: const Icon(Icons.email),
                            inputType: TextInputType.emailAddress),
                      ),
                      AppMainButton(
                          testName: 'Reset',
                          onTap: () {
                            context.read<ResetPasswordBloc>().add(
                                EmailVerificationEvent(
                                    userName: _userName.text.trim()));
                          },
                          height: 50)
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
