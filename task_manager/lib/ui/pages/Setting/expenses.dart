import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/expensesDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/ui/pages/Setting/addExpenses.dart';
import 'package:task_manager/ui/pages/Setting/editExpenses.dart';
import '../DashBoard/sidebarAdmin.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  late double deviceWidth;
  late double deviceHeight;

  @override
  void initState() {
    super.initState();

    expenses();
  }

  void refreshTable() {
    expenses(); // Refresh data
  }

  List<Expense> expensesList = [];
  void expenses() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.expences}',
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        expensesList = data.map((item) => Expense.fromJson(item)).toList();
        setState(() {});
      }
    }
  }

  void deleteExpense(String? expenseId) async {
    if (expenseId != null) {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.deleteExpences}',
        params: {'id': expenseId},
      );

      if (genmodel != null && genmodel.status == true) {
        Fluttertoast.showToast(
          msg: "${genmodel.message.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Expenses",
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
                  height: deviceHeight * 0.02,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.01,
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

  Row _header() {
    return Row(
      children: [
        Text(
          "Expense List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.02,
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: refreshTable,
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
            Get.to(AddExpenses());
          },
          child: Text(
            "Add Expenses List",
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
        const Spacer(),
      ],
    );
  }

  Column _table() {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Sr.No.'), numeric: true),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: expensesList.map((Expense expense) {
                  final index = expensesList.indexOf(expense);
                  final srNo = (index + 1).toString();

                  return DataRow(cells: [
                    DataCell(Text(srNo)),
                    DataCell(Text(expense.name ?? "")),
                    DataCell(Text(
                        expense.type == "1" ? 'Deductable' : 'Chargeable')),
                    DataCell(IconButton(
                        onPressed: () {
                          if (expense.id != null) {
                            Get.to(EditExpenses(userId: expense.id!));
                          }
                        },
                        icon: Icon(Icons.edit))),
                    DataCell(IconButton(
                        onPressed: () {
                          if (expense.id != null) {
                            deleteExpense(expense.id!);
                            expenses();
                          }
                        },
                        icon: Icon(Icons.delete))),
                  ]);
                }).toList(),
                dataRowMinHeight: 32.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}
