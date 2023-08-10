import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class fileDetailsEdit extends StatefulWidget {
 
  final String ticketId;
  final String sc;

  const fileDetailsEdit({required this.sc,required this.ticketId, Key? key}) : super(key: key);

  @override
  State<fileDetailsEdit> createState() => _fileDetailsEditState();
}

class _fileDetailsEditState extends State<fileDetailsEdit> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _fileDetailsEditKey = GlobalKey<FormState>();
 
  String ticketId = "";
  String sc = "";
  bool  isActive = true;
 
  String isActiveValue = "";
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ticketId  = widget.ticketId;
   
    sc = widget.sc;
    isActive = (sc == "1" ? true : false);
  }

  // void clearField() {}

  // void getUser() async {
  //   print("id :- $userId");
  //   genModel? genmodel = await Urls.postApiCall(
  //     method: '${Urls.taskViewTaskDetails}',
  //     params: {
  //       "sub_tid": userId.toString(),
  //     },
  //   );

  //   if (genmodel != null && genmodel.status == true) {
  //     final data = genmodel.data;
  //     final fileData = TasksData.fromJson(data);
  //     print("fileData :- $fileData");

  //     isActive = fileData.virtualFile![0].toString() == "1" ? true : false;
  //     setState(() {});
  //   }
  // }

  void editFile() async {
     isActiveValue = (isActive ? "1" : "0");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.companyFileEdit}',
      params: { 'task':'view_company_log','downloadable': isActiveValue, 'id': ticketId,'submit':'submit'},
    );

    if (genmodel != null && genmodel.status == true) {
      Fluttertoast.showToast(
        msg: "${genmodel.message.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Tasks > Files > Edit",
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
                _fileDetailsEdit(),
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
          "Edit File Details",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _fileDetailsEdit() {
    return Form(
      key: _fileDetailsEditKey,
      child: Column(
        
        children: <Widget>[
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          SwitchListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Show To User', style: TextStyle(fontSize: 20)),
                Text(
                  isActive ? 'Yes' : 'No',
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
              if (_fileDetailsEditKey.currentState!.validate()) {
                editFile();
              }
            },
            child: Text(
              "Edit",
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
