import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../res/color/app_color.dart';
import '../arguments/from_data.dart';
import '../arguments/student_editable.dart';
import '../bloc/quick_camera/quick_camera_bloc.dart';
import '../components/drawer_header_widget.dart';
import '../components/drawer_list_item_widget.dart';
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
      ),
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeaderWidget(
                drawerHeaderImageUrl: 'assets/logo/brr.png',
                drawerHeaderText: 'SAVIDYA EDUCATION'),
            const SizedBox(
              height: 20,
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/teacher_screen', arguments: {
                  "update_teacher": false,
                });
              },
              icon: Fontelico.crown_plus,
              color: ColorUtil.roseColor[10]!,
              title: 'Add Tutor',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/class_screen',
                    arguments: {"edit_mode": false});
              },
              icon: Entypo.home,
              color: ColorUtil.darkGreenColor[10]!,
              title: 'Add Class',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/class_schedule');
              },
              icon: Entypo.bucket,
              color: ColorUtil.darkGreenColor[10]!,
              title: 'Class Schedule',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/today_classes');
              },
              icon: FontAwesome5.book_reader,
              color: ColorUtil.darkGreenColor[10]!,
              title: 'Today Classes',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/user_screen');
              },
              icon: FontAwesome5.user,
              color: ColorUtil.blackColor[10]!,
              title: 'Add User',
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Divider(),
            ),
            const SizedBox(
              height: 20,
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/all_active_student',
                    arguments:
                        const ActiveStudentViewEditable(editable: false));
              },
              icon: Entypo.database,
              color: ColorUtil.skyBlueColor[10]!,
              title: 'Student Details',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/teacher_all_screen',
                    arguments: {"update_teacher": false});
              },
              icon: Entypo.database,
              color: ColorUtil.roseColor[10]!,
              title: 'Tutor Details',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/all_active_class', arguments: {
                  "edit_mode": false,
                });
              },
              icon: Entypo.database,
              color: ColorUtil.darkGreenColor[10]!,
              title: 'Class Details',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.pushNamed(context, '/cheng_grade');
              },
              icon: Icons.grade,
              color: ColorUtil.blackColor[10]!,
              title: 'Chenge Grade',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/student_generate_id');
              },
              icon: Entypo.print,
              color: ColorUtil.blackColor[10]!,
              title: 'Print_all',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/reports');
              },
              icon: FontAwesome5.file_export,
              color: ColorUtil.blackColor[10]!,
              title: 'Reports',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Divider(),
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/payment_read_screen', arguments: {
                  "name": "half_payment",
                });
              },
              icon: FontAwesome5.money_bill,
              color: ColorUtil.orangeColor[10]!,
              title: 'payment check',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/add_admission');
              },
              icon: FontAwesome5.dollar_sign,
              color: ColorUtil.orangeColor[10]!,
              title: 'Add Admission',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/pay_admission');
              },
              icon: FontAwesome5.file_invoice_dollar,
              color: ColorUtil.orangeColor[10]!,
              title: 'Pay Admission',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/today_pay_admission');
              },
              icon: FontAwesome5.file_invoice_dollar,
              color: ColorUtil.orangeColor[10]!,
              title: 'Today Admission Payment',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Divider(),
            ),

            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/user_profile');
              },
              icon: FontAwesome5.user_shield,
              color: ColorUtil.blackColor[10]!,
              title: 'Profile',
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5),
            //   child: Divider(
            //     thickness: 2,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/help_screen');
              },
              icon: Icons.help,
              color: ColorUtil.roseColor[10]!,
              title: 'Help Center',
            ),
            // DrawerListItemWidget(
            //   onTap: () {},
            //   icon: Icons.light_mode,
            //   color: ColorUtil.blackColor[10]!,
            //   title: 'Light Mode',
            // ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed('/');
              },
              icon: MfgLabs.logout,
              color: ColorUtil.roseColor[10]!,
              title: 'Sign Out',
            ),
          ],
        ),
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
