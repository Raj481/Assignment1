
import 'package:appassesment/controller/phone_number_screen_controller.dart';
import 'package:appassesment/ui/phone_number/widget/phone_number_textview.dart';
import 'package:appassesment/ui/phone_number/widget/phone_number_top_bar.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/common/button_view.dart';
import 'package:appassesment/widget/common/divider_gradient_view.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {

    PhoneNumberScreenController controller = Get.put(PhoneNumberScreenController());

    return Scaffold(
      backgroundColor: ColorRes.bgDarkGrey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PhoneNumberTopBar(
              onBackTap: () => controller.onBackTap(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 25
              ),
              child: DividerGradientView(),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * .03,
                  horizontal: Get.width * .1
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder(
                      init: controller,
                      builder: (_){
                        return  PhoneNumberTextView(
                          model: controller.countryModel,
                          controller: controller.phoneTextController,
                          decoration: const BoxDecoration(),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15
                          ),
                          onTextChanged: (value){
                            controller.setError("");
                          },
                          enabled: controller.isLoading ? false : true,
                        );
                      }),
                  DividerGradientView(
                    gradient: LinearGradient(
                      colors: [
                        ColorRes.textLightGrey.withOpacity(.5)
                      ],
                      stops: const [.5],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),

                  GetBuilder(
                      init: controller,
                      builder: (_){

                        if(controller.errorText.trim().isEmpty){
                          return const SizedBox.shrink();
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 25,),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * .1
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomUi.errorWidget(errorText: controller.errorText)
                                ],
                              ),
                            )
                          ],
                        );
                      }
                  )

                ],
              ),
            ),

            SizedBox(height: Get.height * .3,),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonView(
                  onTap: () => controller.onGetOtpTap(),
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
                          StringRes.getOtp,
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
            const SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
