import 'package:app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/adding_post_controller.dart';
import '../../../../core/constants/App_colors.dart';

class CustomTextFormPost extends StatefulWidget {
  CustomTextFormPost({Key? key}) : super(key: key);

  @override
  State<CustomTextFormPost> createState() => _CustomTextFormPostState();
}

class _CustomTextFormPostState extends State<CustomTextFormPost> {
  final AddingPostController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: Get.height * 0.5,
          decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)],
              borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            onChanged: (value) => _controller.setText(value),
            keyboardType: TextInputType.multiline,
            maxLines: null, // to make auto increase new line
            decoration: InputDecoration(
                fillColor: AppColors.background,
                hintText: AppString.text.tr,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 1),
                )),
          ),
        ),
      ],
    );
  }
}
