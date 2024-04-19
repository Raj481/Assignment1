
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/home/home_screen.dart';
import 'package:appassesment/ui/phone_number/phone_number_screen.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectCountryScreenController extends GetxController {

  /*--- UI ---*/
  /*--- Services ---*/
  ApiService apiService = ApiService.instance;

  /*--- Variable and Lists ---*/
  bool isLoading = false;

  @override
  void onReady() {
    super.onReady();
  }

  // UI event methods and action methods declare here
  void onBackTap(){
    Get.back();
  }

  void onProceedTap(){
    Get.to(() => const HomeScreen());
  }

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  // Api service method create and declare here



}