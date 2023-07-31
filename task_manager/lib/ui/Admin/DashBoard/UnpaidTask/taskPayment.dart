import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/model/TaskPaymentDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class TaskPayment extends StatefulWidget {
  final String userId;

  const TaskPayment({required this.userId, Key? key}) : super(key: key);

  @override
  State<TaskPayment> createState() => _TaskPaymentState();
}

class _TaskPaymentState extends State<TaskPayment> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _TaskPaymentKey = GlobalKey<FormState>();
  TextEditingController companyName = TextEditingController();
  TextEditingController invoiceName = TextEditingController();
  TextEditingController paymentName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController reference = TextEditingController();
  TextEditingController description = TextEditingController();

  String userId = "";
  String? selectedClientId1;
  String? selectedinvoiceId1;
  String? selectedpaymentId1;
 
  @override
  void dispose() {
    companyName.dispose();
    invoiceName.dispose();
    paymentName.dispose();
    amount.dispose();
    reference.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = widget.userId; // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    companyName.clear();
    invoiceName.clear();
    paymentName.clear();
    amount.clear();
    reference.clear();
    description.clear();
    selectedinvoiceId1 = null;
    selectedpaymentId1 = null;
    selectedClientId1 = null;
  }

  List<TaskPaymentDataModel> clientType = [];

  void getUser() async {
    print("id :- $userId");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.taskPayment}',
      params: {
         "id": userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      final fileData = TaskPaymentDataModel.fromJson(data);
      print("fileData :- $fileData");
      
      companyName.text = fileData.invoiceData!.name.toString();
      invoiceName.text = " Invoice Number ${fileData.invoiceData!.id.toString()}  ${fileData.invoiceData!.otherDetails.toString()}";
      amount.text = fileData.invoiceData!.total.toString();
      selectedClientId1 = fileData.invoiceData!.clientId.toString();
      selectedinvoiceId1 = fileData.invoiceData!.id.toString();
      selectedpaymentId1 = fileData.invoiceData!.paymentId.toString();
      clientType.add(fileData); // Add the companyData to clientType list
      setState(() {});
    }
  }

  void fileEdit() async {
    try {
    
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.taskPayment}',
        params: {
          "save": "save",
          "id": userId.toString(),
          "client": selectedClientId1.toString(),
          "file": selectedinvoiceId1.toString(),
          "payment": selectedpaymentId1.toString(),
          "amt": amount.text.toString(),
          "refer": reference.text.toString(),
          "desc": description.text.toString(),
         
        },
      );
      if (genmodel != null) {
        Fluttertoast.showToast(
          msg: genmodel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (genmodel.status == true) {
          setState(() {});
        }
      }
    } catch (e) {
      // Handle the exception
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Desboard > Unpaid Task > Task Payment",
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
                  height: deviceHeight * 0.05,
                ),
                _TaskPayment(),
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
          "Task Payment",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _TaskPayment() {
    return Form(
      key: _TaskPaymentKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: companyName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Company Name',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Company Name';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: invoiceName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Invoice Number',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Invoice Name';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          
          DropdownButtonFormField<String>(
            value: selectedpaymentId1,
            decoration: const InputDecoration(
              labelText: 'Payment',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedpaymentId1 = newValue;
                companyName.text = selectedpaymentId1 ?? '';
              });
            },
            items: clientType.expand<DropdownMenuItem<String>>(
                (TaskPaymentDataModel dataModel) {
              return dataModel.payment
                      ?.map<DropdownMenuItem<String>>((Payment payment) {
                    return DropdownMenuItem<String>(
                      value: payment.id ?? '',
                      child: Text('${payment.name}'),
                    );
                  }).toList() ??
                  [];
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a client';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
           TextFormField(
            controller: amount,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Amount',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
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
            controller: reference,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Reference',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Reference';
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
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Description';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              minimumSize: Size.fromHeight(60),
              backgroundColor: Colors.blue, // Set the background color

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_TaskPaymentKey.currentState!.validate()) {
                fileEdit();
              }
            },
            child: Text(
              "Update",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.2,
          ),
        ],
      ),
    );
  }
}
