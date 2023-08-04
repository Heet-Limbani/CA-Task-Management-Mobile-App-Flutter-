import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/API/Admin%20DataModel/getUsersDataModel.dart';
import 'package:task_manager/ui/Admin/Users/addClientForm.dart';
import 'package:task_manager/ui/Admin/Users/editClientForm.dart';
import 'package:task_manager/ui/Admin/Users/viewClient.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class Client extends StatefulWidget {
  const Client({super.key});

  @override
  State<Client> createState() => _ClientState();
}

int dataCount = 0;

class _ClientState extends State<Client> {
  late TableSource _source; // Declare _source here

  String? stringResponse;
  late double deviceWidth;
  late double deviceHeight;
  //List<GetUser> dataList = [];
  TextEditingController searchLogController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;

  // ignore: avoid_positional_boolean_parameters
  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

  @override
  void initState() {
    super.initState();
    _source = TableSource(context); // Initialize _source here

    fetchData();
  }

  void refreshTable1() {
    fetchData(); // Refresh data
  }

  List<GetUser> dataList = [];
  int currentPage = 0;
  int rowsPerPage = 10;
  int totalCount = 0;
  genModel? dataModel;

  Future<void> fetchData() async {
    int offset = currentPage * rowsPerPage;
    dataModel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: {
        'offset': offset,
        'search': searchLogController.text.trim(),
      },
    );

