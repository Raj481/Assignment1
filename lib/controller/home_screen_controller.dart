

import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {

  /*--- Services ---*/
  ApiService apiService = ApiService.instance;
  PrefService prefService = PrefService.instance;

  /*--- Variable and Lists ---*/
  String get loginType => Get.arguments[0];
  String get phoneNumber => Get.arguments[2];
  bool isLoading = false;
  String errorText = "";


  @override
  void onInit() async {
    await prefService.init();
    super.onInit();
  }


  // UI event methods and action methods declare here
  void setLoading(bool value){
    isLoading = value;
    update();
  }


  // Api service method create and declare here

}