import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/text_style.dart';
import '../../utils/assets_res.dart';
import '../../utils/color_res.dart';
import '../../utils/string_res.dart';
import 'controller/AnimationController.dart';
import 'controller/splashController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());
    final AnimationControllerGetx animationController =
        Get.put(AnimationControllerGetx());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(assetsRes.appLogo,
                height: Get.height * 0.24, width: Get.width * 0.8),
            // child: Container(
            //   height: Get.height * 0.24,
            //   width: Get.width * 0.8,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage(assetsRes.appLogo), fit: BoxFit.cover)),
            // ),
          ),
          const SizedBox(
            height: 30,
          ),
          GetBuilder<AnimationControllerGetx>(
            builder: (controller) {
              return ScaleTransition(
                scale: controller.animation,
                child: Text(
                  stringRes.appName,
                  style: josefinSansBold(
                    fontSize: 30,
                    color: colorRes.blue,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
