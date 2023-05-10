// import 'package:flutter/material.dart';
// import 'package:task_manager/Pages/login_screen.dart';
// import 'package:sizer/sizer.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Task Management',
//       home: LoginScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/ui/core/res/color.dart';
import 'package:task_manager/ui/core/routes/routes.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Task Management',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getTheme,
        initialRoute: Routes.loginScreen,
        onGenerateRoute: RouterGenerator.generateRoutes,
      );
    });
  }
}
