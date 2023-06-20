import 'package:flutter/material.dart';
import '../../../API/model/genModel.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/urls.dart' as url;
import 'package:task_manager/API/model/configurationNotificationModel.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  List<ConfigurationModel> clients = [];
  int offset = 0;
  int limit = 10;
  int totalCount = 0;
  int selectedValue=0;
  int selectedRowIndex = -1;

  void notificationTable() async {
    genModel? genmodel = await url.Urls.postApiCall(
      method: '${url.Urls.configurationNotification}',
      // params: {
      //   'offset': offset,
      //   'search': searchLogController.text.trim(),
      // },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clients = data.map((item) => ConfigurationModel.fromJson(item)).toList();
        // print("Count :- ${genmodel.count}");
        // print(clients);
        totalCount = genmodel.count ?? 0;
        for (ConfigurationModel client in clients) {
          print('Client ID: ${client.id}');
          print('Client Meta: ${client.meta}');
          print('Client send: ${client.send}');
          print('Message: ${client.message}');
          // Print other client properties as needed
        }
        setState(() {
          // Update the UI state if necessary
        });
      }
    }
  }

  Future<void> actionMessage(int id, String message, int send) async {
    genModel? genmodel =
    await url.Urls.postApiCall(method: '${url.Urls.configurationNotificationEdit}',
        params: {
          "id":id.toString(),
          "message":message,
          "send":send.toString()
        });
    if (genmodel != null) {
      //print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        // final data = genmodel.data;
        print(id);
        // dataCount = CountData.fromJson(data);
        //print('data  ${dataCount?.count?.pendingCount}');
        setState(() {});
      }
    }
  }


  @override
  void initState() {
    super.initState();
    notificationTable();
  }



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
                  DataColumn(label: Text('Sr. No.'), numeric: true),
                  DataColumn(label: Text('User ID')),
                  DataColumn(label: Text('Meta')),
                  DataColumn(label: Text('Send')),
                  DataColumn(label: Text('Message')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Action')),
                ],
                rows: clients.map((birthday) {
                  final index =
                      clients.indexOf(birthday);
                  final srNo = (index + 1).toString();
                  final userId = birthday.id;
                  final meta = birthday.meta;
                  final send=birthday.send;
                  final message=birthday.message;

                  return DataRow(
                      selected: selectedRowIndex == index,
                      onSelectChanged: (isSelected) {
                        setState(() {
                          selectedRowIndex = isSelected! ? index : -1;
                        });
                      },
                      cells: [
                    DataCell(Text(srNo)),
                    DataCell(Text(userId!)),
                    DataCell(Text(meta!)),
                    DataCell(Text(send!)),
                    DataCell(Text(message!)),
                    DataCell(IconButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/editPaymentMethod', arguments: {
                            'userId':userId
                          });
                        },
                        icon: Icon(Icons.edit)
                    )),
                    DataCell(
                      Column(
                        children: [
                          RadioListTile(
                            title: Text('Enable'),
                            groupValue: selectedRowIndex,
                            value: 1,
                            onChanged: (value){
                              setState(() {
                                selectedRowIndex=value!;
                              });
                            },
                    ),
                          RadioListTile(
                            title: Text('Disable'),
                            groupValue: selectedRowIndex,
                            value: 2,
                            onChanged: (value){
                              setState(() {
                                selectedRowIndex=value!;
                              });
                            },
                          ),
                  ]
                      ),
                  ),
                  ]);
                }).toList(),
                dataRowHeight: 113.0,
              ),
            ],
          ),
        ),
      ],
    );
    // return Column(
    //   children: <Widget>[
    //     SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         children: [
    //           DataTable(
    //             columns: const [
    //               DataColumn(label: Text('Sr.No.'), numeric: true),
    //               DataColumn(label: Text('Meta')),
    //               DataColumn(label: Text('Send ?')),
    //               DataColumn(label: Text('Message')),
    //               DataColumn(label: Text('Edit')),
    //               DataColumn(label: Text('Enable')),
    //             ],
    //             rows: const [
    //               DataRow(cells: [
    //                 DataCell(Text('1')),
    //                 DataCell(Text('Task')),
    //                 DataCell(Text('Deactive')),
    //                 DataCell(Text('Your New Task Has Been Generated')),
    //                 DataCell(
    //                     IconButton(onPressed: null, icon: Icon(Icons.edit))),
    //                 DataCell(
    //                     IconButton(onPressed: null, icon: Icon(Icons.check))),
    //               ]),
    //               DataRow(cells: [
    //                 DataCell(Text('2')),
    //                 DataCell(Text('Client')),
    //                 DataCell(Text('Deactive')),
    //                 DataCell(Text('Your New Task Has Been Generated')),
    //                 DataCell(
    //                     IconButton(onPressed: null, icon: Icon(Icons.edit))),
    //                 DataCell(
    //                     IconButton(onPressed: null, icon: Icon(Icons.check))),
    //               ]),
    //               DataRow(cells: [
    //                 DataCell(Text('3')),
    //                 DataCell(Text('Company')),
    //                 DataCell(Text('Deactive')),
    //                 DataCell(Text('Your New Task Has Been Generated')),
    //                 DataCell(
    //                     IconButton(onPressed: null, icon: Icon(Icons.edit))),
    //                 DataCell(
    //                     IconButton(onPressed: null, icon: Icon(Icons.check))),
    //               ]),
    //             ],
    //             dataRowHeight: 32.0,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
