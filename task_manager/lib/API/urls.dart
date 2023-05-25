import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/API/model/genModel.dart';

class urls {
  static String baseUrlMain = "https://task.mysyva.net/backend/";

  static String login = "${urls.baseUrlMain}Login";
  static String adminDashBoard = "${urls.baseUrlMain}AdminDashboard";
  static String clientLog = "${urls.baseUrlMain}ClientLogData_Dashboard";



   static Map<String, String> xToken = {
    'Xtoken':
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Im1va3NoZXMiLCJwYXNzd29yZCI6IiQyYSQxMiRRem1TZkFZalhGR0E0RzZWREdZblRPM2dXM21xdEJJWnlYM3VhRUNyUW12WGVSN1I0QVNOYSJ9.N9AFKPmku7qScJaRwIBMsiOIyr6Cx6Bfjf_n2Q05Df4',
   // 'Cookie': 'ci_session=a7c4368defaabe2595797df65df38def',
  };

  static Future<genModel?> postApiCall(
    String method,
    Map<String, dynamic> params,
    Map<String, String> headers,
  ) async {
    if (kDebugMode) {
      print(method);
      print(params);
    }
    try {
      var request = http.Request('POST', Uri.parse(method));
      request.body = json.encode(params);
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      // request.headers.addAll({
      //   'Content-Type': 'application/json',
      //   //xToken  : webToken
      // });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        genModel genmodel = genModel
            .fromJson(json.decode(await response.stream.bytesToString()));

        if (kDebugMode) {
          print(genmodel);
        }
        return genmodel;
      }
    } on Exception catch (e) {
      print('Error: $e');
    }

    return null;
  }
}
