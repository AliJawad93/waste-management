import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/adding_post_controller.dart';
import '../../../../core/constants/App_colors.dart';

class CustomChoiceClipPost extends StatefulWidget {
  CustomChoiceClipPost({Key? key}) : super(key: key);
  @override
  State<CustomChoiceClipPost> createState() => _CustomChoiceClipPostState();
}

class _CustomChoiceClipPostState extends State<CustomChoiceClipPost> {
  int selectedIndex = 0;
  List<String> types = ["CLEAN TRASH", "TREES", "CLEANING"];
  final AddingPostController _controller = Get.find();
  @override
  void initState() {
    _controller.setType(types[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: types.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              label: Text(
                types[index],
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
                _controller.setType(types[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
