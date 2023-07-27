import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/ui/Admin/DashBoard/homeAdmin.dart';
import 'package:task_manager/ui/Client/Dashboard/homeClient.dart';
import 'package:task_manager/ui/Employee/Dashboard/homeEmployee.dart';
import 'package:task_manager/ui/Admin/loginPage/login_screen.dart';
import 'package:task_manager/ui/core/res/color.dart';

void main() {
  runApp(GetMaterialApp(
    home: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String KEYLOGIN = 'Login';
  //static String type = Urls.profileType;
  @override
  Widget build(BuildContext context) {
    whereToGo();
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Task Management',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getTheme,
        home: Container(),
      );
    });
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLogin = sharedPref.getBool(KEYLOGIN);
    String? type = sharedPref.getString('type');
    if (isLogin != null && isLogin) {
      if (type == "0") {
        Get.offAll(HomeAdminScreen());
      } else if (type == "1") {
        Get.offAll(HomeEmployeeScreen());
      } else if (type == "2") {
        Get.offAll(HomeClientScreen());
      } else {
        print("Error: Invalid type $type");
      }
    } else {
      Get.offAll(LoginScreen());
    }
  }
}
