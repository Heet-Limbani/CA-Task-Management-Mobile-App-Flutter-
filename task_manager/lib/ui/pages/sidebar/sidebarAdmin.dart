import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/pages/Activity_Log/activity_log.dart';
import 'package:task_manager/ui/pages/Appointment/appointment_list.dart';
import 'package:task_manager/ui/pages/ClientManualPayment/clientManualPayment.dart';
import 'package:task_manager/ui/pages/Client_Data/client_data.dart';
import 'package:task_manager/ui/pages/Client_Password/client_password.dart';
import 'package:task_manager/ui/pages/Company%20View/company1.dart';
import 'package:task_manager/ui/pages/DashBoard/taskOnBoard.dart';
import 'package:task_manager/ui/pages/Employee_Leave/employee_leave.dart';
import 'package:task_manager/ui/pages/File_Manager/fileManager.dart';
import 'package:task_manager/ui/pages/Holiday/holiday.dart';
import 'package:task_manager/ui/pages/Invoice/customInvoice.dart';
import 'package:task_manager/ui/pages/Invoice/invoice.dart';
import 'package:task_manager/ui/pages/Password/password_manager.dart';
import 'package:task_manager/ui/pages/Receipt/receipt.dart';
import 'package:task_manager/ui/pages/Reports/due_report.dart';
import 'package:task_manager/ui/pages/Reports/gst_report.dart';
import 'package:task_manager/ui/pages/Reports/performance_report.dart';
import 'package:task_manager/ui/pages/Setting/notificationConfig.dart';
import 'package:task_manager/ui/pages/Setting/expenses.dart';
import 'package:task_manager/ui/pages/Setting/msgConfig.dart';
import 'package:task_manager/ui/pages/Task/addTask.dart';
import 'package:task_manager/ui/pages/Task/taskReport.dart';
import 'package:task_manager/ui/pages/Users/employee.dart';
import 'package:task_manager/ui/pages/DashBoard/homeAdmin.dart';
import 'package:task_manager/ui/pages/Profile/profile1.dart';
import '../../../API/model/loginDataModel.dart';
import '../Admin_Leave/admin_leave.dart';
import '../Client_Login/client_login.dart';
import '../Department/department.dart';
import '../Employee_Login/employee_login.dart';
import '../Reports/attendance_log.dart';
import '../Reports/attendance_report.dart';
import '../Setting/payment_method.dart';
import '../Company/company.dart';
import '../Users/client.dart';
import 'package:task_manager/ui/pages/Notification/notification1.dart';

class SideBarAdmin extends StatelessWidget {
  SideBarAdmin({Key? key}) : super(key: key);
  final String email = Urls.profileEmail;
  final String userName = Urls.profileUserName;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User account details
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 154, 207, 250),
                Color.fromARGB(255, 4, 77, 204),
              ],
            )),
            accountName: Text(
              userName,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: ClipOval(
                  child: Image(
                image: AssetImage(
                  'assets/images/task_manager.png',
                ),
                fit: BoxFit.cover,
              )),
            ),
          ),
          // Various options
          ListTile(
            title: Text('Admin'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Get.to(profile1());
            },
          ),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Get.offAll(HomeAdminScreen());
              }),
          ExpansionTile(
            title: Text('Users'),
            leading: Icon(Icons.people),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Employee'),
                onTap: () {
                  Get.to(Employee());
                },
              ),
              ListTile(
                title: Text('Client'),
                onTap: () {
                  Get.to(Client());
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Payment Method'),
                onTap: () {
                  Get.to(Payment_Method());
                },
              ),
              ListTile(
                title: Text('Expensen'),
                onTap: () {
                  Get.to(Expenses());
                },
              ),
               ListTile(
                title: Text('Configure SMS'),
                onTap: () {
                  Get.to(Sent());
                },
              ),
              ListTile(
                title: Text('Configure Notification'),
                onTap: () {
                  Get.to(NotificationConfig());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text('Company'),
            onTap: () {
              Get.to(Company());
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Client Manual Payment'),
            onTap: () {
              Get.to(ClientManualPayment());
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt_outlined),
            title: Text('Company View'),
            onTap: () {
              Get.to(Company1());
            },
          ),
          ListTile(
            leading: Icon(Icons.workspaces),
            title: Text('Department'),
            onTap: () {
              Get.to(Department());
            },
          ),
          ExpansionTile(
            title: Text('Task'),
            leading: Icon(Icons.pending_actions),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Add Task'),
                onTap: () {
                  Get.to(AddTask());
                },
              ),
              ListTile(
                title: Text('Task On Board'),
                onTap: () {
                  Get.to(TaskOnBoard());
                },
              ),
              ListTile(
                title: Text('Task Report'),
                onTap: () {
                  Get.to(()=>TaskReport());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {
              Get.to(Notification1());
            },
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('File Manager'),
            onTap: () {
              Get.to(FileManager());
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Receipt'),
            onTap: () {
              Get.to(Receipt());
            },
          ),
          ExpansionTile(
            title: Text('Invoice'),
            leading: Icon(Icons.inventory_outlined),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Invoice List'),
                onTap: () {
                  Get.to(Invoice());
                },
              ),
              ListTile(
                title: Text('Custom Invoice List'),
                onTap: () {
                  Get.to(CustomInvoice());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Password Manager'),
            onTap: () {
              Get.to(Password_Manager());
            },
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Activity Log'),
            onTap: () {
              Get.to(Activity_Log());
            },
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Client Password'),
            onTap: () {
              Get.to(Client_Password());
            },
          ),
          ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Client Data'),
            onTap: () {
              Get.to(Client_Data());
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Appointment'),
            onTap: () {
              Get.to(Appointment_List());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Employee Leave'),
            onTap: () {
              Get.to(Employee_Leave());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Admin Leave'),
            onTap: () {
              Get.to(Admin_Leave());
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts_sharp),
            title: Text('Manage Holiday'),
            onTap: () {
              Get.to(Holiday());
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Employee Login'),
            onTap: () {
              Get.to(Employee_Login());
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Client Login'),
            onTap: () {
              Get.to(Client_Login());
            },
          ),
          ExpansionTile(
            title: Text('Reports'),
            leading: Icon(Icons.receipt_long),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Performance Report'),
                onTap: () {
                  Get.to(Performance_Report());
                },
              ),
              ListTile(
                title: Text('Due Report'),
                onTap: () {
                  Get.to(Due_Report());
                },
              ),
              ListTile(
                title: Text('Attendance Log'),
                onTap: () {
                  Get.to(Attendance_Log());
                },
              ),
              ListTile(
                title: Text('Attendance Report'),
                onTap: () {
                  Get.to(Attendance_Report());
                },
              ),
              ListTile(
                title: Text('GST Report'),
                onTap: () {
                  Get.to(Gst_Report());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(MyApp.KEYLOGIN, false);

              Get.offAll(MyApp());
            },
          ),
        ],
      ),
    );
  }

  Future<LoginData?> retrieveLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final loginDataString = prefs.getString('loginData');
    if (loginDataString != null) {
      final loginData = LoginData.fromJson(jsonDecode(loginDataString));
      return loginData;
    } else {
      return null;
    }
  }
}
