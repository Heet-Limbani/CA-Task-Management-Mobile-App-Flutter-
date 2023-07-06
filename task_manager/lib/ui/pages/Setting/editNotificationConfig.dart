import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/notificationConficDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';


class EditNotificationConfig extends StatefulWidget {
  final String userId;

  const EditNotificationConfig({required this.userId, Key? key}) : super(key: key);

  @override
  State<EditNotificationConfig> createState() => _EditNotificationConfigState();
}

class _EditNotificationConfigState extends State<EditNotificationConfig> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _EditNotificationConfigKey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();

  bool isActive = true;
  bool checkSMS = true;
  bool checkEmail = true;
  String isActiveValue = "";

  String userId = "";

  @override
  void dispose() {
    message.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = widget.userId; // Store widget.userId in a local variable
    notification();
  }

  void clearField() {
    message.clear();
  }

  List<NotificationConfigDataModel> notificationList = [];
  void notification() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.configurationNotificationEdit}',
      params: {
        'id': userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
     
      if (data != null && data is Map<String, dynamic>) {
        
        final notificationData = NotificationConfigDataModel.fromJson(data);
        notificationList = [notificationData];
        message.text = notificationData.message.toString();

        isActive = notificationData.send.toString() == "0" ? true : false;


        setState(() {});
      }
    }
  }

  void expensesEdit() async {
    isActiveValue = (isActive ? "0" : "1");

    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.configurationNotificationEdit}',
        params: {
          'id': userId.toString(),
          'save': "save",
          'message': message.text,
          'send': isActiveValue,
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
    notification();
  }

 

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Expenses > Edit Expences",
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
                _EditNotificationConfig(),
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
          "Edit Expences",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _EditNotificationConfig() {
    return Form(
      key: _EditNotificationConfigKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            readOnly: true,
            controller: message,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Message',
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
                return 'Please Enter Message';
              }
              if (value.length < 3) {
                return 'Message must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          SwitchListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status', style: TextStyle(fontSize: 20)),
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
                ?Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.cancel, color: Colors.red),
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
              if (_EditNotificationConfigKey.currentState!.validate()) {
                expensesEdit();
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

