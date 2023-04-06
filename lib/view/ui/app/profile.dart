import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/auth/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/main_page_controller.dart';
import '../../../core/constants/App_colors.dart';

class Profile2 extends StatefulWidget {
  Profile2({Key? key}) : super(key: key);

  @override
  State<Profile2> createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  String? name;
  MainPageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile2"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 100,
              width: 100,
              color: AppColors.primary,
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(60.0),
              ),
            ),
            child: Column(
              children: [
                Center(
                    child: IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    prefs.setBool(KeysSharePref.isLogin, false);
                    Get.offAll(() => Login());
                  },
                  icon: Icon(Icons.home),
                )),
                Text("${controller.getDriverModel?.id}"),
                Text("${controller.getuserModel?.userRole}"),
                Container(
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: "",
                          placeholder: (context, url) => Icon(
                            Icons.person_outline,
                            color: AppColors.white,
                            size: 35,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.person_outline,
                            color: AppColors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
