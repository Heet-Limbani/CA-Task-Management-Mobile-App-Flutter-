import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:task_manager/API/model/editTaskDataModel.dart';
import 'package:task_manager/API/model/fileDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/viewTasksDataModel2.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/subtaskAdd.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/subtaskEdit.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Resources/res/color.dart';
import 'package:task_manager/ui/Admin/Company/addCompany.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:collection/collection.dart'; // Import the 'collection' package for the 'firstWhereOrNull' method
import 'package:advanced_datatable/datatable.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';

class EditTask extends StatefulWidget {
  final String? id;
  const EditTask({required this.id, Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

String id = '';
String ticketId = '';
int dataCount = 0;

class _EditTaskState extends State<EditTask> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

   TextEditingController _searchController = TextEditingController();

  late TableSource _source;
  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;

  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

  final GlobalKey<FormState> _EditTaskKey = GlobalKey<FormState>();
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
  EditTaskDataModel? taskDataModel;
  List<EditTaskDataModel> companyGroupDataList = [];
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
    id = widget.id!;
    ticketId = widget.id!;
     _source = TableSource(context);
    _source.setNextView();
    getUser();
  }
   void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  List<EditTaskDataModel> employeeGroupDataList = [];
  List<EditTaskDataModel> clientType = [];
  List<EditTaskDataModel> departmentType = [];

  void getUser() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editTask}',
        params: {
          "id": id,
        },
      );

      if (genmodel != null &&
          genmodel.status == true &&
          genmodel.data != null) {
        final data = genmodel.data!;
        taskDataModel = EditTaskDataModel.fromJson(data);

        final taskData = EditTaskDataModel.fromJson(data);
        employeeGroupDataList.clear();
        clientType.clear();
        departmentType.clear();

        employeeGroupDataList.add(taskData);
        clientType.add(taskData);
        departmentType.add(taskData);
        selectedClientId1 = taskData.data!.clientId!;
        selectedDepartmentIds = taskData.data!.depId!;
        selectedFileIds = taskData.data!.fileId!.split(',');
        print("selectedFileIds: $selectedFileIds");
        taskName.text = taskData.data!.title!;
        client.text = taskData.data!.clientId!;
        startingDate.text = taskData.data!.startingDate!;
        deadlineDate.text = taskData.data!.deadlineDate!;
        department.text = taskData.data!.depId!;
        amount.text = taskData.data!.amount!;
        description.text = taskData.data!.description!;
        autoComplete =
            taskData.data!.autoCompleteAndReview == "1" ? true : false;
        autoInvoice = taskData.data!.autoInvoice == "1" ? true : false;

        setState(() {});
        getUser2();
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
        "id": selectedClientId1.toString(),
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

    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editTask}',
        params: {
          "id": id,
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
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Task > Edit Task",
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
                _EditTask(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _add2(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _header2(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _table(),
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
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

  Row _header2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Task List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        const Spacer(),
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
              if (_EditTaskKey.currentState!.validate()) {
                taskAdd();
              }
            },
            child: Text(
              "Edit Task",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
        ],
      ),
    );
  }

  Row _add2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(() => SubtaskAdd(userId: ticketId));
          },
          child: Text(
            "Add Subtask",
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

  Column _table() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                  ),
                  onSubmitted: (vlaue) {
                    _source.filterServerSide(_searchController.text);
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _searchController.text = '';
                });
                _source.filterServerSide(_searchController.text);
                ;
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () => _source.filterServerSide(_searchController.text),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: refreshTable,
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.03,
        ),
        AdvancedPaginatedDataTable(
          loadingWidget: () => UniversalShimmer(
            itemCount: dataCount,
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
          ),
          addEmptyRows: false,
          source: _source,
          showHorizontalScrollbarAlways: true,
          sortAscending: _sortAsc,
          sortColumnIndex: _sortIndex,
          showFirstLastButtons: true,
          rowsPerPage: _rowsPerPage,
          availableRowsPerPage: const [10, 20, 50, 100, 200],
          onRowsPerPageChanged: (newRowsPerPage) {
            if (newRowsPerPage != null) {
              setState(() {
                _rowsPerPage = newRowsPerPage;
              });
            }
          },
          columns: [
            DataColumn(
              label: const Text('Sr. No.'),
              numeric: true,
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Task'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Employee'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Tax Payable'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Tax Payable Till Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Action'),
              onSort: setSort,
            ),
          ],
          //Optianl override to support custom data row text / translation
          getFooterRowText:
              (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
            final localizations = MaterialLocalizations.of(context);
            var amountText = localizations.pageRowsInfoTitle(
              startRow,
              pageSize,
              totalFilter ?? totalRowsWithoutFilter,
              false,
            );

            if (totalFilter != null) {
              //Filtered data source show addtional information
              amountText += ' filtered from ($totalRowsWithoutFilter)';
            }

            return amountText;
          },
          customTableFooter: _customFooter
              ? (source, offset) {
                  const maxPagesToShow = 6;
                  const maxPagesBeforeCurrent = 3;
                  final lastRequestDetails = source.lastDetails!;
                  final rowsForPager = lastRequestDetails.filteredRows ??
                      lastRequestDetails.totalRows;
                  final totalPages = rowsForPager ~/ _rowsPerPage;
                  final currentPage = (offset ~/ _rowsPerPage) + 1;
                  final List<int> pageList = [];
                  if (currentPage > 1) {
                    pageList.addAll(
                      List.generate(currentPage - 1, (index) => index + 1),
                    );
                    //Keep up to 3 pages before current in the list
                    pageList.removeWhere(
                      (element) =>
                          element < currentPage - maxPagesBeforeCurrent,
                    );
                  }
                  pageList.add(currentPage);
                  //Add reminding pages after current to the list
                  pageList.addAll(
                    List.generate(
                      maxPagesToShow - (pageList.length - 1),
                      (index) => (currentPage + 1) + index,
                    ),
                  );
                  pageList.removeWhere((element) => element > totalPages);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: pageList
                        .map(
                          (e) => TextButton(
                            onPressed: e != currentPage
                                ? () {
                                    //Start index is zero based
                                    source.setNextView(
                                      startIndex: (e - 1) * _rowsPerPage,
                                    );
                                  }
                                : null,
                            child: Text(
                              e.toString(),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              : null,
        ),
      ],
    );
  }
}
typedef SelectedCallBack = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<TasksData2> {
  final BuildContext context;

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<TasksData2>? lastDetails;

  void subTaskDelete(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.subtaskDelete}',
        params: {'subtask_id': id},
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
  }


  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<TasksData2> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final TasksData2 dataList = rows[index];
      final List<Subtask2>? subtasks = dataList.subtask;
      

      if (subtasks != null && subtasks.isNotEmpty) {
        final Subtask2 subtask = subtasks.first;
         final parsedDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(subtask.taxPayableTillDate ?? '') * 1000);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(subtask.title ?? '')),
            DataCell(
              Row(
                children: [
                  Text(subtask.firstName ?? ''),
                  Text(subtask.lastName ?? ''),
                ],
              ),
            ),
            DataCell(Text(subtask.taxPayable ?? '')),
            DataCell(Text(formattedDate)),
            DataCell(
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            Get.to(() => SubtaskEdit(
                                userId: subtask.subtaskId.toString()));
                          },
                          child: Icon(Icons.edit),
                          constraints: BoxConstraints.tight(Size(24, 24)),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            subTaskDelete(subtask.subtaskId.toString());
                          },
                          child: Icon(Icons.delete),
                          constraints: BoxConstraints.tight(Size(24, 24)),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    }
    return null;
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<TasksData2>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
      'id': ticketId.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.taskViewTaskDetails}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      int subtaskCount = 0;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('subtask')) {
        final dynamicList = dynamicData['subtask'] as List<dynamic>?;
        subtaskCount = dynamicList?.length ?? 0;
        dataCount = subtaskCount;
        final List<TasksData2> dataList = dynamicList
                ?.map<TasksData2>(
                    (item) => TasksData2(subtask: [Subtask2.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<TasksData2>(
          //dataModel.count ?? 0,
          subtaskCount,
          dataList,
          filteredRows: lastSearchTerm.isNotEmpty ? dataList.length : null,
        );
      } else {
        throw Exception('Invalid dynamicData format');
      }

      return lastDetails!;
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
