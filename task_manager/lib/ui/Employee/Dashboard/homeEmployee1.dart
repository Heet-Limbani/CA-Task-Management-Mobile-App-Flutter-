import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/AdminDataModel/countDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/holidayDataModel.dart';
import 'package:task_manager/ui/Employee/Sidebar/sidebarEmployee.dart';
import 'package:task_manager/ui/widgets/circle_gradient_icon.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/AdminDataModel/clientLogDataModel.dart';
import 'package:task_manager/API/AdminDataModel/birthDayDataModel.dart';

class HomeEmployeeScreen1 extends StatefulWidget {
  const HomeEmployeeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeEmployeeScreen1> createState() => _HomeEmployeeScreen1State();
}

class _HomeEmployeeScreen1State extends State<HomeEmployeeScreen1> {
  List<Client> clients = [];
  late double deviceWidth;
  late double deviceHeight;

  @override
  void initState() {
    super.initState();

    clientDashboard();
    birthDayTable();
    holidayTable();
    clientTable();
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
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleGradientIcon(
              onTap: () {},
              icon: Icons.calendar_month,
              color: Colors.purple,
              iconSize: 24,
              size: 40,
            ),
          )
        ],
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBarEmployee(),
      extendBody: true,
      body: _buildBody(),
    );
  }

  CountData? dataCount;
  void clientDashboard() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
    );
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

  BirthDayList? dataBirthdayList;
  void birthDayTable() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
    );
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataBirthdayList = BirthDayList.fromJson(data);
        if (dataBirthdayList?.birthday != null) {
          // for (Birthday birthday in dataBirthdayList!.birthday!) {
          //   print('BirthDay ID: ${birthday.id}');
          // }
        }
        setState(() {});
      }
    }
  }

  HolidayList? dataHolidayList;
  void holidayTable() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
    );
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataHolidayList = HolidayList.fromJson(data);
        // if (dataHolidayList?.holiday != null) {
        //   for (Holiday holiday in dataHolidayList!.holiday!) {
        //     print('Holiday ID: ${holiday.title}');
        //   }
        // }
        setState(() {});
      }
    }
  }

  void clientTable() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clients = data.map((item) => Client.fromJson(item)).toList();
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
                // _admin(),

                // _client(),

                _employee(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String client = "";

  String message = "";

  String description = "";

  var measure;

  String Function(DateTime date) date = DateFormat('dd/MM/yyyy').format;

  Column _employee() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Employee Dashboard",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: TaskGroupContainer(
                color: Colors.blue,
                icon: Icons.keyboard,
                taskCount: 5,
                taskGroup: "Today's Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.orange,
                isSmall: true,
                icon: Icons.pending_actions,
                taskCount: 2,
                taskGroup: "Pending Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.green,
                icon: Icons.currency_rupee,
                taskCount: 5,
                taskGroup: "Task Payable",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.red,
                icon: Icons.watch_later_rounded,
                taskCount: 10,
                taskGroup: "Overdue Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.purple,
                icon: Icons.live_help_outlined,
                taskCount: 5,
                isSmall: true,
                taskGroup: "Query Raised",
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Holiday List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Sr. No.'), numeric: true),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Date')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('John')),
                    DataCell(Text('Hello')),
                    DataCell(Text('2023-05-10')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Jane')),
                    DataCell(Text('Hi')),
                    DataCell(Text('2023-05-11')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Bob')),
                    DataCell(Text('Hey')),
                    DataCell(Text('2023-05-12')),
                  ]),
                ],
                dataRowMinHeight: 32.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
