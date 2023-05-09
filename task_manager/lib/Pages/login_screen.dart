// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task_manager/ui/pages/home.dart';

import 'package:task_manager/Theme/app_theme.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int index = 0;
  final _clientFormKey = GlobalKey<FormState>();
  final _employeeFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final screens = [
      SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: deviceHeight * 0.30,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/task_manager.png',
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
                                child: buildEmailFormFieldClient(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25, top: 8),
                                child: buildPasswordFormFieldClient(),
                              ),
                              loginButtonClient(deviceHeight)
                            ],
                          ))
                    ]),
              ),
            ),
          )
        ],
      )),
      SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: deviceHeight * 0.30,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/task_manager.png',
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
                                child: buildEmailFormFieldEmployee(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25, top: 8),
                                child: buildPasswordFormFieldEmployee(),
                              ),
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

  GestureDetector loginButtonClient(double deviceHeight) {
    return GestureDetector(
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
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
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormFieldClient() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
        suffixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 2),
      ),
    );
  }

  TextFormField buildEmailFormFieldClient() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email or Username",
        suffixIcon: Icon(Icons.email_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 2),
      ),
    );
  }

  GestureDetector loginButtonEmployee(double deviceHeight) {
    return GestureDetector(
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
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
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormFieldEmployee() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
        suffixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 2),
      ),
    );
  }

  TextFormField buildEmailFormFieldEmployee() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email or Username",
        suffixIcon: Icon(Icons.email_rounded),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppTheme.colors.black),
            gapPadding: 2),
      ),
    );
  }
}
