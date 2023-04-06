import 'package:app/core/constants/App_colors.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentAddingNewMark extends StatefulWidget {
  const ContentAddingNewMark({Key? key}) : super(key: key);

  @override
  State<ContentAddingNewMark> createState() => _ContentAddingNewMarkState();
}

class _ContentAddingNewMarkState extends State<ContentAddingNewMark> {
  TextEditingController idBin = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(
                Icons.expand_more,
                size: 30,
                color: AppColors.outLineTextFormFeld,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: idBin,
            decoration: const InputDecoration(
                hintText: "Id Bin", prefixIcon: Icon(Icons.key)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: latitude,
            decoration: const InputDecoration(
                hintText: "latitude", prefixIcon: Icon(Icons.language)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: longitude,
            decoration: const InputDecoration(
                hintText: "longitude", prefixIcon: Icon(Icons.language)),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Learn to get your latitude and longitude ?",
            style: TextStyle(color: AppColors.primary, fontSize: 12),
          ),
        ),
        Container(
            height: Get.height * 0.08,
            margin: const EdgeInsets.all(10.0),
            width: Get.width,
            child: ElevatedButton(
                onPressed: () {
                  if (idBin.text.isEmpty ||
                      latitude.text.isEmpty ||
                      longitude.text.isEmpty) return;

                  print(
                      "${idBin.text.isEmpty} ++ ${latitude.text.isEmpty} ++ ${longitude.text.isEmpty}");
                  double lat = double.parse(latitude.text);
                  double long = double.parse(longitude.text);

                  if ((lat >= -90 && lat <= 90) &&
                      (long >= -180 && lat <= 180)) {
                    //  FirebaseMap.addLocation(lat, long, "user", idBin.text);
                    Get.snackbar(AppString.succeeded, AppString.massageIsAdded,
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.background);
                  } else {
                    Get.snackbar(AppString.error, AppString.massageErrorAddBin);
                  }
                  setState(() {
                    idBin.clear();
                    latitude.clear();
                    longitude.clear();
                  });
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 17),
                ))),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}
