// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickerController extends GetxController {
//   final ImagePicker picker = ImagePicker();
//
//   Future<String> pickImage(ImageSource source) async {
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       return image.path;
//     } else {
//       return "";
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  final RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<String> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        imagePath.value = image.path;
        return image.path;
      }
      return '';
    } catch (e) {
      print("Error picking image: $e");
      return '';
    }
  }
}
