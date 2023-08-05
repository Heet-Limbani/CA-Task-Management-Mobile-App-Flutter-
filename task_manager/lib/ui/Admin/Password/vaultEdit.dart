import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/vaultEditDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class VaultEdit extends StatefulWidget {
  final String id;
  const VaultEdit({required this.id, Key? key}) : super(key: key);

  @override
  State<VaultEdit> createState() => _VaultEditState();
}
String id = '';
class _VaultEditState extends State<VaultEdit> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _VaultEditKey = GlobalKey<FormState>();
  TextEditingController companyName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rpass = TextEditingController();
  TextEditingController note = TextEditingController();

  String? selectedClientId1;

  @override
  void dispose() {
    companyName.dispose();
    name.dispose();
    userName.dispose();
    email.dispose();
    contact.dispose();
    pass.dispose();
    rpass.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    id = widget.id;
    getUser();
  }

  void clearField() {
    companyName.clear();
    name.clear();
    userName.clear();
    email.clear();
    contact.clear();
    pass.clear();
    rpass.clear();
    note.clear();
    selectedClientId1 = null;
  }

   List<VaultEditDataModel> clientType = [];

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.vaultEdit}',
      params: {
        'id': id.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;


      final companyData = VaultEditDataModel.fromJson(data);

      //clientName.text = companyData.company!.name.toString();
      name.text = companyData.data!.name.toString();
      userName.text = companyData.data!.username.toString();
      email.text = companyData.data!.email.toString();
      contact.text = companyData.data!.number.toString();
      note.text = companyData.data!.notes.toString();

      selectedClientId1 = companyData.data!.companyId.toString();
      clientType.add(companyData); // Add the companyData to clientType list

      setState(() {});
    }
  }

  void fileEdit() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.vaultEdit}',
        params: {
          "company": selectedClientId1.toString(),
          "name": name.text,
          "usname": userName.text,
          "pass": pass.text,
          "cpass": rpass.text,
          "email": email.text,
          "number": contact.text,
          "note": note.text,
          "id": id.toString(),
          "save":"save",
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Vault > Add Vault",
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
                _VaultEdit(),
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
          "Add Vault",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _VaultEdit() {
    return Form(
      key: _VaultEditKey,
      child: Column(
        children: <Widget>[
         DropdownButtonFormField<String>(
            value: selectedClientId1,
            decoration: const InputDecoration(
              labelText: 'Client',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedClientId1 = newValue;
                companyName.text = selectedClientId1 ?? '';
              });
            },
            items: clientType.expand<DropdownMenuItem<String>>(
                (VaultEditDataModel dataModel) {
              return dataModel.company
                      ?.map<DropdownMenuItem<String>>((Company company) {
                    return DropdownMenuItem<String>(
                      value: company.id ?? '',
                      child: Text('${company.text}'),
                    );
                  }).toList() ??
                  [];
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a client';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: name,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Name',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Name';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: userName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Username',
              suffixIcon: Icon(Icons.person),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Username';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: pass,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              suffixIcon: Icon(Icons.person),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
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
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: rpass,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Re-Password',
              suffixIcon: Icon(Icons.person),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              if (value != pass.text) {
                return 'Password Not Match';
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
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an email';
              }

              final emailRegex =
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
              if (!RegExp(emailRegex).hasMatch(value)) {
                return 'Please enter a valid email';
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
              labelText: 'Contact',
              suffixIcon: Icon(Icons.phone),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Contact';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: note,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Note',
              suffixIcon: Icon(Icons.note),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Note';
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
              if (_VaultEditKey.currentState!.validate()) {
                fileEdit();
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
