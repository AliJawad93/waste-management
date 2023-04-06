import 'package:app/core/constants/app_image_path.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/auth/ResetPassword.dart';
import 'package:app/view/ui/app/auth/SignUp.dart';

import 'package:app/view/ui/app/auth/verify.dart';
import 'package:app/view/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/google_Services.dart';
import '../../../../services/login_services.dart';
import '../../../widgets/custom_elevated_button.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email = TextEditingController();
  late TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color iconColor = Color.fromARGB(255, 36, 204, 131);
  Color textFieldColor = Color.fromARGB(255, 247, 246, 246);
  FirebaseAuth auth = FirebaseAuth.instance;
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String? emailValid(String? value) {
    RegExp regex = RegExp(pattern.toString());
    if (value!.trim().isEmpty) {
      return "Please enter your email";
    } else if (!regex.hasMatch(value)) {
      return "Email is not valid";
    }
    return null;
  }

  String? passwordValid(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter your password";
    } else if (value.trim().length < 7) {
      return "Password length must be greater 6";
    }
    return null;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          height: height / 3,
                          child: Image.asset(
                            AppImagePath.logo,
                            width: 125,
                          )),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            textField(
                                AppString.email.tr,
                                Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                                width,
                                height,
                                email,
                                emailValid),
                            SizedBox(
                              height: 10,
                            ),
                            textField(
                                AppString.password.tr,
                                Icon(
                                  Icons.lock_outlined,
                                  color: Colors.grey,
                                ),
                                width,
                                height,
                                password,
                                passwordValid),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate() !=
                                      false) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await LoginServices.login(
                                        email.text, password.text);

                                    setState(() {
                                      isLoading = false;
                                    });

                                    //login(context);
                                  }
                                },
                                title: AppString.login.tr),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            GestureDetector(
                              child: Text(
                                AppString.forgetPassword.tr,
                                style: TextStyle(
                                    color: iconColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Get.to(() => resetPassword());
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: height / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppString.or.tr,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            button(
                              "Google  ",
                              AppImagePath.google,
                              height,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppString.donotHaveAccount.tr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                GestureDetector(
                                  child: Text(
                                    AppString.createAccount.tr,
                                    style: TextStyle(
                                        color: iconColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ));
  }

  Widget textField(String hint, Icon icon, double width, double height,
      TextEditingController myControl, validFunction) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: TextFormField(
        controller: myControl,
        validator: validFunction,
        decoration: InputDecoration(
          prefixIcon: icon,
          filled: true,
          fillColor: textFieldColor,
          focusColor: textFieldColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textFieldColor),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textFieldColor),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        obscureText: hint == AppString.password.tr ? true : false,
      ),
    );
  }

  Widget text(String word) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        word,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      padding: EdgeInsets.only(left: 18, bottom: 1),
    );
  }

  Widget button(String nameLogo, String imagePath, double height) {
    return InkWell(
      child: Container(
        width: Get.width,
        height: 50,
        decoration: new BoxDecoration(
            color: textFieldColor, //Filling colour
            borderRadius: BorderRadius.all(Radius.circular(10.0)) //Roundness
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: nameLogo == "FaceBook" ? 30 : 27,
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Text(nameLogo)
          ],
        ),
      ),
      onTap: () {
        //Get.snackbar("", message)
        //LoginWithGoogle.signInWithGoogle();
      },
    );
  }
}





