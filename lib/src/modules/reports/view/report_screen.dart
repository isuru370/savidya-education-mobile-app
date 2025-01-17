import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';
import 'tab_screen/daily_report_screen.dart';
import 'tab_screen/monthly_report_screen.dart';
import 'tab_screen/teacher_payment_screen.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text(
            "Reports",
            style: TextStyle(
              fontSize: 24, // Increased font size for the title
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorUtil.tealColor[10],
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontSize: 18, // Larger font size for selected tab
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16, // Slightly smaller font for unselected tab
              fontWeight: FontWeight.w400,
            ),
            labelColor: Colors.white, // Color of the selected tab text
            unselectedLabelColor:
                Colors.black54, // Color of unselected tab text
            indicatorColor: Colors.white, // Indicator color
            indicatorWeight: 4.0, // Thickness of the indicator
            tabs: [
              Tab(text: "Daily Report"),
              Tab(text: "Monthly Report"),
              Tab(text: "Teacher Payment"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DailyReportScreen(),
            MonthlyReportScreen(),
            TeacherPaymentScreen(),
          ],
        ),
      ),
    );
  }
}
