import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';

class CustomTaggleButton extends StatelessWidget {
  void Function() onTap;
  int index;
  int currentIndex;
  String title;
  CustomTaggleButton({
    Key? key,
    required this.onTap,
    required this.index,
    required this.currentIndex,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index == currentIndex ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        duration: Duration(milliseconds: 200),
        child: Text(
          title,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: index == currentIndex ? AppColors.white : Colors.black,
              fontWeight:
                  index == currentIndex ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
