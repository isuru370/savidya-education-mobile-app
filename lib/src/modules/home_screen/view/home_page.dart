import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../res/color/app_color.dart';
import '../arguments/from_data.dart';
import '../arguments/student_editable.dart';
import '../bloc/quick_camera/quick_camera_bloc.dart';
import '../components/horizontalmainview.dart';
import '../components/vertical_main_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectOption = 'Option 1';
  late String paidStudent;
  int? newStu = 0;
  int? paid = 0;

  //camera image
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocListener<QuickCameraBloc, QuickCameraState>(
        listener: (context, state) {
          if (state is QuickCameraFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.massage,
                ),
              ),
            );
          }
          if (state is QuickCameraSuccess) {
            Navigator.of(context).pushNamed('/quick_camera',
                arguments: FromData(studentImagePath: state.imageResult));
          }
        },
        child: BlocBuilder<QuickCameraBloc, QuickCameraState>(
          builder: (context, state) {
            if (state is QuickCameraProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/read_student_id_screen',
                                      arguments: {
                                        "screen_name": "view_student",
                                      });
                                },
                                icon: 'assets/svg/search.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Search"),
                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  context
                                      .read<QuickCameraBloc>()
                                      .add(QuickCameraClickEvent());
                                },
                                icon: 'assets/svg/quickcamera.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Quick Image"),
                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/read_student_id_screen',
                                          arguments: {
                                        'screen_name': "student_add_class",
                                      });
                                },
                                icon: 'assets/svg/class_add.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Add To Class"),

                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/read_student_id_screen',
                                          arguments: {
                                        'screen_name': "student_tute",
                                      });
                                },
                                icon: 'assets/svg/tute.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Tute"),

                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/all_active_student',
                                          arguments:
                                              const ActiveStudentViewEditable(
                                                  editable: true));
                                },
                                icon: 'assets/svg/student.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Edit Student"),
                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/class_at_category',
                                          arguments: {'class_id': null});
                                },
                                icon: 'assets/svg/category.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Add Category"),
                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/teacher_all_screen',
                                          arguments: {
                                        "update_teacher": true,
                                      });
                                },
                                icon: 'assets/svg/tutor.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Edit tutor"),
                            const SizedBox(
                              width: 20,
                            ),
                            HorizontalMainViewWidget(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/all_active_class',
                                          arguments: {
                                        "edit_mode": true,
                                      });
                                },
                                icon: 'assets/svg/stuinclass.svg',
                                colorFilter: ColorFilter.mode(
                                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                                text: "Edit Class"),
                            // const SizedBox(
                            //   width: 20,
                            // ),
                            // HorizontalMainViewWidget(
                            //     onTap: () {
                            //       // Navigator.push(
                            //       //     context,
                            //       //     MaterialPageRoute(
                            //       //         builder: (context) => const SelectClass(
                            //       //               name: 'cancel',
                            //       //             )));
                            //     },
                            //     icon: 'assets/svg/cancel.svg',
                            //     colorFilter: ColorFilter.mode(
                            //         ColorUtil.roseColor[10]!, BlendMode.srcIn),
                            //     text: "Class Cancel")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          VerticalMainViewWidget(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/student',
                                arguments:
                                    const StudentEditable(editable: false),
                              );
                            },
                            homeIcon1: 'assets/svg/addstu.svg',
                            homeText: "Add New Student",
                            homeIcon2: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          VerticalMainViewWidget(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  '/new_attendance_read_screen',
                                );
                                // Navigator.of(context, rootNavigator: true)
                                //     .pushNamed(
                                //   '/select_class',
                                //   arguments: const SelectClassArguments(
                                //     selectPayHasAtt: "Attendance",
                                //   ),
                                // );
                              },
                              homeIcon1: 'assets/svg/attendent.svg',
                              homeIcon2: const Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              ),
                              homeText: "Attendance"),
                          const SizedBox(
                            height: 15,
                          ),
                          VerticalMainViewWidget(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('/payment_read_screen',
                                        arguments: {
                                      "name": "ordinary-level",
                                    });
                              },
                              homeIcon1: 'assets/svg/payment.svg',
                              homeIcon2: const Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              ),
                              homeText: "Student O/L Payment"),
                          const SizedBox(
                            height: 10,
                          ),
                          VerticalMainViewWidget(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('/payment_read_screen',
                                        arguments: {
                                      "name": "advance-level",
                                    });
                              },
                              homeIcon1: 'assets/svg/payment.svg',
                              homeIcon2: const Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              ),
                              homeText: "Student A/L Payment"),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // void checkPermissionAndNavigate(BuildContext context, String pageName) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) => AccessPages(
  //         pageName: pageName,
  //         userTypeId: context.read<UserLoginBloc>().state
  //                 is SystemUserLoginSuccess
  //             ? (context.read<UserLoginBloc>().state as SystemUserLoginSuccess)
  //                 .myUserModelClass[0]
  //                 .userTypeId!
  //             : 0,
  //         onSuccess: () {
  //           switch (pageName) {
  //             case "Add New Student":
  //               break;
  //             case "Head-Student Payments":
  //               break;
  //             case "Head-Student Attendance":
  //               break;
  //             default:
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text("Unknown page name")),
  //               );
  //           }
  //         },
  //         onError: () {
  //           Navigator.of(context).pushNamed('/unknown_page');
  //         },
  //       ),
  //     ),
  //   );
  // }
}
