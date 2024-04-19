
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.bgDarkGrey,
      body: Container(
        padding: EdgeInsets.only(
          top: Get.statusBarHeight
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage(
                        ImageRes.imgTerms
                    ),
                  height: 60,
                ),
                const SizedBox(width: 10,),
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          StringRes.termsOfService,
                          style: TextStyle(
                              color: ColorRes.textDarkBrown,
                              fontSize: 21,
                              fontFamily: FontRes.smMedium
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Update 16/03/2023",
                          style: TextStyle(
                              color: ColorRes.textLightGrey,
                              fontSize: 14,
                              fontFamily: FontRes.regular
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
