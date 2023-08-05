import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/AdminDataModel/clientTicketDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/logModel.dart';
import 'package:task_manager/ui/Admin/Users/editClientForm.dart';
import '../sidebar/sidebarAdmin.dart';

class ClientTicketDetails extends StatefulWidget {
  final String userId;
  const ClientTicketDetails({required this.userId, Key? key}) : super(key: key);
  @override
  State<ClientTicketDetails> createState() => _ClientTicketDetailsState();
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

class _ClientTicketDetailsState extends State<ClientTicketDetails> {
  @override
  void initState() {
    super.initState();
    _source = ClientSource(context); // Initialize _source here

    userId = widget.userId; // Store widget.userId in a local variable
    print("userId :- $userId");
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Users > Client > viewClient > Ticket",
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
    // Perform the refresh operation here
    // For example, you can update the table data or reset the search/filter criteria
    setState(() {
      // Update the necessary variables or perform any other actions to refresh the table
      // For example, you can reset the startIndex and call setNextView() again
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
          "Client Ticket Details",
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
              label: const Text('Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Starting Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Description'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Amount'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Status'),
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

class ClientDataSource extends DataTableSource {
  final List<Log> log;
  final int totalCount;
  final int startIndex;

  ClientDataSource(this.log, this.totalCount, this.startIndex);

  @override
  DataRow getRow(int index) {
    final clientIndex = startIndex + index;
    if (clientIndex >= log.length) {
      return DataRow(cells: [
        DataCell(Text('')),
        //DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }
    void deleteUser(String? clientId) async {
      if (clientId != null) {
        print("clientId :- $clientId");
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

    final client = log[clientIndex];

    return DataRow(cells: [
      DataCell(Text((clientIndex + 1).toString())),
      //DataCell(Text(client.client ?? "")),
      DataCell(Text(client.message ?? "")),
      DataCell(Text(client.description ?? "")),
      DataCell(Text(client.onDate.toString())),
      DataCell(Text(client.createdOn ?? "")),
      DataCell(
        IconButton(
          onPressed: () {
            Get.to(EditClientForm(userId: client.id!));
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
              deleteUser(client.id!);
            },
            onCancel: () {},
          );
        },
        icon: Icon(Icons.delete),
      )),
    ]);
  }

  @override
  int get rowCount => totalCount;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

/////////////
///
///////
typedef SelectedCallBack = Function(String id, bool newSelectState);

class ClientSource extends AdvancedDataTableSource<Ticket> {
  final BuildContext context; // Add the context parameter
  ClientSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  @override
  DataRow? getRow(int index) {
    final int srNo = startIndex + index + 1;
    final ticket = lastDetails!.rows[index];

    String statusText = '';
    if (ticket.status == "0") {
      statusText = "Unassigned";
    } else if (ticket.status == "1") {
      statusText = "Inactive";
    } else if (ticket.status == "2") {
      statusText = "In Progress";
    } else if (ticket.status == "3") {
      statusText = "Query Raised";
    } else if (ticket.status == "4") {
      statusText = "Completed";
    } else if (ticket.status == "5") {
      statusText = "Completed & Reviewed";
    } else if (ticket.status == "6") {
      statusText = "Invoice Raised";
    } else if (ticket.status == "7") {
      statusText = "Paid";
    }

    return DataRow(
      cells: [
        DataCell(Text(srNo.toString())),
        //DataCell(Text(client.client ?? "")),
        DataCell(Text(ticket.title ?? "")),
        DataCell(Text(ticket.startingDate ?? "")),
        DataCell(Text(ticket.description ?? "")),
        DataCell(Text(ticket.amount ?? "")),
        DataCell(Text(statusText)),
      ],
      // selected: selectedIds.contains(ticket.ticketId),
      // onSelectChanged: (value) {
      //   selectedRow(ticket.ticketId.toString(), value ?? false);
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
  Future<RemoteDataSourceDetails<Ticket>> getNextPage(
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
      method: '${Urls.clientViewTicketDetails}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      int count = dataModel.data.length ?? 0;
      dataCount = count;

      return RemoteDataSourceDetails(
        dataModel.count ?? 0,
        dynamicData
            .map<Ticket>(
              (item) => Ticket.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<Ticket>(
                  (item) => Ticket.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
