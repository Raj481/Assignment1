

import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpTopBarView extends StatelessWidget {
  final Function() onBackTap;
  const OtpTopBarView({
    super.key,
    required this.onBackTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 18,
                  top: Get.statusBarHeight
              ),
              child: GestureDetector(
                onTap: () => onBackTap(),
                child: Image(
                  image: AssetImage(
                      ImageRes.icBack
                  ),
                  height: 45,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringRes.verifyNumber,
              style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 24,
                  fontFamily: FontRes.regular
              ),
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                StringRes.msgPleaseEnterTheOtpReceived,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorRes.textDarkBrown,
                    fontSize: 13,
                    fontFamily: FontRes.regular
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
