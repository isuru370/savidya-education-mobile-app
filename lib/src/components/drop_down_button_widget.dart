import 'package:flutter/cupertino.dart';

class DropDownButtonWidget extends StatelessWidget {
  final Widget? widget;
  final Color? color;
  const DropDownButtonWidget({super.key, required this.widget, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget);
  }
}
