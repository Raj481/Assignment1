// Import necessary packages
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Import custom classes
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/otp/otp_verify_screen.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/string_res.dart';

class PhoneNumberScreenController extends GetxController {

  /*--- UI elements ---*/
  TextEditingController phoneTextController = TextEditingController();
  /*--- Service for API requests ---*/
  ApiService apiService = ApiService.instance;

  /*--- Variable and Lists ---*/
  // Variables
  CountryModel get countryModel => Get.arguments[1];
  String get loginType => Get.arguments[0];
  bool isLoading = false;
  String errorText = "";

  // UI event methods and action methods declare here
  // Method to handle back button tap
  void onBackTap(){
    Get.back();
  }

  // Method to set loading state
  void setLoading(bool value){
    isLoading = value;
    update();
  }

  // Method to set error message
  void setError(String value){
    errorText = value;
    update();
  }

  // Method called when user taps on "Get OTP" button
  onGetOtpTap(){
    if(isLoading) return;
    if(!isValidate()) return;

    if(loginType.contains("agent")){
      getCounsellorLogin();
    } else {
      getStudentLogin();
    }

  }


  // Method to validate phone number input
  bool isValidate(){
    setError("");

    if(phoneTextController.text.trim().isEmpty){
      setError(StringRes.msgPleaseEnterValidMobileNumber);
      return false;
    }

    return true;
  }

  // Api service method create and declare here
  // Method to handle student login API request
  Future getStudentLogin({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{

      var res =  await apiService.studentLogin(
          countryCode: countryModel.telCode!,
          phoneNumber: phoneTextController.text
      );
      GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
      if(res.statusCode == 200){
        CustomUi.showSnackbar(responseModel.message?? "");
        Get.to(() => const OtpVerifyScreen(),arguments: [
          loginType,
          countryModel,
          phoneTextController.text
        ]);
      }
      setLoading(false);
    } on DioException catch (e) {
      if(e.response != null){
        GeneralResponse response = GeneralResponse.fromJson(e.response!.data!);
        // CustomUiUtils.showSnackbar(response.data);
        if(response.data is List){
          setError(response.data.first);
        } else {
          setError(response.data);
        }
      }
      else {
        CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }

  // Method to handle counsellor login API request
  Future getCounsellorLogin({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{

      var res =  await apiService.counsellorLogin(
          countryCode: countryModel.telCode!,
          phoneNumber: phoneTextController.text
      );
      GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
      if(res.statusCode == 200){
        CustomUi.showSnackbar(responseModel.message?? "");
        Get.to(() => const OtpVerifyScreen(),arguments: [
          loginType,
          countryModel,
          phoneTextController.text
        ]);
      }
      setLoading(false);
    } on DioException catch (e) {

      if(e.response != null){
        GeneralResponse response = GeneralResponse.fromJson(e.response!.data!);
        // CustomUiUtils.showSnackbar(response.data);
        if(response.data is List){
          setError(response.data.first);
        } else {
          setError(response.data);
        }
      }
      else {
        CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }

}