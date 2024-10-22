
import 'package:appassesment/controller/home_screen_controller.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/common/button_view.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    HomeScreenController controller = Get.put(HomeScreenController());

    return Scaffold(
      backgroundColor: ColorRes.bgDarkGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringRes.welcome,
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 24,
                  fontFamily: FontRes.regular
                ),
              ),
            ],
          ),
          const SizedBox(height: 25,),
          GetBuilder(
              init: controller,
              builder: (_){

                if(controller.isLoading){
                  return CustomUi.loaderWidget();
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonView(
                          onTap: controller.onLogoutTap,
                          constraints: BoxConstraints(
                              minWidth: Get.width * .25,
                              minHeight: 50
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: Get.width * .1
                          ),
                          child: Center(
                            child: Text(
                              StringRes.logout,
                              style: TextStyle(
                                  color: ColorRes.textWhite,
                                  fontSize: 16,
                                  fontFamily: FontRes.regular
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonView(
                          onTap: controller.onDeleteUserTap,
                          constraints: BoxConstraints(
                              minWidth: Get.width * .25,
                              minHeight: 50
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: Get.width * .1
                          ),
                          child: Center(
                            child: Text(
                              StringRes.deleteUser,
                              style: TextStyle(
                                  color: ColorRes.textWhite,
                                  fontSize: 16,
                                  fontFamily: FontRes.regular
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
          ),
        ],
      ),
    );
  }
}
