
import 'package:appassesment/ui/country/country_code_screen/country_code_select_screen.dart';
import 'package:appassesment/ui/home/home_screen.dart';
import 'package:appassesment/ui/terms_and_condition/terms_condition_screen.dart';
import 'package:get/get.dart';

class StartUpScreenController extends GetxController {

  void onAgentTap() {
    Get.to(() => const CountryCodeSelectScreen(), arguments: {"login_type" : "agent"});
  }
  void onStudentTap() {
    Get.to(() => const CountryCodeSelectScreen(), arguments: {"login_type" : "student"});
  }

  void onTermsConditionTap() {
    Get.to(() => const TermsConditionScreen());
  }

}