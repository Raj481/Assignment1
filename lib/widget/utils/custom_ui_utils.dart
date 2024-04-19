
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUiUtils {
  CustomUiUtils._();
  static CustomUiUtils get instance {
    return CustomUiUtils._();
  }

  static void showSnackbar(String message, {bool isSuccess = true}){
    Get.showSnackbar(
        GetSnackBar(
          backgroundColor: ColorRes.white,
          messageText: Text(
            message,
            style: TextStyle(
                color: ColorRes.black,
                fontFamily: FontRes.regular,
                fontSize: 18
            ),
          ),
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15
          ),
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(seconds: 2),
        )
    );
  }

  static Widget loaderWidget() {
    return Center(
      child: CircularProgressIndicator(color: ColorRes.textDarkBrown),
    );
  }
  static Widget errorWidget({required String errorText}) {
    return Flexible(
      child: Text(
          errorText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: FontRes.regular,
          color: ColorRes.textError,
          fontSize: 14
        ),
      ),
    );
  }

}