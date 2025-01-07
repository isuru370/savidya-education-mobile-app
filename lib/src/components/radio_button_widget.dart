import 'package:flutter/material.dart';

class RadioButtonWidget extends StatelessWidget {
  final dynamic buttonTitle, value;
  final dynamic groupValue;
  final Function(dynamic) onChanged;
  const RadioButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(
          buttonTitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
