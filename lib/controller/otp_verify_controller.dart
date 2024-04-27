
// Import necessary packages
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:otp_text_field/otp_field.dart';

// Import custom classes
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/country/select_country_screen/select_country_screen.dart';
import 'package:appassesment/utils/const_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';

import '../ui/otp/widget/sample_strategy.dart';

class OtpVerifyController extends GetxController {

  /*--- UI elements---*/
  OtpFieldController otpFieldController = OtpFieldController();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;

  /*--- Services for API and preferences ---*/
  ApiService apiService = ApiService.instance;
  PrefService prefService = PrefService.instance;

  // Variables
  bool isLoading = false;
  String errorText = "";
  String otpValue = "";

  // Timer for OTP resend
  Timer? timer;
  int remainingSeconds = 30;

  CountryModel get countryModel => Get.arguments[1];
  String get loginType => Get.arguments[0];
  String get phoneNumber => Get.arguments[2];


// Initialize preferences on controller initialization
  @override
  void onInit() async {
    await prefService.init();
    super.onInit();
  }

  @override
  void onReady() {
    startOtpListener();
    super.onReady();
  }

  @override
  void onClose() {
    controller.stopListen();
    super.onClose();
  }

  // UI event methods and action methods declare here
  // Method to handle back button tap
  void onBackTap(){
    Get.back();
  }

  // Method to set OTP value
  void setOtp(String value){
    otpValue = value;
    update();
  }

  // Method to handle OTP verification
  void onVerifyTap() {
    if(isLoading) return;
    if(!isValidate()) return;
    verifyOtp();
  }

  // Method to handle OTP resend
  void onResendTap() {
    setError("");
    if(isLoading) return;
    if((timer != null) && timer!.isActive) {
      return; 
    }
    resendOtp();
  }

  // Method to start timer for OTP resend
  void startTimer(int seconds) {
    remainingSeconds = seconds;
    Duration duration = const Duration(seconds: 1);
    timer = Timer.periodic(duration, onTimerEnd);
    update();
  }

  // Method called when timer ends
  void onTimerEnd(Timer value) {
    if(remainingSeconds <= 0){
      value.cancel();
    } else{
      remainingSeconds--;
    }
    update();
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


  // Method to validate OTP input
  bool isValidate(){
    setError("");
    if(otpValue.trim().isEmpty){
      setError(StringRes.msgPleaseEnterTheOtpReceived);
      return false;
    }
    return true;
  }

  // set otp listener
  void startOtpListener() {
    _initInteractor();
    controller = OTPTextEditController(
      codeLength: 4,
      //ignore: avoid_print
      onCodeReceive: (code) {
        print('Your StudyLancer verification code is: $code');
        var data = code.length;
        print('$data');
        var list = code.split("").map((e) => e.toString()).toList();
        otpFieldController.set(list);
        verifyOtp();
      },
      otpInteractor: _otpInteractor,
    )
      ..startListenUserConsent((code) {
        final exp = RegExp(r'(\d{4})');
        print("Otp printed ::: $code");
        return exp.stringMatch(code ?? '') ?? '';
      },
    );
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  // Api service method create and declare here
  // Method to verify OTP api fetch
  Future verifyOtp({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{
      var res =  await apiService.verifyOtp(
          phoneNumberWithCountryCode: "${countryModel.telCode!}$phoneNumber",
          otp: otpValue,
      );
      GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
      if(res.statusCode == 200){
        CustomUi.showSnackbar(responseModel.message?? "");
        var userMap = jsonEncode(responseModel.data);
        await prefService.saveString(key: ConstRes.user, value: userMap);
        await prefService.saveBool(key: ConstRes.isLogin, value: true);
        Get.to(() => const SelectCountryScreen());
      }
      setLoading(false);

    } on DioException catch (e) {

      if(e.response != null){
        if(e.response!.statusCode == 400){
          setError(StringRes.msgOTPDoesNotMatch);
        }
        if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
          setError(response.data);
        }
        else {}
      }
      else{
        CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }

  // Method to resend OTP api fetch
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
        CustomUi.showSnackbar(responseModel.message?? "");
        startOtpListener();
      }
      setLoading(false);

    } on DioException catch (e) {
      if(e.response != null){
        if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
          setError(response.data);
        } else {
          CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
        }
      }
      else{
        CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
    }
  }


}