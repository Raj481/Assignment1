
import 'package:appassesment/services/api_service.dart';
import 'package:appassesment/services/pref_service.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../services/response/general_response.dart';

class TermsConditionScreenController extends GetxController {

   // Services for API and preferences
   ApiService apiService = ApiService.instance;
   PrefService prefService = PrefService.instance;

   /*--- Variable and Lists ---*/
   bool isLoading = false;
   dynamic responseData;


   @override
  void onReady() async {
    super.onReady();
    await fetchTermConditionData();
  }

   /*
  * UI event methods and action methods declare here
  * */
   // Method to handle back button tap
   void onBackTap(){
      Get.back();
   }

   // Method to set loading state
   void setLoading(bool value){
      isLoading = value;
      update();
   }

   void setResponseData( value){
      responseData = value;
      update();
   }

   // Api service method create and declare here
   // Method to fetch countries list from API
   Future fetchTermConditionData({bool isRefresh = false}) async {

      if(!isRefresh){
         setLoading(true);
      }
      try{
         var res =  await apiService.getTermsCondition();
         GeneralResponse responseModel = GeneralResponse.fromJson(res.data);
         if(res.statusCode == 200){
            setResponseData(responseModel.data);
         }
         setLoading(false);

      } on DioException catch (e) {
         dioExceptionHandlers(e);
      } catch (e) {
         generalExceptionHandlers(e);
      }
   }


   /*Exception Handlers Methods*/

   void dioExceptionHandlers(DioException e){
      if(e.response != null){
         if(e.response!.statusCode == 400){
         }
         if(e.response!.statusCode == 403){

         }
         else {
         }
      }
      else{
         CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      }
      setLoading(false);
   }

   void generalExceptionHandlers(Object e){
      CustomUi.showSnackbar(StringRes.msgSomethingWentWrong);
      setLoading(false);
   }

}