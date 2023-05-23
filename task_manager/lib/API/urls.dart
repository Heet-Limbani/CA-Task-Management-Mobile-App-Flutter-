import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/ui/models/genModel.dart';

class urls {
  static String baseUrlMain = "https://task.mysyva.net/backend/";
  
  static String login = "${urls.baseUrlMain}Login";

  static Future <genModel?> postApiCall(String method, Map params) async {
    if (kDebugMode) {
      print(method);
      print(params);
    }
    try {
      var request = http.Request('POST', Uri.parse(method));
      request.body = json.encode(params);
      request.headers.addAll({
        'Content-Type': 'application/json',
        //xToken  : webToken
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        genModel genmodel = genModel
            .fromJson(json.decode(await response.stream.bytesToString()));

        if (kDebugMode) {
          print(genmodel);
        }
        return genmodel;
      }
    } 
    on Exception 
    catch (e) {
      print('Error: $e');
    }
  
    return null;
  }
}
