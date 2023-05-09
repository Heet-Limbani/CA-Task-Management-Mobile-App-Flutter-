import 'package:flutter/material.dart';
import 'package:task_manager/Pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      home: LoginScreen(),
    );
  }
}

// main file of the ui branch 
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return MaterialApp(
//         title: 'Task Management',
//         debugShowCheckedModeBanner: false,
//         theme: AppColors.getTheme,
//         initialRoute: Routes.onBoarding,
//         onGenerateRoute: RouterGenerator.generateRoutes,
//       );
//     });
//   }
// }