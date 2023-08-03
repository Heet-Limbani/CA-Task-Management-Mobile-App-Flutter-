import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:shimmer/shimmer.dart';

class Urls {
  static String baseUrlMain = "https://task.mysyva.net/backend/";
  static String manualPayment = "assets/client_receipt/";
  static String profile = "assets/profile/";

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
  static String invoice = "${Urls.baseUrlMain}Invoice";
  static String receipt = "${Urls.baseUrlMain}Payment";
  static String viewReceipt = "${Urls.baseUrlMain}view_payment";
  static String invoiceMessage = "${Urls.baseUrlMain}generate_pay_message";
  static String companyList = "${Urls.baseUrlMain}Add_Invoice";
  static String addInvoice = "${Urls.baseUrlMain}Add_Invoice";
  static String customInvoice = "${Urls.baseUrlMain}custom_invoice_load";
  static String editCustomInvoice = "${Urls.baseUrlMain}edit_custom_invoice";
  static String deleteCustomInvoice =
      "${Urls.baseUrlMain}delete_custom_invoice";
  static String addCustomInvoice = "${Urls.baseUrlMain}add_custom_invoice";
  static String vault = "${Urls.baseUrlMain}Vault_manager";
  static String vaultDelete = "${Urls.baseUrlMain}Delete_vault";
  static String vaultAdd = "${Urls.baseUrlMain}Add_Vault";
  static String vaultEdit = "${Urls.baseUrlMain}Edit_vault";
  static String userPass = "${Urls.baseUrlMain}check_user_pass";
  static String activityLog = "${Urls.baseUrlMain}ActivityLog";
  static String clientPassword = "${Urls.baseUrlMain}client_password";
  static String clientPasswordEdit = "${Urls.baseUrlMain}edit_client_password";
  static String clientPasswordAdd = "${Urls.baseUrlMain}add_client_password";
  static String clientPasswordDelete =
      "${Urls.baseUrlMain}delete_client_password";
  static String appointment = "${Urls.baseUrlMain}Appointment";
  static String appointmentAccept = "${Urls.baseUrlMain}Accept_Appointment";
  static String appointmentReject = "${Urls.baseUrlMain}Reject_Appointment";
  static String appointmentDelete = "${Urls.baseUrlMain}Delete_Appointment";
  static String employeeLeave = "${Urls.baseUrlMain}get_employee_leave";
  static String employeeLeaveAccept =
      "${Urls.baseUrlMain}employee_leave_accept";
  static String employeeLeaveReject =
      "${Urls.baseUrlMain}employee_leave_reject";
  static String employeeLeaveDelete = "${Urls.baseUrlMain}Delete_Admin_Leave";
  static String adminLeave = "${Urls.baseUrlMain}Admin_Leave";
  static String adminLeaveEdit = "${Urls.baseUrlMain}Edit_Admin_Leave";
  static String holidayView = "${Urls.baseUrlMain}Holiday";
  static String holidayViewEdit = "${Urls.baseUrlMain}EditHoliday";
  static String holidayViewAdd = "${Urls.baseUrlMain}AddHoliday";
  static String holidayViewDelete = "${Urls.baseUrlMain}DeleteHoliday";
  static String employeeLog = "${Urls.baseUrlMain}EmployeeLoginLog";
  static String clientLogin = "${Urls.baseUrlMain}ClientLoginLog";
  static String performanceReport =
      "${Urls.baseUrlMain}Reports/Employee_Performance";
  static String dueReport = "${Urls.baseUrlMain}Reports/DueReport";
  static String attendanceLog = "${Urls.baseUrlMain}Reports/AttendanceLog";
  static String attendanceLogEdit =
      "${Urls.baseUrlMain}Reports/AttendanceLog_Edit";
  static String attendanceLogEditGetData =
      "${Urls.baseUrlMain}Reports/AttendanceLog";
  static String attendanceLogDelete =
      "${Urls.baseUrlMain}Reports/DeleteAttendanceLog";
  static String attendanceReport = "${Urls.baseUrlMain}Reports/Attendance";
  static String editTask = "${Urls.baseUrlMain}UpdateTask";
  static String subtaskEdit = "${Urls.baseUrlMain}EditSubTask";
  static String subtaskDelete = "${Urls.baseUrlMain}DeleteSubTask";
  static String subtaskAdd = "${Urls.baseUrlMain}AddSubTask";
  static String editFileTask = "${Urls.baseUrlMain}Editupload_image";
  static String deleteFileTask = "${Urls.baseUrlMain}DeleteVirtualFile";
  static String taskChargeEdit = "${Urls.baseUrlMain}Edit_TaskExpences";
  static String taskChargeDelete = "${Urls.baseUrlMain}Delete_TaskExpences";
  static String taskChargeAdd = "${Urls.baseUrlMain}Add_TaskExpences";
  static String closeTicket = "${Urls.baseUrlMain}close_ticket";
  static String deleteTask = "${Urls.baseUrlMain}DeleteTask";
  static String taskPayment = "${Urls.baseUrlMain}task_payment";
  static String unAssignTask = "${Urls.baseUrlMain}unassigned_task_board";
  static String messageUser = "${Urls.baseUrlMain}message_the_user";
  


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

class UniversalShimmer extends StatelessWidget {
  final int itemCount;
  final double deviceWidth;
  final double deviceHeight;

  UniversalShimmer({
    required this.itemCount,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount + 2, // Add 2 for the heading and footer rows
        itemBuilder: (context, index) {
          // Check if it's the heading row
          if (index == 0) {
            return _buildHeadingRow();
          }
          // Check if it's the footer row
          else if (index == itemCount + 1) {
            return _buildFooterRow();
          } else {
            // Subtract 1 from index to get the correct data row index
            int rowIndex = index - 1;
            return _buildDataRow(rowIndex);
          }
        },
      ),
    );
  }

  Widget _buildHeadingRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: deviceHeight * 0.02, // Adjust the height as needed
              color: Colors.grey[400],
            ),
          ),
          //SizedBox(width: deviceWidth * 0.02), // Adjust the width as needed
          Expanded(
            flex: 2,
            child: Container(
              height: deviceHeight * 0.02, // Adjust the height as needed
              color: Colors.grey[400],
            ),
          ),
          //SizedBox(width: deviceWidth * 0.02), // Adjust the width as needed
          Expanded(
            flex: 1,
            child: Container(
              height: deviceHeight * 0.02, // Adjust the height as needed
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: deviceHeight * 0.02, // Adjust the height as needed
              color: Colors.grey[400],
            ),
          ),
          // SizedBox(width: deviceWidth * 0.02), // Adjust the width as needed
          Expanded(
            flex: 2,
            child: Container(
              height: deviceHeight * 0.02, // Adjust the height as needed
              color: Colors.grey[400],
            ),
          ),
          // SizedBox(width: deviceWidth * 0.02), // Adjust the width as needed
          Expanded(
            flex: 1,
            child: Container(
              height: deviceHeight * 0.02, // Adjust the height as needed
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(int rowIndex) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: deviceHeight * 0.01, // Adjust the height as needed
              color: Colors.white,
            ),
          ),
          SizedBox(width: deviceWidth * 0.02), // Adjust the width as needed
          Expanded(
            flex: 2,
            child: Container(
              height: deviceHeight * 0.01, // Adjust the height as needed
              color: Colors.white,
            ),
          ),
          SizedBox(width: deviceWidth * 0.02), // Adjust the width as needed
          Expanded(
            flex: 1,
            child: Container(
              height: deviceHeight * 0.01, // Adjust the height as needed
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