// // ignore_for_file: prefer_typing_uninitialized_variables
// import 'package:app/core/constant/imageAsset.dart';
// import 'package:app/widget/auth/face_goole.dart';
// import 'package:app/widget/auth/ImageLogin.dart';
// import 'package:app/widget/auth/login_Appbar.dart';
// import 'package:app/widget/auth/textOFbutton.dart';
// import 'package:app/widget/auth/text_underButton.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'Addinformatio.dart';
// import 'ResetPassword.dart';
// import 'SignUp.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   GlobalKey<FormState> key = GlobalKey<FormState>();
//   var mypassword, myemail, myuser;
//   verfi() async {
//     var v = await key.currentState!;
//     if (v.validate()) {
//       v.save();
//       try {
//         final credential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: myemail, password: mypassword);
//         return credential;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           Get.defaultDialog(
//             title: 'user-not-found',
//             middleText: 'try again ',
//             textCancel: 'cansle',
//           );
//         } else if (e.code == 'wrong-password') {
//           Get.defaultDialog(
//             title: 'Wrong password provided for that user.',
//             middleText: 'try again ',
//             textCancel: 'cansle',
//           );
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: login_appbar(context),
//       body: Container(
//         margin: const EdgeInsets.only(top: 5),
//         child: Form(
//           key: key,
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             child: ListView(children: [
//               const ImageLogin(),
//               TextOFbutton(
//                 text: ' البريد الالكتروني',
//                 height: 25,
//               ),
//               SizedBox(
//                 child: TextFormField(
//                   onSaved: (value) {
//                     myemail = value;
//                   },
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) {
//                     if (value!.length <= 2) {
//                       return 'please enter grater than 10 ';
//                     }
//                     if (value.length >= 100) {
//                       return 'please enter  less than 50 ';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'ادخل البريد الالكتروني',
//                     label: const Text(
//                       'ادخل البريد الالكتروني',
//                     ),
//                     prefixIcon: const Icon(Icons.mail),
//                   ),
//                 ),
//                 /*TextFOrmField(
//                   prefixicon: Icons.mail,
//                   label: 'ادخل البريد الالكتروني',
//                   height: 60,
                  
//                   valid: (val) {
                  
//                     if (val!.length <= 10) {
//                       return 'please enter grater than 2 ';
//                     }
//                     if (val.length >= 100) {
//                       return 'please enter grater less 10 ';
//                     }
//                     return '  ';
//                   },
                  
//                     onSaved:(val){
//                   myemail=val;
//                 } ,
//                   onChang: (val) {
//                     LoginServices.myemail = val;
//                   },
//                 ),*/
//               ),
//               TextOFbutton(
//                 text: ' كلمة السر',
//                 height: 25,
//               ),
//               TextFormField(
//                 onSaved: (value) {
//                   mypassword = value;
//                 },
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value!.length <= 3) {
//                     return 'please enter grater than 3 ';
//                   }
//                   if (value.length >= 100) {
//                     return 'please enter grater less 10 ';
//                   }
//                   return null;
//                 },
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: ' **********',
//                   prefixIcon: const Icon(Icons.lock),
//                 ),
//               ),
//               /*TextFOrmField(
//                 typeOfKyepord: 'password',
//                 prefixicon: Icons.lock,
//                 label: '**********',
//                 suffixIcon: Icons.remove_red_eye,
//                 height: 60,
//                  valid: (val){
//                      if (val!.length <= 3) {
//                       return 'please enter grater than 3 ';
//                     }
//                     if (val.length >= 100) {
//                       return 'please enter grater less 10 ';
//                     }
//                     return ' ';
//                   },
                      
//                       onSaved: (val){
//                       myemail=val;
//                       },
//              /*   valid: (val) {
//                   if (val!.length <= 3) {
//                     return 'pleas enter grater then 3';
//                   }
//                   return " ";
//                 },
//                 onSaved:(val){
//                   mypassword=val;
//                 } ,*/
//                 onChang: (val) {
//                   LoginServices.mypassword = val;
//                 },
//               ),*/
//               Padding(
//                 padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
//                 child: MaterialButton(
//                   height: 60,
//                   // padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   textColor: Colors.white,
//                   color: const Color(0xffb1b1b3),
//                   onPressed: () async {
//                     UserCredential x = await verfi();
//                     // ignore: unnecessary_null_comparison
//                     if (x != null) {
//                       // ignore: use_build_context_synchronously
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (_) {
//                         return const UserInfio();
//                       }));
//                     } else {}
//                   },
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.person),
//                       SizedBox(
//                         width: 9,
//                       ),
//                       Text('تسجيل الدخول',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25,
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//               /*  MaterialButoonLogin(
//                 key: key,
//                 text_material: 'تسجيل الدخول',
//                 icon_material: Icons.person,
//                 Function_materialButoon: () {
//                   LoginServices.login(
//                       LoginServices.myemail!, LoginServices.mypassword!);
//                 },
//                 color: const Color(0xffb1b1b3),
//               ),*/
//               TitleText(
//                   string: 'هل نسيت كلمة السر  ?',
//                   color: Colors.green,
//                   ontap: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//                       return const resetPassword();
//                     }));
//                   } //Get.toNamed('/resetPassword'),
//                   ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TitleText(
//                       string: 'اذا لم يكن لديك حساب',
//                       color: Colors.grey.shade600),
//                   const SizedBox(width: 7),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (_) {
//                             return const SignUp();
//                           }));
//                         }, // Get.offNamed('/createAccount'),
//                         child: TitleText(
//                           string: 'اضغط هنا',
//                           color: Colors.green,
//                         ),
//                       ),
//                       const SizedBox(width: 7),
//                       TitleText(
//                           string: 'او الدخول بواسطة',
//                           color: Colors.grey.shade600),
//                     ],
//                   ),
//                 ],
//               ),
//               FaceGoogle(
//                 textFaceGoogle: 'جوجل',
//                 imageFaceGoogle: image.goggle_image,
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
