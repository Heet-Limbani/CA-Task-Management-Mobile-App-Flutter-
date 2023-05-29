import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class Add_Task extends StatefulWidget {
  const Add_Task({super.key});

  @override
  State<Add_Task> createState() => _Add_TaskState();
}

class _Add_TaskState extends State<Add_Task> {
  final taskController = TextEditingController();
  final clientController = TextEditingController();
  final fileController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final departmentController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskController.addListener(() => setState(() {}));
    clientController.addListener(() => setState(() {}));
    fileController.addListener(() => setState(() {}));
    startDateController.addListener(() => setState(() {}));
    endDateController.addListener(() => setState(() {}));
    departmentController.addListener(() => setState(() {}));
    amountController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  int _value = 1;
  int _value1 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Task > Add Task",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBarAdmin(),
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
                  height: 10,
                ),
                _add(),
                const SizedBox(
                  height: 30,
                ),
                buildTask(),
                const SizedBox(
                  height: 20,
                ),
                buildClient(),
                const SizedBox(
                  height: 20,
                ),
                buildFile(),
                const SizedBox(
                  height: 20,
                ),
                buildStartDate(),
                const SizedBox(
                  height: 20,
                ),
                buildEndDate(),
                const SizedBox(
                  height: 20,
                ),
                buildDepartment(),
                const SizedBox(
                  height: 20,
                ),
                buildComplete(),
                const SizedBox(
                  height: 10,
                ),
                buildAmount(),
                const SizedBox(
                  height: 20,
                ),
                buildInvoice(),
                const SizedBox(
                  height: 10,
                ),
                buildDescription(),
                const SizedBox(
                  height: 60,
                ),
                buildButton(),
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
          "Add Task",
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
            "Add Company",
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

  Widget buildTask() => TextField(
        controller: taskController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Task Name *',
          hintText: 'Enter Task Name',
          suffixIcon: taskController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => taskController.clear(),
                ),
          prefixIcon: Icon(Icons.task),
          border: OutlineInputBorder(),
        ),
      );

  Widget buildClient() => DropdownButtonFormField(
        items: [
          DropdownMenuItem(
            child: Text("MYSYVA"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Client 2"),
            value: 2,
          ),
          DropdownMenuItem(
            child: Text("Client 3"),
            value: 3,
          ),
        ],
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: 'Client *',
          hintText: 'Enter Client Name',
          prefixIcon: Icon(Icons.store),
          border: OutlineInputBorder(),
        ),
      );

  Widget buildFile() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: clientController,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'.*')),
            ],
            decoration: InputDecoration(
              labelText: 'File Name *',
              hintText: 'Enter File Name',
              suffixIcon: clientController.text.isEmpty
                  ? Container(
                      width: 0,
                    )
                  : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => clientController.clear(),
                    ),
              prefixIcon: Icon(Icons.attach_file),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              PlatformFile file = result.files.single;

              // Update the text field with the selected file name
              clientController.text = file.name;

              // Use the selected file as needed
              print(file.name);
            }
          },
          child: Text('Add'),
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
          labelText: 'Starting Date *',
          hintText: 'Enter Starting Date',
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
          labelText: 'DeadLine Date *',
          hintText: 'Enter DeadLine Date',
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

  Widget buildDepartment() => TextField(
        controller: departmentController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Department *',
          hintText: 'Enter Department Name',
          suffixIcon: departmentController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => departmentController.clear(),
                ),
          prefixIcon: Icon(Icons.store),
          border: OutlineInputBorder(),
        ),
      );

  Widget buildComplete() {
    return Row(
      children: [
        Column(children: [
          Row(
            children: [
              Text("   Auto Completed",
                  style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 0,
                    color: Colors.black,
                  )),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value as int;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text("Yes"),
              SizedBox(
                width: 20,
              ),
              Radio(
                value: 2,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value as int;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text("NO"),
            ],
          ),
        ]),
      ],
    );
  }

  Widget buildAmount() => TextField(
        controller: amountController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Amount *',
          hintText: 'Enter Amount',
          suffixIcon: amountController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => amountController.clear(),
                ),
          prefixIcon: Icon(Icons.currency_rupee),
          border: OutlineInputBorder(),
        ),
      );
  Widget buildInvoice() {
    return Row(
      children: [
        Column(children: [
          Row(
            children: [
              Text("Auto Invoice",
                  style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 0,
                    color: Colors.black,
                  )),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: _value1,
                onChanged: (value) {
                  setState(() {
                    _value1 = value as int;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text("Yes"),
              SizedBox(
                width: 20,
              ),
              Radio(
                value: 2,
                groupValue: _value1,
                onChanged: (value) {
                  setState(() {
                    _value1 = value as int;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text("NO"),
            ],
          ),
        ]),
      ],
    );
  }

  Widget buildDescription() => TextField(
        controller: descriptionController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Description ',
          hintText: 'Enter Description',
          suffixIcon: descriptionController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => descriptionController.clear(),
                ),
          prefixIcon: Icon(Icons.description),
          border: OutlineInputBorder(),
        ),
      );
  Widget buildButton() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0,
              color: Colors.white,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0,
              color: Colors.white,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
