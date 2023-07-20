import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Sent extends StatefulWidget {
  const Sent({super.key});

  @override
  State<Sent> createState() => _SentState();
}

class _SentState extends State<Sent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Sent Notification",
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
          "Sent Notification",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
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
                dataRowMinHeight: 32.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
