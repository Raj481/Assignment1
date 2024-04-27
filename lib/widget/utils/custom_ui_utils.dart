
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/constants.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUi {
  CustomUi._();
  static CustomUi get instance {
    return CustomUi._();
  }

  static void showSnackbar(
      String message,
      { ToastEnum type = ToastEnum.warning } ){

    GetSnackBar snackBar = GetSnackBar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorRes.black.withOpacity(.16),
      boxShadows: [
        BoxShadow(
          //offset: const Offset(-2, 2),
            color: ColorRes.white.withOpacity(.02),
            spreadRadius: 3,
            blurRadius: 5
        )
      ],
      titleText: Text(
        StringRes.warning.toUpperCase(),
        style: TextStyle(
            color: ColorRes.textWarning,
            fontFamily: FontRes.smBold,
            fontSize: 16
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
            color: ColorRes.white,
            fontFamily: FontRes.regular,
            fontSize: 12
        ),
      ),
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 2),
    );

    if(type == ToastEnum.success){
      snackBar = GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorRes.bgDarkGrey,
        titleText: Text(
          StringRes.success.toUpperCase(),
          style: TextStyle(
              color: ColorRes.textSuccess,
              fontFamily: FontRes.smBold,
              fontSize: 16
          ),
        ),
        messageText: Text(
          message,
          style: TextStyle(
              color: ColorRes.white,
              fontFamily: FontRes.regular,
              fontSize: 12
          ),
        ),
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(seconds: 2),
      );
    }

    if(type == ToastEnum.error){
      snackBar = GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorRes.bgDarkGrey,
        titleText: Text(
          StringRes.failed.toUpperCase(),
          style: TextStyle(
              color: ColorRes.textError,
              fontFamily: FontRes.smBold,
              fontSize: 16
          ),
        ),
        messageText: Text(
          message,
          style: TextStyle(
              color: ColorRes.white,
              fontFamily: FontRes.regular,
              fontSize: 12
          ),
        ),
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(seconds: 2),
      );
    }
    Get.showSnackbar(snackBar);
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

  static Future loader({bool barrierDismissible = false}) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return PopScope(
            canPop: false,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorRes.textDarkBrown,
              ),
            )
        );
      },
    );
  }

}