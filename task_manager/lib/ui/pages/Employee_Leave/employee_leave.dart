import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Employee_Leave extends StatefulWidget {
  const Employee_Leave({super.key});

  @override
  State<Employee_Leave> createState() => _Employee_LeaveState();
}

class _Employee_LeaveState extends State<Employee_Leave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Employee Leave",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBarAdmin(),
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
          "Employee Leave",
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
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Reason')),
                  DataColumn(label: Text('From Date')),
                  DataColumn(label: Text('To Date')),
                  DataColumn(label: Text('Shift')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Accept')),
                  DataColumn(label: Text('Reject')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('06/08/2022')),
                    DataCell(Text('08/08/2022')),
                    DataCell(Text('Morning')),
                    DataCell(Text('Pending')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.check))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.close))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('06/08/2022')),
                    DataCell(Text('08/08/2022')),
                    DataCell(Text('Morning')),
                    DataCell(Text('Pending')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.check))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.close))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('06/08/2022')),
                    DataCell(Text('08/08/2022')),
                    DataCell(Text('Morning')),
                    DataCell(Text('Pending')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.check))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.close))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.delete))),
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
}
