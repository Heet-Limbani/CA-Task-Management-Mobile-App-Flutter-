// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import 'package:task_manager/ui/pages/Users/addEmployeeForm.dart';
import 'package:task_manager/ui/pages/Users/editEmployeeForm.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager/API/urls.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  String? stringResponse;
  Map? mapResponse;
  Map? dataResponse;
  late double deviceWidth;
  late double deviceHeight;
  TextEditingController searchLogController = TextEditingController();
  List<GetUser> clientType = [];

  @override
  void initState() {
    super.initState();

    getUser();
  }

  void refreshTable() {
    getUser(); // Refresh data
  }

  void getUser() async {
    genModel? genmodel = await urls.postApiCall(
      method: '${urls.getUsers}',
      params: {
        'type': urls.employeeType,
        'limit': "500",
        'search': searchLogController.text.trim(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clientType = data.map((item) => GetUser.fromJson(item)).toList();
        // if (clientType.isEmpty) {
        //   // List is empty
        //   print("No client data available.");
        // } else {
        //   // List has values
        //   print("Client data available.");
        // }
        // for (GetUser clientdata1 in clientType) {
        //   print('UserName: ${clientdata1.username}');
        // }
        setState(() {});
      }
    }
  }

  void deleteUser(String? employeeId) async {
    if (employeeId != null) {
      genModel? genmodel = await urls.postApiCall(
        method: '${urls.deleteEmployee}',
        params: {'id': employeeId},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: "${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        setState(() {});
      }
    }
  }

  void updateUserPassword(String? employeeId, String newPassword) async {
    if (employeeId != null) {
      genModel? genmodel = await urls.postApiCall(
        method: '${urls.updateEmployeePassword}',
        params: {'id': employeeId, 'pass': newPassword},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: " ${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        setState(() {});
      }
    }
  }

  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Employee",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarAdmin(),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                _header(),
                const SizedBox(
                  height: 20,
                ),
                _add(),
                const SizedBox(
                  height: 10,
                ),
                _search(),
                const SizedBox(
                  height: 30,
                ),

                _table(),
                const SizedBox(
                  height: 50,
                ),
                //_test(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// Table heading
  Row _header() {
    return Row(
      children: [
        Text(
          "Employee List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.02,
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: refreshTable,
        ),
      ],
    );
  }

  Row _search() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: deviceWidth * 0.3,
            child: TextField(
              controller: searchLogController,
              onChanged: (value) {
                getUser();
              },
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(),
                  ),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      searchLogController.clear();
                      FocusScope.of(context).unfocus();
                      searchLogController.clear();
                      getUser();
                      // setState(() {});
                    },
                    child: Icon(Icons.clear),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(() => AddEmployeeForm());
          },
          child: Text(
            "Add New Employee",
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0,
              color: Colors.blue,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Column _table() {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Sr. No.'), numeric: true),
                  DataColumn(label: Text('User Name')),
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Email ID')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                  DataColumn(label: Text('Reset Password')),
                  DataColumn(label: Text('Permission')),
                  DataColumn(label: Text('Chat')),
                ],
                rows: clientType.map((GetUser user) {
                  final index = clientType.indexOf(user);
                  final srNo = (index + 1).toString();

                  final createdOnFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                  // final createdOnDate =
                  //     createdOnFormat.parse(user.createdOn ?? '');

                  // final formattedDate =
                  //     DateFormat('dd/MM/yyyy').format(createdOnDate);

                  return DataRow(cells: [
                    DataCell(Text(srNo)),
                    DataCell(Text(user.username ?? '')),
                    DataCell(Text(user.firstName ?? '')),
                    DataCell(Text(user.lastName ?? '')),
                    DataCell(Text(user.email ?? '')),
                    DataCell(Text(user.active == "1" ? 'Active' : 'Inactive')),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          if (user.iD != null) {
                            Get.to(EditEmployeeForm(userId: user.iD!));
                          }
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    DataCell(IconButton(
                      onPressed: () {
                        if (user.iD != null) {
                          deleteUser(user.iD!);
                          getUser();
                        }
                      },
                      icon: Icon(Icons.delete),
                    )),
                    DataCell(IconButton(
                      onPressed: () {
                        if (user.iD != null) {
                          // Show a dialog to reset the password
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String newPassword =
                                  ''; // Store the entered new password
                              String confirmPassword =
                                  ''; // Store the entered confirm password

                              return AlertDialog(
                                title: Text('Reset Password'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        newPassword = value;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Enter new password',
                                      ),
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        confirmPassword = value;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Confirm new password',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      if (newPassword.isNotEmpty &&
                                          confirmPassword.isNotEmpty) {
                                        if (newPassword == confirmPassword) {
                                          updateUserPassword(
                                              user.iD, newPassword);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Passwords do not match.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                          );
                                        }
                                      }
                                    },
                                    child: Text('Reset'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      icon: Icon(Icons.password),
                    )),
                    DataCell(IconButton(
                      onPressed: () {
                        // Implement permission functionality
                      },
                      icon: Icon(Icons.check),
                    )),
                    DataCell(IconButton(
                      onPressed: () {
                        // Implement chat functionality
                      },
                      icon: Icon(Icons.chat),
                    )),
                  ]);
                }).toList(),
                dataRowHeight: 32.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}
// Table contents
// Column _table() {
//   return Column(
//     children: <Widget>[
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             DataTable(
//               columns: const [
//                 DataColumn(label: Text('Sr. No.'), numeric: true),
//                 DataColumn(label: Text('User Name')),
//                 DataColumn(label: Text('First Name')),
//                 DataColumn(label: Text('Last Name')),
//                 DataColumn(label: Text('Email ID')),
//                 DataColumn(label: Text('Status')),
//                 DataColumn(label: Text('Edit')),
//                 DataColumn(label: Text('Delete')),
//                 DataColumn(label: Text('Reset Password')),
//                 DataColumn(label: Text('Permission')),
//                 DataColumn(label: Text('Chat')),
//               ],
//               rows: const [
//                 DataRow(cells: [
//                   DataCell(Text('1')),
//                   DataCell(Text('John')),
//                   DataCell(Text('John ')),
//                   DataCell(Text('Cena')),
//                   DataCell(Text('john@gmail.com')),
//                   DataCell(Text('Active')),
//                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.delete))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.password))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.check))),
//                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('2')),
//                   DataCell(Text('Jane')),
//                   DataCell(Text('Jane')),
//                   DataCell(Text('Doe')),
//                   DataCell(Text('jane@gmail.com')),
//                   DataCell(Text('Active')),
//                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.delete))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.password))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.check))),
//                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('3')),
//                   DataCell(Text('Bob')),
//                   DataCell(Text('Bob')),
//                   DataCell(Text('Charley')),
//                   DataCell(Text('bob@gmail.com')),
//                   DataCell(Text('Inactive')),
//                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.delete))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.password))),
//                   DataCell(
//                       IconButton(onPressed: null, icon: Icon(Icons.check))),
//                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
//                 ]),
//               ],
//               dataRowHeight: 32.0,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
