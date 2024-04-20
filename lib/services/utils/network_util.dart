
import 'package:appassesment/services/api_constants.dart';
import 'package:appassesment/services/interceptor/logging.dart';
import 'package:dio/dio.dart';

class NetworkUtil {

   static String get tag => "DioClient";
   NetworkUtil._();

   static late Dio _dio;

   static NetworkUtil get instance {
     ///Create Dio Object using baseOptions set receiveTimeout,connectTimeout
     BaseOptions options = BaseOptions(
         receiveTimeout: const Duration(milliseconds: ApiConstants.receiveApiTimeout),
         connectTimeout:  const Duration(milliseconds: ApiConstants.apiTimeout) );

     options.baseUrl = ApiConstants.baseUrl;
     _dio = Dio(options);
     _dio.interceptors.add(Logging());

     return NetworkUtil._();
   }

   ///used for calling get Request
   Future<Response> get(String url,{Map<String, dynamic>? headers}) async {
     late Response response;
     if(headers == null){
       response = await _dio.get(
           url,
           options: Options(
               responseType: ResponseType.json,
           )
       );
     } else {
       response = await _dio.get(
           url,
           options: Options(
             responseType: ResponseType.json,
             headers: headers
           )
       );
     }

     return response;
   }

   ///used for calling post Request
   Future<Response> post(String url, FormData params) async {
     Response response = await _dio.post(url,
         data: params,
         options: Options(responseType: ResponseType.json)
     );
     return response;
   }

   Future<Response> postWithParamHeaders(
       String url, {
     Map<String, dynamic>? headers,
     FormData? params
   }) async {
     Response response = await _dio.post(url,
         data: params,
         options: Options(
             responseType: ResponseType.json,
             headers: headers
         )
     );

     return response;
   }

   Future<Response> postWithHeaders(
       String url,
       {Map<String, dynamic>? headers}) async {
     Response response = await _dio.post(url,
         options: Options(
             responseType: ResponseType.json,
             headers: headers
         )
     );

     return response;
   }

   ///used for calling post Request
   Future<Response> delete(String url, Map<String, String> params) async {
     Response response = await _dio.delete(url,
         data: params, options: Options(responseType: ResponseType.json));
     return response;
   }

 }