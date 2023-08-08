import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/EditTaskDataModel.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/API/Urls.dart';

class EditTask extends StatefulWidget {
  final String userId;

  const EditTask({required this.userId, Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _EditTaskKey = GlobalKey<FormState>();
  TextEditingController taskName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController startingDate = TextEditingController();
  TextEditingController deadlineDate = TextEditingController();
  bool autoComplete = true;
  bool autoInvoice = true;
  String autoCompleteValue = "";
  String autoInvoiceValue = "";
  List<String> selectedFileIds = [];

  String userId = "";
  String? selectedClientId1;

  @override
  void dispose() {
    taskName.dispose();
    companyName.dispose();
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
    taskName.clear();
    companyName.clear();
    description.clear();
    selectedClientId1 = null;
  }

  List<EditTaskDataModel> clientType = [];

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.editTask}',
      params: {
        "id": userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      final fileData = EditTaskDataModel.fromJson(data);

      taskName.text = fileData.data!.title.toString();
      description.text = fileData.data!.description.toString();
      department.text = fileData.data!.depId.toString();
      amount.text = fileData.data!.amount!.toString();
      startingDate.text = fileData.data!.startingDate!;
      deadlineDate.text = fileData.data!.deadlineDate!;
      autoComplete = fileData.data!.autoCompleteAndReview == "1" ? true : false;
      autoInvoice = fileData.data!.autoInvoice == "1" ? true : false;
       selectedFileIds = fileData.data!.fileId!.split(',');
      selectedClientId1 = fileData.data!.clientId.toString();

      clientType.add(fileData); // Add the companyData to clientType list
      setState(() {});
    }
  }

  void fileEdit() async {
    autoCompleteValue = (autoComplete ? "1" : "0");
    autoInvoiceValue = (autoInvoice ? "1" : "0");

    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editTask}',
        params: {
          "id": userId,
          "txtTaskname": taskName.text,
          "txtComment": description.text,
          "Client": selectedClientId1.toString(),
          "Department": department.text,
          "auto_cmplt": autoCompleteValue,
          "auto_inc": autoInvoiceValue,
          "txtamount": amount.text,
          "startingdate": startingDate.text,
          "deadlinedate": deadlineDate.text,
          "file[]": selectedFileIds,
          "update": "update",
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
          "Desboard > Task > Edit Task",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarClient(),
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
                _EditTask(),
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
          "Edit Task",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _EditTask() {
    return Form(
      key: _EditTaskKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: taskName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Sub Task Name',
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
                return 'Please Enter Sub Task Name';
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
              labelText: 'Company',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: null,
            // onChanged: (String? newValue) {
            //   setState(() {
            //     selectedClientId1 = newValue;
            //     companyName.text = selectedClientId1 ?? '';
            //   });
            // },
            items: clientType.expand<DropdownMenuItem<String>>(
                (EditTaskDataModel dataModel) {
              return dataModel.company
                      ?.map<DropdownMenuItem<String>>((Company company) {
                    return DropdownMenuItem<String>(
                      value: company.id ?? '',
                      child: Text('${company.text}'),
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
              if (_EditTaskKey.currentState!.validate()) {
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
