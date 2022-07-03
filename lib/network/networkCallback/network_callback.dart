import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';

import '../../utils/enums.dart';
import '../client/api_client.dart';

class NetworkCall {
  static Future<Map<String, dynamic>> makeCall(
      {required String endPoint,
      required HttpMethod method,
      dynamic requestBody,
      Map<String, dynamic>? queryParams,
      bool isMultipart = false,
      bool urlExist = false,
      String imageUrl = '',
      List<MultipartFile>? multiPartValues}) async {
    try {
      Response? response;
      if (method == HttpMethod.GET) {
        response =
            (await ApiClient.getRequest(endPoint, queryParams!, urlExist));
      }
      // else if (method == HttpMethod.POST) {
      //   response = (await ApiClient.postRequest(
      //     endPoint,
      //     requestBody,
      //     imageUrl: imageUrl,
      //     isMultipart: isMultipart,
      //     multiPartValues: multiPartValues,
      //   ));
      // } else if (method == HttpMethod.PUT) {
      //   response = (await ApiClient.putRequest(endPoint, requestBody,
      //       isMultipart: isMultipart, multiPartValues: multiPartValues));
      // } else if (method == HttpMethod.DELETE) {
      //   response = (await ApiClient.deleteRequest(endPoint, queryParams!));
      // }

      if (response!.statusCode == NetworkStatusCodes.OK_200.value ||
          response.statusCode == NetworkStatusCodes(201).value) {
        //Api logger
        log("Api Response: ${response.body}");

        return jsonDecode(response.body);
      } else if (response.statusCode ==
              NetworkStatusCodes.ServerInternalError.value ||
          response.statusCode == NetworkStatusCodes.BadRequest.value) {
        //Api logger

        log("API Error: ${response.statusCode} - ${response.reasonPhrase} - ${response.body}");
        return {
          "status": false,
          "code": response.statusCode,
          'response': jsonDecode(response.body) as Map<String, dynamic>,
          "message": 'Internal Server Error',
        };
      } else if (response.statusCode ==
          NetworkStatusCodes.UnAuthorizedUser.value) {
        var result = jsonDecode(response.body) as Map<String, dynamic>;

        //Api logger
        log("API Error: ${response.statusCode} - ${response.reasonPhrase} - $result");
        return {
          "status": false,
          "code": response.statusCode,
          "message": result['title']
        };
      } else {
        //Api logger
        log("API Error: ${response.statusCode} - ${response.reasonPhrase} - ${response.body}");
        return {
          "status": false,
          "code": response.statusCode,
          'response': jsonDecode(response.body) as Map<String, dynamic>,
          "message": response.reasonPhrase
        };
      }
    } on SocketException catch (_) {
      return {
        "status": false,
        "code": 0,
        "message":
            'No internet connection, please check your network and try again',
      };
    } on Exception catch (_) {
      return {"status": false, "code": 0, "message": _.toString()};
    }
  }
}
