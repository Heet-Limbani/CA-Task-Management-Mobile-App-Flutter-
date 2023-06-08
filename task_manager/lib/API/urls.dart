import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/model/genModel.dart';

class urls {
  static String baseUrlMain = "https://task.mysyva.net/backend/";

  static String login = "${urls.baseUrlMain}Login";
  static String adminDashBoard = "${urls.baseUrlMain}AdminDashboard";
  static String clientLog = "${urls.baseUrlMain}ClientLogData_Dashboard";
  static String clientLogAdd = "${urls.baseUrlMain}AddClientLog";
  static String getUsers = "${urls.baseUrlMain}GetUsers";
  static String profileEmail = "";
  static String profileUserName = "";
  static String profileType = "";
  static String profileContactNumber = "";
  static String profileFirstName = "";
  static String profileLastName = "";
  static String profilePassword = "";
  static String profileSessionTime = "";
  static String profileAvatar = "";
  static String adminType = "0";
  static String employeeType = "1";
  static String clientType = "2";


  static Future<Map<String, String>> getXTokenHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? xtoken = prefs.getString('xtoken');
    String? email = prefs.getString('email');
    profileEmail = email ?? "";
    String? userName = prefs.getString('username');
    profileUserName = userName ?? "";
    String? type = prefs.getString('type');
    profileType = type ?? "";
    String? contactNumber = prefs.getString('contactnumber');
    profileContactNumber = contactNumber ?? "";
    String? firstName = prefs.getString('firstname');
    profileFirstName = firstName ?? "";
    String? lastName = prefs.getString('lastname');
    profileLastName = lastName ?? "";
     String? password = prefs.getString('password');
    profilePassword = password ?? "" ;
     String? sessionTime = prefs.getString('sessiontime');
    profileSessionTime = sessionTime ?? "" ;
     String? avatar = prefs.getString('avatar');
    profileAvatar = avatar ?? "" ;

    if (xtoken != null && xtoken.isNotEmpty) {
      return {'Xtoken': xtoken};
    } else {
      return {}; // Set xToken to an empty map if xtoken is not available
    }
  }
//aa corect che ?
  //  static Map<String, String> xToken = {
  //   'Xtoken':
  //       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Im1va3NoZXMiLCJwYXNzd29yZCI6IiQyYSQxMiRRem1TZkFZalhGR0E0RzZWREdZblRPM2dXM21xdEJJWnlYM3VhRUNyUW12WGVSN1I0QVNOYSJ9.N9AFKPmku7qScJaRwIBMsiOIyr6Cx6Bfjf_n2Q05Df4',
  // };

  static Future<genModel?> postApiCall({
    required String method,
    Map<String, dynamic>? params = const {},
  }) async {
    if (kDebugMode) {
      print(method);
      print(params);
    }
    try {
      var request = http.Request('POST', Uri.parse(method));
      request.body = json.encode(params);
      getXTokenHeader().then((value) {
        request.headers.addAll(value);
      });
      //am thse ok to sir aa na ma

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
