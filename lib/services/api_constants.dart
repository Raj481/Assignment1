
class ApiConstants {

  ApiConstants._();

  static String get baseUrl => "https://studylancer.yuktidea.com/api";
  static const int apiTimeout = 50000;
  static const int receiveApiTimeout = 30000;
  static String get termsConditions => "$baseUrl/terms-conditions";
  static String get studentLogin => "$baseUrl/student/login";
  static String get counsellorLogin => "$baseUrl/counsellor/login";
  static String get verifyOtp => "$baseUrl/verify-otp";
  static String get resendOtp => "$baseUrl/resend-otp";
  static String get userLogout => "$baseUrl/logout";
  static String get userDelete => "$baseUrl/delete";
  static String get selectCountry => "$baseUrl/select/country";
  static String get countries => "$baseUrl/countries";

}