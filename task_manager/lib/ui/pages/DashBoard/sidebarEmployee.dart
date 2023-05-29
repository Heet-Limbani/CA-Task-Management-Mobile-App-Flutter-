import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager/ui/pages/DashBoard/login_screen.dart';

class SideBarEmployee extends StatelessWidget {
  const SideBarEmployee({super.key});

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
