import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class HolidayViewAdd extends StatefulWidget {
  

  const HolidayViewAdd({ Key? key}) : super(key: key);

  @override
  State<HolidayViewAdd> createState() => _HolidayViewAddState();
}

class _HolidayViewAddState extends State<HolidayViewAdd> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _HolidayViewAddKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description= TextEditingController();
  TextEditingController date = TextEditingController();

 
  bool isActive = true;
  String isActiveValue = "";
  @override
  void dispose() {
    title.dispose();
    description.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  // Store widget.userId in a local variable
     
  }

  void clearField() {
    title.clear();
    description.clear();
    date.clear();
  }


  void fileEdit() async {
     isActiveValue = (isActive ? "1" : "0");
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.holidayViewAdd}',
        params: {
          "title": title.text,
          "description": description.text,
          "date": date.text,
          "show_to_users": isActiveValue,
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
          "Menu > Holiday > Add Holiday",
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
                _HolidayViewAdd(),
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
          "Add Holiday",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  
 

  Form _HolidayViewAdd() {
    return Form(
      key: _HolidayViewAddKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: title,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Title',
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
                return 'Please Enter Title';
              }
              return null; // Return null if the input is valid
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
                lastDate: DateTime(2100),
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
                return 'Please Select birth date.';
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
              if (_HolidayViewAddKey.currentState!.validate()) {
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
