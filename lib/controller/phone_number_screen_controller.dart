
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/otp/otp_verify_screen.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneNumberScreenController extends GetxController {

  /*--- UI ---*/
  TextEditingController phoneTextController = TextEditingController();
  /*--- Services ---*/
  ApiService apiService = ApiService.instance;

  /*--- Variable and Lists ---*/
  CountryModel get countryModel => Get.arguments[1];
  String get loginType => Get.arguments[0];
  bool isLoading = false;
  String errorText = "";

  // UI event methods and action methods declare here
  void onBackTap(){
    Get.back();
  }

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  void setError(String value){
    errorText = value;
    update();
  }



  onGetOtpTap(){
    if(isLoading) return;
    if(!isValidate()) return;

    if(loginType.contains("agent")){
      getCounsellorLogin();
    } else {
      getStudentLogin();
    }

  }


  bool isValidate(){
    setError("");

    if(phoneTextController.text.trim().isEmpty){
      setError(StringRes.msgPleaseEnterValidMobileNumber);
      return false;
    }

    return true;
  }

  // Api service method create and declare here
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
        CustomUiUtils.showSnackbar(responseModel.message?? "");
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
        CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }

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
        CustomUiUtils.showSnackbar(responseModel.message?? "");
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
        CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }

}