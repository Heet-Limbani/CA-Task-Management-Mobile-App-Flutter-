// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/pages/DashBoard/home.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/ui/models/genModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int index = 0;
  final _clientFormKey = GlobalKey<FormState>();
  final _employeeFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final passwordControllerC = TextEditingController();
  final emailControllerC = TextEditingController();
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
                          ))
                    ]),
              ),
            ),
          )
        ],
      )),
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
                          ))
                    ]),
              ),
            ),
          )
        ],
      )),
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
            NavigationDestination(icon: Icon(Icons.people), label: 'Client'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Employee'),
          ],
        ),
      ),
      backgroundColor: AppTheme.colors.lightGrey,
      body: screens[index],
    );
  }
// Various methods for Client Login Screen

  GestureDetector loginButtonClient(double deviceHeight) {
    return GestureDetector(
      onTap: () {
        loginClient();
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

  //  Future<genModel?> genmodel = urls.postApiCall('${urls.baseUrlMain}Login', {
  //     "email": emailControllerC.text,
  //     "password": passwordControllerC.text,
  //     }
  //   );

  genModel? genmodel;
  void loginClient() async {
    genmodel = await urls.postApiCall('${urls.login}', {
      "email": emailControllerC.text,
      "password": passwordControllerC.text,
    });
    if (genmodel != null) {
      print('Status: ${genmodel?.message}');
       Fluttertoast.showToast(msg: genmodel!.message.toString());
      if (genmodel?.status == true) {
        Get.off(() => HomeScreen());
      }
    }
  }

  // void loginClient() async {
  //   try {
  //     var request = http.Request(
  //         'POST', Uri.parse('${urls.baseUrlMain}Login' ));

  //     request.body = json.encode({
  //       "email": emailControllerC.text,
  //       "password": passwordControllerC.text,
  //     });
  //     //request.headers.addAll({  'Content-Type': 'application/json',});
  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       //  print(await response.stream.bytesToString());
  //       genModel? genmodel = genModel
  //           .fromJson(json.decode(await response.stream.bytesToString()));
  //      Fluttertoast.showToast(msg: genmodel.message.toString());
  //       print('Status: ${genmodel.message}');
  //       if (genmodel.status == true) {
  //         Get.off(() => HomeScreen());
  //       }
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  TextFormField buildPasswordFormFieldClient() {
    return TextFormField(
      controller: passwordControllerC,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
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
    );
  }

  TextFormField buildEmailFormFieldClient() {
    return TextFormField(
      controller: emailControllerC,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email or Username",
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
    );
  }

// Various methods for Employee Login Screen
  GestureDetector loginButtonEmployee(double deviceHeight) {
    return GestureDetector(
      onTap: () {
         Get.off(() => HomeScreen());
        //loginEmployee();
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

  // void loginEmployee() async {
  //   genmodel = await urls.postApiCall('${urls.login}', {
  //     "email": emailController.text,
  //     "password": passwordController.text,
  //   });
  //   if (genmodel != null) {
  //     print('Status: ${genmodel?.message}');
  //      Fluttertoast.showToast(msg: genmodel!.message.toString());
  //     if (genmodel?.status == true) {
  //       Get.off(() => HomeScreen());
  //     }
  //   }
  // }

  // void login() async {
  //   try {
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse('https://task.mysyva.net/backend/Login'));
  //     request.fields.addAll({
  //       'email': emailController.text,
  //       'password': passwordController.text,
  //       'token': ''
  //     });

  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //       // Successful login
  //       Get.off(() => HomeScreen());
  //     } else {
  //       // Login failed
  //       print(response.reasonPhrase);
  //       // Display an error message to the user
  //       showDialog(
  //         context: context, // Replace `context` with your actual context
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text('Login Failed'),
  //             content: Text('Incorrect email or password. Please try again.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle other exceptions, e.g., display a generic error message
  //   }
  // }

  TextFormField buildPasswordFormFieldEmployee() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
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
    );
  }

  TextFormField buildEmailFormFieldEmployee() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email or Username",
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
    );
  }
}
