import 'dart:async';
import 'package:app/core/constants/app_image_path.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/services/signup_services.dart';
import 'package:app/view/ui/app/auth/login.dart';
import 'package:app/view/ui/app/auth/verify.dart';
import 'package:app/view/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/google_Services.dart';
import '../../../widgets/custom_elevated_button.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController email = TextEditingController();
  late TextEditingController password = TextEditingController();
  late TextEditingController confirmPassword = TextEditingController();
  late TextEditingController phoneNumber = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color iconColor = Color.fromARGB(255, 36, 204, 131);
  Color textFieldColor = Color.fromARGB(255, 247, 246, 246);
  bool isVisible = false;
  // pattern for email
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  FirebaseAuth auth = FirebaseAuth.instance;

  String? emailValid(String? value) {
    RegExp regex = RegExp(pattern.toString());
    if (value!.trim().isEmpty) {
      return AppString.pleaseEnterYourEmail.tr;
    } else if (!regex.hasMatch(value)) {
      return AppString.emailIsNotValid.tr;
    }
    return null;
  }

  String? passwordValid(String? value) {
    if (value!.trim().isEmpty) {
      return AppString.pleaseEnterYourPassword.tr;
    } else if (value.trim().length < 7) {
      return AppString.passwordLengthMustBeGreater.tr;
    }
    return null;
  }

  String? confirmPasswordValid(String? value) {
    if (value!.trim().isEmpty) {
      return AppString.pleaseEnterYourConfirmPassword.tr;
    } else if (value != password.text) {
      return AppString.passwordConfirmationDoesNotMatch.tr;
    }
    return null;
  }

  String? phoneNumberValid(String? value) {
    if (value!.length <= 10) {
      return AppString.pleaseEnterCorrectNumber.tr;
    }
    if (value.length >= 12) {
      return AppString.pleaseEnterLess11.tr;
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 100,
                            child: Text(
                              AppString.singUp.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
                        textField(
                            AppString.phoneNumber.tr,
                            Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            width,
                            height,
                            phoneNumber,
                            phoneNumberValid),
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
                        textField(
                            AppString.confirmPassword.tr,
                            Icon(
                              Icons.lock_outlined,
                              color: Colors.grey,
                            ),
                            width,
                            height,
                            confirmPassword,
                            confirmPasswordValid),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() != false) {
                                setState(() {
                                  isLoading = true;
                                });
                                await SignupServices.signUp(
                                    email.text, password.text);

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            title: AppString.singUp.tr),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppString.or.tr,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              button("Google  ", AppImagePath.google, height),
                              Center(
                                child: GestureDetector(
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            )),
          );
  }

  Widget textField(String hint, Icon icon, double width, double height,
      TextEditingController myController, validFunction) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
      ),
      child: TextFormField(
        obscureText:
            hint == AppString.email.tr || hint == AppString.phoneNumber.tr
                ? false
                : isVisible
                    ? false
                    : true,
        controller: myController,
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
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon:
              hint != AppString.email.tr && hint != AppString.phoneNumber.tr
                  ? IconButton(
                      icon: isVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    )
                  : null,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onEditingComplete: () {},
      ),
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
        //  LoginWithGoogle.signInWithGoogle();
      },
    );
  }
}

// import 'package:app/core/constant/imageAsset.dart';
// import 'package:app/scrrens/auth/verify.dart';
// import 'package:app/widget/auth/createAccount/appbar_create.dart';
// import 'package:app/widget/auth/face_goole.dart';
// import 'package:app/widget/auth/textOFbutton.dart';
// import 'package:app/widget/auth/text_underButton.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../verviy1.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }


