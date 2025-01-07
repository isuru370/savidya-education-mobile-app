import 'package:flutter/material.dart';

import '../res/color/app_color.dart';

class UserStatesWidget extends StatelessWidget {
  final String statesTitle;
  final Function(bool) onChanged;
  final bool value;
  const UserStatesWidget({
    super.key,
    required this.statesTitle,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 60,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            statesTitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Switch(
              activeColor: ColorUtil.tealColor[10],
              thumbColor: WidgetStateProperty.all(ColorUtil.tealColor[10]),
              trackColor: WidgetStateProperty.all(ColorUtil.whiteColor[22]),
              value: value,
              onChanged: onChanged),
        ],
      ),
    );
  }
}
