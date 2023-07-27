import 'package:flutter/material.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';


class Company_View extends StatefulWidget {
  const Company_View({super.key});

  @override
  State<Company_View> createState() => _Company_ViewState();
}

class _Company_ViewState extends State<Company_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Company View",
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
          "Company List",
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
                  DataColumn(label: Text('Comapany Name')),
                  DataColumn(label: Text('Property Name')),
                  DataColumn(label: Text('Mobile')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('View')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Shivam Joshi')),
                    DataCell(Text('MYSYVA')),
                    DataCell(Text('Mokshes shah')),
                    DataCell(Text('1234567890')),
                    DataCell(Text('try@gmail')),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.view_list))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('New')),
                    DataCell(Text('1234567890')),
                    DataCell(Text('try@gmail')),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.view_list))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('New')),
                    DataCell(Text('1234567890')),
                    DataCell(Text('try@gmail')),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.view_list))),
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
