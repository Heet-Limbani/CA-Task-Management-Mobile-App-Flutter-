import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class AttendanceLogAdd extends StatefulWidget {


  const AttendanceLogAdd({ Key? key}) : super(key: key);

  @override
  State<AttendanceLogAdd> createState() => _AttendanceLogAddState();
}

class _AttendanceLogAddState extends State<AttendanceLogAdd> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _AttendanceLogAddKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController inTime = TextEditingController();
  TextEditingController outTime = TextEditingController();
  TextEditingController date = TextEditingController();

 
  String? selectedClientId1;

  @override
  void dispose() {
    name.dispose();
    inTime.dispose();
    outTime.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    name.clear();
    inTime.clear();
    outTime.clear();
    date.clear();
    selectedClientId1 = null;
  }

  List<GetUser> clientType = [];
  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: {'type': Urls.employeeType, 'limit': "200"},

    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      if (data != null && data is List) {
        clientType =
            data.map((item) => GetUser.fromJson(item)).toList();
      }
      setState(() {});
    }
  }

  void fileEdit() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.attendanceLogEdit}',
        params: {
          "save": "save",
          "Employee": selectedClientId1.toString(),
          "in_time": inTime.text.toString(),
          "out_time": outTime.text.toString(),
          "created_on": date.text.toString(),
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
          "Menu > Report > Attendance Log > Add",
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
                _AttendanceLogAdd(),
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
          "Add Attendance Log",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _AttendanceLogAdd() {
    return Form(
      key: _AttendanceLogAddKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: selectedClientId1,
            decoration: const InputDecoration(
              labelText: 'Employee',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedClientId1 = newValue;
                name.text = selectedClientId1 ?? '';
              });
            },
            items: clientType.map((GetUser user) {
              return DropdownMenuItem<String>(
                value: user.iD ?? '',
                child: Text('${user.firstName} ${user.lastName}'),
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
            controller: inTime,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'In Time',
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
              // Show time picker when the text field is tapped
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: inTime.text.isEmpty
                    ? TimeOfDay.now()
                    : TimeOfDay.fromDateTime(
                        DateFormat('HH:mm').parse(inTime.text),
                      ),
              );

              if (selectedTime != null) {
                // Format the selected time
                String formattedTime =
               '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';


                setState(() {
                  inTime.text = formattedTime;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select Time.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: outTime,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Out Time',
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
              // Show time picker when the text field is tapped
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: outTime.text.isEmpty
                    ? TimeOfDay.now()
                    : TimeOfDay.fromDateTime(
                        DateFormat('HH:mm').parse(outTime.text),
                      ),
              );

              if (selectedTime != null) {
                // Format the selected time
                String formattedTime1 =
                '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

                setState(() {
                  outTime.text = formattedTime1;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select Time.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: date,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Date',
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
                    DateFormat('yyyy-MM-dd').format(selectedDate);

                setState(() {
                  date.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select Date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
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
              if (_AttendanceLogAddKey.currentState!.validate()) {
                fileEdit();
              }
            },
            child: Text(
              "Add",
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
