import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/API/Admin%20DataModel/paymentMethodModel.dart';
import 'package:task_manager/ui/Admin/Setting/add_payment_method.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class Payment_Method extends StatefulWidget {
  const Payment_Method({super.key});

  @override
  State<Payment_Method> createState() => _Payment_MethodState();
}

TextEditingController nameController =
    TextEditingController(); // Define the TextEditingController
int dataCount = 0;

class _Payment_MethodState extends State<Payment_Method> {
  late TableSource _source; // Declare _source here

  String? stringResponse;
  late double deviceWidth;
  late double deviceHeight;
  TextEditingController searchLogController = TextEditingController();

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
  }

  void refreshTable() {
    setState(() {
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
          "Menu > Setting > Payment Method",
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
          "Payment Method",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.1,
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
          ),
          onPressed: refreshTable,
        ),
      ],
    );
  }

  Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(() => AddPaymentMethod());
          },
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
        // SizedBox(
        //   height: deviceHeight * 0.02,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 10),
        //         child: TextField(
        //           controller: _searchController,
        //           decoration: const InputDecoration(
        //             labelText: 'Search by User Name',
        //           ),
        //           onSubmitted: (vlaue) {
        //             _source.filterServerSide(_searchController.text);
        //           },
        //         ),
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           _searchController.text = '';
        //         });
        //         _source.filterServerSide(_searchController.text);
        //         ;
        //       },
        //       icon: const Icon(Icons.clear),
        //     ),
        //     IconButton(
        //       onPressed: () => _source.filterServerSide(_searchController.text),
        //       icon: const Icon(Icons.search),
        //     ),
        //     IconButton(
        //       icon: Icon(
        //         Icons.refresh,
        //       ),
        //       onPressed: refreshTable,
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: deviceHeight * 0.03,
        // ),
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
              label: const Text('Id'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Action'),
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

class TableSource extends AdvancedDataTableSource<PaymentMethod> {
  final BuildContext context; // Add the context parameter

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  void deleteUser(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.deletePaymentMethod}',
        params: {'id': id},
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

  void updateUserPassword(String? id, String newName) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editPaymentMethod}',
        params: {'id': id, 'name': newName},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: " ${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
  }

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final PaymentMethod dataList = lastDetails!.rows[index];

    return DataRow(
      cells: [
        DataCell(Text(srNo)),
        DataCell(Text(dataList.id ?? '')),
        DataCell(Text(dataList.name ?? '')),
        DataCell(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        nameController.text = dataList.name ?? '';
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit Payment Method'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Name',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    String newName = nameController.text.trim();
                                    if (newName.isNotEmpty) {
                                      updateUserPassword(dataList.id, newName);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Field Is Empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                      );
                                    }
                                  },
                                  child: Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.edit),
                      constraints: BoxConstraints.tight(Size(24, 24)),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        // Handle button pressed
                        if (dataList.id != null) {
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
                              deleteUser(dataList.id!);
                            },
                            onCancel: () {},
                          );
                        }
                      },
                      child: Icon(Icons.delete),
                      constraints: BoxConstraints.tight(Size(24, 24)),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
      // selected: selectedIds.contains(dataList.id),
      // onSelectChanged: (value) {
      //   selectedRow(dataList.id.toString(), value ?? false);
      // },
    );
  }

  @override
  int get selectedRowCount => selectedIds.length;

  // void selectedRow(String id, bool newSelectState) {
  //   if (selectedIds.contains(id)) {
  //     selectedIds.remove(id);
  //   } else {
  //     selectedIds.add(id);
  //   }
  //   notifyListeners();
  // }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<PaymentMethod>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString()
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.paymentMethod}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      int count = dataModel.data.length ?? 0;
      final dynamicData = dataModel.data;
      dataCount = count;
      return RemoteDataSourceDetails(
        //dataModel.count ?? 0,
        count,
        dynamicData
            .map<PaymentMethod>(
              (item) => PaymentMethod.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<PaymentMethod>(
                  (item) =>
                      PaymentMethod.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
