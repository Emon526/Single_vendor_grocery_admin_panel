import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../responsive.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.onpressed,
      required this.text,
      required this.icon,
      required this.backgroundColor})
      : super(key: key);
  final VoidCallback onpressed;
  final String text;
  final IconData icon;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 1.5,
            vertical: defaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
          ),
        ),
        onPressed: () {
          onpressed();
        },
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(text));
  }
}
