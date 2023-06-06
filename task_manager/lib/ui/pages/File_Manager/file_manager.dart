import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class File_Manager extends StatefulWidget {
  const File_Manager({super.key});

  @override
  State<File_Manager> createState() => _File_ManagerState();
}

class _File_ManagerState extends State<File_Manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > File Manager",
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
          "Manage File",
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

  Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Add File",
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
        SizedBox(
          width: 20,
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "View Dispatched File",
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
        SizedBox(
          width: 20,
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Manage Location",
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
                  DataColumn(label: Text('Sr.No.'), numeric: true),
                  DataColumn(label: Text('File Name')),
                  DataColumn(label: Text('Client Name')),
                  DataColumn(label: Text('Location')),
                  DataColumn(label: Text('File No.')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Dispatched')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('New')),
                    DataCell(Text('1234567890')),
                    DataCell(Text('try@gmail')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.share_location))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('New')),
                    DataCell(Text('1234567890')),
                    DataCell(Text('try@gmail')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.share_location))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Roy')),
                    DataCell(Text('ABC')),
                    DataCell(Text('New')),
                    DataCell(Text('1234567890')),
                    DataCell(Text('try@gmail')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(IconButton(
                        onPressed: null, icon: Icon(Icons.share_location))),
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
