
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/common/button_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonView(
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
          ),
        ],
      ),
    );
  }
}
