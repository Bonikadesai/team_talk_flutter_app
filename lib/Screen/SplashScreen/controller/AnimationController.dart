import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationControllerGetx extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation back and forth

    animation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void onClose() {
    controller.dispose(); // Dispose the controller when not in use
    super.onClose();
  }
}
