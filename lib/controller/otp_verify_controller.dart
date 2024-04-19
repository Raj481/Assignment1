

import 'dart:async';
import 'dart:ffi';

import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/country/select_country_screen/select_country_screen.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OtpVerifyController extends GetxController {

  /*--- UI ---*/
  OtpFieldController otpFieldController = OtpFieldController();

  /*--- Services ---*/
  ApiService apiService = ApiService.instance;

  /*--- Variable and Lists ---*/
  CountryModel get countryModel => Get.arguments[1];
  String get loginType => Get.arguments[0];
  String get phoneNumber => Get.arguments[2];
  bool isLoading = false;
  String errorText = "";
  String otpValue = "";

  Timer? timer;
  int remainingSeconds = 30;


  // UI event methods and action methods declare here
  void onBackTap(){
    Get.back();
  }

  void setOtp(String value){
    otpValue = value;
    update();
  }

  void onVerifyTap() {
    if(isLoading) return;
    if(!isValidate()) return;
    verifyOtp();
    // Get.to(() => const SelectCountryScreen());
  }

  void onResendTap() {
    setError("");
    if((timer != null) && timer!.isActive) {
      return; 
    }
    resendOtp();
  }

  void startTimer(int seconds) {
    remainingSeconds = seconds;
    Duration duration = const Duration(seconds: 1);
    timer = Timer.periodic(duration, onTimerEnd);
    update();
  }

  void onTimerEnd(Timer value) {
    if(remainingSeconds <= 0){
      value.cancel();
    } else{
      remainingSeconds--;
    }
    update();

  }

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  void setError(String value){
    errorText = value;
    update();
  }


  bool isValidate(){
    setError("");
    if(otpValue.trim().isEmpty){
      setError(StringRes.msgPleaseEnterTheOtpReceived);
      return false;
    }
    return true;
  }


  // Api service method create and declare here
  Future verifyOtp({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{
      var res =  await apiService.verifyOtp(
          phoneNumberWithCountryCode: "${countryModel.telCode!}${phoneNumber}",
          otp: otpValue,
      );
      GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
      if(res.statusCode == 200){
        CustomUiUtils.showSnackbar(responseModel.message?? "");
        Get.to(() => const SelectCountryScreen(),
            /*arguments: [loginType, countryModel]*/);
      }
      setLoading(false);

    } on DioException catch (e) {

      if(e.response != null){
        if(e.response!.statusCode == 400){
          setError(StringRes.msgOTPDoesNotMatch);
        } if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
          setError(response.data);
        } else {
          CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
        }
      } else{
        CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }

  Future resendOtp({bool isRefresh = false}) async {

    if(isLoading) return;
    if(!isRefresh){
      setLoading(true);
    }
    try{
      var res =  await apiService.resendOtp(
          phoneNumberWithCountryCode: "${countryModel.telCode!}$phoneNumber",
      );
      GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
      if(res.statusCode == 200){
        startTimer(30);
        CustomUiUtils.showSnackbar(responseModel.message?? "");
      }
      setLoading(false);

    } on DioException catch (e) {
      if(e.response != null){
        if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
          setError(response.data);
        } else {
          CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
        }
      }
      else{
        CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }


}