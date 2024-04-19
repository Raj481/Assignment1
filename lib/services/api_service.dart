
import 'package:appassesment/services/api_constants.dart';
import 'package:appassesment/services/utils/network_util.dart';
import 'package:dio/dio.dart';

class ApiService {

 // static const String TAG ="ApiService";
  ApiService._();
  static NetworkUtil networkUtil = NetworkUtil.instance;

  ///Single final Object of API Service
  // final apiServiceInstance = ApiService();
  static ApiService get instance {
    return ApiService._();
  }

  /// write your all API Async requests here
  Future<Response> getCountries() {
    return networkUtil.get(ApiConstants.countries);
  }

  Future<Response> getTermsCondition() {
    return networkUtil.get(ApiConstants.termsConditions);
  }

  Future<Response> studentLogin({required String countryCode, required String phoneNumber}) {
    final formData = FormData.fromMap({
      'tel_code': countryCode,
      'phone': phoneNumber,
    });
    return networkUtil.post(ApiConstants.studentLogin, formData);
  }

  Future<Response> counsellorLogin({required String countryCode, required String phoneNumber}) {
    final formData = FormData.fromMap({
      'tel_code': countryCode,
      'phone': phoneNumber,
    });
    return networkUtil.post(ApiConstants.counsellorLogin, formData);
  }

  Future<Response> verifyOtp({
    required String otp,
    required String phoneNumberWithCountryCode
  }) {
    final formData = FormData.fromMap({
      'phone': phoneNumberWithCountryCode,
      'code': otp,
    });
    return networkUtil.post(ApiConstants.verifyOtp, formData);
  }

  Future<Response> resendOtp({
    required String phoneNumberWithCountryCode
  }) {
    final formData = FormData.fromMap({
      'phone': phoneNumberWithCountryCode,
    });
    return networkUtil.post(ApiConstants.resendOtp, formData);
  }

  Future<Response> logout() {
    return networkUtil.get(ApiConstants.userLogout,);
  }
  Future<Response> deleteUser() {
    return networkUtil.get(ApiConstants.userDelete,);
  }

  Future<Response> getSelectCountry() {
    return networkUtil.get(ApiConstants.selectCountry,);
  }

  Future<Response> postSelectCountry() {
    return networkUtil.get(ApiConstants.selectCountry,);
  }


}