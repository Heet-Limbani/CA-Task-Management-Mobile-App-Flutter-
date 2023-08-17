import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/AdminDataModel/clientLogDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Admin/Users/editLogClient.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';

class ClientLogDetails extends StatefulWidget {
  final String userId;
  const ClientLogDetails({required this.userId, Key? key}) : super(key: key);
  @override
  State<ClientLogDetails> createState() => _ClientLogDetailsState();
}

String userId = '';

late double deviceWidth;
late double deviceHeight;
late ClientSource _source; // Declare _source here

//final _source = ClientSource(context);
var _sortIndex = 0;
var _sortAsc = true;
var _customFooter = false;
var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
TextEditingController _searchController = TextEditingController();
int dataCount = 0;

class _ClientLogDetailsState extends State<ClientLogDetails> {
  @override
  void initState() {
    super.initState();
    _source = ClientSource(context); // Initialize _source here

    userId = widget.userId; // Store widget.userId in a local variable
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Users > Client > viewClient > Log",
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

  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

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

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Client Log Details",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        const Spacer(),
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
            // DataColumn(
            //   label: const Text('Client Name'),
            //   onSort: setSort,
            // ),
            DataColumn(
              label: const Text('Message'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Description'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Created On'),
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

class ClientSource extends AdvancedDataTableSource<Client> {
  final BuildContext context; // Add the context parameter
  ClientSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable
  void deleteUser(String? clientId) async {
    if (clientId != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientViewLogDetailsEdit}',
        params: {'id': clientId, 'delete': "delete"},
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

  void updateUserPassword(
      String? clientId, String message, String description, String date) async {
    if (clientId != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientViewLogDetailsEdit}',
        params: {
          'id': clientId,
          'message': message,
          'description': description,
          'date': date,
          'save': "save"
        },
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
    final int srNo = startIndex + index + 1;
    final log = lastDetails!.rows[index];
    final parsedDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(log.onDate ?? '0') * 1000);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    //print("parsedDate $parsedDate");

    return DataRow(
      cells: [
        DataCell(Text(srNo.toString())),
        //DataCell(Text(client.client ?? "")),
        DataCell(Text(log.message ?? "")),
        DataCell(Text(log.description ?? "")),
        DataCell(Text(formattedDate)),
        DataCell(Text(log.createdOn ?? "")),
        DataCell(
          IconButton(
            onPressed: () {
              Get.to(EditLogClient(logId: log.id!));
            },
            icon: Icon(Icons.edit),
          ),
        ),
        DataCell(IconButton(
          onPressed: () {
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
                deleteUser(log.id!);
              },
              onCancel: () {},
            );
          },
          icon: Icon(Icons.delete),
        )),
      ],
      // selected: selectedIds.contains(log.id),
      // onSelectChanged: (value) {
      //   selectedRow(log.id.toString(), value ?? false);
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

  void refresh() {
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Client>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
      'id': userId,
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.clientViewLogDetails}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      int count = dataModel.data.length ?? 0;
      dataCount = count;
      return RemoteDataSourceDetails(
        dataModel.count ?? 0,
        dynamicData
            .map<Client>(
              (item) => Client.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<Client>(
                  (item) => Client.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
