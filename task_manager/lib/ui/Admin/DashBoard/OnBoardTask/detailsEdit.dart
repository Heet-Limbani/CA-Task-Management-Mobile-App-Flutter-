import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class DetailsEdit extends StatefulWidget {

  final String ticketId;


  const DetailsEdit({required this.ticketId, Key? key}) : super(key: key);

  @override
  State<DetailsEdit> createState() => _DetailsEditState();
}

class _DetailsEditState extends State<DetailsEdit> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _DetailsEditKey = GlobalKey<FormState>();

  String ticketId = "";

  bool  isActive = true;
    bool  isActive2 = true;
 
  String isActiveValue = "";
  String isActiveValue2 = "";
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ticketId  = widget.ticketId;
  }

  void editFile() async {
     isActiveValue = (isActive ? "1" : "0");
     isActiveValue2 = (isActive2 ? "1" : "0");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.closeTicket}',
      params: { 
        'ticket_id': ticketId,
        'send_message': isActiveValue,
        'send_email': isActiveValue2,
        },
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
          "Dashboard > On Board Tasks > Close",
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
                _DetailsEdit(),
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
          "Close Ticket",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _DetailsEdit() {
    return Form(
      key: _DetailsEditKey,
      child: Column(
        
        children: <Widget>[
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          SwitchListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Message', style: TextStyle(fontSize: 20)),
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
            height: deviceHeight * 0.02,
          ),
          SwitchListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Email', style: TextStyle(fontSize: 20)),
                Text(
                  isActive2 ? 'Yes' : 'No',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            value: isActive2,
            onChanged: (value) {
              setState(() {
                isActive2 = value;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
            secondary: isActive2
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
              if (_DetailsEditKey.currentState!.validate()) {
                editFile();
                Get.back();
              }
            },
            child: Text(
              "Close Ticket",
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