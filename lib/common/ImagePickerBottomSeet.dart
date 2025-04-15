import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Screen/ProfileScreen/controller/ImagePicker.dart';
import '../utils/color_res.dart';
import 'text_style.dart';

Future<dynamic> ImagePickerBottomSheet(BuildContext context, RxString imagePath,
    ImagePickerController imagePickerController) {
  return Get.bottomSheet(Container(
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              imagePath.value =
                  await imagePickerController.pickImage(ImageSource.camera);
              Get.back();
            },
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: colorRes.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.camera,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text("Camera", style: rubikRegular(color: colorRes.blue)),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              imagePath.value =
                  await imagePickerController.pickImage(ImageSource.gallery);
              Get.back();
            },
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: colorRes.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.photo,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text("Gallery", style: rubikRegular(color: colorRes.blue)),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //     height: 70,
          //     width: 70,
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).colorScheme.background,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: Icon(
          //       Icons.play_arrow,
          //       size: 30,
          //     ),
          //   ),
          // )
        ],
      ),
    ),
  ));
}
