import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/Employee/Profile/profile3.dart';

class SideBarEmployee extends StatefulWidget {
  const SideBarEmployee({super.key});

  @override
  State<SideBarEmployee> createState() => _SideBarEmployeeState();
}

class _SideBarEmployeeState extends State<SideBarEmployee> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  String email = "";
  String img = "";
  String userName = "";
  bool loading = true;
  bool errorOccurred = false;

  void getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        img = Urls.baseUrlMain + Urls.profile + prefs.getString('avatar')!;
        email = prefs.getString('email')!;
        userName = prefs.getString('username')!;
        loading = false; // Set loading to false after data retrieval
      });
    } catch (e) {
      setState(() {
        loading = false; // Set loading to false even in case of error
        errorOccurred = true;
      });
    }
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
                child: loading
                    ? CircularProgressIndicator() // Show loading indicator
                    : errorOccurred
                        ? Icon(Icons.error) // Show error icon
                        : Image(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ),
              ),
            ),
          ),
          ListTile(
            title: Text('Employee'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Get.to(Profile3());
            },
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
}
