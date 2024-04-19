
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/phone_number/phone_number_screen.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CountryListScreenController extends GetxController {

  /*--- UI ---*/
  TextEditingController searchController = TextEditingController();
  /*--- Services ---*/
  ApiService apiService = ApiService.instance;

  /*--- Variable and Lists ---*/
  late List<CountryModel> _countriesList = [];
  late List<CountryModel> _searchCountriesList = [];
  List<CountryModel> get getCountries => _searchCountriesList;
  bool isLoading = false;

  String get loginType => Get.arguments["login_type"];

  @override
  void onReady() {
    fetchCountries();
    print("loginType ::: $loginType");
    super.onReady();
  }

  // UI event methods and action methods declare here
  void onBackTap(){
    Get.back();
  }

  searchedCountry(){
    if(_countriesList.isEmpty) return;
    if(searchController.text.trim().isEmpty){
      _searchCountriesList = _countriesList;
      update();
      return;
    }
    var list = _countriesList.where(
            (element) => element.name!.toLowerCase().contains(
              searchController.text.toLowerCase()
            )
    ).toList();
    _searchCountriesList = list;
    update();
  }

  onCountryTap(CountryModel model) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Get.to(() => const PhoneNumberScreen(), arguments: [loginType, model]);
  }

  clearAll(){
    _countriesList.clear();
    _searchCountriesList.clear();
    update();
  }

  prepareCountryList(List<dynamic> data) {
    var list = data.map((e) => CountryModel.fromJson(e)).toList();
    _countriesList = list;
    _searchCountriesList = list;
    update();
  }

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  // Api service method create and declare here
  Future fetchCountries({bool isRefresh = false}) async {
    if(!isRefresh){
      setLoading(true);
    }
     try{
       var res =  await apiService.getCountries();
       GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
       prepareCountryList(responseModel.data);
       setLoading(false);
     } on DioException catch (ex) {
       CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
       setLoading(false);
     } catch (ex) {
       CustomUiUtils.showSnackbar(StringRes.msgSomethingWentWrong);
       setLoading(false);
     }
  }


}