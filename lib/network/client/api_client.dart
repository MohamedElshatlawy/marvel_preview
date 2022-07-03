import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../services_urls.dart';

class ApiClient {
  static Map<String, String> headers(
      {String contentType = 'application/json'}) {
    var mHeaders = {
      HttpHeaders.contentTypeHeader: contentType,
    };
    return mHeaders;
  }

  static Future<Response> getRequest(
      String endPoint, Map<String, dynamic> queryParams, bool urlExist) async {
    // Uri url = Uri(
    //   scheme: ServicesURLs.development_environment_scheme,
    //   host: ServicesURLs.development_environment_without_http,
    //   path: endPoint,
    //   queryParameters: queryParams,
    // );

    String url = urlExist == false
        ? "${ServicesURLs.development_environment}$endPoint?ts=1&offset=${queryParams['offset']}&limit=${queryParams['limit']}&apikey=${ServicesURLs.api_key}&hash=${ServicesURLs.hash}"
        : "$endPoint?ts=1&apikey=${ServicesURLs.api_key}&hash=${ServicesURLs.hash}";
    //network logger
    log("$url\n${headers()}");
    //GET network request call
    final response = await http.get(
      Uri.parse(url),
      headers: headers(),
    );

    return response;
  }

  // static Future<http.Response> postRequest(String endPoint, dynamic requestBody,
  //     {bool isMultipart = false,
  //     String imageUrl = '',
  //     List<http.MultipartFile>? multiPartValues}) async {
  //   String url = imageUrl == ''
  //       ? ServicesURLs.development_environment + endPoint
  //       : imageUrl;
  //
  //   http.Response response;
  //   if (!isMultipart) {
  //     response = await http.post(Uri.parse(url),
  //         headers: headers(
  //             contentType: imageUrl == ''
  //                 ? 'application/json'
  //                 : 'multipart/form-data; boundary=<calculated when request is sent>'),
  //         body: requestBody);
  //   } else {
  //     log("*****MultiPartRequest*****");
  //     var uri = Uri.parse(url);
  //     Map<String, dynamic> p = jsonDecode(requestBody);
  //     Map<String, String> convertedMap = {};
  //     p.forEach((key, value) {
  //       convertedMap[key] = value;
  //     });
  //
  //     var request = http.MultipartRequest('POST', uri)
  //       ..headers.addAll(headers(
  //           contentType: imageUrl == ''
  //               ? 'application/json'
  //               : 'multipart/form-data; boundary=<calculated when request is sent>'))
  //       ..fields.addAll(convertedMap)
  //       ..files.addAll(multiPartValues!);
  //
  //     response = await http.Response.fromStream(await request.send());
  //   }
  //   //network logger
  //   log("$url\n${headers(contentType: imageUrl == '' ? 'application/json' : 'multipart/form-data; boundary=<calculated when request is sent>')}");
  //   if (requestBody != null) log(requestBody.toString());
  //   //POST network request call
  //   return response;
  // }
  //
  // static Future<http.Response> putRequest(String endPoint, dynamic requestBody,
  //     {bool isMultipart = false,
  //     List<http.MultipartFile>? multiPartValues}) async {
  //   //create url of (baseUrl + endPoint)
  //   String url = ServicesURLs.development_environment + endPoint;
  //   //network logger
  //   log("$url\n${headers()}");
  //   if (requestBody != null) log(requestBody.toString());
  //   //POST network request call
  //   http.Response response;
  //   if (!isMultipart) {
  //     response =
  //         await http.put(Uri.parse(url), headers: headers(), body: requestBody);
  //   } else {
  //     log("****MultiPart*****");
  //     var uri = Uri.parse(url);
  //     Map<String, dynamic> p = jsonDecode(requestBody);
  //     Map<String, String> convertedMap = {};
  //     p.forEach((key, value) {
  //       convertedMap[key] = value;
  //     });
  //
  //     var request = http.MultipartRequest('PUT', uri)
  //       ..headers.addAll(headers())
  //       ..fields.addAll(convertedMap)
  //       ..files.addAll(multiPartValues!);
  //
  //     response = await http.Response.fromStream(await request.send());
  //   }
  //
  //   return response;
  // }
  //
  // static Future<Response> deleteRequest(
  //     String endPoint, Map<String, dynamic> queryParams) async {
  //   //create url with (baseUrl + endPoint) and query Params if any
  //   String url = ServicesURLs.development_environment + endPoint;
  //   //network logger
  //   log("$url\n${headers()}");
  //   //GET network request call
  //   final response = await http.delete(Uri.parse(url), headers: headers());
  //
  //   return response;
  // }
}
