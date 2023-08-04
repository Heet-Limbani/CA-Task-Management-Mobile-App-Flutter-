import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/Admin%20DataModel/companyDataModel.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddCompanyGroup extends StatefulWidget {
  const AddCompanyGroup({super.key});

  @override
  State<AddCompanyGroup> createState() => _AddCompanyGroupState();
}

class _AddCompanyGroupState extends State<AddCompanyGroup> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _AddCompanyGroupKey = GlobalKey<FormState>();
  TextEditingController groupName = TextEditingController();
  TextEditingController Companies = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController interval = TextEditingController();
  TextEditingController startDate = TextEditingController();
  List<String> test = ["1", "2"];
  String? selectedClientId1;
  late int selectedClientId;
  String? company;
  List<String> selectedCompanyIds = [];
  List<String> selectedCompanyNames = [];

  // TextEditingController contact2 = TextEditingController();

  bool autoTicket = true;
  bool checkSMS = true;
  bool checkEmail = true;
  String autoTicketValue = "";
  String checkSMSValue = "";
  String checkEmailValue = "";

  @override
  void dispose() {
    groupName.dispose();
    Companies.dispose();
    message.dispose();
    interval.dispose();
    startDate.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getUser();
    super.initState();
    // Store widget.userId in a local variable
  }

  void clearField() {
    groupName.clear();
    Companies.clear();
    message.clear();
    interval.clear();
    startDate.clear();
  }

  List<CompanyDataModel> companyGroupDataList = [];

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.company}',
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List<dynamic>) {
        List<CompanyDataModel> fetchedData = data.map<CompanyDataModel>((item) {
          return CompanyDataModel.fromJson(item);
        }).toList();

        setState(() {
          companyGroupDataList.addAll(fetchedData);
        });
      }
    }
  }

  void clientEdit() async {
    autoTicketValue = (autoTicket ? "1" : "0");
    checkSMSValue = (checkSMS ? "1" : "0");
    checkEmailValue = (checkEmail ? "1" : "0");
    // print("Contact2 : ${contact2.text}");

    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editCompanyGroup}',
        params: {
          'name': groupName.text,
          'file[]': selectedCompanyIds,
          'msg': message.text,
          'intval': selectedClientId.toString(),
          'start': startDate.text,
          'auto': autoTicketValue,
          'email': checkEmailValue,
          'sms': checkSMSValue,
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
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Company > Company Group > Edit",
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
                _AddCompanyGroup(),
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
          "Edit Company Group",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
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

  Form _AddCompanyGroup() {
    return Form(
      key: _AddCompanyGroupKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: groupName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Group Name',
              suffixIcon: Icon(Icons.keyboard),
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
                return 'Please Enter Group Name';
              }
              if (value.length < 3) {
                return 'Group Name must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.04,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              MultiSelectDialogField<CompanyDataModel>(
                title: Text('Select Company'),
                items: companyGroupDataList
                    .map((company) => MultiSelectItem<CompanyDataModel>(
                          company,
                          company.name ?? '',
                        ))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (List<CompanyDataModel> selectedItems) {
                  setState(() {
                    selectedCompanyIds = selectedItems
                        .map((item) => item.id!)
                        .toList()
                        .cast<String>();
                  });
                  print(selectedCompanyIds);
                },
              ),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.04,
          ),
          TextFormField(
            controller: message,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Message',
              suffixIcon: Icon(Icons.keyboard),
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
          DropdownButtonFormField<String>(
            value: selectedClientId1,
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
                selectedClientId1 = newValue!;
                selectedClientId = _getItemId(newValue)!;
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
          TextFormField(
            controller: startDate,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Start Date',
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
                  startDate.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select Start Date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Auto Ticket Generate', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: autoTicket,
                  onChanged: (value) {
                    setState(() {
                      autoTicket = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Send Text SMS', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: checkSMS,
                  onChanged: (value) {
                    setState(() {
                      checkSMS = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Send Email', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: checkEmail,
                  onChanged: (value) {
                    setState(() {
                      checkEmail = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              minimumSize: Size.fromHeight(60),
              backgroundColor: Colors.blue, // Set the background color
             // Set the text color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_AddCompanyGroupKey.currentState!.validate()) {
                clientEdit();
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
