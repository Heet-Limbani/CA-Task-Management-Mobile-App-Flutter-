import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/AdminDataModel/taskOnBoardDataModel.dart';
import 'package:task_manager/ui/Admin/DashBoard/OnBoardTask/detailsEdit.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/taskEdit.dart';
import 'package:task_manager/ui/Admin/DashBoard/TaskView/taskView.dart';
import 'package:task_manager/ui/Admin/Task/addTask.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';

class TaskOnBoard extends StatefulWidget {
  const TaskOnBoard({Key? key}) : super(key: key);

  @override
  State<TaskOnBoard> createState() => _TaskOnBoardState();
}

class _TaskOnBoardState extends State<TaskOnBoard> {
  late TableSource _source;
  String? stringResponse;
  late double deviceWidth;
  late double deviceHeight;
  TextEditingController searchLogController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;

  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  @override
  void initState() {
    super.initState();
    _source = TableSource(startIndex: 0); // Initialize startIndex here
  }

  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Tasks On Board",
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
                _header(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _add(),
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                _table(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Table heading
  Row _header() {
    return Row(
      children: [
        Text(
          "Task On Board",
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
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(() => AddTask());
          },
          child: Text(
            "Add Task",
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
                    labelText: 'Search by User Name',
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
              label: const Text('Task Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Ticket ID'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Client Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Employee Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Department'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Deadline Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Closing Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Status'),
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

class TableSource extends AdvancedDataTableSource<OnBoard> {
  int startIndex; // Add the startIndex variable

  TableSource({required this.startIndex}); // Update the constructor

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  //int startIndex = 0; // Add the startIndex variable

  void delete(id) async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.deleteTask}',
      params: {
        'id': id,
      },
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

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final OnBoard dataList = lastDetails!.rows[index];
    String statusText = '';
    int roundedPercentage = 0;

    if (dataList.status == "0") {
      statusText = "Unassigned";
    } else if (dataList.status == "1") {
      double percentage = double.parse(dataList.taskCompletePercentage ?? '0');
      roundedPercentage = percentage.toInt();
      statusText = "Open $roundedPercentage%";
    } else if (dataList.status == "2") {
      double percentage = double.parse(dataList.taskCompletePercentage ?? '0');
      roundedPercentage = percentage.toInt();
      statusText = "In Progress $roundedPercentage%";
    } else if (dataList.status == "3") {
      statusText = "Query Raised";
    } else if (dataList.status == "4") {
      statusText = "Closed";
    } else if (dataList.status == "5") {
      statusText = "Completed & Reviewed";
    } else if (dataList.status == "6") {
      statusText = "Invoice Raised";
    } else if (dataList.status == "7") {
      statusText = "Paid";
    }

    return DataRow(
      cells: [
        DataCell(Text(srNo)),
        DataCell(Text(dataList.title ?? '')),
        DataCell(Text(dataList.ticketId ?? '')),
        DataCell(Text(dataList.clientName ?? '')),
        DataCell(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dataList.employee?.map((employee) {
                    return Text(
                      '${employee.firstName ?? ''} ${employee.lastName ?? ''}',
                      style: TextStyle(fontSize: 14),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ),
        DataCell(Text(dataList.departmentName ?? '')),
        DataCell(Text(dataList.deadlineDate ?? '')),
        DataCell(Text(dataList.closedOn ?? '')),
        DataCell(Text(statusText)),
        DataCell(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (dataList.status == "0")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(ViewTasksTask(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.remove_red_eye),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(EditTask(id: dataList.ticketId!));
                        },
                        child: Icon(Icons.edit),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Delete",
                            middleText: "Are you sure you want to delete ?",
                            textConfirm: "Yes",
                            textCancel: "No",
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.red,
                            cancelTextColor: Colors.black,
                            onConfirm: () {
                              delete(dataList.ticketId);
                              Get.back();
                            },
                            onCancel: () {},
                          );
                        },
                        child: Icon(Icons.delete),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(DetailsEdit(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.close),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                if (dataList.status == "1" ||
                    dataList.status == "2" ||
                    dataList.status == "3")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(ViewTasksTask(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.remove_red_eye),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(EditTask(id: dataList.ticketId!));
                        },
                        child: Icon(Icons.edit),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(DetailsEdit(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.close),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                if (dataList.status == "4")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(ViewTasksTask(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.remove_red_eye),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(EditTask(id: dataList.ticketId!));
                        },
                        child: Icon(Icons.edit),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          // Handle button pressed
                        },
                        child: Icon(Icons.check),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(DetailsEdit(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.close),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                if (dataList.status == "5")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(ViewTasksTask(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.remove_red_eye),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(EditTask(id: dataList.ticketId!));
                        },
                        child: Icon(Icons.edit),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          // Handle button pressed
                        },
                        child: Icon(Icons.list_alt),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                if (dataList.status == "6")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(ViewTasksTask(ticketId: dataList.ticketId!));
                        },
                        child: Icon(Icons.remove_red_eye),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      // RawMaterialButton(
                      //   onPressed: () {
                      //     // Handle button pressed
                      //   },
                      //   child: Icon(Icons.currency_rupee),
                      //   constraints: BoxConstraints.tight(Size(24, 24)),
                      //   shape: CircleBorder(),
                      // ),
                    ],
                  ),
                if (dataList.status == "7")
                  RawMaterialButton(
                    onPressed: () {
                      Get.to(ViewTasksTask(ticketId: dataList.ticketId!));
                    },
                    child: Icon(Icons.remove_red_eye),
                    constraints: BoxConstraints.tight(Size(24, 24)),
                    shape: CircleBorder(),
                  ),
              ],
            ),
          ),
        ),
      ],
      // selected: selectedIds.contains(dataList.ticketId),
      // onSelectChanged: (value) {
      //   selectedRow(dataList.ticketId.toString(), value ?? false);
      // },
    );
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<OnBoard>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.loadTaskOnboard}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      return RemoteDataSourceDetails(
        dataModel.count ?? 0,
        dynamicData
            .map<OnBoard>(
              (item) => OnBoard.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<OnBoard>(
                  (item) => OnBoard.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
