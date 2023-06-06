import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../DashBoard/sidebarAdmin.dart';

class Notification1 extends StatefulWidget {
  const Notification1({super.key});

  @override
  State<Notification1> createState() => _Notification1State();
}

class _Notification1State extends State<Notification1> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    startDateController.addListener(() => setState(() {}));
    endDateController.addListener(() => setState(() {}));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Notification1",
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
                  height: 30,
                ),
                _add(),
                const SizedBox(
                  height: 30,
                ),
                buildStartDate(),
                const SizedBox(
                  height: 20,
                ),
                buildEndDate(),
                const SizedBox(
                  height: 10,
                ),
                _add1(),
                const SizedBox(
                  height: 30,
                ),
                _table(),
                const SizedBox(
                  height: 100,
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
          "SMS And Email",
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

  Row _add() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Send SMS",
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
          width: 10,
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Send Email",
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
          width: 10,
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Daily Notification1",
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

  Widget buildStartDate() => TextField(
        onTap: () async {
          DateTime? datePicked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
          );
          if (datePicked != null) {
            final formattedDate = DateFormat('dd/MM/yyyy').format(datePicked);
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
            final formattedDate = DateFormat('dd/MM/yyyy').format(datePicked);
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
          onPressed: () {},
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Sr.No.'), numeric: true),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Message')),
                  DataColumn(label: Text('Response')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Test')),
                    DataCell(Text('08/08/2022')),
                    DataCell(Text('Test Message')),
                    DataCell(Text('Test Response')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('User Message')),
                    DataCell(Text('abc@gmnail.com')),
                    DataCell(Text('08/08/2022')),
                    DataCell(Text('Test Message')),
                    DataCell(Text('Test Response')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('ABC')),
                    DataCell(Text('Test')),
                    DataCell(Text('23/08/23')),
                    DataCell(Text('Test Message')),
                    DataCell(Text('Response2')),
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
}
