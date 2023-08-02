import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/clientDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import 'package:task_manager/API/model/unAssignTaskDataModel.dart';
import 'package:task_manager/ui/Resources/res/color.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/clientLogDataModel.dart';

class UnAssignTask extends StatefulWidget {
  const UnAssignTask({Key? key}) : super(key: key);

  @override
  State<UnAssignTask> createState() => _UnAssignTaskState();
}

int subtaskCount = 0;
int subtaskCount1 = 0;
int subtaskCount2 = 0;

int dataCount3 = 0;
int dataCount1 = 0;
int dataCount2 = 0;

class _UnAssignTaskState extends State<UnAssignTask> {
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

  final _source2 = TableSource2();
  var _sortIndex2 = 0;
  var _sortAsc2 = true;
  var _customFooter2 = false;
  var _rowsPerPage2 = AdvancedPaginatedDataTable.defaultRowsPerPage;
  TextEditingController _searchController2 = TextEditingController();

  void setSort2(int i, bool asc) => setState(() {
        _sortIndex1 = i;
        _sortAsc1 = asc;
      });

// end here

  List<GetUser> clientType = [];
  List<ClientData> clientsdata = [];

  late double deviceWidth;
  late double deviceHeight;

  TextEditingController clientController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController searchLogController = TextEditingController();
  String clientId = "";
  String selectedClientId = "";
  String clientName = '';
  String message = "";
  String description = "";
  String date = '';
  int offset = 0;
  int limit = 10;
  String? selectedClientId1;
  bool showTableAll = false;
  bool showTableManual = false;
  bool showTableGroup = false;
  bool showHideAll = false;
  bool showSeeAll = true;

  DateTime? selectedDateTime = DateTime.now();
  @override
  void dispose() {
    clientController.dispose();
    messageController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    searchLogController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unAssign();
  }

  void clear() {
    clientController.clear();
    messageController.clear();
    descriptionController.clear();
    dateController.clear();
  }

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

  void refreshTable2() {
    setState(() {
      _source2.startIndex = 0;
      _source2.setNextView();
    });
  }

