import 'dart:async';
import 'package:app/core/constants/app_image_path.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconMapHelper {
  static BitmapDescriptor getIcon(
      List<Uint8List> icons, bool isTruck, int level) {
    if (!isTruck) {
      if (level <= 25) {
        return BitmapDescriptor.fromBytes(icons[0]); // 0 : Green Bin
      } else if (level <= 75) {
        return BitmapDescriptor.fromBytes(icons[1]); // 1 : Orange Bin
      } else {
        return BitmapDescriptor.fromBytes(icons[2]); // 2 : Red Bin
      }
    }
    return BitmapDescriptor.fromBytes(icons[3]); // 3 : truck
  }

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<List<Uint8List>> getIconsMarker() async {
    List<Uint8List> icons = [];
    icons.add(await _getBytesFromAsset(AppImagePath.greenBin, 100));
    icons.add(await _getBytesFromAsset(AppImagePath.ornageBin, 100));
    icons.add(await _getBytesFromAsset(AppImagePath.redBin, 100));
    icons.add(await _getBytesFromAsset(AppImagePath.truck, 100));
    return icons;
  }
}
