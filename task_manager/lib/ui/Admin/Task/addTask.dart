import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:task_manager/API/model/fileDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/taskDataModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Resources/res/color.dart';
import 'package:task_manager/ui/Admin/Company/addCompany.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:collection/collection.dart'; // Import the 'collection' package for the 'firstWhereOrNull' method

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _AddTaskKey = GlobalKey<FormState>();
  TextEditingController taskName = TextEditingController();
  TextEditingController client = TextEditingController();
  TextEditingController selectFile = TextEditingController();
  TextEditingController enterFile = TextEditingController();
  TextEditingController startingDate = TextEditingController();
  TextEditingController deadlineDate = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

  String? selectedClientId1;
  String? selectedDepartmentIds;
  //String? selectedEmployeeId;
  //TaskDataModel taskDataModel = TaskDataModel();
  List<Employee>? selectedEmployeeId;
  TaskDataModel? taskDataModel;

  List<TaskDataModel> companyGroupDataList = [];
  List<String> selectedFileIds = [];

  bool autoComplete = true;
  bool autoInvoice = true;
  String autoCompleteValue = "";
  String autoInvoiceValue = "";

  @override
  void dispose() {
    taskName.dispose();
    client.dispose();
    selectFile.dispose();
    enterFile.dispose();
    startingDate.dispose();
    deadlineDate.dispose();
    department.dispose();
    amount.dispose();
    description.dispose();
    super.dispose();
  }

  void clearField() {
    taskName.clear();
    client.clear();
    selectFile.clear();
    enterFile.clear();
    startingDate.clear();
    deadlineDate.clear();
    department.clear();
    amount.clear();
    description.clear();
    selectedClientId1 = null;
    selectedDepartmentIds = null;
    selectedFileIds.clear();
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getUser2();
  }

  List<TaskDataModel> employeeGroupDataList =
      []; // Define as List<TaskDataModel>
  List<TaskDataModel> clientType = [];
  List<TaskDataModel> departmentType = []; // Define as List<TaskDataModel>

  void getUser() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.addTask}',
        params: {},
      );

      if (genmodel != null &&
          genmodel.status == true &&
          genmodel.data != null) {
        final data = genmodel.data!;
        taskDataModel = TaskDataModel.fromJson(data);

        final taskData = TaskDataModel.fromJson(data);

        // Clear existing data before adding new data
        employeeGroupDataList.clear();
        clientType.clear();

        // Add data to the appropriate lists

        employeeGroupDataList
            .add(taskData); // Add taskData to employeeGroupDataList

        clientType.add(taskData);
        departmentType.add(taskData);

        setState(() {});
      }
    } catch (e) {
      print('Error retrieving client data: $e');
    }
  }

  List<FileDataModel> fileList = [];

  void getUser2() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.fileForTask}',
      params: {
        "id": selectedClientId1,
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List<dynamic>) {
        // Clear existing data before adding new data
        fileList.clear();
        List<FileDataModel> fetchedData = data.map<FileDataModel>((item) {
          return FileDataModel.fromJson(item);
        }).toList();

        setState(() {
          fileList.addAll(fetchedData);
        });
      }
    }
  }

  void addFile() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.addFileForTask}',
      params: {
        "client_id": selectedClientId1,
        "name": enterFile.text,
      },
    );

    if (genmodel!.status == true) {
      Fluttertoast.showToast(
        msg: genmodel.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      getUser2();
    }
  }
  void taskAdd() async {
    autoCompleteValue = (autoComplete ? "1" : "0");
    autoInvoiceValue = (autoInvoice ? "1" : "0");
    print("startingdate: ${startingDate.text}");
    print("deadlineDate: ${deadlineDate.text}");
    print("description: ${description.text}");
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.addTask}',
        params: {
          "txtTaskname": taskName.text,
          "Client": selectedClientId1.toString(),
          "file[]": selectedFileIds,
          "startingdate": startingDate.text,
          "deadlinedate": deadlineDate.text,
          "Department": selectedDepartmentIds.toString(),
          "txtamount": amount.text,
          "txtComment": description.text,
          "auto_cmplt": autoCompleteValue,
          "auto_inc": autoInvoiceValue,
          "Save":"Save"
        },
      );
      if (genmodel != null) {
        print('Status: ${genmodel.message}');
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
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Task > Add Task",
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
               
                _add(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _AddTask(),
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
          "Add Task",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Row _add() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(AddCompany());
          },
          child: Text(
            "Add Company",
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0,
              color: Colors.blue,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Row _add1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            addFile();
            enterFile.clear();
          },
          child: Text(
            "Add File",
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0,
              color: Colors.blue,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Form _AddTask() {
    return Form(
      key: _AddTaskKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: taskName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Task Name',
              suffixIcon: Icon(Icons.task),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.grey,
                ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.lightBlue,
                ),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Task Name';
              }
              if (value.length < 3) {
                return 'Task Name must be at least 3 characters long';
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
                client.text = selectedClientId1 ?? '';
                getUser2();

                // Find the selected client in the clientType list
                final selectedClient = clientType
                    .expand((dataModel) => dataModel.company ?? [])
                    .firstWhereOrNull(
                        (client) => client.id == selectedClientId1);

                if (selectedClient != null) {
                  // Handle selected client
                } else {
                  // Handle when no client is selected
                }
              });
            },
            items: clientType.isNotEmpty
                ? clientType
                    .expand((dataModel) => dataModel.company ?? [])
                    .map<DropdownMenuItem<String>>((dynamic item) {
                    final company = item as Company; // Cast item to Company
                    return DropdownMenuItem<String>(
                      value: company.id ?? '',
                      child: Text('${company.text}'),
                    );
                  }).toList()
                : [],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a client';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'File',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              MultiSelectDialogField<FileDataModel>(
                title: Text('Select File'),
                items: fileList
                    .map((file) => MultiSelectItem<FileDataModel>(
                          file,
                          file.text ?? '',
                        ))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (List<FileDataModel> selectedItems) {
                  setState(() {
                    //clear the previous list
                    selectedFileIds.clear();
                    selectedFileIds = selectedItems
                        .map((item) => item.id!)
                        .toList()
                        .cast<String>();
                  });
                  print(selectedFileIds);
                },
              ),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          TextFormField(
            controller: enterFile,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Enter File',
              suffixIcon: Icon(Icons.file_copy),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.grey,
                ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.lightBlue,
                ),
                gapPadding: 10,
              ),
            ),
          ),
          _add1(),
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
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(selectedDate);

                setState(() {
                  startingDate.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select deadline date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: deadlineDate,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Deadline Date',
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
                  deadlineDate.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Select starting date.';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          DropdownButtonFormField<String>(
            value: selectedDepartmentIds,
            decoration: const InputDecoration(
              labelText: 'Department',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedDepartmentIds = newValue;
                department.text = selectedDepartmentIds ?? '';
                final selectedDepartment = departmentType
                    .expand((dataModel) => dataModel.department ?? [])
                    .firstWhereOrNull(
                        (department) => department.id == selectedDepartmentIds);

                if (selectedDepartment != null) {
                  // Handle selected client
                } else {
                  // Handle when no client is selected
                }
              });
            },
            items: clientType.isNotEmpty
                ? clientType
                    .expand((dataModel) => dataModel.department ?? [])
                    .map<DropdownMenuItem<String>>((dynamic item) {
                    final department =
                        item as Department; // Cast item to Company
                    return DropdownMenuItem<String>(
                      value: department.id ?? '',
                      child: Text('${department.name}'),
                    );
                  }).toList()
                : [],
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
              suffixIcon: Icon(Icons.currency_rupee),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.grey,
                ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.lightBlue,
                ),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Amount';
              }
              if (value.length < 3) {
                return 'Amount must be at least 3 characters long';
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
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.grey,
                ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppTheme.colors.lightBlue,
                ),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Description';
              }
              if (value.length < 3) {
                return 'Description must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Auto Complete', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: autoComplete,
                  onChanged: (value) {
                    setState(() {
                      autoComplete = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.01,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Text('Auto Invoice', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Spacer(), // Add spacer to push checkbox to the right
                Checkbox(
                  value: autoInvoice,
                  onChanged: (value) {
                    setState(() {
                      autoInvoice = value!;
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
             
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_AddTaskKey.currentState!.validate()) {
                taskAdd();
                clearField();
              }
            },
            child: Text(
              "Add Task",
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
