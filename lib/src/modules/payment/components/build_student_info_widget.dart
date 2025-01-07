import 'package:flutter/material.dart';

class BuildStudentInfoWidget extends StatelessWidget {
  final String imageUrl;
  final String initialName;
  final String studentCustomId;

  const BuildStudentInfoWidget({
    super.key,
    required this.imageUrl,
    required this.initialName,
    required this.studentCustomId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(
                (0.1 * 255).toInt()), // Convert opacity to alpha value
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            initialName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Student ID: $studentCustomId'.toUpperCase(),
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
