import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class Client extends StatefulWidget {
  const Client({super.key});

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > User > Client",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer:  SideBarAdmin(),
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
        "Client List",
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
          "Add New Client",
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
                DataColumn(label: Text('View Client')),
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
