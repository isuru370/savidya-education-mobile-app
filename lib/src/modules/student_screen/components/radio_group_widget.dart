import 'package:flutter/material.dart';

class RadioGroupWidget extends StatelessWidget {
  final String mainText;
  final List<Widget> children;
  const RadioGroupWidget({
    super.key,
    required this.mainText,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "$mainText :",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Row(
          children: children,
        ),
      ],
    );
  }
}
