import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';

class StudentFreeCardWidget extends StatelessWidget {
  const StudentFreeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorUtil.tealColor[10]!, Colors.tealAccent[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withAlpha((0.2 * 255).toInt()), // Convert opacity to alpha
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.card_giftcard,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            'Free Card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
