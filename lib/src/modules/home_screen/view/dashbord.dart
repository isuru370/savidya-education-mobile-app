import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';

import '../arguments/student_editable.dart';
import '../components/drawer_header_widget.dart';
import '../components/drawer_list_item_widget.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord>
    with SingleTickerProviderStateMixin {
  final List<FlSpot> paymentData = [
    FlSpot(1, 200),
    FlSpot(2, 300),
    FlSpot(3, 150),
    FlSpot(4, 400),
    FlSpot(5, 250),
  ];
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the AnimationController for continuous scrolling
    _controller = AnimationController(
      duration: const Duration(
          seconds: 10), // Set your animation duration for one full loop
      vsync: this,
    );

    // Create a slide animation with a horizontal offset for continuous scroll from right to left
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start position (off-screen to the right)
      end: const Offset(-1.0, 0.0), // End position (off-screen to the left)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Start the animation and loop continuously
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      backgroundColor: ColorUtil.tealColor[10],
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
                Navigator.of(context, rootNavigator: true).pushNamed('/home');
              },
              icon: FontAwesome5.house_user,
              color: ColorUtil.tealColor[10]!,
              title: 'Home',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/teacher_screen', arguments: {
                  "update_teacher": false,
                });
              },
              icon: Fontelico.crown_plus,
              color: ColorUtil.tealColor[10]!,
              title: 'Add Tutor',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/class_screen',
                    arguments: {"edit_mode": false});
              },
              icon: Entypo.home,
              color: ColorUtil.tealColor[10]!,
              title: 'Add Class',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/class_schedule');
              },
              icon: Entypo.bucket,
              color: ColorUtil.tealColor[10]!,
              title: 'Class Schedule',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/today_classes');
              },
              icon: FontAwesome5.book_reader,
              color: ColorUtil.tealColor[10]!,
              title: 'Today Classes',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/user_screen');
              },
              icon: FontAwesome5.user,
              color: ColorUtil.tealColor[10]!,
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
              color: ColorUtil.tealColor[10]!,
              title: 'Student Details',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/teacher_all_screen',
                    arguments: {"update_teacher": false});
              },
              icon: Entypo.database,
              color: ColorUtil.tealColor[10]!,
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
              color: ColorUtil.tealColor[10]!,
              title: 'Class Details',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.pushNamed(context, '/cheng_grade');
              },
              icon: Icons.grade,
              color: ColorUtil.tealColor[10]!,
              title: 'Chenge Grade',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/student_generate_id');
              },
              icon: Entypo.print,
              color: ColorUtil.tealColor[10]!,
              title: 'Print_all',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/reports');
              },
              icon: FontAwesome5.file_export,
              color: ColorUtil.tealColor[10]!,
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
              color: ColorUtil.tealColor[10]!,
              title: 'payment check',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/add_admission');
              },
              icon: FontAwesome5.dollar_sign,
              color: ColorUtil.tealColor[10]!,
              title: 'Add Admission',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/pay_admission');
              },
              icon: FontAwesome5.file_invoice_dollar,
              color: ColorUtil.tealColor[10]!,
              title: 'Pay Admission',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/today_pay_admission');
              },
              icon: FontAwesome5.file_invoice_dollar,
              color: ColorUtil.tealColor[10]!,
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
              color: ColorUtil.tealColor[10]!,
              title: 'Profile',
            ),
            DrawerListItemWidget(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/help_screen');
              },
              icon: Icons.help,
              color: ColorUtil.tealColor[10]!,
              title: 'Help Center',
            ),
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
      body: Column(
        children: [
          Center(
            child: ClipRect(
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Welcome to Savidya Education Institute',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // The Expanded widget ensures the ListView takes up the remaining space
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height:
                              150, // Set a fixed height for the cards to maintain consistency
                          child: Row(
                            children: [
                              _buildStatCard(
                                  "Active Student Count", "254", Colors.green),
                              _buildStatCard(
                                  "Inactive Teacher Count", "254", Colors.red),
                              _buildStatCard(
                                  "Ongoing Class Count", "254", Colors.blue),
                              _buildStatCard(
                                  "Outgoing Class Count", "254", Colors.purple),
                              _buildStatCard(
                                  "Deleted Class Count", "254", Colors.orange),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 300, // Set a fixed height for the chart
                    child: _buildLineChart(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 10.0), // Space between cards
      child: Card(
        color: Colors.white
            // ignore: deprecated_member_use
            .withOpacity(0.2), // Light color for the card background
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Container(
          width: 180, // Fixed width to control box size
          height: 260, // Fixed height to control box size
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                // ignore: deprecated_member_use
                color.withOpacity(0.3), // Light color for the card background
          ),
          padding: const EdgeInsets.all(16.0), // Add padding inside the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text("Day ${value.toInt()}");
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: paymentData,
            isCurved: true,
            barWidth: 4,
            color: Colors.amber,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
