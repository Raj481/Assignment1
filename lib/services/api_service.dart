
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

  Future<Response> logout({
    required String accessToken,
    required String tokenType,
  }) {
    var headers = {
      "Authorization" : "$tokenType $accessToken"
    };
    return networkUtil.postWithHeaders(ApiConstants.userLogout, headers: headers );
  }
  Future<Response> deleteUser({
    required String accessToken,
    required String tokenType,
  }) {
    var headers = {
      "Authorization" : "$tokenType $accessToken"
    };
    return networkUtil.postWithHeaders(ApiConstants.userDelete, headers: headers);
  }

  Future<Response> getSelectCountry({
    required String accessToken,
    required String tokenType,
  }) {
    var headers = {
      "Authorization" : "$tokenType $accessToken"
    };
    return networkUtil.get(ApiConstants.selectCountry, headers: headers );
  }

  Future<Response> postSelectCountry({
    required String accessToken,
    required String tokenType,
    required dynamic countryId,
  }) {
    var headers = {
      "Authorization" : "$tokenType $accessToken"
    };
    final formData = FormData.fromMap({
      'country_id': countryId,
    });
    return networkUtil.postWithParamHeaders(
      ApiConstants.selectCountry,
        headers: headers,
        params: formData
    );
  }


}