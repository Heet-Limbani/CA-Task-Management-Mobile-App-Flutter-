import 'package:flutter/material.dart';
import 'package:task_manager/API/model/cardDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/viewTasksDataModel.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class ViewPendingTask extends StatefulWidget {
  final String ticketId;
  const ViewPendingTask({required this.ticketId, Key? key}) : super(key: key);

  @override
  State<ViewPendingTask> createState() => _ViewPendingTaskState();
}

late double deviceWidth;
late double deviceHeight;

TextEditingController descriptionController = TextEditingController();
TextEditingController clientNameController = TextEditingController();
TextEditingController clientNumberController = TextEditingController();
TextEditingController clientEmailController = TextEditingController();
TextEditingController startingDateController = TextEditingController();
TextEditingController deadlineDateController = TextEditingController();
TextEditingController createdDateController = TextEditingController();

String ticketId = "";

String? selectedClientId1;

class _ViewPendingTaskState extends State<ViewPendingTask> {
  bool isObscurePassword = true;

  @override
  void initState() {
    super.initState();
    ticketId = widget.ticketId; // Store widget.userId in a local variable
    // getUser();
    getTaskDetails();
  }
 List<Pending> cardDataList = [];
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
  // List<Pending> cardDataList = [];
  // void getTaskDetails() async {
  //   genModel? genmodel = await Urls.postApiCall(
  //     method: '${Urls.taskViewTaskDetails}',
  //     params: {
  //       'id': ticketId.toString(),
  //     },
  //   );
  //   if (genmodel != null && genmodel.status == true) {
  //     final data = genmodel.data;

  //     if (data != null && data is Map<String, dynamic>) {
  //       Pending cardData =
  //           Pending.fromJson(data['data']);
  //       cardDataList.add(cardData);
  //       descriptionController.text = cardDataList[0].description.toString();
  //       //clientNameController.text = cardDataList[0].clientName.toString();
  //       // clientNumberController.text = cardDataList[0].clientNumber.toString();
  //       // clientEmailController.text = cardDataList[0].clientEmail.toString();
  //       startingDateController.text = cardDataList[0].startingDate.toString();
  //       deadlineDateController.text = cardDataList[0].deadlineDate.toString();
  //       createdDateController.text = cardDataList[0].createdOn.toString();
  //       setState(() {});
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Pending Tasks > View Pending Task",
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
                  height: deviceHeight * 0.05,
                ),
                _detail(),
                _add(),
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
                _add2(),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.1,
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

  Column _detail() {
    return Column(
      children: [
        buildTextField("Description", descriptionController.text, false),
      ],
    );
  }

  Row _add() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            // Get.to(() => AddClientForm());
          },
          child: Text(
            "Edit",
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

  
  Row _add2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            // Get.to(() => AddClientForm());
          },
          child: Text(
            "Add Subtask",
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
          "Task List",
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

  Row _table() {
    return Row(
      children: [
       
        SizedBox(
          width: deviceWidth * 0.1,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         ClientLoginDetails(userId: ticketId),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       return FadeTransition(opacity: animation, child: child);
            //     },
            //   ),
            // );
          },
          child: Text(
            'File Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // Add more buttons for additional tables
        SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         ClientTicketDetails(userId: ticketId),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       return FadeTransition(opacity: animation, child: child);
            //     },
            //   ),
            // );
          },
          child: Text(
            'Chat',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         ClientInvoiceDetails(userId: ticketId),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       return FadeTransition(opacity: animation, child: child);
            //     },
            //   ),
            // );
          },
          child: Text(
            'Charges',
            style: TextStyle(color: Colors.black),
          ),
        ),
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
            )),
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
