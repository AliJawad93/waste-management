import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton extends StatelessWidget {
  String title;
  void Function() onPressed;
  CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.08,
      width: Get.width,
      child: ElevatedButton(onPressed: onPressed, child: Text(title)),
    );
  }
}
