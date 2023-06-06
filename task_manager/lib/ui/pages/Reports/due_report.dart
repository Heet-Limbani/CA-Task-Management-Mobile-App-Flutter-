import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Due_Report extends StatefulWidget {
  const Due_Report({super.key});

  @override
  State<Due_Report> createState() => _Due_ReportState();
}

class _Due_ReportState extends State<Due_Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Reports > Due Report",
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
          "Reports",
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
                  DataColumn(label: Text('Sr.No'), numeric: true),
                  DataColumn(label: Text('Company Name')),
                  DataColumn(label: Text('Contact Number')),
                  DataColumn(label: Text('Total Ticket Amount')),
                  DataColumn(label: Text('Total Invoice Amount')),
                  DataColumn(label: Text('Total')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('ABC')),
                    DataCell(Text('2345678910')),
                    DataCell(Text('2908')),
                    DataCell(Text('1200')),
                    DataCell(Text('4108')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('ABC')),
                    DataCell(Text('2345678910')),
                    DataCell(Text('2908')),
                    DataCell(Text('1200')),
                    DataCell(Text('4108')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('ABC')),
                    DataCell(Text('2345678910')),
                    DataCell(Text('2908')),
                    DataCell(Text('1200')),
                    DataCell(Text('4108')),
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
