import 'package:flutter/material.dart';

class DisableTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final Function() onPressed;

  const DisableTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 250,
              height: 45,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(hintText: hintText),
                  enabled: false,
                ),
              ),
            ),
            SizedBox(child: IconButton(icon: Icon(icon), onPressed: onPressed)),
          ]),
    );
  }
}