  void unAssign() async {
    genModel? genmodel = await Urls.postApiCall(method: '${Urls.unAssignTask}');
    if (genmodel != null && genmodel.status == true) {
      final dynamicData = genmodel.data;
      if (dynamicData is Map<String, dynamic>) {
        final dynamicList = dynamicData['all_task'] as List<dynamic>?;
        final dynamicList1 = dynamicData['manual'] as List<dynamic>?;
        final dynamicList2 = dynamicData['group_data'] as List<dynamic>?;
        subtaskCount = dynamicList?.length ?? 0;
        subtaskCount1 = dynamicList1?.length ?? 0;
        subtaskCount2 = dynamicList2?.length ?? 0;
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

                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: clients.length,
                //   itemBuilder: (context, index) {
                //     final client = clients[index];
                //     return ListTile(
                //       title: Text(client.client ?? ''),
                //       subtitle: Text(client.message ?? ''),
                //     );
                //   },
                // ),

                //_client(),

                //_employee(),
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
              "UnAssigned Task ",
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
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.1,
              child: InkWell(
                onTap: () {
                  if (subtaskCount != 0) {
                    setState(() {
                      showTableAll = !showTableAll;
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTableAll
                            ? "All Task Added to Task List"
                            : "All Task Removed from Task List",
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
                  icon: Icons.clear_all,
                  taskCount:
                      subtaskCount, //dataCount?.count?.pendingCount ?? '0',
                  taskGroup: "All Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if (subtaskCount1 != 0) {
                    setState(() {
                      showTableManual = !showTableManual;
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTableManual
                            ? "Manual Task Added to Task List"
                            : "Manual Task Removed from Task List",
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
                  color: Colors.purple,
                  icon: Icons.edit_attributes_outlined,
                  taskCount:
                      subtaskCount1, //dataCount?.count?.tasksCount ?? '0',
                  taskGroup: "Manual Task",
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
                      showTableGroup =
                          !showTableGroup; // Toggle the visibility of the table
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTableGroup
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
                  icon: Icons.group,
                  taskCount:
                      subtaskCount2, //dataCount?.count?.taxPayableCount ?? '0',
                  taskGroup: "GH Group",
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
                    showTableAll = true;
                    showTableManual = true;
                    showTableGroup = true;
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
                    showTableAll = false;
                    showTableManual = false;
                    showTableGroup = false;
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
        if (showTableAll) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "All Task",
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
                    label: const Text('Task Name'),
                    onSort: setSort1,
                  ),
                  DataColumn(
                    label: const Text('Ticket ID'),
                    onSort: setSort1,
                  ),
                  DataColumn(
                    label: const Text('Client Name'),
                    onSort: setSort1,
                  ),
                  DataColumn(
                    label: const Text('Department'),
                    onSort: setSort1,
                  ),
                  DataColumn(
                    label: const Text('Deadline'),
                    onSort: setSort1,
                  ),
                  DataColumn(
                    label: const Text('Status'),
                    onSort: setSort1,
                  ),
                  DataColumn(
                    label: const Text('Action'),
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
                            List.generate(
                                currentPage - 1, (index) => index + 1),
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
            ],
          ),
        },
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        if (showTableManual) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Manual Tasks",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _searchController2,
                        decoration: const InputDecoration(
                          labelText: 'Search by User Name',
                        ),
                        onSubmitted: (vlaue) {
                          _source2.filterServerSide(_searchController2.text);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchController2.text = '';
                      });
                      _source2.filterServerSide(_searchController2.text);
                      ;
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () =>
                        _source2.filterServerSide(_searchController2.text),
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                    ),
                    onPressed: refreshTable2,
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              AdvancedPaginatedDataTable(
                loadingWidget: () => UniversalShimmer(
                  itemCount: dataCount2,
                  deviceHeight: deviceHeight,
                  deviceWidth: deviceWidth,
                ),
                addEmptyRows: false,
                source: _source2,
                showHorizontalScrollbarAlways: true,
                sortAscending: _sortAsc2,
                sortColumnIndex: _sortIndex2,
                showFirstLastButtons: true,
                rowsPerPage: _rowsPerPage2,
                availableRowsPerPage: const [10, 20, 50, 100, 200],

                onRowsPerPageChanged: (newRowsPerPage) {
                  if (newRowsPerPage != null) {
                    setState(() {
                      _rowsPerPage2 = newRowsPerPage;
                    });
                  }
                },
                columns: [
                  DataColumn(
                    label: const Text('Sr. No.'),
                    numeric: true,
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Task Name'),
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Ticket ID'),
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Client Name'),
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Department'),
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Deadline'),
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Status'),
                    onSort: setSort2,
                  ),
                  DataColumn(
                    label: const Text('Action'),
                    onSort: setSort2,
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
                customTableFooter: _customFooter2
                    ? (source1, offset) {
                        const maxPagesToShow = 6;
                        const maxPagesBeforeCurrent = 3;
                        final lastRequestDetails = source1.lastDetails!;
                        final rowsForPager = lastRequestDetails.filteredRows ??
                            lastRequestDetails.totalRows;
                        final totalPages = rowsForPager ~/ _rowsPerPage2;
                        final currentPage = (offset ~/ _rowsPerPage2) + 1;
                        final List<int> pageList = [];
                        if (currentPage > 1) {
                          pageList.addAll(
                            List.generate(
                                currentPage - 1, (index) => index + 1),
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
            ],
          ),
        },

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
      drawer: SideBarAdmin(),
      extendBody: true,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildBody(), //try now
      ),
    );
  }
}

class ClientDataSource extends DataTableSource {
  final List<Client> clients;
  final int totalCount;
  final int startIndex;

  ClientDataSource(this.clients, this.totalCount, this.startIndex);

  @override
  DataRow getRow(int index) {
    final clientIndex = startIndex + index;
    if (clientIndex >= clients.length) {
      return DataRow(cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }

    final client = clients[clientIndex];

    return DataRow(cells: [
      DataCell(Text((clientIndex + 1).toString())),
      DataCell(Text(client.client ?? "")),
      DataCell(Text(client.message ?? "")),
      DataCell(Text(client.description ?? "")),
      DataCell(Text(client.onDate.toString())),
      DataCell(Text(client.createdOn ?? "")),
    ]);
  }

  @override
  int get rowCount => totalCount;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class ClientSource extends AdvancedDataTableSource<Client> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  @override
  DataRow? getRow(int index) {
    final int srNo = startIndex + index + 1;
    final Client client = lastDetails!.rows[index];
    final parsedDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(client.onDate ?? '0') * 1000);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    //print("parsedDate $parsedDate");

    return DataRow(
      cells: [
        DataCell(Text(srNo.toString())),
        DataCell(Text(client.client ?? "")),
        DataCell(Text(client.message ?? "")),
        DataCell(Text(client.description ?? "")),
        DataCell(Text(formattedDate)),
        DataCell(Text(client.createdOn ?? "")),
      ],
      // selected: selectedIds.contains(client.id),
      // onSelectChanged: (value) {
      //   selectedRow(client.id.toString(), value ?? false);
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

  void refresh() {
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Client>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      int count = dataModel.data.length ?? 0;
      dataCount1 = count;

      return RemoteDataSourceDetails(
        dataModel.count ?? 0,
        dynamicData
            .map<Client>(
              (item) => Client.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<Client>(
                  (item) => Client.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}

///////////////
typedef SelectedCallBack1 = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<UnAssignTaskDataModel> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<UnAssignTaskDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<UnAssignTaskDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final UnAssignTaskDataModel dataList = rows[index];
      final List<AllTask>? allTasks = dataList.allTask;

      if (allTasks != null && allTasks.isNotEmpty) {
        final AllTask allTask = allTasks.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(allTask.title ?? '')),
            DataCell(Text(allTask.ticketId ?? '')),
            DataCell(Text(allTask.clientName ?? '')),
            DataCell(Text(allTask.departmentName ?? '')),
            DataCell(Text(allTask.deadlineDate ?? '')),
            DataCell(Text(allTask.status ?? '')),
            DataCell(Text('')),
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
  Future<RemoteDataSourceDetails<UnAssignTaskDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.unAssignTask}',
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      final allList = dynamicData['all_task'];
      int count = allList.length ?? 0;
      dataCount3 = count;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('all_task')) {
        final dynamicList = dynamicData['all_task'] as List<dynamic>?;
        final List<UnAssignTaskDataModel> dataList = dynamicList
                ?.map<UnAssignTaskDataModel>((item) =>
                    UnAssignTaskDataModel(allTask: [AllTask.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<UnAssignTaskDataModel>(
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

typedef SelectedCallBack2 = Function(String id, bool newSelectState);

class TableSource2 extends AdvancedDataTableSource<UnAssignTaskDataModel> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<UnAssignTaskDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<UnAssignTaskDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final UnAssignTaskDataModel dataList = rows[index];
      final List<Manual>? manuals = dataList.manual;

      if (manuals != null && manuals.isNotEmpty) {
        final Manual manual = manuals.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(manual.title ?? '')),
            DataCell(Text(manual.ticketId ?? '')),
            DataCell(Text(manual.clientName ?? '')),
            DataCell(Text(manual.departmentName ?? '')),
            DataCell(Text(manual.deadlineDate ?? '')),
            DataCell(Text(manual.status ?? '')),
            DataCell(Text('')),
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
  Future<RemoteDataSourceDetails<UnAssignTaskDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.unAssignTask}',
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      final UnAssign = dynamicData['manual'];
      int count = UnAssign.length ?? 0;
      dataCount2 = count;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('manual')) {
        final dynamicList = dynamicData['manual'] as List<dynamic>?;
        final List<UnAssignTaskDataModel> dataList = dynamicList
                ?.map<UnAssignTaskDataModel>((item) =>
                    UnAssignTaskDataModel(manual: [Manual.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<UnAssignTaskDataModel>(
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
