import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/API/model/clientLogDataModel.dart';
import '../../../API/model/genModel.dart';
import '../../../API/model/paymentMethodModel.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/urls.dart' as url;

class Payment_Method extends StatefulWidget {
  const Payment_Method({super.key});

  @override
  State<Payment_Method> createState() => _Payment_MethodState();
}

class _Payment_MethodState extends State<Payment_Method> {
  List<PaymentMethod> clients = [];
  int offset = 0;
  int limit = 10;
  int totalCount = 0;

  void paymentTable() async {
    genModel? genmodel = await url.urls.postApiCall(
      method: '${url.urls.paymentMethod}',
      // params: {
      //   'offset': offset,
      //   'search': searchLogController.text.trim(),
      // },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clients = data.map((item) => PaymentMethod.fromJson(item)).toList();
        // print("Count :- ${genmodel.count}");
        // print(clients);
        totalCount = genmodel.count ?? 0;
        for (PaymentMethod client in clients) {
          print('Client ID: ${client.id}');
          print('Client Name: ${client.name}');
          // print('Message: ${client.message}');
          // Print other client properties as needed
        }
        setState(() {
          // Update the UI state if necessary
        });
      }
    }
  }


  // void paymentTable() async {
  //   Map j={};
  //   genModel? genmodel = await url.urls.postApiCall(
  //     method: '${url.urls.paymentMethod}',
  //     // params: {
  //     //   'message': message,
  //     //   'client': clientName,
  //     //   'description': description,
  //     //   'date': date,
  //     // },
  //   );
  //   if (genmodel != null) {
  //     print('Status: ${genmodel.message}');
  //     if (genmodel.status == true) {
  //       print('data added successfully');
  //
  //       setState(() {
  //         clients.add(PaymentMethod());
  //         print(clients);
  //       });
  //     }
  //   }
  // }
  // late PaymentMethod p;
  // Map rr={};
  // Future<void> fetchData() async {
  //   final response = await http.post(
  //     Uri.parse(url.urls.paymentMethod),
  //     body: {
  //       // Add any required parameters or data in the body
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('dt response ${response.body}');
  //
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       responseData = data['name'];
  //       rr=p.toJson();
  //       //print response here and re run
  //       print(rr);// Replace 'YOUR_DATA_FIELD' with the actual field name in the API response
  //     });
  //   } else {
  //     // Handle error response
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }
  // void _handlePageChange(int page) {
  //   setState(() {
  //     _currentPage = page;
  //   });
  // }
  @override
  void initState() {
    super.initState();
    // fetchData();
    paymentTable();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Payment Method",
          style: Theme
              .of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarAdmin(),
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

  _table() {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Sr. No.'), numeric: true),
                  DataColumn(label: Text('User ID')),
                  DataColumn(label: Text('Name')),
                ],
                rows: clients?.map((birthday) {
                  final index =
                      clients?.indexOf(birthday) ??
                          -1;
                  final srNo = (index + 1).toString();
                  final userId = birthday.id;
                  final name = birthday.name;

                  return DataRow(cells: [
                    DataCell(Text(srNo)),
                    DataCell(Text(userId!)),
                    DataCell(Text(name!)),
                  ]);
                }).toList() ??
                    [],
                dataRowHeight: 32.0,
              ),
            ],
          ),
        ),
      ],
    );
        // return PaginatedDataTable(
    //   header: Text('Table Header'),
    //   columns: [
    //     DataColumn(label: Text('ID')),
    //     DataColumn(label: Text('Name')),
    //     // Add more DataColumn widgets for additional columns
    //   ],
    //   source: _PaymentDataTableSource(
    //       responseData,
    //       totalCount,
    //       limit,
    //       offset,
    //   ),
    //   rowsPerPage: _rowsPerPage,
    //   availableRowsPerPage: [5, 10, 20],
    //   // onPageChanged: _handlePageChange,
    //   initialFirstRowIndex: _currentPage * _rowsPerPage,
    // );

    // return PaginatedDataTable(
    //   header: const Text('Client List'),
    //   columns: const [
    //     DataColumn(label: Text('Sr. No.'), numeric: true),
    //     DataColumn(label: Text('Client Name')),
    //   ],
    //   source: _PaymentDataTableSource(
    //     clients,
    //     totalCount,
    //     limit,
    //     offset,
    //   ),
    //   onPageChanged: (int pageIndex) {
    //     setState(() {
    //       // offset = limit * pageIndex;
    //       //offset = (limit * pageIndex) - (limit - 1);
    //     });
    //     print('Page Index: $pageIndex');
    //     paymentTable();
    //   },
    //   rowsPerPage: limit,
    // );
  }
}

  class _PaymentDataTableSource extends DataTableSource {
  final List<PaymentMethod> clients;
  final int totalCount;
  final int limit;
  final int offset;

  _PaymentDataTableSource(
  this.clients, this.totalCount, this.limit, this.offset);

  @override
  DataRow? getRow(int index) {
  if (index >= rowCount) {
    return null;
  }
  final clientIndex = offset + index;
  //final clientIndex = index + (pageIndex * limit);
  final client = clients[clientIndex];
  final srNo = (clientIndex + 1).toString();
  // final srNo = ((limit * pageIndex) - (limit - 1) + index).toString();

  return DataRow(cells: [
    DataCell(Text(srNo)),
    DataCell(Text(client.name ?? '')),
  // DataCell(Text(client.id ?? '')),
  ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalCount;

  @override
  int get selectedRowCount => 0;
  }