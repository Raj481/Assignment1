
import 'dart:convert';
import 'package:appassesment/model/user_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/startup/start_up_screen.dart';
import 'package:appassesment/utils/const_res.dart';
import 'package:appassesment/utils/constants.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {

  /*--- Services ---*/
  ApiService apiService = ApiService.instance;
  PrefService prefService = PrefService.instance;

  /*--- Variable and Lists ---*/
  bool isLoading = false;
  String errorText = "";
  UserModel? userModel;

  /*
  * Override state controller methods and declare here
  * */
  @override
  void onInit() async {
    await prefService.init();
    super.onInit();
  }

  @override
  void onReady() async {
    await getUser();
    super.onReady();
  }

  /*
  * UI event methods and action methods declare here
  * */
  void setLoading(bool value){
    isLoading = value;
    update();
  }

  onLogoutTap() async {
    /*setLoading(true);
    Future.delayed(const Duration(seconds: 10),(){
      setLoading(false);
    });*/
    if(isLoading) return;
    await userLogout();
  }
  onDeleteUserTap() async {
    if(isLoading) return;
    await userDelete();
  }

  void setUser(UserModel model){
    userModel = model;
    update();
  }

  Future getUser() async {
    var data = prefService.getString(key: ConstRes.user);
    if(data == null) return;
    var userMap = await jsonDecode(data);
    var model = UserModel.fromJson(userMap);
    setUser(model);
  }

  /*
  * Api service method create and declare here
  * */

  Future userLogout({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{
      var res =  await apiService.logout(
          accessToken:  userModel!.accessToken ?? "",
          tokenType: "Bearer"
      );
      if(res.statusCode == 200){
       await prefService.clearPrefs().whenComplete((){
         Get.offAll(() => const StartUpScreen());
       });
      }
      setLoading(false);

    } on DioException catch (e) {

      if(e.response != null){
        if(e.response!.statusCode == 400){
          //setError(StringRes.msgOTPDoesNotMatch);
        }
        if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
          // setError(response.data);
        }
        else {
          // CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
        }
      }
      else{
        CustomUi.showSnackbar(
            StringRes.msgSomethingWentWrong,
            type: ToastEnum.error);
      }
      setLoading(false);
    } catch (ex) {
      CustomUi.showSnackbar(
          StringRes.msgSomethingWentWrong,
          type: ToastEnum.error);
      print("Exception ::: $ex");
      setLoading(false);
    }
  }
  Future userDelete({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{
      var res =  await apiService.deleteUser(
          accessToken:  userModel!.accessToken ?? "",
          tokenType: "Bearer"
      );
      if(res.statusCode == 200){
       await prefService.clearPrefs().whenComplete((){
         Get.offAll(() => const StartUpScreen());
       });
      }
      setLoading(false);

    } on DioException catch (e) {

      if(e.response != null){
        if(e.response!.statusCode == 400){
          //setError(StringRes.msgOTPDoesNotMatch);
        }
        if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
          // setError(response.data);
        }
        else {
          // CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
        }
      }
      else{
        CustomUi.showSnackbar(
            StringRes.msgSomethingWentWrong,
            type: ToastEnum.error);
      }
      setLoading(false);
    } catch (ex) {
      CustomUi.showSnackbar(
          StringRes.msgSomethingWentWrong,
          type: ToastEnum.error);
      setLoading(false);
    }
  }

}