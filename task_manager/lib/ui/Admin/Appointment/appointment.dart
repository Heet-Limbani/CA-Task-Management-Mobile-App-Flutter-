import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/AppointmentDataModel.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

TextEditingController nameController =
    TextEditingController(); // Define the TextEditingController
int dataCount = 0;

class _AppointmentState extends State<Appointment> {
  late TableSource _source; // Declare _source here

  String? stringResponse;
  late double deviceWidth;
  late double deviceHeight;
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
          "Menu > Appointment",
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
          "Appointment List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
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
                    labelText: 'Search',
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
              label: const Text('Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Topic'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Time'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Status'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text(
                'Action',
                textAlign: TextAlign.center,
              ),
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

class TableSource extends AdvancedDataTableSource<AppointmentDataModel> {
  final BuildContext context; // Add the context parameter

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  void deleteAppointment(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.appointmentDelete}',
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

  void rejectAppointment(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.appointmentReject}',
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

  void approveAppointment(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.appointmentAccept}',
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



  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final AppointmentDataModel dataList = lastDetails!.rows[index];
    String statusValue = "";
    if (dataList.status == "0") {
      statusValue = "In Waiting";
    } else if (dataList.status == "1") {
      statusValue = "Approved";
    } else {
      statusValue = "Reject";
    }
     final parsedDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(dataList.date ?? '0') * 1000);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
     final parsedDate1 = DateTime.fromMillisecondsSinceEpoch(
        int.parse(dataList.time ?? '0') * 1000);
    final formattedDate1 = DateFormat('hh:mm:ss').format(parsedDate1.toUtc());
    return DataRow(
      cells: [
        DataCell(Text(srNo)),
        DataCell(Text(dataList.userName ?? '')),
        DataCell(Text(dataList.topic ?? '')),
        DataCell(Text(formattedDate)),
        DataCell(Text(formattedDate1)),
        DataCell(Text(statusValue)),
        DataCell(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                if (dataList.status == "0")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          approveAppointment(dataList.id);
                        },
                        child: Icon(Icons.check),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          rejectAppointment(dataList.id);
                        },
                        child: Icon(Icons.close),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          deleteAppointment(dataList.id);
                        },
                        child: Icon(Icons.delete),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {},
                        child: Icon(Icons.mail),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                if (dataList.status == "1" || dataList.status == "2")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        child: Icon(Icons.mail),
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
  Future<RemoteDataSourceDetails<AppointmentDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString()
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.appointment}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      int count = dataModel.data.length ?? 0;
      final dynamicData = dataModel.data;
      dataCount = count;

      return RemoteDataSourceDetails(
        dataModel.count ?? 0,
        //count,
        dynamicData
            .map<AppointmentDataModel>(
              (item) =>
                  AppointmentDataModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<AppointmentDataModel>(
                  (item) => AppointmentDataModel.fromJson(
                      item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
