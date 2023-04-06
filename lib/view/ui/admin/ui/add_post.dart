import 'dart:ffi';

import 'package:app/controller/adding_post_controller.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_post.dart';
import 'package:app/model/post_model.dart';
import 'package:app/view/ui/admin/widgets/choice_clip_post.dart';
import 'package:app/view/ui/app/main_page.dart';
import 'package:app/view/ui/app/post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_scafold.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text_form.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final AddingPostController _controller = Get.put(AddingPostController());
  bool isLoading = false;
  DateTime date = DateTime.now();
  Future<void> post() async {
    String? urlImage =
        await FirebasePost.uploadWithGetURL(_controller.getPlatformFile);
    String dateShape =
        DateFormat("yyyy-mm-dd hh:mm a").format(DateTime.now()).toString();

    if (_controller.getText != null &&
        _controller.getType != null &&
        urlImage != null) {
      PostModel postModel = PostModel(
          type: _controller.getType!,
          text: _controller.getText!,
          date: dateShape,
          urlImage: urlImage);
      FirebasePost.addPost(postModel);
      Get.offAll(() => MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppString.posts.tr),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await post();
                setState(() {
                  isLoading = false;
                });
              },
              icon: const Icon(Icons.post_add))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    //   CustomChoiceClipPost(),
                    CustomTextFormPost(),
                    CustomImagePost(),
                  ],
                ),
              ),
            ),
    );
  }
}
