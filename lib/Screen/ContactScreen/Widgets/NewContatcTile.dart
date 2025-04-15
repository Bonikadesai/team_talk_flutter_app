import 'package:flutter/material.dart';

import '../../../common/text_style.dart';
import '../../../utils/color_res.dart';

class NewContactTile extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final VoidCallback ontap;
  const NewContactTile(
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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              child: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: colorRes.blue,
              ),
            ),
            SizedBox(width: 20),
            Text(
              btnName,
              style: rubikRegular(
                fontSize: 16,
                color: colorRes.blue,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
