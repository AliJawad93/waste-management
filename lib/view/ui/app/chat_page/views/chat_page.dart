import 'package:app/core/constants/App_colors.dart';
import 'package:app/core/constants/app_image_path.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/view/ui/app/search/views/search_view.dart';
import 'package:app/view/widgets/custom_scafold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppString.chat.tr),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => SearchView()),
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Material(
          //   elevation: 5,
          //   child: Container(
          //     margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
          //     decoration: BoxDecoration(
          //       border: Border(
          //         bottom: BorderSide(
          //           color: Colors.black38,
          //         ),
          //       ),
          //     ),
          //     padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Chats",
          //           style: TextStyle(
          //             fontSize: 35,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Material(
          //           borderRadius: BorderRadius.circular(50),
          //           color: Colors.red[900],
          //           child: InkWell(
          //             borderRadius: BorderRadius.circular(50),
          //             onTap: () => Get.toNamed(Routes.PROFILE),
          //             child: Padding(
          //               padding: const EdgeInsets.all(5),
          //               child: Icon(
          //                 Icons.person,
          //                 size: 35,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatsStream(uid),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var listDocsChats = snapshot1.data?.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats?.length ?? 0,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .friendStream(listDocsChats?[index]["connection"]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            return data?["status"] == ""
                                ? Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ),
                                      onTap: () => controller.goToChatRoom(
                                        "${listDocsChats?[index].id}",
                                        uid,
                                        listDocsChats?[index]["connection"],
                                      ),
                                      leading: CachedNetworkImage(
                                        imageUrl: data?["photoUrl"],
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: imageProvider),
                                                shape: BoxShape.circle),
                                          );
                                        },
                                        placeholder: (context, url) => Icon(
                                          Icons.person_outline,
                                          color: AppColors.primary,
                                          size: 35,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.person_outline,
                                          color: AppColors.primary,
                                          size: 35,
                                        ),
                                      ),
                                      title: Text(
                                        "${data?["name"]}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      trailing: listDocsChats?[index]
                                                  ["total_unread"] ==
                                              0
                                          ? SizedBox()
                                          : CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primary,
                                              child: Text(
                                                "${listDocsChats?[index]["total_unread"]}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                    ),
                                  )
                                : ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats?[index].id}",
                                      uid,
                                      listDocsChats?[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data?["photoUrl"] == "noimage"
                                            ? Icon(Icons.person)
                                            : Image.network(
                                                "${data?["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data?["name"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${data?["status"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: listDocsChats?[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            backgroundColor: AppColors.primary,
                                            label: Text(
                                              "${listDocsChats?[index]["total_unread"]}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
