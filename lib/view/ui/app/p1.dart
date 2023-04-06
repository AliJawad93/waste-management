import 'dart:math';

import 'package:app/core/constants/App_colors.dart';
import 'package:app/services/google_Services.dart';
import 'package:app/view/ui/user/ui/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "no name";
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () async {
                      _googleSignIn.signIn().then(
                        (value) {
                          name = value!.email;
                        },
                      );

                      setState(() {});
                    },
                    icon: Icon(Icons.open_with_rounded))
              ],
            ),
            body: Center(
              child: Text(name),
            )));
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8170000, size.height * 0.4993104);
    path_0.lineTo(size.width * 0.1775648, size.height * 0.4988159);
    path_0.cubicTo(size.width * 0.07962963, size.height * 0.4989461, 0,
        size.height * 0.2752492, 0, size.height * -0.0007026310);
    path_0.lineTo(size.width, size.height * -0.0007026310);
    path_0.lineTo(size.width, size.height * 0.9992974);
    path_0.cubicTo(
        size.width,
        size.height * 0.5764436,
        size.width * 0.8804630,
        size.height * 0.4993104,
        size.width * 0.8170000,
        size.height * 0.4993104);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = AppColors.primary;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
