import 'package:file_picker/file_picker.dart';

class PickerImageHelper {
  static Future<PlatformFile?> selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;

    return result.files.first;
  }
}
