import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/Admin/Activity_Log/activityLog.dart';
import 'package:task_manager/ui/Admin/Admin_Leave/adminLeave.dart';
import 'package:task_manager/ui/Admin/Appointment/appointment.dart';
import 'package:task_manager/ui/Admin/ClientManualPayment/clientManualPayment.dart';
import 'package:task_manager/ui/Admin/Client_Data/clientData.dart';
import 'package:task_manager/ui/Admin/Client_Login/clientLog.dart';
import 'package:task_manager/ui/Admin/Client_Password/clientPassword.dart';
import 'package:task_manager/ui/Admin/Company%20View/company1.dart';
import 'package:task_manager/ui/Admin/DashBoard/OnBoardTask/taskOnBoard.dart';
import 'package:task_manager/ui/Admin/Employee_Leave/employeeLeave.dart';
import 'package:task_manager/ui/Admin/Employee_Login/employeeLog.dart';
import 'package:task_manager/ui/Admin/File_Manager/fileManager.dart';
import 'package:task_manager/ui/Admin/Holiday/holidayView.dart';
import 'package:task_manager/ui/Admin/Invoice/customInvoice.dart';
import 'package:task_manager/ui/Admin/Invoice/invoice.dart';
import 'package:task_manager/ui/Admin/Password/vault.dart';
import 'package:task_manager/ui/Admin/Profile/profile2.dart';
import 'package:task_manager/ui/Admin/Receipt/receipt.dart';
import 'package:task_manager/ui/Admin/Reports/attendanceLog.dart';
import 'package:task_manager/ui/Admin/Reports/attendanceReport.dart';
import 'package:task_manager/ui/Admin/Reports/dueReport.dart';
import 'package:task_manager/ui/Admin/Reports/gst_report.dart';
import 'package:task_manager/ui/Admin/Reports/performanceReport.dart';
import 'package:task_manager/ui/Admin/Setting/notificationConfig.dart';
import 'package:task_manager/ui/Admin/Setting/expenses.dart';
import 'package:task_manager/ui/Admin/Setting/msgConfig.dart';
import 'package:task_manager/ui/Admin/Task/addTask.dart';
import 'package:task_manager/ui/Admin/Task/taskReport.dart';
import 'package:task_manager/ui/Admin/Users/employee.dart';
import 'package:task_manager/ui/Admin/DashBoard/homeAdmin.dart';
import '../../../API/AdminDataModel/loginDataModel.dart';
import '../Department/department.dart';
import '../Setting/payment_method.dart';
import '../Company/company.dart';
import '../Users/client.dart';
import 'package:task_manager/ui/Admin/Notification/notification1.dart';


class SideBarAdmin extends StatefulWidget {
  SideBarAdmin({Key? key}) : super(key: key);

  @override
  State<SideBarAdmin> createState() => _SideBarAdminState();
}
String img = "";
class _SideBarAdminState extends State<SideBarAdmin> {
   String email = "";

   String userName = "";

   @override
  void initState() {
    super.initState();
    getUser();
  }

void getUser() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        img = Urls.baseUrlMain + Urls.profile + prefs.getString('avatar')!;
        email = prefs.getString('email')!;
        userName = prefs.getString('username')!;
      });
    });
  }

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
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
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
              Get.to(Profile2());
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
                  Get.to(() => TaskReport());
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
            title: Text('Vault Manager'),
            onTap: () {
              Get.to(Vault());
            },
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Activity Log'),
            onTap: () {
              Get.to(ActivityLog());
            },
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Client Password'),
            onTap: () {
              Get.to(ClientPassword());
            },
          ),
          ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Client Data'),
            onTap: () {
              Get.to(ClientData());
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Appointment'),
            onTap: () {
              Get.to(Appointment());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Employee Leave'),
            onTap: () {
              Get.to(EmployeeLeave());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Admin Leave'),
            onTap: () {
              Get.to(AdminLeave());
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts_sharp),
            title: Text('Manage Holiday'),
            onTap: () {
              Get.to(HolidayView());
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Employee Login'),
            onTap: () {
              Get.to(EmployeeLog());
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Client Login'),
            onTap: () {
              Get.to(ClientLog());
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
                  Get.to(PerformanceReport());
                },
              ),
              ListTile(
                title: Text('Due Report'),
                onTap: () {
                  Get.to(DueReport());
                },
              ),
              ListTile(
                title: Text('Attendance Log'),
                onTap: () {
                  Get.to(AttendanceLog());
                },
              ),
              ListTile(
                title: Text('Attendance Report'),
                onTap: () {
                  Get.to(AttendanceReport());
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
