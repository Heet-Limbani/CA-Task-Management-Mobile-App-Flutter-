import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Activity_Log extends StatefulWidget {
  const Activity_Log({super.key});

  @override
  State<Activity_Log> createState() => _Activity_LogState();
}

class _Activity_LogState extends State<Activity_Log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Activity",
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
          "Activity Log",
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

  Column _table() {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Sr.No.'), numeric: true),
                  DataColumn(label: Text(' User Name')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Date')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Roy12')),
                    DataCell(Text('02/06/2020')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Roy12')),
                    DataCell(Text('02/06/2020')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Roy12')),
                    DataCell(Text('02/06/2020')),
                  ]),
                ],
                dataRowMaxHeight: 32.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
