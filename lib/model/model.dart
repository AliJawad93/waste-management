import 'package:app/model/driver_model.dart';
import 'package:app/model/user_model.dart';

class Model {
  UserModel? userModel;
  DriverModel? driverModel;

  Model(model) {
    if (model["user_role"] == "user" || model["user_role"] == "admin") {
      userModel = UserModel.fromMap(model);
    } else {
      driverModel = DriverModel.fromMap(model);
    }
  }
}
