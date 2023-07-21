import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/clientInvoiceDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/logModel.dart';
import 'package:task_manager/ui/pages/Users/editClientForm.dart';
import '../sidebar/sidebarAdmin.dart';

class ClientInvoiceDetails extends StatefulWidget {
  final String userId;
  const ClientInvoiceDetails({required this.userId, Key? key})
      : super(key: key);
  @override
  State<ClientInvoiceDetails> createState() => _ClientInvoiceDetailsState();
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

class _ClientInvoiceDetailsState extends State<ClientInvoiceDetails> {
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
          "Menu > Users > Client > viewClient > Invoice",
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
          "Client Invoice Details",
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
              label: const Text('Client Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Amount'),
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
          print("client.id :- ${client.id}");
          deleteUser(client.id!);
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

class ClientSource extends AdvancedDataTableSource<Invoice> {
  final BuildContext context; // Add the context parameter
  ClientSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  @override
  DataRow? getRow(int index) {
    final int srNo = startIndex + index + 1;
    final invoice = lastDetails!.rows[index];

    //print("parsedDate $parsedDate");

    return DataRow(
  cells: [
    DataCell(Text(srNo.toString())),
    DataCell(Text(invoice.invoiceNo ?? "")),
    DataCell(Text(invoice.company ?? "")),
    DataCell(Text(invoice.total.toString())),
    DataCell(Text(invoice.otherDetails ?? "")),
    DataCell(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10), // Adjust the horizontal margin as per your requirement
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the start of the column
          children: [
            if (invoice.paymentId == "1")
              RawMaterialButton(
                onPressed: () {
                  // Handle button pressed
                },
                child: Icon(Icons.remove_red_eye),
                constraints: BoxConstraints.tight(Size(24, 24)), // Adjust the size as per your requirement
                shape: CircleBorder(),
              ),
            if (invoice.paymentId == "0" || (invoice.paymentId == "0" && invoice.customInvoice == "1"))
              RawMaterialButton(
                onPressed: () {
                  // Handle button pressed
                },
                child: Icon(Icons.remove_red_eye),
                constraints: BoxConstraints.tight(Size(24, 24)), // Adjust the size as per your requirement
                shape: CircleBorder(),
              ),
            if (invoice.paymentId == "0" || (invoice.paymentId == "0" && invoice.customInvoice == "1"))
              RawMaterialButton(
                onPressed: () {
                  // Handle button pressed
                },
                child: Icon(Icons.message),
                constraints: BoxConstraints.tight(Size(24, 24)), // Adjust the size as per your requirement
                shape: CircleBorder(),
              ),
            if (invoice.paymentId == "0" && invoice.customInvoice == "1")
              RawMaterialButton(
                onPressed: () {
                  // Handle button pressed
                },
                child: Icon(Icons.edit),
                constraints: BoxConstraints.tight(Size(24, 24)), // Adjust the size as per your requirement
                shape: CircleBorder(),
              ),
          ],
        ),
      ),
    ),
  ],
  // selected: selectedIds.contains(invoice.id),
  // onSelectChanged: (value) {
  //   selectedRow(invoice.id.toString(), value ?? false);
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
  Future<RemoteDataSourceDetails<Invoice>> getNextPage(
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
      method: '${Urls.clientViewInvoiceDetails}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      print("Data :- $dynamicData");

      return RemoteDataSourceDetails<Invoice>(
        dataModel.count ?? 0,
        dynamicData
            .map<Invoice>(
              (item) => Invoice.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<Invoice>(
                  (item) => Invoice.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}

/*
if($r->status==0){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'> <span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Task/Edit_Task/".$r->ticket_id." title='Edit Data' class='btn btn-success btn-sm'> <span class='glyphicon glyphicon-pencil'/></a>
    <a href=". base_url()."Task/Delete_Task/".$r->ticket_id." title='Delete Data' class='btn btn-danger btn-sm'> <span class='glyphicon glyphicon-trash'/></a>";
    if($r->deadline_date < $today){
        //$status="Overdue - ".number_format($r->task_complete_percentage,0)."%";
        $action .="<input type='hidden' value='overdue'>";
    }
    $status="Un-assigned";
    // $status="Open";
}elseif($r->status==1){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Task/Edit_Task/".$r->ticket_id." title='Edit Data' class='btn btn-success btn-sm'> <span class='glyphicon glyphicon-pencil'/></a>";
    if($r->deadline_date < $today){
        //$status="Overdue - ".number_format($r->task_complete_percentage,0)."%";
        $action .="<input type='hidden' value='overdue'>";
    }
    // $status="Completed - ".number_format($r->task_complete_percentage,0)."%";
    $status="Open - ".number_format($r->task_complete_percentage,0)."%";
    // $status="Assigned - ".number_format($r->task_complete_percentage,0)."%";
}elseif($r->status==2){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Task/Edit_Task/".$r->ticket_id." title='Edit Data' class='btn btn-success btn-sm'> <span class='glyphicon glyphicon-pencil'/></a>";
    if($r->deadline_date < $today){
        $action .="<input type='hidden' value='overdue'>";
        //$status="Overdue - ".number_format($r->task_complete_percentage,0)."%";
    }
    $status="In-progress - ".number_format($r->task_complete_percentage,0)."%";
}elseif($r->status==3){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Task/Edit_Task/".$r->ticket_id." title='Edit Data' class='btn btn-success btn-sm'> <span class='glyphicon glyphicon-pencil'/></a>";
    $status="Query Raised";
}elseif($r->status==4){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Task/Edit_Task/".$r->ticket_id." title='Edit Data' class='btn btn-success btn-sm'> <span class='glyphicon glyphicon-pencil'/></a>
    <a href=". base_url()."Task/reviewtask/".$r->ticket_id." title='Task Reviewed' class='btn btn-primary btn-sm'> <span class='glyphicon glyphicon-ok'/></a>";
    // $status="Completed";
    $status="Closed";
}elseif($r->status==5){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Task/Edit_Task/".$r->ticket_id." title='Edit Data' class='btn btn-success btn-sm'> <span class='glyphicon glyphicon-pencil'/></a>
    <a href=". base_url()."Task/invoice_raised/".$r->ticket_id." title='Raise Invoice' class='btn btn-primary btn-sm'> <span class='glyphicon glyphicon-list-alt'/></a>";
    $status="Completed & Reviewed";
}elseif($r->status==6){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>
    <a href=". base_url()."Payment/task_payment/".$r->ticket_id." title='Task Payment' class='btn btn-primary btn-sm'> <span class='glyphicon glyphicon-paste'/></a>";
    $status="Invoice-Raised";
}elseif($r->status==7){
    $action="<a href=".base_url()."Task/View_task/".$r->ticket_id." title='View' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-eye-open'/></a>";
    $status="Paid";
}else{
    $action = " ";
    $status = " ";
}
*/