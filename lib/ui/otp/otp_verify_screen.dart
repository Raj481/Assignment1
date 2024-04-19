
import 'package:appassesment/controller/otp_verify_controller.dart';
import 'package:appassesment/ui/otp/widget/otp_top_bar_view.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/common/button_view.dart';
import 'package:appassesment/widget/common/divider_gradient_view.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    OtpVerifyController controller = Get.put(OtpVerifyController());

    return Scaffold(
      backgroundColor: ColorRes.bgDarkGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            OtpTopBarView(
              onBackTap: () => controller.onBackTap(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 25
              ),
              child: DividerGradientView(),
            ),
            // SizedBox(height: Get.height * .05,),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .1
                  ),
                  child: GetBuilder(
                    init: controller,
                    builder: ( _) {
                      return OTPTextField(
                        controller: controller.otpFieldController,
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 40,
                        fieldStyle: FieldStyle.underline,
                        outlineBorderRadius: 15,
                        otpFieldStyle: OtpFieldStyle(
                          borderColor: ColorRes.white,
                          enabledBorderColor: ColorRes.textLightGrey,
                          focusBorderColor: ColorRes.white,
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorRes.white,
                            fontFamily: FontRes.smMedium
                        ),
                        onChanged: (value){
                          controller.setOtp(value);
                        },
                        onCompleted: (value){},
                      );
                    },
                  ),
                ),
                GetBuilder(
                    init: controller,
                    builder: (_){

                      if(controller.errorText.trim().isEmpty){
                        return const SizedBox(height: 25,);
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomUiUtils.errorWidget(
                                  errorText: controller.errorText
                              )
                            ],
                          )
                        ],
                      );
                    }
                ),
                SizedBox(height: Get.height * .1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringRes.didNotReceiveOTP,
                      style: TextStyle(
                          color: ColorRes.textLightGrey,
                          fontSize: 14,
                          fontFamily: FontRes.regular
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    GetBuilder(
                        init: controller,
                        builder: (_){
                          if((controller.timer != null) && controller.timer!.isActive) {
                            return RichText(
                              text: TextSpan(
                                  text:  StringRes.resendingOTP,
                                  style: TextStyle(
                                      color: ColorRes.textLightGrey,
                                      fontSize: 14,
                                      fontFamily: FontRes.regular
                                  ),
                                  children: [
                                    TextSpan(
                                      text:  "${controller.remainingSeconds} seconds",
                                      style: TextStyle(
                                          color: ColorRes.textDarkBrown,
                                          fontSize: 14,
                                          fontFamily: FontRes.regular
                                      ),
                                    )
                                  ]
                              ),
                            );
                          }

                            return GestureDetector(
                              onTap: () => controller.onResendTap(),
                              child: Text(
                                StringRes.resendOTP,
                                style: TextStyle(
                                    color: ColorRes.textDarkBrown,
                                    fontSize: 16,
                                    fontFamily: FontRes.regular
                                ),
                              ),
                            );
                        }
                    ),



                  ],
                )
              ],
            ),

            SizedBox(height: Get.height * .2,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonView(
                  onTap: () => controller.onVerifyTap(),
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
                          child: CustomUiUtils.loaderWidget(),
                        );
                      }
                      return Center(
                        child: Text(
                          StringRes.verify,
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
