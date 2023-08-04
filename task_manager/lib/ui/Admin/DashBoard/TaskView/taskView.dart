import 'package:advanced_datatable/datatable.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/API/Admin%20DataModel/viewTasksDataModel.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/subtaskAdd.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/subtaskEdit.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/taskCharge.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/taskEdit.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/taskFile.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class ViewTasksTask extends StatefulWidget {
  final String ticketId;
  const ViewTasksTask({required this.ticketId, Key? key}) : super(key: key);

  @override
  State<ViewTasksTask> createState() => _ViewTasksTaskState();
}

late double deviceWidth;
late double deviceHeight;

// Declare _source here

TextEditingController descriptionController = TextEditingController();
TextEditingController clientNameController = TextEditingController();
TextEditingController clientNumberController = TextEditingController();
TextEditingController clientEmailController = TextEditingController();
TextEditingController startingDateController = TextEditingController();
TextEditingController deadlineDateController = TextEditingController();
TextEditingController createdDateController = TextEditingController();
bool isObscurePassword = true;
String ticketId = "";
int dataCount = 0;
String? selectedClientId1;

class _ViewTasksTaskState extends State<ViewTasksTask> {
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
  @override
  void initState() {
    super.initState();
    ticketId = widget.ticketId; // Store widget.userId in a local variable
    // getUser();
    _source = TableSource(context);
    _source.setNextView();
    getTaskDetails();
  }

  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  List<Subtask> subtaskList = [];

  void getTaskDetails() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.taskViewTaskDetails}',
      params: {
        'id': ticketId.toString(),
      },
    );
    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      final taskData = TasksData.fromJson(data);

      descriptionController.text = taskData.data!.description.toString();
      startingDateController.text = taskData.data!.startingDate.toString();
      deadlineDateController.text = taskData.data!.deadlineDate.toString();
      createdDateController.text = taskData.data!.createdOn.toString();
      clientNameController.text = taskData.company!.name.toString();
      clientNumberController.text = taskData.company!.mobile.toString();
      clientEmailController.text = taskData.company!.email.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Tasks",
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
                  height: deviceHeight * 0.05,
                ),
                _detail(),
                _add(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _header1(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _detail1(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _add2(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _table(),
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
                _button(),
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

  Column _detail() {
    return Column(
      children: [
        buildTextField("Description", descriptionController.text, false),
      ],
    );
  }

  Row _add() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(() => EditTask(id: ticketId));
          },
          child: Text(
            "Edit",
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

  Row _header1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Main Task Details",
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

  Column _detail1() {
    return Column(
      children: [
        buildTextField1("Client Name", clientNameController.text, false),
        buildTextField1("Client Number", clientNumberController.text, false),
        buildTextField1("Client Email", clientEmailController.text, false),
        buildTextField1("Starting Date", startingDateController.text, false),
        buildTextField1("Deadline Date", deadlineDateController.text, false),
        buildTextField1("Created Date", createdDateController.text, false),
      ],
    );
  }

  Row _header() {
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

  Row _button() {
    return Row(
      children: [
        SizedBox(
          width: deviceWidth * 0.1,
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    TodaysTaskFile(ticketId: ticketId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'File Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // Add more buttons for additional tables
        SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         ClientTicketDetails(userId: ticketId),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       return FadeTransition(opacity: animation, child: child);
            //     },
            //   ),
            // );
          },
          child: Text(
            'Chat',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    TodaysTaskCharge(ticketId: ticketId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Charges',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        readOnly: true,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextField1(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        readOnly: true,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            )),
      ),
    );
  }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<TasksData> {
  final BuildContext context;

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<TasksData>? lastDetails;

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
    final List<TasksData> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final TasksData dataList = rows[index];
      final List<Subtask>? subtasks = dataList.subtask;
      

      if (subtasks != null && subtasks.isNotEmpty) {
        final Subtask subtask = subtasks.first;
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
  Future<RemoteDataSourceDetails<TasksData>> getNextPage(
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
        final List<TasksData> dataList = dynamicList
                ?.map<TasksData>(
                    (item) => TasksData(subtask: [Subtask.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<TasksData>(
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
