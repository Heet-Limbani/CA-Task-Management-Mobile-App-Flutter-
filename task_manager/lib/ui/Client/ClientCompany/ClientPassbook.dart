import 'package:advanced_datatable/datatable.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/ClientDataModel/clientPassbookDataModel.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';

class ClientPassbook extends StatefulWidget {
  final String ticketId;
  const ClientPassbook({required this.ticketId, Key? key}) : super(key: key);

  @override
  State<ClientPassbook> createState() => _ClientPassbookState();
}

late double deviceWidth;
late double deviceHeight;

// Declare _source here
bool isObscurePassword = true;
String ticketId = "";
int dataCount = 0;
int dataCount2 = 0;
String? selectedClientId1;

class _ClientPassbookState extends State<ClientPassbook> {
  TextEditingController _searchController = TextEditingController();
  late TableSource _source;
  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

  TextEditingController _searchController2 = TextEditingController();
  late TableSource2 _source2;
  var _sortIndex2 = 0;
  var _sortAsc2 = true;
  var _customFooter2 = false;
  var _rowsPerPage2 = AdvancedPaginatedDataTable.defaultRowsPerPage;
  void setSort2(int i, bool asc) => setState(() {
        _sortIndex2 = i;
        _sortAsc2 = asc;
      });

  @override
  void initState() {
    super.initState();
    ticketId = widget.ticketId; // Store widget.userId in a local variable
    // getUser();
    _source = TableSource(context);
    _source.setNextView();

    _source2 = TableSource2(context);
    _source2.setNextView();
  }

  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  void refreshTable2() {
    setState(() {
      _source2.startIndex = 0;
      _source2.setNextView();
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Company > Passbook",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarClient(),
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
                  height: deviceHeight * 0.02,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _table(),
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
                _header2(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _table2(),
                SizedBox(
                  height: deviceHeight * 0.5,
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
          "Invoice",
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
              label: const Text('Invoice No.'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Amount'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Details'),
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

  Row _header2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Paid",
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

  Column _table2() {
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
                  controller: _searchController2,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                  ),
                  onSubmitted: (vlaue) {
                    _source2.filterServerSide(_searchController2.text);
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _searchController2.text = '';
                });
                _source2.filterServerSide(_searchController2.text);
                ;
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () =>
                  _source2.filterServerSide(_searchController2.text),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: refreshTable2,
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.03,
        ),
        AdvancedPaginatedDataTable(
          loadingWidget: () => UniversalShimmer(
            itemCount: dataCount2,
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
          ),
          addEmptyRows: false,
          source: _source2,
          showHorizontalScrollbarAlways: true,
          sortAscending: _sortAsc2,
          sortColumnIndex: _sortIndex2,
          showFirstLastButtons: true,
          rowsPerPage: _rowsPerPage2,
          availableRowsPerPage: const [10, 20, 50, 100, 200],
          onRowsPerPageChanged: (newRowsPerPage) {
            if (newRowsPerPage != null) {
              setState(() {
                _rowsPerPage2 = newRowsPerPage;
              });
            }
          },
          columns: [
            DataColumn(
              label: const Text('Sr. No.'),
              numeric: true,
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Amount'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Download'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Reference'),
              onSort: setSort2,
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
          customTableFooter: _customFooter2
              ? (source, offset) {
                  const maxPagesToShow = 6;
                  const maxPagesBeforeCurrent = 3;
                  final lastRequestDetails = source.lastDetails!;
                  final rowsForPager = lastRequestDetails.filteredRows ??
                      lastRequestDetails.totalRows;
                  final totalPages = rowsForPager ~/ _rowsPerPage2;
                  final currentPage = (offset ~/ _rowsPerPage2) + 1;
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
                                      startIndex: (e - 1) * _rowsPerPage2,
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

class TableSource extends AdvancedDataTableSource<ClientPassbookDataModel> {
  final BuildContext context;

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<ClientPassbookDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<ClientPassbookDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final ClientPassbookDataModel dataList = rows[index];
      final List<InvoiceData>? files = dataList.invoiceData;

      if (files != null && files.isNotEmpty) {
        final InvoiceData invoiceData = files.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text("File Location - ${invoiceData.invoiceNo ?? ''}")),
            DataCell(Text(invoiceData.total ?? '')),
            DataCell(Text(invoiceData.dateOf ?? '')),
            DataCell(Text(invoiceData.otherDetails ?? '')),
            DataCell(
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RawMaterialButton(
                          onPressed: () {},
                          child: Icon(Icons.remove_red_eye_outlined),
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
        );
      }
    }
    return null;
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<ClientPassbookDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.clientPassbook}/${ticketId}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      int fileCount = 0;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('invoice_data')) {
        final dynamicList = dynamicData['invoice_data'] as List<dynamic>?;
        fileCount = dynamicList?.length ?? 0;
        dataCount = fileCount;
        final List<ClientPassbookDataModel> dataList = dynamicList
                ?.map<ClientPassbookDataModel>((item) =>
                    ClientPassbookDataModel(
                        invoiceData: [InvoiceData.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<ClientPassbookDataModel>(
          //dataModel.count ?? 0,
          fileCount,
          dataList,
          filteredRows: lastSearchTerm.isNotEmpty ? dataList.length : null,
        );
      } else {
        throw Exception('Invalid dynamicData format');
      }

      return lastDetails!;
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}

///////////
class TableSource2 extends AdvancedDataTableSource<ClientPassbookDataModel> {
  final BuildContext context;

  TableSource2(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<ClientPassbookDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<ClientPassbookDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final ClientPassbookDataModel dataList = rows[index];
      final List<PaymentDate>? paymentDates = dataList.paymentDate;

      if (paymentDates != null && paymentDates.isNotEmpty) {
        final PaymentDate file = paymentDates.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(file.date ?? '')),
            DataCell(Text(file.amount ?? '')),
            DataCell(
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RawMaterialButton(
                          onPressed: () {},
                          child: Icon(Icons.edit),
                          constraints: BoxConstraints.tight(Size(24, 24)),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            DataCell(Text(file.referenceNumber ?? '')),
          ],
        );
      }
    }
    return null;
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<ClientPassbookDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.clientPassbook}/${ticketId}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      int virtualFileCount = 0;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('payment_date')) {
        final dynamicList = dynamicData['payment_date'] as List<dynamic>?;
        virtualFileCount = dynamicList?.length ?? 0;
        dataCount2 = virtualFileCount;
        final List<ClientPassbookDataModel> dataList = dynamicList
                ?.map<ClientPassbookDataModel>((item) =>
                    ClientPassbookDataModel(
                        paymentDate: [PaymentDate.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<ClientPassbookDataModel>(
          //dataModel.count ?? 0,
          virtualFileCount,
          dataList,
          filteredRows: lastSearchTerm.isNotEmpty ? dataList.length : null,
        );
      } else {
        throw Exception('Invalid dynamicData format');
      }

      return lastDetails!;
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
