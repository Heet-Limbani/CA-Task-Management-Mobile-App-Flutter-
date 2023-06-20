import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/model/genModel.dart';

class Urls {
  static String baseUrlMain = "https://task.mysyva.net/backend/";

  static String login = "${Urls.baseUrlMain}Login";
  static String adminDashBoard = "${Urls.baseUrlMain}AdminDashboard";
  static String clientLog = "${Urls.baseUrlMain}ClientLogData_Dashboard";
  static String clientLogAdd = "${Urls.baseUrlMain}AddClientLog";
  static String paymentMethod="${Urls.baseUrlMain}PaymentMethod";
  static String getUsers = "${Urls.baseUrlMain}GetUsers";
  static String addPaymentMethod="${Urls.baseUrlMain}AddPaymentMethod";
  static String editPaymentMethod="${Urls.baseUrlMain}EditPaymentMethod";
  static String deletePaymentMethod="${Urls.baseUrlMain}DeletePaymentMethod";

  static String addEmployee = "${Urls.baseUrlMain}Add_Employee";
  static String deleteEmployee = "${Urls.baseUrlMain}Delete_Employee";
  static String updateEmployeePassword =
      "${Urls.baseUrlMain}EmployeeResetPassword";
  static String editEmployee = "${Urls.baseUrlMain}Edit_Employee";
  static String deleteClient = "${Urls.baseUrlMain}Delete_Client";
  static String updateClientPassword = "${Urls.baseUrlMain}ClientResetPassword";
  static String editClient = "${Urls.baseUrlMain}Edit_Client";
  static String addClient = "${Urls.baseUrlMain}Add_Client";
  static String expences = "${Urls.baseUrlMain}Expences";
  static String editExpences = "${Urls.baseUrlMain}EditExpences";
  static String deleteExpences = "${Urls.baseUrlMain}DeleteExpences";
  static String addExpences = "${Urls.baseUrlMain}AddExpences";



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
