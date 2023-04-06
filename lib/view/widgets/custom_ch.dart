import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';

class CustomChoiceClip extends StatefulWidget {
  CustomChoiceClip({Key? key}) : super(key: key);

  @override
  State<CustomChoiceClip> createState() => _CustomChoiceClipState();
}

class _CustomChoiceClipState extends State<CustomChoiceClip> {
  int selectedIndex = 0;
  List<String> choiceText = ["ALL", "CLEAN TRASH", "TREES", "CLEANING"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      margin: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: choiceText.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              label: Text(
                choiceText[index],
                style: TextStyle(
                    color: selectedIndex == index
                        ? Colors.white
                        : Color(0xff696d72)),
              ),
              selected: selectedIndex == index,
              selectedColor: AppColors.selectedIcon,
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                  side: BorderSide(
                      color: selectedIndex == index
                          ? Colors.white
                          : Color(0xfff0f0f0),
                      width: 2.0)),
              shadowColor: AppColors.shadow,
              onSelected: (value) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
