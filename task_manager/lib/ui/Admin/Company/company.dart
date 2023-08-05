// import 'package:flutter/material.dart';
// import '../DashBoard/sidebarAdmin.dart';
// class Company extends StatefulWidget {
//   const Company({super.key});
//   @override
//   State<Company> createState() => _CompanyState();
// }
// class _CompanyState extends State<Company> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Menu > Company",
//           style: Theme.of(context)
//               .textTheme
//               .bodySmall!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         foregroundColor: Colors.grey,
//         backgroundColor: Colors.transparent,
//       ),
//       drawer:  SideBarAdmin(),
//       extendBody: true,
//       body: _buildBody(),
//     );
//   }
//   Stack _buildBody() {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 _header(),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 _search(),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 _add(),
//                 const SizedBox(
//                   height: 0,
//                 ),
//                 _table(),
//                 const SizedBox(
//                   height: 100,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Row _header() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "Company List",
//           style: TextStyle(
//             color: Colors.blueGrey[900],
//             fontWeight: FontWeight.w700,
//             fontSize: 22,
//           ),
//         ),
//         SizedBox(
//           width: 30,
//         ),
//         const Spacer(),
//       ],
//     );
//   }
//   Row _search() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                 hintText: 'Search',
//                 suffixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: const BorderSide())),
//           ),
//         ),
//       ],
//     );
//   }
//   Row _add() {
//     return Row(
//       children: [
//         OutlinedButton(
//           onPressed: () {},
//           child: Text(
//             "Add New",
//             style: TextStyle(
//               fontSize: 12,
//               letterSpacing: 0,
//               color: Colors.blue,
//             ),
//           ),
//           style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         OutlinedButton(
//           onPressed: () {},
//           child: Text(
//             "Manage Group",
//             style: TextStyle(
//               fontSize: 12,
//               letterSpacing: 0,
//               color: Colors.blue,
//             ),
//           ),
//           style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         OutlinedButton(
//           onPressed: () {},
//           child: Text(
//             "Manage Comments",
//             style: TextStyle(
//               fontSize: 12,
//               letterSpacing: 0,
//               color: Colors.blue,
//             ),
//           ),
//           style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Column _table() {
//     return Column(
//       children: <Widget>[
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               DataTable(
//                 columns: const [
//                   DataColumn(label: Text('Sr.No.'), numeric: true),
//                   DataColumn(label: Text(' Client Name')),
//                   DataColumn(label: Text('Comapany Name')),
//                   DataColumn(label: Text('Property Name')),
//                   DataColumn(label: Text('Mobile')),
//                   DataColumn(label: Text('Email')),
//                   DataColumn(label: Text('Edit')),
//                   DataColumn(label: Text('View')),
//                   DataColumn(label: Text('Delete')),
//                 ],
//                 rows: const [
//                   DataRow(cells: [
//                     DataCell(Text('1')),
//                     DataCell(Text('Roy')),
//                     DataCell(Text('ABC')),
//                     DataCell(Text('New')),
//                     DataCell(Text('1234567890')),
//                     DataCell(Text('try@gmail')),
//                     DataCell(
//                         IconButton(onPressed: null, icon: Icon(Icons.edit))),
//                     DataCell(IconButton(
//                         onPressed: null, icon: Icon(Icons.view_list))),
//                     DataCell(
//                         IconButton(onPressed: null, icon: Icon(Icons.delete))),
//                   ]),
//                   DataRow(cells: [
//                     DataCell(Text('2')),
//                     DataCell(Text('Roy')),
//                     DataCell(Text('ABC')),
//                     DataCell(Text('New')),
//                     DataCell(Text('1234567890')),
//                     DataCell(Text('try@gmail')),
//                     DataCell(
//                         IconButton(onPressed: null, icon: Icon(Icons.edit))),
//                     DataCell(IconButton(
//                         onPressed: null, icon: Icon(Icons.view_list))),
//                     DataCell(
//                         IconButton(onPressed: null, icon: Icon(Icons.delete))),
//                   ]),
//                   DataRow(cells: [
//                     DataCell(Text('3')),
//                     DataCell(Text('Roy')),
//                     DataCell(Text('ABC')),
//                     DataCell(Text('New')),
//                     DataCell(Text('1234567890')),
//                     DataCell(Text('try@gmail')),
//                     DataCell(
//                         IconButton(onPressed: null, icon: Icon(Icons.edit))),
//                     DataCell(IconButton(
//                         onPressed: null, icon: Icon(Icons.view_list))),
//                     DataCell(
//                         IconButton(onPressed: null, icon: Icon(Icons.delete))),
//                   ]),
//                 ],
//                 dataRowHeight: 32.0,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/AdminDataModel/companyDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Admin/Company/addCompany.dart';
import 'package:task_manager/ui/Admin/Company/companyGroup.dart.dart';
import 'package:task_manager/ui/Admin/Company/companyManageComments.dart';
import 'package:task_manager/ui/Admin/Company/editCompany.dart';
import 'package:task_manager/ui/Admin/Company/viewCompany.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

TextEditingController nameController =
    TextEditingController(); // Define the TextEditingController
int dataCount = 0;
class _CompanyState extends State<Company> {
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
          "Menu > Company",
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
          "Company List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Row _add() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            Get.to(AddCompany());
          },
          child: Text(
            "Add New",
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
        SizedBox(
          width: 30,
        ),
        //const Spacer(),
        OutlinedButton(
          onPressed: () {
            Get.to(CompanyGroup());
          },
          child: Text(
            "Manage Group",
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
        SizedBox(
          width: 30,
        ),
        OutlinedButton(
          onPressed: () {
            Get.to(CompanyManageComments());
          },
          child: Text(
            "Manage Comments",
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
              label: const Text('Client Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Company Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Property Name'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Mobile'),
              onSort: setSort,
            ),
            DataColumn(
              label: const Text('Email'),
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

class TableSource extends AdvancedDataTableSource<CompanyDataModel> {
  final BuildContext context; // Add the context parameter

  TableSource(this.context);

  List<String> selectedIds = [];
  String lastSearchTerm = '';

  int startIndex = 0; // Add the startIndex variable

  void deleteUser(String? id) async {
    if (id != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.deleteCompany}',
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
    final CompanyDataModel dataList = lastDetails!.rows[index];

    return DataRow(
      cells: [
        DataCell(Text(srNo)),
        DataCell(Text(dataList.cname ?? '')),
        DataCell(Text(dataList.name ?? '')),
        DataCell(Text(dataList.proprietorName ?? '')),
        DataCell(Text(dataList.mobile ?? '')),
        DataCell(Text(dataList.email ?? '')),
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
                        if (dataList.id != null) {
                          Get.to(EditCompany(userId: dataList.id!));
                        }
                      },
                      child: Icon(Icons.edit),
                      constraints: BoxConstraints.tight(Size(24, 24)),
                      shape: CircleBorder(),
                    ),
                     RawMaterialButton(
                      onPressed: () {
                        if (dataList.id != null) {
                          Get.to(ViewCompany(id: dataList.id!));
                        }
                      },
                      child: Icon(Icons.remove_red_eye),
                      constraints: BoxConstraints.tight(Size(24, 24)),
                      shape: CircleBorder(),
                    ),
                     RawMaterialButton(
                      onPressed: () {
                        if (dataList.id != null) {
                          Get.defaultDialog(
                            title: 'Delete',
                            middleText: 'Are you sure you want to delete?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            onConfirm: () {
                              Get.back();
                              deleteUser(dataList.id);
                            },
                            onCancel: () {
                             
                            },
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
  Future<RemoteDataSourceDetails<CompanyDataModel>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    startIndex = pageRequest.offset;
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      if (lastSearchTerm.isNotEmpty) 'search': lastSearchTerm,
      'limit': pageRequest.pageSize.toString()
    };

    genModel? dataModel = await Urls.postApiCall(
      method: '${Urls.company}',
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
            .map<CompanyDataModel>(
              (item) => CompanyDataModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? dynamicData
                .map<CompanyDataModel>(
                  (item) =>
                      CompanyDataModel.fromJson(item as Map<String, dynamic>),
                )
                .length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
