import 'package:app/data/firebase_map.dart';
import 'package:app/data/firebase_users.dart';
import 'package:app/model/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  Position? _position;
  final FirebaseUsers _firebaseUsers = FirebaseUsers();
  Location location = Location();
  Future<void> getCurrentPositionWithSendData() async {
    try {
      // await _requestPermission();
      // _position = await Geolocator.getLastKnownPosition().whenComplete(() {});
      LocationData locationData = await location.getLocation();

      await FirebaseMap.updateLocation(locationData.latitude!,
          locationData.longitude!, locationData.heading!);
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> getCurrentPositionWithSendData() async {
  //   try {
  //     await _requestPermission();
  //     _position = await Geolocator.getLastKnownPosition().whenComplete(() {});
  //     await FirebaseMap.addLocation(
  //         _position!.latitude, _position!.longitude, _position!.heading);
  //     //update();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<Position?> getCurrentPostion() async {
    try {
      await _requestPermission();
      _position = await Geolocator.getLastKnownPosition();
    } catch (e) {
      print(e.toString());
    }
    return _position;
  }

  Position? getPostion() => _position;

  // pravite functions

  Future<Position> _requestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }
}
