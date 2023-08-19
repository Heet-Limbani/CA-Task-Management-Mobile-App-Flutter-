import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/AdminDataModel/clientDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/getUsersDataModel.dart';
import 'package:task_manager/API/EmployeeDataModel/employeeDashboardDataModel.dart';
import 'package:task_manager/ui/Employee/Dashboard/TaskViewEmployee/taskViewEmployee.dart';
import 'package:task_manager/ui/Employee/Sidebar/sidebarEmployee.dart';
import 'package:task_manager/ui/Resources/res/color.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/AdminDataModel/clientLogDataModel.dart';

class HomeEmployeeScreen extends StatefulWidget {
  const HomeEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<HomeEmployeeScreen> createState() => _HomeEmployeeScreenState();
}

int dataCount3 = 0;
int dataCount1 = 0;
int dataCount2 = 0;
int subtaskCount = 0;
int subtaskCount1 = 0;
int subtaskCount2 = 0;
int subtaskCount3 = 0;
int subtaskCount4 = 0;

class _HomeEmployeeScreenState extends State<HomeEmployeeScreen> {
  final _source1 = TableSource();
  var _sortIndex1 = 0;
  var _sortAsc1 = true;
  var _customFooter1 = false;
  var _rowsPerPage1 = AdvancedPaginatedDataTable.defaultRowsPerPage;
  TextEditingController _searchController1 = TextEditingController();

  void setSort1(int i, bool asc) => setState(() {
        _sortIndex1 = i;
        _sortAsc1 = asc;
      });

