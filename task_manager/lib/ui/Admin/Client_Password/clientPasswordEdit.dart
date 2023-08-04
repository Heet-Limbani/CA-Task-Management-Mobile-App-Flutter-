import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/API/model/ClientPasswordEditDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class ClientPasswordEdit extends StatefulWidget {
  final String id;
  const ClientPasswordEdit({required this.id, Key? key}) : super(key: key);

  @override
  State<ClientPasswordEdit> createState() => _ClientPasswordEditState();
}

String id = '';

class _ClientPasswordEditState extends State<ClientPasswordEdit> {
  late double deviceWidth;
  late double deviceHeight;
  bool obscurePassword = true;
  bool obscurePassword1 = true;

  Map? dataResponse;

  final GlobalKey<FormState> _ClientPasswordEditKey = GlobalKey<FormState>();
  TextEditingController companyName = TextEditingController();
  TextEditingController gstUser = TextEditingController();
  TextEditingController gstPassword = TextEditingController();
  TextEditingController anotherPass = TextEditingController();
  TextEditingController note = TextEditingController();

  String? selectedClientId1;

  @override
  void dispose() {
    companyName.dispose();
    gstUser.dispose();
    gstPassword.dispose();
    anotherPass.dispose();
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
    gstUser.clear();
    gstPassword.clear();
    anotherPass.clear();
    note.clear();
    selectedClientId1 = null;
  }

  List<ClientPasswordEditDataModel> clientType = [];

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientPasswordEdit}',
      params: {
        'id': id.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      final companyData = ClientPasswordEditDataModel.fromJson(data);

      //clientName.text = companyData.company!.name.toString();

      companyName.text = companyData.perData!.name.toString();
      gstUser.text = companyData.perData!.username.toString();
      gstPassword.text = companyData.perData!.password.toString();
      anotherPass.text = companyData.perData!.name.toString();
      note.text = companyData.perData!.notes.toString();

      selectedClientId1 = companyData.perData!.companyId.toString();
      clientType.add(companyData); // Add the companyData to clientType list

      setState(() {});
    }
  }

  void fileEdit() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientPasswordEdit}',
        params: {
          "id": id.toString(),
          "company": selectedClientId1.toString(),
          "gstun": gstUser.text.toString(),
          "gstpass": gstPassword.text.toString(),
          "anotherpass": anotherPass.text.toString(),
          "note": note.text.toString(),
          "save": "save",
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
          "Menu > Client Password > Edit Client Password",
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
                _ClientPasswordEdit(),
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
          "Add Client Password",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _ClientPasswordEdit() {
    return Form(
      key: _ClientPasswordEditKey,
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
                (ClientPasswordEditDataModel dataModel) {
              return dataModel.data?.map<DropdownMenuItem<String>>((Data data) {
                    return DropdownMenuItem<String>(
                      value: data.id ?? '',
                      child: Text('${data.text}'),
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
            controller: gstUser,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'GST Username',
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
                return 'Please Enter GST Username';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: gstPassword,
            obscureText: obscurePassword1,
            decoration: InputDecoration(
              labelText: 'GST Password',
               suffix: GestureDetector(
                child: Icon(
                    obscurePassword1 ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(() {
                    obscurePassword1 = !obscurePassword1;
                  });
                },
              ),
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

              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: anotherPass,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: 'Another Password',
              suffix: GestureDetector(
                child: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
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
              if (_ClientPasswordEditKey.currentState!.validate()) {
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
