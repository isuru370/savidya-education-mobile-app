import 'package:flutter/material.dart';

import '../../../models/teacher/teacher.dart';
import '../../../res/color/app_color.dart';
import 'teacher_has_classes.dart';

class TeacherViewScreen extends StatelessWidget {
  final TeacherModelClass teacherModelClass;

  const TeacherViewScreen({super.key, required this.teacherModelClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.tealColor[10], // Define a primary color
        title: const Text(
          'Tutor Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.report),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Profile Header
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: ColorUtil.whiteColor[10],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withAlpha((0.2 * 255).toInt()), // Replace withAlpha
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2), // Shadow direction
                  ),
                ],
              ),
              child: Column(
                children: [
                  Badge(
                    smallSize: 14,
                    alignment: Alignment.bottomRight,
                    backgroundColor: teacherModelClass.isActive == 1
                        ? ColorUtil.greenColor[10]
                        : ColorUtil.roseColor[10],
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/logo/brr.png',
                      ),
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    teacherModelClass.fullName ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorUtil.blackColor[10],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    teacherModelClass.initialName ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorUtil.blackColor[14],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    teacherModelClass.email ?? '',
                    style: TextStyle(color: ColorUtil.blackColor[10]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    teacherModelClass.nic ?? '',
                    style: TextStyle(color: ColorUtil.blackColor[10]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // View Classes Button as a Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherHasClasses(
                        teacherModelClass: teacherModelClass,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.class_, color: ColorUtil.tealColor[10]),
                      const SizedBox(width: 10),
                      Text(
                        'View Classes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorUtil.tealColor[10],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.mobile_friendly,
                      text: teacherModelClass.mobile ?? '',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.location_city,
                      text:
                          '${teacherModelClass.address1 ?? ''} ${teacherModelClass.address2 ?? ''} ${teacherModelClass.address3 ?? ''}',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.date_range_sharp,
                      text: teacherModelClass.birthday ?? '',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.female,
                      text: teacherModelClass.gender ?? '',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.add_business_sharp,
                      text: teacherModelClass.graduationDetails ?? '',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.explicit_sharp,
                      text: teacherModelClass.experience ?? '',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: ColorUtil.tealColor[10]),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: ColorUtil.blackColor[10]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Dummy View Classes Screen
