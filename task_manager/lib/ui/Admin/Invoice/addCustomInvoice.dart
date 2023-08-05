import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/AdminDataModel/addCustomInvoiceDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class AddCustomInvoice extends StatefulWidget {
  const AddCustomInvoice({Key? key}) : super(key: key);

  @override
  State<AddCustomInvoice> createState() => _AddCustomInvoiceState();
}

class _AddCustomInvoiceState extends State<AddCustomInvoice> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _AddCustomInvoiceKey = GlobalKey<FormState>();
  TextEditingController companyName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController startingDate = TextEditingController();
  TextEditingController interval = TextEditingController();
  TextEditingController particular = TextEditingController();

  String? selectedClientId1;
  String? selectedIntervalId1;
  late int selectedIntervalId;
  bool isActive = true;

  String isActiveValue = "";
  @override
  void dispose() {
    companyName.dispose();
    amount.dispose();
    startingDate.dispose();
    interval.dispose();
    particular.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    companyName.clear();
    amount.clear();
    startingDate.clear();
    interval.clear();
    particular.clear();
    selectedClientId1 = null;
  }

  List<AddCustomInvoiceDataModel> clientType = [];
  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.addCustomInvoice}',
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      if (data != null && data is List) {
        clientType = data
            .map((item) => AddCustomInvoiceDataModel.fromJson(item))
            .toList();
      }
      setState(() {});
    }
  }

  void fileEdit() async {
    isActiveValue = (isActive ? "0" : "1");
    String test = selectedIntervalId.toString();
    print("selectedIntervalId :- $test");
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.addCustomInvoice}',
        params: {
          "btnSave": "Save",
          "Client": selectedClientId1.toString(),
          "amount": amount.text,
          "startingdate": startingDate.text,
          "active": isActiveValue,
          "time_period": selectedIntervalId.toString(),
          "particular": particular.text,
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
      case 'Week':
        return 0;
      case 'Half - Month':
        return 1;
      case 'Month':
        return 2;
      case 'Quarter':
        return 3;
      case 'Half - Year':
        return 4;
      case 'Year':
        return 5;
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
          "Menu > Custome Invoice > Edit Invoice",
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
                _AddCustomInvoice(),
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
          "Add Invoice",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _AddCustomInvoice() {
    return Form(
      key: _AddCustomInvoiceKey,
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
            items: clientType.map((AddCustomInvoiceDataModel user) {
              return DropdownMenuItem<String>(
                value: user.id ?? '',
                child: Text(user.text ?? ''),
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
            controller: amount,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Amount',
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
                return 'Please Enter Amount';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: particular,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Particular',
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
                return 'Please Enter Particular';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: startingDate,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Starting Date',
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
                  startingDate.text = formattedDate;
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
            items: <String>[
              'Week',
              'Half - Month',
              'Month',
              'Quarter',
              'Half - Year',
              'Year'
            ].map<DropdownMenuItem<String>>((String value) {
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
          SwitchListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account', style: TextStyle(fontSize: 20)),
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
              if (_AddCustomInvoiceKey.currentState!.validate()) {
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
