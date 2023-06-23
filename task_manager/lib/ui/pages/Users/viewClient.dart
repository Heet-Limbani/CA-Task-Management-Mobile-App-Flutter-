import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import '../../core/res/color.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class ViewClient extends StatefulWidget {
  final String userId;
  const ViewClient({required this.userId, Key? key}) : super(key: key);
  @override
  _ViewClientState createState() => _ViewClientState();
}

late double deviceWidth;
late double deviceHeight;
TextEditingController clientController = TextEditingController();
TextEditingController messageController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController searchLogController = TextEditingController();
List<GetUser> clientType = [];
String clientId = "";
String message = "";
String description = "";
String date = '';
DateTime? selectedDateTime = DateTime.now();

String? selectedClientId1;

class _ViewClientState extends State<ViewClient> {
  bool isObscurePassword = true;
  bool receiveSms = false;
  bool receiveEmail = false;
  String userId = "";
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    userId = widget.userId; // Store widget.userId in a local variable
    getUser();
  }

  List<GetUser> dataList = [];
  void getUser() async {
    print("User ID: $userId");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: {
        'type': Urls.clientType,
        'id': userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        dataList = data.map((item) => GetUser.fromJson(item)).toList();
        userName.text = dataList[0].username.toString();
        email.text = dataList[0].email.toString();
        contact.text = dataList[0].contactNumber.toString();

        if (dataList.isEmpty) {
          // List is empty
          print("No client data available.");
        } else {
          // List has values
          print("Client data available.");
        }
        for (GetUser clientdata1 in dataList) {
          print('UserName: ${clientdata1.username}');
        }

        setState(() {});
      }
    }
  }

  void clientLogAdd() async {
    try {
      if (selectedDateTime == null) {
        selectedDateTime = DateTime.now();
      }
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientLogAdd}',
        params: {
          'message': message,
          'client': selectedClientId1,
          'description': description,
          'date': selectedDateTime.toString(),
        },
      );
      if (genmodel != null) {
        if (genmodel.status == true) {
          setState(() {
            clientId = '';
          });
        }
      }
    } catch (e) {}
  }

  void clear() {
    clientController.clear();
    messageController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > viewClient",
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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        readOnly: true,
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscurePassword = !isObscurePassword;
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
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
                  height: 10,
                ),
                _textField(),
                const SizedBox(
                  height: 30,
                ),
                //_add(),
                const SizedBox(
                  height: 0,
                ),
                //_table(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Cient",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        const Spacer(),
      ],
    );
  }

 Column _textField() {
  return Column(
    children: <Widget>[
      Expanded(
        child: ListView(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 50),
            buildTextField("User Name", userName.text, false),
            buildTextField("E-mail", email.text, false),
            buildTextField("Contact Number", contact.text, false),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Update Settings",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    ],
  );
}

}


// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:task_manager/API/model/genModel.dart';
// import 'package:task_manager/API/model/getUsersDataModel.dart';
// import '../../core/res/color.dart';
// import '../DashBoard/sidebarAdmin.dart';
// import 'package:task_manager/API/Urls.dart';

// class ViewClient extends StatefulWidget {
//   final String userId;
//   const ViewClient({required this.userId, Key? key}) : super(key: key);
//   @override
//   _ViewClientState createState() => _ViewClientState();
// }

// late double deviceWidth;
// late double deviceHeight;
// TextEditingController clientController = TextEditingController();
// TextEditingController messageController = TextEditingController();
// TextEditingController descriptionController = TextEditingController();
// TextEditingController dateController = TextEditingController();
// TextEditingController searchLogController = TextEditingController();
// List<GetUser> clientType = [];
// String clientId = "";
// String message = "";
// String description = "";
// String date = '';
// DateTime? selectedDateTime = DateTime.now();

// String? selectedClientId1;

// class _ViewClientState extends State<ViewClient> {
//   bool isObscurePassword = true;
//   bool receiveSms = false;
//   bool receiveEmail = false;
//   String userId = "";
//   TextEditingController userName = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController contact = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     userId = widget.userId; // Store widget.userId in a local variable
//     getUser();
//   }

//   List<GetUser> dataList = [];
//   void getUser() async {
//     print("User ID: $userId");
//     genModel? genmodel = await Urls.postApiCall(
//       method: '${Urls.getUsers}',
//       params: {
//         'type': Urls.clientType,
//         'id': userId.toString(),
//       },
//     );

//     if (genmodel != null && genmodel.status == true) {
//       final data = genmodel.data;

//       if (data != null && data is List) {
//         dataList = data.map((item) => GetUser.fromJson(item)).toList();
//         userName.text = dataList[0].username.toString();
//         email.text = dataList[0].email.toString();
//         contact.text = dataList[0].contactNumber.toString();

//         if (dataList.isEmpty) {
//           // List is empty
//           print("No client data available.");
//         } else {
//           // List has values
//           print("Client data available.");
//         }
//         for (GetUser clientdata1 in dataList) {
//           print('UserName: ${clientdata1.username}');
//         }

//         setState(() {});
//       }
//     }
//   }

//   void clientLogAdd() async {
//     try {
//       if (selectedDateTime == null) {
//         selectedDateTime = DateTime.now();
//       }
//       genModel? genmodel = await Urls.postApiCall(
//         method: '${Urls.clientLogAdd}',
//         params: {
//           'message': message,
//           'client': selectedClientId1,
//           'description': description,
//           'date': selectedDateTime.toString(),
//         },
//       );
//       if (genmodel != null) {
//         if (genmodel.status == true) {
//           setState(() {
//             clientId = '';
//           });
//         }
//       }
//     } catch (e) {}
//   }

//   void clear() {
//     clientController.clear();
//     messageController.clear();
//     descriptionController.clear();
//     dateController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     deviceWidth = MediaQuery.of(context).size.width;
//     deviceHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Menu > Profile",
//           style: Theme.of(context)
//               .textTheme
//               .bodySmall!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         foregroundColor: Colors.grey,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(left: 15, top: 20, right: 15),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   ListView(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: 130,
//                               height: 130,
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(width: 4, color: Colors.white),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     color: Colors.black.withOpacity(0.1),
//                                   )
//                                 ],
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       buildTextField("User Name", userName.text, false),
//                       buildTextField("E-mail", email.text, false),
//                       buildTextField("Contact Number", contact.text, false),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // ElevatedButton(
//                           //   onPressed: () {},
//                           //   child: Text(
//                           //     "Update Settings",
//                           //     style: TextStyle(
//                           //       fontSize: 20,
//                           //       letterSpacing: 2,
//                           //       color: Colors.white,
//                           //     ),
//                           //   ),
//                           //   style: ElevatedButton.styleFrom(
//                           //     backgroundColor: Colors.blue,
//                           //     padding:
//                           //         EdgeInsets.symmetric(horizontal: 50, vertical: 14),
//                           //     shape: RoundedRectangleBorder(
//                           //       borderRadius: BorderRadius.circular(30),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 100,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     Text(
//                       "Add Client Log",
//                       style: TextStyle(
//                         color: Colors.blueGrey[900],
//                         fontWeight: FontWeight.w700,
//                         fontSize: 22,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: deviceHeight * 0.02,
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     DropdownButtonFormField<String>(
//                       value: selectedClientId1,
//                       decoration: const InputDecoration(
//                         labelText: 'Client',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(20.0)),
//                           borderSide:
//                               BorderSide(color: Colors.grey, width: 0.0),
//                         ),
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedClientId1 = newValue;
//                           clientController.text = selectedClientId1 ?? '';
//                         });
//                       },
//                       items: clientType.map((GetUser user) {
//                         return DropdownMenuItem<String>(
//                           value: user.iD ?? '',
//                           child: Text(user.username ?? ''),
//                         );
//                       }).toList(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a client';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: deviceHeight * 0.02,
//                     ),
//                     TextFormField(
//                       controller: messageController,
//                       decoration: const InputDecoration(
//                           labelText: 'Message',
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                             borderSide:
//                                 BorderSide(color: Colors.grey, width: 0.0),
//                           ),
//                           border: OutlineInputBorder()),
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             value.length < 3) {
//                           return 'Last Name must contain at least 3 characters';
//                         } else if (value
//                             .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
//                           return 'Last Name cannot contain special characters';
//                         }
//                         return null;
//                       },
//                       onFieldSubmitted: (value) {
//                         setState(() {
//                           message = value;
//                           // lastNameList.add(lastName);
//                         });
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           message = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: deviceHeight * 0.02),
//                     TextFormField(
//                       controller: descriptionController,
//                       decoration: const InputDecoration(
//                           labelText: 'Description',
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                             borderSide:
//                                 BorderSide(color: Colors.grey, width: 0.0),
//                           ),
//                           border: OutlineInputBorder()),
//                       keyboardType: TextInputType.text,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             value.length < 3) {
//                           return 'Description must contain at least 3 characters';
//                         } else if (value
//                             .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
//                           return 'Description cannot contain special characters';
//                         }
//                         return null;
//                       },
//                       onFieldSubmitted: (value) {
//                         setState(() {
//                           description = value;
//                           // bodyTempList.add(bodyTemp);
//                         });
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           description = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: deviceHeight * 0.02),
//                     TextFormField(
//                       controller: dateController,
//                       decoration: const InputDecoration(
//                         labelText: 'Date',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(20.0)),
//                           borderSide:
//                               BorderSide(color: Colors.grey, width: 0.0),
//                         ),
//                         border: OutlineInputBorder(),
//                       ),
//                       onTap: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: selectedDateTime ?? DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(3000),
//                         );
//                         if (pickedDate != null) {
//                           setState(() {
//                             selectedDateTime = DateTime(
//                               pickedDate.year,
//                               pickedDate.month,
//                               pickedDate.day,
//                             );
//                             date = DateFormat('yyyy-MM-dd')
//                                 .format(selectedDateTime!);
//                             dateController.text = date;
//                           });
//                         }
//                       },
//                       onFieldSubmitted: (value) {
//                         setState(() {
//                           selectedDateTime = DateTime.tryParse(value);
//                         });
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           selectedDateTime = DateTime.tryParse(value);
//                         });
//                       },
//                     ),
//                     SizedBox(height: deviceHeight * 0.02),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size.fromHeight(60)),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           FocusScope.of(context).unfocus();
      
