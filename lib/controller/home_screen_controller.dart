// Import necessary packages
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// Import custom classes
import 'package:appassesment/model/user_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/startup/start_up_screen.dart';
import 'package:appassesment/utils/const_res.dart';
import 'package:appassesment/utils/constants.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';

class HomeScreenController extends GetxController {

  /*
  *  Services for API and preferences
  * */
  ApiService apiService = ApiService.instance;
  PrefService prefService = PrefService.instance;

  /*--- Variable and Lists ---*/
  // Variable to track loading state
  bool isLoading = false;

  // Error message text
  String errorText = "";

  // User model to store user information
  UserModel? userModel;

  /*
  * Override state controller methods and declare here
   */

  // Method called when the controller is initialized
  @override
  void onInit() async {
    await prefService.init();
    super.onInit();
  }

  // Method called when the controller is ready
  @override
  void onReady() async {
    await getUser();
    super.onReady();
  }

  /*
  * UI event methods and action methods declare here
  * */
  // Method to set loading state
  void setLoading(bool value){
    isLoading = value;
    update();
  }

  // Method to handle logout action
  onLogoutTap() async {
    if(isLoading) return;
    await userLogout();
  }

  // Method to handle user deletion action
  onDeleteUserTap() async {
    if(isLoading) return;
    await userDelete();
  }

  // Method to set user data
  void setUser(UserModel model){
    userModel = model;
    update();
  }

  // Method to get user data from preferences
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

  // Method to log out the user api fetch
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
        }
        if(e.response!.statusCode == 403){
          GeneralResponse response = GeneralResponse.fromJson(e.response!.data);
        }
        else {

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

  // Method to delete the user api fetch
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