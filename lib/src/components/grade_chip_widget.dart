import 'package:flutter/material.dart';

class GradeChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  const GradeChipWidget(
      {super.key, required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Chip(
        label: Text(label),
        backgroundColor: selected ? Colors.teal : Colors.grey[300],
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
