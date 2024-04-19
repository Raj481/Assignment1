
class GeneralResponse{

  dynamic success;
  dynamic status;
  dynamic message;
  dynamic data;
  GeneralResponse.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        status = json["status"] ,
        message = json["message"],
        data = json["data"];
}