import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/common/text_style.dart';

import '../utils/color_res.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({super.key, required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.075,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorRes.blue,
        ),
        child: Center(
          child: Text(
            label,
            style: rubikMedium(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
