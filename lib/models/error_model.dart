class ErrorModel {
  bool? status;
  int? code;
  Response? response;
  String? message;

  ErrorModel({
    this.code,
    this.status,
    this.message,
    this.response,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }
}

class Response {
  String? code;
  String? message;

  Response({this.code, this.message});

  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
