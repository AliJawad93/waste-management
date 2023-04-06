import 'package:app/controller/adding_driver_controller.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_driver.dart';
import 'package:app/model/driver_model.dart';
import 'package:app/view/ui/admin/widgets/custom_form_driver.dart';
import 'package:app/view/ui/app/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';
import '../../../widgets/custom_scafold.dart';
import '../widgets/custom_add_image_person.dart';

class AddDriver extends StatefulWidget {
  AddDriver({Key? key}) : super(key: key);

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  bool isLoading = false;
  final AddingDriverController _controller = Get.put(AddingDriverController());
  bool isEnable = false;
  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.isFormDriverEmptyAndImageNull()) return;
      setState(() {
        isEnable = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(title: Text(AppString.addDriver.tr)),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomAddingImagePerson(),
                  const CusotmFormDriverr(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: Get.height * 0.08,
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: !isEnable
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });

                                await _controller.addDriver();

                                setState(() {
                                  isLoading = false;
                                });
                              },
                        child: Text(AppString.add.tr),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
