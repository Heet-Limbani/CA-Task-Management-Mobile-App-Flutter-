import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/circle_gradient_icon.dart';
import '../DashBoard/sidebar.dart';

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Company",
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
                 _add(),
                const SizedBox(
                  height: 0,
                ),
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
          "Company List",
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
  Row _add() {
    return Row(
      children: [
         TextButton(
          child: const Text(
            "Add New",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          onPressed: () {},
        ),
        TextButton(
          child: const Text(
            "Manage Group",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          onPressed: () {},
        ),
        TextButton(
          child: const Text(
            "Manage Comments",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          onPressed: () {},
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
                DataColumn(label: Text('Edit')),
                DataColumn(label: Text('View')),
                DataColumn(label: Text('Delete')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Roy')),
                  DataCell(Text('ABC')),
                  DataCell(Text('New')),
                  DataCell(Text('1234567890')),
                  DataCell(Text('try@gmail')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.view_list))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Roy')),
                  DataCell(Text('ABC')),
                  DataCell(Text('New')),
                  DataCell(Text('1234567890')),
                  DataCell(Text('try@gmail')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.view_list))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                ]),
               DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('Roy')),
                  DataCell(Text('ABC')),
                  DataCell(Text('New')),
                  DataCell(Text('1234567890')),
                  DataCell(Text('try@gmail')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                   DataCell(IconButton(onPressed: null, icon: Icon(Icons.view_list))),
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