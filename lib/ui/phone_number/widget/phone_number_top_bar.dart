

import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberTopBar extends StatelessWidget {
  final Function() onBackTap;
  const PhoneNumberTopBar({
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
              padding: const EdgeInsets.only(
                  left: 18,
                  top: 55, //Get.statusBarHeight
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
              StringRes.enterPhoneNumber,
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
                StringRes.msgPleasePleaseEnter10DigitMobileNumber,
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
