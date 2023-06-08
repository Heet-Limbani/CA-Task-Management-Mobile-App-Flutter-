// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({super.key});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

String? stringResponse;
Map? mapResponse;
Map? dataResponse;
final GlobalKey<FormState> _addEmployeeformKey = GlobalKey<FormState>();
TextEditingController userName = TextEditingController();
late double deviceWidth;
late double deviceHeight;

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Employee > Add Employee",
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
                height: deviceHeight * 2,
              ),

              _header(),
              SizedBox(
                height: deviceHeight * 2,
              ),
              _addEmployeeForm(),
              // _search(),
              // const SizedBox(
              //   height: 30,
              // ),
              // _add(),
              // const SizedBox(
              //   height: 10,
              // ),
              // _table(),
              //  const SizedBox(
              //   height: 50,
              // ),
              // _test(),
              // const SizedBox(
              //   height: 50,
              // ),
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
        "Add EmployeeForm",
        style: TextStyle(
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    ],
  );
}

Form _addEmployeeForm() {
  return Form(
    key: _addEmployeeformKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          controller: userName,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: 'User Name',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: OutlineInputBorder(),
          ),
        )
      ],
    ),
  );
}

// Table heading

Row _search() {
  return Row(
    children: [
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              hintText: 'Search',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide())),
        ),
      ),
    ],
  );
}

Row _add() {
  return Row(
    children: [
      OutlinedButton(
        onPressed: () {},
        child: Text(
          "Add New AddEmployeeForm",
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

Row _test() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 182, 212, 237),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: dataResponse == null
              ? Text("data Is Loading")
              : Text(
                  dataResponse!["first_name"].toString(),
                ),
        ),
      ),
    ],
  );
}

// Table contents
Column _table() {
  return Column(
    children: <Widget>[
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            DataTable(
              columns: const [
                DataColumn(label: Text('Sr. No.'), numeric: true),
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('First Name')),
                DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('Email ID')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Edit')),
                DataColumn(label: Text('Delete')),
                DataColumn(label: Text('Reset Password')),
                DataColumn(label: Text('Permission')),
                DataColumn(label: Text('Chat')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('John')),
                  DataCell(Text('John ')),
                  DataCell(Text('Cena')),
                  DataCell(Text('john@gmail.com')),
                  DataCell(Text('Active')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.password))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.check))),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Jane')),
                  DataCell(Text('Jane')),
                  DataCell(Text('Doe')),
                  DataCell(Text('jane@gmail.com')),
                  DataCell(Text('Active')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.password))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.check))),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('Bob')),
                  DataCell(Text('Bob')),
                  DataCell(Text('Charley')),
                  DataCell(Text('bob@gmail.com')),
                  DataCell(Text('Inactive')),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.edit))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.delete))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.password))),
                  DataCell(
                      IconButton(onPressed: null, icon: Icon(Icons.check))),
                  DataCell(IconButton(onPressed: null, icon: Icon(Icons.chat))),
                ]),
              ],
              dataRowHeight: 32.0,
            ),
          ],
        ),
      ),
    ],
  );
}
