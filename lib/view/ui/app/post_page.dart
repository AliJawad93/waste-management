import 'package:app/controller/main_page_controller.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_post.dart';
import 'package:app/main.dart';
import 'package:app/model/post_model.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/admin/ui/add_post.dart';
import 'package:app/view/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_ch.dart';
import '../../widgets/custom_post_card.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final MainPageController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text(
            AppString.posts.tr,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
          actions: [
            prefs.getString(KeysSharePref.userRole) == "admin"
                ? IconButton(
                    onPressed: () {
                      Get.to(() => AddPost());
                    },
                    icon: const Icon(
                      Icons.add,
                    ))
                : const SizedBox(),
          ],
        ),
        body: StreamBuilder<List<PostModel>>(
          stream: FirebasePost.getPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                //   CustomChoiceClip(),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) =>
                          CustomPostCard(snapshot.data![index])),
                )
              ],
            );
          },
        ));
  }
}
