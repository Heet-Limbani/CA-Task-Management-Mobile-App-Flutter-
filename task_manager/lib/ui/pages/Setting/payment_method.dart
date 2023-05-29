import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Payment_Method extends StatefulWidget {
  const Payment_Method({super.key});

  @override
  State<Payment_Method> createState() => _Payment_MethodState();
}

class _Payment_MethodState extends State<Payment_Method> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Payment Method",
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
          "Payment Method",
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
   Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Add Payment Method",
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
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Edit')),
                DataColumn(label: Text('Delete')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('BOB')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('UPI')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('HDFC')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
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