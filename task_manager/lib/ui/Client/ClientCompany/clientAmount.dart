import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/Users/addClientForm.dart';
import 'package:task_manager/API/Urls.dart';

class ClientAmount extends StatefulWidget {
  const ClientAmount({Key? key}) : super(key: key);

  @override
  State<ClientAmount> createState() => _ClientAmountState();
}

TextEditingController fileController = TextEditingController();
File? selectedFile;

 TextEditingController title1 = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

class _ClientAmountState extends State<ClientAmount> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;
  int total = 0;

  final GlobalKey<FormState> _ClientAmountKey = GlobalKey<FormState>();
 

  @override
  void dispose() {
    title1.dispose();
    amount.dispose();
    description.dispose();
    super.dispose();
  }

  void clearField() {
    title1.clear();
    amount.clear();
    description.clear();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientAmount}',
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      if (data != null && data is Map<String, dynamic>) {
        print("data: $data");

        int invoiceTotal =
            int.parse(data['invoice_data_amount']?['total'] ?? 0);
        int paymentAmount =
            int.parse(data['payment_data_amount']?['amount'] ?? 0);
        total = invoiceTotal - paymentAmount;

        print("total: $total");
        setState(() {});
      }
    }
  }

  void clientAdd(title2, amount2, description2) async {
    try {
      Map<String, String> headers = await Urls.getXTokenHeader();
      String csrfToken = headers['Xtoken'] ?? ''; // Get the Xtoken value
      var response = await http.post(
        Uri.parse(Urls.clientAmount), // Replace with your API endpoint URL
        headers: {
          "Xtoken": csrfToken,
        },
        body: {
          "submit": "submit",
          "title": title2,
          "amount": amount2,
          "description": description2,
          "userImage": fileController.text,
        },
      );
      if (response.statusCode == 200) {
        // Successful response
        var genmodel = genModel.fromJson(json.decode(response.body));
        print('Response body: ${response.body}');
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

      // Rest of your code...
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Company > Pending Amount",
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
                  height: deviceHeight * 0.04,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                // _add(),
                // SizedBox(
                //   height: deviceHeight * 0.05,
                // ),
                _ClientAmount(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _add(),
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
          "Pending Amount - ${total}",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 20,
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
            Get.to(AddClientForm());
          },
          child: Text(
            "Pay Online",
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0,
              color: Colors.blue,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  Form _ClientAmount() {
    return Form(
      key: _ClientAmountKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: title1,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Title',
              suffixIcon: Icon(Icons.keyboard),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Title';
              }
              if (value.length < 3) {
                return 'Title must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: amount,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Amount',
              suffixIcon: Icon(Icons.currency_rupee),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Amount';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: description,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Description',
              suffixIcon: Icon(Icons.description),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.0),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.0),
                borderSide: BorderSide(
                  color: AppTheme.colors.lightBlue,
                ),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Description';
              }
              if (value.length < 3) {
                return 'Description must be at least 3 characters long';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.04,
          ),
          _detail(),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              //minimumSize: Size.fromHeight(60),
              backgroundColor: Colors.blue, // Set the background color
              // Set the text color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_ClientAmountKey.currentState!.validate()) {
                clientAdd(title1.text, amount.text, description.text);
                clearField();
              }
            },
            child: Text(
              "Submit",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
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
            onPressed: () {},
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
}

// Table heading