//                           clientLogAdd();
      
//                           Fluttertoast.showToast(
//                             msg: "Client Log Added Successfully",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.BOTTOM,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: AppColors.primaryColor,
//                             textColor: Colors.white,
//                             fontSize: 16.0,
//                           );
//                         }
      
//                         clear();
//                       },
//                       child: const Text("Submit"),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       drawer: SideBarAdmin(),
//       extendBody: true,
//     );
//   }

//   Widget buildTextField(
//       String labelText, String placeholder, bool isPasswordTextField) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 30.0),
//       child: TextField(
//         readOnly: true,
//         obscureText: isPasswordTextField ? true : false,
//         decoration: InputDecoration(
//           suffixIcon: isPasswordTextField
//               ? IconButton(
//                   icon: Icon(
//                     Icons.remove_red_eye,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isObscurePassword = !isObscurePassword;
//                     });
//                   },
//                 )
//               : null,
//           contentPadding: EdgeInsets.only(bottom: 3),
//           labelText: labelText,
//           labelStyle: TextStyle(
//             fontSize: 16,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: placeholder,
//           hintStyle: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   buildCheckboxTile(
//     String title,
//     bool value,
//     Function(bool) onChanged,
//   ) {
//     return ListTile(
//       title: Text(title),
//       trailing: Checkbox(
//         value: value,
//         onChanged: (newValue) {
//           onChanged(newValue ?? false);
//         },
//       ),
//     );
//   }
// }