// class _SignUpState extends State<SignUp> {
//   GlobalKey<FormState> key = GlobalKey<FormState>();
//   late String mypassword, myemail, myuser;
//   verfi() async {
//     var v =  key.currentState!;
//     if (v.validate()) v.save();
//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: myemail,
//         password: mypassword,
//       );
//       return credential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         AwesomeDialog(
//                 context: context,
//                 body: const Text('The password provided is too weak'))
//             .show();
//       } else if (e.code == 'email-already-in-use') {
//         AwesomeDialog(
//           autoHide: const Duration(seconds: 3),
//           context: context,
//           body: const Text('The account already exists for that email.'),
//         ).show();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: appbarCreate(context),
//       body: SafeArea(
//         child: Form(
//           key: key,
//           child: ListView(
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               //  const ImageCreate(),
//               TextOFbutton(
//                 text: 'البريد الاكتروني',
//                 height: 20,
//               ),
//               TextFormField(
//                 onSaved: (value) {
//                   myemail = value!;
//                 },
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value!.length <= 2) {
//                     return 'please enter grater than 10 ';
//                   }
//                   if (value.length >= 100) {
//                     return 'please enter  less than 50 ';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'ادخل البريد الالكتروني',
//                   label: const Text(
//                     'ادخل البريد الالكتروني',
//                   ),
//                   prefixIcon: const Icon(Icons.mail,color: Colors.green,),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(100)),
//                 ),
//               ),
//               /* TextFOrmField(
//                 prefixicon: Icons.mail,
//                 label: 'ادخل البريد الالكتروني',
//                 height: 60,
//                 valid: (value) {
//                   if (value!.isEmpty || value.length < 5) {
//                     return 'عفوا ادخل بريد صحيح ';
//                   }
//                   return ' ';
//                 },
//                 onChang: (value) {
//                   SignupServices.myemail = value!;
//                 },
//                 typeOfKyepord: 'email',
//               ),*/
//               TextOFbutton(
//                 text: ' كلمة السر',
//                 height: 20,
//               ),
//                TextFormField(
//                       onSaved: (value) {
//                         mypassword = value!;
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: (value) {
//                         if (value!.length <= 3) {
//                           return 'please enter grater than 3 ';
//                         }
//                         if (value.length >= 100) {
//                           return 'please enter grater less 10 ';
//                         }
//                         return null;
//                       },
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: ' **********',
                        
//                         prefixIcon: const Icon(Icons.lock,color: Colors.green,),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//             /*  TextFOrmField(
//                 valid: (value) {
//                   if (value!.length < 6) {
//                     return ' عفوا ادخل اكثر من 3 قيم';
//                   }

//                   return value;
//                 },
//                 onChang: (value) {
//                   SignupServices.mypassword = value!;
//                 },
//                 prefixicon: Icons.lock,
//                 label: '**********',
//                 suffixIcon: Icons.remove_red_eye,
//                 height: 60,
//                 typeOfKyepord: 'password',
//               ),*/
//               TextOFbutton(
//                 text: 'تأكيد كلمة السر',
//                 height: 20,
//               ),
//                TextFormField(
//                       onSaved: (value) {
//                         mypassword = value!;
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: (value) {
//                         if (value!.length <= 3) {
//                           return 'please enter grater than 3 ';
//                         }
//                         if (value.length >= 100) {
//                           return 'please enter grater less 10 ';
//                         }
//                         return null;
//                       },
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: ' **********',
                        
//                         prefixIcon: const Icon(Icons.lock,color: Colors.green,),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
                 
//             /*  TextFOrmField(
//                 valid: (value) {
//                   if (SignupServices.mypassword != value) {
//                     return 'كلمة السر غير مطابقة';
//                   }
//                   return ' ';
//                 },
//                 onChang: (value) {
//                   SignupServices.mypassword = value!;
//                 },
//                 prefixicon: Icons.lock,
//                 label: '**********',
//                 suffixIcon: Icons.remove_red_eye,
//                 height: 60,
//                 typeOfKyepord: 'password',
//                 //  controller: Controller.mypassword,
//               ),*/
//               TextOFbutton(
//                 text: 'رقم المبايل',
//                 height: 20,
//               ),
//                TextFormField(
//                       onSaved: (value) {
//                         mypassword = value!;
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: (value) {
//                         if (value!.length <= 10) {
//                           return 'please enter correct number   ';
//                         }
//                         if (value.length >= 12) {
//                           return 'please enter  less 11 number ';
//                         }
//                         return null;
//                       },
//                       keyboardType:TextInputType.phone,
//                       decoration: InputDecoration(
//                         hintText: 'ادخال رقم المبايل',
//                         prefixIcon: const Icon(Icons.mobile_off,color: Colors.green,),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//              /* TextFOrmField(
//                 valid: (value) {
//                   if (value!.length < 6) {
//                     return 'عفوا الرقم خطا';
//                   }
//                   return '  ';
//                 },
//                 onChang: (value) {
//                   SignupServices.mymopile = value!;
//                 },
//                 prefixicon: Icons.mobile_friendly_outlined,
//                 label: 'ادخال رقم المبايل',
//                 height: 60,
//                 typeOfKyepord: 'mopile',
//                 //   controller: Controller.mymopile,
//               ),*/
//                  const SizedBox(height: 20),
//               MaterialButton(
//                  height: 60,
//                  // padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
//                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                  textColor: Colors.white,
//                  color:const Color(0xffb1b1b3),
//                  onPressed: () async {
//                                UserCredential x = await verfi();
//                                // ignore: unnecessary_null_comparison
//                                if (x != null) {
                                
//                                  // ignore: use_build_context_synchronously
//                                  Navigator.of(context)
//                                      .push(MaterialPageRoute(builder: (_) {
//                                    return const  verifiy1();
//                                  }));
//                                } else {
//                                }
//                              },
//                  padding: const EdgeInsets.symmetric(vertical: 10),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children:const [
//                      Icon(Icons.person_add,color: Colors.green,),
//                       SizedBox(
//                        width: 9,
//                      ),
//                      Text('تسجيل الدخول',
//                          style:  TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 25,
//                          )),
//                    ],
//                  ),
//                ),
//              /* MaterialButoonLogin(
//                 text_material: 'انشاء حساب',
//                 icon_material: Icons.person_add,
//                 Function_materialButoon: () async {
//                   SignupServices.createAcoount(
//                     SignupServices.myemail,
//                     SignupServices.mypassword,
//                   );
//                 },
//                 color: const Color(0xffb1b1b3),
//               ),*/
//               TitleText(
//                 string: '----     او التسجيل بواسطة   ----',
//                 color: Colors.black54,
//               ),
//               FaceGoogle(
//                 textFaceGoogle: 'جوجل',
//                 imageFaceGoogle: image.goggle_image,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
