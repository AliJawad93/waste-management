import 'dart:io';
import 'dart:math';
import 'package:app/core/utils/app_string.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/main_page.dart';
import 'package:app/view/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';
import '../../../widgets/custom_elevated_button.dart';

class UserInfio extends StatefulWidget {
  const UserInfio({super.key});

  @override
  State<UserInfio> createState() => _UserInfioState();
}

class _UserInfioState extends State<UserInfio> {
  GlobalKey<FormState> formstate = GlobalKey();
  final _reference = FirebaseStorage.instance.ref();
  File? _file;
  String? username, birthday;
  var imagepicker;
  PlatformFile? _platformFile;
  Future<String?> uploadWithGetURL(pickerImage) async {
    if (pickerImage == null) return null;
    final imageName = pickerImage!.name;
    final image = File(pickerImage!.path!);
    try {
      final ref = _reference.child(imageName);
      final uploadTask = ref.putFile(image);
      final snapShot = await uploadTask.whenComplete(() {});
      return await snapShot.ref.getDownloadURL();
    } catch (e) {
      print("ERORR");
      return null;
    }
  }

  addinformation() async {
    try {
      String? url = await uploadWithGetURL(_platformFile);
      var user = FirebaseAuth.instance.currentUser;
      // FirebaseFirestore.instance.collection('users').add({
      //   'username': username,
      //   'birthday': birthday,
      //   'id': userID,
      //   'url': url,
      // });
      print(user?.uid.toString());
      await FirebaseFirestore.instance.collection('user').doc(user?.uid).set({
        "uid": user?.uid,
        "name": username,
        "id_bin": "",
        "email": user?.email,
        "photoUrl": url ?? "noimage",
        "birthday": birthday,
        "status": "",
        "is_subscribe": false,
        "user_role": "user",
        "creationTime": user?.metadata.creationTime!.toIso8601String(),
        "lastSignInTime": user?.metadata.lastSignInTime!.toIso8601String(),
        "updatedTime": DateTime.now().toIso8601String(),
      });
      prefs.setBool(KeysSharePref.isLogin, true);
      Get.offAll(() => MainPage());
    } catch (e) {
      print(e);
    }
  }

  String? userNameVaild(val) {
    if (val!.length <= 1) {
      return AppString.pleasenterGraterThan2letter.tr;
    }
    return null;
  }

  String? birthDayVaild(val) {
    if (val!.length <= 3) {
      return AppString.pleasenterGraterThan3letter.tr;
    }
    return null;
  }

  Future<PlatformFile?> selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return result.files.first;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,

      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: SafeArea(
                  child: Form(
                key: formstate,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomImagePerson(),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: userNameVaild,
                        onChanged: (value) {
                          username = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppString.enterYourName.tr,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: birthDayVaild,
                        onChanged: (val) {
                          birthday = val;
                        },
                        decoration: InputDecoration(
                          hintText: AppString.enterYourBirthday.tr,
                          prefixIcon: Icon(
                            Icons.dataset,
                            color: Colors.grey,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          title: AppString.send.tr,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await addinformation();
                            setState(() {
                              isLoading = false;
                            });
                          }),
                    ],
                  ),
                ),
              )),
            ),
    );
  }

  CustomImagePerson() {
    return Container(
      height: sqrt((Get.height + Get.width) * 7),
      width: sqrt((Get.height + Get.width) * 7),
      margin: EdgeInsets.only(top: Get.height * 0.025),
      decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _platformFile == null
              ? Icon(
                  Icons.person_outline,
                  size: 30,
                )
              : ClipOval(child: Image.file(File(_platformFile!.path!))),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                _platformFile = await selectImage();
                setState(() {});
              },
              child: CircleAvatar(
                radius: 11,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
