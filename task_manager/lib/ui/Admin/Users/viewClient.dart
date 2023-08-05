import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/getUsersDataModel.dart';
import 'package:task_manager/ui/Admin/Users/clientInvoiceDetails.dart';
import 'package:task_manager/ui/Admin/Users/clientLogDetails.dart';
import 'package:task_manager/ui/Admin/Users/clientLoginDetails.dart';
import 'package:task_manager/ui/Admin/Users/clientTicketDetails.dart';
import '../../Resources/res/color.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class viewClient1 extends StatefulWidget {
  final String userId;
  const viewClient1({required this.userId, Key? key}) : super(key: key);

  @override
  State<viewClient1> createState() => _viewClient1State();
}

late double deviceWidth;
late double deviceHeight;
TextEditingController clientController = TextEditingController();
TextEditingController messageController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController searchLogController = TextEditingController();
TextEditingController userName = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController contact = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();

String clientId = "";
String message = "";
String description = "";
String date = '';
DateTime? selectedDateTime = DateTime.now();
String userId = "";

String? selectedClientId1;

class _viewClient1State extends State<viewClient1> {
  bool isObscurePassword = true;

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
          'client': userId,
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
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Users > Client > viewClient",
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
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _detail(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _form(),
                 SizedBox(
                  height: deviceHeight * 0.1,
                ),
                _header1(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _table(),
               
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _detail() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              )
            ],
            shape: BoxShape.circle,
            //  image: DecorationImage(
            //    fit: BoxFit.cover,
            //    image: Urls.profileAvatar == ""
            //        ? AssetImage(
            //            "assets/images/heet.png",
            //          )
            //        : NetworkImage(Urls.profileAvatar) as ImageProvider,
            //    // AssetImage(
            //    //   "assets/images/heet.png",
            //    // ),
            //  ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildTextField("User Name", userName.text, false),
        buildTextField("E-mail", email.text, false),
        buildTextField("Contact Number", contact.text, false),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text(
            //     "Update Settings",
            //     style: TextStyle(
            //       fontSize: 20,
            //       letterSpacing: 2,
            //       color: Colors.white,
            //     ),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue,
            //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: 10,
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
          "Add Client Log",
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

  Form _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // DropdownButtonFormField<String>(
          //   value: selectedClientId1,
          //   decoration: const InputDecoration(
          //     labelText: 'Client',
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //       borderSide: BorderSide(color: Colors.grey, width: 0.0),
          //     ),
          //     border: OutlineInputBorder(),
          //   ),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedClientId1 = newValue;
          //       clientController.text = selectedClientId1 ?? '';
          //     });
          //   },
          //   items: clientType.map((GetUser user) {
          //     return DropdownMenuItem<String>(
          //       value: user.iD ?? '',
          //       child: Text(user.username ?? ''),
          //     );
          //   }).toList(),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please select a client';
          //     }
          //     return null;
          //   },
          // ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: messageController,
            decoration: const InputDecoration(
                labelText: 'Message',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Last Name must contain at least 3 characters';
              } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                return 'Last Name cannot contain special characters';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              setState(() {
                message = value;
                // lastNameList.add(lastName);
              });
            },
            onChanged: (value) {
              setState(() {
                message = value;
              });
            },
          ),
          SizedBox(height: deviceHeight * 0.02),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
                labelText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Description must contain at least 3 characters';
              } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                return 'Description cannot contain special characters';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              setState(() {
                description = value;
                // bodyTempList.add(bodyTemp);
              });
            },
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          SizedBox(height: deviceHeight * 0.02),
          TextFormField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Date',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDateTime ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                  );
                  date = DateFormat('yyyy-MM-dd').format(selectedDateTime!);
                  dateController.text = date;
                });
              }
            },
            onFieldSubmitted: (value) {
              setState(() {
                selectedDateTime = DateTime.tryParse(value);
              });
            },
            onChanged: (value) {
              setState(() {
                selectedDateTime = DateTime.tryParse(value);
              });
            },
          ),
          SizedBox(height: deviceHeight * 0.02),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60)),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();

                clientLogAdd();

                Fluttertoast.showToast(
                  msg: "Client Log Added Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }

              clear();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

Row _header1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Client Details",
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


  Row _table() {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ClientLogDetails(userId: userId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Log',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                   ClientLoginDetails(userId: userId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // Add more buttons for additional tables
         SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                   ClientTicketDetails(userId: userId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Ticket',
            style: TextStyle(color: Colors.black),
          ),
        ),
         SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                   ClientInvoiceDetails(userId: userId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Invoice',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
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
              color: Colors.grey,
            )),
      ),
    );
  }
}

class TableScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > viewClient1",
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
      body: Center(
        child: Text('Table 1 Content'),
      ),
    );
  }
}

class TableScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table 2'),
      ),
      body: Center(
        child: Text('Table 2 Content'),
      ),
    );
  }
}
//  @override
//   Widget build(BuildContext context) {
//     deviceWidth = MediaQuery.of(context).size.width;
//     deviceHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Menu > viewClient1",
//           style: Theme.of(context)
//               .textTheme
//               .bodySmall!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         foregroundColor: Colors.grey,
//         backgroundColor: Colors.transparent,
//       ),
//       drawer: SideBarAdmin(),
//       extendBody: true,
//       body: _buildBody(),
//     );
//   }