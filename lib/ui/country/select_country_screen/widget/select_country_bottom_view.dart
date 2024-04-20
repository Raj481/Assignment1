
import 'package:appassesment/controller/select_country_screen_controller.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/common/button_view.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCountryBottomView extends StatelessWidget {
  final SelectCountryScreenController controller;
  final Function() onProceedTap;
  const SelectCountryBottomView({
    super.key,
    required this.onProceedTap,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonView(
              onTap: onProceedTap,
              constraints: BoxConstraints(
                  minWidth: Get.width * .4,
                  minHeight: 50
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: Get.width * .1
              ),
              child: GetBuilder(
                init: controller,
                builder: (_) {
                  if(controller.isLoading){
                    return Center(
                      child: CustomUi.loaderWidget(),
                    );
                  }
                  return Center(
                    child: Text(
                      StringRes.proceed,
                      style: TextStyle(
                          color: ColorRes.textWhite,
                          fontSize: 16,
                          fontFamily: FontRes.regular
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 25,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringRes.cantSeeTheCountryOfYourInterest,
              maxLines: 2,
              style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 14,
                  fontFamily: FontRes.xsLight
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringRes.consultWithUs,
              maxLines: 1,
              style: TextStyle(
                  color: ColorRes.textDarkBrown,
                  fontSize: 18,
                  fontFamily: FontRes.smMedium
              ),
            ),
          ],
        ),

        const SizedBox(height: 25,),
      ],
    );
  }
}
