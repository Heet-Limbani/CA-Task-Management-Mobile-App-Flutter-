import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/AdminDataModel/employeeLeaveDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class AdminLeaveEdit extends StatefulWidget {
  final String id;

  const AdminLeaveEdit({required this.id, Key? key}) : super(key: key);

  @override
  State<AdminLeaveEdit> createState() => _AdminLeaveEditState();
}

class _AdminLeaveEditState extends State<AdminLeaveEdit> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _AdminLeaveEditKey = GlobalKey<FormState>();
  TextEditingController reason = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController interval = TextEditingController();
  TextEditingController description = TextEditingController();

  String id = "";
  String? selectedIntervalId1;
  late int selectedIntervalId;

  @override
  void dispose() {
    reason.dispose();
    fromDate.dispose();
    toDate.dispose();
    interval.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    id = widget.id; // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    reason.clear();
    fromDate.clear();
    toDate.clear();
    interval.clear();
    description.clear();
  }

  List<EmployeeLeaveDataModel> clientType = [];
  void getUser() async {
    
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.adminLeaveEdit}',
      params: {
        'id': id.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      final fileData = EmployeeLeaveDataModel.fromJson(data);
      reason.text = fileData.reason.toString();
      fromDate.text = DateFormat('yyyy-MM-dd').format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(fileData.fromDate!) * 1000),
      );
      toDate.text = DateFormat('yyyy-MM-dd').format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(fileData.toDate!) * 1000),
      );

      String intervalValue = '';
      if (fileData.shift.toString() == "0") {
        intervalValue = "Shift - 1";
      } else if (fileData.shift.toString() == "1") {
        intervalValue = "Shift - 2";
      } else if (fileData.shift.toString() == "2") {
        intervalValue = "Full Day";
      }

      selectedIntervalId = _getItemId(intervalValue)!;
      interval.text = intervalValue;
      selectedIntervalId1 = intervalValue;
      description.text = fileData.description.toString();
      clientType.add(fileData); // Add the companyData to clientType list
      setState(() {});
    }
  }

  void fileEdit() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.adminLeaveEdit}',
        params: {
          "save": "save",
          "id": id.toString(),
          "reason": reason.text,
          "fdate": fromDate.text,
          "tdate": toDate.text,
          "shift": selectedIntervalId.toString(),
          "description": description.text,
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

  int? _getItemId(String item) {
    switch (item) {
      case 'Shift - 1':
        return 0;
      case 'Shift - 2':
        return 1;
      case 'Full Day':
        return 2;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Admin Leave > Edit Admin Leave",
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
                _AdminLeaveEdit(),
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
          "Edit Admin Leave",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _AdminLeaveEdit() {
    return Form(
      key: _AdminLeaveEditKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: reason,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Reason',
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
                return 'Please Enter Reason';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: fromDate,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'From Date',
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
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                // Format the selected date as 'dd-MM-yyyy'
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(selectedDate);

                setState(() {
                  fromDate.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select From date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: toDate,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'To Date',
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
                initialDate: toDate.text.isEmpty
                    ? DateTime.now()
                    : DateTime.parse(toDate.text),
                firstDate: fromDate.text.isEmpty
                    ? DateTime.now()
                    : DateTime.parse(fromDate.text),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                // Format the selected date as 'dd-MM-yyyy'
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(selectedDate);

                setState(() {
                  toDate.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select To date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          DropdownButtonFormField<String>(
            value: selectedIntervalId1,
            decoration: const InputDecoration(
              labelText: 'Interval',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedIntervalId1 = newValue!;
                selectedIntervalId = _getItemId(newValue)!;
              });
            },
            items: <String>['Shift - 1', 'Shift - 2', 'Full Day']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 16)),
              );
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
          TextFormField(
            controller: description,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Description',
              suffixIcon: Icon(Icons.description),
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
                return 'Please Enter Description';
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
              if (_AdminLeaveEditKey.currentState!.validate()) {
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
