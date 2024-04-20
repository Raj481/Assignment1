// Import necessary packages
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Import custom classes
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/response/general_response.dart';
import 'package:appassesment/ui/phone_number/phone_number_screen.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/string_res.dart';

// Define the controller class
class CountryListScreenController extends GetxController {

  // Text editing controller for search input
  TextEditingController searchController = TextEditingController();

  // Service for making API requests
  ApiService apiService = ApiService.instance;

  // Lists to store countries data
  late List<CountryModel> _countriesList = [];
  late List<CountryModel> _searchCountriesList = [];
  List<CountryModel> get getCountries => _searchCountriesList;

  // Flag to indicate loading state
  bool isLoading = false;

  // Get login type from arguments
  String get loginType => Get.arguments["login_type"];

  // Method called when the controller is ready
  @override
  void onReady() {
    fetchCountries();
    super.onReady();
  }

  // Method to handle back button tap
  void onBackTap(){
    Get.back();
  }

  // Method to handle search functionality
  searchedCountry() {
    // Check if countries list is empty
    if(_countriesList.isEmpty) return;
    // If search text is empty, show all countries
    if(searchController.text.trim().isEmpty){
      _searchCountriesList = _countriesList;
      update();
      return;
    }
    // Filter countries based on search text
    var list = _countriesList.where(
            (element) => element.name!.toLowerCase().contains(
              searchController.text.toLowerCase()
            )
    ).toList();
    // Update the filtered countries list
    _searchCountriesList = list;
    update();
  }

  // Method to handle country selection
  onCountryTap(CountryModel model) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Get.to(() => const PhoneNumberScreen(), arguments: [loginType, model]);
  }

  // Method to clear all countries
  clearAll(){
    _countriesList.clear();
    _searchCountriesList.clear();
    update();
  }

  // Method to prepare list of countries from API response
  prepareCountryList(List<dynamic> data) {
    var list = data.map((e) => CountryModel.fromJson(e)).toList();
    _countriesList = list;
    _searchCountriesList = list;
    update();
  }

  // Method to set loading state
  void setLoading(bool value){
    isLoading = value;
    update();
  }

  /*
  *  Api service method create and declare here
  *  Method to fetch countries data from API
  * */

  Future fetchCountries({bool isRefresh = false}) async {
    if(!isRefresh){
      setLoading(true);
    }
     try{
       var res =  await apiService.getCountries();
       GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
       prepareCountryList(responseModel.data);
       setLoading(false);
     } on DioException {
       CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
       setLoading(false);
     } catch (ex) {
       CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
       setLoading(false);
     }
  }


}