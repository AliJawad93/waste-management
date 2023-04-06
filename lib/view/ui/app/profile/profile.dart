import 'dart:math';

import 'package:app/controller/main_page_controller.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/profile/widgets/card_item_profile.dart';
import 'package:app/view/widgets/custom_scafold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(title: Text(AppString.profile.tr)),
      body: isLoading
          ? CircularProgressIndicator(
              color: AppColors.primary,
            )
          : Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: sqrt((Get.height + Get.width) * 0.2)),
                height: Get.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: sqrt((Get.height + Get.width) * 8),
                      width: sqrt((Get.height + Get.width) * 8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              prefs.getString(KeysSharePref.urlImage) ?? "",
                          placeholder: (context, url) => Icon(
                            Icons.person,
                            color: AppColors.gray,
                            size: 35,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.person,
                            color: AppColors.gray,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      prefs.getString(KeysSharePref.name) ?? "",
                      style: TextStyle(color: AppColors.black, fontSize: 18),
                    ),
                    Text(
                      prefs.getString(KeysSharePref.email) ?? "",
                      style: TextStyle(color: AppColors.black, fontSize: 18),
                    ),
                    Text(
                      prefs.getString(KeysSharePref.birthDay) ?? "",
                      style: TextStyle(color: AppColors.black, fontSize: 18),
                    ),
                    CardItemProfile(
                        title: AppString.editProfile.tr,
                        iconData: Icons.edit_outlined,
                        onTap: () {
                          Get.snackbar(
                              AppString.comingSoon.tr, AppString.comingSoon.tr,
                              colorText: AppColors.white,
                              backgroundColor: AppColors.primary,
                              snackPosition: SnackPosition.BOTTOM);
                        }),
                    CardItemProfile(
                        title: AppString.policiesAndTerms.tr,
                        iconData: Icons.description,
                        onTap: () {}),
                    CardItemProfile(
                        title: AppString.signOut.tr,
                        iconData: Icons.logout,
                        onTap: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseAuth.instance.signOut();
                            await prefs.clear();
                            await prefs.setBool(KeysSharePref.isLogin, false);
                            setState(() {
                              isLoading = false;
                            });
                            Get.offAll(() => Login());
                          } catch (e) {
                            Get.snackbar('error', e.toString());
                          }
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
