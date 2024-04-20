
import 'dart:convert';

import 'package:appassesment/model/user_model.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:appassesment/ui/country/country_code_screen/country_code_select_screen.dart';
import 'package:appassesment/ui/home/home_screen.dart';
import 'package:appassesment/ui/terms_and_condition/terms_condition_screen.dart';
import 'package:appassesment/utils/const_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:get/get.dart';

class StartUpScreenController extends GetxController {

  /*--- Services ---*/
  PrefService prefService = PrefService.instance;

  // overrider state controller event methods and action methods declare here
  @override
  void onInit() async {
    await prefService.init();
    super.onInit();
  }

  @override
  void onReady() async {
    await isLogin();
    super.onReady();
  }

  // UI event methods and action methods declare here
  void onAgentTap() {
    Get.to(() => const CountryCodeSelectScreen(), arguments: {"login_type" : "agent"});
  }
  void onStudentTap() {
    Get.to(() => const CountryCodeSelectScreen(), arguments: {"login_type" : "student"});
  }
  void onTermsConditionTap() {
    Get.to(() => const TermsConditionScreen());
  }

  Future isLogin() async {
    CustomUi.loader();
    var data = prefService.getBool(key: ConstRes.isLogin);
    if(data) {
      Get.back();
      Get.offAll(() => const HomeScreen());
    }
    else {
      Get.back();
    }

  }

}