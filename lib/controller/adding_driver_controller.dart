import 'package:app/data/firebase_map.dart';
import 'package:app/view/ui/admin/ui/add_driver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';

import '../data/firebase_driver.dart';
import '../helper/picker_image_helper.dart';
import '../model/driver_model.dart';
import '../view/ui/app/main_page.dart';

class AddingDriverController extends GetxController {
  PlatformFile? _pickerImage;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _numberTruck = TextEditingController();
  final TextEditingController _workDays = TextEditingController();
  final TextEditingController _workStreet = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _emailAdmin = TextEditingController();
  final TextEditingController _passwordAdmin = TextEditingController();

  Future<void> selectImage() async {
    _pickerImage = await PickerImageHelper.selectImage();
    update();
  }

  bool isFormDriverEmptyAndImageNull() {
    if (_name.text.isEmpty ||
        _email.text.isEmpty ||
        _numberTruck.text.isEmpty ||
        _workDays.text.isEmpty ||
        _workStreet.text.isEmpty ||
        _password.text.isEmpty ||
        _birthday.text.isEmpty ||
        _emailAdmin.text.isEmpty ||
        _passwordAdmin.text.isEmpty ||
        _pickerImage == null) return true;

    return false;
  }

  Future<void> addDriver() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);

      String? urlImage =
          await FirebaseDriver.uploadWithGetURL(getPlatformFile!);
      String idDriver = auth.currentUser!.uid;
      DriverModel driverModel = DriverModel(
        id: idDriver,
        name: _name.text,
        workDays: _workDays.text,
        workStreet: _workStreet.text,
        numberTruck: int.parse(_numberTruck.text),
        urlImage: urlImage ?? "null",
        email: FirebaseAuth.instance.currentUser!.email!,
        birthday: _birthday.text,
        status: "",
        userRole: "driver",
        creationTime: FirebaseAuth.instance.currentUser!.metadata.creationTime!
            .toIso8601String(),
        lastSignInTime: FirebaseAuth
            .instance.currentUser!.metadata.lastSignInTime!
            .toIso8601String(),
        updatedTime: DateTime.now().toIso8601String(),
      );

      await FirebaseDriver.addDriver(driverModel);
      await FirebaseMap.addDriverLocation(driverModel.id);
      await auth.signOut();
      await auth.signInWithEmailAndPassword(
          email: _emailAdmin.text, password: _passwordAdmin.text);
      Get.back();
    } catch (e) {
      print(e.toString());
      Get.snackbar("Erorr", e.toString());
    }
  }

  TextEditingController get getNameController => _name;
  TextEditingController get getEmailController => _email;
  TextEditingController get getEmailAdminController => _emailAdmin;
  TextEditingController get getNumberTruckController => _numberTruck;
  TextEditingController get getWorkDaysController => _workDays;
  TextEditingController get getWorkStreetController => _workStreet;
  TextEditingController get getPassword => _password;
  TextEditingController get getPasswordAdmin => _passwordAdmin;
  TextEditingController get getBirthday => _birthday;
  PlatformFile? get getPlatformFile => _pickerImage;
}