    if (dataModel != null && dataModel?.status == true) {
      final data = dataModel?.data;

      if (data != null && data is List) {
        dataList = data.map((item) => GetUser.fromJson(item)).toList();
        totalCount = dataModel?.count ?? 0;
      } else {
        dataList = [];
        totalCount = 0;
      }
    }
  }

  void handlePageChange(int pageIndex, genModel? model) async {
    currentPage = pageIndex ~/ rowsPerPage;
    //print('currentPage $currentPage');

    await fetchData();

    if (dataModel != null && dataModel?.data != null) {
      dataList = dataModel?.data!
          .map<GetUser>(
              (item) => GetUser.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      dataList = [];
    }

    setState(() {});
  }

  void deleteUser(String? clientId) async {
    if (clientId != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.deleteClient}',
        params: {'id': clientId},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: "${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        setState(() {});
      }
    }
  }

  void updateUserPassword(String? clientId, String newPassword) async {
    if (clientId != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.updateClientPassword}',
        params: {'id': clientId, 'pass': newPassword},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: " ${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        setState(() {});
      }
    }
  }

  void refreshTable() {
    // Perform the refresh operation here
    // For example, you can update the table data or reset the search/filter criteria
    setState(() {
      // Update the necessary variables or perform any other actions to refresh the table
      // For example, you can reset the startIndex and call setNextView() again
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Client",
          style: Theme.of(context)
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
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _add(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                // _search(),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                _table(),
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Table heading
  Row _header() {
    return Row(
      children: [
        Text(
          "Client List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(() => AddClientForm());
          },
          child: Text(
            "Add New Client",
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
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search by User Name',
                  ),
                  onSubmitted: (vlaue) {
                    _source.filterServerSide(_searchController.text);
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _searchController.text = '';
                });
                _source.filterServerSide(_searchController.text);
                ;
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () => _source.filterServerSide(_searchController.text),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: refreshTable,
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.03,
        ),
        AdvancedPaginatedDataTable(
          loadingWidget: () => UniversalShimmer(
            itemCount: dataCount,
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
          ),
          addEmptyRows: false,
          source: _source,
          showHorizontalScrollbarAlways: true,
          sortAscending: _sortAsc,
          sortColumnIndex: _sortIndex,
          showFirstLastButtons: true,
          rowsPerPage: _rowsPerPage,
          availableRowsPerPage: const [10, 20, 50, 100, 200],
          onRowsPerPageChanged: (newRowsPerPage) {
            if (newRowsPerPage != null) {
              setState(() {
                _rowsPerPage = newRowsPerPage;
              });
            }
          },
          columns: [
            DataColumn(
              label: const Text('Sr. No.'),
              numeric: true,
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('User Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('First Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Last Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Email ID'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Status'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Edit'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Delete'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('View'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Reset Password'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Chat'),
              onSort: setSort,
            ),
          ],
          //Optianl override to support custom data row text / translation
          getFooterRowText:
              (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
            final localizations = MaterialLocalizations.of(context);
            var amountText = localizations.pageRowsInfoTitle(
              startRow,
              pageSize,
              totalFilter ?? totalRowsWithoutFilter,
              false,
            );

            if (totalFilter != null) {
              //Filtered data source show addtional information
              amountText += ' filtered from ($totalRowsWithoutFilter)';
            }

            return amountText;
          },
          customTableFooter: _customFooter
              ? (source, offset) {
                  const maxPagesToShow = 6;
                  const maxPagesBeforeCurrent = 3;
                  final lastRequestDetails = source.lastDetails!;
                  final rowsForPager = lastRequestDetails.filteredRows ??
                      lastRequestDetails.totalRows;
                  final totalPages = rowsForPager ~/ _rowsPerPage;
                  final currentPage = (offset ~/ _rowsPerPage) + 1;
                  final List<int> pageList = [];
                  if (currentPage > 1) {
                    pageList.addAll(
                      List.generate(currentPage - 1, (index) => index + 1),
                    );
                    //Keep up to 3 pages before current in the list
                    pageList.removeWhere(
                      (element) =>
                          element < currentPage - maxPagesBeforeCurrent,
                    );
                  }
                  pageList.add(currentPage);
                  //Add reminding pages after current to the list
                  pageList.addAll(
                    List.generate(
                      maxPagesToShow - (pageList.length - 1),
                      (index) => (currentPage + 1) + index,
                    ),
                  );
                  pageList.removeWhere((element) => element > totalPages);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: pageList
                        .map(
                          (e) => TextButton(
                            onPressed: e != currentPage
                                ? () {
                                    //Start index is zero based
                                    source.setNextView(
                                      startIndex: (e - 1) * _rowsPerPage,
                                    );
                                  }
                                : null,
                            child: Text(
                              e.toString(),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              : null,
        ),
      ],
    );
  }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<GetUser> {
  final BuildContext context; // Add the context parameter

  TableSource(this.context);

  void deleteUser(String? clientId) async {
    if (clientId != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.deleteClient}',
        params: {'id': clientId},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: "${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
  }

  void updateUserPassword(String? clientId, String newPassword) async {
    if (clientId != null) {
    
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.updateClientPassword}',
        params: {'id': clientId, 'pass': newPassword.toString()},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: "${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
  }

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final GetUser dataList = lastDetails!.rows[index];

    return DataRow(
      cells: [
        DataCell(Text(srNo)),
        DataCell(Text(dataList.username ?? '')),
        DataCell(Text(dataList.firstName ?? '')),
        DataCell(Text(dataList.lastName ?? '')),
        DataCell(Text(dataList.email ?? '')),
        DataCell(Text(dataList.active == "1" ? 'Active' : 'Inactive')),
        DataCell(
          IconButton(
            onPressed: () {
              if (dataList.iD != null) {
                Get.to(EditClientForm(userId: dataList.iD!));
              }
            },
            icon: Icon(Icons.edit),
          ),
        ),
        DataCell(IconButton(
          onPressed: () {
            if (dataList.iD != null) {
              Get.defaultDialog(
                title: "Delete",
                middleText: "Are you sure you want to delete ?",
                textConfirm: "Yes",
                textCancel: "No",
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                cancelTextColor: Colors.black,
                onConfirm: () {
                  Get.back();
                  deleteUser(dataList.iD!);
                },
                onCancel: () {},
              );
            }
          },
          icon: Icon(Icons.delete),
        )),
        DataCell(IconButton(
          onPressed: () {
            if (dataList.iD != null) {
              Get.to(viewClient1(userId: dataList.iD!));
            }
          },
          icon: Icon(Icons.remove_red_eye),
        )),
        DataCell(IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String newPassword = ''; // Store the entered new password
                String confirmPassword =
                    ''; // Store the entered confirm password
                return AlertDialog(
                  title: Text('Reset Password'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          newPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter new password',
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm new password',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        if (newPassword.isNotEmpty &&
                            confirmPassword.isNotEmpty) {
                          if (newPassword == confirmPassword) {
                            updateUserPassword(dataList.iD, newPassword);
                          } else {
                            Fluttertoast.showToast(
                              msg: "Passwords do not match.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                            );
                          }
                        }
                      },
                      child: Text('Reset'),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.password),
        )),
        DataCell(IconButton(
          onPressed: () {
            // Implement chat functionality
          },
          icon: Icon(Icons.chat),
        )),
      ],
      // selected: selectedIds.contains(dataList.iD),
      // onSelectChanged: (value) {
      //   selectedRow(dataList.iD.toString(), value ?? false);
      // },
    );
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<GetUser>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
      'type': Urls.clientType,
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.getUsers}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      int count = dataModel.data.length ?? 0;
      dataCount = count;

      return RemoteDataSourceDetails(
        dataModel.count ?? 0,
        dynamicData
            .map<GetUser>(
              (item) => GetUser.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<GetUser>(
                  (item) => GetUser.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/API/model/genModel.dart';
// import 'package:task_manager/API/model/getUsersDataModel.dart';
// import 'package:task_manager/ui/pages/Users/addClientForm.dart';
// import 'package:task_manager/ui/pages/Users/editClientForm.dart';
// import '../DashBoard/sidebarAdmin.dart';
// import 'package:task_manager/API/Urls.dart';

// class Client extends StatefulWidget {
//   const Client({super.key});

//   @override
//   State<Client> createState() => _ClientState();
// }

// class _ClientState extends State<Client> {
//   String? stringResponse;
//   late double deviceWidth;
//   late double deviceHeight;
//   List<GetUser> clientType = [];
//   TextEditingController searchLogController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     getUser();
//   }

//   void refreshTable() {
//     getUser(); // Refresh data
//   }

//   void getUser() async {
//     genModel? genmodel = await Urls.postApiCall(
//       method: '${Urls.getUsers}',
//       params: {
//         'type': Urls.clientType,
//         'limit': "200",
//         'search': searchLogController.text.trim(),
//       },
//     );

//     if (genmodel != null && genmodel.status == true) {
//       final data = genmodel.data;

//       if (data != null && data is List) {
//         clientType = data.map((item) => GetUser.fromJson(item)).toList();
//         // if (clientType.isEmpty) {
//         //   // List is empty
//         //   print("No client data available.");
//         // } else {
//         //   // List has values
//         //   print("Client data available.");
//         // }
//         // for (GetUser clientdata1 in clientType) {
//         //   print('UserName: ${clientdata1.username}');
//         // }
//         setState(() {});
//       }
//     }
//   }

  
//   void deleteUser(String? clientId) async {
//     if (clientId != null) {
//       genModel? genmodel = await Urls.postApiCall(
//         method: '${Urls.deleteClient}',
//         params: {'id': clientId},
//       );

//       if (genmodel != null && genmodel.status == true) {
//         Fluttertoast.showToast(
//           msg: "${genmodel.message.toString()}",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//         );
//         setState(() {});
//       }
//     }
//   }

//    void updateUserPassword(String? clientId, String newPassword) async {
//     if (clientId != null) {
//       genModel? genmodel = await Urls.postApiCall(
//         method: '${Urls.updateClientPassword}',
//         params: {'id': clientId, 'pass': newPassword},
//       );

//       if (genmodel != null && genmodel.status == true) {
//         Fluttertoast.showToast(
//           msg: " ${genmodel.message.toString()}",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//         );
//         setState(() {});
//       }
//     }
//   }

//   Widget build(BuildContext context) {
//     deviceWidth = MediaQuery.of(context).size.width;
//     deviceHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Menu > User > Client",
//           style: Theme.of(context)
//               .textTheme
//               .bodySmall!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         foregroundColor: Colors.grey,
//         backgroundColor: Colors.transparent,
//       ),
//       drawer: SideBarAdmin(),
//       extendBody: true,
//       body: _buildBody(),
//     );
//   }

//   Stack _buildBody() {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: deviceHeight * 0.04,
//                 ),
//                 _header(),
//                 SizedBox(
//                   height: deviceHeight * 0.02,
//                 ),
//                 _add(),
//                 SizedBox(
//                   height: deviceHeight * 0.01,
//                 ),
//                 _search(),
//                SizedBox(
//                   height: deviceHeight * 0.03,
//                 ),
//                 _table(),
//                SizedBox(
//                   height: deviceHeight * 0.1,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Table heading
//   Row _header() {
//     return Row(
//       children: [
//         Text(
//           "Client List",
//           style: TextStyle(
//             color: Colors.blueGrey[900],
//             fontWeight: FontWeight.w700,
//             fontSize: 22,
//           ),
//         ),
//         SizedBox(
//           width: deviceWidth * 0.02,
//         ),
//         IconButton(
//           icon: Icon(Icons.refresh),
//           onPressed: refreshTable,
//         ),
        
//       ],
//     );
//   }

//   Row _search() {
//     return Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             width: deviceWidth * 0.3,
//             child: TextField(
//               controller: searchLogController,
//               onChanged: (value) {
//                 getUser();
//               },
//               decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                   hintText: 'Search',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: const BorderSide(),
//                   ),
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: GestureDetector(
//                     onTap: () {
//                       searchLogController.clear();
//                       FocusScope.of(context).unfocus();
//                       searchLogController.clear();
//                       getUser();
//                       // setState(() {});
//                     },
//                     child: Icon(Icons.clear),
//                   )),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//  Row _add() {
//     return Row(
//       children: [
//         OutlinedButton(
//           onPressed: () {
//             Get.to(() => AddClientForm());
//           },
//           child: Text(
//             "Add New Employee",
//             style: TextStyle(
//               fontSize: 12,
//               letterSpacing: 0,
//               color: Colors.blue,
//             ),
//           ),
//           style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }


//   Column _table() {
//     return Column(
//       children: <Widget>[
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               DataTable(
//                 columns: const [
//                   DataColumn(label: Text('Sr. No.'), numeric: true),
//                   DataColumn(label: Text('User Name')),
//                   DataColumn(label: Text('First Name')),
//                   DataColumn(label: Text('Last Name')),
//                   DataColumn(label: Text('Email ID')),
//                   DataColumn(label: Text('Status')),
//                   DataColumn(label: Text('Edit')),
//                   DataColumn(label: Text('Delete')),
//                   DataColumn(label: Text('Reset Password')),
//                   DataColumn(label: Text('Permission')),
//                   DataColumn(label: Text('Chat')),
//                 ],
//                 rows: clientType.map((GetUser user) {
//                   final index = clientType.indexOf(user);
//                   final srNo = (index + 1).toString();

//                   //final createdOnFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
//                   // final createdOnDate =
//                   //     createdOnFormat.parse(user.createdOn ?? '');

//                   // final formattedDate =
//                   //     DateFormat('dd/MM/yyyy').format(createdOnDate);

//                   return DataRow(cells: [
//                     DataCell(Text(srNo)),
//                     DataCell(Text(user.username ?? '')),
//                     DataCell(Text(user.firstName ?? '')),
//                     DataCell(Text(user.lastName ?? '')),
//                     DataCell(Text(user.email ?? '')),
//                     DataCell(Text(user.active == "1" ? 'Active' : 'Inactive')),
//                     DataCell(
//                       IconButton(
//                         onPressed: () {
//                           if (user.iD != null) {
//                             Get.to(EditClientForm(userId: user.iD!));
//                           }
//                         },
//                         icon: Icon(Icons.edit),
//                       ),
//                     ),
//                     DataCell(IconButton(
//                       onPressed: () {
//                         if (user.iD != null) {
//                           deleteUser(user.iD!);
//                           getUser();
//                         }
//                       },
//                       icon: Icon(Icons.delete),
//                     )),
//                     DataCell(IconButton(
//                       onPressed: () {
//                         if (user.iD != null) {
//                           // Show a dialog to reset the password
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               String newPassword =
//                                   ''; // Store the entered new password
//                               String confirmPassword =
//                                   ''; // Store the entered confirm password

//                               return AlertDialog(
//                                 title: Text('Reset Password'),
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     TextField(
//                                       onChanged: (value) {
//                                         newPassword = value;
//                                       },
//                                       obscureText: true,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter new password',
//                                       ),
//                                     ),
//                                     TextField(
//                                       onChanged: (value) {
//                                         confirmPassword = value;
//                                       },
//                                       obscureText: true,
//                                       decoration: InputDecoration(
//                                         hintText: 'Confirm new password',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context)
//                                           .pop(); // Close the dialog
//                                     },
//                                     child: Text('Cancel'),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context)
//                                           .pop(); // Close the dialog
//                                       if (newPassword.isNotEmpty &&
//                                           confirmPassword.isNotEmpty) {
//                                         if (newPassword == confirmPassword) {
//                                           updateUserPassword(
//                                               user.iD, newPassword);
//                                         } else {
//                                           Fluttertoast.showToast(
//                                             msg: "Passwords do not match.",
//                                             toastLength: Toast.LENGTH_SHORT,
//                                             gravity: ToastGravity.BOTTOM,
//                                             timeInSecForIosWeb: 1,
//                                           );
//                                         }
//                                       }
//                                     },
//                                     child: Text('Reset'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                       },
//                       icon: Icon(Icons.password),
//                     )),
//                     DataCell(IconButton(
//                       onPressed: () {
//                         // Implement permission functionality
//                       },
//                       icon: Icon(Icons.check),
//                     )),
//                     DataCell(IconButton(
//                       onPressed: () {
//                         // Implement chat functionality
//                       },
//                       icon: Icon(Icons.chat),
//                     )),
//                   ]);
//                 }).toList(),
//                 dataRowHeight: 32.0,
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }


// }
///////
///
///

  // _table() {
  //   return Column(
  //     children: <Widget>[
  //       SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: [
  //             DataTable(
  //               columns: const [
  //                 DataColumn(label: Text('Sr. No.'), numeric: true),
  //                 DataColumn(label: Text('User ID')),
  //                 DataColumn(label: Text('Name')),
  //                 DataColumn(label: Text('Edit')),
  //                 DataColumn(label: Text('Delete')),
  //               ],
  //               rows: clients.map((birthday) {
  //                 final index = clients.indexOf(birthday);
  //                 final srNo = (index + 1).toString();
  //                 final userId = birthday.id;
  //                 final name = birthday.name;
  //                 return DataRow(cells: [
  //                   DataCell(Text(srNo)),
  //                   DataCell(Text(userId!)),
  //                   DataCell(Text(name!)),
  //                   DataCell(IconButton(
  //                       onPressed: () {
  //                         Navigator.pushReplacementNamed(
  //                             context, '/editPaymentMethod',
  //                             arguments: {'userId': userId});
  //                       },
  //                       icon: Icon(Icons.edit))),
  //                   DataCell(IconButton(
  //                       onPressed: () {
  //                         deleteData(int.parse(userId));
  //                         paymentTable();
  //                       },
  //                       icon: Icon(Icons.delete))),
  //                 ]);
  //               }).toList(),
  //               dataRowHeight: 32.0,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
//}

//  void paymentTable() async {
//     genModel? genmodel = await url.Urls.postApiCall(
//       method: '${Urls.paymentMethod}',
//     );

//     if (genmodel != null && genmodel.status == true) {
//       final data = genmodel.data;

//       if (data != null && data is List) {
//         clients = data.map((item) => PaymentMethod.fromJson(item)).toList();

//         totalCount = genmodel.count ?? 0;

//         setState(() {});
//       }
//     }
//   }