import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/pages/Activity_Log/activity_log.dart';
import 'package:task_manager/ui/pages/Appointment/appointment_list.dart';
import 'package:task_manager/ui/pages/ClientManualPayment/manual_payment.dart';
import 'package:task_manager/ui/pages/Client_Data/client_data.dart';
import 'package:task_manager/ui/pages/Client_Password/client_password.dart';
import 'package:task_manager/ui/pages/DashBoard/login_screen.dart';
import 'package:task_manager/ui/pages/Employee_Leave/employee_leave.dart';
import 'package:task_manager/ui/pages/File_Manager/file_manager.dart';
import 'package:task_manager/ui/pages/Holiday/holiday.dart';
import 'package:task_manager/ui/pages/Invoice/custom_Invoice.dart';
import 'package:task_manager/ui/pages/Invoice/invoice.dart';
import 'package:task_manager/ui/pages/Password/password_manager.dart';
import 'package:task_manager/ui/pages/Receipt/receipt.dart';
import 'package:task_manager/ui/pages/Reports/due_report.dart';
import 'package:task_manager/ui/pages/Reports/gst_report.dart';
import 'package:task_manager/ui/pages/Reports/performance_report.dart';
import 'package:task_manager/ui/pages/Setting/configuration.dart';
import 'package:task_manager/ui/pages/Setting/expenses.dart';
import 'package:task_manager/ui/pages/Setting/sent.dart';
import 'package:task_manager/ui/pages/Task/add_task.dart';
import 'package:task_manager/ui/pages/Task/task_report.dart';
import 'package:task_manager/ui/pages/Users/employee.dart';
import 'package:task_manager/ui/pages/DashBoard/home.dart';
import 'package:task_manager/ui/pages/Profile/profile1.dart';
import '../Admin_Leave/admin_leave.dart';
import '../Client_Login/client_login.dart';
import '../Company/company_view.dart';
import '../Department/department.dart';
import '../Employee_Login/employee_login.dart';
import '../Reports/attendance_log.dart';
import '../Reports/attendance_report.dart';
import '../Setting/payment_method.dart';
import '../Company/company.dart';
import '../Task/task_on_board.dart';
import '../Users/client.dart';
import 'package:task_manager/ui/pages/Notification/notification1.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

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
              "Admin",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              "admin@admin.com",
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
              Get.off(profile1());
            },
          ),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Get.offAll(HomeScreen());
              }),
          ExpansionTile(
            title: Text('Users'),
            leading: Icon(Icons.people),
            childrenPadding: EdgeInsets.only(left: 60),
            children: [
              ListTile(
                title: Text('Employee'),
                onTap: () {
                  Get.off(Employee());
                },
              ),
              ListTile(
                title: Text('Client'),
                onTap: () {
                  Get.off(Client());
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
                  Get.off(Payment_Method());
                },
              ),
              ListTile(
                title: Text('Expensen'),
                onTap: () {
                  Get.off(Expenses());
                },
              ),
              ListTile(
                title: Text('Configuration Notification'),
                onTap: () {
                  Get.off(Configuration());
                },
              ),
              ListTile(
                title: Text('Send Notification'),
                onTap: () {
                  Get.off(Sent());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text('Company'),
            onTap: () {
              Get.off(Company());
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Client Manual Payment'),
            onTap: () {
              Get.off(Manual_Payment());
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt_outlined),
            title: Text('Company View'),
            onTap: () {
              Get.off(Company_View());
            },
          ),
          ListTile(
            leading: Icon(Icons.workspaces),
            title: Text('Department'),
            onTap: () {
              Get.off(Department());
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
                  Get.off(Add_Task());
                },
              ),
              ListTile(
                title: Text('Task On Board'),
                onTap: () {
                  Get.off(Task_On_Board());
                },
              ),
              ListTile(
                title: Text('Task Report'),
                onTap: () {
                  Get.off(Task_Report());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {
              Get.off(Notification1());
            },
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('File Manager'),
            onTap: () {
              Get.off(File_Manager());
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Receipt'),
            onTap: () {
              Get.off(Receipt());
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
                  Get.off(Invoice());
                },
              ),
              ListTile(
                title: Text('Custom Invoice List'),
                onTap: () {
                  Get.off(custom_invoice());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Password Manager'),
            onTap: () {
              Get.off(Password_Manager());
            },
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Activity Log'),
            onTap: () {
              Get.off(Activity_Log());
            },
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Client Password'),
            onTap: () {
              Get.off(Client_Password());
            },
          ),
          ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Client Data'),
            onTap: () {
              Get.off(Client_Data());
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Appointment'),
            onTap: () {
              Get.off(Appointment_List());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Employee Leave'),
            onTap: () {
              Get.off(Employee_Leave());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Admin Leave'),
            onTap: () {
              Get.off(Admin_Leave());
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts_sharp),
            title: Text('Manage Holiday'),
            onTap: () {
              Get.off(Holiday());
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text('Employee Login'),
            onTap: () {
              Get.off(Employee_Login());
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Client Login'),
            onTap: () {
              Get.off(Client_Login());
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
                  Get.off(Performance_Report());
                },
              ),
              ListTile(
                title: Text('Due Report'),
                onTap: () {
                  Get.off(Due_Report());
                },
              ),
              ListTile(
                title: Text('Attendance Log'),
                onTap: () {
                  Get.off(Attendance_Log());
                },
              ),
              ListTile(
                title: Text('Attendance Report'),
                onTap: () {
                  Get.off(Attendance_Report());
                },
              ),
              ListTile(
                title: Text('GST Report'),
                onTap: () {
                  Get.off(Gst_Report());
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.off(LoginScreen());
            },
          ),
          ListTile(
            title: Text('Client '),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text('Company Details'),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Client Manual Payment'),
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Ticket'),
          ),
          ListTile(
            leading: Icon(Icons.inventory_outlined),
            title: Text('Invoice '),
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Appointment'),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Admin Chat'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.off(LoginScreen());
            },
          ),
          ListTile(
            title: Text('Employee'),
          ),
            ListTile(
               leading: Icon(Icons.task),
            title: Text('Company Task'),
          ),
           ListTile(
               leading: Icon(Icons.work_outline),
            title: Text('Company'),
          ),
          ListTile(
               leading: Icon(Icons.list),
            title: Text('Task List'),
          ),
           ListTile(
               leading: Icon(Icons.receipt),
            title: Text('Leave Application'),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Admin Chat'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.off(LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
