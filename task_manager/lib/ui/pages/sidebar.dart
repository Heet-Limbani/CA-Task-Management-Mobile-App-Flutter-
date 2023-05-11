// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Theme/app_theme.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/ui/pages/home.dart';
import 'package:task_manager/ui/pages/profile.dart';
import 'package:task_manager/ui/pages/profile1/pages/profile_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap:  () {
                Get.off(ProfilePage());
              },
          ),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Get.offAll(HomeScreen());
              }),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Users'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text('Company'),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Client Manual Payment'),
          ),
          ListTile(
            leading: Icon(Icons.workspaces),
            title: Text('Department'),
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Task'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('File Manager'),
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Receipt'),
          ),
          ListTile(
            leading: Icon(Icons.receipt_long_outlined),
            title: Text('Invoice'),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Password Manager'),
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Activity Log'),
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Appointment'),
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text('Employee Leave'),
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts_sharp),
            title: Text('Manage Holiday'),
          ),
          ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text('Employee Login'),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Client Login'),
          ),
          ListTile(
            leading: Icon(Icons.file_present),
            title: Text('Reports'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
