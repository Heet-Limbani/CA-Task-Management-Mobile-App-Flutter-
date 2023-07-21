import 'package:flutter/material.dart';
import '../sidebar/sidebarAdmin.dart';

class Task_Report extends StatefulWidget {
  const Task_Report({super.key});

  @override
  State<Task_Report> createState() => _Task_ReportState();
}

class _Task_ReportState extends State<Task_Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Task > Task Report",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer:  SideBarAdmin(),
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
                const SizedBox(
                  height: 40,
                ),
                _header(),
                const SizedBox(
                  height: 10,
                ),
                _search(),
                const SizedBox(
                  height: 30,
                ),
                _add(),
                const SizedBox(
                  height: 10,
                ),
                _table(),
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
        IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month)),
        const Spacer(),
      ],
    );
  }

  Row _search() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide())),
          ),
        ),
      ],
    );
  }

  Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Task Name')),
                  DataColumn(label: Text('Ticket ID')),
                  DataColumn(label: Text('Client Name')),
                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('Deadline Date')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('View')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('Work')),
                    DataCell(Text('123')),
                    DataCell(Text('Roy')),
                    DataCell(Text('Sales')),
                    DataCell(Text('06/03/2023')),
                    DataCell(Text('Completed')),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.view_list))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Work')),
                    DataCell(Text('123')),
                    DataCell(Text('Roy')),
                    DataCell(Text('Sales')),
                    DataCell(Text('06/03/2023')),
                    DataCell(Text('Completed')),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.view_list))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Work')),
                    DataCell(Text('123')),
                    DataCell(Text('Roy')),
                    DataCell(Text('Sales')),
                    DataCell(Text('06/03/2023')),
                    DataCell(Text('Completed')),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.view_list))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.delete))),
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
