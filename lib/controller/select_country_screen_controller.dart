
import 'dart:convert';

import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/model/user_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/services/response/select_country_response.dart';
import 'package:appassesment/ui/home/home_screen.dart';
import 'package:appassesment/ui/phone_number/phone_number_screen.dart';
import 'package:appassesment/utils/const_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class  SelectCountryScreenController extends GetxController {

  /*--- UI ---*/
  /*--- Services ---*/
  ApiService apiService = ApiService.instance;
  PrefService prefService = PrefService.instance;

  /*--- Variable and Lists ---*/
  bool isLoading = false;
  UserModel? userModel;
  List<Country>? _countries = [];
  List<Country> get getCountries =>  _countries ?? [];


  @override
  void onInit() async {
    await prefService.init();
    super.onInit();
  }

  @override
  void onReady() async {
    await getUser().whenComplete(
            ()async{
          await getSelectCountries();
        });
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

  void setUser(UserModel model){
    userModel = model;
    update();
  }

  void setCountries(List<Country> value){
    _countries = value;
    update();
  }

  void onCountryITemTap(int index){
    var selectedIndex = _countries!.indexWhere((element) => element.isSelected);
    if((selectedIndex != index) && selectedIndex != -1){
      _countries![selectedIndex].isSelected = false;
      _countries![index].isSelected = true;
    } else{
      if(_countries![index].isSelected){
        _countries![index].isSelected = false;
      } else{
        _countries![index].isSelected = true;
      }
    }
    update();
  }

  Future getUser() async {
    var data = prefService.getString(key: ConstRes.user);
    if(data == null) return;
    var userMap = await jsonDecode(data);
    var model = UserModel.fromJson(userMap);
    setUser(model);
  }

  // Api service method create and declare here

  Future getSelectCountries({bool isRefresh = false}) async {

    if(!isRefresh){
      setLoading(true);
    }
    try{
      var res =  await apiService.getSelectCountry(
        accessToken:  userModel!.accessToken ?? "",
        tokenType: "Bearer"
      );
      GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
      if(res.statusCode == 200){
        SelectCountryResponse response = SelectCountryResponse.fromJson(responseModel.data);
        setCountries(response.countries ?? []);
        CustomUiUtils.showSnackbar(responseModel.message?? "");
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
        CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
    } catch (ex) {
      CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
      print("exception ::: $ex");
    }
  }

}