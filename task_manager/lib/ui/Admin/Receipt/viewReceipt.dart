import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/API/AdminDataModel/cardDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/receiptViewDataModel.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';

class ViewReceipt extends StatefulWidget {
  final String id;
  const ViewReceipt({required this.id, Key? key}) : super(key: key);

  @override
  State<ViewReceipt> createState() => _ViewReceiptState();
}

late double deviceWidth;
late double deviceHeight;

TextEditingController clientNameController = TextEditingController();
TextEditingController clientNumberController = TextEditingController();
TextEditingController clientEmailController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController statusController = TextEditingController();
TextEditingController referenceController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController _searchController = TextEditingController();

String id = "";

String? selectedClientId1;
int dataCount = 0;

class _ViewReceiptState extends State<ViewReceipt> {
  bool isObscurePassword = true;

  var _sortIndex = 0;
  var _sortAsc = true;
  var _customFooter = false;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  late TableSource _source;

  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });
  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  @override
  void initState() {
    super.initState();
    id = widget.id; // Store widget.userId in a local variable
    getReceiptDetails();
    _source = TableSource(context);
    _source.setNextView();
  }

  List<Pending> cardDataList = [];
  void getReceiptDetails() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.viewReceipt}',
      params: {
        'id': id.toString(),
      },
    );
    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      final taskData = ReceiptViewDataModel.fromJson(data);

      clientNameController.text = taskData.company!.name.toString();
      clientNumberController.text = taskData.company!.mobile.toString();
      clientEmailController.text = taskData.company!.email.toString();
      amountController.text = taskData.data!.amount.toString();
      dateController.text = taskData.data!.date.toString();
      statusController.text = taskData.data!.status.toString();
      referenceController.text = taskData.data!.referenceNumber.toString();
      descriptionController.text = taskData.data!.description.toString();
      setState(() {});
    }
  }
  // List<Pending> cardDataList = [];
  // void getTaskDetails() async {
  //   genModel? genmodel = await Urls.postApiCall(
  //     method: '${Urls.taskViewTaskDetails}',
  //     params: {
  //       'id': ticketId.toString(),
  //     },
  //   );
  //   if (genmodel != null && genmodel.status == true) {
  //     final data = genmodel.data;

  //     if (data != null && data is Map<String, dynamic>) {
  //       Pending cardData =
  //           Pending.fromJson(data['data']);
  //       cardDataList.add(cardData);
  //       descriptionController.text = cardDataList[0].description.toString();
  //       //clientNameController.text = cardDataList[0].clientName.toString();
  //       // clientNumberController.text = cardDataList[0].clientNumber.toString();
  //       // clientEmailController.text = cardDataList[0].clientEmail.toString();
  //       startingDateController.text = cardDataList[0].startingDate.toString();
  //       deadlineDateController.text = cardDataList[0].deadlineDate.toString();
  //       createdDateController.text = cardDataList[0].createdOn.toString();
  //       setState(() {});
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Receipt > View Receipt",
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
                  height: deviceHeight * 0.05,
                ),
                _header1(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _detail1(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _table1(),
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

  Row _header1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "View Receipt",
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

  Column _detail1() {
    return Column(
      children: [
        buildTextField1("Client Name", clientNameController.text, false),
        buildTextField1("Client Number", clientNumberController.text, false),
        buildTextField1("Client Email", clientEmailController.text, false),
        buildTextField1("Amount", amountController.text, false),
        buildTextField1("Date", dateController.text, false),
        buildTextField1("Status", statusController.text, false),
        buildTextField1("Reference Number", referenceController.text, false),
        buildTextField1("Description", descriptionController.text, false),
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Invoice List",
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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        readOnly: true,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextField1(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        readOnly: true,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            )),
      ),
    );
  }

  Column _table1() {
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
              label: const Text('Paid Amount'),
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

class TableSource extends AdvancedDataTableSource<ReceiptViewDataModel> {
  final BuildContext context;

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<ReceiptViewDataModel>? lastDetails;

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final List<ReceiptViewDataModel> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final ReceiptViewDataModel dataList = rows[index];
      final List<InvoicePaymentId>? files = dataList.invoicePaymentId;

      if (files != null && files.isNotEmpty) {
        final InvoicePaymentId file = files.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(file.invoiceId ?? '')),
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
                          onPressed: () {
                            // if (file.id != null) {
                            //  Get.to(ViewReceipt(id: file.id!) );
                            // }
                          },
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
  Future<RemoteDataSourceDetails<ReceiptViewDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
      'id': id.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.viewReceipt}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;
      int count = dataModel.data.length ?? 0;
      dataCount = count;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('invoice_payment_id')) {
        final dynamicList = dynamicData['invoice_payment_id'] as List<dynamic>?;
        final List<ReceiptViewDataModel> dataList = dynamicList
                ?.map<ReceiptViewDataModel>((item) => ReceiptViewDataModel(
                    invoicePaymentId: [InvoicePaymentId.fromJson(item)]))
                .toList() ??
            [];
        int count = dynamicList?.length ?? 0;
        lastDetails = RemoteDataSourceDetails<ReceiptViewDataModel>(
          //dataModel.count ?? 0,
          count,
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
