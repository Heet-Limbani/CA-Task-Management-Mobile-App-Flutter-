// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../DashBoard/sidebar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

String? stringResponse;
Map? mapResponse;
Map? dataResponse;

class _EmployeeState extends State<Employee> {

  Future apicall() async{
    http.Response response;
   response = await http.post(Uri.parse("https://task.mysyva.net/backend/GetUsers"));

   if(response.statusCode == 200){
     setState(() {
       //stringResponse = response.body;
       mapResponse = json.decode(response.body);
       dataResponse = mapResponse!["data"];
     });
   }
   else{
     print(response.statusCode);
   }
  }
  
  @override
  void initState(){
     apicall();
    super.initState();
   
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Employee",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBar(),
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
              const SizedBox(
                height: 40,
              ),
              _header(),
              const SizedBox(
                height: 20,
              ),
              _search(),
              const SizedBox(
                height: 30,
              ),
              _add(),
              const SizedBox(
                height: 10,
              ),
              _table(),
               const SizedBox(
                height: 50,
              ),
              _test(),
              const SizedBox(
                height: 50,
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
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Employee List",
        style: TextStyle(
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      const Spacer(),
    ],
  );
}

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
          "Add New Employee",
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
          child: dataResponse == null ? Text("data Is Loading"):Text(dataResponse!["first_name"].toString(),
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
