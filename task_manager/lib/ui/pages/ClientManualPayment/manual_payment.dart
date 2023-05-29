import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Manual_Payment extends StatefulWidget {
  const Manual_Payment({super.key});

  @override
  State<Manual_Payment> createState() => _Manual_PaymentState();
}

class _Manual_PaymentState extends State<Manual_Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Manual Payment",
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
          "Manual Payment List",
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
                  DataColumn(label: Text(' Client Name')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Image')),
                  DataColumn(label: Text('Amount'), numeric: true),
                  DataColumn(label: Text('Description')),
                  DataColumn(
                    label: Text('Request On'),
                  ),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Image')),
                    DataCell(Text('500')),
                    DataCell(Text('Test')),
                    DataCell(Text('27/03/2023')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Image')),
                    DataCell(Text('2400')),
                    DataCell(Text('Description')),
                    DataCell(Text('Request On')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Image')),
                    DataCell(Text('1500')),
                    DataCell(Text('Description')),
                    DataCell(Text('23/07/2020')),
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
