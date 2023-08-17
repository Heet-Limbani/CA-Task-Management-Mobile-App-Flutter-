import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/loginDataModel.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/API/Urls.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

String img = "";

class _ProfileState extends State<Profile> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _ProfileKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController session = TextEditingController();
  bool edit = false;
  TextEditingController fileController = TextEditingController();
  File? selectedFile;

  // TextEditingController contact2 = TextEditingController();

  bool isActive = true;
  bool checkSMS = true;
  bool checkEmail = true;
  String isActiveValue = "";
  String checkSMSValue = "";
  String checkEmailValue = "";

  @override
  void dispose() {
    userName.dispose();
    firstName.dispose();
    lastName.dispose();
    about.dispose();
    email.dispose();
    contact.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    userName.clear();
    firstName.clear();
    lastName.clear();
    about.clear();
    email.clear();
    contact.clear();
    // contact2.clear();
  }

  void getUser() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        userName.text = prefs.getString('username') ?? '';
        firstName.text = prefs.getString('firstname') ?? '';
        lastName.text = prefs.getString('lastname') ?? '';
        about.text = prefs.getString('aboutme') ?? '';
        email.text = prefs.getString('email') ?? '';
        contact.text = prefs.getString('contactnumber') ?? '';
        session.text = prefs.getString('sessiontime') ?? '';
        img = Urls.baseUrlMain + Urls.profile + prefs.getString('avatar')!;
        checkSMS = prefs.getString('enable_sms_notification') == "1"
            ? true
            : prefs.getString('enable_sms_notification') == "0"
                ? false
                : true;
        checkEmail = prefs.getString('enable_email_notification') == "1"
            ? true
            : prefs.getString('enable_email_notification') == "0"
                ? false
                : true;
      });
    });
  }

  void profileEdit() async {
    checkSMSValue = (checkSMS ? "1" : "0");
    checkEmailValue = (checkEmail ? "1" : "0");
    // print("Contact2 : ${contact2.text}");

    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.updateProfile}',
        params: {
          'first_name': firstName.text,
          'last_name': lastName.text,
          'email': email.text,
          'number': contact.text,
          'enable_email_notification': checkEmailValue,
          'enable_sms_notification': checkSMSValue,
          'aboutme': about.text,
          "session_time": session.text,
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
  }

  void editImage(File selectedFile) async {
    try {
      Map<String, String> headers = await Urls.getXTokenHeader();
      String csrfToken = headers['Xtoken'] ?? ''; // Get the Xtoken value

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.updateImage), // Replace with your API endpoint URL
      );

      request.headers['Xtoken'] = csrfToken;
      request.files.add(
        http.MultipartFile(
          'userImage',
          selectedFile.readAsBytes().asStream(),
          selectedFile.lengthSync(),
          filename:
              selectedFile.path.split('/').last, // Use the selected file's name
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successful response
        var responseBody = await response.stream.bytesToString();
        var genmodel = genModel.fromJson(json.decode(responseBody));
        Fluttertoast.showToast(
          msg: genmodel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        if (genmodel.status == true) {
          setState(() {});
        }
        profile();
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  genModel? genmodel;
  LoginData logindata = LoginData();
  void profile() async {
    try {
      genmodel = await Urls.postApiCall(
        method: '${Urls.profile1}',
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    if (genmodel != null) {
      LoginData loginData = LoginData.fromJson(genmodel!.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('xtoken', loginData.xtoken ?? '');
      prefs.setString('email', loginData.email ?? '');
      prefs.setString('username', loginData.username ?? '');
      prefs.setString('type', loginData.type ?? '');
      prefs.setString('contactnumber', loginData.contactNumber ?? '');
      prefs.setString('firstname', loginData.firstName ?? '');
      prefs.setString('lastname', loginData.lastName ?? '');
      prefs.setString('password', loginData.password ?? '');
      prefs.setString('sessiontime', loginData.sessionTime ?? '');
      prefs.setString('avatar', loginData.avatar ?? '');
      getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Profile",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarClient(),
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
                _image(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                if (edit) ...{
                  _detail(),
                },
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _Profile(),
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
          "Profile",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Center _image() {
    return Center(
      child: Stack(
        children: [
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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(img),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                  color: Colors.blue,
                ),
                child: Icon(Icons.edit, color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  edit = !edit;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Column _detail() {
    return Column(
      children: [
        buildFileInput(
          "Select File",
          fileController,
          (file) {
            setState(() {
              selectedFile = file;
            });
          },
        ),
      ],
    );
  }

  Widget buildFileInput(
    String labelText,
    TextEditingController controller,
    void Function(File?)? onPressed,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path!);
                controller.text = file.path;
                onPressed?.call(file);
              }
            },
            icon: Icon(Icons.attach_file),
          ),
          IconButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                editImage(selectedFile!);
                controller.clear();
                edit = false;
              } else {
                Fluttertoast.showToast(
                  msg: "Please Select File",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  // backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            icon: Icon(Icons.upload),
          ),
          IconButton(
            onPressed: () {
              controller.clear();
              onPressed?.call(null);
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

  Form _Profile() {
    return Form(
      key: _ProfileKey,
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
            height: deviceHeight * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              minimumSize: Size.fromHeight(60),
              backgroundColor: Colors.blue, // Set the background color

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_ProfileKey.currentState!.validate()) {
                profileEdit();
                getUser();
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
