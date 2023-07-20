import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/cardDataModel.dart';
import 'package:task_manager/API/model/clientDataModel.dart';
import 'package:task_manager/API/model/countDataModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import 'package:task_manager/API/model/holidayDataModel.dart';
import 'package:task_manager/ui/core/res/color.dart';
import 'package:task_manager/ui/pages/DashBoard/sidebarAdmin.dart';
import 'package:task_manager/ui/pages/DashBoard/taskOnBoard.dart';
import 'package:task_manager/ui/pages/DashBoard/taskUnPaid.dart';
import 'package:task_manager/ui/pages/DashBoard/viewOverdueTask.dart';
import 'package:task_manager/ui/pages/DashBoard/viewPendingTask.dart';
import 'package:task_manager/ui/pages/DashBoard/viewTasksTask.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/clientLogDataModel.dart';
import '../../../API/model/genModel.dart';
import 'package:task_manager/API/model/birthDayDataModel.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final _source = ClientSource();
  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  TextEditingController _searchController = TextEditingController();

  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

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
  final GlobalKey<FormState> _formKey = GlobalKey();

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
  bool showTablePending = false;
  bool showTableOverdue = false;
  bool showTableTask = true;
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
    fetchData();
    clientDashboard();
    birthDayTable();
    holidayTable();
    clientTable();
    clientData();
    getUser();
    fetchCardData();
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

  Future<void> fetchData() async {
    int offset = currentPage * rowsPerPage;
   
    dataModel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
      params: {
        'offset': offset,
        'search': searchLogController.text.trim(),
      },
    );

    if (dataModel != null && dataModel?.status == true) {
      final dynamicData = dataModel?.data;

      if (dynamicData != null && dynamicData is List) {
        clients = dynamicData
            .map<Client>(
                (item) => Client.fromJson(item as Map<String, dynamic>))
            .toList();
        totalCount = dataModel?.count ?? 0;
      } else {
        clients = [];
        totalCount = 0;
      }
    }
  }

  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

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

  void handlePageChange(int pageIndex, genModel? model) async {
    currentPage = pageIndex ~/ rowsPerPage;
    //print('currentPage $currentPage');

    await fetchData();

    if (dataModel != null && dataModel?.data != null) {
      clients = dataModel?.data!
          .map<Client>((item) => Client.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      clients = [];
    }

    setState(() {});
  }

  CountData? dataCount;

  void clientDashboard() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      //print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataCount = CountData.fromJson(data);
        //print('data  ${dataCount?.count?.pendingCount}');

        setState(() {});
      }
    }
  }

  CardData? cardData;

  Future<void> fetchCardData() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      cardData = CardData.fromJson(data);
    }
  }

  // Print the pending items
  // if (cardData?.cardData?.pending != null) {
  //   for (Pending pendingItem in cardData!.cardData!.pending!) {
  //     print('Pending Ticket ID: ${pendingItem.ticketId}');
  //     print('Title: ${pendingItem.title}');
  //     print('Status: ${pendingItem.status}');
  //     print('----------------------');
  //   }
  // }
  BirthDayList? dataBirthdayList;

  void birthDayTable() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        // print('Data: ${genmodel.data}');

        final data = genmodel.data;
        dataBirthdayList = BirthDayList.fromJson(data);
        // if (dataBirthdayList?.birthday != null) {
        //   for (Birthday birthday in dataBirthdayList!.birthday!) {
        //     print('BirthDay ID: ${birthday.id}');
        //   }
        // }
        setState(() {});
      }
    }
  }

  HolidayList? dataHolidayList;

  void holidayTable() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataHolidayList = HolidayList.fromJson(data);

        setState(() {});
      }
    }
  }

  ClientList? dataClientList;

  void clientData() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel.data}');

        final data = genmodel.data;
        dataClientList = ClientList.fromJson(data);
        if (dataClientList?.clientdata != null) {
          clientsdata = (data['client'] as List<dynamic>)
              .map((item) => ClientData.fromJson(item as Map<String, dynamic>))
              .toList();
          //print("clients $clients.asString()");
          //print("clientsdata $clientsdata");
          if (clientsdata.isEmpty) {
            // List is empty
            // print("No client data available.");
          } else {
            // List has values
            // print("Client data available.");
          }
          // for (ClientData clientdata1 in dataClientList!.clientdata!) {
          // print('UserName: ${clientdata1.username}');
          //}
        }
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  void clientTable({int offset = 0, int limit = 10}) async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
      params: {
        'offset': offset,
        'search': searchLogController.text.trim(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clients = data.map((item) => Client.fromJson(item)).toList();
        // print("Count :- ${genmodel.count}");
        totalCount = genmodel.count ?? 0;
        // for (Client client in clients) {
        //   print('Client ID: ${client.id}');
        //   print('Client Name: ${client.client}');
        //   print('Message: ${client.message}');
        //   // Print other client properties as needed
        // }
        setState(() {
          // Update the UI state if necessary
        });
      }
    }
  }

  void clientLogAdd() async {
    try {
      if (selectedDateTime == null) {
        selectedDateTime = DateTime.now();
      }
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientLogAdd}',
        params: {
          'message': message,
          'client': selectedClientId1,
          'description': description,
          'date': selectedDateTime.toString(),
        },
      );
      if (genmodel != null) {
        if (genmodel.status == true) {
          setState(() {
            clientId = '';
          });
        }
      }
    } catch (e) {}
  }

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: {'type': Urls.clientType, 'limit': "200"},
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clientType = data.map((item) => GetUser.fromJson(item)).toList();
        //if (clientType.isEmpty) {
        // List is empty
        //print("No client data available.");
        // } else {
        // List has values
        //print("Client data available.");
        // }
        // for (GetUser clientdata1 in clientType) {
        //   print('UserName: ${clientdata1.username}');
        // }
        setState(() {});
      }
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
              "Admin Dashboard",
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
                  if ((dataCount?.count?.tasksCount ?? '0') != 0) {
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
                  color: Colors.purple,
                  icon: Icons.today_rounded,
                  taskCount: dataCount?.count?.tasksCount ?? '0',
                  taskGroup: "Today's Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.1,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.pendingCount ?? '0') != 0) {
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
                  color: Colors.blue,
                  icon: Icons.pending_actions,
                  taskCount: dataCount?.count?.pendingCount ?? '0',
                  taskGroup: "Pending Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.taxPayableCount ?? '0') != 0) {
                    // setState(() {
                    //   showTablePending =
                    //       !showTablePending; // Toggle the visibility of the table
                    // });
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
                  color: Colors.orange,
                  isSmall: true,
                  icon: Icons.attach_money,
                  taskCount: dataCount?.count?.taxPayableCount ?? '0',
                  taskGroup: "Tax Payable",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.totalOverdueTaskCount ?? '0') != 0) {
                    setState(() {
                      showTableOverdue = !showTableOverdue;
                    });
                    final snackBar = SnackBar(
                      content: Text(
                        showTableOverdue
                            ? "Overdue Task Added to Task List"
                            : "Overdue Task Removed from Task List",
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
                  icon: Icons.watch_later_outlined,
                  taskCount: dataCount?.count?.totalOverdueTaskCount ?? '0',
                  taskGroup: "Overdue Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.totalQueryRaisedCount ?? '0') != 0) {
                    // setState(() {
                    //   showTablePending =
                    //       !showTablePending; // Toggle the visibility of the table
                    // });
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
                  color: Colors.green,
                  isSmall: true,
                  icon: Icons.live_help_rounded,
                  taskCount: dataCount?.count?.totalQueryRaisedCount ?? '0',
                  taskGroup: "Query Raised",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.totalOnBoardCount ?? '0') != 0) {
                    Get.to(
                      TaskOnBoard(),
                    );
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
                  color: Colors.pink,
                  icon: Icons.keyboard,
                  taskCount: dataCount?.count?.totalOnBoardCount ?? '0',
                  taskGroup: "On Board Task",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.05,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.unassignedTaskCount ?? '0') != 0) {
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
                  isSmall: true,
                  icon: Icons.punch_clock,
                  taskCount: dataCount?.count?.unassignedTaskCount ?? '0',
                  taskGroup: "UnAssign Work",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if ((dataCount?.count?.unpaidTaskBoardCount ?? '0') != 0) {
                    Get.to(
                      TaskUnPaid(),
                    );
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
                        onPressed: () {
                          // Perform any action on snackbar action press (if needed)
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.orange,
                  isSmall: true,
                  icon: Icons.money_off_outlined,
                  taskCount: dataCount?.count?.unpaidTaskBoardCount ?? '0',
                  taskGroup: "UnPaid Tax",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.1,
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
                          rows: cardData?.cardData?.tasks?.map(
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
                                              ViewTasksTask(ticketId: ticketId),
                                            );
                                            print("Ticket Id :- $ticketId");
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
                          rows: cardData?.cardData?.pending1?.map(
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
                                              ViewPendingTask(
                                                  ticketId: pending.ticketId!),
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
        if (showTableOverdue) ...{
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Overdue Tasks",
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
                          rows: cardData?.cardData?.overdue?.map(
                                (overdue) {
                                  final taskName = overdue.title ?? '';
                                  final ticketId = overdue.ticketId ?? '';
                                  final clientName = overdue.clientName ?? '';
                                  final employeeName =
                                      overdue.employeeName ?? '';
                                  final deadline = overdue.cdeadlineDate ?? '';

                                  int roundedPercentage = 0;
                                  double percentage = double.parse(
                                      overdue.taskCompletePercentage!);
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
                                              ViewOverdueTask(
                                                  ticketId: overdue.ticketId!),
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
              "Add Client Log",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Form(
          key: _formKey,
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
                    clientController.text = selectedClientId1 ?? '';
                  });
                },
                items: clientType.map((GetUser user) {
                  return DropdownMenuItem<String>(
                    value: user.iD ?? '',
                    child: Text(user.username ?? ''),
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
                controller: messageController,
                decoration: const InputDecoration(
                    labelText: 'Message',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Last Name must contain at least 3 characters';
                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                    return 'Last Name cannot contain special characters';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    message = value;
                    // lastNameList.add(lastName);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
              ),
              SizedBox(height: deviceHeight * 0.02),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Description must contain at least 3 characters';
                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                    return 'Description cannot contain special characters';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    description = value;
                    // bodyTempList.add(bodyTemp);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox(height: deviceHeight * 0.02),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDateTime ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                      );
                      date = DateFormat('yyyy-MM-dd').format(selectedDateTime!);
                      dateController.text = date;
                    });
                  }
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    selectedDateTime = DateTime.tryParse(value);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    selectedDateTime = DateTime.tryParse(value);
                  });
                },
              ),
              SizedBox(height: deviceHeight * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60)),
                onPressed: () {
                  clientTable();
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();

                    clientLogAdd();

                    Fluttertoast.showToast(
                      msg: "Client Log Added Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                  clientTable();
                  clear();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),

        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          children: [
            Text(
              "Client Log Data",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
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
          height: deviceHeight * 0.02,
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
              label: const Text('Client Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Message'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Description'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Created On'),
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
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: SizedBox(
        //         width: deviceWidth * 0.3,
        //         child: TextField(
        //           controller: searchLogController,
        //           onChanged: (value) {
        //             clientTable();
        //           },
        //           decoration: InputDecoration(
        //               contentPadding:
        //                   EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        //               hintText: 'Search',
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //                 borderSide: const BorderSide(),
        //               ),
        //               prefixIcon: Icon(Icons.search),
        //               suffixIcon: GestureDetector(
        //                 onTap: () {
        //                   searchLogController.clear();
        //                   FocusScope.of(context).unfocus();
        //                   searchLogController.clear();
        //                   clientTable();
        //                   // setState(() {});
        //                 },
        //                 child: Icon(Icons.clear),
        //               )),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        Row(
          children: [
            Text(
              "Birthday List",
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
              label: const Text('ID'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Name'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Birth Date'),
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
        // Column(
        //   children: <Widget>[
        //     SingleChildScrollView(
        //       scrollDirection: Axis.horizontal,
        //       child: Row(
        //         children: [
        //           DataTable(
        //             columns: const [
        //               DataColumn(label: Text('Sr. No.'), numeric: true),
        //               DataColumn(label: Text('User ID')),
        //               DataColumn(label: Text('Name')),
        //               DataColumn(label: Text('Birth Date')),
        //             ],
        //             rows: dataBirthdayList?.birthday?.map((birthday) {
        //                   final index =
        //                       dataBirthdayList?.birthday?.indexOf(birthday) ??
        //                           -1;
        //                   final srNo = (index + 1).toString();
        //                   final userId = birthday.userId;
        //                   final name = birthday.userName;

        //                   return DataRow(cells: [
        //                     DataCell(Text(srNo)),
        //                     DataCell(Text(userId!)),
        //                     DataCell(Text(name!)),
        //                     DataCell(Text('')),
        //                   ]);
        //                 }).toList() ??
        //                 [],
        //             dataRowHeight: 32.0,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
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

typedef SelectedCallBack1 = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<HolidayList> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<HolidayList>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<HolidayList> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final HolidayList dataList = rows[index];
      final List<Holiday>? holidays = dataList.holiday;

      if (holidays != null && holidays.isNotEmpty) {
        final Holiday holiday = holidays.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(holiday.title ?? '')),
            DataCell(Text(holiday.description ?? '')),
            DataCell(Text(holiday.date ?? '')),
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
  Future<RemoteDataSourceDetails<HolidayList>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
   

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
     
    );

    if (dataModel != null && dataModel.status == true) {
     
      final dynamicData = dataModel.data;
      final holidayList = dynamicData['holiday'];
      int count = holidayList.length ?? 0;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('holiday')) {
        final dynamicList = dynamicData['holiday'] as List<dynamic>?;
        final List<HolidayList> dataList = dynamicList
                ?.map<HolidayList>(
                    (item) => HolidayList(holiday: [Holiday.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<HolidayList>(
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

class TableSource2 extends AdvancedDataTableSource<BirthDayList> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<BirthDayList>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<BirthDayList> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final BirthDayList dataList = rows[index];
      final List<Birthday>? birthdays = dataList.birthday;

      if (birthdays != null && birthdays.isNotEmpty) {
        final Birthday birthday = birthdays.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(birthday.id ?? '')),
            DataCell(Text(birthday.userName ?? '')),
            DataCell(Text("")),
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
  Future<RemoteDataSourceDetails<BirthDayList>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
   

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
      
    );

    if (dataModel != null && dataModel.status == true) {
     
      final dynamicData = dataModel.data;
      final birthdayList = dynamicData['birthday_list'];
      int count = birthdayList.length ?? 0;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('birthday_list')) {
        final dynamicList = dynamicData['birthday_list'] as List<dynamic>?;
        final List<BirthDayList> dataList = dynamicList
                ?.map<BirthDayList>(
                    (item) => BirthDayList(birthday: [Birthday.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<BirthDayList>(
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
