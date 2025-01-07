import 'package:aloka_mobile_app/src/models/user/user_model.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/bloc/user_bloc/user_login_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button/app_main_button.dart';
import '../../../components/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isDeviceConnected = false;
  bool isAlertSet = false;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();

  bool? newUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<UserLoginBloc, UserLoginState>(
          listener: (context, state) {
            if (state is SystemUserLoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                  ),
                ),
              );
            }
            if (state is SystemUserLoginSuccess) {
              Navigator.of(context, rootNavigator: true).pushNamed('/home');
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        foregroundImage:
                            const AssetImage("assets/logo/brr.png"),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 80,
                      ),
                      Text(
                        "SAVIDYA HIGHER EDUCATION INSTITUTE",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: ColorUtil.blueColor[10]),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 50),
                        child: Column(
                          children: [
                            MyTextField(
                              controller: _userName,
                              hintText: "User Name",
                              inputType: TextInputType.text,
                              obscureText: false,
                              icon: const Icon(Icons.lock),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              controller: _userPassword,
                              hintText: "Password",
                              inputType: TextInputType.text,
                              obscureText: true,
                              icon: const Icon(Icons.lock),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Forgot",
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed("/password_reset");
                                  },
                                  child: const Text(
                                    "Password ?",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppMainButton(
                                onTap: () async {
                                  context.read<UserLoginBloc>().add(
                                        SystemUserLoginEvent(
                                          myUser: MyUserModelClass(
                                            userName: _userName.text.trim(),
                                            password: _userPassword.text.trim(),
                                          ),
                                        ),
                                      );
                                },
                                height: 50,
                                testName: "Login"),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/help_screen');
                                },
                                child: const Text(
                                  "Help Center",
                                  style: TextStyle(color: Colors.red),
                                )),
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
      ),
    );
  }
}
