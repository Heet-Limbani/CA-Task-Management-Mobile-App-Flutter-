import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/AdminDataModel/companyFileDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Admin/Company/filesDetailsEdit.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';

class CompanyFile extends StatefulWidget {
  final String id;
  const CompanyFile({required this.id, Key? key}) : super(key: key);

  @override
  State<CompanyFile> createState() => _CompanyFileState();
}

TextEditingController nameController =
    TextEditingController(); // Define the TextEditingController
TextEditingController fileController = TextEditingController();
File? selectedFile;

String id = "";
int dataCount = 0;

class _CompanyFileState extends State<CompanyFile> {
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
    id = widget.id;
    _source = TableSource(context); // Initialize _source here
  }

  void refreshTable() {
    setState(() {
      _source.startIndex = 0;
      _source.setNextView();
    });
  }

  void uploadFile(File selectedFile) async {
    try {
      Map<String, String> headers = await Urls.getXTokenHeader();
      String csrfToken = headers['Xtoken'] ?? ''; // Get the Xtoken value

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Urls.companyFileUpload}/${id}'), // Replace with your API endpoint URL
      );

      request.headers['Xtoken'] = csrfToken;
      request.files.add(
        http.MultipartFile(
          'userImage',
          selectedFile.readAsBytes().asStream(),
          selectedFile.lengthSync(),
          filename:
              selectedFile.path.split('/').last, // Use the selected file's name
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successful response
        var responseBody = await response.stream.bytesToString();
        var genmodel = genModel.fromJson(json.decode(responseBody));
        Fluttertoast.showToast(
          msg: genmodel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        if (genmodel.status == true) {
          setState(() {});
        }
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Company > View > File Details",
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
                _detail(),
                // _add(),
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
          "File Details",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Column _detail() {
    return Column(
      children: [
        buildFileInput(
          "Select File",
          fileController,
          (file) {
            setState(() {
              selectedFile = file;
            });
          },
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
              label: const Text('Date'),
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

  Widget buildFileInput(
    String labelText,
    TextEditingController controller,
    void Function(File?)? onPressed,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path!);
                controller.text = file.path;
                onPressed?.call(file);
              }
            },
            icon: Icon(Icons.attach_file),
          ),
          IconButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                uploadFile(selectedFile!);
                controller.clear();
              } else {
                Fluttertoast.showToast(
                  msg: "Please Select File",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  // backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            icon: Icon(Icons.upload),
          ),
          IconButton(
            onPressed: () {
              controller.clear();
              onPressed?.call(null);
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class TableSource extends AdvancedDataTableSource<CompanyFileDataModel> {
  final BuildContext context; // Add the context parameter

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable
  void deleteUser(String? id1) async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.companyFileDelete}',
      params: {'id': id1, 'ticket_id': id, 'task': 'view_company_log'},
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

  @override
  DataRow? getRow(int index) {
    final srNo = (startIndex + index + 1).toString();
    final CompanyFileDataModel dataList = lastDetails!.rows[index];

    return DataRow(
      cells: [
        DataCell(Text(srNo)),
        DataCell(Text(dataList.name ?? '')),
        DataCell(Text(dataList.inwardTime ?? '')),
        DataCell(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (dataList.downloadable == "0")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(fileDetailsEdit(
                              ticketId: dataList.id!,
                              sc: dataList.downloadable!));
                        },
                        child: Icon(Icons.edit),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Delete",
                            content: Text("Are you sure you want to delete?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  deleteUser(dataList.id);
                                  Get.back();
                                },
                                child: Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Cencel"),
                              ),
                            ],
                          );
                        },
                        child: Icon(Icons.delete),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                if (dataList.downloadable == "1")
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          // Handle button pressed
                        },
                        child: Icon(Icons.download),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.to(fileDetailsEdit(
                              ticketId: dataList.id!,
                              sc: dataList.downloadable!));
                        },
                        child: Icon(Icons.edit),
                        constraints: BoxConstraints.tight(Size(24, 24)),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Delete",
                            content: Text("Are you sure you want to delete?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  deleteUser(dataList.id);
                                  Get.back();
                                },
                                child: Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Cencel"),
                              ),
                            ],
                          );
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
  Future<RemoteDataSourceDetails<CompanyFileDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'id': id,
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString()
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.companyFile}',
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
            .map<CompanyFileDataModel>(
              (item) =>
                  CompanyFileDataModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<CompanyFileDataModel>(
                  (item) => CompanyFileDataModel.fromJson(
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
