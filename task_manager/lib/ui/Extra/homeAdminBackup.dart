import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/clientDataModel.dart';
import 'package:task_manager/API/model/countDataModel.dart';
import 'package:task_manager/API/model/getUsersDataModel.dart';
import 'package:task_manager/API/model/holidayDataModel.dart';
import 'package:task_manager/ui/core/res/color.dart';
import 'package:task_manager/ui/pages/DashBoard/sidebarAdmin.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/clientLogDataModel.dart';
import '../../../API/model/genModel.dart';
import 'package:task_manager/API/model/birthDayDataModel.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  List<GetUser> clientType = [];
  List<ClientData> clientsdata = [];

  late double deviceWidth;
  late double deviceHeight;
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController clientController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController searchLogController = TextEditingController();
  String clientId = "";
  String selectedClientId = "";
  String clientName = '';
  String message = "";
  String description = "";
  String date = '';
  int offset = 0;

  int limit = 10;

  String?
      selectedClientId1; // Create a variable to store the selected client ID

  //DateTime? selectedDateTime;
  DateTime? selectedDateTime =
      DateTime.now(); // Initialize with current date and time

  @override
  void dispose() {
    clientController.dispose();
    messageController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    searchLogController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    clientDashboard();
    birthDayTable();
    holidayTable();
    clientTable();
    clientData();
    getUser();
  }

  List<Client> clients = [];
  int currentPage = 0;
  int rowsPerPage = 10;
  int totalCount = 0;
  genModel? dataModel;

  Future<void> fetchData() async {
    int offset = currentPage * rowsPerPage;

    dataModel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
      params: {
        'offset': offset,
        'search': searchLogController.text.trim(),
      },
    );
              
    if (dataModel != null && dataModel?.status == true) {
      final dynamicData = dataModel?.data;

      if (dynamicData != null && dynamicData is List) {
        clients = dynamicData
            .map<Client>(
                (item) => Client.fromJson(item as Map<String, dynamic>))
            .toList();
        totalCount = dataModel?.count ?? 0;
       // print("Data $dynamicData"); // Print the received data for debugging
      } else {
        clients = [];
        totalCount = 0;
      }
    }

    // Print the values for debugging
    // print("Offset: $offset");
    // print("Data Model: $dataModel");
    // print("Clients: $clients");
    // print("Total Count: $totalCount");
  }

  void handlePageChange(int pageIndex, genModel? model) async {
    currentPage = pageIndex ~/ rowsPerPage;
    //print('currentPage $currentPage');

    await fetchData();

    if (dataModel != null && dataModel?.data != null) {
      clients = dataModel?.data!
          .map<Client>((item) => Client.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      clients = [];
    }

    setState(() {}); // Only call setState once after updating clients
  }

  CountData? dataCount;
  void clientDashboard() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      //print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataCount = CountData.fromJson(data);
        //print('data  ${dataCount?.count?.pendingCount}');

        setState(() {});
      }
    }
  }

  BirthDayList? dataBirthdayList;
  void birthDayTable() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataBirthdayList = BirthDayList.fromJson(data);
        if (dataBirthdayList?.birthday != null) {
          // for (Birthday birthday in dataBirthdayList!.birthday!) {
          //   print('BirthDay ID: ${birthday.id}');
          // }
        }
        setState(() {});
      }
    }
  }

  HolidayList? dataHolidayList;
  void holidayTable() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataHolidayList = HolidayList.fromJson(data);

        setState(() {});
      }
    }
  }

  ClientList? dataClientList;
  void clientData() async {
    genModel? genmodel =
        await Urls.postApiCall(method: '${Urls.adminDashBoard}');
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel.data}');

        final data = genmodel.data;
        dataClientList = ClientList.fromJson(data);
        if (dataClientList?.clientdata != null) {
          clientsdata = (data['client'] as List<dynamic>)
              .map((item) => ClientData.fromJson(item as Map<String, dynamic>))
              .toList();
          //print("clients $clients.asString()");
          //print("clientsdata $clientsdata");
          if (clientsdata.isEmpty) {
            // List is empty
            // print("No client data available.");
          } else {
            // List has values
            // print("Client data available.");
          }
          // for (ClientData clientdata1 in dataClientList!.clientdata!) {
          // print('UserName: ${clientdata1.username}');
          //}
        }
        setState(() {});
      }
    }
  }

  void clientTable({int offset = 0, int limit = 10}) async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
      params: {
        'offset': offset,
        'search': searchLogController.text.trim(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clients = data.map((item) => Client.fromJson(item)).toList();
        // print("Count :- ${genmodel.count}");
        totalCount = genmodel.count ?? 0;
        // for (Client client in clients) {
        //   print('Client ID: ${client.id}');
        //   print('Client Name: ${client.client}');
        //   print('Message: ${client.message}');
        //   // Print other client properties as needed
        // }
        setState(() {
          // Update the UI state if necessary
        });
      }
    }
  }

  void clientLogAdd() async {
    try {
      if (selectedDateTime == null) {
        selectedDateTime = DateTime.now();
      }
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientLogAdd}',
        params: {
          'message': message,
          'client': selectedClientId1,
          'description': description,
          'date': selectedDateTime.toString(),
        },
      );
      if (genmodel != null) {
        if (genmodel.status == true) {
          setState(() {
            clientId = '';
          });
        }
      }
    } catch (e) {
      // Handle the exception
    }
  }

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: {'type': Urls.clientType, 'limit': "200"},
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clientType = data.map((item) => GetUser.fromJson(item)).toList();
        //if (clientType.isEmpty) {
        // List is empty
        //print("No client data available.");
        // } else {
        // List has values
        //print("Client data available.");
        // }
        // for (GetUser clientdata1 in clientType) {
        //   print('UserName: ${clientdata1.username}');
        // }
        setState(() {});
      }
    }
  }
  // void openUserListDialog(List<ClientData> clientList) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Select User'),
  //         content: Container(
  //           width: double.maxFinite,
  //           child: ListView.builder(
  //             /// aa customise karvu padse list view last itm ma ave etle api call karavi ne bijo  data server prthi fetch karvau pdse ok sir and sir naitar api call karvi ne limit ma count put karaviye to badhi entry aavijay list ma ? na em nai chale moklavu tne example tyar sudhi package implement kar advance pagination varo ha sir
  //             shrinkWrap: true,
  //             itemCount: clientList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               final client = clientList[index];
  //               return ListTile(
  //                 title: Text(client.username ?? ''),
  //                 onTap: () {
  //                   setState(() {
  //                     clientId = client.iD!;
  //                     clientController.text = clientId;
  //                   });
  //                   Navigator.of(context).pop();
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _admin(),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return ListTile(
                      title: Text(client.client ?? ''),
                      subtitle: Text(client.message ?? ''),
                    );
                  },
                ),

                //_client(),

                //_employee(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Stack _buildBody() {
  //   return Stack(
  //     children: [
  //       SingleChildScrollView(
  //         child: Container(
  //           margin: const EdgeInsets.symmetric(
  //             horizontal: 15,
  //             vertical: 0,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 height: deviceHeight * 0.02,
  //               ),
  //               _admin(),

  //               // _client(),

  //               //_employee(),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Column _admin() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              "Admin Dashboard",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              toolbarOptions: const ToolbarOptions(
                copy: true,
                selectAll: true,
              ),
            ),
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.add_circle_outline,
            //       color: Colors.blue[400],
            //     ))
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: TaskGroupContainer(
                color: Colors.purple,
                icon: Icons.today_rounded,
                taskCount: dataCount?.count?.tasksCount ?? '0',
                taskGroup: "Today's Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.1,
              child: TaskGroupContainer(
                color: Colors.blue,
                icon: Icons.pending_actions,
                taskCount: dataCount?.count?.pendingCount ?? '0',
                taskGroup: "Pending Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.orange,
                isSmall: true,
                icon: Icons.attach_money,
                taskCount: dataCount?.count?.taxPayableCount ?? '0',
                taskGroup: "Tax Payable",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.red,
                icon: Icons.watch_later_outlined,
                taskCount: dataCount?.count?.totalOverdueTaskCount ?? '0',
                taskGroup: "Overdue Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.green,
                isSmall: true,
                icon: Icons.live_help_rounded,
                taskCount: dataCount?.count?.totalQueryRaisedCount ?? '0',
                taskGroup: "Query Raised",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.pink,
                icon: Icons.keyboard,
                taskCount: dataCount?.count?.totalOnBoardCount ?? '0',
                taskGroup: "On Board Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.05,
              child: TaskGroupContainer(
                color: Colors.blue,
                isSmall: true,
                icon: Icons.punch_clock,
                taskCount: dataCount?.count?.unassignedTaskCount ?? '0',
                taskGroup: "UnAssign Work",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.orange,
                isSmall: true,
                icon: Icons.money_off_outlined,
                taskCount: dataCount?.count?.unpaidTaskBoardCount ?? '0',
                taskGroup: "UnPaid Tax",
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Task List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(), sir without debuging run karavu padse ok sir run nathi thatu km ?
            InkWell(
              onTap: () {},
              child: Text(
                "See all",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.2,
        ),
        Row(
          children: [
            Text(
              "Add Client Log",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: selectedClientId1,
                decoration: const InputDecoration(
                  labelText: 'Client',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedClientId1 = newValue;
                    clientController.text = selectedClientId1 ??
                        ''; // Update the clientController value
                  });
                },
                items: clientType.map((GetUser user) {
                  return DropdownMenuItem<String>(
                    value: user.iD ?? '',
                    child: Text(user.username ?? ''),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a client';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              // TextFormField(
              //   controller: clientController,
              //   decoration: const InputDecoration(
              //     labelText: 'Client ID',
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //       borderSide: BorderSide(color: Colors.grey, width: 0.0),
              //     ),
              //     border: OutlineInputBorder(),
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       selectedClientId1 = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a client ID';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: clientController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     labelText: 'Client ID',
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //       borderSide: BorderSide(color: Colors.grey, width: 0.0),
              //     ),
              //     border: OutlineInputBorder(),
              //   ),
              //   onTap: () {

              //     openUserListDialog(clientsdata);
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       clientId = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null ||
              //         value.isEmpty ||
              //         value.contains(RegExp(r'^[a-zA-Z\-]'))) {
              //       return 'Use only numbers!';
              //     }
              //     return null;
              //   },
              // ),

              // void openUserListDialog(List<ClientData> clientList) {
              //   showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: Text('Select User'),
              //         content: Container(
              //           width: double.maxFinite,
              //           child: ListView.builder(
              //             /// aa customise karvu padse list view last itm ma ave etle api call karavi ne bijo  data server prthi fetch karvau pdse ok sir and sir naitar api call karvi ne limit ma count put karaviye to badhi entry aavijay list ma ? na em nai chale moklavu tne example tyar sudhi package implement kar advance pagination varo ha sir
              //             shrinkWrap: true,
              //             itemCount: clientList.length,
              //             itemBuilder: (BuildContext context, int index) {
              //               final client = clientList[index];
              //               return ListTile(
              //                 title: Text(client.username ?? ''),
              //                 onTap: () {
              //                   setState(() {
              //                     clientId = client.iD!;
              //                     clientController.text = clientId;
              //                   });
              //                   Navigator.of(context).pop();
              //                 },
              //               );
              //             },
              //           ),
              //         ),
              //       );
              //     },
              //   );
              // }

              SizedBox(
                height: deviceHeight * 0.02,
              ),
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(
                    labelText: 'Message',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Last Name must contain at least 3 characters';
                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                    return 'Last Name cannot contain special characters';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    message = value;
                    // lastNameList.add(lastName);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
              ),
              SizedBox(height: deviceHeight * 0.02),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Description must contain at least 3 characters';
                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                    return 'Description cannot contain special characters';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    description = value;
                    // bodyTempList.add(bodyTemp);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox(height: deviceHeight * 0.02),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date And Time',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDateTime = await showDatePicker(
                    context: context,
                    initialDate: selectedDateTime ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  if (pickedDateTime != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          selectedDateTime ?? DateTime.now()),
                    );

                    if (pickedTime != null) {
                      selectedDateTime = DateTime(
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      setState(() {
                        date = selectedDateTime.toString();
                        dateController.text = date;
                      });
                    }
                  }
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    selectedDateTime = DateTime.tryParse(value);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    selectedDateTime = DateTime.tryParse(value);
                  });
                },
              ),

              // TextFormField(
              //   controller: dateController,
              //   decoration: const InputDecoration(
              //       labelText: 'Date And Time',
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //         borderSide: BorderSide(color: Colors.grey, width: 0.0),
              //       ),
              //       border: OutlineInputBorder()),
              //   onTap: () async {
              //     DateTime? selectedDateTime = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime(3000),
              //     );
              //     if (selectedDateTime != null) {
              //       TimeOfDay? selectedTime = await showTimePicker(
              //         context: context,
              //         initialTime: TimeOfDay.now(),
              //       );

              //       if (selectedTime != null) {
              //         selectedDateTime = DateTime(
              //           selectedDateTime.year,
              //           selectedDateTime.month,
              //           selectedDateTime.day,
              //           selectedTime.hour,
              //           selectedTime.minute,
              //         );
              //         setState(() {
              //           date = selectedDateTime.toString();
              //           dateController.text = date;
              //         });
              //       }
              //     }
              //   },
              //   onFieldSubmitted: (value) {
              //     setState(() {
              //       date = value;
              //     });
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       date = value;
              //     });
              //   },
              // ),
              SizedBox(height: deviceHeight * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60)),
                onPressed: () {
                  clientTable();
                  if (_formKey.currentState!.validate()) {
                    clientLogAdd();

                    Fluttertoast.showToast(
                      msg: "Client Log Added Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                  clientTable();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),

        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          children: [
            Text(
              "Client Log Data",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: deviceWidth * 0.3,
                child: TextField(
                  controller: searchLogController,
                  onChanged: (value) {
                    clientTable(); //
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchLogController.clear();
                          FocusScope.of(context).unfocus();
                          searchLogController.clear();
                          clientTable();
                          // setState(() {});
                        },
                        child: Icon(Icons.clear),
                      )),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        PaginatedDataTable(
          header: const Text('Your Table'),
          columns: const [
            DataColumn(label: Text('Sr. No.'), numeric: true),
            DataColumn(label: Text('Client Name')),
            DataColumn(label: Text('Message')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Created On')),
          ],
          source:
              ClientDataSource(clients, totalCount, currentPage * rowsPerPage),
          rowsPerPage: rowsPerPage,
          availableRowsPerPage: [rowsPerPage],
          onPageChanged: (pageIndex) {
            handlePageChange(pageIndex, dataModel);
          },
        ),
        // PaginatedDataTable(
        //   header: const Text('Client List'),
        //   columns: const [
        //     DataColumn(label: Text('Sr. No.'), numeric: true),
        //     DataColumn(label: Text('Client Name')),
        //     DataColumn(label: Text('Message')),
        //     DataColumn(label: Text('Description')),
        //     DataColumn(label: Text('Date')),
        //     DataColumn(label: Text('Created On')),
        //   ],
        //   source: _ClientDataTableSource(
        //     clients,
        //     totalCount,
        //     limit,
        //     offset,
        //   ),
        //   onPageChanged: (int pageIndex) {
        //     setState(() {
        //       offset += pageIndex;
        //       // print('offset $offset');
        //       // print('pageindex $pageIndex');
        //       // run kar to
        //     }); //offset ni value page change upar proper set nathi thati

        //     clientTable(offset: offset);
        //   },
        //   rowsPerPage: limit,
        // ),
        // // Column(
        // //   children: <Widget>[
        // //     SingleChildScrollView(
        // //       scrollDirection: Axis.horizontal,
        // //       child: Row(
        // //         children: [
        // //           DataTable(
        // //             columns: const [
        // //               DataColumn(label: Text('Sr. No.'), numeric: true),
        // //               DataColumn(label: Text('Client Name')),
        // //               DataColumn(label: Text('Message')),
        // //               DataColumn(label: Text('Description')),
        // //               DataColumn(label: Text('Date')),
        // //               DataColumn(label: Text('Created On')),
        // //             ],
        //             rows: clients.map((client) {
        // //               final index = clients.indexOf(client);
        // //               final srNo = (index + 1).toString();

        // //               // Parse createdOn string to DateTime
        // //               final createdOnFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        // //               final createdOnDate =
        // //                   createdOnFormat.parse(client.createdOn ?? '');

        // //               // Format the date as dd/mm/yyyy
        // //               final formattedDate =
        // //                   DateFormat('dd/MM/yyyy').format(createdOnDate);

        // //               return DataRow(cells: [
        // //                 DataCell(Text(srNo)),
        // //                 DataCell(Text(client.client ?? '')),
        // //                 DataCell(Text(client.message ?? '')),
        // //                 DataCell(Text(client.description ?? '')),
        // //                 DataCell(Text(formattedDate)),
        // //                 DataCell(Text(client.createdOn ?? '')),
        // //               ]);
        // //             }).toList(),
        // //             dataRowHeight: 32.0,
        // //           )
        // //         ],
        // //       ),
        // //     ),
        //   ],
        // ),

        SizedBox(
          height: deviceHeight * 0.1,
        ),

        Row(
          children: [
            Text(
              "Birthday List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Column(
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
                      DataColumn(label: Text('Birth Date')),
                    ],
                    rows: dataBirthdayList?.birthday?.map((birthday) {
                          final index =
                              dataBirthdayList?.birthday?.indexOf(birthday) ??
                                  -1;
                          final srNo = (index + 1).toString();
                          final userId = birthday.userId;
                          final name = birthday.userName;

                          return DataRow(cells: [
                            DataCell(Text(srNo)),
                            DataCell(Text(userId!)),
                            DataCell(Text(name!)),
                            DataCell(Text('')),
                          ]);
                        }).toList() ??
                        [],
                    dataRowHeight: 32.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          children: [
            Text(
              "Holiday List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Sr. No.'), numeric: true),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Date')),
                    ],
                    rows: dataHolidayList?.holiday?.map((holiday) {
                          final index =
                              dataHolidayList?.holiday?.indexOf(holiday) ?? -1;
                          final srNo = (index + 1).toString();
                          final title = holiday.title ?? '';
                          final description = holiday.description ?? '';
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              (int.tryParse(holiday.date!.toString()) ?? 0) *
                                  1000);
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(date);
                          return DataRow(cells: [
                            DataCell(Text(srNo)),
                            DataCell(Text(title)),
                            DataCell(Text(description)),
                            DataCell(Text(formattedDate.toString())),
                          ]);
                        }).toList() ??
                        [],
                    dataRowHeight: 32.0,
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.2,
        ),
      ],
    );
  }

  Column _client() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Client Dashboard",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: const [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1.1,
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.keyboard,
                  taskCount: 5,
                  taskGroup: "On Going Task",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: TaskGroupContainer(
                  color: Colors.green,
                  isSmall: true,
                  icon: Icons.live_help_rounded,
                  taskCount: 2,
                  taskGroup: "Query Raised",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1.2,
                child: TaskGroupContainer(
                  color: Colors.orange,
                  icon: Icons.pending_actions,
                  taskCount: 5,
                  taskGroup: "Inoice Raised",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1.2,
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.attach_money,
                  taskCount: 10,
                  taskGroup: "Amount",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: TaskGroupContainer(
                  color: Colors.purple,
                  icon: Icons.download,
                  taskCount: 5,
                  isSmall: true,
                  taskGroup: "Download",
                ),
              ),
            ])
      ],
    );
  }

  Column _employee() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Employee Dashboard",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: TaskGroupContainer(
                color: Colors.blue,
                icon: Icons.keyboard,
                taskCount: 5,
                taskGroup: "Today's Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.orange,
                isSmall: true,
                icon: Icons.pending_actions,
                taskCount: 2,
                taskGroup: "Pending Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.green,
                icon: Icons.currency_rupee,
                taskCount: 5,
                taskGroup: "Task Payable",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: TaskGroupContainer(
                color: Colors.red,
                icon: Icons.watch_later_rounded,
                taskCount: 10,
                taskGroup: "Overdue Task",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: TaskGroupContainer(
                color: Colors.purple,
                icon: Icons.live_help_outlined,
                taskCount: 5,
                isSmall: true,
                taskGroup: "Query Raised",
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Holiday List",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            // const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Sr. No.'), numeric: true),
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Date')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('John')),
                      DataCell(Text('Hello')),
                      DataCell(Text('2023-05-10')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('Jane')),
                      DataCell(Text('Hi')),
                      DataCell(Text('2023-05-11')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('3')),
                      DataCell(Text('Bob')),
                      DataCell(Text('Hey')),
                      DataCell(Text('2023-05-12')),
                    ]),
                  ],
                  dataRowHeight: 32.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
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
      drawer: SideBarAdmin(),
      extendBody: true,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildBody(), //try now
      ),
    );
  }
}

