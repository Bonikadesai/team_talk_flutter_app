import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Screen/ProfileScreen/controller/ImagePicker.dart';
import '../utils/color_res.dart';
import 'text_style.dart';

Future<dynamic> ImagePickerBottomSheet(BuildContext context, RxString imagePath,
    ImagePickerController imagePickerController) {
  return Get.bottomSheet(
    Container(
      height: 200, // Adjust as per design
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        // Center vertically + horizontally
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                imagePath.value =
                    await imagePickerController.pickImage(ImageSource.camera);
                Get.back();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: colorRes.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Camera", style: rubikRegular(color: colorRes.blue)),
                ],
              ),
            ),
            SizedBox(width: 50),
            InkWell(
              onTap: () async {
                imagePath.value =
                    await imagePickerController.pickImage(ImageSource.gallery);
                Get.back();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: colorRes.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Gallery", style: rubikRegular(color: colorRes.blue)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
