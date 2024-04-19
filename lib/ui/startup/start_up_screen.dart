

import 'package:appassesment/controller/start_up_screen_controller.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    StartUpScreenController controller = Get.put(StartUpScreenController());

    return Scaffold(
      backgroundColor: ColorRes.bgDarkGrey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageRes.bgOption1
              ),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: Get.height * .38
              ),
              decoration: BoxDecoration(
                color: ColorRes.bgStartupColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringRes.welcomeToStudyLancer,
                        style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 26,
                          fontFamily: FontRes.smBold
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringRes.pleaseSelectYourRole,
                        style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 14,
                          fontFamily: FontRes.regular
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              controller.onStudentTap();
                            },
                            child: Image(
                                image: AssetImage(
                                  ImageRes.imgStudent
                                ),
                              height: 150,
                            ),
                          ),
                          Text(
                            StringRes.student,
                            style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 16,
                                fontFamily: FontRes.smBold
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              controller.onAgentTap();
                            },
                            child: Image(
                              image: AssetImage(
                                  ImageRes.imgAgent
                              ),
                              height: 150,
                            ),
                          ),
                          Text(
                            StringRes.agent,
                            style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 16,
                                fontFamily: FontRes.smBold
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                            text: StringRes.byContinuingYouAgree,
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 12,
                              fontFamily: FontRes.xsLight
                            ),
                            children: [
                              TextSpan(
                                text: StringRes.termsAndConditions,
                                style: TextStyle(
                                    color: ColorRes.textDarkBrown,
                                    fontSize: 12,
                                    fontFamily: FontRes.smBold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    controller.onTermsConditionTap();
                                  }
                              )
                            ]
                          )
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
