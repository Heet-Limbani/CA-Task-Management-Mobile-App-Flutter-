import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Configuration",
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
          "Notifications",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 80,
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
            "Add Notification",
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
                  DataColumn(label: Text('Meta')),
                  DataColumn(label: Text('Send ?')),
                  DataColumn(label: Text('Message')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Enable')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Task')),
                    DataCell(Text('Deactive')),
                    DataCell(Text('Your New Task Has Been Generated')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.check))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Client')),
                    DataCell(Text('Deactive')),
                    DataCell(Text('Your New Task Has Been Generated')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.check))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('Company')),
                    DataCell(Text('Deactive')),
                    DataCell(Text('Your New Task Has Been Generated')),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.edit))),
                    DataCell(
                        IconButton(onPressed: null, icon: Icon(Icons.check))),
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
