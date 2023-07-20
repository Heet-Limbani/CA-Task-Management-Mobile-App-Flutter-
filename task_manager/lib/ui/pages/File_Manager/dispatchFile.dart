import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/pages/File_Manager/fileManager.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class DispatchFile extends StatefulWidget {
  final String userId;

  const DispatchFile({required this.userId, Key? key}) : super(key: key);

  @override
  State<DispatchFile> createState() => _DispatchFileState();
}

class _DispatchFileState extends State<DispatchFile> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _DispatchFileKey = GlobalKey<FormState>();
  TextEditingController receiverName = TextEditingController();
  TextEditingController note = TextEditingController();
 
  String userId = "";


  @override
  void dispose() {
  
    receiverName.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = widget.userId; // Store widget.userId in a local variable
  }

  void clearField() {
    receiverName.clear();
    note.clear();
  }

 
  void fileDispatch() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.dispatchFile}',
        params: {
          "update": "Update",
          "id": userId.toString(),
          "receiver_name": receiverName.text.toString(),
          "note": note.text.toString(),
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
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > File Manager > Dispatch File",
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
                _DispatchFile(),
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
          "Dispatch File",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _DispatchFile() {
    return Form(
      key: _DispatchFileKey,
      child: Column(
        children: <Widget>[

          TextFormField(
            controller: receiverName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Receiver Name',
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
                return 'Please Enter Receiver Name';
              }
              if (value.length < 3) {
                return 'Receiver Name must be at least 3 characters long';
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
                return 'Please Enter Note';
              }
              if (value.length < 3) {
                return 'Note must be at least 3 characters long';
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
              if (_DispatchFileKey.currentState!.validate()) {
                fileDispatch();
                clearField();
                Get.off(FileManager());
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


