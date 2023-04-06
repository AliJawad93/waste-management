import 'package:app/helper/picker_image_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AddingPostController extends GetxController {
  String? _type;
  String? _text;
  String? _urlIMage;
  PlatformFile? _pickerImage;

  void setType(String type) {
    this._type = type;
    update();
  }

  void setText(String text) {
    this._text = text;
    update();
  }

  void setUrlIMage(urlIMage) {
    this._urlIMage = urlIMage;
    update();
  }

  Future<void> selectImage() async {
    _pickerImage = await PickerImageHelper.selectImage();
    update();
  }

  String? get getType => _type;

  String? get getText => _text;

  String? get getUrlIMage => _urlIMage;

  PlatformFile? get getPlatformFile => _pickerImage;
}
