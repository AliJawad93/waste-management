import 'dart:async';
import 'package:app/core/constants/app_image_path.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/main_page.dart';
import 'package:app/view/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'Addinformatio.dart';
import 'login.dart';

/*
if you have varable 
int n;
and you put (!) n!
and value is come null here will be run time ERROR
! mean imposaple n be null but n come null 
 */
class Verification extends StatefulWidget {
  Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool? isEmailVerified;
  bool isLoading = true;
  bool? isEmailUsed;
  Timer? timer;
  Color iconColor = Color.fromARGB(255, 36, 204, 131);
  Color textFieldColor = Color.fromARGB(255, 247, 246, 246);
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    checkIfEmailUsed();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  Future<void> checkIfEmailUsed() async {
    user = auth.currentUser;
    /*
    at first listen user  will take null 
    and second listen user will take value and stop 
     */
    auth.userChanges().take(2).listen((event) {
      user = event;
      if (user != null) {
        var userRef =
            FirebaseFirestore.instance.collection("users").doc(user!.uid);
        userRef.get().then((value) {
          if (value.exists) {
            //prefs.setString(KeysSharePref.userRole, true);
            prefs.setString(KeysSharePref.uid, auth.currentUser!.uid);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          } else {
            setState(() {
              isEmailVerified = user!.emailVerified;
              isLoading = false;
            });
            sendVerification(user);
          }
        });
      }
      print("{}{}{}{}{}{}{}{}{}{}{}{}{}{}{ inside :" + user.toString());
    });
  }

  Future<void> sendVerification(user) async {
    if (isEmailVerified == false) {
      try {
        await user.sendEmailVerification();
      } catch (e) {
        print(e.toString());
      }
      timer = Timer.periodic(Duration(seconds: 5), (t) {
        timer = t;
        chechEmailVerified();
      });
    }
  }

  Future<void> chechEmailVerified() async {
    // call after email verification
    await auth.currentUser!.reload();
    setState(() {
      isEmailVerified = auth.currentUser!.emailVerified;
      if (isEmailVerified == true) {
        timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return isLoading
        ? Loading()
        : isEmailVerified!
            ? UserInfio()
            : Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Lottie.asset(
                        AppImagePath.resendEmail,
                        width: 250,
                        height: 250,
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          child: Column(
                            children: [
                              Text(
                                AppString.checkYourEmail.tr,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 330,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 50, bottom: 30),
                                child: Text(
                                  AppString.bodyCheckYourEmail.tr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height / 60,
                                    horizontal: width / 6),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    sendVerification(user);
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    size: 25,
                                  ),
                                  label: Text(AppString.send.tr,
                                      style: TextStyle(fontSize: 16)),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      primary: iconColor,
                                      minimumSize: Size(width, 55)),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              GestureDetector(
                                child: Text(
                                  AppString.alreadyHaveAccount.tr,
                                  style: TextStyle(
                                      color: iconColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                              )
                            ],
                          )),
                    )
                  ],
                )),
              );
  }
}
