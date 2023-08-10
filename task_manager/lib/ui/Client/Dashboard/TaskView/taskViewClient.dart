import 'dart:convert';
import 'dart:io';
import 'package:advanced_datatable/datatable.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/viewTasksDataModel.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/ui/Client/Dashboard/TaskView/fileDetailsEdit.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';

class ViewTasksTaskClient extends StatefulWidget {
  final String ticketId;
  const ViewTasksTaskClient({required this.ticketId, Key? key})
      : super(key: key);

  @override
  State<ViewTasksTaskClient> createState() => _ViewTasksTaskClientState();
}

late double deviceWidth;
late double deviceHeight;

// Declare _source here

TextEditingController descriptionController = TextEditingController();
TextEditingController clientNameController = TextEditingController();
TextEditingController clientNumberController = TextEditingController();
TextEditingController clientEmailController = TextEditingController();
TextEditingController startingDateController = TextEditingController();
TextEditingController deadlineDateController = TextEditingController();
TextEditingController createdDateController = TextEditingController();
bool isObscurePassword = true;
String ticketId = "";
int dataCount = 0;
String? selectedClientId1;
int dataCount2 = 0;

class _ViewTasksTaskClientState extends State<ViewTasksTaskClient> {
  TextEditingController fileController = TextEditingController();
  File? selectedFile;
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
    getTaskDetails();
    _source2 = TableSource2(context);
    _source2.setNextView();
  }

  void refreshTable2() {
    setState(() {
      _source2.startIndex = 0;
      _source2.setNextView();
    });
  }

  List<Subtask> subtaskList = [];

  void getTaskDetails() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.taskViewTaskDetails}',
      params: {
        'id': ticketId.toString(),
      },
    );
    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      final taskData = TasksData.fromJson(data);

      descriptionController.text = taskData.data!.description.toString();
      startingDateController.text = taskData.data!.startingDate.toString();
      deadlineDateController.text = taskData.data!.deadlineDate.toString();
      createdDateController.text = taskData.data!.createdOn.toString();
      clientNameController.text = taskData.company!.name.toString();
      clientNumberController.text = taskData.company!.mobile.toString();
      clientEmailController.text = taskData.company!.email.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Tasks",
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

  void uploadFile(File selectedFile) async {
    try {
      Map<String, String> headers = await Urls.getXTokenHeader();
      String csrfToken = headers['Xtoken'] ?? ''; // Get the Xtoken value

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Urls.fileUpload}/${ticketId}'), // Replace with your API endpoint URL
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
                _detail2(),
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
                _detail(),
                SizedBox(
                  height: deviceHeight * 0.08,
                ),
                _header2(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _table2(),
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
                _header3(),
                SizedBox(
                  height: deviceHeight * 0.2,
                ),
              ],
            ),
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

  Row _header2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Uploaded Files",
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
              label: const Text('ID'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Name'),
              onSort: setSort2,
            ),
            DataColumn(
              label: const Text('Action'),
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

  Column _detail2() {
    return Column(
      children: [
        buildTextField("Description", descriptionController.text, false),
      ],
    );
  }

  Row _header1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Main Task Details",
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
        buildTextField1("Starting Date", startingDateController.text, false),
        buildTextField1("Deadline Date", deadlineDateController.text, false),
        buildTextField1("Created Date", createdDateController.text, false),
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Upload Files",
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

  Row _header3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Comments",
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
          ),
        ),
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
}

class TableSource2 extends AdvancedDataTableSource<TasksData> {
  final BuildContext context;

  TableSource2(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';
  int startIndex = 0;
  RemoteDataSourceDetails<TasksData>? lastDetails;

  void delete(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.deleteFileTask}',
        params: {
          'id': id,
          'ticket_id': ticketId,
          'task': 'View_task',
        },
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
    final List<TasksData> rows = lastDetails!.rows;
    if (index >= 0 && index < rows.length) {
      final TasksData dataList = rows[index];
      final List<VirtualFile>? virtualFiles = dataList.virtualFile;

      if (virtualFiles != null && virtualFiles.isNotEmpty) {
        final VirtualFile file = virtualFiles.first;
        return DataRow(
          cells: [
            DataCell(Text(srNo)),
            DataCell(Text(file.id ?? '')),
            DataCell(Text(file.name ?? '')),
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
                            Get.to(fileDetailsEdit(
                                userId: file.id!,
                                ticketId: ticketId,
                                sc: file.showToClient!));
                          },
                          child: Icon(Icons.edit),
                          constraints: BoxConstraints.tight(Size(24, 24)),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            delete(file.id);
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
  Future<RemoteDataSourceDetails<TasksData>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString(),
      'id': ticketId.toString(),
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.taskViewTaskDetails}',
      params: queryParameter,
    );

    if (dataModel != null && dataModel.status == true) {
      final dynamicData = dataModel.data;

      int virtualFileCount = 0;

      if (dynamicData is Map<String, dynamic> &&
          dynamicData.containsKey('virtual_file')) {
        final dynamicList = dynamicData['virtual_file'] as List<dynamic>?;
        virtualFileCount = dynamicList?.length ?? 0;
        dataCount2 = virtualFileCount;
        final List<TasksData> dataList = dynamicList
                ?.map<TasksData>((item) =>
                    TasksData(virtualFile: [VirtualFile.fromJson(item)]))
                .toList() ??
            [];

        lastDetails = RemoteDataSourceDetails<TasksData>(
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
