import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/taskChargeEditDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class TaskChargeEdit extends StatefulWidget {
  final String userId;

  const TaskChargeEdit({required this.userId, Key? key}) : super(key: key);

  @override
  State<TaskChargeEdit> createState() => _TaskChargeEditState();
}

class _TaskChargeEditState extends State<TaskChargeEdit> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _TaskChargeEditKey = GlobalKey<FormState>();
  TextEditingController chargeName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

  String userId = "";
  String? selectedClientId1;
 
  @override
  void dispose() {
    chargeName.dispose();
    amount.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = widget.userId; // Store widget.userId in a local variable
    getUser();
     
  }

  void clearField() {
    chargeName.clear();
    amount.clear();
    description.clear();
    selectedClientId1 = null;
  }

  List<TaskChargeEditDataModel> clientType = [];
  void getUser() async {
    print("id :- $userId");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.taskChargeEdit}',
      params: {
        'id': userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      final fileData = TaskChargeEditDataModel.fromJson(data);
      amount.text = fileData.data!.amount.toString();
      description.text = fileData.data!.description.toString();
      selectedClientId1 = fileData.data!.expenceId.toString();
      clientType.add(fileData); // Add the companyData to clientType list
      setState(() {});
    }
  }

  void fileEdit() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.taskChargeEdit}',
        params: {
          "submit": "Save",
          "id": userId.toString(),
          "exp": selectedClientId1.toString(),
          "txtamount": amount.text,
          "txtComment": description.text,
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
          "Menu > Task > Charge >  Edit",
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
                _TaskChargeEdit(),
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
          "Edit Charge",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _TaskChargeEdit() {
    return Form(
      key: _TaskChargeEditKey,
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
                chargeName.text = selectedClientId1 ?? '';
              });
            },
            items: clientType.expand<DropdownMenuItem<String>>(
                (TaskChargeEditDataModel dataModel) {
              return dataModel.expences
                      ?.map<DropdownMenuItem<String>>((Expences expences) {
                    return DropdownMenuItem<String>(
                      value: expences.id ?? '',
                      child: Text('${expences.name}'),
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
            controller: description,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Description',
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
              if (_TaskChargeEditKey.currentState!.validate()) {
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
