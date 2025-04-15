import 'package:flutter/material.dart';
import 'package:team_talk_flutter_app/common/text_style.dart';

import '../utils/color_res.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final VoidCallback ontap;
  const PrimaryButton(
      {super.key,
      required this.btnName,
      required this.icon,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorRes.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              btnName,
              style: rubikRegular(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
