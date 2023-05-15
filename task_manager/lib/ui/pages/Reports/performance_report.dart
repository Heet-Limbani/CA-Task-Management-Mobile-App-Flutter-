import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/circle_gradient_icon.dart';
import '../DashBoard/sidebar.dart';

class Performance_Report extends StatefulWidget {
  const Performance_Report({super.key});

  @override
  State<Performance_Report> createState() => _Performance_ReportState();
}

class _Performance_ReportState extends State<Performance_Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reports > Employee Performance",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: CircleGradientIcon(
        //       onTap: () {},
        //       icon: Icons.calendar_month,
        //       color: Colors.purple,
        //       iconSize: 24,
        //       size: 40,
        //     ),
        //   )
        // ],
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBar(),
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
               _paymentHeader(),
                const SizedBox(
                  height: 10,
                ),
                _search(),
                const SizedBox(
                  height: 30,
                ),
                //  _add(),
                // const SizedBox(
                //   height: 0,
                // ),
                _table(),

                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 30,
        //   // left: 100.w / 2 - (70 / 2),
        //   right: 30,
        //   child: CircleGradientIcon(
        //     color: Colors.pink,
        //     onTap: () {},
        //     size: 60,
        //     iconSize: 30,
        //     icon: Icons.add,
        //   ),
        // )
      ],
    );
  }
  
  Row _paymentHeader() {
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
        SizedBox(width: 30,),
       
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
  // Row _add() {
  //   return Row(
  //     children: [
  //        TextButton(
  //         child: const Text(
  //           "Add New",
  //           style: TextStyle(
  //             color: Colors.blue,
  //             fontWeight: FontWeight.w700,
  //             fontSize: 14,
  //           ),
  //         ),
  //         onPressed: () {},
  //       ),
       
  //     ],
  //   );
  // }
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
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('Total Task')),
                DataColumn(label: Text('Completed Task')), 
                DataColumn(label: Text('Performance')),
                DataColumn(label: Text('View Graph')),
                ],

              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('ABC')),
                  DataCell(Text('2')),
                  DataCell(Text('0')),
                  DataCell(Text('0.00%')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye))),
                  ]),

                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('ABC')),
                  DataCell(Text('2')),
                  DataCell(Text('0')),
                  DataCell(Text('0.00%')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye))),
                  ]),

                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('ABC')),
                  DataCell(Text('2')),
                  DataCell(Text('0')),
                  DataCell(Text('0.00%')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye))),
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