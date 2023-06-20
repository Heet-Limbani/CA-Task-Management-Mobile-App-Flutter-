import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';


class EditEmployeeForm extends StatefulWidget {
  final String userId;

  const EditEmployeeForm({required this.userId, Key? key}) : super(key: key);

  @override
  State<EditEmployeeForm> createState() => _EditEmployeeFormState();
}

class _EditEmployeeFormState extends State<EditEmployeeForm> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _editEmployeeFormKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController contact2 = TextEditingController();

  bool isActive = true;
  bool checkSMS = true;
  bool checkEmail = true;
  String isActiveValue = "";
  String checkSMSValue = "";
  String checkEmailValue = "";
  String userId = "";

  @override
  void dispose() {
    userName.dispose();
    firstName.dispose();
    lastName.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = widget.userId; // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    userName.clear();
    firstName.clear();
    lastName.clear();
    birthDateController.clear();
    email.clear();
    contact.clear();
    contact2.clear();
  }

  List<GetUser> clientType = [];
  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: {
        'type': Urls.employeeType,
        'id': userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clientType = data.map((item) => GetUser.fromJson(item)).toList();
        userName.text = clientType[0].username.toString();
        firstName.text = clientType[0].firstName.toString();
        lastName.text = clientType[0].lastName.toString();
        birthDateController.text = DateFormat('yyyy-MM-dd').format(
          DateTime.fromMillisecondsSinceEpoch(
              int.parse(clientType[0].birthdate!) * 1000),
        );
        // birthDateController.text = clientType[0].birthdate.toString();
        email.text = clientType[0].email.toString();
        contact.text = clientType[0].contactNumber.toString();
        contact2.text = clientType[0].parentNumber.toString();
        isActive = clientType[0].active.toString() == "1" ? true : false;
        checkSMS = clientType[0].sendSms.toString() == "1" ? true : false;
        checkEmail = clientType[0].sendEmail.toString() == "1" ? true : false;

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

  void employeeEdit() async {
    isActiveValue = (isActive ? "1" : "0");
    checkSMSValue = (checkSMS ? "1" : "0");
    checkEmailValue = (checkEmail ? "1" : "0");

    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editEmployee}',
        params: {
          'id': userId.toString(),
          'save': "save",
          'un': userName.text,
          'fname': firstName.text,
          'lname': lastName.text,
          'email': email.text,
          'num': contact.text,
          'par_num': contact2.text,
          'sendemail': checkEmailValue,
          'sendsms': checkSMSValue,
          'active': isActiveValue,
          'bdate': birthDateController.text,
        },
      );
      if (genmodel != null) {
        Fluttertoast.showToast(
          msg: genmodel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (genmodel.status == true) {
          setState(() {});
        }
      }
    } catch (e) {
      // Handle the exception
    }
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Employee > Edit Employee",
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
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _editEmployeeForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _header() {
    return Row(
      children: [
        Text(
          "Edit Employee Form",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _editEmployeeForm() {
    return Form(
      key: _editEmployeeFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            readOnly: true,
            controller: userName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'User Name',
              suffixIcon: Icon(Icons.person),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter UserName';
              }
              if (value.length < 3) {
                return 'Username must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: firstName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'First Name',
              suffixIcon: Icon(Icons.keyboard),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter First Name';
              }
              if (value.length < 3) {
                return 'First Name must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: lastName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Last Name',
              suffixIcon: Icon(Icons.keyboard),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Last Name';
              }
              if (value.length < 3) {
                return 'Last Name must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: birthDateController,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Birth Date',
              suffixIcon: Icon(Icons.calendar_month),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            onTap: () async {
              // Show date picker when the text field is tapped
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (selectedDate != null) {
                // Format the selected date as 'dd-MM-yyyy'
                String formattedDate =
                    DateFormat('yyyy-mm-dd').format(selectedDate);

                setState(() {
                  birthDateController.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select birth date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email',
              suffixIcon: Icon(Icons.email),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter email';
              }

              final emailRegex =
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
              if (!RegExp(emailRegex).hasMatch(value)) {
                return 'Please Enter Valid Email';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: contact,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Contact Number',
              suffixIcon: Icon(Icons.phone),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Contact Number';
              }

              final numberRegex = r'^[0-9]+$';
              if (!RegExp(numberRegex).hasMatch(value)) {
                return 'Please Enter valid Number';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: contact2,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Parent Number',
              suffixIcon: Icon(Icons.contact_phone),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isNotEmpty) {
                final numberRegex = r'^[0-9]+$';
                if (!RegExp(numberRegex).hasMatch(value)) {
                  return 'Please Enter a Valid Number';
                }
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          SwitchListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account', style: TextStyle(fontSize: 20)),
                Text(
                  isActive ? 'Active' : 'Inactive',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            value: isActive,
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
            secondary: isActive
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.cancel, color: Colors.red),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Send Text SMS', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: checkSMS,
                  onChanged: (value) {
                    setState(() {
                      checkSMS = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Send Email', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: checkEmail,
                  onChanged: (value) {
                    setState(() {
                      checkEmail = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              minimumSize: Size.fromHeight(60),
              backgroundColor: Colors.blue, // Set the background color
              primary: Colors.white, // Set the text color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_editEmployeeFormKey.currentState!.validate()) {
                employeeEdit();
              }
            },
            child: Text(
              "Update",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.2,
          ),
        ],
      ),
    );
  }
}

// Table heading

Row _search() {
  return Row(
    children: [
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              hintText: 'Search',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide())),
        ),
      ),
    ],
  );
}

Row _add() {
  return Row(
    children: [
      OutlinedButton(
        onPressed: () {},
        child: Text(
          "Add New EditEmployeeForm",
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

// Row _test() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Container(
//         height: 100,
//         width: 200,
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 182, 212, 237),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: dataResponse == null
//               ? Text("data Is Loading")
//               : Text(
//                   dataResponse!["first_name"].toString(),
//                 ),
//         ),
//       ),
//     ],
//   );
// }

// Table contents
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
              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('John')),
                  DataCell(Text('John ')),
                  DataCell(Text('Cena')),
                  DataCell(Text('john@gmail.com')),
                  DataCell(Text('Active')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.password))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.check))),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Jane')),
                  DataCell(Text('Jane')),
                  DataCell(Text('Doe')),
                  DataCell(Text('jane@gmail.com')),
                  DataCell(Text('Active')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.password))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.check))),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('Bob')),
                  DataCell(Text('Bob')),
                  DataCell(Text('Charley')),
                  DataCell(Text('bob@gmail.com')),
                  DataCell(Text('Inactive')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.password))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.check))),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
                ]),
              ],
              dataRowHeight: 32.0,
            ),
          ],
        ),
      ),
    ],
  );
}
