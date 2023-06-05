// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/model/loginDataModel.dart';
import 'package:task_manager/ui/pages/DashBoard/homeAdmin.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/urls.dart';
import 'package:task_manager/ui/pages/DashBoard/homeClient.dart';
import 'package:task_manager/ui/pages/DashBoard/homeEmployee.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int index = 0;
  final _clientFormKey = GlobalKey<FormState>();
  final _employeeFormKey = GlobalKey<FormState>();
  final _adminFormKey = GlobalKey<FormState>();
  final passwordControllerE = TextEditingController();
  final emailControllerE = TextEditingController();
  final passwordControllerC = TextEditingController();
  final emailControllerC = TextEditingController();
  final passwordControllerA = TextEditingController();
  final emailControllerA = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final deviceWidth = MediaQuery.of(context).size.width;

    final screens = [
      // Client Login Screen
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: deviceHeight * 0.30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/28_generated1.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppTheme.colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.04,
                      ),
                      Text(
                        'Admin Login',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      Form(
                        key: _adminFormKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 25, right: 25, bottom: 8),
                              // Email Text Field for Employee
                              child: buildEmailFormFieldAdmin(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 25, top: 8),
                              // Password Text Field for Employee
                              child: buildPasswordFormFieldAdmin(),
                            ),
                            // Login Button for Employee
                            loginButtonAdmin(deviceHeight)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: deviceHeight * 0.30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/28_generated1.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppTheme.colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.04,
                      ),
                      Text(
                        'Client Login',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      Form(
                        key: _clientFormKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 25, right: 25, bottom: 8),
                              // Email Text Field for Client
                              child: buildEmailFormFieldClient(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 25, top: 8),
                              // Password Text Field for Client
                              child: buildPasswordFormFieldClient(),
                            ),
                            // Login Button for Client
                            loginButtonClient(deviceHeight)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // Employee Login Screen
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: deviceHeight * 0.30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/28_generated1.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppTheme.colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.04,
                      ),
                      Text(
                        'Employee Login',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      Form(
                        key: _employeeFormKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 25, right: 25, bottom: 8),
                              // Email Text Field for Employee
                              child: buildEmailFormFieldEmployee(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 25, top: 8),
                              // Password Text Field for Employee
                              child: buildPasswordFormFieldEmployee(),
                            ),
                            // Login Button for Employee
                            loginButtonEmployee(deviceHeight)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ];
    return Scaffold(
      // Navigation Bar
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
        child: NavigationBar(
          height: deviceHeight * 0.09,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.admin_panel_settings), label: 'Admin'),
            NavigationDestination(icon: Icon(Icons.people), label: 'Client'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Employee'),
          ],
        ),
      ),
      backgroundColor: AppTheme.colors.lightGrey,
      body: screens[index],
    );
  }

  TextFormField buildEmailFormFieldAdmin() {
    return TextFormField(
      controller: emailControllerA,
      decoration: InputDecoration(
        labelText: "Email",
        //hintText: "Email or Username",
        suffixIcon: Icon(Icons.email_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an email';
        }

        final emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
        if (!RegExp(emailRegex).hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordFormFieldAdmin() {
    return TextFormField(
      controller: passwordControllerA,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        //hintText: "Password",
        suffixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null; // Return null if the input is valid
      },
    );
  }

  GestureDetector loginButtonAdmin(double deviceHeight) {
    return GestureDetector(
      onTap: () {
        if (_adminFormKey.currentState!.validate()) {
          loginAdmin();
        }
        //Get.off(() => HomeAdminScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: AppTheme.colors.lightBlue,
          ),
          width: double.infinity,
          height: deviceHeight * 0.07,
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: AppTheme.colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  genModel? genmodel;
  LoginData logindata = LoginData();
  void loginAdmin() async {
    genmodel = await urls.postApiCall( method: '${urls.login}', params: {
      "email": emailControllerA.text,
      "password": passwordControllerA.text,
    }, );
    if (genmodel != null) {
      //print('Status: ${genmodel?.message}');
      Fluttertoast.showToast(msg: genmodel!.message.toString());

      LoginData loginData = LoginData.fromJson(genmodel!.data);
print("LOgin data ${loginData.toJson()}");
      // Store xtoken in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('xtoken', loginData.xtoken ?? '');
      String? storedXToken = prefs.getString('xtoken');
      if (storedXToken != null && storedXToken.isNotEmpty) {
        print('xtoken is stored in SharedPreferences: $storedXToken');
      } else {
        print('xtoken is not available in SharedPreferences');
      }
      if (genmodel?.status == true) {
        Get.off(() => HomeAdminScreen());
      }
    }
  }

  TextFormField buildEmailFormFieldClient() {
    return TextFormField(
      controller: emailControllerC,
      decoration: InputDecoration(
        labelText: "Email",
        //hintText: "Email or Username",
        suffixIcon: Icon(Icons.email_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an email';
        }

        final emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
        if (!RegExp(emailRegex).hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordFormFieldClient() {
    return TextFormField(
      controller: passwordControllerC,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        // hintText: "Password",
        suffixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null; // Return null if the input is valid
      },
    );
  }

  GestureDetector loginButtonClient(double deviceHeight) {
    return GestureDetector(
      onTap: () {
        // if (_clientFormKey.currentState!.validate()) {
        //  loginClient();}
        Get.off(() => HomeClientScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: AppTheme.colors.lightBlue,
          ),
          width: double.infinity,
          height: deviceHeight * 0.07,
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: AppTheme.colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginClient() async {
    genmodel = await urls.postApiCall( method: '${urls.login}', params: {
      "email": emailControllerC.text,
      "password": passwordControllerC.text,
    }, );
    if (genmodel != null) {
      print('Status: ${genmodel?.message}');
      Fluttertoast.showToast(msg: genmodel!.message.toString());
      if (genmodel?.status == true) {
        Get.off(() => HomeAdminScreen());
      }
    }
  }

  TextFormField buildEmailFormFieldEmployee() {
    return TextFormField(
      controller: emailControllerE,
      decoration: InputDecoration(
        labelText: "Email",
        // hintText: "Email or Username",
        suffixIcon: Icon(Icons.email_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an email';
        }

        final emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
        if (!RegExp(emailRegex).hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordFormFieldEmployee() {
    return TextFormField(
      controller: passwordControllerE,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        // hintText: "Password",
        suffixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: AppTheme.colors.black),
          gapPadding: 2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null; // Return null if the input is valid
      },
    );
  }

  GestureDetector loginButtonEmployee(double deviceHeight) {
    return GestureDetector(
      onTap: () {
        // if (_employeeFormKey.currentState!.validate()) {
        //   loginEmployee();
        // }
        Get.off(() => HomeEmployeeScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: AppTheme.colors.lightBlue,
          ),
          width: double.infinity,
          height: deviceHeight * 0.07,
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: AppTheme.colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginEmployee() async {
    genmodel = await urls.postApiCall( method: '${urls.login}', params: {
      "email": emailControllerE.text,
      "password": passwordControllerE.text,
    }, );
    if (genmodel != null) {
      print('Status: ${genmodel?.message}');
      Fluttertoast.showToast(msg: genmodel!.message.toString());
      if (genmodel?.status == true) {
        Get.off(() => HomeAdminScreen());
      }
    }
  }
}
