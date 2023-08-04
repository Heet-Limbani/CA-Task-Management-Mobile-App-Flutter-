import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/Admin%20DataModel/loginDataModel.dart';
import 'package:task_manager/main.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/Urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int index = 0;
  final _adminFormKey = GlobalKey<FormState>();
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
                        'Login',
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
    ];
    return Scaffold(
      // Navigation Bar
      // bottomNavigationBar: NavigationBarTheme(
      //   data: NavigationBarThemeData(
      //       labelTextStyle: MaterialStateProperty.all(
      //           TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
      //   child: NavigationBar(
      //     height: deviceHeight * 0.09,
      //     selectedIndex: index,
      //     onDestinationSelected: (index) => setState(() {
      //       this.index = index;
      //     }),
      //     destinations: const [
      //       NavigationDestination(
      //           icon: Icon(Icons.admin_panel_settings), label: 'Admin'),
      //       NavigationDestination(icon: Icon(Icons.people), label: 'Client'),
      //       NavigationDestination(icon: Icon(Icons.person), label: 'Employee'),
      //     ],
      //   ),
      // ),
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
        if (value.length < 3) {
          return 'Password must be at least 3 characters long';
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
    try {
      genmodel = await Urls.postApiCall(
        method: '${Urls.login}',
        params: {
          "email": emailControllerA.text,
          "password": passwordControllerA.text,
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    if (genmodel != null) {
      LoginData loginData = LoginData.fromJson(genmodel!.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('xtoken', loginData.xtoken ?? '');
      prefs.setString('email', loginData.email ?? '');
      prefs.setString('username', loginData.username ?? '');
      prefs.setString('type', loginData.type ?? '');
      prefs.setString('contactnumber', loginData.contactNumber ?? '');
      prefs.setString('firstname', loginData.firstName ?? '');
      prefs.setString('lastname', loginData.lastName ?? '');
      prefs.setString('password', loginData.password ?? '');
      prefs.setString('sessiontime', loginData.sessionTime ?? '');
      prefs.setString('avatar', loginData.avatar ?? '');

      if (genmodel?.status == true) {
        Fluttertoast.showToast(msg: genmodel!.message.toString());
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(MyApp.KEYLOGIN, true);
        Get.offAll(MyApp());
      }
    } else {
      Fluttertoast.showToast(msg: 'null genmodel');
    }
  }
}