  List<GetUser> clientType = [];
  List<ClientData> clientsdata = [];
  late double deviceWidth;
  late double deviceHeight;
  int offset = 0;
  int limit = 10;
  bool showTablePending = false;
  bool showTablePayable = false;
  bool showTableQuery = false;
  bool showTableOverdue = false;
  bool showTableTask = false;
  bool showHideAll = false;
  bool showSeeAll = true;
  DateTime? selectedDateTime = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dashBoard();
  }

  void clear() {}

  List<Client> clients = [];
  int currentPage = 0;
  int rowsPerPage = 10;
  int totalCount = 0;
  genModel? dataModel;

  void refreshTable1() {
    setState(() {
      _source1.startIndex = 0;
      _source1.setNextView();
    });
  }

  EmployeeDashboardDataModel? taskData;
  void dashBoard() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.employeeDashboard}');
    if (genmodel != null && genmodel.status == true) {
      final dynamicData = genmodel.data;
      if (dynamicData is Map<String, dynamic>) {
        taskData = EmployeeDashboardDataModel.fromJson(dynamicData);
        final dynamicList = dynamicData['tasks'] as List<dynamic>?;
        final dynamicList1 = dynamicData['pending'] as List<dynamic>?;
        final dynamicList2 =
            dynamicData['total_overdue_task'] as List<dynamic>?;
        final dynamicList3 = dynamicData['total_hold_task'] as List<dynamic>?;
        final dynamicList4 =
            dynamicData['total_query_raised'] as List<dynamic>?;

        subtaskCount = dynamicList?.length ?? 0;
        subtaskCount1 = dynamicList1?.length ?? 0;
        subtaskCount2 = dynamicList2?.length ?? 0;
        subtaskCount3 = dynamicList3?.length ?? 0;
        subtaskCount4 = dynamicList4?.length ?? 0;
      } else {
        throw Exception('Invalid dynamicData format');
      }
    } else {
      throw Exception('Unable to query remote server');
    }
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
                  height: deviceHeight * 0.02,
                ),
                _admin(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _admin() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              "Employee Dashboard",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              // toolbarOptions: const ToolbarOptions(
              //   copy: true,
              //   selectAll: true,
              // ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.03,
        ),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: InkWell(
                onTap: () {
                  if (subtaskCount != 0) {
                    setState(() {
                      showTableTask = !showTableTask;
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTableTask
                            ? "Today's Task Added to Task List"
                            : "Today's Task Removed from Task List",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.today_rounded,
                  taskCount: subtaskCount,
                  taskGroup: "Today's Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.1,
              child: InkWell(
                onTap: () {
                  if (subtaskCount1 != 0) {
                    setState(() {
                      showTablePending = !showTablePending;
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTablePending
                            ? "Pending Task Added to Task List"
                            : "Pending Task Removed from Task List",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.red,
                  icon: Icons.pending_actions,
                  taskCount: subtaskCount1,
                  taskGroup: "Pending Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if (subtaskCount2 != 0) {
                    setState(() {
                      showTablePayable =
                          !showTablePayable; // Toggle the visibility of the table
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTablePayable
                            ? "Task Payable Added to Task List"
                            : "Task Payble Removed from Task List",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.orange,
                  isSmall: true,
                  icon: Icons.attach_money,
                  taskCount: subtaskCount2,
                  taskGroup: "Tax Payable",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if (subtaskCount3 != 0) {
                    setState(() {
                      showTableQuery =
                          !showTableQuery; // Toggle the visibility of the table
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTableQuery
                            ? "Query Added to Task List"
                            : "Query Task Removed from Task List",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {
                          // Perform any action on snackbar action press (if needed)
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.purple,
                  isSmall: true,
                  icon: Icons.live_help_rounded,
                  taskCount: subtaskCount4,
                  taskGroup: "Query Raised",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Task List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            if (showSeeAll) ...{
              InkWell(
                onTap: () {
                  setState(() {
                    showTableTask = true;
                    showTablePending = true;
                    showTableOverdue = true;
                    showTablePayable = true;
                    showTableQuery = true;
                    showHideAll = true;
                    showSeeAll = false;
                  });
                },
                child: Text(
                  "See all",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            },
            if (showHideAll) ...{
              InkWell(
                onTap: () {
                  setState(() {
                    showTableTask = false;
                    showTablePending = false;
                    showTableOverdue = false;
                    showTablePayable = false;
                    showTableQuery = false;
                    showHideAll = false;
                    showSeeAll = true;
                  });
                },
                child: Text(
                  "Hide all",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            },
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        if (showTableTask) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Todays Tasks",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Task Name'), numeric: true),
                            DataColumn(label: Text('Ticket Id')),
                            DataColumn(label: Text('Client Name')),
                            DataColumn(label: Text('Employee Name')),
                            DataColumn(label: Text('Deadline')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('View')),
                          ],
                          rows: taskData?.tasks?.map(
                                (tasks) {
                                  final taskName = tasks.title ?? '';
                                  final ticketId = tasks.ticketId ?? '';
                                  final clientName = tasks.clientName ?? '';
                                  final employeeName = tasks.employeeName ?? '';
                                  final deadline = tasks.cdeadlineDate ?? '';
                                  int roundedPercentage = 0;
                                  double percentage = double.parse(
                                      tasks.taskCompletePercentage!);
                                  roundedPercentage = percentage.toInt();
                                  final statusText = "$roundedPercentage%";

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(taskName)),
                                      DataCell(Text(ticketId)),
                                      DataCell(Text(clientName)),
                                      DataCell(Text(employeeName)),
                                      DataCell(Text(deadline)),
                                      DataCell(Text(statusText)),
                                      DataCell(
                                        IconButton(
                                          onPressed: () {
                                            Get.to(
                                              ViewTasksTaskEmployee(
                                                  ticketId: ticketId),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList() ??
                              [],
                          dataRowMinHeight: 32.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        },
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        if (showTablePending) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Pending Tasks",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Task Name'), numeric: true),
                            DataColumn(label: Text('Ticket Id')),
                            DataColumn(label: Text('Client Name')),
                            DataColumn(label: Text('Employee Name')),
                            DataColumn(label: Text('Deadline')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('View')),
                          ],
                          rows: taskData?.pending?.map(
                                (pending) {
                                  final taskName = pending.title ?? '';
                                  final ticketId = pending.ticketId ?? '';
                                  final clientName = pending.clientName ?? '';
                                  final employeeName =
                                      pending.employeeName ?? '';
                                  final deadline = pending.cdeadlineDate ?? '';

                                  int roundedPercentage = 0;
                                  double percentage = double.parse(
                                      pending.taskCompletePercentage!);
                                  roundedPercentage = percentage.toInt();
                                  final statusText = "$roundedPercentage%";

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(taskName)),
                                      DataCell(Text(ticketId)),
                                      DataCell(Text(clientName)),
                                      DataCell(Text(employeeName)),
                                      DataCell(Text(deadline)),
                                      DataCell(Text(statusText)),
                                      DataCell(
                                        IconButton(
                                          onPressed: () {
                                            Get.to(
                                              ViewTasksTaskEmployee(
                                                  ticketId: pending.ticketId!),
                                              // ViewPendingTask(
                                              //     ticketId: pending.ticketId!),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList() ??
                              [],
                          dataRowMinHeight: 32.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        },
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        if (showTablePayable) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Tax Payable",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Task Name'), numeric: true),
                            DataColumn(label: Text('Ticket Id')),
                            DataColumn(label: Text('Client Name')),
                            DataColumn(label: Text('Employee Name')),
                            DataColumn(label: Text('Deadline')),
                            DataColumn(label: Text('Query')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Tax Payable')),
                          ],
                          rows: taskData?.totalOverdueTask?.map(
                                (taxPayable) {
                                  final taskName = taxPayable.title ?? '';
                                  final ticketId = taxPayable.ticketId ?? '';
                                  final clientName =
                                      taxPayable.clientName ?? '';
                                  final employeeName =
                                      taxPayable.employeeName ?? '';
                                  final deadline =
                                      taxPayable.cdeadlineDate ?? '';

                                  final query =
                                      taxPayable.lastReplyByText ?? '';

                                  int roundedPercentage = 0;
                                  double percentage = double.parse(
                                      taxPayable.taskCompletePercentage!);
                                  roundedPercentage = percentage.toInt();
                                  final statusText = "$roundedPercentage%";

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(taskName)),
                                      DataCell(Text(ticketId)),
                                      DataCell(Text(clientName)),
                                      DataCell(Text(employeeName)),
                                      DataCell(Text(deadline)),
                                      DataCell(Text(query)),
                                      DataCell(Text(statusText)),
                                      DataCell(
                                        IconButton(
                                          onPressed: () {
                                            Get.to(
                                              ViewTasksTaskEmployee(
                                                  ticketId:
                                                      taxPayable.ticketId!),
                                              // ViewPendingTask(
                                              //     ticketId: pending.ticketId!),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList() ??
                              [],
                          dataRowMinHeight: 32.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        },
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        if (showTableQuery) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Query Raised",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Task Name'), numeric: true),
                            DataColumn(label: Text('Ticket Id')),
                            DataColumn(label: Text('Client Name')),
                            DataColumn(label: Text('Employee Name')),
                            DataColumn(label: Text('Deadline')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: taskData?.totalQueryRaised?.map(
                                (totalQueryRaised) {
                                  final taskName = totalQueryRaised.title ?? '';
                                  final ticketId =
                                      totalQueryRaised.ticketId ?? '';
                                  final clientName =
                                      totalQueryRaised.clientName ?? '';
                                  final employeeName =
                                      totalQueryRaised.employeeName ?? '';
                                  final deadline =
                                      totalQueryRaised.cdeadlineDate ?? '';

                                  int roundedPercentage = 0;
                                  double percentage = double.parse(
                                      totalQueryRaised.taskCompletePercentage!);
                                  roundedPercentage = percentage.toInt();
                                  final statusText = "$roundedPercentage%";

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(taskName)),
                                      DataCell(Text(ticketId)),
                                      DataCell(Text(clientName)),
                                      DataCell(Text(employeeName)),
                                      DataCell(Text(deadline)),
                                      DataCell(Text(statusText)),
                                      DataCell(
                                        IconButton(
                                          onPressed: () {
                                            Get.to(
                                              ViewTasksTaskEmployee(
                                                  ticketId: totalQueryRaised
                                                      .ticketId!),
                                              // ViewPendingTask(
                                              //     ticketId: pending.ticketId!),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList() ??
                              [],
                          dataRowMinHeight: 32.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        },
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          children: [
            Text(
              "Holiday List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
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
                  controller: _searchController1,
                  decoration: const InputDecoration(
                    labelText: 'Search by User Name',
                  ),
                  onSubmitted: (vlaue) {
                    _source1.filterServerSide(_searchController1.text);
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _searchController1.text = '';
                });
                _source1.filterServerSide(_searchController1.text);
                ;
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () =>
                  _source1.filterServerSide(_searchController1.text),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: refreshTable1,
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),

        AdvancedPaginatedDataTable(
          loadingWidget: () => UniversalShimmer(
            itemCount: dataCount3,
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
          ),
          addEmptyRows: false,
          source: _source1,
          showHorizontalScrollbarAlways: true,
          sortAscending: _sortAsc1,
          sortColumnIndex: _sortIndex1,
          showFirstLastButtons: true,
          rowsPerPage: _rowsPerPage1,
          availableRowsPerPage: const [10, 20, 50, 100, 200],

          onRowsPerPageChanged: (newRowsPerPage) {
            if (newRowsPerPage != null) {
              setState(() {
                _rowsPerPage1 = newRowsPerPage;
              });
            }
          },
          columns: [
            DataColumn(
              label: const Text('Sr. No.'),
              numeric: true,
              onSort: setSort1,
            ),
            DataColumn(
              label: const Text('Title'),
              onSort: setSort1,
            ),
            DataColumn(
              label: const Text('Description'),
              onSort: setSort1,
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: setSort1,
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
          customTableFooter: _customFooter1
              ? (source1, offset) {
                  const maxPagesToShow = 6;
                  const maxPagesBeforeCurrent = 3;
                  final lastRequestDetails = source1.lastDetails!;
                  final rowsForPager = lastRequestDetails.filteredRows ??
                      lastRequestDetails.totalRows;
                  final totalPages = rowsForPager ~/ _rowsPerPage1;
                  final currentPage = (offset ~/ _rowsPerPage1) + 1;
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
                                    source1.setNextView(
                                      startIndex: (e - 1) * _rowsPerPage1,
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
        SizedBox(
          height: deviceHeight * 0.1,
        ),

        //     Column(
        //       children: <Widget>[
        //         SingleChildScrollView(
        //           scrollDirection: Axis.horizontal,
        //           child: Row(
        //             children: [
        //               DataTable(
        //                 columns: const [
        //                   DataColumn(label: Text('Sr. No.'), numeric: true),
        //                   DataColumn(label: Text('Title')),
        //                   DataColumn(label: Text('Description')),
        //                   DataColumn(label: Text('Date')),
        //                 ],
        //                 rows: dataHolidayList?.holiday?.map((holiday) {
        //                       final index =
        //                           dataHolidayList?.holiday?.indexOf(holiday) ?? -1;
        //                       final srNo = (index + 1).toString();
        //                       final title = holiday.title ?? '';
        //                       final description = holiday.description ?? '';
        //                       final date = DateTime.fromMillisecondsSinceEpoch(
        //                           (int.tryParse(holiday.date!.toString()) ?? 0) *
        //                               1000);
        //                       final formattedDate =
        //                           DateFormat('dd/MM/yyyy').format(date);
        //                       return DataRow(cells: [
        //                         DataCell(Text(srNo)),
        //                         DataCell(Text(title)),
        //                         DataCell(Text(description)),
        //                         DataCell(Text(formattedDate.toString())),
        //                       ]);
        //                     }).toList() ??
        //                     [],
        //                 dataRowHeight: 32.0,
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        // for setting custom footer adv dtable
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.table_chart_outlined),
          //   tooltip: 'Change footer',
          //   onPressed: () {
          //     // handle the press
          //     setState(() {
          //       _customFooter = !_customFooter;
          //     });
          //   },
          // ),
        ],
        elevation: 0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: CircleGradientIcon(
        //       onTap: () {},
        //       icon: Icons.calendar_month,
        //       color: Colors.purple,
        //       iconSize: 24,
        //       size: 40,
        //     ),
        //   )
        // ],
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarEmployee(),
      extendBody: true,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildBody(), //try now
      ),
    );
  }
}

typedef SelectedCallBack1 = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<EmployeeDashboardDataModel> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<EmployeeDashboardDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<EmployeeDashboardDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final EmployeeDashboardDataModel dataList = rows[index];
      final List<Holiday>? holidays = dataList.holiday;

      if (holidays != null && holidays.isNotEmpty) {
        final Holiday holiday = holidays.first;
        final parsedDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(holiday.date ?? '0') * 1000);
        final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(holiday.title ?? '')),
            DataCell(Text(holiday.description ?? '')),
            DataCell(Text(formattedDate)),
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
  Future<RemoteDataSourceDetails<EmployeeDashboardDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.employeeDashboard}',
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      final holidayList = dynamicData['holiday'];
      int count = holidayList.length ?? 0;
      dataCount3 = count;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('holiday')) {
        final dynamicList = dynamicData['holiday'] as List<dynamic>?;
        final List<EmployeeDashboardDataModel> dataList = dynamicList
                ?.map<EmployeeDashboardDataModel>((item) =>
                    EmployeeDashboardDataModel(
                        holiday: [Holiday.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<EmployeeDashboardDataModel>(
          // dataModel.count ?? 0,
          count,
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
