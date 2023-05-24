import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/model/countDataModel.dart';
import 'package:task_manager/ui/core/res/color.dart';
import 'package:task_manager/ui/pages/DashBoard/sidebar.dart';
import 'package:task_manager/ui/widgets/circle_gradient_icon.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/urls.dart';
import '../../../API/model/genModel.dart';
import 'package:task_manager/API/model/birthDayDataModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    clientDashboard();
    birthDayTable();
  }

  CountData? dataCount;
  void clientDashboard() async {
    final headers = urls.xToken;

    genModel? genmodel = await urls.postApiCall(
      '${urls.adminDashBoard}',
      {},
      headers,
    );
    if (genmodel != null) {
      print('Status: ${genmodel.message}');
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
    final headers = urls.xToken;

    genModel? genmodel = await urls.postApiCall(
      '${urls.adminDashBoard}',
      {},
      headers,
    );
    if (genmodel != null) {
      print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataBirthdayList = BirthDayList.fromJson(data);
        if (dataBirthdayList?.birthday != null) {
        for (Birthday birthday in dataBirthdayList!.birthday!) {
          print('BirthDay ID: ${birthday.id}');
        }
      }
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
                const SizedBox(
                  height: 10,
                ),
                _admin(),
                const SizedBox(
                  height: 100,
                ),
                _client(),
                const SizedBox(
                  height: 100,
                ),
                _employee(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _admin() {
    final GlobalKey<FormState> _formKey = GlobalKey();
    // ignore: unused_local_variable
    String client = "";
    // ignore: unused_local_variable
    String message = "";
    // ignore: unused_local_variable
    String description = "";
    // ignore: unused_local_variable
    var measure;

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
              toolbarOptions: const ToolbarOptions(
                copy: true,
                selectAll: true,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.blue[400],
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
       
        Container(
          child: Text(''),
        ),
        SizedBox(
          height: 20,
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
                color: Colors.purple,
                icon: Icons.today_rounded,
                taskCount: dataCount?.count?.tasksCount ?? '0',
                taskGroup: "Today's Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.1,
              child: TaskGroupContainer(
                color: Colors.blue,
                icon: Icons.pending_actions,
                taskCount: dataCount?.count?.pendingCount ?? '0',
                taskGroup: "Pending Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.orange,
                isSmall: true,
                icon: Icons.attach_money,
                taskCount: dataCount?.count?.taxPayableCount ?? '0',
                taskGroup: "Tax Payable",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.red,
                icon: Icons.watch_later_outlined,
                taskCount: dataCount?.count?.totalOverdueTaskCount ?? '0',
                taskGroup: "Overdue Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.green,
                isSmall: true,
                icon: Icons.live_help_rounded,
                taskCount: dataCount?.count?.totalQueryRaisedCount ?? '0',
                taskGroup: "Query Raised",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.pink,
                icon: Icons.keyboard,
                taskCount: dataCount?.count?.totalOnBoardCount ?? '0',
                taskGroup: "On Board Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.05,
              child: TaskGroupContainer(
                color: Colors.blue,
                isSmall: true,
                icon: Icons.punch_clock,
                taskCount: dataCount?.count?.unassignedTaskCount ?? '0',
                taskGroup: "UnAssign Work",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.orange,
                isSmall: true,
                icon: Icons.money_off_outlined,
                taskCount: dataCount?.count?.unpaidTaskBoardCount ?? '0',
                taskGroup: "UnPaid Tax",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
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
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Text(
                "See all",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Client Log",
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
          height: 20,
        ),
        Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Client',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    onFieldSubmitted: (value) {
                      setState(() {
                        client = value;
                        // firstNameList.add(firstName);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        client = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'First Name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'First Name cannot contain special characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Message',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      setState(() {
                        message = value;
                        // bodyTempList.add(bodyTemp);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        message = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDatePickerFormField(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now()),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        //_submit();
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Client Log Data",
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
          height: 20,
        ),
        Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Sr. No.'), numeric: true),
                      DataColumn(label: Text('Client Name')),
                      DataColumn(label: Text('Message')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Created On')),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(Text('John')),
                        DataCell(Text('Hello')),
                        DataCell(Text('Lorem ipsum dolor sit amet')),
                        DataCell(Text('2023-05-10')),
                        DataCell(Text('2023-05-10')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(Text('Jane')),
                        DataCell(Text('Hi')),
                        DataCell(Text('Consectetur adipiscing elit')),
                        DataCell(Text('2023-05-11')),
                        DataCell(Text('2023-05-11')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(Text('Bob')),
                        DataCell(Text('Hey')),
                        DataCell(Text('Sed do eiusmod tempor incididunt')),
                        DataCell(Text('2023-05-12')),
                        DataCell(Text('2023-05-12')),
                      ]),
                    ],
                    dataRowHeight: 32.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Birthday List",
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
          height: 20,
        ),
        Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Sr. No.'), numeric: true),
                      DataColumn(label: Text('User')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Birth Date')),
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
                    dataRowHeight: 32.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
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
          height: 20,
        ),
        Column(
          children: <Widget>[
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
                    dataRowHeight: 32.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _client() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Client Dashboard",
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
          height: 20,
        ),
        StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: const [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1.1,
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.keyboard,
                  taskCount: 5,
                  taskGroup: "On Going Task",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: TaskGroupContainer(
                  color: Colors.green,
                  isSmall: true,
                  icon: Icons.live_help_rounded,
                  taskCount: 2,
                  taskGroup: "Query Raised",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1.2,
                child: TaskGroupContainer(
                  color: Colors.orange,
                  icon: Icons.pending_actions,
                  taskCount: 5,
                  taskGroup: "Inoice Raised",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1.2,
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.attach_money,
                  taskCount: 10,
                  taskGroup: "Amount",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: TaskGroupContainer(
                  color: Colors.purple,
                  icon: Icons.download,
                  taskCount: 5,
                  isSmall: true,
                  taskGroup: "Download",
                ),
              ),
            ])
      ],
    );
  }

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
          height: 20,
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
          height: 50,
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
          height: 20,
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
                dataRowHeight: 32.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: const SideBar(),
      extendBody: true,
      body: _buildBody(),
    );
  }
}

