import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/viewDispatchFileDataModel.dart';
import 'package:task_manager/ui/pages/sidebar/sidebarAdmin.dart';

class ViewDispatchFile extends StatefulWidget {
  const ViewDispatchFile({super.key});

  @override
  State<ViewDispatchFile> createState() => _ViewDispatchFileState();
}

TextEditingController nameController =
    TextEditingController(); // Define the TextEditingController

TextEditingController nameController1 = TextEditingController();

class _ViewDispatchFileState extends State<ViewDispatchFile> {
  late TableSource _source; // Declare _source here

  String? stringResponse;
  late double deviceWidth;
  late double deviceHeight;
  TextEditingController searchLogController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;

  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

  @override
  void initState() {
    super.initState();
    _source = TableSource(context);
    _source.setNextView();
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
          "Menu > File Manager > View Dispatch File",
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
                buildStartDate(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                buildEndDate(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _add1(),
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
          "Dispatch File",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Widget buildStartDate() => TextField(
        onTap: () async {
          DateTime? datePicked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
          );
          if (datePicked != null) {
            final formattedDate = DateFormat('yyyy/MM/dd').format(datePicked);
            setState(() {
              startDateController.text = formattedDate;
            });
          }
        },
        controller: startDateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'From',
          //hintText: 'Enter Starting Date',
          suffixIcon: startDateController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => startDateController.clear(),
                ),
          prefixIcon: Icon(Icons.calendar_month),
          border: OutlineInputBorder(),
        ),
      );
  Widget buildEndDate() => TextField(
        onTap: () async {
          DateTime? datePicked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
          );
          if (datePicked != null) {
            final formattedDate = DateFormat('yyyy/MM/dd').format(datePicked);
            setState(() {
              endDateController.text = formattedDate;
            });
          }
        },
        controller: endDateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'To',
          //hintText: 'Enter DeadLine Date',
          suffixIcon: endDateController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => endDateController.clear(),
                ),
          prefixIcon: Icon(Icons.calendar_month),
          border: OutlineInputBorder(),
        ),
      );
  Row _add1() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            refreshTable();
          },
          child: Text(
            "Submit",
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0,
              color: Colors.white,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue,
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
              label: const Text('File Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Client Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Reciver Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Note'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Location'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Old Location No.'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Inward Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Outward Date'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Outward By'),
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

class TableSource extends AdvancedDataTableSource<ViewDispatchFileDataModel> {
  final BuildContext context;

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<ViewDispatchFileDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<ViewDispatchFileDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final ViewDispatchFileDataModel dataList = rows[index];
      final List<File>? files = dataList.file;

      if (files != null && files.isNotEmpty) {
        final File file = files.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(file.name ?? '')),
            DataCell(Text(file.cname ?? '')),
            DataCell(Text(file.receiverName ?? '')),
            DataCell(Text(file.note ?? '')),
            DataCell(Text(file.location ?? '')),
            DataCell(Text(file.locationNum ?? '')),
            DataCell(Text(file.inwardTime ?? '')),
            DataCell(Text(file.outwardTime ?? '')),
            DataCell(Text(file.outBy ?? '')),
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
  Future<RemoteDataSourceDetails<ViewDispatchFileDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
      'fromdt': '2020-07-18',
      'todt': '2023-07-18',
      'submit': 'submit',
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.viewDispatchFile}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('file')) {
        final dynamicList = dynamicData['file'] as List<dynamic>?;
        final List<ViewDispatchFileDataModel> dataList = dynamicList
                ?.map<ViewDispatchFileDataModel>((item) =>
                    ViewDispatchFileDataModel(file: [File.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<ViewDispatchFileDataModel>(
          dataModel.count ?? 0,
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
