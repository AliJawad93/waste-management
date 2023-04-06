import 'package:app/core/constants/App_colors.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  CustomRichText(
      {required this.title, required this.text, required this.icon, Key? key})
      : super(key: key);
  String title;
  String text;
  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (icon != null)
            WidgetSpan(
              child: icon!,
            ),
          TextSpan(
              text: title,
              style: TextStyle(color: AppColors.unSelectedIcon, fontSize: 15)),
          TextSpan(
              text: text, style: TextStyle(color: Colors.black, fontSize: 13)),
        ],
      ),
    );
  }
}
