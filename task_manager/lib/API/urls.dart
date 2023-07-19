import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/model/genModel.dart';

class Urls {
  static String baseUrlMain = "https://task.mysyva.net/backend/";
  static String manualPayment = "assets/client_receipt/";

  static String login = "${Urls.baseUrlMain}Login";
  static String adminDashBoard = "${Urls.baseUrlMain}AdminDashboard";
  static String clientLog = "${Urls.baseUrlMain}ClientLogData_Dashboard";
  static String clientLogAdd = "${Urls.baseUrlMain}AddClientLog";
  static String paymentMethod = "${Urls.baseUrlMain}PaymentMethod";
  static String getUsers = "${Urls.baseUrlMain}GetUsers";
  static String addPaymentMethod = "${Urls.baseUrlMain}AddPaymentMethod";
  static String editPaymentMethod = "${Urls.baseUrlMain}EditPaymentMethod";
  static String deletePaymentMethod = "${Urls.baseUrlMain}DeletePaymentMethod";
  static String configurationNotification =
      "${Urls.baseUrlMain}NotificationConfig";
  static String configurationNotificationEdit =
      "${Urls.baseUrlMain}EditNotificationConfig";
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
  static String clientViewLogDetails = "${Urls.baseUrlMain}ClientLogData";
  static String clientViewLogDetailsEdit = "${Urls.baseUrlMain}EditClientLog";
  static String clientViewLoginDetails = "${Urls.baseUrlMain}ClientLoginData";
  static String clientViewTicketDetails =
      "${Urls.baseUrlMain}LoadClientTicketDetail";
  static String clientViewInvoiceDetails = "${Urls.baseUrlMain}LoadInvoiceList";
  static String taskViewTaskDetails = "${Urls.baseUrlMain}ViewTask";
  static String loadTaskOnboard = "${Urls.baseUrlMain}LoadTaskOnboard";
  static String loadTask = "${Urls.baseUrlMain}LoadTask";
  static String loadTaskUnPaid = "${Urls.baseUrlMain}unpaid_task_board";
  static String company = "${Urls.baseUrlMain}Company";
  static String addCompany = "${Urls.baseUrlMain}AddCompany";
  static String deleteCompany = "${Urls.baseUrlMain}DeleteCompany";
  static String editCompany = "${Urls.baseUrlMain}EditCompany";
  static String companyLog = "${Urls.baseUrlMain}LoadLogDetail";
  static String companyTicket = "${Urls.baseUrlMain}LoadCompanyTicketDetail";
  static String companyFile = "${Urls.baseUrlMain}LoadCompanyFileDetail";
  static String companyPermission =
      "${Urls.baseUrlMain}LoadCompanyEmpPermission";
  static String companyGroup = "${Urls.baseUrlMain}ManageCompanyGroup";
  static String deleteCompanyGroup = "${Urls.baseUrlMain}DeleteCompanyGroup";
  static String manageCompanyGroup = "${Urls.baseUrlMain}ManageCompanyGroup";
  static String editCompanyGroup = "${Urls.baseUrlMain}EditCompanyGroup";
  static String manageCompanyComment = "${Urls.baseUrlMain}ManageComments";
  static String editCompanyComment = "${Urls.baseUrlMain}EditComments";
  static String clientManualPayment =
      "${Urls.baseUrlMain}Client_Manual_Payment";
  static String department = "${Urls.baseUrlMain}Department";
  static String editDepartment = "${Urls.baseUrlMain}EditDepartment";
  static String addDepartment = "${Urls.baseUrlMain}AddDepartment";
  static String deleteDepartment = "${Urls.baseUrlMain}DeleteDepartment";
  static String addTask = "${Urls.baseUrlMain}AddTask";
  static String fileForTask = "${Urls.baseUrlMain}GetAllFileforTask";
  static String addFileForTask = "${Urls.baseUrlMain}InsertDataintoFile";
  static String getFile = "${Urls.baseUrlMain}Get_File";
  static String editFile = "${Urls.baseUrlMain}edit_file_manage";
  static String dispatchFile = "${Urls.baseUrlMain}update_dispatech_file";
  static String viewDispatchFile = "${Urls.baseUrlMain}view_dispatch_file";
  static String manageLocation = "${Urls.baseUrlMain}getdata_file_location";
  static String editLocation = "${Urls.baseUrlMain}edit_location";
  static String deleteLocation = "${Urls.baseUrlMain}delete_location";
  static String defaultLocation = "${Urls.baseUrlMain}SetDefault_location";
  static String addLocation = "${Urls.baseUrlMain}add_location";
  static String addFile = "${Urls.baseUrlMain}Add_File";

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
    profilePassword = password ?? "";
    String? sessionTime = prefs.getString('sessiontime');
    profileSessionTime = sessionTime ?? "";
    String? avatar = prefs.getString('avatar');
    profileAvatar = avatar ?? "";

    if (xtoken != null && xtoken.isNotEmpty) {
      return {'Xtoken': xtoken};
    } else {
      return {}; // Set xToken to an empty map if xtoken is not available
    }
  }

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
