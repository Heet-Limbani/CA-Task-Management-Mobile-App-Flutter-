import 'package:flutter/material.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/AdminDataModel/viewTasksDataModel.dart';
import 'package:task_manager/API/Urls.dart';
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

class _ViewTasksTaskClientState extends State<ViewTasksTaskClient> {
  @override
  void initState() {
    super.initState();
    ticketId = widget.ticketId; // Store widget.userId in a local variable
    getTaskDetails();
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
                _detail(),
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
                  height: deviceHeight * 0.2,
                ),
                _header2(),
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
          "Upload File",
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

  Row _header2() {
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
