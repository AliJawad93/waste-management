import 'dart:async';
import 'dart:math';

import 'package:app/controller/google_map_controller.dart';
import 'package:app/controller/main_page_controller.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_map.dart';
import 'package:app/main.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/App_colors.dart';
import '../../widgets/content_adding_new_mark.dart';
import '../../widgets/custom_scafold.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = Get.put(MapController());
  final Completer<GoogleMapController> _controller = Completer();

  setNewMarkPin() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        context: context,
        builder: (context) {
          return ContentAddingNewMark();
        });
  }

  @override
  void initState() {
    if (prefs.getString(KeysSharePref.userRole) == "driver") {
      Timer.periodic(const Duration(seconds: 20), (timer) {
        print("X" * 30);
        _mapController.getCurrentPositionWithSendData();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<Set<Marker>>(
                stream: FirebaseMap.getMarkersMap(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(33.372020, 44.456620),
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: snapshot.data!,
                  );
                }),
            CustomPaint(
              size: Size(Get.width, (Get.height * 0.19).toDouble()),
              painter: RPSCustomPainter(),
              child: Container(
                  height: Get.height * 0.17,
                  width: Get.width,
                  padding:
                      EdgeInsets.symmetric(vertical: sqrt(Get.height) * 0.5),
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppString.map.tr,
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8471667, size.height * 0.4920798);
    path_0.cubicTo(
        size.width * 0.6671852,
        size.height * 0.4920798,
        size.width * 0.1605370,
        size.height * 0.4852672,
        size.width * 0.1605370,
        size.height * 0.4852672);
    path_0.cubicTo(size.width * 0.06257407, size.height * 0.4854057, 0,
        size.height * 0.2752146, 0, size.height * -0.0007477153);
    path_0.lineTo(size.width, size.height * -0.0007477153);
    path_0.lineTo(size.width, size.height * 0.9992523);
    path_0.cubicTo(
        size.width,
        size.height * 0.5763777,
        size.width * 0.9001019,
        size.height * 0.4920798,
        size.width * 0.8471667,
        size.height * 0.4920798);
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