class ClientDataSource extends DataTableSource {
  final List<Client> clients;
  final int totalCount;
  final int startIndex;

  ClientDataSource(this.clients, this.totalCount, this.startIndex);

  @override
  DataRow getRow(int index) {
    final clientIndex = startIndex + index;
    if (clientIndex >= clients.length) {
      return DataRow(cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }

    final client = clients[clientIndex];

    return DataRow(cells: [
      DataCell(Text((clientIndex + 1).toString())),
      DataCell(Text(client.client ?? "")),
      DataCell(Text(client.message ?? "")),
      DataCell(Text(client.description ?? "")),
      DataCell(Text(client.onDate.toString())),
      DataCell(Text(client.createdOn ?? "")),
    ]);
  }

  @override
  int get rowCount => totalCount;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}


// class _ClientDataTableSource extends DataTableSource {
//   final List<Client> clients;
//   final int totalCount;
//   final int limit;
//   final int offset;

//   _ClientDataTableSource(
//       this.clients, this.totalCount, this.limit, this.offset);

//   @override
//   DataRow? getRow(int index) {
//     if (index >= rowCount) {
//       return null;
//     }
//     // final clientIndex = index;//   aa logic ? ha aa logic work nathi karto
//     //print("index : $index");
//     // print("offset : $offset"); //run
//     //final clientIndex = index + (pageIndex * limit);
//     final client = clients[index];
//     final srNo = (index + 1).toString(); 
//      final srNo = ((limit * pageIndex) - (limit - 1) + index).toString();
    // final createdOnFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    // final createdOnDate = createdOnFormat.parse(client.createdOn ?? '');
    // final formattedDate = DateFormat('dd/MM/yyyy').format(createdOnDate);

//     return DataRow.byIndex(index: index, cells: [
//       DataCell(Text(srNo)),
//       DataCell(Text(client.client ?? '')),
//       DataCell(Text(client.message ?? '')),
//       DataCell(Text(client.description ?? '')),
//       DataCell(Text(formattedDate)),
//       DataCell(Text(client.createdOn ?? '')),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => totalCount;

//   @override
//   int get selectedRowCount => 0;
// }

// class _ClientDataTableSource extends DataTableSource {
//   final List<Client> clients;

//   _ClientDataTableSource(this.clients);

//   @override
//   DataRow? getRow(int index) {
//     if (index >= clients.length) {
//       return null;
//     }

//     final client = clients[index];
//     final srNo = (index + 1).toString();

//     final createdOnFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
//     final createdOnDate = createdOnFormat.parse(client.createdOn ?? '');
//     final formattedDate = DateFormat('dd/MM/yyyy').format(createdOnDate);

//     return DataRow(cells: [
//       DataCell(Text(srNo)),
//       DataCell(Text(client.client ?? '')),
//       DataCell(Text(client.message ?? '')),
//       DataCell(Text(client.description ?? '')),
//       DataCell(Text(formattedDate)),
//       DataCell(Text(client.createdOn ?? '')),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => clients.length;

//   @override
//   int get selectedRowCount => 0;
// }
