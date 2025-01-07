import 'package:flutter/material.dart';

class DrawerListItemWidget extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final Color color;
  final String title;
  const DrawerListItemWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
      ),
    );
  }
}
