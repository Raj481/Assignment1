
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../controller/terms_condition_screen_controller.dart';
import '../../utils/constants.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TermsConditionScreenController controller
    = Get.put(TermsConditionScreenController());

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
            ),
            GetBuilder(
               init: controller,
               builder: (_){

                 if(controller.isLoading) {
                   return Expanded(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         CustomUi.loaderWidget(),
                       ],
                     ),
                   );
                 }

                 if(controller.responseData == null) {
                   return const SizedBox.shrink();
                 }

                 return  Flexible(
                   child: SingleChildScrollView(
                     child: Html(
                       data: prepareHtml(controller.responseData["content"]),
                     ),
                   ),
                 );
               }
           )
          ],
        ),
      )
    );
  }
}
